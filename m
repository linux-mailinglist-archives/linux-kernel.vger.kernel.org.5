Return-Path: <linux-kernel+bounces-102771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D09187B71E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E64C2284A40
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEC59441;
	Thu, 14 Mar 2024 04:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OPaW5LRL"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24CDD267
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 04:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710390522; cv=none; b=PVL0LrCrKLD3c8G0gNDZLcOq661u1KNmmPvyyK6NGmGA75imuiQt5Q25IvY6mHjBWe7twU2vMBoP224bCvjJl8Tr6/CGqpgr5yc7B+yeyVcb+Z550jiwcMyE5sAY47NHMAS8I7l/QDkYZobuFMiqDvLtDJHjmxUvgFVwMz5YMd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710390522; c=relaxed/simple;
	bh=YmgqATLE7Zmydsm0FL/D3txzzG7EV4H026eCaH03988=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=okjqbxllHGx+D33tXp0/2B1YjDcSJ5R6LDy/2eiOpLPXPvFnzakMnJ54YZo3dYNAHitsk7PB7sIom2Wh9d4EfkNb7xTTu9r+rALMrizfvTInhzydwREIvlkb0/JZ9aSAYWDyBNlXFjW5oQHUPLGiT69UMlwC2M+4cCJ5rJLhHF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OPaW5LRL; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso429683a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710390518; x=1710995318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7KaaNtYVeHwjTO9YKm/+KfBYG68joLx8iXf/cQ7VH0=;
        b=OPaW5LRLi27SUGBrMfrsTdq+KMCURDKH8MJyqLCVkz9OIcYua+P6f7ArKkAP6oemwb
         p9NUeCLZqIC1KhVmQ/hEKuqAcBMpbrl2HIJ4GcfHqfxjkSm7zjTSWh+4IVGljv28tG9B
         prZB94ciOykXNuwodseJwCp2zugPadASGNO0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710390518; x=1710995318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7KaaNtYVeHwjTO9YKm/+KfBYG68joLx8iXf/cQ7VH0=;
        b=XHVe+ot7UyMAhzEZy9rSH8aOjPB61HFpKZo75X1XUmXrBEmuTZIE9kN7n+vrnTgNil
         fSHBkoetOxIojda5gyOvZRz0jIOYjxGqtjmtV2r1/u3X85+imbYH6ardjbwy/7P8DSAT
         X2QjkmSWkhZlcSq6uJLpB0P/WuVpAnTCuNi306dSylWbZuVJytWfdlv8f1irAcUCOUiJ
         I2jbzOQnqPSGmx249eSZftGKGFaXvY+6H9P5Z7zBeiFyrrXqcaDA0eCNnvG/CfCC/qv5
         Gx3HB0CSLWXcPX1hIt6+i7zzmS+2arFG+9/MpjSwNifvYYxhfOR2VszZ+/ba9RoTJyFl
         1ZmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWidPwiNDnngiBIXo77rU3gE8tfMwN5acNylth7Kv+kUZm3Xf0AxnBK0XQoWhHqHKoWw1keTNTbbQrrqh70q2A+Eqe0phP2rr3k/B2K
X-Gm-Message-State: AOJu0YxGQQUtlXIhTsOjcgunwQ2PttHlsF3+il/oVZToNvg+Y89hWjNy
	nAYEHS4zP8DUI32QwBNIHfouMtKxkDoOHVVFJKgOOKn+tZ7EIjbheYzgMSx3SA==
X-Google-Smtp-Source: AGHT+IEIVeX9M6qIiSDiouc482T1Cb1JSC1mL3ZhBJgs/2khtqmWK5RDJ0uSv5BHWt/NhF/JD3tlYA==
X-Received: by 2002:a05:6a20:94c9:b0:1a1:8474:31e4 with SMTP id ht9-20020a056a2094c900b001a1847431e4mr890420pzb.16.1710390518082;
        Wed, 13 Mar 2024 21:28:38 -0700 (PDT)
