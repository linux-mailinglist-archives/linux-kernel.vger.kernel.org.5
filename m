Return-Path: <linux-kernel+bounces-46623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DA284421F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99CF1F2613C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597BB1DDCE;
	Wed, 31 Jan 2024 14:46:37 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F948287A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712396; cv=none; b=b5CoQxwAXgjY5kRz6CKz0yph2rrnXKQg5pgFFt4s6WNPbiINg7cedsiDvf/BmjQZsG4hF53Ax72lBky6X8AP59RqYe9AsgjDq0KxPagu/2PgABCexGNnGYKJSIzoOXrCGMsW66Hf7vRba0JnLlC4EqID6hZOKRazBp15e92BgUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712396; c=relaxed/simple;
	bh=xw/JEHipL3IdpaBrUlztJJRa6YI56n1PTV2RANvdiQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=s7JHDi+cMEqJYfPFIHx+vxSz/rwZs/VBThaoF3TcAlVpqGRQn1xK2VmDleD3xRx84L9Ub/y5cy6z43F7uFaFZoLxfBCBuAmRg2w4BQor7vkqtwHEV6FL60GZSdCSAf+tkx1oZf4FVIeXdLhNv+7Ie9wzgtCp9zv980d1yvwmzyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6CEA9E0003;
	Wed, 31 Jan 2024 14:46:28 +0000 (UTC)
Message-ID: <25e2faa5-908c-4391-87db-8540d1f0e904@ghiti.fr>
Date: Wed, 31 Jan 2024 15:46:27 +0100
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
 Palmer Dabbelt <palmer@rivosinc.com>, paul.walmsley@sifive.com,
 aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20231205085959.32177-1-zong.li@sifive.com>
 <CANXhq0r6A48q+ehayaURLO6snDEjzVJO6Ti+1we-57i0ORT9yg@mail.gmail.com>
 <CANXhq0qqv3MBEt8zsWBT+gkdyt1PD4ZjDSrznEotdFM7M7K+yQ@mail.gmail.com>
 <CANXhq0qNA5JO1xZLbuL6ig1Ddws0m2azMwCyqLFgN3B0VZmvEw@mail.gmail.com>
 <CANXhq0o-MaEQY3m+0CNWK2Jv_pxqsjhhSJWtVR396wgKUzcbQw@mail.gmail.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CANXhq0o-MaEQY3m+0CNWK2Jv_pxqsjhhSJWtVR396wgKUzcbQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Zong,

