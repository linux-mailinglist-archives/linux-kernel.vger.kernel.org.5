Return-Path: <linux-kernel+bounces-18821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04303826391
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 10:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90561282895
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 09:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F22612B78;
	Sun,  7 Jan 2024 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O92BIUst"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8104212B6D
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 09:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3717C433CB
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 09:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704618803;
	bh=lby2YwXYBR8MpwYa8Qm4WEWUd+51MI/1x+Gc6lo8E3s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O92BIUstXNHnDUU6+AJfoE9YHpV6VYR4SHEYvGjTBSuIW8nDVd+pOCWZMKJjtypRo
	 CVu32CzfF4K+8nqYenyYuFcb2R19VT4BeQqcIDSDM3PaWf5g+cjew1V7KfWRhCQx34
	 bT4YTYSha4S28vf+aelWZ8g5L0B1QxIgM1XaNWCrjf2xDdNMgZm+RPq0u6ktXgsp5e
	 jdw5fd0JyR+VaDe+Yt+IX57sK84Dtu18iqQVQgDOV0nbwl1Q2z6mgYA8+O218DW++Y
	 i/ORE0+fUoutsphq6SIY+MDQINd4+jJ+kmQanLGe1T93DwJ0U2QmWhbrpEl0/BCLjU
	 V5QUodUS+5U4Q==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5983c45a5d3so187626eaf.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 01:13:23 -0800 (PST)
X-Gm-Message-State: AOJu0YwRiC+l3EDZaEPQzyNYbpoAWTHX4u7I3Wq4vnaX0RqSCh2nEFQI
	h0FRCVahbbt7k89dS7xia6Oz59XmUx85KWPBQM8=
X-Google-Smtp-Source: AGHT+IHT+Craw9DjF4NKPHqZvE7Eq6CLtcfUcyQgyHSVp1AN55S8K/TcnLRtSDi0HY/bmF1EN6NsB8Yv5UIyUpj9MOg=
X-Received: by 2002:a05:6870:b416:b0:203:e7a5:bbf1 with SMTP id
 x22-20020a056870b41600b00203e7a5bbf1mr3042251oap.67.1704618803148; Sun, 07
 Jan 2024 01:13:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704353568.git.kevinmbecause@gmail.com> <cd370037f8c21dc851a2a33a07250459c9c98708.1704353568.git.kevinmbecause@gmail.com>
