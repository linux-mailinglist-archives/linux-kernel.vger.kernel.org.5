Return-Path: <linux-kernel+bounces-104283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F0D87CB9A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18205283204
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E1918EB8;
	Fri, 15 Mar 2024 10:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoCOqhGq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E0017C6A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710499624; cv=none; b=A7dK7Fiv9mX0PpNaVGoSoWd6JagtFRvVHWcb8PHnpxsA3VpqgqikuA6MCkbOsp0dnNBfQkcqVpbpgZE5Jv2NN4opdVYY8AOcefZZxqTclRkstW2fTcoHWL5cy0IpT5eN5/rjzZNMdCdQSh9mEuE+W41/hijTjTr7wTPyDVg+GBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710499624; c=relaxed/simple;
	bh=aF07u09fRtr70SoY4xn4mBQ+dJ4fFyp3A36TqPhhyQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ua/1XmGorH87YHw6Oz1d5xv7JOo6TJ3dbUrLpB38uHTXkQnrssfeQ+pC/VepdWispMkM7u81p0YwKyugrV9yAQ3BbNoEHPjTJr5EqiPrMlg00kpUYDrAu00CrkbNbOJ2ZZvNVakEQLmr9q8i2ZAQdv/i1FmO/daO8+fGYmEUIEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoCOqhGq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6668BC43143
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710499624;
	bh=aF07u09fRtr70SoY4xn4mBQ+dJ4fFyp3A36TqPhhyQM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hoCOqhGqWZRx25FwmWujyu/NAxsfp6aoXU/83siNfJWttYMO+U1iAs+sPrwjnyfUp
	 Rh+53VUNm4x4aO/f/Vl3mb+H+qly354evdwYBDtnVvf7QqrClbq0q2YHgYO8JWMmuP
	 IE7Enq418H/AQq7IzrfGf57I0/0suxLhCoYPQsY7phl/uzvsNM76StsL9GVScB5f0W
	 tbUCU4czhx5pEZgrzmHu4RZotISPxreXj0vzLShohSBqerY43XuX5CUQ6ifF7lysNQ
	 3NX7rZcgFtnaGN8vrJ4iSmY6PonxEmatKxJckq/3nUWWQNegL79AopO0kRdt/cPWDc
	 gGxrTunFKl69A==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513d717269fso1011352e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 03:47:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXi9RZUZUDFhn0sS2yLCezTDmhRG0r9D7Opnff4nrFKSKFavPrmMNOgG9hlXvuPjQnbKDaS5VrRUVx5UGMQAsGvVwYo8NenzEDpey2y
X-Gm-Message-State: AOJu0YwwNBmsfqvdf/zaieXD6/MDoi69yPtzr1yQ4MDPMtwnEKuRzFoP
	O4b2KMFMGtYcEdoHYfyhD0IpkAhTITSK6az2+XYAKIj4ubuHveN2ISx2tEiy1I2bUhdpk3Up5fb
	enANrdl4MwuDSy73NtRN7HUhwwEg=
X-Google-Smtp-Source: AGHT+IHFrtinN1g79Mgqdz+HhZVUkQtcozUNc5rCImZnAn8Xf37obOcRYCuDlCJhOYHUV8iZDq9agcYxerFfh7w5zIM=
X-Received: by 2002:ac2:5387:0:b0:513:c7c7:8799 with SMTP id
 g7-20020ac25387000000b00513c7c78799mr1856929lfh.58.1710499622568; Fri, 15 Mar
 2024 03:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315063154.696633-1-liuyuntao12@huawei.com>
 <CAMj1kXH+FaddHV5--kqB_wVgw_M682MvchPB1BoCuDuA6vVyvg@mail.gmail.com> <d7a1996f-f558-4cea-b8ca-eb071d02c6d4@huawei.com>
In-Reply-To: <d7a1996f-f558-4cea-b8ca-eb071d02c6d4@huawei.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 15 Mar 2024 11:46:51 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHP-M7hTsCmorgzvDiPB1jRXHciJrXjJR82zmkxUTD-5Q@mail.gmail.com>
Message-ID: <CAMj1kXHP-M7hTsCmorgzvDiPB1jRXHciJrXjJR82zmkxUTD-5Q@mail.gmail.com>
Subject: Re: [PATCH-next v3] arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
To: "liuyuntao (F)" <liuyuntao12@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	arnd@arndb.de, geert@linux-m68k.org, linux@armlinux.org.uk, afd@ti.com, 
	akpm@linux-foundation.org, kirill.shutemov@linux.intel.com, 
	geert+renesas@glider.be, corbet@lwn.net, rppt@kernel.org, robh@kernel.org, 
	tglx@linutronix.de, linus.walleij@linaro.org, maskray@google.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Mar 2024 at 11:23, liuyuntao (F) <liuyuntao12@huawei.com> wrote:
