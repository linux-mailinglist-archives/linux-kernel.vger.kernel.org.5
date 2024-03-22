Return-Path: <linux-kernel+bounces-110817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9466F886447
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 01:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508BA2821A5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3757565C;
	Fri, 22 Mar 2024 00:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QAcNKIrc"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FF1376
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 00:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711066436; cv=none; b=Ebtw1wD2sLaX41oxHBPNcVZeUb1csNLONbSbfQaGHaBjASd0wwx6f/BVf/Hzdat+UakoRSqF7Z+HblQnShwGgGvqESt769cCkb3y/crXY9mOqAFlS8yB6bfMBLljnLrzxxLsLNMl6h0J0U199yJ6OZ5G9+h6k38llli4lpG+KOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711066436; c=relaxed/simple;
	bh=Z5fjCzmDv7rqR7iUDqxDLqg/AN5GIh/c5iZIz9BpjEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=idkyJiASYC6knb6BiTSDACCUIgTGqdBgmdTSMKq/1RXfqVj6L3XX1qYav7pyJ0jg3/q4I1TaI1gAvGB7vRPKIg7SzVNv850NKM6+s5Qs5dkGWdcK6XckFkyT6MyxLZDXqAtEySN+VU8Q2XuwzD/n7LZcroHUwa1Lp2yE5mAfrRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=QAcNKIrc; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3686914b564so3571675ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 17:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711066434; x=1711671234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oVj0RTqijXF6fGHo7lvyifktNSlsSBmRQcPYhg8uW8Y=;
        b=QAcNKIrcsdNtT0pZpXNbkJzKMlZtJcSzPC0XFEQKRXTTEh0FM61171mjI2WPIGK55N
         3fmWSLAduhmYr1bhTpAm/0lX1iMdA3Y+MAJ2mNTpBbnGBbzwZsA51Drgigrtcf9MRjcq
         ZEBTvYyEj7Thixeku7+4uUTLHabcsrhxrclVBH89vgo9zdAxAL3a+BIb6qC0CvsqQmRb
         DwI8161oN9mMEXtTCRsEboi6gv1VOhJEYdlBeGRJwJksi8t+pEDbN0dCmoVR/xnbeaCF
         GufQJsb02A/RBSYn9s7umWR7DEDkqCdYgsAylGMvV7dwJmyd8xyIlpVPwMuKcAE18rWv
         44dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711066434; x=1711671234;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oVj0RTqijXF6fGHo7lvyifktNSlsSBmRQcPYhg8uW8Y=;
        b=aUgqdrKjQzv+RWgoY9k/PgjQ19PnwMeACEkQR6DCY8yEScop631fPMJlb6X9HoBX8J
         44NfPb7XqckmQHPD7rYMO+LCebJy3gd40GSBPBmKx0SW5m5wUt0AEY/ENQ+tkB6aLbMs
         m7c6orBGzMOOLduiVRdJUhNdmd8nBbVeU2/2O3QxMMOiN+dXOKb23hGU2qXlM26+SsFm
         yIIGTsT7L2QCpfq0nqpz1LLlNTz3nbPArSa4TSq00lleeSGk/2peZloHfsYtaq2oukog
         b+6hFego+BBtsunno+gUMFBAc40uN0lGEMPzYfJtbNz4TRcrSESLO+BfvLe4snMt+HuG
         khmg==
X-Forwarded-Encrypted: i=1; AJvYcCXHZ4GRibMAnLjw1gbjGs/05wVVyQDnVWMPY9tM5STbk9mA8HMkDfjiJfE7gHNJuCrCwpuS+mGr0qbFZOAvYRGxpm8yXFkEgkdFNxOf
X-Gm-Message-State: AOJu0Yx7FNPqojth/NAJaDYOFpkonhSxVKQX7VLN5z2C0NARQ+eWjdZu
	fl5k9QIGse+tUiQs6vfHIv/EDQgiit6ENik7biNsxOj6JUzAHJHSj5B5R6ERaAo=
