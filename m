Return-Path: <linux-kernel+bounces-50239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57162847627
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BB8F1C28721
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7E414AD17;
	Fri,  2 Feb 2024 17:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E7uUaHqu"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C999B14D422
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895048; cv=none; b=UUmRTtfV2yKfxBcnZ85EreS87BZnIJ3JDbTw7sSGZiWDDkR7dYRw6L/ZD0Pbg28BhGsth2gTaqCwCdYFszMhFSYGihhfE0072LcRp7ttf/YBAzbNpvBz+wKC9tcoJ+e0yNdoptidEaM0Z2dYkJtIC3XPPosHPSYkdhAtRmgMi+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895048; c=relaxed/simple;
	bh=6/LQjwafjkf3POPALyFSJZbXfQo0FXONK0GPPdihaeI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SQtsBZQU6OyE4CXA+WZZM8g4Y2AuR77imK/s+gQlkXaVtNQyUW2zHOdXRPDMyQG0RKuoKsezA1+EwJZi4GOn9/75+ZVZ4lRSLIauArXVd3bW7EOWFsj7fdgofZ9CYdwc+YSKh0DBoOeBxi9cs+K+UzieMXKpdBn5QbfkNYMkmes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E7uUaHqu; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a372a3773a5so51838166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 09:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706895044; x=1707499844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUjd9mNFW9Xo6zVRo6Wb/Ij0ln3xwo6VigqykVmxzxo=;
        b=E7uUaHqusD5/Efq5QS+StR9FXuD61UQdA6tW7JuiRB6v+iKb1gKGKOKaK8usBAKm2n
         kfbS8fopp5u8+YNT6WyeCvBO8joyu1Ubes8ReDoWE3KAQu5OFqU5v9cDFabYB67QywpN
         LRMkd34pjNBdk30nkhMazC13ID5f21QbuLAQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895044; x=1707499844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUjd9mNFW9Xo6zVRo6Wb/Ij0ln3xwo6VigqykVmxzxo=;
        b=aenbnuoJCliUomgmq7JCuAzfvaByX7ZxTaw3pRASjdYN1CChg8RRxst0M3o7t20hHH
         Se7dJjeW/cLUVTgzobCgLR1622toN7T4WglnkxTFNHGpHZgPFWuxmvba7gUJJ937XsIU
         WiMPE/w6YmZJkgAbnCKtTxOM4v2UdBaES9YRokUcMVZJaDPlTL++50aHEUqyhr6M5Z1v
         YYBdzQhDsgRT3HkXrlmZVKWZ/UetNYqgKv4uYWQfDRiC4E6XCXF60CHcUT6es2flXR1v
         ha64Ot0I2VZGz8J97J+X8mmDlmy062ChuoMHt6TyUBqfBiW52f+LCCCIfm7ks5d+8lpg
         wLxg==
X-Gm-Message-State: AOJu0YwsRQq4FjSOZytVPp0DEN6zfn9ILiVaezCpTLE3oDbNfUTChS7P
	4/rUC1vKTH8U3QKuL8589pbn73wA13w1WBnJ2w05rBEfqdTuCF6HokclRLDo0Q==
X-Google-Smtp-Source: AGHT+IEu4yiHnceMrb9CvB8px4GsG1m5WOHmxkjgGxCkUHPhhmkw6Cl96PnLbUAXd0Dl6BEW/xlNRA==
X-Received: by 2002:a17:907:788e:b0:a37:3abb:99c2 with SMTP id ku14-20020a170907788e00b00a373abb99c2mr67433ejc.74.1706895044091;
        Fri, 02 Feb 2024 09:30:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX1WmyEW96BkinfCnY3RLD+m6tFijx2cAvuMjzuz4wFs74vxRHDww0NLru4eBkxCIDndDkeE8LjB4EeTt4ZHO8GqN4Q2qoSno+8eT6NhLm227tj3oNU6ly9Vbm02EiVFLXB+wJZppg91gkRWkBGgZ1AGIBbju5R+ZBw6KeQaBsMQgy62Mk3aGhvaKhTpmwnyf9Z9q05Ytr+ZiB+0IcholmXt4GcI0y3hHXgyTYpVVMVkFBbaeDYJN061sgJv+AeSmDq5k+4fbPPb63ifQ/ULzLoBijUH5y6Z/9KRdghymNTa8T8hZutkpyylje51RQQ0ntRQDc7hPKnsmgRJt/6k6VTbhrDIWI24np5r2iTpXX8NAC/+xybdFlEhvN2eyYyOK2mAxjXmjc+ILN+Dh+rOx+h7pMlEL9Dc+aG
Received: from chromium.org (66.224-78-194.adsl-static.isp.belgacom.be. [194.78.224.66])
        by smtp.gmail.com with ESMTPSA id hd34-20020a17090796a200b00a36f314daa6sm1083392ejc.46.2024.02.02.09.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 09:30:43 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
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
Subject: [PATCH v10 2/2] arm64: boot: Support Flat Image Tree
Date: Fri,  2 Feb 2024 10:30:34 -0700
Message-Id: <20240202173034.221790-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202173034.221790-1-sjg@chromium.org>
References: <20240202173034.221790-1-sjg@chromium.org>
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
 scripts/make_fit.py               | 298 ++++++++++++++++++++++++++++++
 7 files changed, 341 insertions(+), 3 deletions(-)
 create mode 100755 scripts/make_fit.py

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 50b3d1cb1115..a8110965e4e1 100644
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
index 61117c3afa80..10c2753d7bcc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3026,6 +3026,13 @@ F:	drivers/mmc/host/sdhci-of-arasan.c
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
index 83cd2b7234b9..5de2b02f549a 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -150,7 +150,7 @@ libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 # Default target when executing plain make
 boot		:= arch/arm64/boot
 
