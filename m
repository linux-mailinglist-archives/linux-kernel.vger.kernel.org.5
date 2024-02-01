Return-Path: <linux-kernel+bounces-48251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE0C845922
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8F628AEE9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6168F5CDE8;
	Thu,  1 Feb 2024 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="zf4f5JhU"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415245CDE2
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706795038; cv=none; b=SNIqD5Qm2LQ351LJw4jhJuK+j+LndGeBQFlTML3NwxwpnNSZljPsqASu9P9st0sfBxni+iQi12OUjigZQ4I5gvsKfr+HhSG9qdmObijooVkqisxmnioBO/o2rBQciR0RGd4dKItT8W+LDy+B4ekjdXVHFR2+TOoLd9Ba9Hu+pXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706795038; c=relaxed/simple;
	bh=KJbpMJIDVdFb/1RNgHsvpCts/VKtvvjd7llQmrTcWZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=baCqHRXBfP3a5Z8pUNXkOrX+f0qRm1F5CuWJ+375FCMB48yTOKWo3/i9I8BxgfkIX6tH2qU6V3r8Ijkodg5HB5kCFJcqOAglANJi4DMCddJJ45XM0fjynX3eO6DFalC5fqqDdP1XuNsi707vLjYOuyNeCZ7LkrqKHFrDHB96dYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=zf4f5JhU; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7bff2f6080aso4057939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 05:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706795035; x=1707399835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KyJgY7BtPARQUZY6lELkeOQOV8fvL5HnZ8zoDjrDJkg=;
        b=zf4f5JhUgiNbQ3/aWwiAORa9J4K6E6EgtVAIPEDyVYWpYjDwZ70ZKGsjNxYr9QzUC8
         43epSdOv83lZ7In2EX63lgqHwS4CZvHfkGCDdFautjMTvBO1IfaPJHAzb56tHTu9uVfD
         nJ2GO0M6ar2ynZsQklcK/quznZKnnHWxsMCV823UuMdUTFjEf2V7ScLkVcG7qxmgnjnK
         KRjJcCXIm/QlGu+6RAEf9yL7vvhMo06zOvAQS3PDNSzz+eSeMLTR/g7YmDBCDF0YxfOx
         tc1wf8+jPt+mesI39dSOz/eHWI1AUSG1+iwetcEBDjYQlvrp/7eAGmrtrMR+uwH0uFny
         T05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706795035; x=1707399835;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KyJgY7BtPARQUZY6lELkeOQOV8fvL5HnZ8zoDjrDJkg=;
        b=jM/LhXUQc0ap7HoPP/YL5Q7/EBKo8b0QPq39lKWRg3xar7+dmOFbXnd/vPM7WDSvgF
         sutnn1VsVo2GCtQ3xYnzYL6WDEIduaX1wOhnzYxO+Ez7kg7vZLxKFCX8eiYv8OP/xgCJ
         /oGovWarksfRv/RiYpNddWnLsiijl5WguOWBJZqyaa0lSXW4xzmK56JqFdhe5n0ef4Ri
         pKcyMHF8Uh5SmNsrE0nlXjvUA2pqSbCYfkvtgsCq7mkt2rpxJ1oG4cjfFtQthT/6Ahdu
         ZS23fAeUjmSYzP4t08hUVcoYRh4c9w2QgHwl5JEAnAVZMCEJhTRXFqRYJrc47LoTbDtE
         f/5Q==
X-Forwarded-Encrypted: i=0; AJvYcCVkExcbNNmj2wAJUZzhFc0L4ssBw2Xn1NplICrq6tTE3ZLWu6rOts9kQzcbB4nrjJx/Izjmi1r+EBNSDz+qDUB0xH2TvaG8hPO3Z79P
X-Gm-Message-State: AOJu0YxiiTZ4wtvpdvmmIg1SClworOthIEcPzjlMgiCes9U1lFLedJTW
	S61Y8YxPCqTX8bYt18eA/GNMqZgzp5WAzYBCg/SiUPESauc+MGRJkJ8BYfWrmfUeBVbGcl/4zoQ
	X
X-Google-Smtp-Source: AGHT+IGF9pFocTTyfuBz2hpTG0KD/XMVrNckwQlqP6WmNJAP+YRAQj1lXcnJI1tYZs7rtB9jn+eQ1g==
X-Received: by 2002:a05:6e02:2188:b0:363:8fa8:1c69 with SMTP id j8-20020a056e02218800b003638fa81c69mr5600066ila.2.1706795035164;
        Thu, 01 Feb 2024 05:43:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU4b5pmsyNOBSC/aHK766NQrc86SqB0LUf9wDrm/niIS1ET0Z2o/Nu4bTbrwHT3Ywgig4ePbUj30RvgeotX47o39Pt2p34dFyCLc+bFwBCr3IJtKds7D19Y98fDA8wXpJ4wpWtxXGY30Mfs5qODqJVSToPgjCCPK49M6hONichwasdcYj0nENcOAzQwtFDmMXuDcdXGhIMinsfZybmE3O4o49OgjGXTQQdUum87uGO1uBsJM5cDRsjn