Received: from chromium.org ([118.149.78.37])
        by smtp.gmail.com with ESMTPSA id u5-20020a170903124500b001dd98195371sm479200plh.181.2024.03.13.21.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 21:28:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Simon Glass <sjg@chromium.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Terrell <terrelln@fb.com>,
	Will Deacon <will@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	workflows@vger.kernel.org
Subject: [PATCH v11 2/2] arm64: boot: Support Flat Image Tree
Date: Thu, 14 Mar 2024 17:26:59 +1300
Message-Id: <20240314042659.232142-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240314042659.232142-1-sjg@chromium.org>
References: <20240314042659.232142-1-sjg@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a script which produces a Flat Image Tree (FIT), a single file
containing the built kernel and associated devicetree files.
Compression defaults to gzip which gives a good balance of size and
performance.

The files compress from about 86MB to 24MB using this approach.

The FIT can be used by bootloaders which support it, such as U-Boot
and Linuxboot. It permits automatic selection of the correct
devicetree, matching the compatible string of the running board with
the closest compatible string in the FIT. There is no need for
filenames or other workarounds.

Add a 'make image.fit' build target for arm64, as well.

The FIT can be examined using 'dumpimage -l'.

This uses the 'dtbs-list' file but processes only .dtb files, ignoring
the overlay .dtbo files.

This features requires pylibfdt (use 'pip install libfdt'). It also
requires compression utilities for the algorithm being used. Supported
compression options are the same as the Image.xxx files. Use
FIT_COMPRESSION to select an algorithm other than gzip.

While FIT supports a ramdisk / initrd, no attempt is made to support
this here, since it must be built separately from the Linux build.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v11:
- Use dtbslist file in image.fit rule
- Update cmd_fit rule as per Masahiro
- Don't mention ignoring files without a .dtb prefix
- Use argparse fromfile_prefix_chars feature
- Add a -v option and use it for output (with make V=1)
- rename srcdir to dtbs
- Use -o for the output file instead of -f

Changes in v10:
- Make use of dtbs-list file
- Mention dtbs-list and FIT_COMPRESSION
- Update copyright year
- Update cover letter to take account of an applied patch

Changes in v9:
- Move the compression control into Makefile.lib

Changes in v8:
- Drop compatible string in FDT node
- Correct sorting of MAINTAINERS to before ARM64 PORT
- Turn compress part of the make_fit.py comment in to a sentence
- Add two blank lines before parse_args() and setup_fit()
- Use 'image.fit: dtbs' instead of BUILD_DTBS var
- Use '$(<D)/dts' instead of '$(dir $<)dts'
- Add 'mkimage' details Documentation/process/changes.rst
- Allow changing the compression used
- Tweak cover letter since there is only one clean-up patch

Changes in v7:
- Add Image as a dependency of image.fit
- Drop kbuild tag
- Add dependency on dtbs
- Drop unnecessary path separator for dtbs
- Rebase to -next

Changes in v5:
- Drop patch previously applied
- Correct compression rule which was broken in v4

Changes in v4:
- Use single quotes for UIMAGE_NAME

Changes in v3:
- Drop temporary file image.itk
- Drop patch 'Use double quotes for image name'
- Drop double quotes in use of UIMAGE_NAME
- Drop unnecessary CONFIG_EFI_ZBOOT condition for help
- Avoid hard-coding "arm64" for the DT architecture

