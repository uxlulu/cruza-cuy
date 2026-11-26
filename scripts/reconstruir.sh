#!/bin/sh
# Reconstruye los binarios del export Web (png, pck, wasm) desde assets_b64/.
set -eu
cd "$(dirname "$0")/.."
if [ -f index.pck ] && [ -f index.wasm ]; then
  echo "Los binarios ya están en la raíz."
else
  if [ ! -d assets_b64 ]; then
    echo "Faltan index.pck/index.wasm y no hay assets_b64/." >&2
    exit 1
  fi
  cat assets_b64/part_*.txt | base64 -d | tar -xf -
  if [ -f index.wasm.gz ] && [ ! -f index.wasm ]; then
    gzip -dk index.wasm.gz
  fi
fi
if [ -f SHA256SUMS ]; then
  sha256sum -c SHA256SUMS
fi
ls -lh index.html index.js index.pck index.wasm index.png
