Return-Path: <linux-kernel+bounces-94912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A358746A2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 567B91C209CA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F274E574;
	Thu,  7 Mar 2024 03:17:34 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13416DDA0;
	Thu,  7 Mar 2024 03:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709781454; cv=none; b=UlAc/8h/492MyzyssElW5knZs1uADQ2jkwwW3OeKWEuh7qQqSf4nrpDAlpexRoTSbcFZQ0s5dZGq31lWw24QSeqOcb7WDDDaPmXTt+qgacO4sKUkHPMq/OY5QkcLQGYCU5eP2a9kuMDO8jqbBqTOGKQakMKXU+WMgFO0YMCBe5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709781454; c=relaxed/simple;
	bh=hG07MMwwxNrLGh+Ju/nrlrkF9OW6RMbomlnLwNbs6Ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fd83mC4+7HzZJBONbksg9KU4crqa8VBOMfuDw13CQ8wkTY7CFhyld8oWHzv8L/jY959DmO1OEgybETHjDYmpE93OXjAsoasaBguEprp80ktMCb06EZx00i6V5yhlKH7tjCY9juzELbygmzyzfOQ9X7ooWcoFOqI1PT8YqD0G/C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TqvZX646Jz1xqN8;
	Thu,  7 Mar 2024 11:15:48 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 496811402CA;
	Thu,  7 Mar 2024 11:17:27 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 7 Mar
 2024 11:17:26 +0800
Message-ID: <3ed907bf-9526-3a46-41b9-8a0c747122f1@huawei.com>
Date: Thu, 7 Mar 2024 11:17:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 2/3] arm64: idle: Cache AMU counters before entering
 idle
To: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>, Beata Michalska
	<beata.michalska@arm.com>
CC: Ionela Voinescu <ionela.voinescu@arm.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<rafael@kernel.org>, <sumitg@nvidia.com>, <zengheng4@huawei.com>,
	<yang@os.amperecomputing.com>, <will@kernel.org>, <sudeep.holla@arm.com>,
	<liuyonglong@huawei.com>, <zhanjie9@hisilicon.com>,
	<linux-acpi@vger.kernel.org>
References: <20240229162520.970986-1-vanshikonda@os.amperecomputing.com>
 <20240229162520.970986-3-vanshikonda@os.amperecomputing.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20240229162520.970986-3-vanshikonda@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600004.china.huawei.com (7.193.23.242)


在 2024/3/1 0:25, Vanshidhar Konda 写道:
> AMU counters do not increment while a CPU is in idle. Saving the value
> of the core and constant counters prior to invoking WFI allows FIE to
> compute the frequency of a CPU that is idle.
>
> Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> ---
>   arch/arm64/kernel/idle.c     | 10 ++++++++++
>   arch/arm64/kernel/topology.c | 14 ++++++++------
>   2 files changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/kernel/idle.c b/arch/arm64/kernel/idle.c
> index 05cfb347ec26..5ed2e57188a8 100644
> --- a/arch/arm64/kernel/idle.c
> +++ b/arch/arm64/kernel/idle.c
> @@ -26,6 +26,16 @@ void __cpuidle cpu_do_idle(void)
>   
>   	arm_cpuidle_save_irq_context(&context);
>   
> +#ifdef CONFIG_ARM64_AMU_EXTN
> +	/* Update the AMU counters before entering WFI. The cached AMU counter
> +	 * value is used to determine CPU frequency while the CPU is idle
> +	 * without needing to wake up the CPU.
> +	 */
> +
> +	if (cpu_has_amu_feat(smp_processor_id()))
> +		update_freq_counters_refs();
> +#endif
The below point I has mentioned in [1].
This is just for the WFI state.
What about other deeper idle states, like retention and power down?
The path to enter idle state is different for them. We should do this 
for all idle states.

> +
>   	dsb(sy);
>   	wfi();
>   
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index db8d14525cf4..8905eb0c681f 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -240,13 +240,15 @@ unsigned int arch_freq_get_on_cpu(int cpu)
>   	} while (read_seqcount_retry(&cpu_sample->seq, seq));
>   
>   	/*
> -	 * Bail on invalid count and when the last update was too long ago,
> -	 * which covers idle and NOHZ full CPUs.
> +	 * Bail on invalid count and when the last update was too long ago.
> +	 * This covers idle, NOHZ full and isolated CPUs.
> +	 *
> +	 * Idle CPUs don't need to be measured because AMU counters stop
> +	 * incrementing during WFI/WFE.
>   	 */
> -	if (!delta_const_cnt || ((jiffies - last) > MAX_SAMPLE_AGE)) {
> -		if (!(housekeeping_cpu(cpu, HK_TYPE_TICK) && idle_cpu(cpu)))
> -			goto fallback;
> -	}
> +	if (!delta_const_cnt ||
> +	    ((jiffies - last) > MAX_SAMPLE_AGE && !idle_cpu(cpu)))
> +		goto fallback;
>   
>   	/*
>   	 * CPU frequency = reference perf (in Hz) * (/\ delivered) / (/\ reference)
[1] 
https://lore.kernel.org/linux-arm-kernel/20231212072617.14756-1-lihuisong@huawei.com/ 


