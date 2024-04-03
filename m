Return-Path: <linux-kernel+bounces-129953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435AC897272
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74AE51C219EF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D1B1494A3;
	Wed,  3 Apr 2024 14:23:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4427172B;
	Wed,  3 Apr 2024 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154212; cv=none; b=l4wflsM7zIZPuizeNYNr8ReDy1Mtci3c4fXncyx7W/A/kkj9J0RUSiQL6VVrkJ4SVcpH2ddGReEONLU0ap/7GcOyTQAgWn9ocWMHfHicSLRzIRNe19SmFw2gbcqRHTSJg5p5yVFbamSUCknr//15E5qhpJ1AfqHWwVSjet39Frk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154212; c=relaxed/simple;
	bh=SFg47yxUbctV3PGgM85vXl4SA4wjFf1zK2RoTvmRxXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F12na4f+sJEGmhTTodA9Y/yBIW4fYaDGxSX+2J7+IXvod24zGNdw1Od7BhERbo89eOaF7Na0tNk60TL3xKBrQAcRgE4RjSoeSrJrltzFghnLGOtWFU9pnNvwPCkx7ywZF9JU9y7F7p9nqn35O95SXkqedQzU8CkXqqJm5mHRHqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A7ED1007;
	Wed,  3 Apr 2024 07:24:00 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.16.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE21D3F7B4;
	Wed,  3 Apr 2024 07:23:26 -0700 (PDT)
Date: Wed, 3 Apr 2024 15:23:24 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: will@kernel.org, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	yangyicong@hisilicon.com, jonathan.cameron@huawei.com,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 03/10] perf/arm-cmn: Avoid placing cpumask var on stack
Message-ID: <Zg1mXESq2BP8B0yz@FVFF77S0Q05N>
References: <20240403125109.2054881-1-dawei.li@shingroup.cn>
 <20240403125109.2054881-4-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403125109.2054881-4-dawei.li@shingroup.cn>

On Wed, Apr 03, 2024 at 08:51:02PM +0800, Dawei Li wrote:
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
>  drivers/perf/arm-cmn.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 7ef9c7e4836b..6bfb0c4a1287 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -1950,20 +1950,20 @@ static int arm_cmn_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_no
>  	struct arm_cmn *cmn;
>  	unsigned int target;
>  	int node;
> -	cpumask_t mask;
>  
>  	cmn = hlist_entry_safe(cpuhp_node, struct arm_cmn, cpuhp_node);
>  	if (cpu != cmn->cpu)
>  		return 0;
>  
>  	node = dev_to_node(cmn->dev);
> -	if (cpumask_and(&mask, cpumask_of_node(node), cpu_online_mask) &&
> -	    cpumask_andnot(&mask, &mask, cpumask_of(cpu)))
> -		target = cpumask_any(&mask);
> -	else
> +
> +	target = cpumask_any_and_but(cpumask_of_node(node), cpu_online_mask, cpu);
> +	if (target >= nr_cpu_ids)
>  		target = cpumask_any_but(cpu_online_mask, cpu);
> +
>  	if (target < nr_cpu_ids)
>  		arm_cmn_migrate(cmn, target);
> +
>  	return 0;
>  }
>  
> -- 
> 2.27.0
> 

