Return-Path: <linux-kernel+bounces-117803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BFE88AFB5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1DF31F675D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9748168A8;
	Mon, 25 Mar 2024 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JdtwoMPw"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDB1134B6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394450; cv=none; b=RdyDR53vxOnug4jBbzQ9yB1m/U+weR2qBJMgAI0nLhpcvoJU/93JEnNkx/6pgdkuVWhBColqWM89uf2X5tpAKNoGkdE53H6+hTYnbLTtrwUhauBMQonH7axQqpgaQj0tphEWnPSxa3BSK1QM8NhsfSECbgyXPRY4GP2FQxTNVj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394450; c=relaxed/simple;
	bh=wLFkOCGASg5q0HXPd8AmjzvxhLR2hmPLfVfM1Dt9m+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lXoC3VStqs1Vb23kjkn0HUibKXdesEYU8VCvaye+xAYAr7+G+Zt/YwU8DJ9O1GLQMC1I/Fs/biaHjMavZ8SmNTYEnePJCo3uNU1QtPznWnpdwfxyc+hDW6f9JYBHPJZjo+wQWRjzS6EFhsUKmemxw0906mQDjwR4xvTRkXyctbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=JdtwoMPw; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7d0486cf91aso75164939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711394448; x=1711999248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sv+dTeEhRx84ZTiMETbHHNzVA6gJg2UXSOcI57+q+UU=;
        b=JdtwoMPwdvu/IMeTI9qOrAA4SjFVMGfo1PMg9Z0EF2I2xNXsyWTOwsJgICLr+GdCXV
         WqmHvwNNdVU/ZhPNU4u14s/F+OXwMlSwIE2lZeUizZmI89IkBP6IKLfLepjqVN+f4c9n
         Uo/aMka8q5ejQPAeHl5zLUMxGC5YPFUcJ11YwUanjOh1MU8juq/lzGXO3Dtlmq8EbtdT
         XgGOTitEfm9UW7VOHZ85nThGp8XoB+TdovGf91T65J3Lg686/9UcnHzBxMu/BAEX2NQA
         S+7GOFBc6PpZLRqpnkUd+st0YdtJhyMgJeN3hJxqAlAspR9BCVzDE263icC1lvHHJnLB
         lNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711394448; x=1711999248;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sv+dTeEhRx84ZTiMETbHHNzVA6gJg2UXSOcI57+q+UU=;
        b=QHwiGazJWwz8xs/kVzTPxS7vq6pPX3Z96OiVFwN8T0rnNgqqdF5KEQlhBJL9oLud9a
         RaCDiCixJXhC4KiXs5qhjz5hV8CnmBEgvuoMET7dTOMIOR+fvovmDOmqjNW2uKkPg8Y1
         d40W8mo9loXfXQHAwIAr9xnWF749tTaNtxzc2FNho8Lkb8lQVQHLiq9j8pNCAbLUoqsx
         a5gymMJdFVKimcwx8zmvFcnN/eNT3Qa/FivAouzD3xModVHRRttBDhVfq4h5gbb7VYMt
         c/m6GzV0exNdWtTv/V/dmmaJW3t3wgqe0ch1B9PKht9IO1zHZ0fp0KgTEV67eBBiGT4V
         al7w==
X-Forwarded-Encrypted: i=1; AJvYcCXcwztF45nwnzWGTJobUFCvOEJGAODu8ZX3yuQz0sw4OZt7jQ2a8PnELsMfbtUbcQDykVWGldyeChNlBt8ewUTKrFlBMpf1w1hNn1au
X-Gm-Message-State: AOJu0YwxzKEeUQlJdQJPdLdyJNn7XBTXzdY0GOWSWGlJbZcHwrTODLKg
	vlTb3MqBBYc6fRKKbx4Vr/zk8HEVpu0nwU+ET1hP6fJWFWrsQQZNlG6+QMmz7vs=
X-Google-Smtp-Source: AGHT+IGgMqUl4sRDrJG66cYxeIJMFjP1ZhvADblr9V63c5aanNrfT587vEs2VxCiJVrrEMzfdd4+Lg==
X-Received: by 2002:a05:6602:4f11:b0:7c8:bbdc:ebed with SMTP id gl17-20020a0566024f1100b007c8bbdcebedmr8382717iob.6.1711394448046;
        Mon, 25 Mar 2024 12:20:48 -0700 (PDT)
Received: from [100.64.0.1] ([136.226.86.189])
        by smtp.gmail.com with ESMTPSA id j11-20020a02a68b000000b0047c1f2e4960sm749632jam.56.2024.03.25.12.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 12:20:47 -0700 (PDT)
