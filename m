Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D78D79AE02
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343913AbjIKVMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242240AbjIKPZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:25:40 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14762D8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1694445929;
        bh=ZJ44zxSZpnXPSFwmecpGOPhNlMiRsPmv7560/Eoa5RM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=R+M/XeBOlMsy/UDo+t99aTgvdKcsEOAxJRmz//kysYPypWEU2oGTa/zfdWyK27xrH
         PPgpxgs/iEwga/PK3qoMg6VauqYmYdGSWvoZ8m2BR88NMfYCKuaKKSiXV1Hw/jQjNu
         ESC28VLaGsq0PavMJeREAGS20fJCC80PT1Nm7VSN7Ok5mGW7OMLX1bRZWcQ1CTYVBf
         t5asBEvN5tScXwiGwJPSVLMDxrVSnN3rMkYiCrFyb4y0G5D7h6EsHALhUaFrOgUjs9
         EeaZpYN3WKNx2E59jd54U0PZH9NQGNoD+fKyrYut6dz2JnV+fmxw7GN1ah/XI2YOCg
         tu9JKKOfQx+Yg==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RkrBd5JX4z1PHL;
        Mon, 11 Sep 2023 11:25:29 -0400 (EDT)
Message-ID: <30a7ff14-3f48-e8cf-333f-cbb7499656e3@efficios.com>
Date:   Mon, 11 Sep 2023 11:26:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH 2/2] sched/fair: skip the cache hot CPU in
 select_idle_cpu()
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org
References: <cover.1694397335.git.yu.c.chen@intel.com>
 <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/23 22:50, Chen Yu wrote:
> When task p is woken up, the scheduler leverages select_idle_sibling()
> to find an idle CPU for it. p's previous CPU is usually a preference
> because it can improve cache locality. However in many cases the
> previous CPU has already been taken by other wakees, thus p has to
> find another idle CPU.
> 
> Inspired by Mathieu's idea[1], consider the sleep time of the task.
> If that task is a short sleeping one, keep p's previous CPU idle
> for a short while. Later when p is woken up, it can choose its
> previous CPU in select_idle_sibling(). When p's previous CPU is reserved,
> other wakee is not allowed to choose this CPU in select_idle_idle().
> The reservation period is set to the task's average sleep time. That
> is to say, if p is a short sleeping task, there is no need to migrate
> p to another idle CPU.
> 
> This does not break the work conservation of the scheduler,
> because wakee will still try its best to find an idle CPU.
> The difference is that, different idle CPUs might have different
> priorities. On the other hand, in theory this extra check could
> increase the failure ratio of select_idle_cpu(), but per the
> initial test result, no regression is detected.
> 
> Baseline: tip/sched/core, on top of:
> Commit 3f4feb58037a ("sched: Misc cleanups")
> 
> Benchmark results on Intel Sapphire Rapids, 112 CPUs/socket, 2 sockets.
> cpufreq governor is performance, turbo boost is disabled, C-states deeper
> than C1 are disabled, Numa balancing is disabled.
> 
> netperf
> =======
> case                    load            baseline(std%)  compare%( std%)
> UDP_RR                  56-threads       1.00 (  1.34)   +1.05 (  1.04)
> UDP_RR                  112-threads      1.00 (  7.94)   -0.68 ( 14.42)
> UDP_RR                  168-threads      1.00 ( 33.17)  +49.63 (  5.96)
> UDP_RR                  224-threads      1.00 ( 13.52)  +122.53 ( 18.50)
> 
> Noticeable improvements of netperf is observed in 168 and 224 threads
> cases.
> 
> hackbench
> =========
> case                    load            baseline(std%)  compare%( std%)
> process-pipe            1-groups         1.00 (  5.61)   -4.69 (  1.48)
> process-pipe            2-groups         1.00 (  8.74)   -0.24 (  3.10)
> process-pipe            4-groups         1.00 (  3.52)   +1.61 (  4.41)
> process-sockets         1-groups         1.00 (  4.73)   +2.32 (  0.95)
> process-sockets         2-groups         1.00 (  1.27)   -3.29 (  0.97)
> process-sockets         4-groups         1.00 (  0.09)   +0.24 (  0.09)
> threads-pipe            1-groups         1.00 ( 10.44)   -5.88 (  1.49)
> threads-pipe            2-groups         1.00 ( 19.15)   +5.31 ( 12.90)
> threads-pipe            4-groups         1.00 (  1.74)   -5.01 (  6.44)
> threads-sockets         1-groups         1.00 (  1.58)   -1.79 (  0.43)
> threads-sockets         2-groups         1.00 (  1.19)   -8.43 (  6.91)
> threads-sockets         4-groups         1.00 (  0.10)   -0.09 (  0.07)
> 
> schbench(old)
> ========
> case                    load            baseline(std%)  compare%( std%)
> normal                  1-mthreads       1.00 (  0.63)   +1.28 (  0.37)
> normal                  2-mthreads       1.00 (  8.33)   +1.58 (  2.83)
> normal                  4-mthreads       1.00 (  2.48)   -2.98 (  3.28)
> normal                  8-mthreads       1.00 (  3.97)   +5.01 (  1.28)
> 
> No much difference is observed in hackbench/schbench, due to the
> run-to-run variance.
> 
> Link: https://lore.kernel.org/lkml/20230905171105.1005672-2-mathieu.desnoyers@efficios.com/ #1
> Suggested-by: Tim Chen <tim.c.chen@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>   kernel/sched/fair.c     | 30 +++++++++++++++++++++++++++---
>   kernel/sched/features.h |  1 +
>   kernel/sched/sched.h    |  1 +
>   3 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e20f50726ab8..fe3b760c9654 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6629,6 +6629,21 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>   	hrtick_update(rq);
>   	now = sched_clock_cpu(cpu_of(rq));
>   	p->se.prev_sleep_time = task_sleep ? now : 0;
> +#ifdef CONFIG_SMP
> +	/*
> +	 * If this rq will become idle, and dequeued task is
> +	 * a short sleeping one, check if we can reserve
> +	 * this idle CPU for that task for a short while.
> +	 * During this reservation period, other wakees will
> +	 * skip this 'idle' CPU in select_idle_cpu(), and this
> +	 * short sleeping task can pick its previous CPU in
> +	 * select_idle_sibling(), which brings better cache
> +	 * locality.
> +	 */
> +	if (sched_feat(SIS_CACHE) && task_sleep && !rq->nr_running &&
> +	    p->se.sleep_avg && p->se.sleep_avg < sysctl_sched_migration_cost)
> +		rq->cache_hot_timeout = now + p->se.sleep_avg;

