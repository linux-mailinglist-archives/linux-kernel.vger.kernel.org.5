Return-Path: <linux-kernel+bounces-133162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43818899FCA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4271F23497
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0771516F919;
	Fri,  5 Apr 2024 14:30:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0464516F265;
	Fri,  5 Apr 2024 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327457; cv=none; b=FZm77f6kKtMRQifb6gbQeu4QBVC+dhVefvIDbEe8FiXaSeB/nPz2cnPezdGbXu2klsYf1IQnAawDm/K3imvGhHCvRkLe+HFg2zT/BV2FWibakf6Aj1f8XXjSdVNmjYRFEUWv3LHKklMhJBH622KK3voczaYD6eEIprr4Imk2khk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327457; c=relaxed/simple;
	bh=YFwqn7103KaIEJsbClKdLm4y4hgjLT+JwR9D/hbmpUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TVAsaG9euEPfl5DypwzPBGi5Zxp0M2KjLVULd+3IPiNgthmfDmaqJxRTDGnFVZTkV6AM6ZezVorqUO/p3ZfebES/u24AOs7fUFGTSn4aR8T2f3w7QKGSQ54qahVIuailY/KFKctZ845EPgjgWGQG/j2bevNXYshdGdAzeRKv0SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22A4CFEC;
	Fri,  5 Apr 2024 07:31:26 -0700 (PDT)
Received: from [10.57.54.111] (unknown [10.57.54.111])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D3883F7B4;
	Fri,  5 Apr 2024 07:30:53 -0700 (PDT)
Message-ID: <5ab9bd5b-87e9-4e09-af49-7f15b0cc48d5@arm.com>
Date: Fri, 5 Apr 2024 15:30:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] perf/arm-cmn: Avoid explicit cpumask var allocation
 from stack
Content-Language: en-GB
To: Dawei Li <dawei.li@shingroup.cn>, will@kernel.org, mark.rutland@arm.com
Cc: xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
 yangyicong@hisilicon.com, jonathan.cameron@huawei.com, andersson@kernel.org,
 konrad.dybcio@linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20240402105610.1695644-1-dawei.li@shingroup.cn>
 <20240402105610.1695644-3-dawei.li@shingroup.cn>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240402105610.1695644-3-dawei.li@shingroup.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-04-02 11:56 am, Dawei Li wrote:
> For CONFIG_CPUMASK_OFFSTACK=y kernel, explicit allocation of cpumask
> variable on stack is not recommended since it can cause potential stack
> overflow.
> 
> Instead, kernel code should always use *cpumask_var API(s) to allocate
> cpumask var in config- neutral way, leaving allocation strategy to
> CONFIG_CPUMASK_OFFSTACK.
> 
> Use *cpumask_var API(s) to address it.

I think the temporary mask may simply be redundant anyway. It seems like 
I may have misunderstood, and cpumask_of_node() actually only covers 
online CPUs already.

Thanks,
Robin.

> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> ---
>   drivers/perf/arm-cmn.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 7ef9c7e4836b..7278fd72d3da 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -1949,21 +1949,26 @@ static int arm_cmn_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_no
>   {
>   	struct arm_cmn *cmn;
>   	unsigned int target;
> +	cpumask_var_t mask;
>   	int node;
> -	cpumask_t mask;
>   
>   	cmn = hlist_entry_safe(cpuhp_node, struct arm_cmn, cpuhp_node);
>   	if (cpu != cmn->cpu)
>   		return 0;
>   
> +	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
> +		return 0;
> +
>   	node = dev_to_node(cmn->dev);
> -	if (cpumask_and(&mask, cpumask_of_node(node), cpu_online_mask) &&
> -	    cpumask_andnot(&mask, &mask, cpumask_of(cpu)))
> -		target = cpumask_any(&mask);
> +	if (cpumask_and(mask, cpumask_of_node(node), cpu_online_mask) &&
> +	    cpumask_andnot(mask, mask, cpumask_of(cpu)))
> +		target = cpumask_any(mask);
>   	else
>   		target = cpumask_any_but(cpu_online_mask, cpu);
>   	if (target < nr_cpu_ids)
>   		arm_cmn_migrate(cmn, target);
> +
> +	free_cpumask_var(mask);
>   	return 0;
>   }
>   

