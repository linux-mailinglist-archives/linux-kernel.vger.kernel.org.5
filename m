Return-Path: <linux-kernel+bounces-129974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CD08972B5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57D261C26520
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A11558ACC;
	Wed,  3 Apr 2024 14:35:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3D057875;
	Wed,  3 Apr 2024 14:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154918; cv=none; b=Iep7MKxu1rbwd046w7zYJ7dPkP6tcaiIMf+vuLIvK6Q4TtnrNfKnU585SAoZC4OMkcfhfmBNHICugJP2uCbXZ80MSwl2hMxcweHtUXAQcJcqNEhw+1GCS+qWGKuXJp4cOKyFaRKQQliNmwtYmGPQ8ooT3mLJMz/J0ZXZAOJQCgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154918; c=relaxed/simple;
	bh=RTGore1mMiwZPaN2GqgBvhB6ZDNGVsnEsd/hvDoQcBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMVg58PGodaGKA8mz6u46tOfn++p+8TBdIta4AKxkY5kmS1PnakTxylQgL7C11bUZFZxvsPpDYDrBRodsY3MxBpSRhoHwWoQyYU3JdZezXinX1VgkZgdGDHcIjnn+4LU6riq17r9xISTU8ZOB6465ct0vvceyEhsYrOOhf9tt1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1B3D1007;
	Wed,  3 Apr 2024 07:35:46 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.16.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A9943F7B4;
	Wed,  3 Apr 2024 07:35:13 -0700 (PDT)
Date: Wed, 3 Apr 2024 15:35:10 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: will@kernel.org, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	yangyicong@hisilicon.com, jonathan.cameron@huawei.com,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 07/10] perf/hisi_pcie: Avoid placing cpumask var on
 stack
Message-ID: <Zg1pHsWnzczoXBb4@FVFF77S0Q05N>
References: <20240403125109.2054881-1-dawei.li@shingroup.cn>
 <20240403125109.2054881-8-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403125109.2054881-8-dawei.li@shingroup.cn>

On Wed, Apr 03, 2024 at 08:51:06PM +0800, Dawei Li wrote:
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
>  drivers/perf/hisilicon/hisi_pcie_pmu.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> index 5d1f0e9fdb08..06b192cc31d5 100644
> --- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> @@ -673,7 +673,6 @@ static int hisi_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
>  {
>  	struct hisi_pcie_pmu *pcie_pmu = hlist_entry_safe(node, struct hisi_pcie_pmu, node);
>  	unsigned int target;
> -	cpumask_t mask;
>  	int numa_node;
>  
>  	/* Nothing to do if this CPU doesn't own the PMU */
> @@ -684,10 +683,10 @@ static int hisi_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
>  
>  	/* Choose a local CPU from all online cpus. */
>  	numa_node = dev_to_node(&pcie_pmu->pdev->dev);
> -	if (cpumask_and(&mask, cpumask_of_node(numa_node), cpu_online_mask) &&
> -	    cpumask_andnot(&mask, &mask, cpumask_of(cpu)))
> -		target = cpumask_any(&mask);
> -	else
> +
> +	target = cpumask_any_and_but(cpumask_of_node(numa_node),
> +				     cpu_online_mask, cpu);
> +	if (target >= nr_cpu_ids)
>  		target = cpumask_any_but(cpu_online_mask, cpu);
>  
>  	if (target >= nr_cpu_ids) {
> -- 
> 2.27.0
> 

