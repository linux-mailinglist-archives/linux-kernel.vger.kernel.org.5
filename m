Return-Path: <linux-kernel+bounces-150819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3F08AA537
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E6031C2134E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B78199E97;
	Thu, 18 Apr 2024 22:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Qif+6AsN"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD9B13F443
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 22:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713477647; cv=none; b=MpOw7+xucxm/338tbM2KbGZk6jo5suCrONESaOdX+osaEkReVUauASrdpCbm9ZORHM4uW17y1Bg8EtJH5lso8TZJhtc4/QC7uFbkjC36+3Paz2LqEBVoAd1AqW2EA+aPR3RcKl5BpP0FN0QMum5pymXMjMQ/LHWfohYaJHPAkTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713477647; c=relaxed/simple;
	bh=p5ZbW5eCLUWIBuL3FO6CJqzFEQBd5Cq98xh9PmgDJ5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1ltl01bsWAUs1z/7iX363DAjA1yMF6xWzUWB9nVUoLzAzZrJiVkW+/9vW5i2U6utiuPjL7h7eMw8wdb1PT/n6D1x/SSzpHy67Vqr6XyHBL0Qg1A5/nMRQurwVH4BnVRKAzMpEZYrFbQPp6/HGMir7zLYHzX2tgj/RK/dVp/Fn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Qif+6AsN; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7c8ad87b2acso36976439f.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 15:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1713477645; x=1714082445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LPPGE1q9s6cTnAk4kOg+eroFH/OZnnaVpd01j4nY80E=;
        b=Qif+6AsNs8Q2NSdv6pQpqyWEtGuA2e78dViSM8asOXXT2sAJ9gkarmU4V/Pyj5VsNp
         ZZJQaVj1LqZXXb8V9evChVt5BTm8eoTFoFtouhEynPpkZ7TMm9Jd8ML492Ks/+boctRk
         /cAo8cg7bAF3R5eMYlslfq2/ONnhwKvAm+cWMShd6BOXPlk1J2Ojbw8T1AF4ujq9lgJs
         yyFIjPeD55hH/tlFEV4FjhEmH0wYIpqX0rMUAEdwlgLqtjcL7c8YuGiNTZ1CIe9r701B
         Vb8xgflDZsXyzvITnYz/m82QhJDZ0NWwWuhvIUCHCd3XK6FmOWzUG2Keu/DNTUPeaYPF
         LANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713477645; x=1714082445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LPPGE1q9s6cTnAk4kOg+eroFH/OZnnaVpd01j4nY80E=;
        b=EA+/cYm9twKAz+qGmHJrnbTeQGBRO/MmK//8JYMY/iGHZ85RHmikb5NqJradM9y8qZ
         ZyM+H8L5gsH2IgtXkBlZWnfBkCD3VqcNS9vuxJFxf0VpMBwSZfkKj6lTo4NqOj/KkYo7
         dIgTjy7J5N2K2lrW2u30h9JVNV8DqzBu99MF+iooUzdxRG6oKqa+wPY2WQZ9rTfaiLD8
         ba/NJWzOPyA7IKN5KzGWbKr9+2CYopoTeUl5e87ynZEsAmGVzThI0ykanLmrlRz0pB7L
         wpeIffwQ3WJwDjH3rEH106tFwqAIqIqRZaqLLRwGZ8m84EKq3Tr2GDXaFZcbWHVn5W7K
         NqyA==
X-Forwarded-Encrypted: i=1; AJvYcCUuoDz4wxe8QX0CupnPNxQ2FzwWVlchWxsUJevNGoewQyeB+pI9f6troAhowhnTbfvzSCGibjOJGvNaO+nDZmxGQ7IZjUoYCVC4nA/+
X-Gm-Message-State: AOJu0YyPFKYzcvfJOF9zOY/wjDdPY5c3ko299gH38jl5vrapPyMWQMuw
	EhIsJDzYuk7GwWWraTiCsJFqiYc1rLvPvN8zTtPZAyxe7Jvk7WhYPvT6ltmCX10=
X-Google-Smtp-Source: AGHT+IF4iUMS3eOsGMRU754zue/Q9W8EqUFJSSWAR8r9SOKI8KHJgGqick2Fy8LHDjkEuBIaHtDFRg==
X-Received: by 2002:a6b:4402:0:b0:7d5:f121:dee7 with SMTP id r2-20020a6b4402000000b007d5f121dee7mr498314ioa.19.1713477645449;
        Thu, 18 Apr 2024 15:00:45 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.197])
        by smtp.gmail.com with ESMTPSA id f2-20020a056638168200b00482a6d6ad31sm650286jat.92.2024.04.18.15.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 15:00:45 -0700 (PDT)
