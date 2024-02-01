Return-Path: <linux-kernel+bounces-47938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA188454DB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9DDC1F23547
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53939157E8C;
	Thu,  1 Feb 2024 10:07:57 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAE34D9E7
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706782076; cv=none; b=drYipehoR2LkHeWp43cDrgNV7xEoJlILOj+b33SiHuIPiaWfoZQ67VxdtFi6gXtGcmGat6y1QbGJEqgQGTbfJ8caQ1CkI+3NB6xSUVtZ8Df7EJZtiM0FaZwzWPgrLXAlBj+1k5uo1pNjljfpSc1KdstKyfTXbvmBovL91jIUX90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706782076; c=relaxed/simple;
	bh=H3NlgKMwCfq774/B0cUI4gDakYJQeaoj9l7F/QS62HE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFqUJ1sgqV1kGuYSKoQc6CDOUsGHrMEz0Lmjt/cAhEl0jPYnpnkIxVsIcNsFZKI4zvjAxRxhkVzd4460ev26L37h75x3UJrdBdGVGOdJpchw72cHIhsgjFkFKarhBg1VWRVTdd8V7eBMxnp6k1Q1W5DCdw7GuSRtv2m1lrWOt+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5B34E24000C;
	Thu,  1 Feb 2024 10:07:49 +0000 (UTC)
Message-ID: <4bf64df4-43a4-4207-b7d5-ff07adb98193@ghiti.fr>
Date: Thu, 1 Feb 2024 11:07:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: add CALLER_ADDRx support
Content-Language: en-US
To: Zong Li <zong.li@sifive.com>, Conor Dooley <conor.dooley@microchip.com>
Cc: palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231205085959.32177-1-zong.li@sifive.com>
 <139cdbd6-73d9-4452-94ce-825689b7c0c8@ghiti.fr>
 <CANXhq0oA7LsKev+5gZCtNzCJ64RVOyimM1yQnY0kqs22VE6S4A@mail.gmail.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CANXhq0oA7LsKev+5gZCtNzCJ64RVOyimM1yQnY0kqs22VE6S4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

