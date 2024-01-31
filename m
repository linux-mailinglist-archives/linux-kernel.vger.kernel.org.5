Return-Path: <linux-kernel+bounces-46879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E55BD8445B8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F64F28252E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757CC12CD97;
	Wed, 31 Jan 2024 17:10:57 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B4E12C539
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721057; cv=none; b=sDgv7QxklcuvXXEnQ/yVkCx1d3tGtv9aRjWw2IoVwQ+gNHVLk10HSbX3RC9W3Tt8yJ6SL917CcpsQy7lx568ruhNO1AchEZS0LcZtwuCCNHPx/hXn+6HYosXwowJtupa6OwDc4fZ1CRtU2fUOZxZ82zJJLC9AYciXIbawXPiEXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721057; c=relaxed/simple;
	bh=vyqxsmT1sYLs8Lhco7xrp08oqpIsWPXEzBlZX7H94oY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F0+wLLi3FwyFoHzxCQ+aAuqkMW2zjDIyf6Fk8xEcdK3sOYLVNIaBrUFeVQximX7/3Xtvc1rla0VVL8+4qj9hdp0OlbNp2nyp140fN9gnxY9VNv7nmGPihTEpDSwybIFIGqC2NeDOqfBKCqjnFn6C6BMAT0hC/n/x8ng8SUsnW3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 739B2240006;
	Wed, 31 Jan 2024 17:10:48 +0000 (UTC)
Message-ID: <139cdbd6-73d9-4452-94ce-825689b7c0c8@ghiti.fr>
Date: Wed, 31 Jan 2024 18:10:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: add CALLER_ADDRx support
Content-Language: en-US
To: Zong Li <zong.li@sifive.com>, palmer@dabbelt.com,
 paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231205085959.32177-1-zong.li@sifive.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20231205085959.32177-1-zong.li@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

On 05/12/2023 09:59, Zong Li wrote:
> CALLER_ADDRx returns caller's address at specified level, they are used
> for several tracers. These macros eventually use
> __builtin_return_address(n) to get the caller's address if arch doesn't
> define their own implementation.
>
> In RISC-V, __builtin_return_address(n) only works when n == 0, we need
> to walk the stack frame to get the caller's address at specified level.


Is that a bug in gcc or something expected for riscv in general?


>
> data.level started from 'level + 3' due to the call flow of getting
> caller's address in RISC-V implementation. If we don't have additional
> three iteration, the level is corresponding to follows:
>
> callsite -> return_address -> arch_stack_walk -> walk_stackframe
> |           |                 |                  |
> level 3     level 2           level 1            level 0
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>   arch/riscv/include/asm/ftrace.h    |  5 ++++
>   arch/riscv/kernel/Makefile         |  2 ++
>   arch/riscv/kernel/return_address.c | 48 ++++++++++++++++++++++++++++++
>   3 files changed, 55 insertions(+)
>   create mode 100644 arch/riscv/kernel/return_address.c
>
> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
> index 2b2f5df7ef2c..42777f91a9c5 100644
> --- a/arch/riscv/include/asm/ftrace.h
> +++ b/arch/riscv/include/asm/ftrace.h
> @@ -25,6 +25,11 @@
>   
>   #define ARCH_SUPPORTS_FTRACE_OPS 1
>   #ifndef __ASSEMBLY__
> +
> +extern void *return_address(unsigned int level);
> +
> +#define ftrace_return_address(n) return_address(n)
> +
>   void MCOUNT_NAME(void);
>   static inline unsigned long ftrace_call_adjust(unsigned long addr)
>   {
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index fee22a3d1b53..40d054939ae2 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -7,6 +7,7 @@ ifdef CONFIG_FTRACE
>   CFLAGS_REMOVE_ftrace.o	= $(CC_FLAGS_FTRACE)
>   CFLAGS_REMOVE_patch.o	= $(CC_FLAGS_FTRACE)
>   CFLAGS_REMOVE_sbi.o	= $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_return_address.o	= $(CC_FLAGS_FTRACE)
>   endif
>   CFLAGS_syscall_table.o	+= $(call cc-option,-Wno-override-init,)
>   CFLAGS_compat_syscall_table.o += $(call cc-option,-Wno-override-init,)
> @@ -46,6 +47,7 @@ obj-y	+= irq.o
>   obj-y	+= process.o
>   obj-y	+= ptrace.o
>   obj-y	+= reset.o
> +obj-y	+= return_address.o
>   obj-y	+= setup.o
>   obj-y	+= signal.o
>   obj-y	+= syscall_table.o
> diff --git a/arch/riscv/kernel/return_address.c b/arch/riscv/kernel/return_address.c
> new file mode 100644
> index 000000000000..c2008d4aa6e5
> --- /dev/null
> +++ b/arch/riscv/kernel/return_address.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * This code come from arch/arm64/kernel/return_address.c
> + *
> + * Copyright (C) 2023 SiFive.
> + */
> +
> +#include <linux/export.h>
> +#include <linux/kprobes.h>
> +#include <linux/stacktrace.h>
> +
> +struct return_address_data {
> +	unsigned int level;
> +	void *addr;
> +};
> +
> +static bool save_return_addr(void *d, unsigned long pc)
> +{
> +	struct return_address_data *data = d;
> +
> +	if (!data->level) {
> +		data->addr = (void *)pc;
> +		return false;
> +	}
> +
> +	--data->level;
> +
> +	return true;
> +}
> +NOKPROBE_SYMBOL(save_return_addr);
> +
> +void *return_address(unsigned int level)


Maybe return_address() should be noinline to make sure it's not inlined 
as it would break the "+ 3"? Not sure it's necessary though.


> +{
> +	struct return_address_data data;
> +
> +	data.level = level + 3;
> +	data.addr = NULL;
> +
> +	arch_stack_walk(save_return_addr, &data, current, NULL);
> +
> +	if (!data.level)
> +		return data.addr;
> +	else
> +		return NULL;
> +
> +}
> +EXPORT_SYMBOL_GPL(return_address);
> +NOKPROBE_SYMBOL(return_address);


And I see that with this patch, ftrace_return_address() is now defined 
whether CONFIG_FRAME_POINTER is set or not, is that correct?

This looks like a fix to me so that should go into -fixes with a Fixes 
tag (but we'll have to make sure that the "+ 3" is correct on all 
backports...):

Fixes: 10626c32e382 ("riscv/ftrace: Add basic support")

And you can finally add for your v2 (or not if you don't respin):

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks and sorry for the delay!

Alex


