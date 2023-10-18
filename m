Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBB47CD58E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344587AbjJRHkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjJRHkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:40:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C139DC6;
        Wed, 18 Oct 2023 00:40:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7129F2F4;
        Wed, 18 Oct 2023 00:40:49 -0700 (PDT)
Received: from e129154.nice.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0A203F64C;
        Wed, 18 Oct 2023 00:40:04 -0700 (PDT)
Date:   Wed, 18 Oct 2023 09:39:28 +0200
From:   Beata Michalska <beata.michalska@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rafael@kernel.org, viresh.kumar@linaro.org, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com
Subject: Re: [PATCH 2/2] sched/schedutil: rework iowait boost
Message-ID: <ZS-LsFZH7uC_Cw9f@e129154.nice.arm.com>
References: <20231013151450.257891-1-vincent.guittot@linaro.org>
 <20231013151450.257891-3-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013151450.257891-3-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 05:14:50PM +0200, Vincent Guittot wrote:
> Use the max value that has already been computed inside sugov_get_util()
> to cap the iowait boost and remove dependency with uclamp_rq_util_with()
> which is not used anymore.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/cpufreq_schedutil.c | 29 ++++++++-------
>  kernel/sched/sched.h             | 60 --------------------------------
>  2 files changed, 14 insertions(+), 75 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 8cb323522b90..820612867769 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -177,11 +177,12 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
>  	return max(target, max);
>  }
>  
> -static void sugov_get_util(struct sugov_cpu *sg_cpu)
> +static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned long boost)
>  {
>  	unsigned long min, max, util = cpu_util_cfs_boost(sg_cpu->cpu);
>  
>  	util = effective_cpu_util(sg_cpu->cpu, util, &min, &max);
> +	util = max(util, boost);
sugov_get_util could actually call sugov_iowait_apply here instead, to get a
centralized point of getting and applying the boost. Also sugov_iowait_apply
naming is no longer reflecting the functionality so maybe renaming it to smth
like sugov_iowait_get ?

---
BR
B.
>  	sg_cpu->bw_min = map_util_perf(min);
>  	sg_cpu->util = sugov_effective_cpu_perf(sg_cpu->cpu, util, min, max);
>  }
> @@ -274,18 +275,16 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
>   * This mechanism is designed to boost high frequently IO waiting tasks, while
>   * being more conservative on tasks which does sporadic IO operations.
>   */
> -static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
> +static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
>  			       unsigned long max_cap)
>  {
> -	unsigned long boost;
> -
>  	/* No boost currently required */
>  	if (!sg_cpu->iowait_boost)
> -		return;
> +		return 0;
>  
>  	/* Reset boost if the CPU appears to have been idle enough */
>  	if (sugov_iowait_reset(sg_cpu, time, false))
> -		return;
> +		return 0;
>  
>  	if (!sg_cpu->iowait_boost_pending) {
>  		/*
> @@ -294,7 +293,7 @@ static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
>  		sg_cpu->iowait_boost >>= 1;
>  		if (sg_cpu->iowait_boost < IOWAIT_BOOST_MIN) {
>  			sg_cpu->iowait_boost = 0;
> -			return;
> +			return 0;
>  		}
>  	}
>  
> @@ -304,10 +303,7 @@ static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
>  	 * sg_cpu->util is already in capacity scale; convert iowait_boost
>  	 * into the same scale so we can compare.
>  	 */
> -	boost = (sg_cpu->iowait_boost * max_cap) >> SCHED_CAPACITY_SHIFT;
> -	boost = uclamp_rq_util_with(cpu_rq(sg_cpu->cpu), boost, NULL);
> -	if (sg_cpu->util < boost)
> -		sg_cpu->util = boost;
> +	return (sg_cpu->iowait_boost * max_cap) >> SCHED_CAPACITY_SHIFT;
>  }
>  
>  #ifdef CONFIG_NO_HZ_COMMON
> @@ -337,6 +333,8 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
>  					      u64 time, unsigned long max_cap,
>  					      unsigned int flags)
>  {
> +	unsigned long boost;
> +
>  	sugov_iowait_boost(sg_cpu, time, flags);
>  	sg_cpu->last_update = time;
>  
> @@ -345,8 +343,8 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
>  	if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
>  		return false;
>  
> -	sugov_get_util(sg_cpu);
> -	sugov_iowait_apply(sg_cpu, time, max_cap);
> +	boost = sugov_iowait_apply(sg_cpu, time, max_cap);
> +	sugov_get_util(sg_cpu, boost);
>  
>  	return true;
>  }
> @@ -447,9 +445,10 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
>  
>  	for_each_cpu(j, policy->cpus) {
>  		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
> +		unsigned long boost;
>  
> -		sugov_get_util(j_sg_cpu);
> -		sugov_iowait_apply(j_sg_cpu, time, max_cap);
> +		boost = sugov_iowait_apply(j_sg_cpu, time, max_cap);
> +		sugov_get_util(j_sg_cpu, boost);
>  
>  		util = max(j_sg_cpu->util, util);
>  	}
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 3873b4de7cfa..b181edaf4d41 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3026,59 +3026,6 @@ static inline bool uclamp_rq_is_idle(struct rq *rq)
>  	return rq->uclamp_flags & UCLAMP_FLAG_IDLE;
>  }
>  
> -/**
> - * uclamp_rq_util_with - clamp @util with @rq and @p effective uclamp values.
> - * @rq:		The rq to clamp against. Must not be NULL.
> - * @util:	The util value to clamp.
> - * @p:		The task to clamp against. Can be NULL if you want to clamp
> - *		against @rq only.
> - *
> - * Clamps the passed @util to the max(@rq, @p) effective uclamp values.
> - *
> - * If sched_uclamp_used static key is disabled, then just return the util
> - * without any clamping since uclamp aggregation at the rq level in the fast
> - * path is disabled, rendering this operation a NOP.
> - *
> - * Use uclamp_eff_value() if you don't care about uclamp values at rq level. It
> - * will return the correct effective uclamp value of the task even if the
> - * static key is disabled.
> - */
> -static __always_inline
> -unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
> -				  struct task_struct *p)
> -{
> -	unsigned long min_util = 0;
> -	unsigned long max_util = 0;
> -
> -	if (!static_branch_likely(&sched_uclamp_used))
> -		return util;
> -
> -	if (p) {
> -		min_util = uclamp_eff_value(p, UCLAMP_MIN);
> -		max_util = uclamp_eff_value(p, UCLAMP_MAX);
> -
> -		/*
> -		 * Ignore last runnable task's max clamp, as this task will
> -		 * reset it. Similarly, no need to read the rq's min clamp.
> -		 */
> -		if (uclamp_rq_is_idle(rq))
> -			goto out;
> -	}
> -
> -	min_util = max_t(unsigned long, min_util, uclamp_rq_get(rq, UCLAMP_MIN));
> -	max_util = max_t(unsigned long, max_util, uclamp_rq_get(rq, UCLAMP_MAX));
> -out:
> -	/*
> -	 * Since CPU's {min,max}_util clamps are MAX aggregated considering
> -	 * RUNNABLE tasks with _different_ clamps, we can end up with an
> -	 * inversion. Fix it now when the clamps are applied.
> -	 */
> -	if (unlikely(min_util >= max_util))
> -		return min_util;
> -
> -	return clamp(util, min_util, max_util);
> -}
> -
>  /* Is the rq being capped/throttled by uclamp_max? */
>  static inline bool uclamp_rq_is_capped(struct rq *rq)
>  {
> @@ -3116,13 +3063,6 @@ static inline unsigned long uclamp_eff_value(struct task_struct *p,
>  	return SCHED_CAPACITY_SCALE;
>  }
>  
> -static inline
> -unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
> -				  struct task_struct *p)
> -{
> -	return util;
> -}
> -
>  static inline bool uclamp_rq_is_capped(struct rq *rq) { return false; }
>  
>  static inline bool uclamp_is_used(void)
> -- 
> 2.34.1
> 