On 31/01/2024 15:24, Zong Li wrote:
> On Thu, Jan 18, 2024 at 8:50 AM Zong Li <zong.li@sifive.com> wrote:
>> On Wed, Jan 10, 2024 at 11:33 AM Zong Li <zong.li@sifive.com> wrote:
>>> On Fri, Dec 29, 2023 at 2:34 PM Zong Li <zong.li@sifive.com> wrote:
>>>> On Tue, Dec 5, 2023 at 5:00 PM Zong Li <zong.li@sifive.com> wrote:
>>>>> CALLER_ADDRx returns caller's address at specified level, they are used
>>>>> for several tracers. These macros eventually use
>>>>> __builtin_return_address(n) to get the caller's address if arch doesn't
>>>>> define their own implementation.
>>>>>
>>>>> In RISC-V, __builtin_return_address(n) only works when n == 0, we need
>>>>> to walk the stack frame to get the caller's address at specified level.
>>>>>
>>>>> data.level started from 'level + 3' due to the call flow of getting
>>>>> caller's address in RISC-V implementation. If we don't have additional
>>>>> three iteration, the level is corresponding to follows:
>>>>>
>>>>> callsite -> return_address -> arch_stack_walk -> walk_stackframe
>>>>> |           |                 |                  |
>>>>> level 3     level 2           level 1            level 0
>>>>>
>>>>> Signed-off-by: Zong Li <zong.li@sifive.com>
>>>>> ---
>>>>>   arch/riscv/include/asm/ftrace.h    |  5 ++++
>>>>>   arch/riscv/kernel/Makefile         |  2 ++
>>>>>   arch/riscv/kernel/return_address.c | 48 ++++++++++++++++++++++++++++++
>>>>>   3 files changed, 55 insertions(+)
>>>>>   create mode 100644 arch/riscv/kernel/return_address.c
>>>>>
>>>>> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
>>>>> index 2b2f5df7ef2c..42777f91a9c5 100644
>>>>> --- a/arch/riscv/include/asm/ftrace.h
>>>>> +++ b/arch/riscv/include/asm/ftrace.h
>>>>> @@ -25,6 +25,11 @@
>>>>>
>>>>>   #define ARCH_SUPPORTS_FTRACE_OPS 1
>>>>>   #ifndef __ASSEMBLY__
>>>>> +
>>>>> +extern void *return_address(unsigned int level);
>>>>> +
>>>>> +#define ftrace_return_address(n) return_address(n)
>>>>> +
>>>>>   void MCOUNT_NAME(void);
>>>>>   static inline unsigned long ftrace_call_adjust(unsigned long addr)
>>>>>   {
>>>>> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
>>>>> index fee22a3d1b53..40d054939ae2 100644
>>>>> --- a/arch/riscv/kernel/Makefile
>>>>> +++ b/arch/riscv/kernel/Makefile
>>>>> @@ -7,6 +7,7 @@ ifdef CONFIG_FTRACE
>>>>>   CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
>>>>>   CFLAGS_REMOVE_patch.o  = $(CC_FLAGS_FTRACE)
>>>>>   CFLAGS_REMOVE_sbi.o    = $(CC_FLAGS_FTRACE)
>>>>> +CFLAGS_REMOVE_return_address.o = $(CC_FLAGS_FTRACE)
>>>>>   endif
>>>>>   CFLAGS_syscall_table.o += $(call cc-option,-Wno-override-init,)
>>>>>   CFLAGS_compat_syscall_table.o += $(call cc-option,-Wno-override-init,)
>>>>> @@ -46,6 +47,7 @@ obj-y += irq.o
>>>>>   obj-y  += process.o
>>>>>   obj-y  += ptrace.o
>>>>>   obj-y  += reset.o
>>>>> +obj-y  += return_address.o
>>>>>   obj-y  += setup.o
>>>>>   obj-y  += signal.o
>>>>>   obj-y  += syscall_table.o
>>>>> diff --git a/arch/riscv/kernel/return_address.c b/arch/riscv/kernel/return_address.c
>>>>> new file mode 100644
>>>>> index 000000000000..c2008d4aa6e5
>>>>> --- /dev/null
>>>>> +++ b/arch/riscv/kernel/return_address.c
>>>>> @@ -0,0 +1,48 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>>> +/*
>>>>> + * This code come from arch/arm64/kernel/return_address.c
>>>>> + *
>>>>> + * Copyright (C) 2023 SiFive.
>>>>> + */
>>>>> +
>>>>> +#include <linux/export.h>
>>>>> +#include <linux/kprobes.h>
>>>>> +#include <linux/stacktrace.h>
>>>>> +
>>>>> +struct return_address_data {
>>>>> +       unsigned int level;
>>>>> +       void *addr;
>>>>> +};
>>>>> +
>>>>> +static bool save_return_addr(void *d, unsigned long pc)
>>>>> +{
>>>>> +       struct return_address_data *data = d;
>>>>> +
>>>>> +       if (!data->level) {
>>>>> +               data->addr = (void *)pc;
>>>>> +               return false;
>>>>> +       }
>>>>> +
>>>>> +       --data->level;
>>>>> +
>>>>> +       return true;
>>>>> +}
>>>>> +NOKPROBE_SYMBOL(save_return_addr);
>>>>> +
>>>>> +void *return_address(unsigned int level)
>>>>> +{
>>>>> +       struct return_address_data data;
>>>>> +
>>>>> +       data.level = level + 3;
>>>>> +       data.addr = NULL;
>>>>> +
>>>>> +       arch_stack_walk(save_return_addr, &data, current, NULL);
>>>>> +
>>>>> +       if (!data.level)
>>>>> +               return data.addr;
>>>>> +       else
>>>>> +               return NULL;
>>>>> +
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(return_address);
>>>>> +NOKPROBE_SYMBOL(return_address);
>>>>> --
>>>>> 2.17.1
>>>>>
>>>> Hi Palmer and all,
>>>> I was wondering whether this patch is good for everyone? Thanks
>>> Hi Palmer,
>>> Is there any chance to include this patch in 6.8-rc1? Thanks
>> Hi Palmer,
>> I'm not sure if this patch is a feature or bug fix, would you consider
>> it for 6.8-rcX? Thanks
> Hi Palmer,
> Sorry for pinging you again. I'm not sure if you saw this patch. The
> irqsoff and wakeup tracer will use CALLER_ADDR1 and CALLER_ADDR2 to
> obtain the caller's return address, but we are currently encountering
> an issue in the RISC-V port where the wrong caller is identified. I
> guess you can easily reproduce the situation using ftrace. Could you
> share your thoughts on this when you have the time to take a look?
> Thanks


I'm not Palmer but I'll take a look at your patch today :)

Thanks,

Alex


>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

