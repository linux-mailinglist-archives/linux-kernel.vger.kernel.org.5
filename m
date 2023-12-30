Return-Path: <linux-kernel+bounces-13562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA8E820815
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 18:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C107A283E03
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 17:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995C6BA4B;
	Sat, 30 Dec 2023 17:57:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8FBBA31
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EFBF2F4;
	Sat, 30 Dec 2023 09:57:55 -0800 (PST)
Received: from [192.168.178.38] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 819633F64C;
	Sat, 30 Dec 2023 09:57:05 -0800 (PST)
Message-ID: <dbd36b16-4acb-415a-9bbd-258b2e022475@arm.com>
Date: Sat, 30 Dec 2023 18:56:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] v2 sched: Fix tg->load when offlining a CPU
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com, imran.f.khan@oracle.com, aaron.lu@intel.com,
 linux-kernel@vger.kernel.org
References: <20231223111545.62135-1-vincent.guittot@linaro.org>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20231223111545.62135-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/12/2023 12:15, Vincent Guittot wrote:
> When a CPU taken offline, the contribution of its cfs_rqs to task_groups'
> load may remain and impact the calculation of the share of the online
> CPUs.
> Clear the contribution of an offlining CPU to task groups' load and skip
> its contribution while it is inactive.

The patch got applied to tip/sched/core a couple of hours ago so this
might be too late ...

Isn't this fix in rq_offline_fair() also affecting all the other cpus
via cpuset_hotplug_workfn() -> rebuild_sched_domains_locked() ->
partition_sched_domains_locked() -> cpu_attach_domain() ->
rq_attach_root() -> set_rq_offline() ?

> 
> Reported-by: Imran Khan <imran.f.khan@oracle.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-and-tested-by: Imran Khan <imran.f.khan@oracle.com>
> ---
> 
> - Fix !CONFIG_FAIR_GROUP_SCHED case
> 
>  kernel/sched/fair.c | 52 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bcea3d55d95d..4b09237d24b9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4100,6 +4100,10 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
>  	if (cfs_rq->tg == &root_task_group)
>  		return;
>  
> +	/* rq has been offline and doesn't contribute anymore to the share */
> +	if (!cpu_active(cpu_of(rq_of(cfs_rq))))
> +		return;
> +
>  	/*
>  	 * For migration heavy workloads, access to tg->load_avg can be
>  	 * unbound. Limit the update rate to at most once per ms.
> @@ -4116,6 +4120,49 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
>  	}
>  }
>  
> +static inline void clear_tg_load_avg(struct cfs_rq *cfs_rq)
> +{
> +	long delta;
> +	u64 now;
> +
> +	/*
> +	 * No need to update load_avg for root_task_group as it is not used.
> +	 */
> +	if (cfs_rq->tg == &root_task_group)
> +		return;
> +
> +	now = sched_clock_cpu(cpu_of(rq_of(cfs_rq)));
> +	delta = 0 - cfs_rq->tg_load_avg_contrib;
> +	atomic_long_add(delta, &cfs_rq->tg->load_avg);

Why not:

atomic_long_sub(cfs_rq->tg_load_avg_contrib, &cfs_rq->tg->load_avg) w/o
the local `long delta`?

> +	cfs_rq->tg_load_avg_contrib = 0;
> +	cfs_rq->last_update_tg_load_avg = now;
> +}
> +
> +/* cpu offline callback */
> +static void __maybe_unused clear_tg_offline_cfs_rqs(struct rq *rq)
> +{
> +	struct task_group *tg;
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	/*
> +	 * The rq clock has already been updated in the
> +	 * set_rq_offline(), so we should skip updating
> +	 * the rq clock again in unthrottle_cfs_rq().

This comment seems misleading here since it looks that it is tailored to
unthrottle_offline_cfs_rqs(), the other cpu offline callback.

> +	 */
> +	rq_clock_start_loop_update(rq);
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(tg, &task_groups, list) {
> +		struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
> +
> +		clear_tg_load_avg(cfs_rq);
> +	}
> +	rcu_read_unlock();
> +
> +	rq_clock_stop_loop_update(rq);
> +}
> +
>  /*
>   * Called within set_task_rq() right before setting a task's CPU. The
>   * caller only guarantees p->pi_lock is held; no other assumptions,
> @@ -4412,6 +4459,8 @@ static inline bool skip_blocked_update(struct sched_entity *se)
>  
>  static inline void update_tg_load_avg(struct cfs_rq *cfs_rq) {}
>  
> +static inline void clear_tg_offline_cfs_rqs(struct rq *rq) {}
> +
>  static inline int propagate_entity_load_avg(struct sched_entity *se)
>  {
>  	return 0;
> @@ -12446,6 +12495,9 @@ static void rq_offline_fair(struct rq *rq)
>  
>  	/* Ensure any throttled groups are reachable by pick_next_task */
>  	unthrottle_offline_cfs_rqs(rq);
> +
> +	/* Ensure that we remove rq contribution to group share */
> +	clear_tg_offline_cfs_rqs(rq);
>  }
>  
>  #endif /* CONFIG_SMP */


