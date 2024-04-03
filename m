Return-Path: <linux-kernel+bounces-129933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7CB897231
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBBC828C1BA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E867C1494D4;
	Wed,  3 Apr 2024 14:16:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B686168BD;
	Wed,  3 Apr 2024 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153797; cv=none; b=b+qXL1xQOmkQ70InSLwFD7P9RC7eUbRIeyFDtALG73nlIFcNjcJkE4vcnHRuFbvHc9gD05NDA3V0jmcUH6ivAWIWhgGfN3FtefdcFKtV9RletHAmZlQAR12/7U++0xM6JFrBVT5TplAkBFf1bZvgVaGGIDrt6tAOLODUHbRJPxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153797; c=relaxed/simple;
	bh=QVNG9klf635AF8QatLYX+kN3E3QTHjJIn6uyjkTeFnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejD7l6yCm9JT7jRyd/1XR1U75CoqXk3ivyHSS5JLodVbw1aniHEm1sv8dSpnh8s0UKyMPrUmr3tCXP6KMDa0SsQpfTdlgoOcMLIykIETWKixYtrOk9Gt1DPWO26LMnfEoPIqr1swJxQ9tu18rD6c+tzV4G/Zv+Me6VFpHESKd6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EE391007;
	Wed,  3 Apr 2024 07:17:05 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.16.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2070E3F7B4;
	Wed,  3 Apr 2024 07:16:31 -0700 (PDT)
Date: Wed, 3 Apr 2024 15:16:24 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: will@kernel.org, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	yangyicong@hisilicon.com, jonathan.cameron@huawei.com,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 02/10] perf/alibaba_uncore_drw: Avoid placing cpumask
 var on stack
Message-ID: <Zg1kuMCxcZWSnFdt@FVFF77S0Q05N>
References: <20240403125109.2054881-1-dawei.li@shingroup.cn>
 <20240403125109.2054881-3-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403125109.2054881-3-dawei.li@shingroup.cn>

On Wed, Apr 03, 2024 at 08:51:01PM +0800, Dawei Li wrote:
> For CONFIG_CPUMASK_OFFSTACK=y kernel, explicit allocation of cpumask
> variable on stack is not recommended since it can cause potential stack
> overflow.
> 
> Instead, kernel code should always use *cpumask_var API(s) to allocate
> cpumask var in config-neutral way, leaving allocation strategy to
> CONFIG_CPUMASK_OFFSTACK.
> 
> But dynamic allocation in cpuhp's teardown callback is somewhat problematic
> for if allocation fails(which is unlikely but still possible):
> - If -ENOMEM is returned to caller, kernel crashes for non-bringup
>   teardown;
> - If callback pretends nothing happened and returns 0 to caller, it may
>   trap system into an in-consisitent/compromised state;
> 
> Use newly-introduced cpumask_any_and_but() to address all issues above.
> It eliminates usage of temporary cpumask var in generic way, no matter how
> the cpumask var is allocated.
>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>

I don't think we need to explain all the pitfalls of the approach we haven't
taken. Could we please simplify this down to:

Could we please get rid of the bit that says we should "always use the
*cpumask_var API(s)", and simplify the commit message down to:

| perf/alibaba_uncore_drw: Avoid placing cpumask on the stack
| 
| In general it's preferable to avoid placing cpumasks on the stack, as
| for large values of NR_CPUS these can consume significant amounts of
| stack space and make stack overflows more likely.
| 
| Use cpumask_any_and_but() to avoid the need for a temporary cpumask on
| the stack.

The logic looks good to me, so with that commit message:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  drivers/perf/alibaba_uncore_drw_pmu.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
> index a9277dcf90ce..d4d14b65c4a5 100644
> --- a/drivers/perf/alibaba_uncore_drw_pmu.c
> +++ b/drivers/perf/alibaba_uncore_drw_pmu.c
> @@ -746,18 +746,14 @@ static int ali_drw_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
>  	struct ali_drw_pmu_irq *irq;
>  	struct ali_drw_pmu *drw_pmu;
>  	unsigned int target;
> -	int ret;
> -	cpumask_t node_online_cpus;
>  
>  	irq = hlist_entry_safe(node, struct ali_drw_pmu_irq, node);
>  	if (cpu != irq->cpu)
>  		return 0;
>  
> -	ret = cpumask_and(&node_online_cpus,
> -			  cpumask_of_node(cpu_to_node(cpu)), cpu_online_mask);
> -	if (ret)
> -		target = cpumask_any_but(&node_online_cpus, cpu);
> -	else
> +	target = cpumask_any_and_but(cpumask_of_node(cpu_to_node(cpu)),
> +				     cpu_online_mask, cpu);
> +	if (target >= nr_cpu_ids)
>  		target = cpumask_any_but(cpu_online_mask, cpu);
>  
>  	if (target >= nr_cpu_ids)
> -- 
> 2.27.0
> 

