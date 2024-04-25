Return-Path: <linux-kernel+bounces-159116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769E08B299C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98E6A1C21A82
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC9915350E;
	Thu, 25 Apr 2024 20:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WXCCR6TV"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D141552F9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 20:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076289; cv=none; b=rIMo73jlbQMeGa1S8cOhH5qlTqNkiXFaz3OPFUzyWuIKT2U8Kmz9STmBiZkCxGTRpCQd6jkQnMP8io2/Jakr+7sGrwlT/UUM1/ltBmF00hbJPlBlDHC+Ogrz+Yfm+BZV8GqFW1rPx78O0rNkE9GeUYXP6MSs9ofn5T4LEeAhacc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076289; c=relaxed/simple;
	bh=padFErmop1Kx/Httft9bH2LI+EbM5jeRy/QYLOJ41lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awO+qwqWZxxXfyZYb64STGTFjQWEL0gNq/0dljm3X5thGtC2kHcXiDjvvyHgXVe9GT77Dw9N3Q8Oyu6dz9mH2RogHM0lCUJfR78Q0e0SxZFho31KxF2y5fOwjZ/c3rCm8Nn+/pboZICXwm9bmjX/EdeqrXAAl/5B6ru3BhF03VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=WXCCR6TV; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7da939572b5so57511939f.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 13:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1714076287; x=1714681087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XWjnmD221hSNpHNdFzITrd9KAsNvE8n3VYCb71ou0zo=;
        b=WXCCR6TVERWGjhfiIHOBEFmgdtRO+++eybN8sMp4hoA5CasdbJOHcSDkxKYOji1Bkx
         wTAreG6usQZUjlTB2S0BrD1OCkziKObUTlwMEiVyDkqtNhtLHnCWuUNN2kvlIN6DbfON
         Wa2yUMc6BuGGVobEs4XnVC69SBdHMYHj+hXlxIhJLc+g/qHpeBiuI+4TkfTlEbAKTGCR
         FNEhRLhTEm5QmQpFK+0ZlYsKqf05kWrOPHHF0yWlGykTgk7n54798GZlISTAwTEtftKX
         KZuvVXh8CWA3lR9Wo/0i6ZzoVJMA2OxkX3N6GCWYw7SAkww55xMMPa9pnFijTw5H2t4x
         yBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714076287; x=1714681087;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XWjnmD221hSNpHNdFzITrd9KAsNvE8n3VYCb71ou0zo=;
        b=ebFBqztyTP9kwDXo/HrqMWnMP6ljGCyO31fHw5+CVX/+coEiAAmvsFC6zDbvPgdbVh
         OZeH+y+FRNEvR9340VnG1qBigQoFR6QoKsB/vSv2NVj1f8ECw56diSFPAiV1Hf5Ob92l
         z4kTRFTNE/9OurMesZCAePqJxOGiQmhxqr1dAfDdWHOLvv3ub2HW9coVlsVjSIsoC+99
         oj1FJxAaR5TBYkpoJxHZrwTNv9VKqz/bRj+T05P3hrbuOd3NWlQYb3Ni6gzkJpJM+jE1
         GayuLVjea+dl7lScpwcOCgeYppUU+8dOObzlvR7hP6g6K1Z+SLd3LCR9jl9Db1EeXbpO
         2Hww==
X-Forwarded-Encrypted: i=1; AJvYcCUPCyG390+gRzfhRA/wqsddGY3QVv6E2/krG6O6sk44TddN1QFb7LQS1OJ2S72BBnk3VYmKL3rcB5DmsO5jVNj7WKAws+Rq9gEMZU6G
X-Gm-Message-State: AOJu0YwVrSx6c3nNgAF5XtUs7CIaGzuCj9+dtGZ2kPxdwqe/+BaOm6I1
	2uyMiM4O3rW1pxDAqXYYrHdyu+4ed2Bo0NVL+vYgvx1bgvXkYLBU9/rl5npxO/U=
X-Google-Smtp-Source: AGHT+IG8HmJjRXVqIOHll0Uudyp+Y7xrkp2bVDeg0wU13haKno9rciTyPNvJjg/aZDXKF1aDzgxtrg==
X-Received: by 2002:a6b:7b07:0:b0:7de:96b0:da89 with SMTP id l7-20020a6b7b07000000b007de96b0da89mr894274iop.6.1714076286907;
        Thu, 25 Apr 2024 13:18:06 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.197])
        by smtp.gmail.com with ESMTPSA id iq34-20020a056638842200b0048554c4b089sm2379582jab.72.2024.04.25.13.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 13:18:06 -0700 (PDT)
