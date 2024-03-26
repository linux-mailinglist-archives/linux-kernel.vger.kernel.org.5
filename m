Return-Path: <linux-kernel+bounces-119838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A47588CD90
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D09B91F6210E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0AE13D272;
	Tue, 26 Mar 2024 19:52:23 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E8E13D258
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711482742; cv=none; b=RykxMRMM90xpaFB8DMVi4k7PXNNlQ6JEKdOpXkfSyV6F6swW3oKszf3f1h0X9UCOryT6TS9okCuTbyZX0QqtcDHa0czX+1P1gqWEQauZr4S0x+Kz+7m+erLofwbP1WXibNSTzYItLzAkmL5gTYbAFf7zMfWj+UF1Z3pL1JtVxJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711482742; c=relaxed/simple;
	bh=6s3IBjP+qBmimLtSS8MdyqdC4aiAyVCcFMCeaaXT0hI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=irgGZU8FANvOzC7BfjkzKZOb0sohHS8TztspdrkILBJuBDqgX4ylfYp3AXgmTkjNBkF/QMPEW2Mzw8iLyqrPN6G6XJ1j3UugiLLfEuV8iJhlDp82fObMN//AU1hW8UR7a/z7CPyx4vFf7b3f3qLPoZC6nvDLWRHMED+Ha5zKrN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 58212240005;
	Tue, 26 Mar 2024 19:52:15 +0000 (UTC)
Message-ID: <13eb7c38-68da-4635-a713-5791d5294df2@ghiti.fr>
Date: Tue, 26 Mar 2024 20:52:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: merge two if-blocks for KBUILD_IMAGE
Content-Language: en-US
To: Masahiro Yamada <masahiroy@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
References: <20240323113500.1249272-1-masahiroy@kernel.org>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240323113500.1249272-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Masahiro,

On 23/03/2024 12:35, Masahiro Yamada wrote:
> In arch/riscv/Makefile, KBUILD_IMAGE is assigned in two separate
> if-blocks.
>
> When CONFIG_XIP_KERNEL is disabled, the decision made by the first
> if-block is overwritten by the second one, which is redundant and
> unreadable.
>
> Merge the two if-blocks.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>   arch/riscv/Makefile | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 252d63942f34..a74e70405d3f 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -133,7 +133,15 @@ boot		:= arch/riscv/boot
>   ifeq ($(CONFIG_XIP_KERNEL),y)
>   KBUILD_IMAGE := $(boot)/xipImage
>   else
> +ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_ARCH_CANAAN),yy)
> +KBUILD_IMAGE := $(boot)/loader.bin
> +else
> +ifeq ($(CONFIG_EFI_ZBOOT),)
>   KBUILD_IMAGE	:= $(boot)/Image.gz
> +else
> +KBUILD_IMAGE := $(boot)/vmlinuz.efi
> +endif
> +endif
>   endif
>   
>   libs-y += arch/riscv/lib/
> @@ -153,17 +161,6 @@ endif
>   vdso-install-y			+= arch/riscv/kernel/vdso/vdso.so.dbg
>   vdso-install-$(CONFIG_COMPAT)	+= arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg:../compat_vdso/compat_vdso.so
>   
> -ifneq ($(CONFIG_XIP_KERNEL),y)
> -ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_ARCH_CANAAN),yy)
> -KBUILD_IMAGE := $(boot)/loader.bin
> -else
> -ifeq ($(CONFIG_EFI_ZBOOT),)
> -KBUILD_IMAGE := $(boot)/Image.gz
> -else
> -KBUILD_IMAGE := $(boot)/vmlinuz.efi
> -endif
> -endif
> -endif
>   BOOT_TARGETS := Image Image.gz loader loader.bin xipImage vmlinuz.efi
>   
>   all:	$(notdir $(KBUILD_IMAGE))


You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


