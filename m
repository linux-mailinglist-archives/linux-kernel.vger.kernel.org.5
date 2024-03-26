Return-Path: <linux-kernel+bounces-118309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E05788B787
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF891F37653
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C6312837E;
	Tue, 26 Mar 2024 02:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="iSfXUcQ0"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DA6128368
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 02:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711420770; cv=none; b=XU04B0drp7Ymj1N5awdr5nKT73ldwyFxVu2XUL755f2CUgvk1mPmaL2a1m7nvkoIsqLwallBVVcqPFGHZ7XTe5OZMjwULmCt9b4IsZawN0yf2IEwtH3c9dDpJ86398kLxW+0a2bxgdLDMgTzwWGbHiq7U+LkBbb/3T73wpJxzXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711420770; c=relaxed/simple;
	bh=zUMMYSTKNGKXkA4klgoSYnxSaopM3FNL66QpHVmfNgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d4niKqVd1uY1mS7LI1eTOCLWWUOyJKx0u73ZAOvpMdmNy+CiLHMJC/g123rIztj/k/UkNADisLBERK16j8Nlw6jzuqQLYk/0ZhvH/CDn/XSbbOj4TGq4Plj4v7VksFEFMJ2146OtYI+f36DhuDc13UXAcchCYFohL2FfI+oR7pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=iSfXUcQ0; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60a0579a968so53786647b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711420768; x=1712025568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4AgrCK3LU8fuZoVf5zgRFHwqwQjRIG9mTqB1m/TopnI=;
        b=iSfXUcQ0sfhhdScDzfGmkMPl6Qn11l26Math5ZKPz5RfF0izu9Yo+8MdgtMix0eHCV
         UXdhjFw9w8WTILude9R96aveS2qqKxtccuD8eawxjXB8k/Upt2skb+TLx76Jz5atBFOS
         ffPgR/+4krfUUvfdfsR9R/bOTHFDLi8E6/A1s5OcT8gsBfAy3RukHehu8oZeOO0MjGu1
         E35yEH0YkLY6sKas02TqBxQTBJct0POGIiXysrDPnhPJ+72QJddWFYUpDPUufX8F60z8
         zw9kM1azKxXtxQWLXjvu+qCM1im+k4jgFgvE/v1mhS51dXJPr+PjB7xySb+jC32fu3AY
         2enA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711420768; x=1712025568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4AgrCK3LU8fuZoVf5zgRFHwqwQjRIG9mTqB1m/TopnI=;
        b=RNIr2PG/jyiicgP8O05pcv0ki9HjV4ZDovxSxdU4FkHv+zxI8ZOG0uQViIahNtE178
         x2iIBQ+aW2NY64Zx3p4/du0gbg//Ncd14WJZenOvzONsuieBo6t1Ima3Zxvz9qWUo6UD
         CkwRxkcRMYjT66mh7WMygTKyT9okQJZvhkj6vvXcj9+EnLEIobEyNEJ60cUPmXh8f2i/
         KXJPpXffgOk/aNMve4LM8ut2bNoYp2CN1kBFk4erJzf0spQHCsGz06GeXZ9R1/e2485i
         wyABxG0u8FW6uNMpQdfiMrNbJneFJaINJ1olOyOdQY/w7l+x1Sm3+kFTZQ/EzgVCIdq/
         j1xA==
X-Forwarded-Encrypted: i=1; AJvYcCVAEsHxPNvzkKsJw4Zn9VOihM0FE1o2FC1g3XufulGxqJSFMYifSxZeiCu28rU4JYVwnGRJAVFqPqNAJU0Ys8D+roqS6HpKcNxA1e7u
X-Gm-Message-State: AOJu0YzYK7CUw0mZ7se6YiaiKXACQ8wLFBqJ1SfmsUSAOv7n7i7serhk
	jDcXV4JyW3omK3U47WYrQKGZjD3wlRCYezAJRrt56IGxIzNWq5bFP4PmV8SIEfo=
