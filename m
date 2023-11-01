Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC5C7DE826
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 23:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346003AbjKAWe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 18:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjKAWeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 18:34:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88E1210F;
        Wed,  1 Nov 2023 15:34:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D673F2F4;
        Wed,  1 Nov 2023 15:35:03 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 073F43F64C;
        Wed,  1 Nov 2023 15:34:19 -0700 (PDT)
Message-ID: <9c6f1e12-ed49-4b3d-ad20-cf2b32741836@arm.com>
Date:   Wed, 1 Nov 2023 23:34:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/6] sched/fair: Use CFS util_avg_uclamp for
 utilization and frequency
Content-Language: en-US
To:     Hongyan Xia <Hongyan.Xia2@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Christian Loehle <christian.loehle@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <cover.1696345700.git.Hongyan.Xia2@arm.com>
 <b2fc40b143f90ce652a02950503cbe744bc1d112.1696345700.git.Hongyan.Xia2@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <b2fc40b143f90ce652a02950503cbe744bc1d112.1696345700.git.Hongyan.Xia2@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2023 11:04, Hongyan Xia wrote:
> From: Hongyan Xia <hongyan.xia2@arm.com>
> 
> Switch to the new util_avg_uclamp for task and runqueue utilization.
> Since util_est() calls task_util(), this means util_est is now also a
> clamped value.

s/util_est()/task_util_est()

but task_util_est() is max(task_util(p), _task_util_est(p))

So I don't immediately spot why util_est is a clamped value as well now.

We have a naming mismatch between CPU and task related function on this
level: cpu_util() vs. task_util_est().

> Now that we have the sum aggregated CFS util value, we do not need to
> consult uclamp buckets to know how the frequency should be clamped. We
> simply look at the aggregated top level root_cfs_util_uclamp to know
> what frequency to choose. Because we simulate PELT decay in
> root_cfs_util_uclamp anyway, there's no need in cpufreq_schedutil.c to
> avoid premature frequency drops.
> 
> Consequently, there is no need for uclamp_rq_util_with(). This function
> takes the un-clamped util value and sends it through various clamping
> filters to get the final value. However, util_avg_uclamp is propagated
> with clamping in mind already, so it does not need to be clamped again.
> 
> TODO: There are two major caveats in this patch.
> 1. At the moment sum aggregation does not consider RT tasks. The avg_rt
>    signal considers all RT tasks on this rq as a single entity, which
>    means the utilization of individual RT tasks is not tracked
>    separately. If we want to use sum aggregation, we might have to track
>    utilization of RT tasks individually.

Not sure if the RT class will except PELT task tracking (plus there is
CONFIG_RT_GROUP_SCHED too).

> 2. Busy time accounting in compute_energy() now takes the uclamp'ed
>    value. Ideally, it should reflect reality and use the un-clamp'ed
>    values. However, that would require maintaining both the normal and
>    uclamp'ed values for util_est. This needs to be revisited if it
>    causes real problems in practice.

You could use your new rq->root_cfs_util_uclamp for eenv_pd_max_util
(FREQUENCY_UTIL) and use rq->cfs.avg.util_avg in eenv_pd_busy_time()
(ENERGY_UTIL).

[...]

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index efe3848978a0..32511ee63f01 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7402,10 +7402,12 @@ int sched_core_idle_cpu(int cpu)
>   * The DL bandwidth number otoh is not a measured metric but a value computed
>   * based on the task model parameters and gives the minimal utilization
>   * required to meet deadlines.
> + *
> + * The util_cfs parameter has already taken uclamp into account (unless uclamp
> + * support is not compiled in).
>   */
>  unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
> -				 enum cpu_util_type type,
> -				 struct task_struct *p)
> +				 enum cpu_util_type type)

There are changes proposed in the area of uclamping right now in:

https://lkml.kernel.org/r/20231026170913.32605-2-vincent.guittot@linaro.org

[...]

>  /**
> @@ -282,7 +281,11 @@ static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
>  	 * into the same scale so we can compare.
>  	 */
>  	boost = (sg_cpu->iowait_boost * max_cap) >> SCHED_CAPACITY_SHIFT;
> -	boost = uclamp_rq_util_with(cpu_rq(sg_cpu->cpu), boost, NULL);
> +	/*
> +	 * TODO: Investigate what should be done here. In sum aggregation there
> +	 * is no such thing as uclamp_max on a rq, so how do we cap the boost
> +	 * value, or do we want to cap the boost frequency here at all?
> +	 */

https://lkml.kernel.org/r/20231026170913.32605-3-vincent.guittot@linaro.org

is proposing to cap iowait boost with max (set in effective_cpu_util()
and max depends on uclamp_rq_get(rq, UCLAMP_MAX) too.

So you could cap iowait boost in case uclamp_rq_is_capped(), i.e. when:

  if (rq->cfs.avg.util_avg > rq->root_cfs_util_uclamp + margin)

[...]

> @@ -7468,11 +7459,13 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  static unsigned long
>  cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
>  {
> -	struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
> -	unsigned long util = READ_ONCE(cfs_rq->avg.util_avg);
> +	struct rq *rq = cpu_rq(cpu);
> +	struct cfs_rq *cfs_rq = &rq->cfs;
> +	unsigned long util = root_cfs_util(rq);
> +	bool capped = uclamp_rq_is_capped(rq);
>  	unsigned long runnable;
>  
> -	if (boost) {
> +	if (boost && !capped) {
>  		runnable = READ_ONCE(cfs_rq->avg.runnable_avg);
>  		util = max(util, runnable);
>  	}

IMHO, this makes sense. Only allow runnable boosting in case the rq is
not uclamp_max capped.

[...]
