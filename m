Return-Path: <linux-kernel+bounces-9762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B2081CAFE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57BC11F24E12
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C26A19BD3;
	Fri, 22 Dec 2023 13:52:55 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92289199B3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFD7E2F4;
	Fri, 22 Dec 2023 05:53:36 -0800 (PST)
Received: from [10.57.87.46] (unknown [10.57.87.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BB623F64C;
	Fri, 22 Dec 2023 05:52:48 -0800 (PST)
Message-ID: <3ea82554-bd7e-41d9-8bea-f12317b27f4f@arm.com>
Date: Fri, 22 Dec 2023 13:52:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 22/23] sched: Refactor dl/rt find_lowest/latest_rq
 logic
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
 <20231220001856.3710363-23-jstultz@google.com>
From: Metin Kaya <metin.kaya@arm.com>
In-Reply-To: <20231220001856.3710363-23-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/12/2023 12:18 am, John Stultz wrote:
> This pulls re-validation logic done in find_lowest_rq
> and find_latest_rq after re-acquiring the rq locks out into its
> own function.
> 
> This allows us to later use a more complicated validation
> check for chain-migration when using proxy-exectuion.

                                              execution

> 
> TODO: It seems likely we could consolidate this two functions
> further and leave the task_is_rt()/task_is_dl() checks externally?

Agreed.

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
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
>   kernel/sched/deadline.c | 31 ++++++++++++++++++++-----
>   kernel/sched/rt.c       | 50 ++++++++++++++++++++++++++++-------------
>   2 files changed, 59 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 21e56ac58e32..8b5701727342 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2172,6 +2172,30 @@ static int find_later_rq(struct task_struct *sched_ctx, struct task_struct *exec
>   	return -1;
>   }
>   
> +static inline bool dl_revalidate_rq_state(struct task_struct *task, struct rq *rq,
> +					  struct rq *later)
> +{
> +	if (task_rq(task) != rq)
> +		return false;
> +
> +	if (!cpumask_test_cpu(later->cpu, &task->cpus_mask))
> +		return false;
> +
> +	if (task_on_cpu(rq, task))
> +		return false;
> +
> +	if (!dl_task(task))
> +		return false;
> +
> +	if (is_migration_disabled(task))
> +		return false;
> +
> +	if (!task_on_rq_queued(task))
> +		return false;
> +
> +	return true;
> +}
> +
>   /* Locks the rq it finds */
>   static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
>   {
> @@ -2204,12 +2228,7 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
>   
>   		/* Retry if something changed. */
>   		if (double_lock_balance(rq, later_rq)) {
> -			if (unlikely(task_rq(task) != rq ||
> -				     !cpumask_test_cpu(later_rq->cpu, &task->cpus_mask) ||
> -				     task_on_cpu(rq, task) ||
> -				     !dl_task(task) ||
> -				     is_migration_disabled(task) ||
> -				     !task_on_rq_queued(task))) {
> +			if (unlikely(!dl_revalidate_rq_state(task, rq, later_rq))) {
>   				double_unlock_balance(rq, later_rq);
>   				later_rq = NULL;
>   				break;
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index f8134d062fa3..fabb19891e95 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1935,6 +1935,39 @@ static int find_lowest_rq(struct task_struct *sched_ctx, struct task_struct *exe
>   	return -1;
>   }
>   
> +static inline bool rt_revalidate_rq_state(struct task_struct *task, struct rq *rq,
> +					  struct rq *lowest)
> +{
> +	/*
> +	 * We had to unlock the run queue. In
> +	 * the mean time, task could have
> +	 * migrated already or had its affinity changed.
> +	 * Also make sure that it wasn't scheduled on its rq.
> +	 * It is possible the task was scheduled, set
> +	 * "migrate_disabled" and then got preempted, so we must
> +	 * check the task migration disable flag here too.
> +	 */
> +	if (task_rq(task) != rq)
> +		return false;
> +
> +	if (!cpumask_test_cpu(lowest->cpu, &task->cpus_mask))
> +		return false;
> +
> +	if (task_on_cpu(rq, task))
> +		return false;
> +
> +	if (!rt_task(task))
> +		return false;
> +
> +	if (is_migration_disabled(task))
> +		return false;
> +
> +	if (!task_on_rq_queued(task))
> +		return false;
> +
> +	return true;
> +}
> +
>   /* Will lock the rq it finds */
>   static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>   {
> @@ -1964,22 +1997,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>   
>   		/* if the prio of this runqueue changed, try again */
>   		if (double_lock_balance(rq, lowest_rq)) {
> -			/*
> -			 * We had to unlock the run queue. In
> -			 * the mean time, task could have
> -			 * migrated already or had its affinity changed.
> -			 * Also make sure that it wasn't scheduled on its rq.
> -			 * It is possible the task was scheduled, set
> -			 * "migrate_disabled" and then got preempted, so we must
> -			 * check the task migration disable flag here too.
> -			 */
> -			if (unlikely(task_rq(task) != rq ||
> -				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
> -				     task_on_cpu(rq, task) ||
> -				     !rt_task(task) ||
> -				     is_migration_disabled(task) ||
> -				     !task_on_rq_queued(task))) {
> -
> +			if (unlikely(!rt_revalidate_rq_state(task, rq, lowest_rq))) {
>   				double_unlock_balance(rq, lowest_rq);
>   				lowest_rq = NULL;
>   				break;