Message-ID: <33de5d8f-5ccb-4dd0-9915-720e6f800560@sifive.com>
Date: Thu, 18 Apr 2024 17:00:42 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] riscv: process: Introduce idle thread using Zawrs
 extension
To: Andrew Jones <ajones@ventanamicro.com>, Conor Dooley <conor@kernel.org>
Cc: Xu Lu <luxu.kernel@bytedance.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, andy.chiu@sifive.com,
 guoren@kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, lihangjing@bytedance.com,
 dengliang.1214@bytedance.com, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com
References: <20240418114942.52770-1-luxu.kernel@bytedance.com>
 <20240418114942.52770-2-luxu.kernel@bytedance.com>
 <20240418-dove-deferral-2b01100e13ca@spud>
 <20240418-d9f305770dc71c2687a6e84b@orel>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240418-d9f305770dc71c2687a6e84b@orel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Drew,

On 2024-04-18 2:10 PM, Andrew Jones wrote:
> On Thu, Apr 18, 2024 at 04:05:55PM +0100, Conor Dooley wrote:
>> + Drew,
>>
>> On Thu, Apr 18, 2024 at 07:49:41PM +0800, Xu Lu wrote:
>>> The Zawrs extension introduces a new instruction WRS.NTO, which will
>>> register a reservation set and causes the hart to temporarily stall
>>> execution in a low-power state until a store occurs to the reservation
>>> set or an interrupt is observed.
>>>
>>> This commit implements new version of idle thread for RISC-V via Zawrs
>>> extension.
>>>
>>> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
>>> Reviewed-by: Hangjing Li <lihangjing@bytedance.com>
>>> Reviewed-by: Liang Deng <dengliang.1214@bytedance.com>
>>> Reviewed-by: Wen Chai <chaiwen.cc@bytedance.com>
>>> ---
>>>  arch/riscv/Kconfig                 | 24 +++++++++++++++++
>>>  arch/riscv/include/asm/cpuidle.h   | 11 +-------
>>>  arch/riscv/include/asm/hwcap.h     |  1 +
>>>  arch/riscv/include/asm/processor.h | 17 +++++++++++++
>>>  arch/riscv/kernel/cpu.c            |  5 ++++
>>>  arch/riscv/kernel/cpufeature.c     |  1 +
>>>  arch/riscv/kernel/process.c        | 41 +++++++++++++++++++++++++++++-
>>>  7 files changed, 89 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>> index be09c8836d56..a0d344e9803f 100644
>>> --- a/arch/riscv/Kconfig
>>> +++ b/arch/riscv/Kconfig
>>> @@ -19,6 +19,7 @@ config RISCV
>>>  	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
>>>  	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
>>>  	select ARCH_HAS_BINFMT_FLAT
>>> +	select ARCH_HAS_CPU_FINALIZE_INIT
>>>  	select ARCH_HAS_CURRENT_STACK_POINTER
>>>  	select ARCH_HAS_DEBUG_VIRTUAL if MMU
>>>  	select ARCH_HAS_DEBUG_VM_PGTABLE
>>> @@ -525,6 +526,20 @@ config RISCV_ISA_SVPBMT
>>>  
>>>  	   If you don't know what to do here, say Y.
>>>  
>>> +config RISCV_ISA_ZAWRS
>>> +	bool "Zawrs extension support for wait-on-reservation-set instructions"
>>> +	depends on RISCV_ALTERNATIVE
>>> +	default y
>>> +	help
>>> +	   Adds support to dynamically detect the presence of the Zawrs
>>> +	   extension and enable its usage.
>>
>> Drew, could you, in your update, use the wording:
>> 	   Add support for enabling optimisations in the kernel when the
>> 	   Zawrs extension is detected at boot.
> 
> How about
> 
>   The Zawrs extension defines a pair of instructions to be used in
>   polling loops which allow a hart to enter a low-power state or to
>   trap to the hypervisor while waiting on a store to a memory location.
>   Enable the use of these instructions when the Zawrs extension is

                                        ^ in the kernel

I believe "in the kernel" was an important part of the clarification that these
Kconfig options do not affect whether userspace can use these instructions.

Regards,
Samuel

>   detected at boot.
> 
> Thanks,
> drew
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


