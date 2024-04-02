Return-Path: <linux-kernel+bounces-127823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D92B189516F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78B0E1F254CC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA83604BB;
	Tue,  2 Apr 2024 11:07:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A8758AC3;
	Tue,  2 Apr 2024 11:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712056023; cv=none; b=XYjh5YTwHUa3XdqIPeZqmqrYh/X9ktCqaj8yrsrknWWSnZOVufZGna0f7r9U42N3UBSgJbS4pQX36rMCsEDLsPYiJEPdSbk+b8Ix3X9uESV32Q29AeNyvUtmbmhqCMo0P0kuuiBT8Jkpzw6cm7Xm5fqiD3GiQytS2MsIY3kgk28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712056023; c=relaxed/simple;
	bh=gLAAunGWwvRJHGizwYjm8QzkWNHBiV97BX0ZTwmQaiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6GEtouFP4XWdW3rVjGpVzTrpiKU2ERoJxEIgmZtp+mYCs0G8uXjL/0PtD4qLh4oqa3zLKp9MfTLhsjQ7CLS4Yp/nT7jLLgHlwi2oEuCYh2jFhIkgOK7nfZX/iXUy1loeXLpZ1WhMqaQwsjxfUBSOwPiRG/u2ngJl/oWHOZlyJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3879FEC;
	Tue,  2 Apr 2024 04:07:31 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.18.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26E383F766;
	Tue,  2 Apr 2024 04:06:58 -0700 (PDT)
Date: Tue, 2 Apr 2024 12:06:52 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: will@kernel.org, xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	yangyicong@hisilicon.com, jonathan.cameron@huawei.com,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/9] perf/alibaba_uncore_drw: Avoid explicit cpumask var
 allocation from stack
Message-ID: <ZgvmzKHD_wfdOLK2@FVFF77S0Q05N>
References: <20240402105610.1695644-1-dawei.li@shingroup.cn>
 <20240402105610.1695644-2-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402105610.1695644-2-dawei.li@shingroup.cn>

On Tue, Apr 02, 2024 at 06:56:02PM +0800, Dawei Li wrote:
> For CONFIG_CPUMASK_OFFSTACK=y kernel, explicit allocation of cpumask
> variable on stack is not recommended since it can cause potential stack
> overflow.
> 
> Instead, kernel code should always use *cpumask_var API(s) to allocate
> cpumask var in config- neutral way, leaving allocation strategy to
> CONFIG_CPUMASK_OFFSTACK.
> 
> Use *cpumask_var API(s) to address it.
> 
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> ---
>  drivers/perf/alibaba_uncore_drw_pmu.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
> index a9277dcf90ce..251f0a2dee84 100644
> --- a/drivers/perf/alibaba_uncore_drw_pmu.c
> +++ b/drivers/perf/alibaba_uncore_drw_pmu.c
> @@ -743,25 +743,28 @@ static void ali_drw_pmu_remove(struct platform_device *pdev)
>  
>  static int ali_drw_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
>  {
> +	cpumask_var_t node_online_cpus;
>  	struct ali_drw_pmu_irq *irq;
>  	struct ali_drw_pmu *drw_pmu;
>  	unsigned int target;
>  	int ret;
> -	cpumask_t node_online_cpus;
>  
>  	irq = hlist_entry_safe(node, struct ali_drw_pmu_irq, node);
>  	if (cpu != irq->cpu)
>  		return 0;
>  
> -	ret = cpumask_and(&node_online_cpus,
> +	if (!alloc_cpumask_var(&node_online_cpus, GFP_KERNEL))
> +		return 0;

NAK. This error path leaves things in an incorrect state and this approach does
not make sense.

Please allocate the cpumasks when we allocate the PMU. Then we can reasonably
fail to probe the PMU if we don't have enough memory, and the masks will
definitely be accessible in gotplug paths.

The same comment applies to the whole series.

Mark.

> +
> +	ret = cpumask_and(node_online_cpus,
>  			  cpumask_of_node(cpu_to_node(cpu)), cpu_online_mask);
>  	if (ret)
> -		target = cpumask_any_but(&node_online_cpus, cpu);
> +		target = cpumask_any_but(node_online_cpus, cpu);
>  	else
>  		target = cpumask_any_but(cpu_online_mask, cpu);
>  
>  	if (target >= nr_cpu_ids)
> -		return 0;
> +		goto __free_cpumask;
>  
>  	/* We're only reading, but this isn't the place to be involving RCU */
>  	mutex_lock(&ali_drw_pmu_irqs_lock);
> @@ -772,6 +775,8 @@ static int ali_drw_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
>  	WARN_ON(irq_set_affinity_hint(irq->irq_num, cpumask_of(target)));
>  	irq->cpu = target;
>  
> +__free_cpumask:
> +	free_cpumask_var(node_online_cpus);
>  	return 0;
>  }
>  
> -- 
> 2.27.0
> 