This is really cool!

There is one scenario that worries me with this approach: workloads
that sleep for a long time and then have short blocked periods.
Those bursts will likely bring the average to values too high
to stay below sysctl_sched_migration_cost.

I wonder if changing the code above for the following would help ?

if (sched_feat(SIS_CACHE) && task_sleep && !rq->nr_running && p->se.sleep_avg)
	rq->cache_hot_timeout = now + min(sysctl_sched_migration_cost, p->se.sleep_avg);

For tasks that have a large sleep_avg, it would activate this rq
"appear as not idle for rq selection" scheme for a window of
sysctl_sched_migration_cost. If the sleep ends up being a long one,
preventing other tasks from being migrated to this rq for a tiny
window should not matter performance-wise. I would expect that it
could help workloads that come in bursts.

Thanks,

Mathieu


> +#endif
>   }
>   
>   #ifdef CONFIG_SMP
> @@ -6982,8 +6997,13 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
>   static inline int __select_idle_cpu(int cpu, struct task_struct *p)
>   {
>   	if ((available_idle_cpu(cpu) || sched_idle_cpu(cpu)) &&
> -	    sched_cpu_cookie_match(cpu_rq(cpu), p))
> +	    sched_cpu_cookie_match(cpu_rq(cpu), p)) {
> +		if (sched_feat(SIS_CACHE) &&
> +		    sched_clock_cpu(cpu) < cpu_rq(cpu)->cache_hot_timeout)
> +			return -1;
> +
>   		return cpu;
> +	}
>   
>   	return -1;
>   }
> @@ -7052,10 +7072,14 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
>   	int cpu;
>   
>   	for_each_cpu(cpu, cpu_smt_mask(core)) {
> -		if (!available_idle_cpu(cpu)) {
> +		bool cache_hot = sched_feat(SIS_CACHE) ?
> +			sched_clock_cpu(cpu) < cpu_rq(cpu)->cache_hot_timeout : false;
> +
> +		if (!available_idle_cpu(cpu) || cache_hot) {
>   			idle = false;
>   			if (*idle_cpu == -1) {
> -				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, p->cpus_ptr)) {
> +				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, p->cpus_ptr) &&
> +				    !cache_hot) {
>   					*idle_cpu = cpu;
>   					break;
>   				}
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index f770168230ae..04ed9fcf67f8 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -51,6 +51,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
>    */
>   SCHED_FEAT(SIS_PROP, false)
>   SCHED_FEAT(SIS_UTIL, true)
> +SCHED_FEAT(SIS_CACHE, true)
>   
>   /*
>    * Issue a WARN when we do multiple update_rq_clock() calls
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 62013c49c451..7a2c12c3b6d0 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1078,6 +1078,7 @@ struct rq {
>   #endif
>   	u64			idle_stamp;
>   	u64			avg_idle;
> +	u64			cache_hot_timeout;
>   
>   	unsigned long		wake_stamp;
>   	u64			wake_avg_idle;

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

