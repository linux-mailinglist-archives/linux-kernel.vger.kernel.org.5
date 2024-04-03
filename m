Return-Path: <linux-kernel+bounces-129975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 684D08972B9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9932E1C20B0A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F130C58AD4;
	Wed,  3 Apr 2024 14:35:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2527A3611A;
	Wed,  3 Apr 2024 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154954; cv=none; b=ku+I58PWjUkfm4Z8ONuqvngzpAXp9Qf7nUeSTzjxgH6gln09ydPj/VM9fZnQGwtE3rL4J52gOUnS8m21eBx1GKTPo8IjxF+Hx3jM0TkW8mhKWS1uOajxWGWI7SpkPVt8vEXOFI86cu/mWav5rJh7pjHfDT2DYGzFu1EdgrTZMkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154954; c=relaxed/simple;
	bh=06xH8btY+Sogyray0F0vQ0Dv+k3Bwm/2CXLhjfYx/Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyNeN74jjSDklNdl77bOTff4725NRnnIC5AcOcbRCB5deY5tQXsr2eDuWJ2JysoAZpsyndR7Y58Jwqo8KfYnXKnLqr4OCGcsjpBUXEDZJf4BKHH705rmSOSdv2AdVQ3OZvMEy/FkBfB2mWcahdRFwJ2FK7fkFxzmFJ6GdruQCU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C5371007;
	Wed,  3 Apr 2024 07:36:23 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.16.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B12C3F7B4;
	Wed,  3 Apr 2024 07:35:49 -0700 (PDT)
Date: Wed, 3 Apr 2024 15:35:47 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: will@kernel.org, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	yangyicong@hisilicon.com, jonathan.cameron@huawei.com,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 08/10] perf/hisi_uncore: Avoid placing cpumask var on
 stack
Message-ID: <Zg1pQ_rnYyZe40_n@FVFF77S0Q05N>
References: <20240403125109.2054881-1-dawei.li@shingroup.cn>
 <20240403125109.2054881-9-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403125109.2054881-9-dawei.li@shingroup.cn>

On Wed, Apr 03, 2024 at 08:51:07PM +0800, Dawei Li wrote:
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
>  drivers/perf/hisilicon/hisi_uncore_pmu.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> index 04031450d5fe..ccc9191ad1b6 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> @@ -504,7 +504,6 @@ int hisi_uncore_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
>  {
>  	struct hisi_pmu *hisi_pmu = hlist_entry_safe(node, struct hisi_pmu,
>  						     node);
> -	cpumask_t pmu_online_cpus;
>  	unsigned int target;
>  
>  	if (!cpumask_test_and_clear_cpu(cpu, &hisi_pmu->associated_cpus))
> @@ -518,9 +517,8 @@ int hisi_uncore_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
>  	hisi_pmu->on_cpu = -1;
>  
>  	/* Choose a new CPU to migrate ownership of the PMU to */
> -	cpumask_and(&pmu_online_cpus, &hisi_pmu->associated_cpus,
> -		    cpu_online_mask);
> -	target = cpumask_any_but(&pmu_online_cpus, cpu);
> +	target = cpumask_any_and_but(&hisi_pmu->associated_cpus,
> +				     cpu_online_mask, cpu);
>  	if (target >= nr_cpu_ids)
>  		return 0;
>  
> -- 
> 2.27.0
> 

