Return-Path: <linux-kernel+bounces-106701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0060B87F223
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1A91F20C74
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100BE58AC3;
	Mon, 18 Mar 2024 21:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mRbbR7m8"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E8058233
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797375; cv=none; b=V/YjtzXnAHXbHTiSDwH0IDmbv+ZUKKMYca46c0NX+ltm+S6TMxPkr18gFTArj2tOPUBPeba7bGnTeLi69QGwpcl1TwakFTYTRmYhSmwlpDuf98ybMKxugBR5JNxtZTxk2TqFdnxNz9QZQLDdYS3YIGPMWLVul4jZO4+MpOGnGtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797375; c=relaxed/simple;
	bh=wa4AsEHowlTcQ7Yg5/g6MIQX/SG3V6t/gqBj8pYSItg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOpLWVN8s9j4fz/IN0G1jDJwcICaiYgNq8RmPjxywO+19UfxJk1RoqeRyYQfhs5IwK3JAl8fmGqsva9F0QSIWF1r3YQ52iCdmHJ8fx9XIW7bM8JzrMxGpNI8ddCt3yU1JVlWhfCkdPo4ebufNS1KWYuFrpiXCChXDbWG1FOk9+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=mRbbR7m8; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-366ad40144fso5896345ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710797373; x=1711402173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Nul1eVuq4XLe3SGFf2DVNn6S2hK2sqq4oKFGkGjGXg=;
        b=mRbbR7m8X5JfixQi24ou2bbV4TNAeyCcRHYyskqLRwWQlu2hIMJrgWZeltOcocde8V
         oYTGVIrrQCr9CzaZ5+4P7hw5oyNx67zWgThX5yxPKmvlLwf8DARgGuQyKSiBHzb3snJd
         GTFA6eQQVAb2Affv1ujR6K1z4J95S38g9t5xHt7JCkyUymxWO04gLEYxBi7CEzitPFQY
         VrTmNLE7k00lL9ol2ddDeeswc8UaMiQ9KPSZ5D0ZE+UEsslVqF7wYORfJSHQjC8LXphb
         2VwR0zLl+kMurAh1akG3ZiQgHP/3HyX+N3OCUwODOSH/x4ZirgLQWOHiPn1wYhc6X5It
         Jt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710797373; x=1711402173;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Nul1eVuq4XLe3SGFf2DVNn6S2hK2sqq4oKFGkGjGXg=;
        b=oaV7ZWN3WVq3sfZT5QAORtXB4YKhaMIHQ8Ixx7RmmXFB6AQhoB4SeVQjhYV6oMkvL9
         NdVw93vYwqxwlF46X5nt6ZwAvSMe/yAPeTpfRG/Sq5NLG5xg9xAIbmDmfJ0hcZ5wG+TT
         JrpWALxCoGLBgXLmP37BTCFtAa3sLAgyzfij0bgzFYF5vYMr86pc3Oz3s0lqXhyArwEN
         VgAVXgwd+SDE0s6raVADldwSNaNT7cEn1uDYM8J4BSxdEGFfuKJw15eIsSQur55xWmzk
         vfNP/2KguTVekWKKgrtTTvOriD2rvjSkS5PGzD/4Hul1pK+6O8OoiN3cCKIDwyE5hHLM
         hqEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu8kaXtAWNJynk9LDppRTCQebX5K3ZRQzpTAMkkWmX7O+rFHRy5npbbJk5XFY1mxLomMzFwY+FMx0vhs5UIAR8u+Jb3LIj6XlXlz3B
X-Gm-Message-State: AOJu0YxGviObRz4PnjgcxQfPmzIShOxvSvqdgO7O83lIe6+Q0nRJhKoE
	XVUe5Cr0BYg2KLOSx8gzntk0U5Bt6TtF7L34y2+URCFCdHkCb4bSsSSofMeKXIU=
X-Google-Smtp-Source: AGHT+IGplRx/3NjrYT/brJF88QRJLUV/wi8Qy9KFuvMjBRp+xMbCOC5rIkYwtdBM4rJ6IEL040jsVA==
X-Received: by 2002:a05:6e02:1064:b0:366:8c58:42ea with SMTP id q4-20020a056e02106400b003668c5842eamr887284ilj.11.1710797372753;
        Mon, 18 Mar 2024 14:29:32 -0700 (PDT)
Received: from [100.64.0.1] ([136.226.86.189])
        by smtp.gmail.com with ESMTPSA id l13-20020a056e0205cd00b00366164573dfsm2512024ils.63.2024.03.18.14.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 14:29:32 -0700 (PDT)