On 01/02/2024 09:43, Zong Li wrote:
> On Thu, Feb 1, 2024 at 1:10 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>> On 05/12/2023 09:59, Zong Li wrote:
>>> CALLER_ADDRx returns caller's address at specified level, they are used
>>> for several tracers. These macros eventually use
>>> __builtin_return_address(n) to get the caller's address if arch doesn't
>>> define their own implementation.
>>>
>>> In RISC-V, __builtin_return_address(n) only works when n == 0, we need
>>> to walk the stack frame to get the caller's address at specified level.
>>
>> Is that a bug in gcc or something expected for riscv in general?
>>
> I think it isn't supported for riscv in general.
>
>>> data.level started from 'level + 3' due to the call flow of getting
>>> caller's address in RISC-V implementation. If we don't have additional
>>> three iteration, the level is corresponding to follows:
>>>
>>> callsite -> return_address -> arch_stack_walk -> walk_stackframe
>>> |           |                 |                  |
>>> level 3     level 2           level 1            level 0
>>>
>>> Signed-off-by: Zong Li <zong.li@sifive.com>
>>> ---
>>>    arch/riscv/include/asm/ftrace.h    |  5 ++++
>>>    arch/riscv/kernel/Makefile         |  2 ++
>>>    arch/riscv/kernel/return_address.c | 48 ++++++++++++++++++++++++++++++
>>>    3 files changed, 55 insertions(+)
>>>    create mode 100644 arch/riscv/kernel/return_address.c
>>>
>>> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
>>> index 2b2f5df7ef2c..42777f91a9c5 100644
>>> --- a/arch/riscv/include/asm/ftrace.h
>>> +++ b/arch/riscv/include/asm/ftrace.h
>>> @@ -25,6 +25,11 @@
>>>
>>>    #define ARCH_SUPPORTS_FTRACE_OPS 1
>>>    #ifndef __ASSEMBLY__
>>> +
>>> +extern void *return_address(unsigned int level);
>>> +
>>> +#define ftrace_return_address(n) return_address(n)
>>> +
>>>    void MCOUNT_NAME(void);
>>>    static inline unsigned long ftrace_call_adjust(unsigned long addr)
>>>    {
>>> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
>>> index fee22a3d1b53..40d054939ae2 100644
>>> --- a/arch/riscv/kernel/Makefile
>>> +++ b/arch/riscv/kernel/Makefile
>>> @@ -7,6 +7,7 @@ ifdef CONFIG_FTRACE
>>>    CFLAGS_REMOVE_ftrace.o      = $(CC_FLAGS_FTRACE)
>>>    CFLAGS_REMOVE_patch.o       = $(CC_FLAGS_FTRACE)
>>>    CFLAGS_REMOVE_sbi.o = $(CC_FLAGS_FTRACE)
>>> +CFLAGS_REMOVE_return_address.o       = $(CC_FLAGS_FTRACE)
>>>    endif
>>>    CFLAGS_syscall_table.o      += $(call cc-option,-Wno-override-init,)
>>>    CFLAGS_compat_syscall_table.o += $(call cc-option,-Wno-override-init,)
>>> @@ -46,6 +47,7 @@ obj-y       += irq.o
>>>    obj-y       += process.o
>>>    obj-y       += ptrace.o
>>>    obj-y       += reset.o
>>> +obj-y        += return_address.o
>>>    obj-y       += setup.o
>>>    obj-y       += signal.o
>>>    obj-y       += syscall_table.o
>>> diff --git a/arch/riscv/kernel/return_address.c b/arch/riscv/kernel/return_address.c
>>> new file mode 100644
>>> index 000000000000..c2008d4aa6e5
>>> --- /dev/null
>>> +++ b/arch/riscv/kernel/return_address.c
>>> @@ -0,0 +1,48 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * This code come from arch/arm64/kernel/return_address.c
>>> + *
>>> + * Copyright (C) 2023 SiFive.
>>> + */
>>> +
>>> +#include <linux/export.h>
>>> +#include <linux/kprobes.h>
>>> +#include <linux/stacktrace.h>
>>> +
>>> +struct return_address_data {
>>> +     unsigned int level;
>>> +     void *addr;
>>> +};
>>> +
>>> +static bool save_return_addr(void *d, unsigned long pc)
>>> +{
>>> +     struct return_address_data *data = d;
>>> +
>>> +     if (!data->level) {
>>> +             data->addr = (void *)pc;
>>> +             return false;
>>> +     }
>>> +
>>> +     --data->level;
>>> +
>>> +     return true;
>>> +}
>>> +NOKPROBE_SYMBOL(save_return_addr);
>>> +
>>> +void *return_address(unsigned int level)
>>
>> Maybe return_address() should be noinline to make sure it's not inlined
>> as it would break the "+ 3"? Not sure it's necessary though.
> Yes, thanks for pointing it out. We should ensure it's not inlined in
> any case. I will send the next version.
>
>>
>>> +{
>>> +     struct return_address_data data;
>>> +
>>> +     data.level = level + 3;
>>> +     data.addr = NULL;
>>> +
>>> +     arch_stack_walk(save_return_addr, &data, current, NULL);
>>> +
>>> +     if (!data.level)
>>> +             return data.addr;
>>> +     else
>>> +             return NULL;
>>> +
>>> +}
>>> +EXPORT_SYMBOL_GPL(return_address);
>>> +NOKPROBE_SYMBOL(return_address);
>>
>> And I see that with this patch, ftrace_return_address() is now defined
>> whether CONFIG_FRAME_POINTER is set or not, is that correct?
> Yes, that is what I understand. In this patch, the
> ftrace_return_address() is still defined to return_address() when
> CONFIG_FRAME_POINTER isn't enabled, and return_address still works
> because riscv port can walk stackframe without fp.
>
>> This looks like a fix to me so that should go into -fixes with a Fixes
>> tag (but we'll have to make sure that the "+ 3" is correct on all
>> backports...):
>>
>> Fixes: 10626c32e382 ("riscv/ftrace: Add basic support")
> The return_address() invokes arch_stack_walk(), which enabled by the
> '5cb0080f1bfd ("riscv: Enable ARCH_STACKWALK")'
>
> I guess that we are not able to apply it on all backports. Is this
> right? "+3" is correct after enabling ARCH_STACKWALK.


5cb0080f1bfd was introduced in v5.11, so that will make the backport possible up to 5.15, I guess that's ok, nobody will ever use a riscv kernel that old (?).

So I'd add the Fixes tag I proposed above, and let the backport fail for < 5.15. @Conor any opinion?


>
>> And you can finally add for your v2 (or not if you don't respin):
>>
>> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Thanks for the review, Alexandre. I will add it in v2:)


Thanks,

Alex


>
>> Thanks and sorry for the delay!
>>
>> Alex
>>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

