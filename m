Return-Path: <linux-kernel+bounces-152060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B918C8AB82A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 02:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBF401C20AD3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 00:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59085CB5;
	Sat, 20 Apr 2024 00:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="J87Pk0lQ"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C87A32
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 00:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713573429; cv=none; b=Ho5PIPiKH7NpENpph9P1q0100ukYICGFWEtHpVIM03KtuNB7F7ag4QAkt8jkQLsah6iTGTTWJnMSJHS7HKs2X0+GsBqcw0JkArLYjT4YNqDuGo5L/WcKX+0nDpzZbOD48eFEi9fHJYP6s7VeDot6u33+cugTDc7z9fhMg+7KeLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713573429; c=relaxed/simple;
	bh=JY998qjQNWwNGLXf2WAsCwsRZCjmE+YbFTuIjSuy7XA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h4CB5F2UlxKlBK/WEuKW3djPr96I81fOcuCF4ZjOJLi8AmgUnjNndBjH8NO46boVWHo4uRIzGh8JspGJCvITSd9v2N/ars1DI/qYq2KVRql0sVVyEo4Zh3GH8eBw+nepR/nsyeMwkQIQeJSVIcRU91Hi5ESOAIXtooQ8dDisLh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=J87Pk0lQ; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7d6c66b1e8aso105588639f.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 17:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1713573427; x=1714178227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vhcLlrujCFL5jsjyr5K82BE+eIjl1NtlFO4BV5YJoss=;
        b=J87Pk0lQfnbRaJMWNnYsftVIBN3XZ5aIuOeGiHiCpNO+W7rbP3kSu5TniFzlx7925/
         H8P/j3v3lx6VEjfcdIEl60SXNFpnvFDV5lIBjlmzIKyBvi2U9h6VicYVePGVaTSzgTns
         wEnV2zzRpFnNOKyAaLQ1La3zrRr79dZRk52MYpxt+HQBcBXUCxHECabuRJmMJNntc7Z2
         9ifwu7CEknlqQbAfF87IUOtWYmb7Gtwq74N4xCmk98ybW/IBLttXedi2X4+/0sZdTA/v
         e84+XFc/euWSkxnXPW9iOfg0IK7Vrc6FE6fqf7aNS5l12VUfpSUEPiB06d10N1bMqglz
         D03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713573427; x=1714178227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vhcLlrujCFL5jsjyr5K82BE+eIjl1NtlFO4BV5YJoss=;
        b=H/1YTH2dDTTF2chRp3B0RbK1IL9Uxue3fNqhupwXosqnH6gFBQWGC0pHB+jFnjaSiM
         hn70dHkbNVBEwub7Y2y1keQhQI6tutZO1HPJB4uINk15P9wH/sARKoCKWdyceAoDl5YM
         ijG9WWoWqjMso2V0hhVrY37oU8Gj9kURC6zlZ2lqK7TNvZcHAeGJMqAUDKCQ4iGpwbTy
         y7FnmM+VC179reb1kAiLd5T3EqUVOgu1SM08C2b09ViUrcdWTKVDnjMsSMpxHwsay/Hy
         tETAyN9rIrXwAHfqLqx4i8+7ZDD6xVQ3C3NV+KbiEiuzNEH9J1T8rzEKsKVngf8ZQTXb
         Griw==
X-Forwarded-Encrypted: i=1; AJvYcCW0FsWujUaScWcEnZvQ15b0W5y0D97V4Dt8uWA+HNNnCPT+0inKpDtMY5sUcs43Sn69IyJGuWcCvSWTFpbKhCMnLQakfkb7dlxr34rg
X-Gm-Message-State: AOJu0YxO4g9xXI9IeuRCJVZwpP+aEQTIEhXXX1/fXNghMlKJXWTchuUa
	Sqrlf12oFBaFogCqEPZ9qO81/Ct6WXgEua4O/ja1nHaZqP0XxwE8ZaFLwzuNWIk=
X-Google-Smtp-Source: AGHT+IHtrgB69K59tQny2VA0fIN2p3RzbXA0ZFndyB8V2oCD/yBJA3LSTlidjs+c33/HgDrnv1SH7A==
X-Received: by 2002:a05:6e02:1588:b0:36b:12f5:14dc with SMTP id m8-20020a056e02158800b0036b12f514dcmr4475746ilu.32.1713573426742;
        Fri, 19 Apr 2024 17:37:06 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.197])
        by smtp.gmail.com with ESMTPSA id u4-20020a056638134400b00484c44cf9cbsm953419jad.168.2024.04.19.17.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 17:37:06 -0700 (PDT)
Message-ID: <6fa06233-d572-48a7-a8ef-73a7c5879c06@sifive.com>
Date: Fri, 19 Apr 2024 19:37:03 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/24] drivers/perf: riscv: Fix counter mask iteration
 for RV32
To: Atish Patra <atishp@rivosinc.com>, linux-kernel@vger.kernel.org
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Anup Patel <anup@brainfault.org>,
 Conor Dooley <conor.dooley@microchip.com>, Juergen Gross <jgross@suse.com>,
 kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
 Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>,
 virtualization@lists.linux.dev, Will Deacon <will@kernel.org>, x86@kernel.org
References: <20240420151741.962500-1-atishp@rivosinc.com>
 <20240420151741.962500-9-atishp@rivosinc.com>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240420151741.962500-9-atishp@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Atish,

On 2024-04-20 10:17 AM, Atish Patra wrote:
> For RV32, used_hw_ctrs can have more than 1 word if the firmware chooses
> to interleave firmware/hardware counters indicies. Even though it's a
> unlikely scenario, handle that case by iterating over all the words
> instead of just using the first word.
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  drivers/perf/riscv_pmu_sbi.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index f23501898657..4eacd89141a9 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -652,10 +652,12 @@ static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
>  static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
>  {
>  	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
> +	int i;
>  
> -	/* No need to check the error here as we can't do anything about the error */
> -	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, 0,
> -		  cpu_hw_evt->used_hw_ctrs[0], 0, 0, 0, 0);
> +	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++)
> +		/* No need to check the error here as we can't do anything about the error */
> +		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, i * BITS_PER_LONG,
> +			  cpu_hw_evt->used_hw_ctrs[i], 0, 0, 0, 0);
>  }
>  
>  /*
> @@ -667,7 +669,7 @@ static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
>  static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
>  					       unsigned long ctr_ovf_mask)
>  {
> -	int idx = 0;
> +	int idx = 0, i;
>  	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
>  	struct perf_event *event;
>  	unsigned long flag = SBI_PMU_START_FLAG_SET_INIT_VALUE;
> @@ -676,11 +678,12 @@ static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
>  	struct hw_perf_event *hwc;
>  	u64 init_val = 0;
>  
> -	ctr_start_mask = cpu_hw_evt->used_hw_ctrs[0] & ~ctr_ovf_mask;
> -
> -	/* Start all the counters that did not overflow in a single shot */
> -	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, 0, ctr_start_mask,
> -		  0, 0, 0, 0);
> +	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
> +		ctr_start_mask = cpu_hw_evt->used_hw_ctrs[i] & ~ctr_ovf_mask;

This is applying the mask for the first 32 logical counters to the both sets of
32 logical counters. ctr_ovf_mask needs to be 64 bits wide here, so each loop
iteration can apply the correct half of the mask.

Regards,
Samuel

> +		/* Start all the counters that did not overflow in a single shot */
> +		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, i * BITS_PER_LONG, ctr_start_mask,
> +			0, 0, 0, 0);
> +	}
>  
>  	/* Reinitialize and start all the counter that overflowed */
>  	while (ctr_ovf_mask) {


