Return-Path: <linux-kernel+bounces-166483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 861888B9B4B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F599282189
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1ED383CC0;
	Thu,  2 May 2024 13:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUuICBZx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29937FBF6;
	Thu,  2 May 2024 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714655128; cv=none; b=T4FXuiyovOrW/CnmqWDByAaDgSq4cAcJO/O9JaIaevxR3fH71/PylhLwqO7BZu723X4gnf9gIi//9bcov0LHH+WABnEDvJSxkw3MP/ZOaS600eD9TYr/VYC3fAQVvu7VlXrcTuZ5J58HlCxM9mol+mm15KqKF8FS3KlwH9O4htc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714655128; c=relaxed/simple;
	bh=24lhDhrKAOqjfxQn9uac6QTJAcaey1HgCcl8HaFLLV8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=us1xg5088myX9zHKbJ2g1KCaH33ZTUh2M8FSl1r4PnFp3GqXzCOFiYgXncsdnUM1d06SpKbkIudd7q2LNgNYMltd4aQ1ZWZSmypwz3buTVuCieBzByZXJoXsR9kQMJgMylpFjhCE8uU8rAi+2JWopKlrvmGI8mUVR8HLFD+xZ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUuICBZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5387CC32789;
	Thu,  2 May 2024 13:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714655127;
	bh=24lhDhrKAOqjfxQn9uac6QTJAcaey1HgCcl8HaFLLV8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=uUuICBZxZoRJ2T5E7+i0z1uoqU1iDOOYGEp3aKBvHqOyXQn//s575HJ7V7nMBiTXj
	 uwZkkGPyTJMRVqzO72riV04TJkb0vyZwvO5hDZV5toCxU4l+cTt0M2/sZToimHIeKE
	 cnHx3ReCk27nrQDWoBEMBFMcloouhnsPav4uZeESD1wTqPkcipv0VUE39vAT0Wq3fU
	 zRuCGr91QgRh4YUcripfcFiXBJo7VhuXBjSMDIRE3NXnVMPIXIE0pyPykN+sur8gSR
	 It5Sn7o6ba1x7oK4tWI0/5k9edigsAFYmM/niSXUSAbks2xELwUFER3uiQSMpwe6u8
	 d3fk5mVQagj8A==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Masahiro Yamada <masahiroy@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Nick
 Terrell <terrelln@fb.com>
Subject: Re: [PATCH v1 1/3] riscv: make image compression configurable
In-Reply-To: <20240502111613.1380453-2-emil.renner.berthing@canonical.com>
References: <20240502111613.1380453-1-emil.renner.berthing@canonical.com>
 <20240502111613.1380453-2-emil.renner.berthing@canonical.com>
Date: Thu, 02 May 2024 15:05:24 +0200
Message-ID: <87ttjgcqjv.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Emil Renner Berthing <emil.renner.berthing@canonical.com> writes:

