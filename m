Return-Path: <linux-kernel+bounces-129976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4F98972D7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25D68B29FF8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4690C59B6C;
	Wed,  3 Apr 2024 14:36:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F7B56751;
	Wed,  3 Apr 2024 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154997; cv=none; b=L9kFmEPWlk2lFi2vrJ15bvTGiKeO4TLLvZgKjxi4T88plfF6AX0NyCPRVcH+3P5WvJULIV+1XaO7HU1buHVxWUEvSIAjr0Z3QM+Tzaq0uEKO/J/umvw27WLh3FV7tGmCm4KOvxUz9EUv+ua8iCpQu77Qd9CgkXtx8t/xsqUMgeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154997; c=relaxed/simple;
	bh=T5ZryUJySmkQGCGluVYgzILkh9NuHRn6+M5l9AwVKbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTbl/ycZRUaORp7OuZKjEMfgO0cmavJo5VaxpX4aDYaeJ7VdGliDU38k9LXgXUKbEg01LnqResIc8OXIYHRUOYWSJo9UhV9hzHxgc70oXrNslcfhej5GWLeV3DoxHOLeZQ675//tEITSBexqyUtSt3ULronje9vdffzR0fUsaX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1C301007;
	Wed,  3 Apr 2024 07:37:06 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.16.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 793C43F7B4;
	Wed,  3 Apr 2024 07:36:33 -0700 (PDT)
Date: Wed, 3 Apr 2024 15:36:30 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: will@kernel.org, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	yangyicong@hisilicon.com, jonathan.cameron@huawei.com,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 09/10] perf/qcom_l2: Avoid placing cpumask var on stack
Message-ID: <Zg1pbiEoSSWveqoj@FVFF77S0Q05N>
References: <20240403125109.2054881-1-dawei.li@shingroup.cn>
 <20240403125109.2054881-10-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403125109.2054881-10-dawei.li@shingroup.cn>

On Wed, Apr 03, 2024 at 08:51:08PM +0800, Dawei Li wrote:
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
>  drivers/perf/qcom_l2_pmu.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
> index 148df5ae8ef8..b5a44dc1dc3a 100644
> --- a/drivers/perf/qcom_l2_pmu.c
> +++ b/drivers/perf/qcom_l2_pmu.c
> @@ -801,9 +801,8 @@ static int l2cache_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
>  
>  static int l2cache_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
>  {
> -	struct cluster_pmu *cluster;
>  	struct l2cache_pmu *l2cache_pmu;
> -	cpumask_t cluster_online_cpus;
> +	struct cluster_pmu *cluster;
>  	unsigned int target;
>  
>  	l2cache_pmu = hlist_entry_safe(node, struct l2cache_pmu, node);
> @@ -820,9 +819,8 @@ static int l2cache_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
>  	cluster->on_cpu = -1;
>  
>  	/* Any other CPU for this cluster which is still online */
> -	cpumask_and(&cluster_online_cpus, &cluster->cluster_cpus,
> -		    cpu_online_mask);
> -	target = cpumask_any_but(&cluster_online_cpus, cpu);
> +	target = cpumask_any_and_but(&cluster->cluster_cpus,
> +				     cpu_online_mask, cpu);
>  	if (target >= nr_cpu_ids) {
>  		disable_irq(cluster->irq);
>  		return 0;
> -- 
> 2.27.0
> 