Message-ID: <88de4a1a-047e-4be9-b5b0-3e53434dc022@sifive.com>
Date: Mon, 18 Mar 2024 16:29:30 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Define TASK_SIZE_MAX for __access_ok()
Content-Language: en-US
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 Albert Ou <aou@eecs.berkeley.edu>, Andrew Morton
 <akpm@linux-foundation.org>, Charlie Jenkins <charlie@rivosinc.com>,
 Guo Ren <guoren@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Xiao Wang <xiao.w.wang@intel.com>,
 Yangyu Chen <cyy@cyyself.name>, linux-kernel@vger.kernel.org
References: <20240313180010.295747-1-samuel.holland@sifive.com>
 <CAHVXubjLWZkjSapnsWJzimWg_2swEy7tQ-DQ6ri8yMk8-Qsc-A@mail.gmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <CAHVXubjLWZkjSapnsWJzimWg_2swEy7tQ-DQ6ri8yMk8-Qsc-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Alex,

On 2024-03-18 3:50 PM, Alexandre Ghiti wrote:
> On Wed, Mar 13, 2024 at 7:00 PM Samuel Holland
> <samuel.holland@sifive.com> wrote:
>>
>> TASK_SIZE_MAX should be set to the largest userspace address under any
>> runtime configuration. This optimizes the check in __access_ok(), which
>> no longer needs to compute the current value of TASK_SIZE. It is still
>> safe because addresses between TASK_SIZE and TASK_SIZE_MAX are invalid
>> at the hardware level.
>>
>> This removes about half of the references to pgtable_l[45]_enabled.
>>
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>>
>>  arch/riscv/include/asm/pgtable-64.h | 1 +
>>  arch/riscv/include/asm/pgtable.h    | 1 +
>>  2 files changed, 2 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
>> index b99bd66107a6..a677ef3c0fe2 100644
>> --- a/arch/riscv/include/asm/pgtable-64.h
>> +++ b/arch/riscv/include/asm/pgtable-64.h
>> @@ -17,6 +17,7 @@ extern bool pgtable_l5_enabled;
>>  #define PGDIR_SHIFT_L4  39
>>  #define PGDIR_SHIFT_L5  48
>>  #define PGDIR_SIZE_L3   (_AC(1, UL) << PGDIR_SHIFT_L3)
>> +#define PGDIR_SIZE_L5   (_AC(1, UL) << PGDIR_SHIFT_L5)
>>
>>  #define PGDIR_SHIFT     (pgtable_l5_enabled ? PGDIR_SHIFT_L5 : \
>>                 (pgtable_l4_enabled ? PGDIR_SHIFT_L4 : PGDIR_SHIFT_L3))
>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>> index 6066822e7396..2032f8ac5fc5 100644
>> --- a/arch/riscv/include/asm/pgtable.h
>> +++ b/arch/riscv/include/asm/pgtable.h
>> @@ -867,6 +867,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>>  #ifdef CONFIG_64BIT
>>  #define TASK_SIZE_64   (PGDIR_SIZE * PTRS_PER_PGD / 2)
>>  #define TASK_SIZE_MIN  (PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
>> +#define TASK_SIZE_MAX  (PGDIR_SIZE_L5 * PTRS_PER_PGD / 2)
>>
>>  #ifdef CONFIG_COMPAT
>>  #define TASK_SIZE_32   (_AC(0x80000000, UL))
>> --
>> 2.43.1
>>
> 
> I think you also need to change the check in handle_page_fault() by
> using TASK_SIZE_MAX instead of TASK_SIZE, otherwise the fixup can't
> happen (https://elixir.bootlin.com/linux/latest/source/arch/riscv/mm/fault.c#L273).

It is not necessary to change that check in fault.c unless we expect to handle
exceptions (outside of userspace access routines) for addresses between
TASK_SIZE and TASK_SIZE_MAX. It looks like the call to fixup_exception() [added
in 416721ff05fd ("riscv, mm: Perform BPF exhandler fixup on page fault")] is
only intended to catch null pointer dereferences. So making the change wouldn't
have any functional impact, but it would still be a valid optimization.

> Or I was wondering if it would not be better to do like x86 and use an
> alternative, it would be more correct (even though I believe your
> solution works)
> https://elixir.bootlin.com/linux/latest/source/arch/x86/include/asm/page_64.h#L82.

What would be the benefit of using an alternative? Any access to an address
between TASK_SIZE and TASK_SIZE_MAX is guaranteed to generate a page fault, so
the only benefit I see is returning -EFAULT slightly faster at the cost of
applying a few hundred alternatives at boot. But it's possible I'm missing
something.

Regards,
Samuel


