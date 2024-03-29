Return-Path: <linux-kernel+bounces-124087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53821891204
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 779EB1C246A1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4A139AC7;
	Fri, 29 Mar 2024 03:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C7KrOyDy"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488893AC08
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 03:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711682973; cv=none; b=i21qqcCNpapnh15HMWRRcOjmID6y9nAd8bUvq7JZQxxXNRZwVWsVrI6X2i6shuCqQqnwHvv0li3yhecPgNSi5bVt/X1HYikP5lyGxNZdQOQcq72I9CwJSMSrcyUOGHQNX3tKtxo7wodkruW8Eaq0UtMlNvPBOuZifnc7DPKKpQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711682973; c=relaxed/simple;
	bh=38SqsARSldGwn4vMuhU0nndL4xSsxRc4WyifRZivzeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rEdCyiQqqsF7uP8fmmyg8PBED01OsVGnCe/0DUlXQAqcPsu7xLXH1dhOwCUzxrqEc5doMvEbUIYJFgT9Oi2jPKUuUyuSAynIsYOnIvI7+9mC6yZ+o+bLRmfgJVBqBLOcg6QxwGXkbOuMC/NF5HNhMT8MFtKqgTN7NiY4jDMNo5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C7KrOyDy; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7d0486cf91aso71632239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711682969; x=1712287769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFRT2ilMn7VkiRLLhnJawFJ1/PDTpXke+vVcnGlj418=;
        b=C7KrOyDyADqpJdheQbtnAEWuJqsTWYdtB7aBfMVVrRosYYCaWG+zvSBUUvkkOvlkAl
         y3VRxYhd5VXajLgDEinJp/rbgy1of9zSyj6WaIP0zAe3y6qawUPibE5tvadZRZFpPfHw
         A0QOCbLSFI2eBn3uJHhpuaTf5JeKitfYbXZYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711682969; x=1712287769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFRT2ilMn7VkiRLLhnJawFJ1/PDTpXke+vVcnGlj418=;
        b=f02bB2rvYDxmyEjxLheUChOQgAycDBea6WHjYbqgiK8fCPIFhvNaOy3DniAnK0/nce
         SbHOHVa/BPn++7a3dj2lwuAU2RnW6cwd/okZsvw17/GtsF1tpqjiVEeXEIjMqqnFwLD1
         C51uNUs3pPewf/DFmsneJYIO7do3uqzkhe4BqEMePkGA5IgrnbDb1gXqRI4JlBbzIbY5
         u6G64XoNW0d3V1JkdHJG1HFbfWgqinmqJOkNv5n2GNcsFMZoYIMEcRcPGvON8fdTXWIz
         mRe/VI+6hK4RNZjFx1AIdGD2jvF6qSNoHmHjnvyojbczt98BCbQ6MQh6Ctg60/tM50Qo
         tvTw==
X-Forwarded-Encrypted: i=1; AJvYcCXMdXUzqoykps5uC/1vnFSM4oO3MgRhLPJ+DUdd7nvF0vlfLs6xOru+qh+UIBX5H7QDS0M0ucfyIUAyibnv5etYmWk7LA7sgiN6RyHc
X-Gm-Message-State: AOJu0YyXRnkkspHjS9HTYoKlEMnzIh+VyHhEZYo3f9vam3MrHzxLoslQ
	GOdOedkioBimsvmu7BEmOufe7ZkdaXMmfbz/Bk8Pc0EBNS/GSR+gpU1+HGkwnw==
X-Google-Smtp-Source: AGHT+IEeo94C7AQMFJplhBzkjNRt33yqHOxtZ1MeCGIBj2s4gaFkOZ3aa2eOOvvl+k2AMM/C5KzbJQ==
X-Received: by 2002:a05:6e02:1d9a:b0:366:a611:f7c0 with SMTP id h26-20020a056e021d9a00b00366a611f7c0mr1099425ila.0.1711682969509;
        Thu, 28 Mar 2024 20:29:29 -0700 (PDT)
Received: from chromium.org ([75.104.105.200])
        by smtp.gmail.com with ESMTPSA id l7-20020a056e021aa700b003685b574968sm815717ilv.51.2024.03.28.20.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 20:29:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Nicolas Schier <nicolas@fjasle.eu>,
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
Subject: [PATCH v12 2/2] arm64: boot: Support Flat Image Tree
Date: Fri, 29 Mar 2024 16:28:36 +1300
Message-Id: <20240329032836.141899-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329032836.141899-1-sjg@chromium.org>
References: <20240329032836.141899-1-sjg@chromium.org>
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

Changes in v12:
- Avoid showing FIT message if V=0

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
 scripts/Makefile.lib              |  16 ++
 scripts/make_fit.py               | 290 ++++++++++++++++++++++++++++++
 7 files changed, 333 insertions(+), 3 deletions(-)
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
index d36c19c1bf81..d28089145ca8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3079,6 +3079,13 @@ F:	drivers/mmc/host/sdhci-of-arasan.c
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
index 743edb09f9c7..1ca2d9982031 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -504,6 +504,22 @@ quiet_cmd_uimage = UIMAGE  $@
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
+		--name '$(UIMAGE_NAME)' \
+		$(if $(findstring 1,$(KBUILD_VERBOSE)),-v) \
+		--compress $(FIT_COMPRESSION) -k $< @$(word 2,$^)
+
 # XZ
 # ---------------------------------------------------------------------------
 # Use xzkern or xzkern_with_size to compress the kernel image and xzmisc to
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


