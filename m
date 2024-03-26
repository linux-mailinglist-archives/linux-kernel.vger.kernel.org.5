Return-Path: <linux-kernel+bounces-118343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9F988B8CD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 04:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCB361F6130E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8361D53C;
	Tue, 26 Mar 2024 03:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MLndGXGq"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4ED128823
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 03:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711424371; cv=none; b=OfwyTt5pTxsLdZg7hDmX56hIU9NfxDHB9coM2g92ffv9fotoUYKwxQrBYV7R1MdfiSY+6gQVLUfRkc8i+Umrta9ATyBCL/WOfvzBG9QeCiEUel7ZlktyoXXEi1HE7FfQ1eqFBTg3goKCzaCmiumHxxVtfwftwm38tHKg2yvU6Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711424371; c=relaxed/simple;
	bh=EL8G8P64MVs0BFg7McQfgLvudXCUf7q2MzfvqN983QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3dnG/pNaZ8IEptovNLHFrcOcfgSMllAovRjRdpqTkwgwwvOV+Mdt+5cvVfQoCVkObxIk8R8Z8yGr4T1QlDgoXrSmp4QN/dxMbScyqnXl1lY7dkxvaajt1+MiDomFvFqeMFicrFOtGFGBJShp9cD+5ioWHEavsX2CP1KhXSwWAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=MLndGXGq; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3668fd6952bso18853935ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711424368; x=1712029168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D6bLchK7FanVwmzKAdf5NEkt7B3LWZhc9CY4a9DgDRc=;
        b=MLndGXGqL1ao10RC7H46X4fn2zXU9daHcvz025wGo8V40s+5waoRFEjMC7yUOGfMlZ
         4NAaZ4VD6xbFz7VijN/n13E81iL98Nj7aYPICSJLTVa23G6NPdwX023v6gIO6GTd/JxJ
         yKvllmjp26MVyiSRuPA9xQEf/v7+PW+nExZhrVevl+dS2dLLLkAUdVHhX8eVaSEXIKmR
         Ef6bdxYBy9RQMBRNMi9jPysDVvyjEIx/MXcCYCFOX+kONzhgNlZCd6L2x5AxRdGcjTKC
         ZNMpuZrUAYPEWw9zFct2pJ+fQi8NiC21eLb6SKwK68ZcptC7WXpna3kfhFzYiN8YYlu1
         Y1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711424368; x=1712029168;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D6bLchK7FanVwmzKAdf5NEkt7B3LWZhc9CY4a9DgDRc=;
        b=P9KkUtpakA0bN1c/+B5UrN/sP1sX4dnB61SlNKkcumCAyiTZXi3JQX6uQsJaZix8eO
         mB7EA9KA1f+quo6J9qduFi2Zbg7kEOYXu4GY7k9vqn18g/0pxKsCWcGLrE6lQoOo+GwT
         9OuuEo8trVx7sYF5OvCjg6vDRyeA33Rhamhn8Z8yTOJCMrnpLYaTKZYfCWbTuIo1B3RT
         nWxiDjOwdyR827NvctnOBpYvXqkIk9LGUfGy+nYIRryjMhMA27dOzN/foAYC6VitbCSE
         X7hFOoA8Nb3fSnZD+oMNN1ZcRyB00JQC9JLvVKYo3cBk1zCgOvgwG9Pe6e5CBj4aPmop
         dsAA==
X-Forwarded-Encrypted: i=1; AJvYcCX5pCTy7+tC9/deOeiWhQCJmdHPIEzScQv4MBIRIdfP8iarG8+H+rL+mXnWnaINYmsx/j1h2HR1defeSR/0qGgkIM4g7IKfwmOQyCkr
X-Gm-Message-State: AOJu0Yx3wgwH4m8KgV4V5FJgTHrDC/52entq0/9ocJ9ya52L+Rfv/B1g
	nFcP82kxdp1vxwZHfcutQsconPoE8ehvWGqC7iJVon941U1uUCHpLgAPJu32nRU=
X-Google-Smtp-Source: AGHT+IHcxCCflYYKst3pOgf9M9cr4SzUmNpnXAY12jijiHAEzbjhLFEbLhz2vqSUcfjyydO9vBXgjg==
X-Received: by 2002:a92:cb47:0:b0:366:ad4a:4b80 with SMTP id f7-20020a92cb47000000b00366ad4a4b80mr9033207ilq.3.1711424368446;
        Mon, 25 Mar 2024 20:39:28 -0700 (PDT)
Received: from [100.64.0.1] ([136.226.86.189])
        by smtp.gmail.com with ESMTPSA id a11-20020a92a30b000000b003685e4a2b5asm2697759ili.82.2024.03.25.20.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 20:39:28 -0700 (PDT)
