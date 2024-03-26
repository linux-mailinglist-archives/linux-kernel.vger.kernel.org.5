Return-Path: <linux-kernel+bounces-119204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BF688C582
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A0C1F3ED80
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D5D13C664;
	Tue, 26 Mar 2024 14:44:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1CE12DD9C;
	Tue, 26 Mar 2024 14:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464272; cv=none; b=W7uVCdRUlXNJX1NUVdN+tGvwNodsYuID5NUD8DIYlhNHpPBOjTZqUVcPX7I/HYBwc3zCJzc0d9uXM1hKvNTOdyd0doHvaMUIzhBgYJh3KmshN5ES9aZ4UOhIY3FurSQFhiW5Az2EL6xv60VjJal3aBAtrrl0MfT3H5yCZ7B3DBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464272; c=relaxed/simple;
	bh=v8xPSVZXeaGaSymzPTtFfRxQBxpGaZ7Snbj/4Dg6wRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T2OLjei6KSX5HrnUJv+b2pma85FTfExiFfrS6NWi0Z6GmJCvtjEmOs9KmdiI8H/PGDSvkIdyNZKwtWy+D3rn3tokBHKuAUTVfS5rd5pZulZS+xIAWsslpDbzd21lwwp42l7hpQPkHJ3sRboW0U7i6tFv2acdYmvl7G0dh+qUv9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4588B2F4;
	Tue, 26 Mar 2024 07:45:02 -0700 (PDT)
