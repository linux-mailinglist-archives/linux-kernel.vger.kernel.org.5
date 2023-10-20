Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23187D0C3B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376684AbjJTJse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376319AbjJTJsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:48:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5FA011B;
        Fri, 20 Oct 2023 02:48:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B8D72F4;
        Fri, 20 Oct 2023 02:49:10 -0700 (PDT)
Received: from [192.168.178.106] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61A7B3F5A1;
        Fri, 20 Oct 2023 02:48:27 -0700 (PDT)
Message-ID: <d76b75cf-04d8-411d-ad92-b7de4dd0f43b@arm.com>
Date:   Fri, 20 Oct 2023 11:48:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/schedutil: rework performance estimation
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, rafael@kernel.org, viresh.kumar@linaro.org,
        qyousef@layalina.io, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     lukasz.luba@arm.com
References: <20231013151450.257891-1-vincent.guittot@linaro.org>
 <20231013151450.257891-2-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20231013151450.257891-2-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2023 17:14, Vincent Guittot wrote:
> The current method to take into account uclamp hints when estimating the
> target frequency can end into situation where the selected target
> frequency is finally higher than uclamp hints whereas there are no real
> needs. Such cases mainly happen because we are currently mixing the
> traditional scheduler utilization signal with the uclamp performance
> hints. By adding these 2 metrics, we loose an important information when
> it comes to select the target frequency and we have to make some
> assumptions which can't fit all cases.
> 
> Rework the interface between the scheduler and schedutil governor in order
> to propagate all information down to the cpufreq governor.

So we change from:

max(util -> uclamp, iowait_boost -> uclamp) -> head_room()

to:

util = max(util, iowait_boost) -> util =
                                  head_room(util)

_min = max(irq + cpu_bw_dl,
           uclamp_min)         ->                  -> max(_min, _max)

_max = min(scale, uclamp_max)  -> _max =
                                  min(util, _max)

> effective_cpu_util() interface changes and now returns the actual
> utilization of the CPU with 2 optional inputs:
> - The minimum performance for this CPU; typically the capacity to handle
>   the deadline task and the interrupt pressure. But also uclamp_min
>   request when available.
> - The maximum targeting performance for this CPU which reflects the
>   maximum level that we would like to not exceed. By default it will be
>   the CPU capacity but can be reduced because of some performance hints
>   set with uclamp. The value can be lower than actual utilization and/or
>   min performance level.
> 
> A new sugov_effective_cpu_perf() interface is also available to compute
> the final performance level that is targeted for the CPU after applying
> some cpufreq headroom and taking into account all inputs.
> 
> With these 2 functions, schedutil is now able to decide when it must go
> above uclamp hints. It now also have a generic way to get the min
> perfromance level.
> 
> The dependency between energy model and cpufreq governor and its headroom
> policy doesn't exist anymore.

But the dependency that both are doing the same thing still exists, right?

sugov_get_util() and eenv_pd_max_util() are calling the same functions:

  util = effective_cpu_util(cpu, util, &min, &max)

  /* ioboost, bw_min = head_room(min) resp. uclamp tsk handling */

  util = sugov_effective_cpu_perf(cpu, util, min, max)

[...]

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a3f9cd52eec5..78228abd1219 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7381,18 +7381,13 @@ int sched_core_idle_cpu(int cpu)
>   * required to meet deadlines.
>   */
>  unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
> -				 enum cpu_util_type type,
> -				 struct task_struct *p)
> +				 unsigned long *min,
> +				 unsigned long *max)

FREQUENCY_UTIL relates to *min != NULL and *max != NULL

ENERGY_UTIL relates to *min == NULL and *max == NULL

so both must be either NULL or !NULL.

Calling it with one equa NULL and the other with !NULL should be
undefined, right?

[...]