> Previously the build process would always set KBUILD_IMAGE to the
> uncompressed Image file (unless XIP_KERNEL or EFI_ZBOOT was enabled) and
> unconditionally compress it into Image.gz. However there are already
> build targets for Image.bz2, Image.lz4, Image.lzma, Image.lzo and
> Image.zstd, so let's make use of those, make the compression method
> configurable and set KBUILD_IMAGE accordingly so that targets like
> 'make install' and 'make bindeb-pkg' will use the chosen image.
>
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> ---
>  arch/riscv/Kconfig         |  7 +++++++
>  arch/riscv/Makefile        | 43 ++++++++++++++++++++------------------
>  arch/riscv/boot/install.sh |  9 +++++---
>  3 files changed, 36 insertions(+), 23 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index be09c8836d56..6c092d1ea7db 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -138,6 +138,13 @@ config RISCV
>  	select HAVE_GCC_PLUGINS
>  	select HAVE_GENERIC_VDSO if MMU && 64BIT
>  	select HAVE_IRQ_TIME_ACCOUNTING
> +	select HAVE_KERNEL_BZIP2 if !XIP_KERNEL && !EFI_ZBOOT
> +	select HAVE_KERNEL_GZIP if !XIP_KERNEL && !EFI_ZBOOT
> +	select HAVE_KERNEL_LZ4 if !XIP_KERNEL && !EFI_ZBOOT
> +	select HAVE_KERNEL_LZMA if !XIP_KERNEL && !EFI_ZBOOT
> +	select HAVE_KERNEL_LZO if !XIP_KERNEL && !EFI_ZBOOT
> +	select HAVE_KERNEL_UNCOMPRESSED if !XIP_KERNEL && !EFI_ZBOOT
> +	select HAVE_KERNEL_ZSTD if !XIP_KERNEL && !EFI_ZBOOT
>  	select HAVE_KPROBES if !XIP_KERNEL
>  	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
>  	select HAVE_KRETPROBES if !XIP_KERNEL
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 5b3115a19852..29be676415d6 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -129,11 +129,27 @@ endif
>  CHECKFLAGS +=3D -D__riscv -D__riscv_xlen=3D$(BITS)
>=20=20
>  # Default target when executing plain make
> -boot		:=3D arch/riscv/boot
> +boot :=3D arch/riscv/boot
>  ifeq ($(CONFIG_XIP_KERNEL),y)
>  KBUILD_IMAGE :=3D $(boot)/xipImage
> +else ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_ARCH_CANAAN),yy)
> +KBUILD_IMAGE :=3D $(boot)/loader.bin
> +else ifeq ($(CONFIG_EFI_ZBOOT),y)
> +KBUILD_IMAGE :=3D $(boot)/vmlinuz.efi
> +else ifeq ($(CONFIG_KERNEL_GZIP),y)
> +KBUILD_IMAGE :=3D $(boot)/Image.gz
> +else ifeq ($(CONFIG_KERNEL_BZIP2),y)
> +KBUILD_IMAGE :=3D $(boot)/Image.bz2
> +else ifeq ($(CONFIG_KERNEL_LZ4),y)
> +KBUILD_IMAGE :=3D $(boot)/Image.lz4
> +else ifeq ($(CONFIG_KERNEL_LZMA),y)
> +KBUILD_IMAGE :=3D $(boot)/Image.lzma
> +else ifeq ($(CONFIG_KERNEL_LZO),y)
> +KBUILD_IMAGE :=3D $(boot)/Image.lzo
> +else ifeq ($(CONFIG_KERNEL_ZSTD),y)
> +KBUILD_IMAGE :=3D $(boot)/Image.zst
>  else
> -KBUILD_IMAGE	:=3D $(boot)/Image.gz
> +KBUILD_IMAGE :=3D $(boot)/Image
>  endif

Really a nit/change if you want, but maybe doing something like
arch/s390/boot/Makefile does is easier to read:

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 024482c68835..70f08e9999b4 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -128,6 +128,14 @@ endif
 # arch specific predefines for sparse
 CHECKFLAGS +=3D -D__riscv -D__riscv_xlen=3D$(BITS)
=20
+suffix-$(CONFIG_KERNEL_GZIP)  :=3D .gz
+suffix-$(CONFIG_KERNEL_BZIP2) :=3D .bz2
+suffix-$(CONFIG_KERNEL_LZ4)  :=3D .lz4
+suffix-$(CONFIG_KERNEL_LZMA)  :=3D .lzma
+suffix-$(CONFIG_KERNEL_LZO)  :=3D .lzo
+suffix-$(CONFIG_KERNEL_XZ)  :=3D .xz
+suffix-$(CONFIG_KERNEL_ZSTD)  :=3D .zst
+
 # Default target when executing plain make
 boot :=3D arch/riscv/boot
 ifeq ($(CONFIG_XIP_KERNEL),y)
@@ -136,20 +144,8 @@ else ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_ARCH_CANAAN)=
,yy)
 KBUILD_IMAGE :=3D $(boot)/loader.bin
 else ifeq ($(CONFIG_EFI_ZBOOT),y)
 KBUILD_IMAGE :=3D $(boot)/vmlinuz.efi
-else ifeq ($(CONFIG_KERNEL_GZIP),y)
-KBUILD_IMAGE :=3D $(boot)/Image.gz
-else ifeq ($(CONFIG_KERNEL_BZIP2),y)
-KBUILD_IMAGE :=3D $(boot)/Image.bz2
-else ifeq ($(CONFIG_KERNEL_LZ4),y)
-KBUILD_IMAGE :=3D $(boot)/Image.lz4
-else ifeq ($(CONFIG_KERNEL_LZMA),y)
-KBUILD_IMAGE :=3D $(boot)/Image.lzma
-else ifeq ($(CONFIG_KERNEL_LZO),y)
-KBUILD_IMAGE :=3D $(boot)/Image.lzo
-else ifeq ($(CONFIG_KERNEL_ZSTD),y)
-KBUILD_IMAGE :=3D $(boot)/Image.zst
 else
-KBUILD_IMAGE :=3D $(boot)/Image
+KBUILD_IMAGE :=3D $(boot)/Image$(suffix-y)
 endif



Bj=C3=B6rn

