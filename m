Return-Path: <linux-kernel+bounces-100759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74814879CD2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A98A283197
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186D0142910;
	Tue, 12 Mar 2024 20:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BApKJEPF"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFE11428F9
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710275168; cv=none; b=A+Fm81NmC+wirfyLd9eM5DcRgjvJ6h2R3gyshl6WuHrkwY72y+XF+VDamApxSkde8R9QLXDawTmrHcR/+lEWivIOqw+8iqWVm4e4Uwys66Xa8cQzZP5s4aYcW+MnhOIILd6eH9n6KHgEqWe3iOwV9WkKsR3iyGqBaRBu0NHw+n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710275168; c=relaxed/simple;
	bh=5inDsbkM50c/G3sT1CXlUxdkCWFCgpacidQC8QYYVgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eue78df5Xq6HldkqFAYTYFlICwjS8cldonEBVbKvVb9cXYiCc6a5UScsWIFnKos9GAYRoabVE01TTLmxZgMl+ZDJxo4ZSBqsL11OKoQvGZf5bV9inu289/jbpyIk+gWa/Enqu930L8Qf0rVvoyrvTkHmQvHPegFgMnX2+wYdc6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BApKJEPF; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42a35c720b8so1324271cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710275163; x=1710879963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3aiF4iciKkLoOS6dwxhTrGRujKDVelZkiyWWbnm9CjU=;
        b=BApKJEPFhdDMx2t7oNmu3s2wcFfbA1x3NKRrv5p748/6g3tNUmmAffBrxD5r3l6A8y
         C/RWeVf11Zw0TeO+brz7uNFhrf6YUNEx5I/mijmvmZRxSg5VcF6fIJWjOPme+38MTcwG
         d1p8CsZV6IneFN6OYxjtHbMWmsJVYB1/hrzeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710275163; x=1710879963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3aiF4iciKkLoOS6dwxhTrGRujKDVelZkiyWWbnm9CjU=;
        b=hXPF1+vapW3GAWF9iEhpk1GZGJEOVsCI1PDRpfuqGeufd/irnwMQq1/GqyrQvyONst
         UsTDMz4zGB7mbo1qzAZcDknVe1djhejm5JAe7dYNh73/Oql4BpZ9CYQnl83A5y4kIeMQ
         PrncDHvQ2BW3NwaKKUQJXN/hf7zFUHEWRbYL9GyOl+1vHpJjVkxUdn1S4KeEvCy38bJ+
         GZG9NRlKtLh0P6YzVXn26HEVnzcqtpYqU8HlNa/7TcqNCwt33HehU8a3HT1O1S3mevQW
         TjpQfEJdURYwJunpqe8j1K1b832ERUwAcAC35Kr1ukE+BCGq7MdPiGjkTiDtLZFVhdX5
         3WXw==
X-Forwarded-Encrypted: i=1; AJvYcCXetTgCih/fS+zoQMHHPW9yvVvO643gD811XDbc59ZuWoTKQXJv1T+1csH/g7Sw2hJCuFOE2nEPvjgTKfC0BI+f9hNVs1VrjBGhrB2q
X-Gm-Message-State: AOJu0YytkIvQ2C16Q0uXB098oAsj/FWBVeRWITraqOpJuZHlJCC+RU7H
	WC2HBCq9h/vV6eeW5L+/w5fJNWV2KdZT0W3N73/X0gkgolyaKP7rmXkgJyw7BXBdVpJBjRWfynG
	DhF+lr+gsbCHsPDfBWy1rjvopSq1ppphp1Ih/
X-Google-Smtp-Source: AGHT+IF55f/Rc6wuOBOrS6xAB7tAOMk48MsSBXrT04HzQk7WihzzN+Qua8p/q59Mt2i1k9kbnjh92ehrr7sO34c1kmU=
X-Received: by 2002:a05:6214:88e:b0:690:b7b3:76da with SMTP id
 cz14-20020a056214088e00b00690b7b376damr5042015qvb.62.1710275163266; Tue, 12
 Mar 2024 13:26:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202173034.221790-1-sjg@chromium.org> <20240202173034.221790-3-sjg@chromium.org>
 <CAK7LNARBC-zPHWDzhkMj90UBVaxHs0PJ9wfUKLRGAHxzBx=Bqg@mail.gmail.com>
 <CAFLszTiwxm_=eXnfta4HA9b1c=ektr3yMiJKVfHESWOdDR4WxA@mail.gmail.com> <CAK7LNAS5rdb_1ZPSdtWXevyS8+vG4EWY6HAs152qggdyRSFLwA@mail.gmail.com>