Changes in v2:
- Drop patch previously applied
- Add .gitignore file
- Move fit rule to Makefile.lib using an intermediate file
- Drop dependency on CONFIG_EFI_ZBOOT
- Pick up .dtb files separately from the kernel
- Correct pylint too-many-args warning for write_kernel()
- Include the kernel image in the file count
- Add a pointer to the FIT spec and mention of its wide industry usage
- Mention the kernel version in the FIT description

 Documentation/process/changes.rst |   9 +
 MAINTAINERS                       |   7 +
 arch/arm64/Makefile               |   7 +-
 arch/arm64/boot/.gitignore        |   1 +
 arch/arm64/boot/Makefile          |   6 +-
 scripts/Makefile.lib              |  15 ++
 scripts/make_fit.py               | 290 ++++++++++++++++++++++++++++++
 7 files changed, 332 insertions(+), 3 deletions(-)
 create mode 100755 scripts/make_fit.py

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 7ef8de58f7f8..3a39395bd9d3 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -62,6 +62,7 @@ Sphinx\ [#f1]_         2.4.4            sphinx-build --version
 cpio                   any              cpio --version
 GNU tar                1.28             tar --version
 gtags (optional)       6.6.5            gtags --version
+mkimage (optional)     2017.01          mkimage --version
 ====================== ===============  ========================================
 
 .. [#f1] Sphinx is needed only to build the Kernel documentation
@@ -189,6 +190,14 @@ The kernel build requires GNU GLOBAL version 6.6.5 or later to generate
 tag files through ``make gtags``.  This is due to its use of the gtags
 ``-C (--directory)`` flag.
 
+mkimage
+-------
+
+This tool is used when building a Flat Image Tree (FIT), commonly used on ARM
+platforms. The tool is available via the ``u-boot-tools`` package or can be
+built from the U-Boot source code. See the instructions at
+https://docs.u-boot.org/en/latest/build/tools.html#building-tools-for-linux
+
 System utilities
 ****************
 
diff --git a/MAINTAINERS b/MAINTAINERS
index b43102ca365d..4bba1419ca35 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3050,6 +3050,13 @@ F:	drivers/mmc/host/sdhci-of-arasan.c
 N:	zynq
 N:	xilinx
 
+ARM64 FIT SUPPORT
+M:	Simon Glass <sjg@chromium.org>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm64/boot/Makefile
+F:	scripts/make_fit.py
+
 ARM64 PORT (AARCH64 ARCHITECTURE)
 M:	Catalin Marinas <catalin.marinas@arm.com>
 M:	Will Deacon <will@kernel.org>
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 1217d97998ac..b8b1d4f4a572 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -154,7 +154,7 @@ libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 # Default target when executing plain make
 boot		:= arch/arm64/boot
 
-BOOT_TARGETS	:= Image vmlinuz.efi
+BOOT_TARGETS	:= Image vmlinuz.efi image.fit
 
 PHONY += $(BOOT_TARGETS)
 
@@ -166,7 +166,9 @@ endif
 
 all:	$(notdir $(KBUILD_IMAGE))
 
-vmlinuz.efi: Image
+image.fit: dtbs
+
+vmlinuz.efi image.fit: Image
 $(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
@@ -219,6 +221,7 @@ virtconfig:
 define archhelp
   echo  '* Image.gz      - Compressed kernel image (arch/$(ARCH)/boot/Image.gz)'
   echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boot/Image)'
+  echo  '  image.fit     - Flat Image Tree (arch/$(ARCH)/boot/image.fit)'
   echo  '  install       - Install uncompressed kernel'
   echo  '  zinstall      - Install compressed kernel'
   echo  '                  Install using (your) ~/bin/installkernel or'
diff --git a/arch/arm64/boot/.gitignore b/arch/arm64/boot/.gitignore
index af5dc61f8b43..abaae9de1bdd 100644
--- a/arch/arm64/boot/.gitignore
+++ b/arch/arm64/boot/.gitignore
@@ -2,3 +2,4 @@
 Image
 Image.gz
 vmlinuz*
+image.fit
diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
index a5a787371117..607a67a649c4 100644
--- a/arch/arm64/boot/Makefile
+++ b/arch/arm64/boot/Makefile
@@ -16,7 +16,8 @@
 
 OBJCOPYFLAGS_Image :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
 
-targets := Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo Image.zst
+targets := Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo \
+	Image.zst image.fit
 
 $(obj)/Image: vmlinux FORCE
 	$(call if_changed,objcopy)
@@ -39,6 +40,9 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
 $(obj)/Image.zst: $(obj)/Image FORCE
 	$(call if_changed,zstd)
 
+$(obj)/image.fit: $(obj)/Image $(obj)/dts/dtbs-list FORCE
+	$(call if_changed,fit)
+
 EFI_ZBOOT_PAYLOAD	:= Image
 EFI_ZBOOT_BFD_TARGET	:= elf64-littleaarch64
 EFI_ZBOOT_MACH_TYPE	:= ARM64
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 3179747cbd2c..0138d0b82be5 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -504,6 +504,21 @@ quiet_cmd_uimage = UIMAGE  $@
 			-a $(UIMAGE_LOADADDR) -e $(UIMAGE_ENTRYADDR) \
 			-n '$(UIMAGE_NAME)' -d $< $@
 
+# Flat Image Tree (FIT)
+# This allows for packaging of a kernel and all devicetrees files, using
+# compression.
+# ---------------------------------------------------------------------------
+
+MAKE_FIT := $(srctree)/scripts/make_fit.py
+
+# Use this to override the compression algorithm
+FIT_COMPRESSION ?= gzip
+
+quiet_cmd_fit = FIT     $@
+      cmd_fit = $(MAKE_FIT) -o $@ --arch $(UIMAGE_ARCH) --os linux \
+		--name '$(UIMAGE_NAME)' $(if $(V),-v) \
+		--compress $(FIT_COMPRESSION) -k $< @$(word 2,$^)
+
 # XZ
 # ---------------------------------------------------------------------------
 # Use xzkern to compress the kernel image and xzmisc to compress other things.
diff --git a/scripts/make_fit.py b/scripts/make_fit.py
new file mode 100755
index 000000000000..3de90c5a094b
--- /dev/null
+++ b/scripts/make_fit.py
@@ -0,0 +1,290 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2024 Google LLC
+# Written by Simon Glass <sjg@chromium.org>
+#
+
+"""Build a FIT containing a lot of devicetree files
+
+Usage:
+    make_fit.py -A arm64 -n 'Linux-6.6' -O linux
+        -o arch/arm64/boot/image.fit -k /tmp/kern/arch/arm64/boot/image.itk
+        @arch/arm64/boot/dts/dtbs-list -E -c gzip
+
+Creates a FIT containing the supplied kernel and a set of devicetree files,
+either specified individually or listed in a file (with an '@' prefix).
+
+Use -E to generate an external FIT (where the data is placed after the
+FIT data structure). This allows parsing of the data without loading
+the entire FIT.
+
+Use -c to compress the data, using bzip2, gzip, lz4, lzma, lzo and
+zstd algorithms.
+
+The resulting FIT can be booted by bootloaders which support FIT, such
+as U-Boot, Linuxboot, Tianocore, etc.
+
+Note that this tool does not yet support adding a ramdisk / initrd.
+"""
+
+import argparse
+import collections
+import os
+import subprocess
+import sys
+import tempfile
+import time
+
+import libfdt
+
+
+# Tool extension and the name of the command-line tools
+CompTool = collections.namedtuple('CompTool', 'ext,tools')
+
+COMP_TOOLS = {
+    'bzip2': CompTool('.bz2', 'bzip2'),
+    'gzip': CompTool('.gz', 'pigz,gzip'),
+    'lz4': CompTool('.lz4', 'lz4'),
+    'lzma': CompTool('.lzma', 'lzma'),
+    'lzo': CompTool('.lzo', 'lzop'),
+    'zstd': CompTool('.zstd', 'zstd'),
+}
+
+
+def parse_args():
+    """Parse the program ArgumentParser
+
+    Returns:
+        Namespace object containing the arguments
+    """
+    epilog = 'Build a FIT from a directory tree containing .dtb files'
+    parser = argparse.ArgumentParser(epilog=epilog, fromfile_prefix_chars='@')
+    parser.add_argument('-A', '--arch', type=str, required=True,
+          help='Specifies the architecture')
+    parser.add_argument('-c', '--compress', type=str, default='none',
+          help='Specifies the compression')
+    parser.add_argument('-E', '--external', action='store_true',
+          help='Convert the FIT to use external data')
+    parser.add_argument('-n', '--name', type=str, required=True,
+          help='Specifies the name')
+    parser.add_argument('-o', '--output', type=str, required=True,
+          help='Specifies the output file (.fit)')
+    parser.add_argument('-O', '--os', type=str, required=True,
+          help='Specifies the operating system')
+    parser.add_argument('-k', '--kernel', type=str, required=True,
+          help='Specifies the (uncompressed) kernel input file (.itk)')
+    parser.add_argument('-v', '--verbose', action='store_true',
+                        help='Enable verbose output')
+    parser.add_argument('dtbs', type=str, nargs='*',
+          help='Specifies the devicetree files to process')
+
+    return parser.parse_args()
+
+
+def setup_fit(fsw, name):
+    """Make a start on writing the FIT
+
+    Outputs the root properties and the 'images' node
+
+    Args:
+        fsw (libfdt.FdtSw): Object to use for writing
+        name (str): Name of kernel image
+    """
+    fsw.INC_SIZE = 65536
+    fsw.finish_reservemap()
+    fsw.begin_node('')
+    fsw.property_string('description', f'{name} with devicetree set')
+    fsw.property_u32('#address-cells', 1)
+
+    fsw.property_u32('timestamp', int(time.time()))
+    fsw.begin_node('images')
+
+
+def write_kernel(fsw, data, args):
+    """Write out the kernel image
+
+    Writes a kernel node along with the required properties
+
+    Args:
+        fsw (libfdt.FdtSw): Object to use for writing
+        data (bytes): Data to write (possibly compressed)
+        args (Namespace): Contains necessary strings:
+            arch: FIT architecture, e.g. 'arm64'
+            fit_os: Operating Systems, e.g. 'linux'
+            name: Name of OS, e.g. 'Linux-6.6.0-rc7'
+            compress: Compression algorithm to use, e.g. 'gzip'
+    """
+    with fsw.add_node('kernel'):
+        fsw.property_string('description', args.name)
+        fsw.property_string('type', 'kernel_noload')
+        fsw.property_string('arch', args.arch)
+        fsw.property_string('os', args.os)
+        fsw.property_string('compression', args.compress)
+        fsw.property('data', data)
+        fsw.property_u32('load', 0)
+        fsw.property_u32('entry', 0)
+
+
+def finish_fit(fsw, entries):
+    """Finish the FIT ready for use
+
+    Writes the /configurations node and subnodes
+
+    Args:
+        fsw (libfdt.FdtSw): Object to use for writing
+        entries (list of tuple): List of configurations:
+            str: Description of model
+            str: Compatible stringlist
+    """
+    fsw.end_node()
+    seq = 0
+    with fsw.add_node('configurations'):
+        for model, compat in entries:
+            seq += 1
+            with fsw.add_node(f'conf-{seq}'):
+                fsw.property('compatible', bytes(compat))
+                fsw.property_string('description', model)
+                fsw.property_string('fdt', f'fdt-{seq}')
+                fsw.property_string('kernel', 'kernel')
+    fsw.end_node()
+
+
+def compress_data(inf, compress):
+    """Compress data using a selected algorithm
+
+    Args:
+        inf (IOBase): Filename containing the data to compress
+        compress (str): Compression algorithm, e.g. 'gzip'
+
+    Return:
+        bytes: Compressed data
+    """
+    if compress == 'none':
+        return inf.read()
+
+    comp = COMP_TOOLS.get(compress)
+    if not comp:
+        raise ValueError(f"Unknown compression algorithm '{compress}'")
+
+    with tempfile.NamedTemporaryFile() as comp_fname:
+        with open(comp_fname.name, 'wb') as outf:
+            done = False
+            for tool in comp.tools.split(','):
+                try:
+                    subprocess.call([tool, '-c'], stdin=inf, stdout=outf)
+                    done = True
+                    break
+                except FileNotFoundError:
+                    pass
+            if not done:
+                raise ValueError(f'Missing tool(s): {comp.tools}\n')
+            with open(comp_fname.name, 'rb') as compf:
+                comp_data = compf.read()
+    return comp_data
+
+
+def output_dtb(fsw, seq, fname, arch, compress):
+    """Write out a single devicetree to the FIT
+
+    Args:
+        fsw (libfdt.FdtSw): Object to use for writing
+        seq (int): Sequence number (1 for first)
+        fmame (str): Filename containing the DTB
+        arch: FIT architecture, e.g. 'arm64'
+        compress (str): Compressed algorithm, e.g. 'gzip'
+
+    Returns:
+        tuple:
+            str: Model name
+            bytes: Compatible stringlist
+    """
+    with fsw.add_node(f'fdt-{seq}'):
+        # Get the compatible / model information
+        with open(fname, 'rb') as inf:
+            data = inf.read()
+        fdt = libfdt.FdtRo(data)
+        model = fdt.getprop(0, 'model').as_str()
+        compat = fdt.getprop(0, 'compatible')
+
+        fsw.property_string('description', model)
+        fsw.property_string('type', 'flat_dt')
+        fsw.property_string('arch', arch)
+        fsw.property_string('compression', compress)
+        fsw.property('compatible', bytes(compat))
+
+        with open(fname, 'rb') as inf:
+            compressed = compress_data(inf, compress)
+        fsw.property('data', compressed)
+    return model, compat
+
+
+def build_fit(args):
+    """Build the FIT from the provided files and arguments
+
+    Args:
+        args (Namespace): Program arguments
+
+    Returns:
+        tuple:
+            bytes: FIT data
+            int: Number of configurations generated
+            size: Total uncompressed size of data
+    """
+    seq = 0
+    size = 0
+    fsw = libfdt.FdtSw()
+    setup_fit(fsw, args.name)
+    entries = []
+
+    # Handle the kernel
+    with open(args.kernel, 'rb') as inf:
+        comp_data = compress_data(inf, args.compress)
+    size += os.path.getsize(args.kernel)
+    write_kernel(fsw, comp_data, args)
+
+    for fname in args.dtbs:
+        # Ignore overlay (.dtbo) files
+        if os.path.splitext(fname)[1] == '.dtb':
+            seq += 1
+            size += os.path.getsize(fname)
+            model, compat = output_dtb(fsw, seq, fname, args.arch, args.compress)
+            entries.append([model, compat])
+
+    finish_fit(fsw, entries)
+
+    # Include the kernel itself in the returned file count
+    return fsw.as_fdt().as_bytearray(), seq + 1, size
+
+
+def run_make_fit():
+    """Run the tool's main logic"""
+    args = parse_args()
+
+    out_data, count, size = build_fit(args)
+    with open(args.output, 'wb') as outf:
+        outf.write(out_data)
+
+    ext_fit_size = None
+    if args.external:
+        mkimage = os.environ.get('MKIMAGE', 'mkimage')
+        subprocess.check_call([mkimage, '-E', '-F', args.output],
+                              stdout=subprocess.DEVNULL)
+
+        with open(args.output, 'rb') as inf:
+            data = inf.read()
+        ext_fit = libfdt.FdtRo(data)
+        ext_fit_size = ext_fit.totalsize()
+
+    if args.verbose:
+        comp_size = len(out_data)
+        print(f'FIT size {comp_size:#x}/{comp_size / 1024 / 1024:.1f} MB',
+              end='')
+        if ext_fit_size:
+            print(f', header {ext_fit_size:#x}/{ext_fit_size / 1024:.1f} KB',
+                  end='')
+        print(f', {count} files, uncompressed {size / 1024 / 1024:.1f} MB')
+
+
+if __name__ == "__main__":
+    sys.exit(run_make_fit())
-- 
2.34.1