Received: from [10.1.25.33] (e133047.arm.com [10.1.25.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F39D53F694;
	Tue, 26 Mar 2024 07:44:22 -0700 (PDT)
Message-ID: <ceecb0ac-13ce-4862-a41a-5ceac08a5df2@arm.com>
Date: Tue, 26 Mar 2024 14:44:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched: Consolidate cpufreq updates
Content-Language: en-US
To: Qais Yousef <qyousef@layalina.io>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240324020139.1032473-1-qyousef@layalina.io>
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240324020139.1032473-1-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Qais,
Some first thoughts, I'll do some more thinking and testing though.
I wonder if the increased latency of applying the new freq later
(context-switch vs enqueue) has any measurable impact for some
workloads for somewhat higher delay switching platforms.

On 24/03/2024 02:01, Qais Yousef wrote:
> Improve the interaction with cpufreq governors by making the
> cpufreq_update_util() calls more intentional.
> 
> At the moment we send them when load is updated for CFS, bandwidth for
> DL and at enqueue/dequeue for RT. But this can lead to too many updates
> sent in a short period of time and potentially be ignored at a critical
> moment due to the rate_limit_us in schedutil.
> 
> For example, simultaneous task enqueue on the CPU where 2nd task is
> bigger and requires higher freq. The trigger to cpufreq_update_util() by
> the first task will lead to dropping the 2nd request until tick. Or
> another CPU in the same policy triggers a freq update shortly after.
Out of curiosity: Is that significant anywhere?
It is unfortunate for sure, but the delay until the 'big' freq update
is also bounded.

> 
> Updates at enqueue for RT are not strictly required. Though they do help
> to reduce the delay for switching the frequency and the potential
> observation of lower frequency during this delay. But current logic
> doesn't intentionally (at least to my understanding) try to speed up the
> request.
> 
> To help reduce the amount of cpufreq updates and make them more
> purposeful, consolidate them into these locations:
> 
> 1. context_switch()
> 2. task_tick_fair()
> 3. {attach, detach}_entity_load_avg()
> 4. update_blocked_averages()
> 
> The update at context switch should help guarantee that DL and RT get
> the right frequency straightaway when they're RUNNING. As mentioned
> though the update will happen slightly after enqueue_task(); though in
> an ideal world these tasks should be RUNNING ASAP and this additional
> delay should be negligible. For fair tasks we need to make sure we send
> a single update for every decay for the root cfs_rq. Any changes to the
> rq will be deferred until the next task is ready to run, or we hit TICK.
> But we are guaranteed the task is running at a level that meets its
> requirements after enqueue.
> 
> To guarantee RT and DL tasks updates are never missed, we add a new
> SCHED_CPUFREQ_FORCE_UPDATE to ignore the rate_limit_us. If we are
> already running at the right freq, the governor will end up doing
> nothing, but we eliminate the risk of the task ending up accidentally
> running at the wrong freq due to rate_limit_us.
> 
> Similarly for iowait boost. We also handle a case of a boost reset
> prematurely by adding a guard against TICK_NSEC in sugov_iowait_apply()
> in similar fashion to sugov_iowait_reset().
> 
> The new SCHED_CPUFREQ_FORCE_UPDATE should not impact the rate limit
> time stamps otherwise we can end up delaying updates for normal
> requests.
With the new updates and the assumed default of 2ms does rate_limit_us
even make sense then? It is very often ignored with these changes, so
unless rate_limit_us==2000 && CONFIG_HZ=1000 SCHED_CPUFREQ_FORCE_UPDATE
would dominate for many workloads, wouldn't it?
Is that fine for all platforms? Platforms I'm aware of will drop older
requests when they couldn't be served yet and a new one is sent, can
we assume that generally?

> 
> We also teach sugov to ignore cpufreq updates from its sugov workers. It
> doesn't make sense for the kworker that applies the frequency update
> (which is a DL task) to trigger a frequency update itself.
> 
> There's room for an optimization that I haven't pursued yet (but plan to
> follow up with in the future) which is not to do an update for RT/DL if
> the frequency level is already the same. sugov currently already handles
> this, but since we force ignoring rate limit now, it would be ideal not
> to force too many frequency updates in a row if there's not much to do.
> We need to compare uclamp_min values for RT and bandwidth values for DL
> between next and prev tasks.
> 
> The update at task_tick_fair will guarantee that the governor will
> follow any updates to load for tasks/CPU or due to new enqueues/dequeues
> to the rq. Since DL and RT always run at constant frequencies and have
> no load tracking, this is only required for fair tasks.
> 
> The update at attach/detach_entity_load_avg() will ensure we adapt to
> big changes when tasks are added/removed from cgroups.
> 
> The update at update_blocked_averages() will ensure we decay frequency
> as the CPU becomes idle for long enough.
> 
> I am contemplating to make all updates except for CFS at context switch
> a forced updates. I'd welcome thoughts. Context switch should be our
> major drive for frequency change, and the other operations should be
> treated as out-of-line updates that must be honoured and not be
> accidentally dropped by rate limit. Contemplating the impact on shared
> policies if we go down that route too. Thoughts would be appreciated.

See below.

> 
> To make sure governors that don't register a cpufreq_update_util()
> handler aren't impacted, we protect the call with a static key to ensure
> that it is only active when the current governor makes use of it.
> 
> Results of `perf stat --repeat 10 perf bench sched pipe` on AMD 3900X to
> verify any potential overhead because of the addition at context switc
> 
> Before:
> -------
> 
> 	Performance counter stats for 'perf bench sched pipe' (10 runs):
> 
> 		 16,839.74 msec task-clock:u              #    1.158 CPUs utilized            ( +-  0.52% )
> 			 0      context-switches:u        #    0.000 /sec
> 			 0      cpu-migrations:u          #    0.000 /sec
> 		     1,390      page-faults:u             #   83.903 /sec                     ( +-  0.06% )
> 	       333,773,107      cycles:u                  #    0.020 GHz                      ( +-  0.70% )  (83.72%)
> 		67,050,466      stalled-cycles-frontend:u #   19.94% frontend cycles idle     ( +-  2.99% )  (83.23%)
> 		37,763,775      stalled-cycles-backend:u  #   11.23% backend cycles idle      ( +-  2.18% )  (83.09%)
> 		84,456,137      instructions:u            #    0.25  insn per cycle
> 							  #    0.83  stalled cycles per insn  ( +-  0.02% )  (83.01%)
> 		34,097,544      branches:u                #    2.058 M/sec                    ( +-  0.02% )  (83.52%)
> 		 8,038,902      branch-misses:u           #   23.59% of all branches          ( +-  0.03% )  (83.44%)
> 
> 		   14.5464 +- 0.0758 seconds time elapsed  ( +-  0.52% )
> 
> After:
> -------
> 
> 	Performance counter stats for 'perf bench sched pipe' (10 runs):
> 
> 		 16,219.58 msec task-clock:u              #    1.130 CPUs utilized            ( +-  0.80% )
> 			 0      context-switches:u        #    0.000 /sec
> 			 0      cpu-migrations:u          #    0.000 /sec
> 		     1,391      page-faults:u             #   85.163 /sec                     ( +-  0.06% )
> 	       342,768,312      cycles:u                  #    0.021 GHz                      ( +-  0.63% )  (83.36%)
> 		66,231,208      stalled-cycles-frontend:u #   18.91% frontend cycles idle     ( +-  2.34% )  (83.95%)
> 		39,055,410      stalled-cycles-backend:u  #   11.15% backend cycles idle      ( +-  1.80% )  (82.73%)
> 		84,475,662      instructions:u            #    0.24  insn per cycle
> 							  #    0.82  stalled cycles per insn  ( +-  0.02% )  (83.05%)
> 		34,067,160      branches:u                #    2.086 M/sec                    ( +-  0.02% )  (83.67%)
> 		 8,042,888      branch-misses:u           #   23.60% of all branches          ( +-  0.07% )  (83.25%)
> 
> 		    14.358 +- 0.116 seconds time elapsed  ( +-  0.81% )
> 
> Note worthy that we still have the following race condition on systems
> that have shared policy:
> 
> * CPUs with shared policy can end up sending simultaneous cpufreq
>   updates requests where the 2nd one will be unlucky and get blocked by
>   the rate_limit_us (schedutil).
> 
> We can potentially address this limitation later, but it is out of the
> scope of this patch.

Which has now gotten worse I'm afraid.
With a shared policy the "update at context switch" at least theoretically
no longer works for any freq update delay > 0.
It could be a non-issue, but confirming that isn't straightforward IMO.

> 
> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> ---
>  include/linux/sched/cpufreq.h    |  3 +-
>  kernel/sched/core.c              | 51 +++++++++++++++++++++++
>  kernel/sched/cpufreq.c           |  5 +++
>  kernel/sched/cpufreq_schedutil.c | 71 +++++++++++++++++++++++++-------
>  kernel/sched/deadline.c          |  4 --
>  kernel/sched/fair.c              | 53 ++++--------------------
>  kernel/sched/rt.c                |  8 +---
>  kernel/sched/sched.h             | 10 +++++
>  8 files changed, 133 insertions(+), 72 deletions(-)
> 
> diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
> index bdd31ab93bc5..2d0a45aba16f 100644
> --- a/include/linux/sched/cpufreq.h
> +++ b/include/linux/sched/cpufreq.h
> @@ -8,7 +8,8 @@
>   * Interface between cpufreq drivers and the scheduler:
>   */
>  
> -#define SCHED_CPUFREQ_IOWAIT	(1U << 0)
> +#define SCHED_CPUFREQ_IOWAIT		(1U << 0)
> +#define SCHED_CPUFREQ_FORCE_UPDATE	(1U << 1) /* ignore transition_delay_us */
>  
>  #ifdef CONFIG_CPU_FREQ
>  struct cpufreq_policy;
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 929fce69f555..563cb61dbf79 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5134,6 +5134,52 @@ static inline void balance_callbacks(struct rq *rq, struct balance_callback *hea
>  
>  #endif
>  
> +static inline void update_cpufreq_ctx_switch(struct rq *rq)
> +{
> +#ifdef CONFIG_CPU_FREQ
> +	unsigned int flags = 0;
> +
> +	if (!static_branch_likely(&cpufreq_update_enabled))
> +		return;
> +
> +#ifdef CONFIG_SMP
> +	if (unlikely(current->sched_class == &stop_sched_class))
> +		return;
> +#endif
> +
> +	if (unlikely(current->sched_class == &idle_sched_class))
> +		return;
> +
> +	if (unlikely(task_has_idle_policy(current)))
> +		return;
> +
> +	if (likely(fair_policy(current->policy))) {
> +
> +		if (unlikely(current->in_iowait)) {
> +			flags |= SCHED_CPUFREQ_IOWAIT | SCHED_CPUFREQ_FORCE_UPDATE;
> +			goto force_update;
> +		}
> +
> +#ifdef CONFIG_SMP
> +		/*
> +		 * Allow cpufreq updates once for every update_load_avg() decay.
> +		 */
> +		if (unlikely(rq->cfs.decayed)) {
> +			rq->cfs.decayed = false;
> +			goto force_update;
> +		}
> +#endif
> +		return;
> +	}
> +
> +	/* RT and DL should always send a freq update */
> +	flags |= SCHED_CPUFREQ_FORCE_UPDATE;
> +
> +force_update:
> +	cpufreq_update_util(rq, flags);
> +#endif
> +}
> +
>  static inline void
>  prepare_lock_switch(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
>  {
> @@ -5160,6 +5206,11 @@ static inline void finish_lock_switch(struct rq *rq)
>  	 */
>  	spin_acquire(&__rq_lockp(rq)->dep_map, 0, 0, _THIS_IP_);
>  	__balance_callbacks(rq);
> +	/*
> +	 * Request freq update after __balance_callbacks to take into account
> +	 * any changes to rq.
> +	 */
> +	update_cpufreq_ctx_switch(rq);
>  	raw_spin_rq_unlock_irq(rq);
>  }
>  
> diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
> index 5252fb191fae..369eb2c8c6ae 100644
> --- a/kernel/sched/cpufreq.c
> +++ b/kernel/sched/cpufreq.c
> @@ -8,6 +8,8 @@
>  
>  DEFINE_PER_CPU(struct update_util_data __rcu *, cpufreq_update_util_data);
>  
> +DEFINE_STATIC_KEY_FALSE(cpufreq_update_enabled);
> +
>  /**
>   * cpufreq_add_update_util_hook - Populate the CPU's update_util_data pointer.
>   * @cpu: The CPU to set the pointer for.
> @@ -33,6 +35,8 @@ void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
>  	if (WARN_ON(!data || !func))
>  		return;
>  
> +	static_branch_enable(&cpufreq_update_enabled);
> +
FWIW here's the lockdep splat:
[    3.798984] cpu cpu0: EM: created perf domain
[    3.804664] 
[    3.804825] ============================================
[    3.805296] WARNING: possible recursive locking detected
[    3.805768] 6.9.0-rc1-00003-gdc02af665938-dirty #251 Not tainted
[    3.806303] --------------------------------------------
[    3.806774] kworker/u24:0/10 is trying to acquire lock:
[    3.807241] ffff800085fde048 (cpu_hotplug_lock){++++}-{0:0}, at: cpus_read_lock+0x18/0x30
[    3.808007] 
[    3.808007] but task is already holding lock:
[    3.808524] ffff800085fde048 (cpu_hotplug_lock){++++}-{0:0}, at: cpus_read_lock+0x18/0x30
[    3.809277] 
[    3.809277] other info that might help us debug this:
[    3.809852]  Possible unsafe locking scenario:
[    3.809852] 
[    3.810376]        CPU0
[    3.810599]        ----
[    3.810821]   lock(cpu_hotplug_lock);
[    3.811159]   lock(cpu_hotplug_lock);
[    3.811496] 
[    3.811496]  *** DEADLOCK ***
[    3.811496] 
[    3.812018]  May be due to missing lock nesting notation
[    3.812018] 
[    3.812616] 6 locks held by kworker/u24:0/10:
[    3.813008]  #0: ffff00000042cd48 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1a8/0x648
[    3.813936]  #1: ffff80008732bde0 (deferred_probe_work){+.+.}-{0:0}, at: process_one_work+0x1d0/0x648
[    3.814783]  #2: ffff0000011b10f8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x40/0x1c0
[    3.815554]  #3: ffff800085fde048 (cpu_hotplug_lock){++++}-{0:0}, at: cpus_read_lock+0x18/0x30
[    3.816344]  #4: ffff0000011f9118 (subsys mutex#3){+.+.}-{3:3}, at: subsys_interface_register+0x58/0x128
[    3.817214]  #5: ffff00000a787b80 (&policy->rwsem){+.+.}-{3:3}, at: cpufreq_online+0x4a8/0xa50
[    3.818010] 
[    3.818010] stack backtrace:
[    3.818400] CPU: 4 PID: 10 Comm: kworker/u24:0 Not tainted 6.9.0-rc1-00003-gdc02af665938-dirty #251
[    3.819202] Hardware name: Pine64 RockPro64 v2.1 (DT)
[    3.819654] Workqueue: events_unbound deferred_probe_work_func
[    3.820182] Call trace:
[    3.820405]  dump_backtrace+0x9c/0x100
[    3.820748]  show_stack+0x20/0x38
[    3.821051]  dump_stack_lvl+0x90/0xd0
[    3.821391]  dump_stack+0x18/0x28
[    3.821699]  print_deadlock_bug+0x25c/0x348
[    3.822084]  __lock_acquire+0x10c4/0x2018
[    3.822451]  lock_acquire.part.0+0xc8/0x210
[    3.822833]  lock_acquire+0x68/0x88
[    3.823154]  percpu_down_read.constprop.0+0x3c/0x158
[    3.823603]  cpus_read_lock+0x18/0x30
[    3.823937]  static_key_enable+0x20/0x48
[    3.824299]  cpufreq_add_update_util_hook+0x44/0xa0
[    3.824740]  sugov_start+0xc0/0x140
[    3.825062]  cpufreq_start_governor+0x5c/0xa0
[    3.825461]  cpufreq_set_policy+0x290/0x350
[    3.825843]  cpufreq_online+0x28c/0xa50
[    3.826196]  cpufreq_add_dev+0x88/0xa8
[    3.826541]  subsys_interface_register+0x104/0x128
[    3.826974]  cpufreq_register_driver+0x158/0x248
[    3.827392]  dt_cpufreq_probe+0x150/0x498
[    3.827764]  platform_probe+0x70/0xf0
[    3.828101]  really_probe+0xc4/0x2a8
[    3.828428]  __driver_probe_device+0x80/0x140
[    3.828823]  driver_probe_device+0xe4/0x178
[    3.829202]  __device_attach_driver+0xc0/0x148
[    3.829605]  bus_for_each_drv+0x88/0xf0
[    3.829954]  __device_attach+0xb0/0x1c0
[    3.830304]  device_initial_probe+0x1c/0x30
[    3.830684]  bus_probe_device+0xb4/0xc0
[    3.831033]  deferred_probe_work_func+0x90/0xd8
[    3.831441]  process_one_work+0x228/0x648
[    3.831810]  worker_thread+0x260/0x3b0
[    3.832155]  kthread+0x120/0x130
[    3.832455]  ret_from_fork+0x10/0x20
[    3.836084] cpu cpu4: EM: created perf domain

>  	if (WARN_ON(per_cpu(cpufreq_update_util_data, cpu)))
>  		return;
>  
> @@ -54,6 +58,7 @@ EXPORT_SYMBOL_GPL(cpufreq_add_update_util_hook);
>  void cpufreq_remove_update_util_hook(int cpu)
>  {
>  	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), NULL);
> +	static_branch_disable(&cpufreq_update_enabled);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_remove_update_util_hook);
>  
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index eece6244f9d2..2f83ac898c34 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -59,7 +59,8 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
>  
>  /************************ Governor internals ***********************/
>  
> -static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
> +static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time,
> +				     unsigned int flags)
>  {
>  	s64 delta_ns;
>  
> @@ -87,13 +88,16 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
>  		return true;
>  	}
>  
> +	if (unlikely(flags & SCHED_CPUFREQ_FORCE_UPDATE))
> +		return true;
> +
>  	delta_ns = time - sg_policy->last_freq_update_time;
>  
>  	return delta_ns >= sg_policy->freq_update_delay_ns;
>  }
>  
>  static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
> -				   unsigned int next_freq)
> +				   unsigned int next_freq, unsigned int flags)
>  {
>  	if (sg_policy->need_freq_update)
>  		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> @@ -101,7 +105,9 @@ static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
>  		return false;
>  
>  	sg_policy->next_freq = next_freq;
> -	sg_policy->last_freq_update_time = time;
> +
> +	if (!unlikely(flags & SCHED_CPUFREQ_FORCE_UPDATE))
> +		sg_policy->last_freq_update_time = time;
>  
>  	return true;
>  }
> @@ -249,9 +255,10 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
>  			       unsigned int flags)
>  {
>  	bool set_iowait_boost = flags & SCHED_CPUFREQ_IOWAIT;
> +	bool forced_update = flags & SCHED_CPUFREQ_FORCE_UPDATE;
>  
>  	/* Reset boost if the CPU appears to have been idle enough */
> -	if (sg_cpu->iowait_boost &&
> +	if (sg_cpu->iowait_boost && !forced_update &&
>  	    sugov_iowait_reset(sg_cpu, time, set_iowait_boost))
>  		return;
>  
> @@ -294,17 +301,29 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
>   * being more conservative on tasks which does sporadic IO operations.
>   */
>  static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
> -			       unsigned long max_cap)
> +			       unsigned long max_cap, unsigned int flags)
>  {
> +	bool forced_update = flags & SCHED_CPUFREQ_FORCE_UPDATE;
> +	s64 delta_ns = time - sg_cpu->last_update;
> +
>  	/* No boost currently required */
>  	if (!sg_cpu->iowait_boost)
>  		return 0;
>  
> +	if (forced_update)
> +		goto apply_boost;
> +
>  	/* Reset boost if the CPU appears to have been idle enough */
>  	if (sugov_iowait_reset(sg_cpu, time, false))
>  		return 0;
>  
>  	if (!sg_cpu->iowait_boost_pending) {
> +		/*
> +		 * Reduce boost only if a tick has elapsed since last request.
> +		 */
> +		if (delta_ns <= TICK_NSEC)
> +			goto apply_boost;
> +

That makes the entire reduce logic below dead code.
If delta_ns > TICK_NSEC then sugov_iowait_reset() will have returned early
anyway and reset the boost.
In theory the current iowait boost (probabilisticly because of rate_limit_us)
determined the boost level more or less by the fraction of iowait wakeups
to non-wakeups.
Did that ever work in a meaningful way? Maybe not.
But of course just relying on the reset opens up the boost to linger for
even longer.
Anyway the iowait boost needs some rework in both intel_pstate and sugov
if we switch to a context-switch freq update IMO.


>  		/*
>  		 * No boost pending; reduce the boost value.
>  		 */
> @@ -315,6 +334,7 @@ static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
>  		}
>  	}
>  
> +apply_boost:
>  	sg_cpu->iowait_boost_pending = false;
>  
>  	/*
> @@ -351,17 +371,28 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
>  					      u64 time, unsigned long max_cap,
>  					      unsigned int flags)
>  {
> +	bool forced_update = flags & SCHED_CPUFREQ_FORCE_UPDATE;
> +	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
> +	bool iowait_boost = flags & SCHED_CPUFREQ_IOWAIT;
>  	unsigned long boost;
>  
> +	/*
> +	 * Forced updates are initiated by iowait and RT/DL tasks. If the
> +	 * latter, verify that it's not our worker thread that is initiating
> +	 * this forced update.
> +	 */
> +	if (forced_update && !iowait_boost && current == sg_policy->thread)
> +		return false;
> +
I don't quite see why this isn't just
if (current == sg_policy->thread)
Is there a reason?