In-Reply-To: <CAK7LNAS5rdb_1ZPSdtWXevyS8+vG4EWY6HAs152qggdyRSFLwA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Mar 2024 09:25:51 +1300
Message-ID: <CAFLszThvxRpahn+yJjJfY4UGmmYZdskno6kDcA+NVMQCzdCTkg@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] arm64: boot: Support Flat Image Tree
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
	Ahmad Fatoum <a.fatoum@pengutronix.de>, Nicolas Schier <nicolas@fjasle.eu>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Terrell <terrelln@fb.com>, Will Deacon <will@kernel.org>, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

On Mon, 11 Mar 2024 at 02:31, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Fri, Mar 8, 2024 at 12:55=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Masahiro,
> >
> > On Thu, 22 Feb 2024 at 01:38, Masahiro Yamada <masahiroy@kernel.org> wr=
ote:
> > >
> > > On Sat, Feb 3, 2024 at 2:30=E2=80=AFAM Simon Glass <sjg@chromium.org>=
 wrote:
> > > >
> > > > Add a script which produces a Flat Image Tree (FIT), a single file
> > > > containing the built kernel and associated devicetree files.
> > > > Compression defaults to gzip which gives a good balance of size and
> > > > performance.
> > > >
> > > > The files compress from about 86MB to 24MB using this approach.
> > > >
> > > > The FIT can be used by bootloaders which support it, such as U-Boot
> > > > and Linuxboot. It permits automatic selection of the correct
> > > > devicetree, matching the compatible string of the running board wit=
h
> > > > the closest compatible string in the FIT. There is no need for
> > > > filenames or other workarounds.
> > > >
> > > > Add a 'make image.fit' build target for arm64, as well.
> > > >
> > > > The FIT can be examined using 'dumpimage -l'.
> > > >
> > > > This uses the 'dtbs-list' file but processes only .dtb files, ignor=
ing
> > > > the overlay .dtbo files.
> > > >
> > > > This features requires pylibfdt (use 'pip install libfdt'). It also
> > > > requires compression utilities for the algorithm being used. Suppor=
ted
> > > > compression options are the same as the Image.xxx files. Use
> > > > FIT_COMPRESSION to select an algorithm other than gzip.
> > > >
> > > > While FIT supports a ramdisk / initrd, no attempt is made to suppor=
t
> > > > this here, since it must be built separately from the Linux build.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > Changes in v10:
> > > > - Make use of dtbs-list file
> > > > - Mention dtbs-list and FIT_COMPRESSION
> > > > - Update copyright year
> > > > - Update cover letter to take account of an applied patch
> > > >
> > > > Changes in v9:
> > > > - Move the compression control into Makefile.lib
> > > >
> > > > Changes in v8:
> > > > - Drop compatible string in FDT node
> > > > - Correct sorting of MAINTAINERS to before ARM64 PORT
> > > > - Turn compress part of the make_fit.py comment in to a sentence
> > > > - Add two blank lines before parse_args() and setup_fit()
> > > > - Use 'image.fit: dtbs' instead of BUILD_DTBS var
> > > > - Use '$(<D)/dts' instead of '$(dir $<)dts'
> > > > - Add 'mkimage' details Documentation/process/changes.rst
> > > > - Allow changing the compression used
> > > > - Tweak cover letter since there is only one clean-up patch
> > > >
> > > > Changes in v7:
> > > > - Add Image as a dependency of image.fit
> > > > - Drop kbuild tag
> > > > - Add dependency on dtbs
> > > > - Drop unnecessary path separator for dtbs
> > > > - Rebase to -next
> > > >
> > > > Changes in v5:
> > > > - Drop patch previously applied
> > > > - Correct compression rule which was broken in v4
> > > >
> > > > Changes in v4:
> > > > - Use single quotes for UIMAGE_NAME
> > > >
> > > > Changes in v3:
> > > > - Drop temporary file image.itk
> > > > - Drop patch 'Use double quotes for image name'
> > > > - Drop double quotes in use of UIMAGE_NAME
> > > > - Drop unnecessary CONFIG_EFI_ZBOOT condition for help
> > > > - Avoid hard-coding "arm64" for the DT architecture
> > > >
> > > > Changes in v2:
> > > > - Drop patch previously applied
> > > > - Add .gitignore file
> > > > - Move fit rule to Makefile.lib using an intermediate file
> > > > - Drop dependency on CONFIG_EFI_ZBOOT
> > > > - Pick up .dtb files separately from the kernel
> > > > - Correct pylint too-many-args warning for write_kernel()
> > > > - Include the kernel image in the file count
> > > > - Add a pointer to the FIT spec and mention of its wide industry us=
age
> > > > - Mention the kernel version in the FIT description
> > > >
> > > >  Documentation/process/changes.rst |   9 +
> > > >  MAINTAINERS                       |   7 +
> > > >  arch/arm64/Makefile               |   7 +-
> > > >  arch/arm64/boot/.gitignore        |   1 +
> > > >  arch/arm64/boot/Makefile          |   6 +-
> > > >  scripts/Makefile.lib              |  16 ++
> > > >  scripts/make_fit.py               | 298 ++++++++++++++++++++++++++=
++++
> > > >  7 files changed, 341 insertions(+), 3 deletions(-)
> > > >  create mode 100755 scripts/make_fit.py
> > > >
> > > > diff --git a/Documentation/process/changes.rst b/Documentation/proc=
ess/changes.rst
> > > > index 50b3d1cb1115..a8110965e4e1 100644
> > > > --- a/Documentation/process/changes.rst
> > > > +++ b/Documentation/process/changes.rst
> > > > @@ -62,6 +62,7 @@ Sphinx\ [#f1]_         2.4.4            sphinx-bu=
ild --version
> > > >  cpio                   any              cpio --version
> > > >  GNU tar                1.28             tar --version
> > > >  gtags (optional)       6.6.5            gtags --version
> > > > +mkimage (optional)     2017.01          mkimage --version
> > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > >
> > > >  .. [#f1] Sphinx is needed only to build the Kernel documentation
> > > > @@ -189,6 +190,14 @@ The kernel build requires GNU GLOBAL version 6=
6.5 or later to generate
> > > >  tag files through ``make gtags``.  This is due to its use of the g=
tags
> > > >  ``-C (--directory)`` flag.
> > > >
> > > > +mkimage
> > > > +-------
> > > > +
> > > > +This tool is used when building a Flat Image Tree (FIT), commonly =
used on ARM
> > > > +platforms. The tool is available via the ``u-boot-tools`` package =
or can be
> > > > +built from the U-Boot source code. See the instructions at
> > > > +https://docs.u-boot.org/en/latest/build/tools.html#building-tools-=
for-linux
> > > > +
> > > >  System utilities
> > > >  ****************
> > > >
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 61117c3afa80..10c2753d7bcc 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -3026,6 +3026,13 @@ F:       drivers/mmc/host/sdhci-of-arasan.c
> > > >  N:     zynq
> > > >  N:     xilinx
> > > >
> > > > +ARM64 FIT SUPPORT
> > > > +M:     Simon Glass <sjg@chromium.org>
> > > > +L:     linux-arm-kernel@lists.infradead.org (moderated for non-sub=
scribers)
> > > > +S:     Maintained
> > > > +F:     arch/arm64/boot/Makefile
> > > > +F:     scripts/make_fit.py
> > > > +
> > > >  ARM64 PORT (AARCH64 ARCHITECTURE)
> > > >  M:     Catalin Marinas <catalin.marinas@arm.com>
> > > >  M:     Will Deacon <will@kernel.org>
> > > > diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> > > > index 83cd2b7234b9..5de2b02f549a 100644
> > > > --- a/arch/arm64/Makefile
> > > > +++ b/arch/arm64/Makefile
> > > > @@ -150,7 +150,7 @@ libs-$(CONFIG_EFI_STUB) +=3D $(objtree)/drivers=
/firmware/efi/libstub/lib.a
> > > >  # Default target when executing plain make
> > > >  boot           :=3D arch/arm64/boot
> > > >
> > > > -BOOT_TARGETS   :=3D Image vmlinuz.efi
> > > > +BOOT_TARGETS   :=3D Image vmlinuz.efi image.fit
> > > >
> > > >  PHONY +=3D $(BOOT_TARGETS)
> > > >
> > > > @@ -162,7 +162,9 @@ endif
> > > >
> > > >  all:   $(notdir $(KBUILD_IMAGE))
> > > >
> > > > -vmlinuz.efi: Image
> > > > +image.fit: dtbs
> > > > +
> > > > +vmlinuz.efi image.fit: Image
> > > >  $(BOOT_TARGETS): vmlinux
> > > >         $(Q)$(MAKE) $(build)=3D$(boot) $(boot)/$@
> > > >
> > > > @@ -215,6 +217,7 @@ virtconfig:
> > > >  define archhelp
> > > >    echo  '* Image.gz      - Compressed kernel image (arch/$(ARCH)/b=
oot/Image.gz)'
> > > >    echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)=
/boot/Image)'
> > > > +  echo  '  image.fit     - Flat Image Tree (arch/$(ARCH)/boot/imag=
e.fit)'
> > > >    echo  '  install       - Install uncompressed kernel'
> > > >    echo  '  zinstall      - Install compressed kernel'
> > > >    echo  '                  Install using (your) ~/bin/installkerne=
l or'
> > > > diff --git a/arch/arm64/boot/.gitignore b/arch/arm64/boot/.gitignor=
e
> > > > index af5dc61f8b43..abaae9de1bdd 100644
> > > > --- a/arch/arm64/boot/.gitignore
> > > > +++ b/arch/arm64/boot/.gitignore
> > > > @@ -2,3 +2,4 @@
> > > >  Image
> > > >  Image.gz
> > > >  vmlinuz*
> > > > +image.fit
> > > > diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
> > > > index a5a787371117..ab21af82913e 100644
> > > > --- a/arch/arm64/boot/Makefile
> > > > +++ b/arch/arm64/boot/Makefile
> > > > @@ -16,7 +16,8 @@
> > > >
> > > >  OBJCOPYFLAGS_Image :=3D-O binary -R .note -R .note.gnu.build-id -R=
 .comment -S
