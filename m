Return-Path: <linux-kernel+bounces-93001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CD3872938
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB8F280A64
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3631212B14F;
	Tue,  5 Mar 2024 21:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="s56OoF7+"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C68512A16C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 21:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709673358; cv=none; b=JeUBA8SfB/hA4r/xdEXFsVUqRQoopWRgtTCWYazTveImUiSBHLePMbHOr/t1XYMMCGUlf0KrqZnrUztvfO+1GFKpqZVm3ThJ3xkwyV3vJHrAthhypfDFk1geLyOyHya/dnsy2vkRgUlH+t8/P0L4ta/BJvG43gl/9jMlnOneRgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709673358; c=relaxed/simple;
	bh=ZuScJ0/saHnBjH4miHUWT5lm4D1ofxQSgaGoXeYoHnU=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=ACwdAiibRYKtru8HAhfjc6HKqjyKeu541tmv2daySdZfVe+irT6P/00w2BRlMez7v85VXeah/AlqHDN3GKA9cY6I6w2kEy+wlp+HTeEjpPrKuZrCINmYUOiZv3pHbhXsDPa+Rqfu+NCK2FgCrjakOI//naiAxqq73P1DlVNaeVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=s56OoF7+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc49afb495so2307015ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 13:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1709673355; x=1710278155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fiBn8FM4g6SLp0BGLWgmHRyv4STvpdqrSJ1Zy2Fii/A=;
        b=s56OoF7+hQxbDFF7KPE56L55q3UoHNnPxcZp96qNe1c/l3hflUx0mLQXDE/xaak58J
         jCacJXenYpVkSjnAYffoLs5/lw5JRXJNj5nwGv95rr9rUf/RURf7zlKfvVzwOXxKqWcb
         QiW6sOQiPWvmoNGdzEE29zkvZELHh147yRGZ1rHICx55Gi+GvcGKm2XoyBqNmsI8R4Yl
         hUE2k5vrtXpTlxLD4M18KP4Sdj4V00otq0zOrkyhOd0KcatcbGjCAH0q1sAomcbXHp4t
         +FSdbxRmZj8y16L/hwCmEL37u2hYiCneEjnxUv+DYQoXWwGhwPwqKJmMKSjAWxPNvJCM
         7p5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709673355; x=1710278155;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiBn8FM4g6SLp0BGLWgmHRyv4STvpdqrSJ1Zy2Fii/A=;
        b=gXzW939fKdN2Z3fxxhyUMAibG6KEOFjDobBEdGyEXTxt/6qhJjlIdD28HC3z+xRRaL
         FMvwl4Hir+tBcTRKDN8nA8h1OkAU87TuZ9hK0xQdmh/P7ciHH8WpZRMlQ/wY2uj1TOFE
         HkeSSDK74Ku5TfOHuHq59D0l/zzPiBIF8NChO2imnf/960FXU6Gq/Ubm3Dtt71wqOjNS
         i4rStx10iz13ifq4Jl2L8/n6Kn6V4k+RadHe3QKZ+po9x3/49RyDbckFSIWQCeTMdx6+
         rV2ndWZ3tNb6NVj0r7bPXl+7DTO3pJ0j1fVIaqhXRMd37Waw8fS0IGrV8B5DxRK028LN
         eSrA==
X-Forwarded-Encrypted: i=1; AJvYcCUt5H61zex44IQFIfk+eDrTftsuqhh5ayK27D23NbXb+lo8v28ZGEUMG33fPpLsgqIGtzYhO2BuCFjs3SUhGXfWg52oCYOguchgEfn0
X-Gm-Message-State: AOJu0YyT7Jb7DKiBQT0Ll0ASS9uXFWal+59MaQwPhKagRy0lViW9q4T2
	qukOycSNA/K+LpYOhTzy50kxYR+E2FxuX1b8X9e4M5zdTDtLCtKfEvLh8CiaaBU=
X-Google-Smtp-Source: AGHT+IHh5G0L+3SfyyNdkveVZXtvX8KU042f9OgNbdPuwmamHBWHlAkygbRToiaIR/tqbjsFPbVIXA==
X-Received: by 2002:a17:902:ecd2:b0:1db:f696:b09 with SMTP id a18-20020a170902ecd200b001dbf6960b09mr3603069plh.14.1709673355319;
        Tue, 05 Mar 2024 13:15:55 -0800 (PST)
Received: from localhost ([50.213.54.97])
        by smtp.gmail.com with ESMTPSA id y5-20020a170902ed4500b001dbb06b6133sm11021831plb.127.2024.03.05.13.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 13:15:54 -0800 (PST)
Date: Tue, 05 Mar 2024 13:15:54 -0800 (PST)
X-Google-Original-Date: Tue, 05 Mar 2024 13:15:53 PST (-0800)
Subject:     Re: [PATCH v3] riscv: dts: Move BUILTIN_DTB_SOURCE to common Kconfig
In-Reply-To: <tencent_88FEE0A2C5E0852436A2F1A1087E6803380A@qq.com>
CC: linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>,
  aou@eecs.berkeley.edu, Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org,
  masahiroy@kernel.org, alex@ghiti.fr, robh+dt@kernel.org, devicetree@vger.kernel.org,
  cyy@cyyself.name, Conor Dooley <conor.dooley@microchip.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: cyy@cyyself.name
