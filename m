Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E066C7D3903
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjJWOLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJWOLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:11:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71C9DCC
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:11:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1330A2F4;
        Mon, 23 Oct 2023 07:12:00 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D20333F64C;
        Mon, 23 Oct 2023 07:11:15 -0700 (PDT)
Message-ID: <f40522de-b71d-4848-8aa3-5b87d38bb847@arm.com>
Date:   Mon, 23 Oct 2023 16:11:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/2] sched/fair: Introduce UTIL_FITS_CAPACITY
 feature (v2)
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>, x86@kernel.org
References: <20231019160523.1582101-1-mathieu.desnoyers@efficios.com>
 <20231019160523.1582101-2-mathieu.desnoyers@efficios.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20231019160523.1582101-2-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2023 18:05, Mathieu Desnoyers wrote:
> Introduce the UTIL_FITS_CAPACITY scheduler feature. The runqueue
> selection picks the previous, target, or recent runqueues if they have
> enough remaining capacity to enqueue the task before scanning for an
> idle cpu.
> 
> This feature is introduced in preparation for the SELECT_BIAS_PREV
> scheduler feature.
> 
> The following benchmarks only cover the UTIL_FITS_CAPACITY feature.
> Those are performed on a v6.5.5 kernel with mitigations=off.
> 
> The following hackbench workload on a 192 cores AMD EPYC 9654 96-Core
> Processor (over 2 sockets) improves the wall time from 49s to 40s
> (18% speedup).
> 
> hackbench -g 32 -f 20 --threads --pipe -l 480000 -s 100
> 
> We can observe that the number of migrations is reduced significantly
> with this patch (improvement):
> 
> Baseline:      117M cpu-migrations  (9.355 K/sec)
> With patch:     47M cpu-migrations  (3.977 K/sec)
> 
> The task-clock utilization is increased (improvement):
> 
> Baseline:      253.275 CPUs utilized
> With patch:    271.367 CPUs utilized
> 
> The number of context-switches is increased (degradation):
> 
> Baseline:      445M context-switches (35.516 K/sec)
> With patch:    586M context-switches (48.823 K/sec)
> 

Haven't run any benchmarks yet to prove the benefit of this prefer
packing over spreading or migration avoidance algorithm.

[...]

> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4497,6 +4497,28 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
>  	trace_sched_util_est_se_tp(&p->se);
>  }
>  
> +static unsigned long scale_rt_capacity(int cpu);
> +
> +/*
> + * Returns true if adding the task utilization to the estimated
> + * utilization of the runnable tasks on @cpu does not exceed the
> + * capacity of @cpu.
> + *
> + * This considers only the utilization of _runnable_ tasks on the @cpu
> + * runqueue, excluding blocked and sleeping tasks. This is achieved by
> + * using the runqueue util_est.enqueued.
> + */
> +static inline bool task_fits_remaining_cpu_capacity(unsigned long task_util,
> +						    int cpu)

This is almost like the existing task_fits_cpu(p, cpu) (used in Capacity
Aware Scheduling (CAS) for Asymmetric CPU capacity systems) except the
latter only uses `util = task_util_est(p)` and deals with uclamp as well
and only tests whether p could fit on the CPU.

Or like find_energy_efficient_cpu() (feec(), used in
Energy-Aware-Scheduling (EAS)) which uses cpu_util(cpu, p, cpu, 0) to get:

  max(util_avg(CPU + p), util_est(CPU + p))

feec()
    ...
    for (; pd; pd = pd->next)
        ...
        util = cpu_util(cpu, p, cpu, 0);
        ...
        fits = util_fits_cpu(util, util_min, util_max, cpu)
                                   ^^^^^^^^^^^^^^^^^^
                                  not used when uclamp is not active (1)
            ...
            capacity = capacity_of(cpu)
            fits = fits_capacity(util, capacity)
            if (!uclamp_is_used()) (1)
                return fits

So not introducing new functions like task_fits_remaining_cpu_capacity()
in this area and using existing one would be good.

> +{
> +	unsigned long total_util;
> +
> +	if (!sched_util_fits_capacity_active())
> +		return false;
> +	total_util = READ_ONCE(cpu_rq(cpu)->cfs.avg.util_est.enqueued) + task_util;
> +	return fits_capacity(total_util, scale_rt_capacity(cpu));

Why not use:

static unsigned long capacity_of(int cpu)
    return cpu_rq(cpu)->cpu_capacity;

which is maintained in update_cpu_capacity() as scale_rt_capacity(cpu)?

[...]

> @@ -7173,7 +7200,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	if (recent_used_cpu != prev &&
>  	    recent_used_cpu != target &&
>  	    cpus_share_cache(recent_used_cpu, target) &&
> -	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
> +	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu) ||
> +	    task_fits_remaining_cpu_capacity(task_util, recent_used_cpu)) &&
>  	    cpumask_test_cpu(recent_used_cpu, p->cpus_ptr) &&
>  	    asym_fits_cpu(task_util, util_min, util_max, recent_used_cpu)) {
>  		return recent_used_cpu;
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index ee7f23c76bd3..9a84a1401123 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -97,6 +97,12 @@ SCHED_FEAT(WA_BIAS, true)
>  SCHED_FEAT(UTIL_EST, true)
>  SCHED_FEAT(UTIL_EST_FASTUP, true)

IMHO, asymmetric CPU capacity systems would have to disable the sched
feature UTIL_FITS_CAPACITY. Otherwise CAS could deliver different
results. task_fits_remaining_cpu_capacity() and asym_fits_cpu() work
slightly different.

[...]