Message-ID: <49976c4d-b171-4c08-b05f-94b9a897151b@sifive.com>
Date: Mon, 25 Mar 2024 22:39:27 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: Add tracepoints for SBI calls and returns
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 Andrew Jones <ajones@ventanamicro.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, linux-kernel@vger.kernel.org
References: <20240321230131.1838105-1-samuel.holland@sifive.com>
 <CAHVXubgez9NCE1XTu6WvumuMOsNeWyDMvze44w4f8kCMG2-X5g@mail.gmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <CAHVXubgez9NCE1XTu6WvumuMOsNeWyDMvze44w4f8kCMG2-X5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Alex,

On 2024-03-22 4:27 AM, Alexandre Ghiti wrote:
> On Fri, Mar 22, 2024 at 12:01 AM Samuel Holland
> <samuel.holland@sifive.com> wrote:
>>
>> These are useful for measuring the latency of SBI calls. The SBI HSM
>> extension is excluded because those functions are called from contexts
>> such as cpuidle where instrumentation is not allowed.
>>
>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>>
>> Changes in v2:
>>  - Remove some blank lines
>>
>>  arch/riscv/include/asm/trace.h | 54 ++++++++++++++++++++++++++++++++++
>>  arch/riscv/kernel/sbi.c        |  7 +++++
>>  2 files changed, 61 insertions(+)
>>  create mode 100644 arch/riscv/include/asm/trace.h
>>
>> diff --git a/arch/riscv/include/asm/trace.h b/arch/riscv/include/asm/trace.h
>> new file mode 100644
>> index 000000000000..6151cee5450c
>> --- /dev/null
>> +++ b/arch/riscv/include/asm/trace.h
>> @@ -0,0 +1,54 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM riscv
>> +
>> +#if !defined(_TRACE_RISCV_H) || defined(TRACE_HEADER_MULTI_READ)
>> +#define _TRACE_RISCV_H
>> +
>> +#include <linux/tracepoint.h>
>> +
>> +TRACE_EVENT_CONDITION(sbi_call,
>> +       TP_PROTO(int ext, int fid),
>> +       TP_ARGS(ext, fid),
>> +       TP_CONDITION(ext != SBI_EXT_HSM),
>> +
>> +       TP_STRUCT__entry(
>> +               __field(int, ext)
>> +               __field(int, fid)
>> +       ),
>> +
>> +       TP_fast_assign(
>> +               __entry->ext = ext;
>> +               __entry->fid = fid;
>> +       ),
>> +
>> +       TP_printk("ext=0x%x fid=%d", __entry->ext, __entry->fid)
>> +);
>> +
>> +TRACE_EVENT_CONDITION(sbi_return,
>> +       TP_PROTO(int ext, long error, long value),
>> +       TP_ARGS(ext, error, value),
>> +       TP_CONDITION(ext != SBI_EXT_HSM),
>> +
>> +       TP_STRUCT__entry(
>> +               __field(long, error)
>> +               __field(long, value)
>> +       ),
>> +
>> +       TP_fast_assign(
>> +               __entry->error = error;
>> +               __entry->value = value;
>> +       ),
>> +
>> +       TP_printk("error=%ld value=0x%lx", __entry->error, __entry->value)
>> +);
>> +
>> +#endif /* _TRACE_RISCV_H */
>> +
>> +#undef TRACE_INCLUDE_PATH
>> +#undef TRACE_INCLUDE_FILE
>> +
>> +#define TRACE_INCLUDE_PATH asm
>> +#define TRACE_INCLUDE_FILE trace
>> +
>> +#include <trace/define_trace.h>
>> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
>> index e66e0999a800..a1d21d8f5293 100644
>> --- a/arch/riscv/kernel/sbi.c
>> +++ b/arch/riscv/kernel/sbi.c
>> @@ -14,6 +14,9 @@
>>  #include <asm/smp.h>
>>  #include <asm/tlbflush.h>
>>
>> +#define CREATE_TRACE_POINTS
>> +#include <asm/trace.h>
>> +
>>  /* default SBI version is 0.1 */
>>  unsigned long sbi_spec_version __ro_after_init = SBI_SPEC_VERSION_DEFAULT;
>>  EXPORT_SYMBOL(sbi_spec_version);
>> @@ -31,6 +34,8 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>>  {
>>         struct sbiret ret;
>>
>> +       trace_sbi_call(ext, fid);
>> +
>>         register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);
>>         register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);
>>         register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);
>> @@ -46,6 +51,8 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>>         ret.error = a0;
>>         ret.value = a1;
>>
>> +       trace_sbi_return(ext, ret.error, ret.value);
>> +
>>         return ret;
>>  }
>>  EXPORT_SYMBOL(sbi_ecall);
>> --
>> 2.43.1
>>
> 
> sbi_ecall() is used by flush_icache_all() so I was a bit scared we
> would need to patch 2 instructions using a tracepoint and then to use
> flush_icache_all() which could bug if only one of the patched
> instruction was seen. But I took a look at the disassembled code, and
> tracepoints happen to only need to patch 1 nop into an unconditional
> jump, which is not a problem then.

Right, tracepoints use the static branch infrastructure, which uses a single
instruction.

