Return-Path: <linux-kernel+bounces-129944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8040689725C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0B0F1C2646A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146621494C2;
	Wed,  3 Apr 2024 14:21:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062B4148FF5;
	Wed,  3 Apr 2024 14:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154077; cv=none; b=VDTQ6IQh2MMRrIIFcab86AXfEnXo/L2st2KdnkDiOxleAR3Y/LWNxBYLEw9640wYaeFyyVUuUAKaM1lbk5EFXmESTRZyU+1uL4CnebNwnN8VQKR3rti3tbpVUXQymDtKkziF/HSd7AtM8q8vcFmXEWnffv1AJkWigCNpyTDpj/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154077; c=relaxed/simple;
	bh=nqFwo/kHXwvxaX3Pir+qxJc7morMd5qBw4IR/1jIKSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GymRZjdYPtJv+vMdw4dOILRak3DPFq+QSh/xclZHabJDQUDX4hOSc6/bYEbUlnhw7z5+HUFFdZrwHvsnEtpdixMHpU4VZFvWsVYhJVN2Iq+Z+PFJQoPn077sejOfDSfBdCUvjg6q2uLZaX1KVvcV8A/0tIEMDa07l3OBYIG2iQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C79E1007;
	Wed,  3 Apr 2024 07:21:46 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.16.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 226733F7B4;
	Wed,  3 Apr 2024 07:21:12 -0700 (PDT)
Date: Wed, 3 Apr 2024 15:21:10 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: will@kernel.org, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	yangyicong@hisilicon.com, jonathan.cameron@huawei.com,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 04/10] perf/arm_cspmu: Avoid placing cpumask var on
 stack
Message-ID: <Zg1l1pxmLoHztM6Q@FVFF77S0Q05N>
References: <20240403125109.2054881-1-dawei.li@shingroup.cn>
 <20240403125109.2054881-5-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403125109.2054881-5-dawei.li@shingroup.cn>

On Wed, Apr 03, 2024 at 08:51:03PM +0800, Dawei Li wrote:
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
> 
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>

The logic looks good to me, but I'd like the commit message updated the same as
per my comment on patch 2.

With that commit message:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  drivers/perf/arm_cspmu/arm_cspmu.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index b9a252272f1e..fd1004251665 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -1322,8 +1322,7 @@ static int arm_cspmu_cpu_online(unsigned int cpu, struct hlist_node *node)
>  
>  static int arm_cspmu_cpu_teardown(unsigned int cpu, struct hlist_node *node)
>  {
> -	int dst;
> -	struct cpumask online_supported;
> +	unsigned int dst;
>  
>  	struct arm_cspmu *cspmu =
>  		hlist_entry_safe(node, struct arm_cspmu, cpuhp_node);
> @@ -1333,9 +1332,8 @@ static int arm_cspmu_cpu_teardown(unsigned int cpu, struct hlist_node *node)
>  		return 0;
>  
>  	/* Choose a new CPU to migrate ownership of the PMU to */
> -	cpumask_and(&online_supported, &cspmu->associated_cpus,
> -		    cpu_online_mask);
> -	dst = cpumask_any_but(&online_supported, cpu);
> +	dst = cpumask_any_and_but(&cspmu->associated_cpus,
> +				  cpu_online_mask, cpu);
>  	if (dst >= nr_cpu_ids)
>  		return 0;
>  
> -- 
> 2.27.0
> 

