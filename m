Return-Path: <linux-kernel+bounces-129968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DFA8972B1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1F16B276B5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2747C43AB6;
	Wed,  3 Apr 2024 14:32:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4052FD272;
	Wed,  3 Apr 2024 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154729; cv=none; b=C+pX+icBgkaK37RYuW7+uwmNO+W3XJPEet0eeCjd8PExRvitTLlqDBjd2zUaVJSPsusG6vFCxPxOmfgQXWX3cCJy8nHODQR3U3EHhV/DbB3aCa10Ya2QaemDqHJRbD6WInWbLSJrRj18gBH28oW41kTWpJu3GkWhP7znRSK1hJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154729; c=relaxed/simple;
	bh=IfavOBHuNBC7BA6z+t/e9bZRoESBeEMspQVXwHiTgtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgyj43GdJcYpqvFuaQeKsC7TXazfjB2J2rusqURVCvQ8eTU8SugUIBYDCXcPo16yQ0PgyaYOpzeVY9YM5fjEvKyZ8b7DxgsAIC3Lwuq30Ex9NEpxNx9DpNos3A105PAbtOPE5PYEHXoYE4IDu068HEa1Sivu5HCSNb6ExFVZORE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B81511007;
	Wed,  3 Apr 2024 07:32:38 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.16.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C8843F7B4;
	Wed,  3 Apr 2024 07:32:05 -0700 (PDT)
Date: Wed, 3 Apr 2024 15:32:02 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: will@kernel.org, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	yangyicong@hisilicon.com, jonathan.cameron@huawei.com,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 05/10] perf/arm_dsu: Avoid placing cpumask var on stack
Message-ID: <Zg1oYr3DyEL3gTV7@FVFF77S0Q05N>
References: <20240403125109.2054881-1-dawei.li@shingroup.cn>
 <20240403125109.2054881-6-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403125109.2054881-6-dawei.li@shingroup.cn>

On Wed, Apr 03, 2024 at 08:51:04PM +0800, Dawei Li wrote:
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
>  drivers/perf/arm_dsu_pmu.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
> index bae3ca37f846..adc0bbb5fafe 100644
> --- a/drivers/perf/arm_dsu_pmu.c
> +++ b/drivers/perf/arm_dsu_pmu.c
> @@ -230,15 +230,6 @@ static const struct attribute_group *dsu_pmu_attr_groups[] = {
>  	NULL,
>  };
>  
> -static int dsu_pmu_get_online_cpu_any_but(struct dsu_pmu *dsu_pmu, int cpu)
> -{
> -	struct cpumask online_supported;
> -
> -	cpumask_and(&online_supported,
> -			 &dsu_pmu->associated_cpus, cpu_online_mask);
> -	return cpumask_any_but(&online_supported, cpu);
> -}
> -
>  static inline bool dsu_pmu_counter_valid(struct dsu_pmu *dsu_pmu, u32 idx)
>  {
>  	return (idx < dsu_pmu->num_counters) ||
> @@ -827,14 +818,16 @@ static int dsu_pmu_cpu_online(unsigned int cpu, struct hlist_node *node)
>  
>  static int dsu_pmu_cpu_teardown(unsigned int cpu, struct hlist_node *node)
>  {
> -	int dst;
> -	struct dsu_pmu *dsu_pmu = hlist_entry_safe(node, struct dsu_pmu,
> -						   cpuhp_node);
> +	struct dsu_pmu *dsu_pmu;
> +	unsigned int dst;
> +
> +	dsu_pmu = hlist_entry_safe(node, struct dsu_pmu, cpuhp_node);
>  
>  	if (!cpumask_test_and_clear_cpu(cpu, &dsu_pmu->active_cpu))
>  		return 0;
>  
> -	dst = dsu_pmu_get_online_cpu_any_but(dsu_pmu, cpu);
> +	dst = cpumask_any_and_but(&dsu_pmu->associated_cpus,
> +				  cpu_online_mask, cpu);
>  	/* If there are no active CPUs in the DSU, leave IRQ disabled */
>  	if (dst >= nr_cpu_ids)
>  		return 0;
> -- 
> 2.27.0
> 