>  	sugov_iowait_boost(sg_cpu, time, flags);
>  	sg_cpu->last_update = time;
>  
>  	ignore_dl_rate_limit(sg_cpu);
>  
> -	if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
> +	if (!sugov_should_update_freq(sg_cpu->sg_policy, time, flags))
>  		return false;
>  
> -	boost = sugov_iowait_apply(sg_cpu, time, max_cap);
> +	boost = sugov_iowait_apply(sg_cpu, time, max_cap, flags);
>  	sugov_get_util(sg_cpu, boost);
>  
>  	return true;
> @@ -397,7 +428,7 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
>  		sg_policy->cached_raw_freq = cached_freq;
>  	}
>  
> -	if (!sugov_update_next_freq(sg_policy, time, next_f))
> +	if (!sugov_update_next_freq(sg_policy, time, next_f, flags))
>  		return;
>  
>  	/*
> @@ -449,10 +480,12 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
>  	cpufreq_driver_adjust_perf(sg_cpu->cpu, sg_cpu->bw_min,
>  				   sg_cpu->util, max_cap);
>  
> -	sg_cpu->sg_policy->last_freq_update_time = time;
> +	if (!unlikely(flags & SCHED_CPUFREQ_FORCE_UPDATE))
> +		sg_cpu->sg_policy->last_freq_update_time = time;
Is that unlikely? Or rather don't we intend to optimise for the
SCHED_CPUFREQ_FORCE_UPDATE case, as it's the more time-critical one?
Just a thought though.

>  }
>  
> -static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
> +static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time,
> +					   unsigned int flags)
>  {
>  	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
>  	struct cpufreq_policy *policy = sg_policy->policy;
> @@ -465,7 +498,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
>  		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
>  		unsigned long boost;
>  
> -		boost = sugov_iowait_apply(j_sg_cpu, time, max_cap);
> +		boost = sugov_iowait_apply(j_sg_cpu, time, max_cap, flags);
>  		sugov_get_util(j_sg_cpu, boost);
>  
>  		util = max(j_sg_cpu->util, util);
> @@ -478,9 +511,19 @@ static void
>  sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
>  {
>  	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
> +	bool forced_update = flags & SCHED_CPUFREQ_FORCE_UPDATE;
>  	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
> +	bool iowait_boost = flags & SCHED_CPUFREQ_IOWAIT;
>  	unsigned int next_f;
>  
> +	/*
> +	 * Forced updates are initiated by iowait and RT/DL tasks. If the
> +	 * latter, verify that it's not our worker thread that is initiating
> +	 * this forced update.
> +	 */
> +	if (forced_update && !iowait_boost && current == sg_policy->thread)
> +		return;
> +
Same question as above.

