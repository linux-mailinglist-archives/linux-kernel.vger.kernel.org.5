Return-Path: <linux-kernel+bounces-117125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EB988A798
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2141D1C602FC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6350C16D31C;
	Mon, 25 Mar 2024 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="da/oDJKC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8100C16D32F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372694; cv=none; b=VpbvbYozMP0XwXx060932DcugQWgssLJ0F0ZG4p2s24cFQHsnSMzjjUpeH7IpEDJm/IASXO8KmPu5AddTvQjqYBEtFOmdV8a9Ipg22GoovuEe5h3Gy7sNwH7tAg1EeOHotMkYd+jV+xQX6B6xbHoWxtY4szgJeRaa7A0ZmCjOrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372694; c=relaxed/simple;
	bh=ny+/lmW+s523HLVgxuU52GFTaccOdrXZFGeAMu3G6Ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLpz8Is6TYREyF0VvyK7rrxSXzeEhwZNenfXf3zx7yzPYBv5OgoO/jaFoMYsQxSXyil1RY9uhZaQSbquhUBj2JWHQDXp+BiCHoMuqCTaS9UOdK66Zd130rvAkbR+CnCMRiSpWAmvUZ7fZsUdPRq+78ol2h4fjZIHty+MR2rz8nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=da/oDJKC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711372690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hZ4xCnKVV4H4Bbt4l6fsZyT3yFsKLmY8H1MMMB/lRws=;
	b=da/oDJKC5cGXQzFVBkoe/XBxsphN+ySGleHQlDGNcTU0s1dUjRCrOZCK5NLcF/KYhDqdSY
	mjaGMf58lEwkfc9CKhg7T5mQhXZTgDnl/+aE+Z3LmGQwZ6O2Nv5Fuch2yEuRJ37JuJPyp4
	1GfsPP/b7KCxorcDo4k46yUC9IVhmpk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-8AS86pm7OHW2AVQX4QxadA-1; Mon, 25 Mar 2024 09:18:05 -0400
X-MC-Unique: 8AS86pm7OHW2AVQX4QxadA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-515ab42c302so777488e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 06:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372683; x=1711977483;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hZ4xCnKVV4H4Bbt4l6fsZyT3yFsKLmY8H1MMMB/lRws=;
        b=dc4MxlmhtzD12jYu1qx3fuK+plUZSOQe6WTbVfv/23XpAuu7np3uJa9mzaIogZnmg8
         oJ97a6413VOsyJ0/9ZUJzUJd9MRcUSztbCP9lOrZwmFa7DEC0pX2iQmV0F/a1M/lcEco
         IDXQnyQmBP+SaRnt5PpjkhmGK3XN6pPWRA5GUhspq9UgWo8NcOm5+azCLGMJes7CC15Z
         4IV57jUr71EP83VShR6IlZ7CvOHShxr0U3b5KJUjTP7yp9glvbBqvgCZAWd8UJECnxVa
         vjpqFPfzNBSDB35FtsCumS999dwsUg0IXSJjTwexZG78reJAvrFxvT+SYOcDkkChBCoJ
         aCnw==
X-Gm-Message-State: AOJu0YwnM/LvrRcGD+o8Mhb2OcVsf6mI1tx16aMQWqBEwnG175Gzn5N0
	QLVwnNpgaiEH5AjlwL/nEs2u8dduzlqmXD8hIVAhdgiquOsK9zHmH6MTOLy8TK+ZiqWtoZIZe6y
	5FfKr1mB8EXbwTJcU8kc5gfsAmpwiRoNHjQYviRT5aGaHgGXexTNEGl2gmDCV3S9vA68S4Q==
X-Received: by 2002:ac2:59c1:0:b0:515:9ae2:93b0 with SMTP id x1-20020ac259c1000000b005159ae293b0mr4227890lfn.19.1711372683514;
        Mon, 25 Mar 2024 06:18:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSTinL2X+dxfG8jdn+IUJTGE3MpMt3TOI7hbbtPSSC0L5vDKdUAa8nk2uzJ5dzrPgTMyJBRw==
X-Received: by 2002:ac2:59c1:0:b0:515:9ae2:93b0 with SMTP id x1-20020ac259c1000000b005159ae293b0mr4227879lfn.19.1711372683143;
        Mon, 25 Mar 2024 06:18:03 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id dt12-20020a170906b78c00b00a473a0f3384sm3067842ejb.16.2024.03.25.06.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 06:18:02 -0700 (PDT)
Message-ID: <5b32b8c8-0a1b-44cf-aedf-cca1d6c83bd8@redhat.com>
Date: Mon, 25 Mar 2024 14:18:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/efistub: Add missing boot_params for mixed mode
 compat entry
