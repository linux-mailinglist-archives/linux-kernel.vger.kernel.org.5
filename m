Return-Path: <linux-kernel+bounces-81794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 310FE867A2A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31C51F23B24
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E6612C520;
	Mon, 26 Feb 2024 15:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="w/m54H4F"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF45512BF2A
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961131; cv=none; b=uvTTEmBMuvaLulLgF+Uewb08CBQdxQBUwBvgb32s0Dxll+MdYXa884Ahzway0+TEo7twgdinyIJ0soPjsUhKm7hf9Aix+kKR2w6qaoNSlVuLdf00wtFSb+XjEHRNXbJGq6sY64KHzBvqRzsfPx7jFTEeDjsodPfdTRnH8DMlLOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961131; c=relaxed/simple;
	bh=r18uY5ZOhrp77TZ+zC5Izune83GhbAV0ksmeVyZNBVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ydg8TgW2zIlH5Gx6uxtGRHVzRyS9sxFy94LDFxYAXvb/ESIs50At7O2eKWKtDbFmMNAmlidmuwY8NRsD/kxf2dVcdjUYkvye3H/4oXbyfJtADsEv+oEKFzoI1Sp5yvJOT21fAEqMS4uAMy1t5HRZLPkcu9Wj6pUAXYbK/KW4+OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=w/m54H4F; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41294731cf2so861745e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708961126; x=1709565926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OmdxWUDOxWS1QVUQvuVEam/7eao/3EwtoaN4YjxgRj8=;
        b=w/m54H4F6a/Cz5OvZkNwWeUuDnA2DpXlaj+f1kUXfCe1WiO9I5/a2Mx8Xt8blvbmZx
         jJscoJbVqJMnLqVj5jAOKzP0Te/cGVgA7kDdb8DAtf2w4T/hwSZ/eeIwEpRLCTVbz8Xz
         WkbW9zHhJSg66OFG3qUF7G7vhzL66AHs7T02iSHdyOEwgVY/Fs2xT7TRhhP2haunov0x
         NOjbFT6zvAt8R6kB3psJLkfE9BDJnIhjrBUxhksKOT8/4jHmIJXvlr5hiRZfU5BeQLmh
         gLx5msa8/vrbPRGKcUZ4Y1PNkBvGIR+XSg+3fT8hZWnAOGmogJBkb+T6Oh79rIFjT7jz
         lWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708961126; x=1709565926;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OmdxWUDOxWS1QVUQvuVEam/7eao/3EwtoaN4YjxgRj8=;
        b=JKIzMmwyBw85XYw7CsDBTe+Ow/LHTvnezr/Tbqt80BNjhSr3Ks7E/G6qJVYqmOfPht
         wK7HKRQzB0ib5lpZwBbCBAJX8oaFz8gpGmguhJiQmRNINV0Lx0HmPGsGBhOVVHIIfIcP
         eOZH5pEZZBRN/G4+spkfEWNHJCmLXzc3KzZkFy03UzOgc/ZtMTIBfKfnls1LPsYde6Ba
         GaMK2BspkXIQedfZ5pcDVVhaLPW0yfhrguGQEza15uRrdqOY37sgVE0WeMP3Kxqzmcpo
         ThSQnTVmDT7TxLCY9zesZ2Hd+F8Yi48QKvrcNqhFIfHcSQHKiSw9WBsgzLpbOTvHgj9q
         Qx0g==
X-Forwarded-Encrypted: i=1; AJvYcCU+UQk6qHDYAtLWrgXFQIW5B35ZpMtUZu4LaZHkd8TmD0dEJC0O/Z+jwnc2x23NI7P8xnQQvtR8WevEtQs+50gSAn7PCyGp5N6iomQJ
X-Gm-Message-State: AOJu0Yx/4etWU0Tpd7mCTrRDQ5Oq6F05CRTKcLr9MfhVU5vfvhBta7yn
	kshyGYNM0m4UFLM5tCXabHaUoGXWniNbCHSBE/bbgSUBNoMoD8Z5/+DXRN4apAM=
X-Google-Smtp-Source: AGHT+IEkU69h1irasa49nI1pNbDA2kcFQo4hhVQlKOlNfBMwqoujEQcijkM6sDdPgjSSEEDn4iC4tA==
X-Received: by 2002:a05:600c:5114:b0:412:5670:ef62 with SMTP id o20-20020a05600c511400b004125670ef62mr5374363wms.1.1708961125880;
        Mon, 26 Feb 2024 07:25:25 -0800 (PST)
Received: from ?IPV6:2a01:e0a:999:a3a0:83a3:2c00:c690:18b0? ([2a01:e0a:999:a3a0:83a3:2c00:c690:18b0])
        by smtp.gmail.com with ESMTPSA id be13-20020a05600c1e8d00b004129ed6f9cbsm7888226wmb.4.2024.02.26.07.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 07:25:25 -0800 (PST)