> But then when disassembling, I noticed that the addition of the
> tracepoint comes with "quite" some overhead:
> 
> Before:
> 
> Dump of assembler code for function sbi_ecall:
>    0xffffffff800085e0 <+0>: add sp,sp,-32
>    0xffffffff800085e2 <+2>: sd s0,24(sp)
>    0xffffffff800085e4 <+4>: mv t1,a0
>    0xffffffff800085e6 <+6>: add s0,sp,32
>    0xffffffff800085e8 <+8>: mv t3,a1
>    0xffffffff800085ea <+10>: mv a0,a2
>    0xffffffff800085ec <+12>: mv a1,a3
>    0xffffffff800085ee <+14>: mv a2,a4
>    0xffffffff800085f0 <+16>: mv a3,a5
>    0xffffffff800085f2 <+18>: mv a4,a6
>    0xffffffff800085f4 <+20>: mv a5,a7
>    0xffffffff800085f6 <+22>: mv a6,t3
>    0xffffffff800085f8 <+24>: mv a7,t1
>    0xffffffff800085fa <+26>: ecall
>    0xffffffff800085fe <+30>: ld s0,24(sp)
>    0xffffffff80008600 <+32>: add sp,sp,32
>    0xffffffff80008602 <+34>: ret
> 
> After:
> 
> Dump of assembler code for function sbi_ecall:
>    0xffffffff8000bbf2 <+0>: add sp,sp,-112
>    0xffffffff8000bbf4 <+2>: sd s0,96(sp)
>    0xffffffff8000bbf6 <+4>: sd s1,88(sp)
>    0xffffffff8000bbf8 <+6>: sd s3,72(sp)
>    0xffffffff8000bbfa <+8>: sd s4,64(sp)
>    0xffffffff8000bbfc <+10>: sd s5,56(sp)
>    0xffffffff8000bbfe <+12>: sd s6,48(sp)
>    0xffffffff8000bc00 <+14>: sd s7,40(sp)
>    0xffffffff8000bc02 <+16>: sd s8,32(sp)
>    0xffffffff8000bc04 <+18>: sd s9,24(sp)
>    0xffffffff8000bc06 <+20>: sd ra,104(sp)
>    0xffffffff8000bc08 <+22>: sd s2,80(sp)
>    0xffffffff8000bc0a <+24>: add s0,sp,112
>    0xffffffff8000bc0c <+26>: mv s1,a0
>    0xffffffff8000bc0e <+28>: mv s3,a1
>    0xffffffff8000bc10 <+30>: mv s9,a2
>    0xffffffff8000bc12 <+32>: mv s8,a3
>    0xffffffff8000bc14 <+34>: mv s7,a4
>    0xffffffff8000bc16 <+36>: mv s6,a5
>    0xffffffff8000bc18 <+38>: mv s5,a6
>    0xffffffff8000bc1a <+40>: mv s4,a7
>    0xffffffff8000bc1c <+42>: nop
>    0xffffffff8000bc20 <+46>: mv a0,s9
>    0xffffffff8000bc22 <+48>: mv a1,s8
>    0xffffffff8000bc24 <+50>: mv a2,s7
>    0xffffffff8000bc26 <+52>: mv a3,s6
>    0xffffffff8000bc28 <+54>: mv a4,s5
>    0xffffffff8000bc2a <+56>: mv a5,s4
>    0xffffffff8000bc2c <+58>: mv a6,s3
>    0xffffffff8000bc2e <+60>: mv a7,s1
>    0xffffffff8000bc30 <+62>: ecall
>    0xffffffff8000bc34 <+66>: mv s4,a0
>    0xffffffff8000bc36 <+68>: mv s3,a1
>    0xffffffff8000bc38 <+70>: nop
>    0xffffffff8000bc3c <+74>: ld ra,104(sp)
>    0xffffffff8000bc3e <+76>: ld s0,96(sp)
>    0xffffffff8000bc40 <+78>: ld s1,88(sp)
>    0xffffffff8000bc42 <+80>: ld s2,80(sp)
>    0xffffffff8000bc44 <+82>: ld s5,56(sp)
>    0xffffffff8000bc46 <+84>: ld s6,48(sp)
>    0xffffffff8000bc48 <+86>: ld s7,40(sp)
>    0xffffffff8000bc4a <+88>: ld s8,32(sp)
>    0xffffffff8000bc4c <+90>: ld s9,24(sp)
>    0xffffffff8000bc4e <+92>: mv a0,s4
>    0xffffffff8000bc50 <+94>: mv a1,s3
>    0xffffffff8000bc52 <+96>: ld s4,64(sp)
>    0xffffffff8000bc54 <+98>: ld s3,72(sp)
>    0xffffffff8000bc56 <+100>: add sp,sp,112
>    0xffffffff8000bc58 <+102>: ret
> 
> Not sure this is really problematic though, let me know what you think.

The overhead is only incurred when tracepoints are enabled. But when they are
enabled, I do not think it is avoidable, unless we were to hide this tracepoint
behind some Kconfig option. I don't think the overhead enough to be a problem,
but I suppose it's up to maintainer judgement.

Regards,
Samuel


