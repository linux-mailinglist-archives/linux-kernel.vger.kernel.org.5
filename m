Return-Path: <linux-kernel+bounces-129971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5128972AD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF4D2821F7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CD456751;
	Wed,  3 Apr 2024 14:33:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9B09461;
	Wed,  3 Apr 2024 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154804; cv=none; b=YSxqUwnY69aWHmAJB+7AZ1EK0CDAwyh6xSOqAwZfXCOjcl9poYpe+09a3RyIGD5i7XblyxPwKDpx8WmdLFdwV7VWzK1nWJ8DY7NAoE0mKcFOriwY/suSgCZbosPFmWTD8rhwwX96kJK0duFYUFWNFQrf+0ZOn8uKsqoGsaMGy/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154804; c=relaxed/simple;
	bh=HqsbniXj2szSUCBQwyicUfJM4X8Rqg2MGkEXTwj3m1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlAio50/5WnahzJ017BfILDaExYk9H+dFa21NiIgCBcV6uQFqKyVueAyB5vJY2h9+N4MsmNJ3hFrQgO/XhtmCcuRtwhU4H2TD59u1Z0DSCewS/QUak1uXlb5J5D4rTEmIuMbJZMfNQHUHfiVf43g8PlYOrJQAn9I91tltO/ZvVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E26F1007;
	Wed,  3 Apr 2024 07:33:53 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.16.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01C423F7B4;
	Wed,  3 Apr 2024 07:33:19 -0700 (PDT)
Date: Wed, 3 Apr 2024 15:33:17 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: will@kernel.org, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	yangyicong@hisilicon.com, jonathan.cameron@huawei.com,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 06/10] perf/dwc_pcie: Avoid placing cpumask var on
 stack
Message-ID: <Zg1orbZqAmVwm9s_@FVFF77S0Q05N>
References: <20240403125109.2054881-1-dawei.li@shingroup.cn>
 <20240403125109.2054881-7-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403125109.2054881-7-dawei.li@shingroup.cn>

On Wed, Apr 03, 2024 at 08:51:05PM +0800, Dawei Li wrote:
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
>  drivers/perf/dwc_pcie_pmu.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index 957058ad0099..c5e328f23841 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -690,9 +690,8 @@ static int dwc_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_n
>  {
>  	struct dwc_pcie_pmu *pcie_pmu;
>  	struct pci_dev *pdev;
> -	int node;
> -	cpumask_t mask;
>  	unsigned int target;
> +	int node;
>  
>  	pcie_pmu = hlist_entry_safe(cpuhp_node, struct dwc_pcie_pmu, cpuhp_node);
>  	/* Nothing to do if this CPU doesn't own the PMU */
> @@ -702,10 +701,9 @@ static int dwc_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_n
>  	pcie_pmu->on_cpu = -1;
>  	pdev = pcie_pmu->pdev;
>  	node = dev_to_node(&pdev->dev);
> -	if (cpumask_and(&mask, cpumask_of_node(node), cpu_online_mask) &&
> -	    cpumask_andnot(&mask, &mask, cpumask_of(cpu)))
> -		target = cpumask_any(&mask);
> -	else
> +
> +	target = cpumask_any_and_but(cpumask_of_node(node), cpu_online_mask, cpu);
> +	if (target >= nr_cpu_ids)
>  		target = cpumask_any_but(cpu_online_mask, cpu);
>  
>  	if (target >= nr_cpu_ids) {
> -- 
> 2.27.0
> 

