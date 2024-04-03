Return-Path: <linux-kernel+bounces-129977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 815308972C9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352941F2491B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B38258AD4;
	Wed,  3 Apr 2024 14:38:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309CB56751;
	Wed,  3 Apr 2024 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712155102; cv=none; b=iZQ8l0wl6DrJxq8IDqIv7BYPLWEveAHIKwXyhQjg9i4F/taslUPUagD5qsEQNbYqrsGXvTPWUwx6ADBMvl4Xuhixh8ESw+31Hfwa+A8UcVxx2XU+BqC38e1vcJTTYTDQpsquODfy5dHh9cfDMjHd/RfZNjyXP1n61eWxfAwKuVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712155102; c=relaxed/simple;
	bh=hfRqXl7ehF2sHdQ1hQLBRdQcRua85KKZsoNUiS1ESF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZQPC9LzFThiarJeAy0RGGH9eQf2Yk8ZApiZkZ5k1mzaKhzHpfjlNwkWIXfKZegt5Gk/W58Nhci5R+djvTosFkhUehbMFPXmbUrFaHGWhdggrKJBzrSOTPFwOsKaDxi5TM6MN8rPcQz8n4Dej+RE9ZYPZa7kHJmGdwSt38GqWiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A15131007;
	Wed,  3 Apr 2024 07:38:50 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.16.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58A0E3F7B4;
	Wed,  3 Apr 2024 07:38:17 -0700 (PDT)
Date: Wed, 3 Apr 2024 15:38:14 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: will@kernel.org, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	yangyicong@hisilicon.com, jonathan.cameron@huawei.com,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 10/10] perf/thunderx2: Avoid placing cpumask var on
 stack
Message-ID: <Zg1p1qsqDpmk62CH@FVFF77S0Q05N>
References: <20240403125109.2054881-1-dawei.li@shingroup.cn>
 <20240403125109.2054881-11-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403125109.2054881-11-dawei.li@shingroup.cn>

On Wed, Apr 03, 2024 at 08:51:09PM +0800, Dawei Li wrote:
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

The logic looks good to me, but I'd like the commit message updated the same as
per my comment on patch 2.

With that commit message:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  drivers/perf/thunderx2_pmu.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
> index e16d10c763de..b3377b662ffc 100644
> --- a/drivers/perf/thunderx2_pmu.c
> +++ b/drivers/perf/thunderx2_pmu.c
> @@ -932,9 +932,8 @@ static int tx2_uncore_pmu_online_cpu(unsigned int cpu,
>  static int tx2_uncore_pmu_offline_cpu(unsigned int cpu,
>  		struct hlist_node *hpnode)
>  {
> -	int new_cpu;
>  	struct tx2_uncore_pmu *tx2_pmu;
> -	struct cpumask cpu_online_mask_temp;
> +	unsigned int new_cpu;
>  
>  	tx2_pmu = hlist_entry_safe(hpnode,
>  			struct tx2_uncore_pmu, hpnode);
> @@ -945,11 +944,8 @@ static int tx2_uncore_pmu_offline_cpu(unsigned int cpu,
>  	if (tx2_pmu->hrtimer_callback)
>  		hrtimer_cancel(&tx2_pmu->hrtimer);
>  
> -	cpumask_copy(&cpu_online_mask_temp, cpu_online_mask);
> -	cpumask_clear_cpu(cpu, &cpu_online_mask_temp);
> -	new_cpu = cpumask_any_and(
> -			cpumask_of_node(tx2_pmu->node),
> -			&cpu_online_mask_temp);
> +	new_cpu = cpumask_any_and_but(cpumask_of_node(tx2_pmu->node),
> +				      cpu_online_mask, cpu);
>  
>  	tx2_pmu->cpu = new_cpu;
>  	if (new_cpu >= nr_cpu_ids)
> -- 
> 2.27.0
> 