-BOOT_TARGETS	:= Image vmlinuz.efi
+BOOT_TARGETS	:= Image vmlinuz.efi image.fit
 
 PHONY += $(BOOT_TARGETS)
 
@@ -162,7 +162,9 @@ endif
 
 all:	$(notdir $(KBUILD_IMAGE))
 
-vmlinuz.efi: Image
+image.fit: dtbs
+
+vmlinuz.efi image.fit: Image
 $(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
@@ -215,6 +217,7 @@ virtconfig:
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
index a5a787371117..ab21af82913e 100644
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
 
+$(obj)/image.fit: $(obj)/Image FORCE
+	$(call cmd,fit)
+
 EFI_ZBOOT_PAYLOAD	:= Image
 EFI_ZBOOT_BFD_TARGET	:= elf64-littleaarch64
 EFI_ZBOOT_MACH_TYPE	:= ARM64
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index b35d39022a30..4efb5ad07fd7 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -502,6 +502,22 @@ quiet_cmd_uimage = UIMAGE  $@
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
+      cmd_fit = $(MAKE_FIT) -f $@ --arch $(UIMAGE_ARCH) --os linux \
+			--name '$(UIMAGE_NAME)' \
+			--compress $(FIT_COMPRESSION) -k $< \
+			@arch/$(SRCARCH)/boot/dts/dtbs-list
+
 # XZ
 # ---------------------------------------------------------------------------
 # Use xzkern to compress the kernel image and xzmisc to compress other things.
diff --git a/scripts/make_fit.py b/scripts/make_fit.py
new file mode 100755
index 000000000000..69eee32960ae
--- /dev/null
+++ b/scripts/make_fit.py
@@ -0,0 +1,298 @@
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
+        -f arch/arm64/boot/image.fit -k /tmp/kern/arch/arm64/boot/image.itk
+        @arch/arm64/boot/dts/dtbs-list -E -c gzip
+
+Creates a FIT containing the supplied kernel and a set of devicetree files,
+either specified individually or listed in a file (with an '@' prefix). Files
+which don't end in '.dtb' are silently ignored.
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
+    parser = argparse.ArgumentParser(epilog=epilog)
+    parser.add_argument('-A', '--arch', type=str, required=True,
+          help='Specifies the architecture')
+    parser.add_argument('-c', '--compress', type=str, default='none',
+          help='Specifies the compression')
+    parser.add_argument('-E', '--external', action='store_true',
+          help='Convert the FIT to use external data')
+    parser.add_argument('-n', '--name', type=str, required=True,
+          help='Specifies the name')
+    parser.add_argument('-O', '--os', type=str, required=True,
+          help='Specifies the operating system')
+    parser.add_argument('-f', '--fit', type=str, required=True,
+          help='Specifies the output file (.fit)')
+    parser.add_argument('-k', '--kernel', type=str, required=True,
+          help='Specifies the (uncompressed) kernel input file (.itk)')
+    parser.add_argument('srcdir', type=str, nargs='*',
+          help='Specifies the directory tree that contains .dtb files')
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
+    def add_file(fname):
+        nonlocal seq, size
+
+        if os.path.splitext(fname)[1] == '.dtb':
+            seq += 1
+            size += os.path.getsize(fname)
+            model, compat = output_dtb(fsw, seq, fname, args.arch,
+                                       args.compress)
+            entries.append([model, compat])
+            return True
+
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
+    for path in args.srcdir:
+        # Handle a list of devicetree files
+        if path.startswith('@'):
+            with open(path[1:], 'r', encoding='utf-8') as inf:
+                for fname in inf.read().splitlines():
+                    add_file(fname)
+        else:
+            add_file(path)
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
+    with open(args.fit, 'wb') as outf:
+        outf.write(out_data)
+
+    ext_fit_size = None
+    if args.external:
+        mkimage = os.environ.get('MKIMAGE', 'mkimage')
+        subprocess.check_call([mkimage, '-E', '-F', args.fit],
+                              stdout=subprocess.DEVNULL)
+
+        with open(args.fit, 'rb') as inf:
+            data = inf.read()
+        ext_fit = libfdt.FdtRo(data)
+        ext_fit_size = ext_fit.totalsize()
+
+    comp_size = len(out_data)
+    print(f'FIT size {comp_size:#x}/{comp_size / 1024 / 1024:.1f} MB', end='')
+    if ext_fit_size:
+        print(f', header {ext_fit_size:#x}/{ext_fit_size / 1024:.1f} KB', end='')
+    print(f', {count} files, uncompressed {size / 1024 / 1024:.1f} MB')
+
+
+if __name__ == "__main__":
+    sys.exit(run_make_fit())
-- 
2.34.1