>
>
>
> On 2024/3/15 16:06, Ard Biesheuvel wrote:
> > On Fri, 15 Mar 2024 at 07:37, Yuntao Liu <liuyuntao12@huawei.com> wrote:
> >>
> >> The current arm32 architecture does not yet support the
> >> HAVE_LD_DEAD_CODE_DATA_ELIMINATION feature. arm32 is widely used in
> >> embedded scenarios, and enabling this feature would be beneficial for
> >> reducing the size of the kernel image.
> >>
> >> In order to make this work, we keep the necessary tables by annotating
> >> them with KEEP, also it requires further changes to linker script to KEEP
> >> some tables and wildcard compiler generated sections into the right place.
> >> When using ld.lld for linking, the KEEP keyword is not recognized within
> >> the OVERLAY command, Ard proposed a concise method to solve this problem.
> >>
> >> It boots normally with defconfig, vexpress_defconfig and tinyconfig.
> >> The size comparison of zImage is as follows:
> >> defconfig       vexpress_defconfig      tinyconfig
> >> 5137712         5138024                 424192          no dce
> >> 5032560         4997824                 298384          dce
> >> 2.0%            2.7%                    29.7%           shrink
> >>
> >> When using smaller config file, there is a significant reduction in the
> >> size of the zImage.
> >>
> >> We also tested this patch on a commercially available single-board
> >> computer, and the comparison is as follows:
> >> a15eb_config
> >> 2161384         no dce
> >> 2092240         dce
> >> 3.2%            shrink
> >>
> >> The zImage size has been reduced by approximately 3.2%, which is 70KB on
> >> 2.1M.
> >>
> >> Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
> >> Tested-by: Arnd Bergmann <arnd@arndb.de>
> >> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >> v3:
> >>     - A better way to KEEP .vectors section for ld.lld linking.
> >>
> >> v2:
> >>     - Support config XIP_KERNEL.
> >>     - Support LLVM compilation.
> >>     - https://lore.kernel.org/all/20240307151231.654025-1-liuyuntao12@huawei.com/
> >>
> >> v1: https://lore.kernel.org/all/20240220081527.23408-1-liuyuntao12@huawei.com/
> >> ---
> >>   arch/arm/Kconfig                       | 1 +
> >>   arch/arm/boot/compressed/vmlinux.lds.S | 6 +++++-
> >>   arch/arm/include/asm/vmlinux.lds.h     | 2 +-
> >>   arch/arm/kernel/entry-armv.S           | 3 +++
> >>   arch/arm/kernel/vmlinux-xip.lds.S      | 4 ++--
> >>   arch/arm/kernel/vmlinux.lds.S          | 6 +++---
> >>   6 files changed, 15 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >> index b14aed3a17ab..45f25f6e7a62 100644
> >> --- a/arch/arm/Kconfig
> >> +++ b/arch/arm/Kconfig
> >> @@ -114,6 +114,7 @@ config ARM
> >>          select HAVE_KERNEL_XZ
> >>          select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V7M
> >>          select HAVE_KRETPROBES if HAVE_KPROBES
> >> +       select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
> >>          select HAVE_MOD_ARCH_SPECIFIC
> >>          select HAVE_NMI
> >>          select HAVE_OPTPROBES if !THUMB2_KERNEL
> >> diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
> >> index 3fcb3e62dc56..affd30714f01 100644
> >> --- a/arch/arm/boot/compressed/vmlinux.lds.S
> >> +++ b/arch/arm/boot/compressed/vmlinux.lds.S
> >> @@ -89,7 +89,11 @@ SECTIONS
> >>        * The EFI stub always executes from RAM, and runs strictly before the
> >>        * decompressor, so we can make an exception for its r/w data, and keep it
> >>        */
> >> +#ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
> >> +    *(.data.* .bss.*)
> >> +#else
> >>       *(.data.efistub .bss.efistub)
> >> +#endif
> >>       __pecoff_data_end = .;
> >>
> >
> > This is still not right.
> >
> > Can you just add -fno-data-sections to cflags-$(CONFIG_ARM) in
> > drivers/firmware/efi/libstub/Makefile?
> >
>
> I rebuild kernel in such way:
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -28,6 +28,7 @@ cflags-$(CONFIG_ARM)          += -DEFI_HAVE_STRLEN
> -DEFI_HAVE_STRNLEN \
>                                     -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
>                                     -DEFI_HAVE_STRCMP -fno-builtin -fpic \
>                                     $(call cc-option,-mno-single-pic-base)
> +cflags-$(CONFIG_ARM)           += -fno-data-sections
>   cflags-$(CONFIG_RISCV)         += -fpic -DNO_ALTERNATIVE -mno-relax
>   cflags-$(CONFIG_LOONGARCH)     += -fpi
> but I am still encountering this error:
> arm-linux-gnueabi-ld: warning: orphan section `.data.efi_loglevel' from
> `drivers/firmware/efi/libstub/printk.stub.o' being placed in section
> `.data.efi_loglevel'
> arm-linux-gnueabi-ld: warning: orphan section `.data.screen_info_guid'
> from `drivers/firmware/efi/libstub/screen_info.stub.o' being placed in
> section `.data.screen_info_guid'
> arm-linux-gnueabi-ld: warning: orphan section `.data.cpu_state_guid'
> from `drivers/firmware/efi/libstub/arm32-stub.stub.o' being placed in
> section `.data.cpu_state_guid'
> arm-linux-gnueabi-ld: warning: orphan section `.data.efi_nokaslr' from
> `drivers/firmware/efi/libstub/efi-stub-helper.stub.o' being placed in
> section `.data.efi_nokaslr'
> arm-linux-gnueabi-ld: error: zImage file size is incorrect
>
> I am puzzled because I could not find any option named
> -fno-data-sections for GCC.
>

How about

--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -28,6 +28,7 @@
                                   -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
                                   -DEFI_HAVE_STRCMP -fno-builtin -fpic \
                                   $(call cc-option,-mno-single-pic-base)
+cflags-$(CONFIG_ARM)           := $(filter-out -fdata-sections, $(CFLAGS-y))
 cflags-$(CONFIG_RISCV)         += -fpic -DNO_ALTERNATIVE -mno-relax
 cflags-$(CONFIG_LOONGARCH)     += -fpie

