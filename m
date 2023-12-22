Return-Path: <linux-kernel+bounces-9588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC09281C815
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 955C728686D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AF41773B;
	Fri, 22 Dec 2023 10:23:53 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11045171C7
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94C2D2F4;
	Fri, 22 Dec 2023 02:24:34 -0800 (PST)
Received: from [10.57.87.46] (unknown [10.57.87.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91F953F738;
	Fri, 22 Dec 2023 02:23:45 -0800 (PST)
Message-ID: <11171acd-dae7-475f-ab93-a890f0f0d273@arm.com>
Date: Fri, 22 Dec 2023 10:23:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 19/23] sched: Consolidate pick_*_task to
 task_is_pushable helper
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
 <20231220001856.3710363-20-jstultz@google.com>
From: Metin Kaya <metin.kaya@arm.com>
In-Reply-To: <20231220001856.3710363-20-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/12/2023 12:18 am, John Stultz wrote:
> From: Connor O'Brien <connoro@google.com>
> 
> This patch consolidates rt and deadline pick_*_task functions to
> a task_is_pushable() helper
> 
> This patch was broken out from a larger chain migration
> patch originally by Connor O'Brien.
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
> [jstultz: split out from larger chain migration patch,
>   renamed helper function]
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
> v7:
> * Split from chain migration patch
> * Renamed function
> ---
>   kernel/sched/deadline.c | 10 +---------
>   kernel/sched/rt.c       | 11 +----------
>   kernel/sched/sched.h    | 10 ++++++++++
>   3 files changed, 12 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index def1eb23318b..1f3bc50de678 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2049,14 +2049,6 @@ static void task_fork_dl(struct task_struct *p)
>   /* Only try algorithms three times */
>   #define DL_MAX_TRIES 3
>   
> -static int pick_dl_task(struct rq *rq, struct task_struct *p, int cpu)
> -{
> -	if (!task_on_cpu(rq, p) &&
> -	    cpumask_test_cpu(cpu, &p->cpus_mask))
> -		return 1;
> -	return 0;
> -}
> -
>   /*
>    * Return the earliest pushable rq's task, which is suitable to be executed
>    * on the CPU, NULL otherwise:
> @@ -2075,7 +2067,7 @@ static struct task_struct *pick_earliest_pushable_dl_task(struct rq *rq, int cpu
>   	if (next_node) {
>   		p = __node_2_pdl(next_node);
>   
> -		if (pick_dl_task(rq, p, cpu))
> +		if (task_is_pushable(rq, p, cpu) == 1)

Nit: ` == 1` part is redundant, IMHO.

>   			return p;
>   
>   		next_node = rb_next(next_node);
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index cf0eb4aac613..15161de88753 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1812,15 +1812,6 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
>   /* Only try algorithms three times */
>   #define RT_MAX_TRIES 3
>   
> -static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
> -{
> -	if (!task_on_cpu(rq, p) &&
> -	    cpumask_test_cpu(cpu, &p->cpus_mask))
> -		return 1;
> -
> -	return 0;
> -}
> -
>   /*
>    * Return the highest pushable rq's task, which is suitable to be executed
>    * on the CPU, NULL otherwise
> @@ -1834,7 +1825,7 @@ static struct task_struct *pick_highest_pushable_task(struct rq *rq, int cpu)
>   		return NULL;
>   
>   	plist_for_each_entry(p, head, pushable_tasks) {
> -		if (pick_rt_task(rq, p, cpu))
> +		if (task_is_pushable(rq, p, cpu) == 1)

Ditto.

>   			return p;
>   	}
>   
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 19afe532771f..ef3d327e267c 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3554,6 +3554,16 @@ void push_task_chain(struct rq *rq, struct rq *dst_rq, struct task_struct *task)
>   	set_task_cpu(task, dst_rq->cpu);
>   	activate_task(dst_rq, task, 0);
>   }
> +
> +static inline
> +int task_is_pushable(struct rq *rq, struct task_struct *p, int cpu)

Nit: I know the function is just renamed in this patch, but should we 
change the return type to bool while we are at it?

> +{
> +	if (!task_on_cpu(rq, p) &&
> +	    cpumask_test_cpu(cpu, &p->cpus_mask))
> +		return 1;
> +
> +	return 0;
> +}
>   #endif
>   
>   #endif /* _KERNEL_SCHED_SCHED_H */