> > > >
> > > > -targets :=3D Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.l=
zo Image.zst
> > > > +targets :=3D Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.l=
zo \
> > > > +       Image.zst image.fit
> > > >
> > > >  $(obj)/Image: vmlinux FORCE
> > > >         $(call if_changed,objcopy)
> > > > @@ -39,6 +40,9 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
> > > >  $(obj)/Image.zst: $(obj)/Image FORCE
> > > >         $(call if_changed,zstd)
> > > >
> > > > +$(obj)/image.fit: $(obj)/Image FORCE
> > > > +       $(call cmd,fit)
> > >
> > >
> > >
> > > The point for using dtbs-list is
> > > to avoid rebuilding image.fit needlessly.
> > >
> > >
> > > This should be:
> > >
> > > $(obj)/image.fit: $(obj)/Image $(obj)/dts/dtbs-list FORCE
> > >         $(call if_changed,fit)
> > >
> > >
> > >
> > >
> > >
> > > > +
> > > >  EFI_ZBOOT_PAYLOAD      :=3D Image
> > > >  EFI_ZBOOT_BFD_TARGET   :=3D elf64-littleaarch64
> > > >  EFI_ZBOOT_MACH_TYPE    :=3D ARM64
> > > > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > > > index b35d39022a30..4efb5ad07fd7 100644
> > > > --- a/scripts/Makefile.lib
> > > > +++ b/scripts/Makefile.lib
> > > > @@ -502,6 +502,22 @@ quiet_cmd_uimage =3D UIMAGE  $@
> > > >                         -a $(UIMAGE_LOADADDR) -e $(UIMAGE_ENTRYADDR=
) \
> > > >                         -n '$(UIMAGE_NAME)' -d $< $@
> > > >
> > > > +# Flat Image Tree (FIT)
> > > > +# This allows for packaging of a kernel and all devicetrees files,=
 using