In-Reply-To: <cd370037f8c21dc851a2a33a07250459c9c98708.1704353568.git.kevinmbecause@gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 7 Jan 2024 18:12:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNARwQwE7=xUjE9HSzTYujWHWFGSu48xBg56pfBE+0uv6_g@mail.gmail.com>
Message-ID: <CAK7LNARwQwE7=xUjE9HSzTYujWHWFGSu48xBg56pfBE+0uv6_g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] firmware_loader: Enable compressed files with EXTRA_FIRMWARE
To: Kevin Martin <kevinmbecause@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 3:11=E2=80=AFPM Kevin Martin <kevinmbecause@gmail.co=
m> wrote:
>
> The linux-firmware packages on Gentoo, Fedora, Arch, and others
> compress the firmware files. This works well with
> CONFIG_FW_LOADER_COMPRESS but does not work with CONFIG_EXTRA_FIRMWARE.
> This patch allows the build system to decompress firmware files
> specified by CONFIG_EXTRA_FIRMWARE. Uncompressed files are used first,
> then the compressed files are used.
>
> The patch works by copying or decompressing the specified firmware files
> into the build directory, then compiling them in from there. I would
> prefer to not copy any uncompressed files, but I have not found a clean
> way to do that.
>
> Signed-off-by: Kevin Martin <kevinmbecause@gmail.com>
> ---
> Changes in v2:
> - Changed .gitignore to ignore all firmware files copied into the
> directory.
> - Fixed a tab.
>
>  drivers/base/firmware_loader/Kconfig            |  5 ++++-
>  drivers/base/firmware_loader/builtin/.gitignore |  5 ++++-
>  drivers/base/firmware_loader/builtin/Makefile   | 16 ++++++++++++----
>  3 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware=
_loader/Kconfig
> index 5ca00e02f..b7a908bff 100644
> --- a/drivers/base/firmware_loader/Kconfig
> +++ b/drivers/base/firmware_loader/Kconfig
> @@ -76,7 +76,10 @@ config EXTRA_FIRMWARE
>           image since it combines both GPL and non-GPL work. You should
>           consult a lawyer of your own before distributing such an image.
>
> -         NOTE: Compressed files are not supported in EXTRA_FIRMWARE.
> +         NOTE: Compressed files are supported by EXTRA_FIRMWARE. The bui=
ld
> +         system will look for uncompressed files first then fall back to
> +         searching for compressed files in a similar way to
> +         CONFIG_FW_LOADER_COMPRESS.
>
>  config EXTRA_FIRMWARE_DIR
>         string "Firmware blobs root directory"
> diff --git a/drivers/base/firmware_loader/builtin/.gitignore b/drivers/ba=
se/firmware_loader/builtin/.gitignore
> index 166f76b43..b3124ee78 100644
> --- a/drivers/base/firmware_loader/builtin/.gitignore
> +++ b/drivers/base/firmware_loader/builtin/.gitignore
> @@ -1,2 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -*.gen.S
> +*
> +!.gitignore
> +!Makefile
> +!main.c
> diff --git a/drivers/base/firmware_loader/builtin/Makefile b/drivers/base=
/firmware_loader/builtin/Makefile
> index 6c067dedc..cc60eb441 100644
> --- a/drivers/base/firmware_loader/builtin/Makefile
> +++ b/drivers/base/firmware_loader/builtin/Makefile
> @@ -20,7 +20,7 @@ filechk_fwbin =3D \
>         echo "    .section .rodata"                             ;\
>         echo "    .p2align 4"                                   ;\
>         echo "_fw_$(FWSTR)_bin:"                                ;\
> -       echo "    .incbin \"$(fwdir)/$(FWNAME)\""               ;\
> +       echo "    .incbin \"$(obj)/$(FWNAME)\""                 ;\
>         echo "_fw_end:"                                         ;\
>         echo "    .section .rodata.str,\"aMS\",$(PROGBITS),1"   ;\
>         echo "    .p2align $(ASM_ALIGN)"                        ;\
> @@ -36,7 +36,15 @@ $(obj)/%.gen.S: FORCE
>         $(call filechk,fwbin)
>
>  # The .o files depend on the binaries directly; the .S files don't.
> -$(addprefix $(obj)/, $(firmware)): $(obj)/%.gen.o: $(fwdir)/%
> +$(addprefix $(obj)/, $(firmware)): $(obj)/%.gen.o: $(obj)/%
>
> -targets :=3D $(patsubst $(obj)/%,%, \
> -                                $(shell find $(obj) -name \*.gen.S 2>/de=
v/null))
> +$(obj)/% : $(fwdir)/% FORCE
> +       $(call if_changed,copy)
> +
> +$(obj)/% : $(fwdir)/%.xz FORCE
> +       $(call if_changed,xzdec)
> +
> +$(obj)/% : $(fwdir)/%.zst FORCE
> +       $(call if_changed,zstddec)
> +
> +targets :=3D $(patsubst %.gen.o, %.gen.S, $(firmware)) $(CONFIG_EXTRA_FI=
RMWARE)


I noticed that "make clean" leaves copied firmware files
in drivers/base/firmware_loader/builtin/.


You need to clean up all files in
drivers/base/firmware_loader/builtin/
except Makefile, main.c.

The following worked for me.


diff --git a/drivers/base/firmware_loader/builtin/Makefile
b/drivers/base/firmware_loader/builtin/Makefile
index bcac1723dc32..4d62ee9f06f6 100644
--- a/drivers/base/firmware_loader/builtin/Makefile
+++ b/drivers/base/firmware_loader/builtin/Makefile
@@ -48,3 +48,5 @@ $(obj)/% : $(fwdir)/%.zst FORCE
        $(call if_changed,zstddec)

 targets :=3D $(patsubst %.gen.o, %.gen.S, $(firmware)) $(CONFIG_EXTRA_FIRM=
WARE)
+
+clean-files :=3D $(filter-out Makefile main.c, $(patsubst $(obj)/%,%,
$(wildcard $(obj)/*)))













--=20
Best Regards
Masahiro Yamada

