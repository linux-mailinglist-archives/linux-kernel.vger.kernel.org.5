Return-Path: <linux-kernel+bounces-98459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B343877A6D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B9D281127
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 04:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9897462;
	Mon, 11 Mar 2024 04:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QZNvZeqG"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916D36AAD
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 04:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710132157; cv=none; b=u0DPSf49FAREUcpPq2xQgBWPON3zcLbFELRagjEYRFEI0SDW2aF4L3DajtvAI9CmRrDyVUtLGxeWC2F78i3z+wx4taEvrwJT21eG2jXUbcmMvdl1rV6lq5DqibZfJnwt3BPrNnCF+DifGXs0f8vJTjtL+Tb+GjyESaRkWlkGIuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710132157; c=relaxed/simple;
	bh=w/60wsxTexX+0M9M7H5JQe81BsjSfrTUM/vp/xfYFuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9Orn2GRI5Goh8IdRmAgXHMfS17r20XLlX6rbTg+kTHEcm4KccDGgq+N9CRU/SZyr2KTZuBl8xcMqxkfWzCUym1YhmdmtQUUxq7np/QyqmnC/Cq/ytkQYfSNoyZrrsL4VMqyR7sFB+309PabxXXbh/axGLWbQyDxzeomH4Ht0IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=QZNvZeqG; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-690d4c22c13so2703786d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 21:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710132154; x=1710736954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OYVTrtS1wFR4xz4iRpAoYb5PAkF0r3W283OMjz+whQg=;
        b=QZNvZeqGx3cY8PvqZ5KHwW0q65P3bkFN16eWtV7+wsjv7gEkF2hZevF3YB0CkMSyJu
         cAjI5LgawjFDskLLq5gIbaijzU8O/6fMCcG4lSLDiXq1bGroiTSlK2R7u9OF/M0vvZK7
         dGsJPLd//TjH7NwGlFtej6TdK0tEscvr5rOfxC5+kntHCxCSgN7+u27+zHU3rg4uzzrC
         5pJ6Imc88EkPzal/z/i5nd6rCCB8nFoBYzqbhcktsnhQqB6VZZbTWW7t/Yh+VNA3MmKy
         WP153KwoALKV8zT1qVQXRzfECg+CFr7jqPrVYXEWQgI47oIgntblD/UnG97JT/PGy0tr
         eMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710132154; x=1710736954;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OYVTrtS1wFR4xz4iRpAoYb5PAkF0r3W283OMjz+whQg=;
        b=nMYvzprNnucFWCjGrDZfpuoQ+cm6uiuIqWjDRu2H+g0SInKRODJAcCusudIzY4SidH
         LR+wdgQoIQlPvrr7NuPuVlfCuCND6ebnnZSxccapN6VjfLWyqDvORD3gDeCojOyNNYQC
         eguv3odHy1VvgqUIVreDRAkYchQzDqCv5pY7bbbEQ0QLqBbPBKGJPc0MKburOnDcwGu/
         eCmZkcKqJVaFRjxClPko7qS7tf7K7Rx4Qkim/p9P96R3f1uRVGtSo1F7fhIfEJEIDeMi
         SuYjz4+IxJIABm0zcKt1TQPxAwId5m/PZ6em+MOEwZel6eJgEcL51ziNcZtUg0KvFMfb
         vchA==
X-Forwarded-Encrypted: i=1; AJvYcCVadKxmInvagj6QzdyZGcfUFGulGI+7kzPh2upAeVNmizQxnXD7cBMogR3RuzJ19PQxMmn8UFrDEjCIiJFX/AyNU/X7A3UAP47n6ShI
X-Gm-Message-State: AOJu0YxSCBaFujONqo+JRkk3r/lX+BlHDdpeSzRnGiYwzJhkDjgBa5H5
	jXcZFCyfb/QHmg3D1V6pHLcewORIdlpErZZc2Evpusreq7EY/pK1CdE4FAPHy20=
X-Google-Smtp-Source: AGHT+IFujUbi/JzfhmrtcGQ3D4oV7h0eie/xe8JSG2biYs1Uf2rxNY6Xc0sSBjnTJ11UzqzUDP6veQ==
X-Received: by 2002:a05:6214:184b:b0:690:9022:15cf with SMTP id d11-20020a056214184b00b00690902215cfmr4388812qvy.61.1710132154380;
        Sun, 10 Mar 2024 21:42:34 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.8.176])
        by smtp.gmail.com with ESMTPSA id di12-20020ad458ec000000b00690d848521esm213805qvb.12.2024.03.10.21.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Mar 2024 21:42:33 -0700 (PDT)
Message-ID: <77275750-18ca-4040-8b46-da601606dc67@sifive.com>
Date: Sun, 10 Mar 2024 23:42:32 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/13] riscv: Use IPIs for remote cache/TLB flushes by
 default
