Return-Path: <linux-kernel+bounces-9596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C38C81C82A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B29284927
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA93C171A9;
	Fri, 22 Dec 2023 10:32:53 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16B1168AD
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 10:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D8402F4;
	Fri, 22 Dec 2023 02:33:35 -0800 (PST)
Received: from [10.57.87.46] (unknown [10.57.87.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C0B03F738;
	Fri, 22 Dec 2023 02:32:46 -0800 (PST)
Message-ID: <371608cd-9abd-4022-a8a0-3a4aa00f535c@arm.com>
Date: Fri, 22 Dec 2023 10:32:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 18/23] sched: Add push_task_chain helper
Content-Language: en-US
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Joel Fernandes <joelaf@google.com>, Qais Yousef <qyousef@google.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat
 <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 kernel-team@android.com
References: <20231220001856.3710363-1-jstultz@google.com>
 <20231220001856.3710363-19-jstultz@google.com>
From: Metin Kaya <metin.kaya@arm.com>
In-Reply-To: <20231220001856.3710363-19-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/12/2023 12:18 am, John Stultz wrote:
> From: Connor O'Brien <connoro@google.com>
> 
> Switch logic that deactivates, sets the task cpu,
> and reactivates a task on a different rq to use a
> helper that will be later extended to push entire
> blocked task chains.
> 
> This patch was broken out from a larger chain migration
> patch originally by Connor O'Brien.

I think the patches #18, #19, #22 can be upstreamed regardless of other 
Proxy Execution patches.

> 
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Qais Yousef <qyousef@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Zimuzo Ezeozue <zezeozue@google.com>
> Cc: Youssef Esmat <youssefesmat@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Metin Kaya <Metin.Kaya@arm.com>
> Cc: Xuewen Yan <xuewen.yan94@gmail.com>
> Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: kernel-team@android.com
> Signed-off-by: Connor O'Brien <connoro@google.com>
> [jstultz: split out from larger chain migration patch]
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
>   kernel/sched/core.c     | 4 +---
>   kernel/sched/deadline.c | 8 ++------
>   kernel/sched/rt.c       | 8 ++------
>   kernel/sched/sched.h    | 9 +++++++++
>   4 files changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0cd63bd0bdcd..0c212dcd4b7a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2721,9 +2721,7 @@ int push_cpu_stop(void *arg)
>   
>   	// XXX validate p is still the highest prio task
>   	if (task_rq(p) == rq) {
> -		deactivate_task(rq, p, 0);
> -		set_task_cpu(p, lowest_rq->cpu);
> -		activate_task(lowest_rq, p, 0);
> +		push_task_chain(rq, lowest_rq, p);
>   		resched_curr(lowest_rq);
>   	}
>   
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 4f998549ea74..def1eb23318b 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2313,9 +2313,7 @@ static int push_dl_task(struct rq *rq)
>   		goto retry;
>   	}
>   
> -	deactivate_task(rq, next_task, 0);
> -	set_task_cpu(next_task, later_rq->cpu);
> -	activate_task(later_rq, next_task, 0);
> +	push_task_chain(rq, later_rq, next_task);
>   	ret = 1;
>   
>   	resched_curr(later_rq);
> @@ -2401,9 +2399,7 @@ static void pull_dl_task(struct rq *this_rq)
>   			if (is_migration_disabled(p)) {
>   				push_task = get_push_task(src_rq);
>   			} else {
> -				deactivate_task(src_rq, p, 0);
> -				set_task_cpu(p, this_cpu);
> -				activate_task(this_rq, p, 0);
> +				push_task_chain(src_rq, this_rq, p);
>   				dmin = p->dl.deadline;
>   				resched = true;
>   			}
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index a7b51a021111..cf0eb4aac613 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2128,9 +2128,7 @@ static int push_rt_task(struct rq *rq, bool pull)
>   		goto retry;
>   	}
>   
> -	deactivate_task(rq, next_task, 0);
> -	set_task_cpu(next_task, lowest_rq->cpu);
> -	activate_task(lowest_rq, next_task, 0);
> +	push_task_chain(rq, lowest_rq, next_task);
>   	resched_curr(lowest_rq);
>   	ret = 1;
>   
> @@ -2401,9 +2399,7 @@ static void pull_rt_task(struct rq *this_rq)
>   			if (is_migration_disabled(p)) {
>   				push_task = get_push_task(src_rq);
>   			} else {
> -				deactivate_task(src_rq, p, 0);
> -				set_task_cpu(p, this_cpu);
> -				activate_task(this_rq, p, 0);
> +				push_task_chain(src_rq, this_rq, p);
>   				resched = true;
>   			}
>   			/*
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 765ba10661de..19afe532771f 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3546,5 +3546,14 @@ static inline void init_sched_mm_cid(struct task_struct *t) { }
>   
>   extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
>   extern int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se);
> +#ifdef CONFIG_SMP
> +static inline
> +void push_task_chain(struct rq *rq, struct rq *dst_rq, struct task_struct *task)
> +{
> +	deactivate_task(rq, task, 0);
> +	set_task_cpu(task, dst_rq->cpu);
> +	activate_task(dst_rq, task, 0);
> +}
> +#endif
>   
>   #endif /* _KERNEL_SCHED_SCHED_H */


