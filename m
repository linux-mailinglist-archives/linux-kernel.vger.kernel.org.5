Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BFC7A9995
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjIUSQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjIUSPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:15:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33AE885D05;
        Thu, 21 Sep 2023 10:37:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AC3114BF;
        Thu, 21 Sep 2023 02:20:19 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.78.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E5C33F59C;
        Thu, 21 Sep 2023 02:19:41 -0700 (PDT)
Date:   Thu, 21 Sep 2023 10:19:40 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, conor.dooley@microchip.com,
        suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org
Subject: Re: [PATCH 3/4] cpufreq/schedutil: use a fixed reference frequency
Message-ID: <ZQwKnnXbjLOYUSjO@arm.com>
References: <20230901130312.247719-1-vincent.guittot@linaro.org>
 <20230901130312.247719-4-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901130312.247719-4-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 Sep 2023 at 15:03:11 (+0200), Vincent Guittot wrote:
> cpuinfo_max_freq can change at runtime because of boost as example. This
> implies that the value could not be the same than the one that has been
> used when computing the capacity of a CPU.
> 
> The new arch_scale_freq_ref() returns a fixed and coherent frequency
> reference that can be used when computing a frequency based on utilization.
> 
> Use this arch_scale_freq_ref() when available and fallback to
> cpuinfo.max_freq otherwise.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/cpufreq_schedutil.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 4492608b7d7f..9996ef429e2b 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -114,6 +114,31 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy)
>  	}
>  }
>  
> +#ifdef arch_scale_freq_ref
> +/**
> + * arch_scale_freq_ref_policy - get the reference frequency of a given CPU that
> + * has been used to correlate frequency and compute capacity.
> + * @cpu: the CPU in question.
> + *
> + * Return: the reference CPU frequency.
> + */
> +static __always_inline
> +unsigned long  arch_scale_freq_ref_policy(struct cpufreq_policy *policy)

This should not be an arch_ function as it's only a wrapper over an
arch_ function and not a function that different architectures might
implement differently usually in architecture specific code.

> +{
> +	return arch_scale_freq_ref(policy->cpu);

It might make it easier to read if arch_scale_freq_ref() had a default
implementation that returned 0.

Then this code would simply become:

freq = arch_scale_freq_ref(policy->cpu);
if (freq)
	return freq;
else if (arch_scale_freq_invariant())
	return ..
..

This approach is similar to the use of arch_freq_get_on_cpu() in
cpufreq.c, and, as there, having a chosen maximum frequency of 0 would
not be a valid value.

> +}
> +#else
> +static __always_inline
> +unsigned long  arch_scale_freq_ref_policy(struct cpufreq_policy *policy)
> +{
> +	if (arch_scale_freq_invariant())
> +		return policy->cpuinfo.max_freq;
> +
> +
> +	return policy->cur;
> +}
> +#endif
> +
>  /**
>   * get_next_freq - Compute a new frequency for a given cpufreq policy.
>   * @sg_policy: schedutil policy object to compute the new frequency for.
> @@ -139,11 +164,11 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy)
>  static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>  				  unsigned long util, unsigned long max)
>  {
> +	unsigned int freq;
>  	struct cpufreq_policy *policy = sg_policy->policy;
> -	unsigned int freq = arch_scale_freq_invariant() ?
> -				policy->cpuinfo.max_freq : policy->cur;
>  
>  	util = map_util_perf(util);
> +	freq = arch_scale_freq_ref_policy(policy);

Given its single use here, it would likely be better to place the code
above directly here, rather than create a wrapper over a few lines of
code.

Hope it helps,
Ionela.

>  	freq = map_util_freq(util, freq, max);
>  
>  	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
> -- 
> 2.34.1
> 
> 