>  	raw_spin_lock(&sg_policy->update_lock);
>  
>  	sugov_iowait_boost(sg_cpu, time, flags);
> @@ -488,10 +531,10 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
>  
>  	ignore_dl_rate_limit(sg_cpu);
>  
> -	if (sugov_should_update_freq(sg_policy, time)) {
> -		next_f = sugov_next_freq_shared(sg_cpu, time);
> +	if (sugov_should_update_freq(sg_policy, time, flags)) {
> +		next_f = sugov_next_freq_shared(sg_cpu, time, flags);
>  
> -		if (!sugov_update_next_freq(sg_policy, time, next_f))
> +		if (!sugov_update_next_freq(sg_policy, time, next_f, flags))
>  			goto unlock;
>  
>  		if (sg_policy->policy->fast_switch_enabled)
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index a04a436af8cc..02c9c2488091 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -252,8 +252,6 @@ void __add_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
>  	dl_rq->running_bw += dl_bw;
>  	SCHED_WARN_ON(dl_rq->running_bw < old); /* overflow */
>  	SCHED_WARN_ON(dl_rq->running_bw > dl_rq->this_bw);
> -	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
> -	cpufreq_update_util(rq_of_dl_rq(dl_rq), 0);
>  }
>  
>  static inline
> @@ -266,8 +264,6 @@ void __sub_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
>  	SCHED_WARN_ON(dl_rq->running_bw > old); /* underflow */
>  	if (dl_rq->running_bw > old)
>  		dl_rq->running_bw = 0;
> -	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
> -	cpufreq_update_util(rq_of_dl_rq(dl_rq), 0);
>  }
>  
>  static inline
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c8e50fbac345..a0692e308d2d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3982,29 +3982,6 @@ static inline void update_cfs_group(struct sched_entity *se)
>  }
>  #endif /* CONFIG_FAIR_GROUP_SCHED */
>  
> -static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
> -{
> -	struct rq *rq = rq_of(cfs_rq);
> -
> -	if (&rq->cfs == cfs_rq) {
> -		/*
> -		 * There are a few boundary cases this might miss but it should
> -		 * get called often enough that that should (hopefully) not be
> -		 * a real problem.
> -		 *
> -		 * It will not get called when we go idle, because the idle
> -		 * thread is a different class (!fair), nor will the utilization
> -		 * number include things like RT tasks.
> -		 *
> -		 * As is, the util number is not freq-invariant (we'd have to
> -		 * implement arch_scale_freq_capacity() for that).
> -		 *
> -		 * See cpu_util_cfs().
> -		 */
> -		cpufreq_update_util(rq, flags);
> -	}
> -}
> -
>  #ifdef CONFIG_SMP
>  static inline bool load_avg_is_decayed(struct sched_avg *sa)
>  {
> @@ -4682,7 +4659,7 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  
>  	add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);
>  
> -	cfs_rq_util_change(cfs_rq, 0);
> +	cpufreq_update_util(rq_of(cfs_rq), 0);
>  
>  	trace_pelt_cfs_tp(cfs_rq);
>  }
> @@ -4712,7 +4689,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  
>  	add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
>  
> -	cfs_rq_util_change(cfs_rq, 0);
> +	cpufreq_update_util(rq_of(cfs_rq), 0);
>  
>  	trace_pelt_cfs_tp(cfs_rq);
>  }
> @@ -4729,7 +4706,6 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  {
>  	u64 now = cfs_rq_clock_pelt(cfs_rq);
> -	int decayed;
>  
>  	/*
>  	 * Track task load average for carrying it to new CPU after migrated, and
> @@ -4738,8 +4714,8 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  	if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))
>  		__update_load_avg_se(now, cfs_rq, se);
>  
> -	decayed  = update_cfs_rq_load_avg(now, cfs_rq);
> -	decayed |= propagate_entity_load_avg(se);
> +	cfs_rq->decayed  = update_cfs_rq_load_avg(now, cfs_rq);
> +	cfs_rq->decayed |= propagate_entity_load_avg(se);
>  
>  	if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
>  
> @@ -4760,11 +4736,8 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  		 */
>  		detach_entity_load_avg(cfs_rq, se);
>  		update_tg_load_avg(cfs_rq);
> -	} else if (decayed) {
> -		cfs_rq_util_change(cfs_rq, 0);
> -
> -		if (flags & UPDATE_TG)
> -			update_tg_load_avg(cfs_rq);
> +	} else if (cfs_rq->decayed && (flags & UPDATE_TG)) {
> +		update_tg_load_avg(cfs_rq);
>  	}
>  }
>  
> @@ -5126,7 +5099,6 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
>  
>  static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
>  {
> -	cfs_rq_util_change(cfs_rq, 0);
>  }
>  
>  static inline void remove_entity_load_avg(struct sched_entity *se) {}
> @@ -6716,14 +6688,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	 */
>  	util_est_enqueue(&rq->cfs, p);
>  
> -	/*
> -	 * If in_iowait is set, the code below may not trigger any cpufreq
> -	 * utilization updates, so do it here explicitly with the IOWAIT flag
> -	 * passed.
> -	 */
> -	if (p->in_iowait)
> -		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
> -