Content-Language: en-US, nl
To: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Clayton Craft <clayton@craftyguy.net>
References: <20240325083905.13163-2-ardb+git@google.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240325083905.13163-2-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/25/24 9:39 AM, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The native EFI stub entry point does not take a struct boot_params from
> the boot loader, but creates it from scratch, and populates only the
> fields that still have meaning in this context (command line, initrd
> base and size, etc)
> 
> The original mixed mode implementation used the EFI handover protocol,
> where the boot loader (i.e., GRUB) populates a struct boot_params and
> passes it to a special EFI entry point that takes the struct boot_params
> pointer as the third argument.
> 
> When the new mixed mode implementation was introduced, using a special
> 32-bit PE entrypoint in the 64-bit kernel, it adopted the usual
> prototype, and relied on the EFI stub to create the struct boot_params
> as usual. This is preferred because it makes the bootloader side much
> easier to implement, as it does not need any x86-specific knowledge on
> how struct boot_params and struct setup_header are put together.
> 
> However, one thing was missed: EFI mixed mode goes through startup_32()
> *before* entering the 64-bit EFI stub, which is difficult to avoid given
> that 64-bit execution requires page tables, which can only be populated
> using 32-bit code, and this piece is what the mixed mode EFI stub relies
> on. startup_32() accesses a couple of struct boot_params fields to
> decide where to place the page tables.
> 
> startup_32() turns out to be quite tolerant to bogus struct boot_params,
> given that ESI used to contain junk when entering via the new mixed mode
> protocol. Only when commit
> 
>   e2ab9eab324c ("x86/boot/compressed: Move 32-bit entrypoint code into .text section")
> 
> started to zero ESI explicitly when entering via this boot path, boot
> failures started to appear on some systems, presumably ones that unmap
> page 0x0 or map it read-only.
> 
> The solution is to pass a special, temporary struct boot_params to
> startup_32() via ESI, one that is sufficient for getting it to create
> the page tables correctly and is discarded right after. This means
> setting a minimal alignment of 4k, only to get the statically allocated
> page tables line up correctly, and setting init_size to the executable
> image size (_end - startup_32). This ensures that the page tables are
> covered by the static footprint of the PE image.
> 
> Given that EFI boot no longer calls the decompressor and no longer pads
> the image to permit the decompressor to execute in place, the same
> temporary struct boot_params should be used in the EFI handover protocol
> based mixed mode implementation as well, to prevent the page tables from
> being placed outside of allocated memory.
> 
> Cc: Hans de Goede <hdegoede@redhat.com>
> Fixes: e2ab9eab324c ("x86/boot/compressed: Move 32-bit entrypoint code into .text section")
> Closes: https://lore.kernel.org/all/20240321150510.GI8211@craftyguy.net/
> Reported-by: Clayton Craft <clayton@craftyguy.net>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

I have given this a test run (on top of 6.9-rc1) on one of my
Bay Trail mixed mode tablets and the tablet still boots fine:

Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  arch/x86/boot/compressed/efi_mixed.S | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
> index 07873f269b7b..c7c108c0bcf0 100644
> --- a/arch/x86/boot/compressed/efi_mixed.S
> +++ b/arch/x86/boot/compressed/efi_mixed.S
> @@ -15,10 +15,12 @@
>   */
>  
>  #include <linux/linkage.h>
> +#include <asm/asm-offsets.h>
>  #include <asm/msr.h>
>  #include <asm/page_types.h>
>  #include <asm/processor-flags.h>
>  #include <asm/segment.h>
> +#include <asm/setup.h>
>  
>  	.code64
>  	.text
> @@ -155,6 +157,7 @@ SYM_FUNC_END(__efi64_thunk)
>  SYM_FUNC_START(efi32_stub_entry)
>  	call	1f
>  1:	popl	%ecx
> +	leal	(efi32_boot_args - 1b)(%ecx), %ebx
>  
>  	/* Clear BSS */
>  	xorl	%eax, %eax
> @@ -169,6 +172,7 @@ SYM_FUNC_START(efi32_stub_entry)
>  	popl	%ecx
>  	popl	%edx
>  	popl	%esi
> +	movl	%esi, 8(%ebx)
>  	jmp	efi32_entry
>  SYM_FUNC_END(efi32_stub_entry)
>  #endif
> @@ -245,8 +249,6 @@ SYM_FUNC_END(efi_enter32)
>   *
>   * Arguments:	%ecx	image handle
>   * 		%edx	EFI system table pointer
> - *		%esi	struct bootparams pointer (or NULL when not using
> - *			the EFI handover protocol)
>   *
>   * Since this is the point of no return for ordinary execution, no registers
>   * are considered live except for the function parameters. [Note that the EFI
> @@ -272,9 +274,18 @@ SYM_FUNC_START_LOCAL(efi32_entry)
>  	leal	(efi32_boot_args - 1b)(%ebx), %ebx
>  	movl	%ecx, 0(%ebx)
>  	movl	%edx, 4(%ebx)
> -	movl	%esi, 8(%ebx)
>  	movb	$0x0, 12(%ebx)          // efi_is64
>  
> +	/*
> +	 * Allocate some memory for a temporary struct boot_params, which only
> +	 * needs the minimal pieces that will get us through startup_32().
> +	 */
> +	subl	$PARAM_SIZE, %esp
> +	movl	%esp, %esi
> +	movl	$PAGE_SIZE, BP_kernel_alignment(%esi)
> +	movl	$_end - 1b, BP_init_size(%esi)
> +	subl	$startup_32 - 1b, BP_init_size(%esi)
> +
>  	/* Disable paging */
>  	movl	%cr0, %eax
>  	btrl	$X86_CR0_PG_BIT, %eax
> @@ -300,8 +311,7 @@ SYM_FUNC_START(efi32_pe_entry)
>  
>  	movl	8(%ebp), %ecx			// image_handle
>  	movl	12(%ebp), %edx			// sys_table
> -	xorl	%esi, %esi
> -	jmp	efi32_entry			// pass %ecx, %edx, %esi
> +	jmp	efi32_entry			// pass %ecx, %edx
>  						// no other registers remain live
>  
>  2:	popl	%edi				// restore callee-save registers