Message-ID: <ea356036-5a0b-47ea-aafb-f9813cc6ec9b@rivosinc.com>
Date: Mon, 26 Feb 2024 16:25:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: deprecate CONFIG_MMU=n
Content-Language: en-US
To: Samuel Holland <samuel.holland@sifive.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Andrew Jones <ajones@ventanamicro.com>, Damien Le Moal <dlemoal@kernel.org>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Atish Patra <atishp@rivosinc.com>
References: <20240226140649.293254-1-cleger@rivosinc.com>
 <40dee2c1-ff24-40b2-a13c-6934139ba869@sifive.com>
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <40dee2c1-ff24-40b2-a13c-6934139ba869@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/02/2024 16:14, Samuel Holland wrote:
> On 2024-02-26 8:06 AM, Clément Léger wrote:
>> Deprecation of NOMMU support for riscv was discussed during LPC 2023
>> [1]. Reasons for this involves lack of users as well as maintenance
>> efforts to support this mode. psABI FDPIC specification also never
>> made it upstream and last public messages of this development seems to
>> date back from 2020 [2]. Plan the deprecation to be done in 2 years from
> 
> What are the criteria for delaying/canceling the removal? NOMMU support doesn't
> rot nearly as fast as XIP; static PIE ELF works and is well specified; and as
> mentioned at LPC, there are some users, even if "just for fun".

Hi Samuel,

I was actually developing some feature that encountered NOMMU build
failures and I was reminded that NOMMU was discussed to be deprecated
during last LPC. I guess I could also mark XIP as deprecated. The
rationale behind delaying is to let some users to manifest themselves
before a full removal. But this can still be discussed of course, this
patch was also meant to trigger such feedback.

> 
>> now. Mark the Kconfig option as deprecated by adding a new dummy option
>> which explicitly displays the deprecation in case of CONFIG_MMU=n. This option
>> is selected indirectly by CONFIG_RISCV_M_MODE since an option can not
>> select another one directly with a "select" in case of such CONFIG=n.
>> Additionally, display a pr_err() message at boot time in case of NOMMU
>> build to warn about upcoming deprecation.
>>
>> Link: https://lpc.events/event/17/contributions/1478/ [1]
>> Link: https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/ZjYUJswknQ4/m/WYRRylTwAAAJ [2]
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>
>> ---
>>  arch/riscv/Kconfig        | 8 ++++++++
>>  arch/riscv/kernel/setup.c | 4 ++++
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index bffbd869a068..8da58c102d3f 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -221,6 +221,7 @@ config ARCH_MMAP_RND_COMPAT_BITS_MAX
>>  # set if we run in machine mode, cleared if we run in supervisor mode
>>  config RISCV_M_MODE
>>  	bool
>> +	select NOMMU
>>  	default !MMU
>>  
>>  # set if we are running in S-mode and can use SBI calls
>> @@ -236,6 +237,13 @@ config MMU
>>  	  Select if you want MMU-based virtualised addressing space
>>  	  support by paged memory management. If unsure, say 'Y'.
>>  
>> +config NOMMU
>> +	depends on !MMU
>> +	bool "NOMMU kernel (DEPRECATED)"
>> +	help
>> +	  NOMMU kernel is deprecated and is scheduled for removal by
>> +	  the beginning of 2027.
>> +
> 
> The idiomatic way to display this kind of warning is a comment directive:
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d4e890fb5b5a..b736440ce0f7 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -248,6 +248,9 @@ config MMU
>           Select if you want MMU-based virtualised addressing space
>           support by paged memory management. If unsure, say 'Y'.
> 
> +comment "NOMMU support is deprecated (scheduled for removal in 2027)"
> +       depends on !MMU
> +

Thanks, I was not able to find any example of such usage.

Clément

>  config PAGE_OFFSET
>         hex
>         default 0xC0000000 if 32BIT && MMU
> 
> Regards,
> Samuel
> 
>>  config PAGE_OFFSET
>>  	hex
>>  	default 0xC0000000 if 32BIT && MMU
>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>> index 4f73c0ae44b2..8799816ef0a6 100644
>> --- a/arch/riscv/kernel/setup.c
>> +++ b/arch/riscv/kernel/setup.c
>> @@ -295,6 +295,10 @@ void __init setup_arch(char **cmdline_p)
>>  	riscv_set_dma_cache_alignment();
>>  
>>  	riscv_user_isa_enable();
>> +
>> +#if !defined(CONFIG_MMU)
>> +	pr_err("RISC-V NOMMU support is deprecated and scheduled for removal by the beginning of 2027\n");
>> +#endif
>>  }
>>  
>>  bool arch_cpu_is_hotpluggable(int cpu)
> 