X-Google-Smtp-Source: AGHT+IFKwWGMcmPYu0Ub5wCx2QiMD01tH+85fFGHMfPp5sK/V1U4H3V0F6RY+8M0VE4TG4elEaDvoQ==
X-Received: by 2002:a92:dc83:0:b0:365:29e4:d95d with SMTP id c3-20020a92dc83000000b0036529e4d95dmr966458iln.30.1711066434179;
        Thu, 21 Mar 2024 17:13:54 -0700 (PDT)
Received: from [100.64.0.1] ([136.226.86.189])
        by smtp.gmail.com with ESMTPSA id y18-20020a056638015200b00476f1daad44sm206727jao.54.2024.03.21.17.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 17:13:53 -0700 (PDT)
Message-ID: <d9452ab4-a783-4bcf-ac25-40baa4f31fac@sifive.com>
Date: Thu, 21 Mar 2024 19:13:52 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RISC-V] [tech-j-ext] [RFC PATCH 5/9] riscv: Split per-CPU and
 per-thread envcfg bits
Content-Language: en-US
To: Deepak Gupta <debug@rivosinc.com>, Conor Dooley <conor@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 tech-j-ext@lists.risc-v.org, kasan-dev@googlegroups.com,
 Evgenii Stepanov <eugenis@google.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Andrew Jones <ajones@ventanamicro.com>,
 Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Paul Walmsley <paul.walmsley@sifive.com>
References: <20240319215915.832127-1-samuel.holland@sifive.com>
 <20240319215915.832127-6-samuel.holland@sifive.com>
 <CAKC1njSg9-hJo6hibcM9a-=FUmMWyR39QUYqQ1uwiWhpBZQb9A@mail.gmail.com>
 <40ab1ce5-8700-4a63-b182-1e864f6c9225@sifive.com>
 <CAKC1njQYZHbQJ71mapeG1DEw=A+aGx77xsuQGecsNFpoJ=tzGQ@mail.gmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <CAKC1njQYZHbQJ71mapeG1DEw=A+aGx77xsuQGecsNFpoJ=tzGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-19 11:39 PM, Deepak Gupta wrote:
>>>> --- a/arch/riscv/include/asm/switch_to.h
>>>> +++ b/arch/riscv/include/asm/switch_to.h
>>>> @@ -69,6 +69,17 @@ static __always_inline bool has_fpu(void) { return false; }
>>>>  #define __switch_to_fpu(__prev, __next) do { } while (0)
>>>>  #endif
>>>>
>>>> +static inline void sync_envcfg(struct task_struct *task)
>>>> +{
>>>> +       csr_write(CSR_ENVCFG, this_cpu_read(riscv_cpu_envcfg) | task->thread.envcfg);
>>>> +}
>>>> +
>>>> +static inline void __switch_to_envcfg(struct task_struct *next)
>>>> +{
>>>> +       if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_XLINUXENVCFG))
>>>
>>> I've seen `riscv_cpu_has_extension_unlikely` generating branchy code
>>> even if ALTERNATIVES was turned on.
>>> Can you check disasm on your end as well.  IMHO, `entry.S` is a better
>>> place to pick up *envcfg.
>>
>> The branchiness is sort of expected, since that function is implemented by
>> switching on/off a branch instruction, so the alternate code is necessarily a
>> separate basic block. It's a tradeoff so we don't have to write assembly code
>> for every bit of code that depends on an extension. However, the cost should be
>> somewhat lowered since the branch is unconditional and so entirely predictable.
>>
>> If the branch turns out to be problematic for performance, then we could use
>> ALTERNATIVE directly in sync_envcfg() to NOP out the CSR write.
> 
> Yeah I lean towards using alternatives directly.

One thing to note here: we can't use alternatives directly if the behavior needs
to be different on different harts (i.e. a subset of harts implement the envcfg
CSR). I think we need some policy about which ISA extensions are allowed to be
asymmetric across harts, or else we add too much complexity.

Regards,
Samuel