Received: from ?IPV6:2a01:e0a:999:a3a0:189:f9cd:e10f:7a3f? ([2a01:e0a:999:a3a0:189:f9cd:e10f:7a3f])
        by smtp.gmail.com with ESMTPSA id a15-20020a631a0f000000b005c662e103a1sm12463130pga.41.2024.02.01.05.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 05:43:54 -0800 (PST)
Message-ID: <48e6b009-c79c-4a2e-a532-e46c7b8b6fc8@rivosinc.com>
Date: Thu, 1 Feb 2024 14:43:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] riscv: Disable misaligned access probe when
 CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240131-disable_misaligned_probe_config-v1-0-98d155e9cda8@rivosinc.com>
 <20240131-disable_misaligned_probe_config-v1-2-98d155e9cda8@rivosinc.com>
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20240131-disable_misaligned_probe_config-v1-2-98d155e9cda8@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 01/02/2024 07:40, Charlie Jenkins wrote:
> When CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is selected, the cpus can be
> set to have fast misaligned access without needing to probe.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/include/asm/cpufeature.h  | 7 +++++++
>  arch/riscv/kernel/cpufeature.c       | 4 ++++
>  arch/riscv/kernel/sys_hwprobe.c      | 4 ++++
>  arch/riscv/kernel/traps_misaligned.c | 4 ++++
>  4 files changed, 19 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> index dfdcca229174..7d8d64783e38 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -137,10 +137,17 @@ static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsi
>  	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
>  }
>  
> +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>  DECLARE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
>  
>  static __always_inline bool has_fast_misaligned_accesses(void)
>  {
>  	return static_branch_likely(&fast_misaligned_access_speed_key);
>  }
> +#else
> +static __always_inline bool has_fast_misaligned_accesses(void)
> +{
> +	return true;
> +}
> +#endif
>  #endif
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 89920f84d0a3..d787846c0b68 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -43,10 +43,12 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
>  /* Per-cpu ISA extensions. */
>  struct riscv_isainfo hart_isa[NR_CPUS];
>  
> +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>  /* Performance information */
>  DEFINE_PER_CPU(long, misaligned_access_speed);
>  
>  static cpumask_t fast_misaligned_access;
> +#endif
>  
>  /**
>   * riscv_isa_extension_base() - Get base extension word
> @@ -706,6 +708,7 @@ unsigned long riscv_get_elf_hwcap(void)
>  	return hwcap;
>  }
>  
> +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>  static int check_unaligned_access(void *param)
>  {
>  	int cpu = smp_processor_id();
> @@ -946,6 +949,7 @@ static int check_unaligned_access_all_cpus(void)
>  }
>  
>  arch_initcall(check_unaligned_access_all_cpus);
> +#endif /* CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS */
>  
>  void riscv_user_isa_enable(void)
>  {

Hi Charlie,

Generally, having so much ifdef in various pieces of code is probably
not a good idea.

AFAICT, if CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is enabled, the whole
misaligned access speed checking could be opt-out. which means that
probably everything related to misaligned accesses should be moved in
it's own file build it only for CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=n
only.

> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> index a7c56b41efd2..3f1a6edfdb08 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -149,6 +149,7 @@ static bool hwprobe_ext0_has(const struct cpumask *cpus, unsigned long ext)
>  
>  static u64 hwprobe_misaligned(const struct cpumask *cpus)
>  {
> +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>  	int cpu;
>  	u64 perf = -1ULL;
>  
> @@ -168,6 +169,9 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
>  		return RISCV_HWPROBE_MISALIGNED_UNKNOWN;
>  
>  	return perf;
> +#else
> +	return RISCV_HWPROBE_MISALIGNED_FAST;
> +#endif
>  }
>  
>  static void hwprobe_one_pair(struct riscv_hwprobe *pair,
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned> index 8ded225e8c5b..c24f79d769f6 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -413,7 +413,9 @@ int handle_misaligned_load(struct pt_regs *regs)
>  
>  	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
>  
> +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>  	*this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_EMULATED;
> +#endif

I think that rather using ifdefery inside this file (traps_misaligned.c)
 it can be totally opt-out in case we have
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS since it implies that misaligned
accesses are not emulated (at least that is my understanding).

Thanks,

Clément


>  
>  	if (!unaligned_enabled)
>  		return -1;
> @@ -596,6 +598,7 @@ int handle_misaligned_store(struct pt_regs *regs)
>  	return 0;
>  }
>  
> +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>  bool check_unaligned_access_emulated(int cpu)
>  {
>  	long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
> @@ -640,6 +643,7 @@ void unaligned_emulation_finish(void)
>  	}
>  	unaligned_ctl = true;
>  }
> +#endif
>  
>  bool unaligned_ctl_available(void)
>  {
> 