> @@ -7400,45 +7395,36 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
>  	 * update_irq_load_avg().
>  	 */
>  	irq = cpu_util_irq(rq);
> -	if (unlikely(irq >= max))
> -		return max;
> +	if (unlikely(irq >= scale)) {
> +		if (min)
> +			*min = scale;
> +		if (max)
> +			*max = scale;
> +		return scale;
> +	}
> +
> +	/* The minimum utilization returns the highest level between:
> +	 * - the computed DL bandwidth needed with the irq pressure which
> +	 *   steals time to the deadline task.
> +	 * - The minimum bandwidth requirement for CFS.

rq UCLAMP_MIN can also be driven by RT, not only CFS.

> +	 */
> +	if (min)
> +		*min = max(irq + cpu_bw_dl(rq), uclamp_rq_get(rq, UCLAMP_MIN));
>  
>  	/*
>  	 * Because the time spend on RT/DL tasks is visible as 'lost' time to
>  	 * CFS tasks and we use the same metric to track the effective
>  	 * utilization (PELT windows are synchronized) we can directly add them
>  	 * to obtain the CPU's actual utilization.
> -	 *
> -	 * CFS and RT utilization can be boosted or capped, depending on
> -	 * utilization clamp constraints requested by currently RUNNABLE
> -	 * tasks.
> -	 * When there are no CFS RUNNABLE tasks, clamps are released and
> -	 * frequency will be gracefully reduced with the utilization decay.
>  	 */
>  	util = util_cfs + cpu_util_rt(rq);
> -	if (type == FREQUENCY_UTIL)
> -		util = uclamp_rq_util_with(rq, util, p);
> -
> -	dl_util = cpu_util_dl(rq);
> -
> -	/*
> -	 * For frequency selection we do not make cpu_util_dl() a permanent part
> -	 * of this sum because we want to use cpu_bw_dl() later on, but we need
> -	 * to check if the CFS+RT+DL sum is saturated (ie. no idle time) such
> -	 * that we select f_max when there is no idle time.
> -	 *
> -	 * NOTE: numerical errors or stop class might cause us to not quite hit
> -	 * saturation when we should -- something for later.
> -	 */
> -	if (util + dl_util >= max)
> -		return max;
> +	util += cpu_util_dl(rq);
>  
> -	/*
> -	 * OTOH, for energy computation we need the estimated running time, so
> -	 * include util_dl and ignore dl_bw.
> -	 */
> -	if (type == ENERGY_UTIL)
> -		util += dl_util;
> +	if (util >= scale) {
> +		if (max)
> +			*max = scale;

But that means that ucamp_max cannot constrain a system in which the
'util > ucamp_max'. I guess that's related to you saying uclamp_min is a
hard req and uclamp_max is a soft req. I don't think that's in sync with
the rest of the uclamp_max implantation.

> +		return scale;
> +	}
>  
>  	/*
>  	 * There is still idle time; further improve the number by using the
> @@ -7449,28 +7435,21 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
>  	 *   U' = irq + --------- * U
>  	 *                 max
>  	 */
> -	util = scale_irq_capacity(util, irq, max);
> +	util = scale_irq_capacity(util, irq, scale);
>  	util += irq;
>  
> -	/*
> -	 * Bandwidth required by DEADLINE must always be granted while, for
> -	 * FAIR and RT, we use blocked utilization of IDLE CPUs as a mechanism
> -	 * to gracefully reduce the frequency when no tasks show up for longer
> -	 * periods of time.
> -	 *
> -	 * Ideally we would like to set bw_dl as min/guaranteed freq and util +
> -	 * bw_dl as requested freq. However, cpufreq is not yet ready for such
> -	 * an interface. So, we only do the latter for now.
> +	/* The maximum hint is a soft bandwidth requirement which can be lower
> +	 * than the actual utilization because of max uclamp requirments
>  	 */
> -	if (type == FREQUENCY_UTIL)
> -		util += cpu_bw_dl(rq);
> +	if (max)
> +		*max = min(scale, uclamp_rq_get(rq, UCLAMP_MAX));
>  
> -	return min(max, util);
> +	return min(scale, util);
>  }

effective_cpu_util for FREQUENCY_UTIL (i.e. (*min != NULL && *max !=
NULL)) is slightly different.

  missing:

  if (!uclamp_is_used() && rt_rq_is_runnable(&rq->rt)
    return max

  probably moved into sugov_effective_cpu_perf() (which is only called
  for `FREQUENCY_UTIL`) ?


  old:

  irq_cap_scaling(util_cfs, util_rt) + irq + cpu_bw_dl()
                                             ^^^^^^^^^^^

  new:

  irq_cap_scaling(util_cfs + util_rt + util_dl) + irq
                                       ^^^^^^^

[...]

> +unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
> +				 unsigned long min,
> +				 unsigned long max)
> +{
> +	unsigned long target;
> +	struct rq *rq = cpu_rq(cpu);
> +
> +	if (rt_rq_is_runnable(&rq->rt))
> +		return max;
> +
> +	/* Provide at least enough capacity for DL + irq */
> +	target =  min;
> +
> +	actual = map_util_perf(actual);
> +	/* Actually we don't need to target the max performance */
> +	if (actual < max)
> +		max = actual;
> +
> +	/*
> +	 * Ensure at least minimum performance while providing more compute
> +	 * capacity when possible.
> +	 */
> +	return max(target, max);

Can you not just use:

       return max(min, max)

and skip target?

> +}
> +
>  static void sugov_get_util(struct sugov_cpu *sg_cpu)
>  {
> -	unsigned long util = cpu_util_cfs_boost(sg_cpu->cpu);
> -	struct rq *rq = cpu_rq(sg_cpu->cpu);
> +	unsigned long min, max, util = cpu_util_cfs_boost(sg_cpu->cpu);
>  
> -	sg_cpu->bw_dl = cpu_bw_dl(rq);
> -	sg_cpu->util = effective_cpu_util(sg_cpu->cpu, util,
> -					  FREQUENCY_UTIL, NULL);
> +	util = effective_cpu_util(sg_cpu->cpu, util, &min, &max);
> +	sg_cpu->bw_min = map_util_perf(min);
> +	sg_cpu->util = sugov_effective_cpu_perf(sg_cpu->cpu, util, min, max);
>  }
>  
>  /**
> @@ -306,7 +329,7 @@ static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
>   */
>  static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu)
>  {
> -	if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_dl)
> +	if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_min)

bw_min is more than DL right?

bw_min = head_room(max(irq + cpu_bw_dl, rq's UCLAMP_MIN)

[...]