> > > > +# compression.
> > > > +# ----------------------------------------------------------------=
-----------
> > > > +
> > > > +MAKE_FIT :=3D $(srctree)/scripts/make_fit.py
> > > > +
> > > > +# Use this to override the compression algorithm
> > > > +FIT_COMPRESSION ?=3D gzip
> > > > +
> > > > +quiet_cmd_fit =3D FIT     $@
> > > > +      cmd_fit =3D $(MAKE_FIT) -f $@ --arch $(UIMAGE_ARCH) --os lin=
ux \
> > > > +                       --name '$(UIMAGE_NAME)' \
> > > > +                       --compress $(FIT_COMPRESSION) -k $< \
> > > > +                       @arch/$(SRCARCH)/boot/dts/dtbs-list
> > >
> > >
> > >
> > >
> > > cmd_fit =3D $(MAKE_FIT) -f $@ --arch $(UIMAGE_ARCH) --os linux \
> > >                 --name '$(UIMAGE_NAME)' \
> > >                 --compress $(FIT_COMPRESSION) -k $< @$(word 2,$^)
> > >
> > >
> > >
> > >
> > >
> > > > +
> > > >  # XZ
> > > >  # ----------------------------------------------------------------=
-----------
> > > >  # Use xzkern to compress the kernel image and xzmisc to compress o=
ther things.
> > > > diff --git a/scripts/make_fit.py b/scripts/make_fit.py
> > > > new file mode 100755
> > > > index 000000000000..69eee32960ae
> > > > --- /dev/null
> > > > +++ b/scripts/make_fit.py
> > > > @@ -0,0 +1,298 @@
> > > > +#!/usr/bin/env python3
> > > > +# SPDX-License-Identifier: GPL-2.0+
> > > > +#
> > > > +# Copyright 2024 Google LLC
> > > > +# Written by Simon Glass <sjg@chromium.org>
> > > > +#
> > > > +
> > > > +"""Build a FIT containing a lot of devicetree files
> > > > +
> > > > +Usage:
> > > > +    make_fit.py -A arm64 -n 'Linux-6.6' -O linux
> > > > +        -f arch/arm64/boot/image.fit -k /tmp/kern/arch/arm64/boot/=
image.itk
> > > > +        @arch/arm64/boot/dts/dtbs-list -E -c gzip
> > > > +
> > > > +Creates a FIT containing the supplied kernel and a set of devicetr=
ee files,
> > > > +either specified individually or listed in a file (with an '@' pre=
fix). Files
> > > > +which don't end in '.dtb' are silently ignored.
> > >
> > >
> > > Why do you need to check the suffix?
> > >
> > >
> > >
> > > > +
> > > > +Use -E to generate an external FIT (where the data is placed after=
 the
> > > > +FIT data structure). This allows parsing of the data without loadi=
ng
> > > > +the entire FIT.
> > > > +
> > > > +Use -c to compress the data, using bzip2, gzip, lz4, lzma, lzo and
> > > > +zstd algorithms.
> > > > +
> > > > +The resulting FIT can be booted by bootloaders which support FIT, =
such
> > > > +as U-Boot, Linuxboot, Tianocore, etc.
> > > > +
> > > > +Note that this tool does not yet support adding a ramdisk / initrd=
.
> > > > +"""
> > > > +
> > > > +import argparse
> > > > +import collections
> > > > +import os
> > > > +import subprocess
> > > > +import sys
> > > > +import tempfile
> > > > +import time
> > > > +
> > > > +import libfdt
> > > > +
> > > > +
> > > > +# Tool extension and the name of the command-line tools
> > > > +CompTool =3D collections.namedtuple('CompTool', 'ext,tools')
> > > > +
> > > > +COMP_TOOLS =3D {
> > > > +    'bzip2': CompTool('.bz2', 'bzip2'),
> > > > +    'gzip': CompTool('.gz', 'pigz,gzip'),
> > > > +    'lz4': CompTool('.lz4', 'lz4'),
> > > > +    'lzma': CompTool('.lzma', 'lzma'),
> > > > +    'lzo': CompTool('.lzo', 'lzop'),
> > > > +    'zstd': CompTool('.zstd', 'zstd'),
> > > > +}
> > > > +
> > > > +
> > > > +def parse_args():
> > > > +    """Parse the program ArgumentParser
> > > > +
> > > > +    Returns:
> > > > +        Namespace object containing the arguments
> > > > +    """
> > > > +    epilog =3D 'Build a FIT from a directory tree containing .dtb =
files'
> > > > +    parser =3D argparse.ArgumentParser(epilog=3Depilog)
> > > > +    parser.add_argument('-A', '--arch', type=3Dstr, required=3DTru=
e,
> > > > +          help=3D'Specifies the architecture')
> > > > +    parser.add_argument('-c', '--compress', type=3Dstr, default=3D=
'none',
> > > > +          help=3D'Specifies the compression')
> > > > +    parser.add_argument('-E', '--external', action=3D'store_true',
> > > > +          help=3D'Convert the FIT to use external data')
> > > > +    parser.add_argument('-n', '--name', type=3Dstr, required=3DTru=
e,
> > > > +          help=3D'Specifies the name')
> > > > +    parser.add_argument('-O', '--os', type=3Dstr, required=3DTrue,
> > > > +          help=3D'Specifies the operating system')
> > > > +    parser.add_argument('-f', '--fit', type=3Dstr, required=3DTrue=
,
> > > > +          help=3D'Specifies the output file (.fit)')
> > >
> > >
> > >
> > > I like -o (--output) to specify the output file.
> > >
> > >
> > >
> > >     parser.add_argument('-o', '--output', type=3Dstr, required=3DTrue=
,
> > >              help=3D'Specifies the output file (.fit)')
> > >
> > >
> > >
> > >
> > >
> > > > +    parser.add_argument('-k', '--kernel', type=3Dstr, required=3DT=
rue,
> > > > +          help=3D'Specifies the (uncompressed) kernel input file (=
itk)')
> > > > +    parser.add_argument('srcdir', type=3Dstr, nargs=3D'*',
> > > > +          help=3D'Specifies the directory tree that contains .dtb =
files')
> > >
> > >
> > > srcdir?
> > >
> > > You changed the positional parameters to take dtb files.
> > >
> > >
> > >
> > >
> > >
> > >
> > > > +
> > > > +    return parser.parse_args()
> > > > +
> > > > +
> > > > +def setup_fit(fsw, name):
> > > > +    """Make a start on writing the FIT
> > > > +
> > > > +    Outputs the root properties and the 'images' node
> > > > +
> > > > +    Args:
> > > > +        fsw (libfdt.FdtSw): Object to use for writing
> > > > +        name (str): Name of kernel image
> > > > +    """
> > > > +    fsw.INC_SIZE =3D 65536
> > > > +    fsw.finish_reservemap()
> > > > +    fsw.begin_node('')
> > > > +    fsw.property_string('description', f'{name} with devicetree se=
t')
> > > > +    fsw.property_u32('#address-cells', 1)
> > > > +
> > > > +    fsw.property_u32('timestamp', int(time.time()))
> > > > +    fsw.begin_node('images')
> > > > +
> > > > +
> > > > +def write_kernel(fsw, data, args):
> > > > +    """Write out the kernel image
> > > > +
> > > > +    Writes a kernel node along with the required properties
> > > > +
> > > > +    Args:
> > > > +        fsw (libfdt.FdtSw): Object to use for writing
> > > > +        data (bytes): Data to write (possibly compressed)
> > > > +        args (Namespace): Contains necessary strings:
> > > > +            arch: FIT architecture, e.g. 'arm64'
> > > > +            fit_os: Operating Systems, e.g. 'linux'
> > > > +            name: Name of OS, e.g. 'Linux-6.6.0-rc7'
> > > > +            compress: Compression algorithm to use, e.g. 'gzip'
> > > > +    """
> > > > +    with fsw.add_node('kernel'):
> > > > +        fsw.property_string('description', args.name)
> > > > +        fsw.property_string('type', 'kernel_noload')
> > > > +        fsw.property_string('arch', args.arch)
> > > > +        fsw.property_string('os', args.os)
> > > > +        fsw.property_string('compression', args.compress)
> > > > +        fsw.property('data', data)
> > > > +        fsw.property_u32('load', 0)
> > > > +        fsw.property_u32('entry', 0)
> > > > +
> > > > +
> > > > +def finish_fit(fsw, entries):
> > > > +    """Finish the FIT ready for use
> > > > +
> > > > +    Writes the /configurations node and subnodes
> > > > +
> > > > +    Args:
> > > > +        fsw (libfdt.FdtSw): Object to use for writing
> > > > +        entries (list of tuple): List of configurations:
> > > > +            str: Description of model
> > > > +            str: Compatible stringlist
> > > > +    """
> > > > +    fsw.end_node()
> > > > +    seq =3D 0
> > > > +    with fsw.add_node('configurations'):
> > > > +        for model, compat in entries:
> > > > +            seq +=3D 1
> > > > +            with fsw.add_node(f'conf-{seq}'):
> > > > +                fsw.property('compatible', bytes(compat))
> > > > +                fsw.property_string('description', model)
> > > > +                fsw.property_string('fdt', f'fdt-{seq}')
> > > > +                fsw.property_string('kernel', 'kernel')
> > > > +    fsw.end_node()
> > > > +
> > > > +
> > > > +def compress_data(inf, compress):
> > > > +    """Compress data using a selected algorithm
> > > > +
> > > > +    Args:
> > > > +        inf (IOBase): Filename containing the data to compress
> > > > +        compress (str): Compression algorithm, e.g. 'gzip'
> > > > +
> > > > +    Return:
> > > > +        bytes: Compressed data
> > > > +    """
> > > > +    if compress =3D=3D 'none':
> > > > +        return inf.read()
> > > > +
> > > > +    comp =3D COMP_TOOLS.get(compress)
> > > > +    if not comp:
> > > > +        raise ValueError(f"Unknown compression algorithm '{compres=
s}'")
> > > > +
> > > > +    with tempfile.NamedTemporaryFile() as comp_fname:
> > > > +        with open(comp_fname.name, 'wb') as outf:
> > > > +            done =3D False
> > > > +            for tool in comp.tools.split(','):
> > > > +                try:
> > > > +                    subprocess.call([tool, '-c'], stdin=3Dinf, std=
out=3Doutf)
> > > > +                    done =3D True
> > > > +                    break
> > > > +                except FileNotFoundError:
> > > > +                    pass
> > > > +            if not done:
> > > > +                raise ValueError(f'Missing tool(s): {comp.tools}\n=
')
> > > > +            with open(comp_fname.name, 'rb') as compf:
> > > > +                comp_data =3D compf.read()
> > > > +    return comp_data
> > > > +
> > > > +
> > > > +def output_dtb(fsw, seq, fname, arch, compress):
> > > > +    """Write out a single devicetree to the FIT
> > > > +
> > > > +    Args:
> > > > +        fsw (libfdt.FdtSw): Object to use for writing
> > > > +        seq (int): Sequence number (1 for first)
> > > > +        fmame (str): Filename containing the DTB
> > > > +        arch: FIT architecture, e.g. 'arm64'
> > > > +        compress (str): Compressed algorithm, e.g. 'gzip'
> > > > +
> > > > +    Returns:
> > > > +        tuple:
> > > > +            str: Model name
> > > > +            bytes: Compatible stringlist
> > > > +    """
> > > > +    with fsw.add_node(f'fdt-{seq}'):
> > > > +        # Get the compatible / model information
> > > > +        with open(fname, 'rb') as inf:
> > > > +            data =3D inf.read()
> > > > +        fdt =3D libfdt.FdtRo(data)
> > > > +        model =3D fdt.getprop(0, 'model').as_str()
> > > > +        compat =3D fdt.getprop(0, 'compatible')
> > > > +
> > > > +        fsw.property_string('description', model)
> > > > +        fsw.property_string('type', 'flat_dt')
> > > > +        fsw.property_string('arch', arch)
> > > > +        fsw.property_string('compression', compress)
> > > > +        fsw.property('compatible', bytes(compat))
> > > > +
> > > > +        with open(fname, 'rb') as inf:
> > > > +            compressed =3D compress_data(inf, compress)
> > > > +        fsw.property('data', compressed)
> > > > +    return model, compat
> > > > +
> > > > +
> > > > +def build_fit(args):
> > > > +    """Build the FIT from the provided files and arguments
> > > > +
> > > > +    Args:
> > > > +        args (Namespace): Program arguments
> > > > +
> > > > +    Returns:
> > > > +        tuple:
> > > > +            bytes: FIT data
> > > > +            int: Number of configurations generated
> > > > +            size: Total uncompressed size of data
> > > > +    """
> > > > +    def add_file(fname):
> > > > +        nonlocal seq, size
> > > > +
> > > > +        if os.path.splitext(fname)[1] =3D=3D '.dtb':
> > > > +            seq +=3D 1
> > > > +            size +=3D os.path.getsize(fname)
> > > > +            model, compat =3D output_dtb(fsw, seq, fname, args.arc=
h,
> > > > +                                       args.compress)
> > > > +            entries.append([model, compat])
> > > > +            return True
> > > > +
> > > > +    seq =3D 0
> > > > +    size =3D 0
> > > > +    fsw =3D libfdt.FdtSw()
> > > > +    setup_fit(fsw, args.name)
> > > > +    entries =3D []
> > > > +
> > > > +    # Handle the kernel
> > > > +    with open(args.kernel, 'rb') as inf:
> > > > +        comp_data =3D compress_data(inf, args.compress)
> > > > +    size +=3D os.path.getsize(args.kernel)
> > > > +    write_kernel(fsw, comp_data, args)
> > > > +
> > > > +    for path in args.srcdir:
> > > > +        # Handle a list of devicetree files
> > > > +        if path.startswith('@'):
> > > > +            with open(path[1:], 'r', encoding=3D'utf-8') as inf:
> > > > +                for fname in inf.read().splitlines():
> > > > +                    add_file(fname)
> > >
> > >
> > >
> > >
> > > You missed the point of my suggestion.
> > >
> > >
> > > I did not mean the "@file" syntax
> > > specifically for containing the device trees.
> > >
> > >
> > > It is common for tools to support the "@file" syntax
> > > to avoid "Argument list too long" error.
> > >
> > >
> > >
> > > See "man ar", "man ld", etc. for example.
> > >
> > >
> > >  @file
> > >    Read command=E2=80=90line options from file. The options read are =
inserted in
> > >    place of the original @file option. If file does not exist, or can=
not
> > >    be read, then the option will be treated literally, and not remove=
d.
> > >
> > >
> > >
> > >
> > > It must be generic enough to contain any command line parameters.
> > >
> > >
> > > And, you do not even implement it yourself because
> > > it is just a matter of adding fromfile_prefix_chars=3D'@'
> > >
> > >
> > > See the document.
> > >
> > >   https://docs.python.org/3/library/argparse.html#fromfile-prefix-cha=
rs
> > >
> > >
> > >
> > >
> > >
> > > > +        else:
> > > > +            add_file(path)
> > > > +
> > > > +    finish_fit(fsw, entries)
> > > > +
> > > > +    # Include the kernel itself in the returned file count
> > > > +    return fsw.as_fdt().as_bytearray(), seq + 1, size
> > > > +
> > > > +
> > > > +def run_make_fit():
> > > > +    """Run the tool's main logic"""
> > > > +    args =3D parse_args()
> > > > +
> > > > +    out_data, count, size =3D build_fit(args)
> > > > +    with open(args.fit, 'wb') as outf:
> > > > +        outf.write(out_data)
> > > > +
> > > > +    ext_fit_size =3D None
> > > > +    if args.external:
> > > > +        mkimage =3D os.environ.get('MKIMAGE', 'mkimage')
> > > > +        subprocess.check_call([mkimage, '-E', '-F', args.fit],
> > > > +                              stdout=3Dsubprocess.DEVNULL)
> > > > +
> > > > +        with open(args.fit, 'rb') as inf:
> > > > +            data =3D inf.read()
> > > > +        ext_fit =3D libfdt.FdtRo(data)
> > > > +        ext_fit_size =3D ext_fit.totalsize()
> > >
> > >
> > >
> > > I still do not understand why mkimage is needed.
> > >
> > >
> > > When external data is used, you can insert "data-size"
> > > and "data-offset" to the dt structure,
> > > and at the same time, concatenate the payload data.
> > > Finally, you can combine the two.
> > > Is it complex to implement?
> >
> > Yes it is somewhat complex, since there are options like alignment and
> > the like which are implemented in that tool.
>
>
>
> So, do you mean you need to pass
> not only -E, -F but also more options to mkimage?

Possibly, in the future, yes.

>
>
>
> > Is there a problem with
> > using the tool? After all, people are using it today and will be
> > expecting this script to use it, I believe. If we start adding mkimage
> > functionality here then we will have to maintain it in two places and
> > worry about whether they are consistent. Also if we want to support
> > signatures, etc. then it would be quite an undertaking to write all
> > that code again in Python.
>
>
> Not a problem, but I think it is unfortunate.
> I thought this script would be a standalone,
> self-contained tool to produce a FIT image.

Well it already requires pylibfdt. I am not keen on duplicating any
more of the mkimage functionality here, particularly as the features
tend to change and expand over time.

>
>
>
> > >
> > >
> > >
> > >
> > >
> > >
> > > > +
> > > > +    comp_size =3D len(out_data)
> > > > +    print(f'FIT size {comp_size:#x}/{comp_size / 1024 / 1024:.1f} =
MB', end=3D'')
> > > > +    if ext_fit_size:
> > > > +        print(f', header {ext_fit_size:#x}/{ext_fit_size / 1024:.1=
f} KB', end=3D'')
> > > > +    print(f', {count} files, uncompressed {size / 1024 / 1024:.1f}=
 MB')
> > >
> > >
> > > Maybe, you can print this only when args.verbose =3D=3D True ?
> >
> > This and other comments seem OK to me and I will address them in v11.
> >
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > > At last, I still do not know how to distinguish the nodes
> > > when the compatible strings are the same.
> >
> > It is like trying to distinguish two devices with the same compatible
> > string. Really, it should not be done. If you would like me to change
> > the script in some way, please suggest something.
>
>
> I cannot suggest anything at this moment.
>
> I believe we need a way to distinguish two devices,
> but I do not see any consensus.

If you would like my opinion, it is that duplicate compatible strings
are not distinguishable by design. It would be better to fix the
source files.

Regards,
Simon