Message-ID: <757b0f1c-b8ff-4a1a-8edc-8dc651a348fb@sifive.com>
Date: Mon, 25 Mar 2024 14:20:46 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Define TASK_SIZE_MAX for __access_ok()
To: Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Alexandre Ghiti <alex@ghiti.fr>, David Laight <David.Laight@aculab.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Palmer Dabbelt
 <palmer@dabbelt.com>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 Albert Ou <aou@eecs.berkeley.edu>, Andrew Morton
 <akpm@linux-foundation.org>, Charlie Jenkins <charlie@rivosinc.com>,
 guoren <guoren@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Matthew Wilcox
 <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Xiao W Wang
 <xiao.w.wang@intel.com>, Yangyu Chen <cyy@cyyself.name>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240313180010.295747-1-samuel.holland@sifive.com>
 <CAHVXubjLWZkjSapnsWJzimWg_2swEy7tQ-DQ6ri8yMk8-Qsc-A@mail.gmail.com>
 <88de4a1a-047e-4be9-b5b0-3e53434dc022@sifive.com>
 <b5624bba-9917-421b-8ef0-4515d442f80b@ghiti.fr>
 <f786e02245424e02b38f55ae6b29d14a@AcuMS.aculab.com>
 <d323eb10-c79b-49cb-94db-9b135e6fd280@ghiti.fr>
 <ZgGosOiW6mTeSnTL@FVFF77S0Q05N>
 <eeccbc9f-7544-42c9-964f-2b4c924c2b2f@app.fastmail.com>
 <ZgHCpgHh1ypSyrtv@FVFF77S0Q05N>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <ZgHCpgHh1ypSyrtv@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-25 1:30 PM, Mark Rutland wrote:
> On Mon, Mar 25, 2024 at 07:02:13PM +0100, Arnd Bergmann wrote:
>> On Mon, Mar 25, 2024, at 17:39, Mark Rutland wrote:
>>
>>> Using a compile-time constant TASK_SIZE_MAX allows the compiler to generate
>>> much better code for access_ok(), and on arm64 we use a compile-time constant
>>> even when our page table depth can change at runtime (and when native/compat
>>> task sizes differ). The only abosolute boundary that needs to be maintained is
>>> that access_ok() fails for kernel addresses.
>>
>> As I understand, this works on arm64 and x86 because the kernel
>> mapping starts on negative 64-bit addresses, so the highest user
>> address (TASK_SIZE = 0x000fffffffffffff) is still smaller than the
>> lowest kernel address (PAGE_OFFSET = 0xfff0000000000000).
> 
> Yep; the highest posible user address is always below the lowest possible
> kernel address, and any "non-canonical" address between the two ranges faults.
> There's some fun with TBI (Top Byte Ignore) and MTE, but that only affects how
> to mangle the pointer before the check, and doesn't affect the definition of
> the VA boundary.
> 
> In general, so long as TASK_SIZE_MAX is <= the lowest possible kernel address
> and TASK_SIZE_MAX > the highest possible user address, it all works out.
> 
>> If an architecture ignores all the top bits of a virtual address,
>> the largest TASK_SIZE would be higher than the smallest (positive,
>> unsigned) PAGE_OFFSET, so you need TASK_SIZE_MAX to be dynamic.
> 
> Agreed, but do we even support such architectures within Linux?
> 
>> It doesn't look like this is the case on riscv, but I'm not sure
>> about this part.
> 
> It looks like riscv is in the same bucket as arm64 and x86 per:
> 
>   https://www.kernel.org/doc/html/next/riscv/vm-layout.html
> 
> ... which says:
> 
> | The RISC-V privileged architecture document states that the 64bit addresses
> | "must have bits 63-48 all equal to bit 47, or else a page-fault exception
> | will occur.": that splits the virtual address space into 2 halves separated
> | by a very big hole, the lower half is where the userspace resides, the upper
> | half is where the RISC-V Linux Kernel resides.

Right, and while RISC-V has a pointer masking extension[1] similar to arm64's
TBI, it will be handled[2] the same way: by sign extending the address prior to
checking against TASK_SIZE_MAX. So we maintain the property that userspace
addresses are always "positive" and kernel addresses are always "negative".

Regards,
Samuel

[1]: https://github.com/riscv/riscv-j-extension/raw/a1e68469c60/zjpm-spec.pdf
[2]:
https://lore.kernel.org/linux-riscv/20240319215915.832127-1-samuel.holland@sifive.com/

