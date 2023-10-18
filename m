Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748DC7CDA2C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjJRLVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjJRLVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:21:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA1FA115;
        Wed, 18 Oct 2023 04:21:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 283602F4;
        Wed, 18 Oct 2023 04:21:49 -0700 (PDT)
Received: from [10.57.81.189] (unknown [10.57.81.189])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9534E3F762;
        Wed, 18 Oct 2023 04:21:03 -0700 (PDT)
Message-ID: <368c8a9f-b137-47a9-9468-ebeb04d4bab5@arm.com>
Date:   Wed, 18 Oct 2023 12:21:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] cpufreq/schedutil: use a fixed reference frequency
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     conor.dooley@microchip.com, suagrfillet@gmail.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vschneid@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, peterz@infradead.org, rafael@kernel.org,
        gregkh@linuxfoundation.org, ajones@ventanamicro.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        sudeep.holla@arm.com, ionela.voinescu@arm.com,
        viresh.kumar@linaro.org, mgorman@suse.de, palmer@dabbelt.com,
        will@kernel.org, bristot@redhat.com, lftan@kernel.org,
        rostedt@goodmis.org, linux@armlinux.org.uk,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu, mingo@redhat.com,
        catalin.marinas@arm.com, pierre.gondois@arm.com
References: <20231009103621.374412-1-vincent.guittot@linaro.org>
 <20231009103621.374412-5-vincent.guittot@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231009103621.374412-5-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/9/23 11:36, Vincent Guittot wrote:
> cpuinfo.max_freq can change at runtime because of boost as an example. This
> implies that the value could be different than the one that has been
> used when computing the capacity of a CPU.
> 
> The new arch_scale_freq_ref() returns a fixed and coherent reference
> frequency that can be used when computing a frequency based on utilization.
> 
> Use this arch_scale_freq_ref() when available and fallback to
> policy otherwise.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   kernel/sched/cpufreq_schedutil.c | 26 ++++++++++++++++++++++++--
>   1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 4492608b7d7f..1fa7e74add8f 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -114,6 +114,28 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy)
>   	}
>   }
>   
> +/**
> + * cpufreq_get_capacity_ref_freq - get the reference frequency of a given CPU that
> + * has been used to correlate frequency and compute capacity.
> + * @policy: the cpufreq policy of the CPU in question.
> + * @use_current: Fallback to current freq instead of policy->cpuinfo.max_freq.
> + *
> + * Return: the reference CPU frequency to compute a capacity.
> + */
> +static __always_inline
> +unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy)
> +{
> +	unsigned int freq = arch_scale_freq_ref(policy->cpu);
> +
> +	if (freq)
> +		return freq;

Looks good, for the platforms having this inline function returning 0,
this will be optimized out.

> +
> +	if (arch_scale_freq_invariant())
> +		return policy->cpuinfo.max_freq;
> +
> +	return policy->cur;
> +}
> +
>   /**
>    * get_next_freq - Compute a new frequency for a given cpufreq policy.
>    * @sg_policy: schedutil policy object to compute the new frequency for.
> @@ -140,10 +162,10 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>   				  unsigned long util, unsigned long max)
>   {
>   	struct cpufreq_policy *policy = sg_policy->policy;
> -	unsigned int freq = arch_scale_freq_invariant() ?
> -				policy->cpuinfo.max_freq : policy->cur;
> +	unsigned int freq;
>   
>   	util = map_util_perf(util);
> +	freq = get_capacity_ref_freq(policy);
>   	freq = map_util_freq(util, freq, max);
>   
>   	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