Content-Language: en-US
To: Anup Patel <apatel@ventanamicro.com>, Stefan O'Rear <sorear@fastmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Jisheng Zhang
 <jszhang@kernel.org>, yunhui cui <cuiyunhui@bytedance.com>
References: <20240229232211.161961-1-samuel.holland@sifive.com>
 <20240229232211.161961-4-samuel.holland@sifive.com>
 <10c4851d-a8d8-4289-a9f9-509c70a0ca22@app.fastmail.com>
 <CAK9=C2X9GR4SVU_VisAakM4Ae4=59D84MkXU-5_0y192Kzv_-Q@mail.gmail.com>
 <CAK9=C2WH+3QzHpUqaQv3TZEJatfgytVOYur5NvhifdheEgU1AQ@mail.gmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <CAK9=C2WH+3QzHpUqaQv3TZEJatfgytVOYur5NvhifdheEgU1AQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Stefan, Anup,

On 2024-03-10 11:12 PM, Anup Patel wrote:
> On Mon, Mar 11, 2024 at 9:34 AM Anup Patel <apatel@ventanamicro.com> wrote:
>>
>> On Mon, Mar 11, 2024 at 8:37 AM Stefan O'Rear <sorear@fastmail.com> wrote:
>>>
>>> On Thu, Feb 29, 2024, at 6:21 PM, Samuel Holland wrote:
>>>> An IPI backend is always required in an SMP configuration, but an SBI
>>>> implementation is not. For example, SBI will be unavailable when the
>>>> kernel runs in M mode.
>>>>
>>>> Generally, IPIs are assumed to be faster than SBI calls due to the SBI
>>>> context switch overhead. However, when SBI is used as the IPI backend,
>>>> then the context switch cost must be paid anyway, and performing the
>>>> cache/TLB flush directly in the SBI implementation is more efficient
>>>> than inserting an interrupt to the kernel. This is the only scenario
>>>> where riscv_ipi_set_virq_range()'s use_for_rfence parameter is false.
>>>>
>>>> Thus, it makes sense for remote fences to use IPIs by default, and make
>>>> the SBI remote fence extension the special case.
>>>
>>> The historical intention of providing SBI calls for remote fences is that
>>> it abstracts over hardware that allows for performing remote fences
>>> _without an IPI at all_. The TH1520 is an example of such hardware, since
>>> it can (at least according to the documentation) perform broadcast fence,
>>> fence.i, and sfence.vma operations using bits in the mhint register.

Platform-specific code can call static_branch_enable(&riscv_sbi_for_rfence) if
it somehow knows SBI remote fences are faster. That option is still available.

>>> T-Head's public opensbi repository doesn't actually use this feature, and
>>> in general SBI remote fences come from a much more optimistic time about
>>> how much we can successfully hide from supervisor software. But I don't
>>> think we can generalize that an IPI will always do less work than a SBI
>>> remote fence.

Agreed, and as Anup pointed out below, the case where IPIs go through SBI is an
obvious case where IPIs will do more work than SBI remote fences. However, there
is not currently any way to detect platforms where SBI remote fences have
special optimizations. So, in the absence of extra information, the kernel
assumes SBI remote fences have the performance characteristics implied by using
only standard RISC-V privileged ISA features.

The status quo is that in all cases where IPIs can be delivered to the kernel's
privilege mode without firmware assistance, remote fences are sent via IPI. This
patch is just recognizing that.

>> On platforms where SBI is the only way of injecting IPIs in S-mode, the
>> SBI based remote fences are actually much faster. This is because on
>> such platforms injecting an IPI from a HART to a set of HARTs will
>> require multiple SBI calls which can be directly replaced by one (or
>> few) SBI remote fence SBI calls.
>>
>> Most of the current platforms still have M-mode CLINT and depend on
>> SBI IPI for S-mode IPI injection so we should not slow down remote
>> fences for these platforms.

Just to be clear, this patch does not change the behavior on any existing
platform. All it does is simplify the logic the kernel uses to choose that
behavior at boot time.

In fact, it makes using something like the T-HEAD instructions easier, because
it decouples the remote fence static branch from irqchip driver registration.
And it also paves the way for supporting an SBI implementation that omits the
remote fence extension, if needed.

Like I mentioned in the commit message, the goal was to make IPIs the "else"
case, since SMP simply won't work without IPIs, so they must exist. And any
optimizations can be added on top of that.

>> Until all platforms have moved to RISC-V AIA (which supports S-mode
>> IPIs), we should keep this boot-time choice of SBI RFENCEs versus
>> direct S-mode IPIs.
>>
>> IMO, this patch is ahead of its time.
> 
> I think this patch is fine since it replaces the static key
> riscv_ipi_for_rfence with riscv_sbi_for_rfence.
> 
> I got confused by the removal of riscv_ipi_for_rfence.

Thanks for taking the time to re-review.

Regards,
Samuel