X-Google-Smtp-Source: AGHT+IGhOODqIBgHDvsLlXa8CZ2AvqOoTdQC6r7LnHvkeyb4qLLlvDI6hphbf8OzjNSc06qsQlPQTQ==
X-Received: by 2002:a0d:e446:0:b0:610:f43d:6f9a with SMTP id n67-20020a0de446000000b00610f43d6f9amr6625429ywe.50.1711420768139;
        Mon, 25 Mar 2024 19:39:28 -0700 (PDT)
Received: from [100.64.0.1] ([136.226.86.189])
        by smtp.gmail.com with ESMTPSA id r19-20020a028813000000b00474a1ac6434sm2497058jai.162.2024.03.25.19.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 19:39:27 -0700 (PDT)
Message-ID: <b063df9b-90b6-4f06-8be5-5a8c267e6c8d@sifive.com>
Date: Mon, 25 Mar 2024 21:39:26 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] riscv: nommu: use CSR_TIME* for get_cycles*
 implementation
To: Jisheng Zhang <jszhang@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240325164021.3229-1-jszhang@kernel.org>
 <20240325164021.3229-3-jszhang@kernel.org>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240325164021.3229-3-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jisheng,

On 2024-03-25 11:40 AM, Jisheng Zhang wrote:
> Per riscv privileged spec, "The time CSR is a read-only shadow of the
> memory-mapped mtime register", "On RV32I the timeh CSR is a read-only
> shadow of the upper 32 bits of the memory-mapped mtime register, while
> time shadows only the lower 32 bits of mtime." Since get_cycles() only
> reads the timer, it's fine to use CSR_TIME to implement get_cycles().

Unfortunately there are various implementations (e.g. FU740/Unmatched, probably
K210 which this code was originally used for) which do not implement the time
CSR, relying on M-mode software to emulate the CSR so S-mode software doesn't
notice. So this code is needed to support those platforms when running Linux in
M-mode.

Maybe there should be an option to assume the time CSR is/is not implemented,
like there is for misaligned access?

Regards,
Samuel

> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/include/asm/timex.h | 40 ----------------------------------
>  1 file changed, 40 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
> index a06697846e69..a3fb85d505d4 100644
> --- a/arch/riscv/include/asm/timex.h
> +++ b/arch/riscv/include/asm/timex.h
> @@ -10,44 +10,6 @@
>  
>  typedef unsigned long cycles_t;
>  
> -#ifdef CONFIG_RISCV_M_MODE
> -
> -#include <asm/clint.h>
> -
> -#ifdef CONFIG_64BIT
> -static inline cycles_t get_cycles(void)
> -{
> -	return readq_relaxed(clint_time_val);
> -}
> -#else /* !CONFIG_64BIT */
> -static inline u32 get_cycles(void)
> -{
> -	return readl_relaxed(((u32 *)clint_time_val));
> -}
> -#define get_cycles get_cycles
> -
> -static inline u32 get_cycles_hi(void)
> -{
> -	return readl_relaxed(((u32 *)clint_time_val) + 1);
> -}
> -#define get_cycles_hi get_cycles_hi
> -#endif /* CONFIG_64BIT */
> -
> -/*
> - * Much like MIPS, we may not have a viable counter to use at an early point
> - * in the boot process. Unfortunately we don't have a fallback, so instead
> - * we just return 0.
> - */
> -static inline unsigned long random_get_entropy(void)
> -{
> -	if (unlikely(clint_time_val == NULL))
> -		return random_get_entropy_fallback();
> -	return get_cycles();
> -}
> -#define random_get_entropy()	random_get_entropy()
> -
> -#else /* CONFIG_RISCV_M_MODE */
> -
>  static inline cycles_t get_cycles(void)
>  {
>  	return csr_read(CSR_TIME);
> @@ -60,8 +22,6 @@ static inline u32 get_cycles_hi(void)
>  }
>  #define get_cycles_hi get_cycles_hi
>  
> -#endif /* !CONFIG_RISCV_M_MODE */
> -
>  #ifdef CONFIG_64BIT
>  static inline u64 get_cycles64(void)
>  {