Message-ID: <mhng-5b86ee53-13eb-45b0-9b41-641224de3f3b@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 28 Feb 2024 00:52:54 PST (-0800), cyy@cyyself.name wrote:
> The BUILTIN_DTB_SOURCE was only configured for K210 before. Since
> SOC_BUILTIN_DTB_DECLARE was removed at commit d5805af9fe9f ("riscv: Fix
> builtin DTB handling") from patch [1], the kernel cannot choose one of the
> dtbs from then on and always take the first one dtb to use. Then, another
> commit 0ddd7eaffa64 ("riscv: Fix BUILTIN_DTB for sifive and microchip soc")
> from patch [2] supports BUILTIN_DTB_SOURCE for other SoCs. However, this
> feature will only work if the Kconfig we use links the dtb we expected in
> the first place as mentioned in the thread [3]. Thus, a config
> BUILTIN_DTB_SOURCE is needed for all SoCs to choose one dtb to use.
>
> For some considerations, this patch also removes default y if XIP_KERNEL
> for BUILTIN_DTB, as this requires setting a proper dtb to use on the
> BUILTIN_DTB_SOURCE, else the kernel with XIP but does not set
> BUILTIN_DTB_SOURCE or unselect BUILTIN_DTB will not boot.
>
> Also, this patch removes the default dtb string for k210 from Kconfig to
> nommu_k210_defconfig and nommu_k210_sdcard_defconfig to avoid complex
> Kconfig settings for other SoCs in the future.
>
> [1] https://lore.kernel.org/linux-riscv/20201208073355.40828-5-damien.lemoal@wdc.com/
> [2] https://lore.kernel.org/linux-riscv/20210604120639.1447869-1-alex@ghiti.fr/
> [3] https://lore.kernel.org/linux-riscv/CAK7LNATt_56mO2Le4v4EnPnAfd3gC8S_Sm5-GCsfa=qXy=8Lrg@mail.gmail.com/
>
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

> ---
> Changes since v2:
> - some fixes on format and grammar
> - v2: https://lore.kernel.org/linux-riscv/tencent_61DFA8E0B13696A3256E538C4BC856633406@qq.com/
>
> Changes since v1:
> - remove default y for BULTIN_DTB in any cases
> - remove default DTB_SOURCE for k210 and moved to its defconfig file
> - remove building dtb object file for other SoCs
> - reword help message to say N if unsure for BUILTIN_DTB_SOURCE
> - reword commit message
> - v1: https://lore.kernel.org/linux-riscv/tencent_AB625442CC1BCFF86E04D7B5891C43719109@qq.com/
>
> ---
>  arch/riscv/Kconfig                            | 14 +++++++-
>  arch/riscv/Kconfig.socs                       | 32 -------------------
>  arch/riscv/boot/dts/Makefile                  |  2 +-
>  arch/riscv/boot/dts/canaan/Makefile           |  2 --
>  arch/riscv/boot/dts/microchip/Makefile        |  1 -
>  arch/riscv/boot/dts/sifive/Makefile           |  1 -
>  arch/riscv/configs/nommu_k210_defconfig       |  2 ++
>  .../riscv/configs/nommu_k210_sdcard_defconfig |  2 ++
>  8 files changed, 18 insertions(+), 38 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 85c899d0133a..3d6d93d71257 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -1000,7 +1000,19 @@ config RISCV_ISA_FALLBACK
>  config BUILTIN_DTB
>  	bool "Built-in device tree"
>  	depends on OF && NONPORTABLE
> -	default y if XIP_KERNEL
> +	help
> +	  Build a device tree into the Linux image.
> +	  This option should be selected if no bootloader is being used.
> +	  If unsure, say N.
> +
> +
> +config BUILTIN_DTB_SOURCE
> +	string "Built-in device tree source"
> +	depends on BUILTIN_DTB
> +	help
> +	  DTS file path (without suffix, relative to arch/riscv/boot/dts)
> +	  for the DTS file that will be used to produce the DTB linked into the
> +	  kernel.
>
>  endmenu # "Boot options"
>
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index e08e91c49abe..623de5f8a208 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -84,36 +84,4 @@ config SOC_CANAAN
>  	help
>  	  This enables support for Canaan Kendryte K210 SoC platform hardware.
>
> -if ARCH_CANAAN
> -
> -config ARCH_CANAAN_K210_DTB_BUILTIN
> -	def_bool SOC_CANAAN_K210_DTB_BUILTIN
> -
> -config SOC_CANAAN_K210_DTB_BUILTIN
> -	bool "Builtin device tree for the Canaan Kendryte K210"
> -	depends on ARCH_CANAAN
> -	default y
> -	select OF
> -	select BUILTIN_DTB
> -	help
> -	  Build a device tree for the Kendryte K210 into the Linux image.
> -	  This option should be selected if no bootloader is being used.
> -	  If unsure, say Y.
> -
> -config ARCH_CANAAN_K210_DTB_SOURCE
> -	string
> -	default SOC_CANAAN_K210_DTB_SOURCE
> -
> -config SOC_CANAAN_K210_DTB_SOURCE
> -	string "Source file for the Canaan Kendryte K210 builtin DTB"
> -	depends on ARCH_CANAAN
> -	depends on ARCH_CANAAN_K210_DTB_BUILTIN
> -	default "k210_generic"
> -	help
> -	  Base name (without suffix, relative to arch/riscv/boot/dts/canaan)
> -	  for the DTS file that will be used to produce the DTB linked into the
> -	  kernel.
> -
> -endif # ARCH_CANAAN
> -
>  endmenu # "SoC selection"
> diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> index 72030fd727af..fdae05bbf556 100644
> --- a/arch/riscv/boot/dts/Makefile
> +++ b/arch/riscv/boot/dts/Makefile
> @@ -8,4 +8,4 @@ subdir-y += sophgo
>  subdir-y += starfive
>  subdir-y += thead
>
> -obj-$(CONFIG_BUILTIN_DTB) := $(addsuffix /, $(subdir-y))
> +obj-$(CONFIG_BUILTIN_DTB) := $(addsuffix .dtb.o, $(CONFIG_BUILTIN_DTB_SOURCE))
> diff --git a/arch/riscv/boot/dts/canaan/Makefile b/arch/riscv/boot/dts/canaan/Makefile
> index 520623264c87..987d1f0c41f0 100644
> --- a/arch/riscv/boot/dts/canaan/Makefile
> +++ b/arch/riscv/boot/dts/canaan/Makefile
> @@ -5,5 +5,3 @@ dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maix_bit.dtb
>  dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maix_dock.dtb
>  dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maix_go.dtb
>  dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maixduino.dtb
> -
> -obj-$(CONFIG_ARCH_CANAAN_K210_DTB_BUILTIN) += $(addsuffix .dtb.o, $(CONFIG_ARCH_CANAAN_K210_DTB_SOURCE))
> diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/boot/dts/microchip/Makefile
> index 45adc4926e79..e177815bf1a2 100644
> --- a/arch/riscv/boot/dts/microchip/Makefile
> +++ b/arch/riscv/boot/dts/microchip/Makefile
> @@ -4,4 +4,3 @@ dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-m100pfsevp.dtb
>  dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-polarberry.dtb
>  dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-sev-kit.dtb
>  dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-tysom-m.dtb
> -obj-$(CONFIG_BUILTIN_DTB) += $(addsuffix .o, $(dtb-y))
> diff --git a/arch/riscv/boot/dts/sifive/Makefile b/arch/riscv/boot/dts/sifive/Makefile
> index 6a5fbd4ed96a..495bf760a909 100644
> --- a/arch/riscv/boot/dts/sifive/Makefile
> +++ b/arch/riscv/boot/dts/sifive/Makefile
> @@ -1,4 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_SIFIVE) += hifive-unleashed-a00.dtb \
>  			     hifive-unmatched-a00.dtb
> -obj-$(CONFIG_BUILTIN_DTB) += $(addsuffix .o, $(dtb-y))
> diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
> index 146c46d0525b..7e75200543f4 100644
> --- a/arch/riscv/configs/nommu_k210_defconfig
> +++ b/arch/riscv/configs/nommu_k210_defconfig
> @@ -33,6 +33,8 @@ CONFIG_SMP=y
>  CONFIG_NR_CPUS=2
>  CONFIG_CMDLINE="earlycon console=ttySIF0"
>  CONFIG_CMDLINE_FORCE=y
> +CONFIG_BUILTIN_DTB=y
> +CONFIG_BUILTIN_DTB_SOURCE="canaan/k210_generic"
>  # CONFIG_SECCOMP is not set
>  # CONFIG_STACKPROTECTOR is not set
>  # CONFIG_GCC_PLUGINS is not set
> diff --git a/arch/riscv/configs/nommu_k210_sdcard_defconfig b/arch/riscv/configs/nommu_k210_sdcard_defconfig
> index 95d8d1808f19..0ba353e9ca71 100644
> --- a/arch/riscv/configs/nommu_k210_sdcard_defconfig
> +++ b/arch/riscv/configs/nommu_k210_sdcard_defconfig
> @@ -25,6 +25,8 @@ CONFIG_SMP=y
>  CONFIG_NR_CPUS=2
>  CONFIG_CMDLINE="earlycon console=ttySIF0 root=/dev/mmcblk0p1 rootwait ro"
>  CONFIG_CMDLINE_FORCE=y
> +CONFIG_BUILTIN_DTB=y
> +CONFIG_BUILTIN_DTB_SOURCE="canaan/k210_generic"
>  # CONFIG_SECCOMP is not set
>  # CONFIG_STACKPROTECTOR is not set
>  # CONFIG_GCC_PLUGINS is not set