I'm sure you're aware, but of course this also changes behavior in intel_pstate.

>  	for_each_sched_entity(se) {
>  		if (se->on_rq)
>  			break;
> @@ -9282,10 +9246,6 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
>  	unsigned long thermal_pressure;
>  	bool decayed;
>  
> -	/*
> -	 * update_load_avg() can call cpufreq_update_util(). Make sure that RT,
> -	 * DL and IRQ signals have been updated before updating CFS.
> -	 */
>  	curr_class = rq->curr->sched_class;
>  
>  	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
> @@ -12623,6 +12583,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>  
>  	update_misfit_status(curr, rq);
>  	update_overutilized_status(task_rq(curr));
> +	cpufreq_update_util(rq, 0);
>  
>  	task_tick_core(rq, curr);
>  }
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 3261b067b67e..fe6d8b0ffa95 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -556,11 +556,8 @@ static void sched_rt_rq_dequeue(struct rt_rq *rt_rq)
>  
>  	rt_se = rt_rq->tg->rt_se[cpu];
>  
> -	if (!rt_se) {
> +	if (!rt_se)
>  		dequeue_top_rt_rq(rt_rq, rt_rq->rt_nr_running);
> -		/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
> -		cpufreq_update_util(rq_of_rt_rq(rt_rq), 0);
> -	}
>  	else if (on_rt_rq(rt_se))
>  		dequeue_rt_entity(rt_se, 0);
>  }
> @@ -1065,9 +1062,6 @@ enqueue_top_rt_rq(struct rt_rq *rt_rq)
>  		add_nr_running(rq, rt_rq->rt_nr_running);
>  		rt_rq->rt_queued = 1;
>  	}
> -
> -	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
> -	cpufreq_update_util(rq, 0);
>  }
>  
>  #if defined CONFIG_SMP
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 41024c1c49b4..6a6de92448d1 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -618,6 +618,11 @@ struct cfs_rq {
>  		unsigned long	runnable_avg;
>  	} removed;
>  
> +	/*
> +	 * Store whether last update_load_avg() has decayed
> +	 */
> +	bool			decayed;
> +
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  	u64			last_update_tg_load_avg;
>  	unsigned long		tg_load_avg_contrib;
> @@ -2961,6 +2966,8 @@ static inline u64 irq_time_read(int cpu)
>  #ifdef CONFIG_CPU_FREQ
>  DECLARE_PER_CPU(struct update_util_data __rcu *, cpufreq_update_util_data);
>  
> +DECLARE_STATIC_KEY_FALSE(cpufreq_update_enabled);
> +
>  /**
>   * cpufreq_update_util - Take a note about CPU utilization changes.
>   * @rq: Runqueue to carry out the update for.
> @@ -2987,6 +2994,9 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags)
>  {
>  	struct update_util_data *data;
>  
> +	if (!static_branch_likely(&cpufreq_update_enabled))
> +		return;
> +
>  	data = rcu_dereference_sched(*per_cpu_ptr(&cpufreq_update_util_data,
>  						  cpu_of(rq)));
>  	if (data)

Apart from the two issues of:
- Does spamming cpufreq updates faster than rate_limit_us have any side-effects on some platforms?
- iowait boosting needs to be revisited.
I don't see anything fundamentally wrong with the approach as of now.

Kind Regards,
Christian