Message-ID: <4fa7ce5b-3ee3-4b04-a950-220eef6a633e@sifive.com>
Date: Thu, 25 Apr 2024 15:18:04 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-riscv/for-next 2/2] drivers/perf: riscv: Fix RV32 snapshot
 overflow use case
To: Atish Patra <atishp@rivosinc.com>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>,
 Conor Dooley <conor.dooley@microchip.com>, linux-riscv@lists.infradead.org,
 kvm-riscv@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20240425232933.4111680-1-atishp@rivosinc.com>
 <20240425232933.4111680-3-atishp@rivosinc.com>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240425232933.4111680-3-atishp@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-04-25 6:29 PM, Atish Patra wrote:
> The shadow copy alogirthm is implemented incorrectly. This patch fixes
> the behavior by keeping a per cpu shadow copy of the counter values to
> avoid clobbering for the cases where system more than XLEN counters and
> the overflown counter index are beyond XLEN. This issue can only be
> observed only in RV32 if an SBI implementation assigns logical counters
> ids greater than XLEN or firmware counter overflow is supported in the
> future.
> 
> Fixes : commit 22f5dac41004d ("drivers/perf: riscv: Implement SBI PMU snapshot function")

Same comment as for patch 1. The logic looks correct as far as I can tell, so:

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>

One minor comment below.

> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  drivers/perf/riscv_pmu_sbi.c   | 49 +++++++++++++++++++---------------
>  include/linux/perf/riscv_pmu.h |  2 ++
>  2 files changed, 30 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 2694110f1cff..98aaeb13e9db 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -588,6 +588,7 @@ static int pmu_sbi_snapshot_setup(struct riscv_pmu *pmu, int cpu)
>  		return sbi_err_map_linux_errno(ret.error);
>  	}
>  
> +	memset(cpu_hw_evt->snapshot_cval_shcopy, 0, sizeof(u64) * RISCV_MAX_COUNTERS);
>  	cpu_hw_evt->snapshot_set_done = true;
>  
>  	return 0;
> @@ -605,7 +606,7 @@ static u64 pmu_sbi_ctr_read(struct perf_event *event)
>  	union sbi_pmu_ctr_info info = pmu_ctr_list[idx];
>  
>  	/* Read the value from the shared memory directly only if counter is stopped */
> -	if (sbi_pmu_snapshot_available() & (hwc->state & PERF_HES_STOPPED)) {
> +	if (sbi_pmu_snapshot_available() && (hwc->state & PERF_HES_STOPPED)) {
>  		val = sdata->ctr_values[idx];
>  		return val;
>  	}
> @@ -769,36 +770,38 @@ static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
>  	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
>  	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
>  	unsigned long flag = 0;
> -	int i;
> +	int i, idx;
>  	struct sbiret ret;
> -	unsigned long temp_ctr_values[64] = {0};
> -	unsigned long ctr_val, temp_ctr_overflow_mask = 0;
> +	u64 temp_ctr_overflow_mask = 0;
>  
>  	if (sbi_pmu_snapshot_available())
>  		flag = SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT;
>  
> +	/* Reset the shadow copy to avoid save/restore any value from previous overflow */
> +	memset(cpu_hw_evt->snapshot_cval_shcopy, 0, sizeof(u64) * RISCV_MAX_COUNTERS);
> +
>  	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
>  		/* No need to check the error here as we can't do anything about the error */
>  		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, i * BITS_PER_LONG,
>  				cpu_hw_evt->used_hw_ctrs[i], flag, 0, 0, 0);
>  		if (!ret.error && sbi_pmu_snapshot_available()) {
>  			/* Save the counter values to avoid clobbering */
> -			temp_ctr_values[i * BITS_PER_LONG + i] = sdata->ctr_values[i];
> -			/* Save the overflow mask to avoid clobbering */
> -			if (BIT(i) & sdata->ctr_overflow_mask)
> -				temp_ctr_overflow_mask |= BIT(i + i * BITS_PER_LONG);
> +			for_each_set_bit(idx, &cpu_hw_evt->used_hw_ctrs[i], BITS_PER_LONG) {
> +				cpu_hw_evt->snapshot_cval_shcopy[i * BITS_PER_LONG + idx] =
> +							sdata->ctr_values[idx];
> +				/* Save the overflow mask to avoid clobbering */
> +				if (BIT(idx) & sdata->ctr_overflow_mask)
> +					temp_ctr_overflow_mask |= BIT(idx + i * BITS_PER_LONG);

This is equivalent to doing

  temp_ctr_overflow_mask |= sdata->ctr_overflow_mask << (i * BITS_PER_LONG);

outside the for_each_set_bit() loop.

> +			}
>  		}
>  	}
>  
> -	/* Restore the counter values to the shared memory */
> +	/* Restore the counter values to the shared memory for used hw counters */
>  	if (sbi_pmu_snapshot_available()) {
> -		for (i = 0; i < 64; i++) {
> -			ctr_val = temp_ctr_values[i];
> -			if (ctr_val)
> -				sdata->ctr_values[i] = ctr_val;
> -			if (temp_ctr_overflow_mask)
> -				sdata->ctr_overflow_mask = temp_ctr_overflow_mask;
> -		}
> +		for_each_set_bit(idx, cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS)
> +			sdata->ctr_values[idx] = cpu_hw_evt->snapshot_cval_shcopy[idx];
> +		if (temp_ctr_overflow_mask)
> +			sdata->ctr_overflow_mask = temp_ctr_overflow_mask;
>  	}
>  }
>  
> @@ -850,7 +853,7 @@ static inline void pmu_sbi_start_ovf_ctrs_sbi(struct cpu_hw_events *cpu_hw_evt,
>  static inline void pmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_events *cpu_hw_evt,
>  						   u64 ctr_ovf_mask)
>  {
> -	int idx = 0;
> +	int i, idx = 0;
>  	struct perf_event *event;
>  	unsigned long flag = SBI_PMU_START_FLAG_INIT_SNAPSHOT;
>  	u64 max_period, init_val = 0;
> @@ -863,7 +866,7 @@ static inline void pmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_events *cpu_hw_
>  			hwc = &event->hw;
>  			max_period = riscv_pmu_ctr_get_width_mask(event);
>  			init_val = local64_read(&hwc->prev_count) & max_period;
> -			sdata->ctr_values[idx] = init_val;
> +			cpu_hw_evt->snapshot_cval_shcopy[idx] = init_val;
>  		}
>  		/*
>  		 * We do not need to update the non-overflow counters the previous
> @@ -871,10 +874,14 @@ static inline void pmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_events *cpu_hw_
>  		 */
>  	}
>  
> -	for (idx = 0; idx < BITS_TO_LONGS(RISCV_MAX_COUNTERS); idx++) {
> +	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
> +		/* Restore the counter values to relative indices for used hw counters */
> +		for_each_set_bit(idx, &cpu_hw_evt->used_hw_ctrs[i], BITS_PER_LONG)
> +			sdata->ctr_values[idx] =
> +					cpu_hw_evt->snapshot_cval_shcopy[idx + i * BITS_PER_LONG];
>  		/* Start all the counters in a single shot */
>  		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, idx * BITS_PER_LONG,
> -			  cpu_hw_evt->used_hw_ctrs[idx], flag, 0, 0, 0);
> +			  cpu_hw_evt->used_hw_ctrs[i], flag, 0, 0, 0);
>  	}
>  }
>  
> @@ -898,7 +905,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>  	int lidx, hidx, fidx;
>  	struct riscv_pmu *pmu;
>  	struct perf_event *event;
> -	unsigned long overflow;
> +	u64 overflow;
>  	u64 overflowed_ctrs = 0;
>  	struct cpu_hw_events *cpu_hw_evt = dev;
>  	u64 start_clock = sched_clock();
> diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
> index c3fa90970042..701974639ff2 100644
> --- a/include/linux/perf/riscv_pmu.h
> +++ b/include/linux/perf/riscv_pmu.h
> @@ -45,6 +45,8 @@ struct cpu_hw_events {
>  	phys_addr_t snapshot_addr_phys;
>  	/* Boolean flag to indicate setup is already done */
>  	bool snapshot_set_done;
> +	/* A shadow copy of the counter values to avoid clobbering during multiple SBI calls */
> +	u64 snapshot_cval_shcopy[RISCV_MAX_COUNTERS];
>  };
>  
>  struct riscv_pmu {


