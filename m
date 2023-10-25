Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942FE7D6999
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbjJYKyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbjJYKyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:54:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 824DD130;
        Wed, 25 Oct 2023 03:54:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E9FB2F4;
        Wed, 25 Oct 2023 03:55:04 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.69.205])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB5AF3F738;
        Wed, 25 Oct 2023 03:54:19 -0700 (PDT)
Date:   Wed, 25 Oct 2023 11:54:16 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     broonie@kernel.org, joey.gouly@arm.com, will@kernel.org,
        amit.kachhap@arm.com, rafael@kernel.org, catalin.marinas@arm.com,
        james.morse@arm.com, maz@kernel.org, viresh.kumar@linaro.org,
        sumitg@nvidia.com, yang@os.amperecomputing.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wangxiongfeng2@huawei.com,
        xiexiuqi@huawei.com, Ionela Voinescu <ionela.voinescu@arm.com>
Subject: Re: [PATCH 2/3] cpufreq: CPPC: Keep the target core awake when
 reading its cpufreq rate
Message-ID: <ZTjz2Ox_iqorbejw@FVFF77S0Q05N>
References: <20231025093847.3740104-1-zengheng4@huawei.com>
 <20231025093847.3740104-3-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025093847.3740104-3-zengheng4@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding Ionela]

On Wed, Oct 25, 2023 at 05:38:46PM +0800, Zeng Heng wrote:
> As ARM AMU's document says, all counters are subject to any changes
> in clock frequency, including clock stopping caused by the WFI and WFE
> instructions.
> 
> Therefore, using smp_call_on_cpu() to trigger target CPU to
> read self's AMU counters, which ensures the counters are working
> properly while cstate feature is enabled.

IIUC there's a pretty deliberate split with all the actual reading of the AMU
living in arch/arm64/kernel/topolgy.c, and the driver code being (relatively)
generic.

We already have code in arch/arm64/kernel/topolgy.c to read counters on a
specific CPU; why can't e reuse that (and avoid exporting cpu_has_amu_feat())?

Mark.

> 
> Reported-by: Sumit Gupta <sumitg@nvidia.com>
> Link: https://lore.kernel.org/all/20230418113459.12860-7-sumitg@nvidia.com/
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 39 ++++++++++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index fe08ca419b3d..321a9dc9484d 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -90,6 +90,12 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
>  				 struct cppc_perf_fb_ctrs *fb_ctrs_t0,
>  				 struct cppc_perf_fb_ctrs *fb_ctrs_t1);
>  
> +struct fb_ctr_pair {
> +	u32 cpu;
> +	struct cppc_perf_fb_ctrs fb_ctrs_t0;
> +	struct cppc_perf_fb_ctrs fb_ctrs_t1;
> +};
> +
>  /**
>   * cppc_scale_freq_workfn - CPPC arch_freq_scale updater for frequency invariance
>   * @work: The work item.
> @@ -840,9 +846,24 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
>  	return (reference_perf * delta_delivered) / delta_reference;
>  }
>  
> +static int cppc_get_perf_ctrs_pair(void *val)
> +{
> +	struct fb_ctr_pair *fb_ctrs = val;
> +	int cpu = fb_ctrs->cpu;
> +	int ret;
> +
> +	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs->fb_ctrs_t0);
> +	if (ret)
> +		return ret;
> +
> +	udelay(2); /* 2usec delay between sampling */
> +
> +	return cppc_get_perf_ctrs(cpu, &fb_ctrs->fb_ctrs_t1);
> +}
> +
>  static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>  {
> -	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
> +	struct fb_ctr_pair fb_ctrs = { .cpu = cpu, };
>  	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>  	struct cppc_cpudata *cpu_data = policy->driver_data;
>  	u64 delivered_perf;
> @@ -850,18 +871,18 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>  
>  	cpufreq_cpu_put(policy);
>  
> -	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
> -	if (ret)
> -		return 0;
> -
> -	udelay(2); /* 2usec delay between sampling */
> +	if (cpu_has_amu_feat(cpu))
> +		ret = smp_call_on_cpu(cpu, cppc_get_perf_ctrs_pair,
> +				      &fb_ctrs, false);
> +	else
> +		ret = cppc_get_perf_ctrs_pair(&fb_ctrs);
>  
> -	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>  	if (ret)
>  		return 0;
>  
> -	delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
> -					       &fb_ctrs_t1);
> +	delivered_perf = cppc_perf_from_fbctrs(cpu_data,
> +					      &fb_ctrs.fb_ctrs_t0,
> +					      &fb_ctrs.fb_ctrs_t1);
>  
>  	return cppc_cpufreq_perf_to_khz(cpu_data, delivered_perf);
>  }
> -- 
> 2.25.1
> 
