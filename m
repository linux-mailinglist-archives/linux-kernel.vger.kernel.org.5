Return-Path: <linux-kernel+bounces-8345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D82BD81B5FD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E83F286C79
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D4F745D3;
	Thu, 21 Dec 2023 12:30:49 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D40A7319C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 723952F4;
	Thu, 21 Dec 2023 04:31:30 -0800 (PST)
Received: from [10.1.25.50] (e132833.arm.com [10.1.25.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C14A73F5A1;
	Thu, 21 Dec 2023 04:30:42 -0800 (PST)
Message-ID: <d029fafd-658a-44ec-872d-62370c6422d7@arm.com>
Date: Thu, 21 Dec 2023 12:30:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/23] sched: Split out __sched() deactivate task logic
 into a helper
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
 <20231220001856.3710363-11-jstultz@google.com>
From: Metin Kaya <metin.kaya@arm.com>
In-Reply-To: <20231220001856.3710363-11-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/12/2023 12:18 am, John Stultz wrote:
> As we're going to re-use the deactivation logic,
> split it into a helper.
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
> v6:
> * Define function as static to avoid "no previous prototype"
>    warnings as Reported-by: kernel test robot <lkp@intel.com>
> v7:
> * Rename state task_state to be more clear, as suggested by
>    Metin Kaya
> ---
>   kernel/sched/core.c | 66 +++++++++++++++++++++++++--------------------
>   1 file changed, 37 insertions(+), 29 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0ce34f5c0e0c..34acd80b6bd0 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6571,6 +6571,42 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>   # define SM_MASK_PREEMPT	SM_PREEMPT
>   #endif
>   

* Better to have a comment (e.g., in which conditions 
try_to_deactivate_task() returns true or false) here.

* try_to_deactivate_task() is temporarily used by 2 commits in the patch 
set (i.e., it's only called by __schedule() just like in this patch at 
the end of the series). However, it's nice to make that big 
__scheduler() function a bit modular as we discussed off-list. So, 
should we move this function out of the Proxy Execution patch set to get 
it merged independently?

> +static bool try_to_deactivate_task(struct rq *rq, struct task_struct *p,
> +				   unsigned long task_state)
> +{
> +	if (signal_pending_state(task_state, p)) {
> +		WRITE_ONCE(p->__state, TASK_RUNNING);
> +	} else {
> +		p->sched_contributes_to_load =
> +			(task_state & TASK_UNINTERRUPTIBLE) &&
> +			!(task_state & TASK_NOLOAD) &&
> +			!(task_state & TASK_FROZEN);
> +
> +		if (p->sched_contributes_to_load)
> +			rq->nr_uninterruptible++;
> +
> +		/*
> +		 * __schedule()			ttwu()
> +		 *   prev_state = prev->state;    if (p->on_rq && ...)
> +		 *   if (prev_state)		    goto out;
> +		 *     p->on_rq = 0;		  smp_acquire__after_ctrl_dep();
> +		 *				  p->state = TASK_WAKING
> +		 *
> +		 * Where __schedule() and ttwu() have matching control dependencies.
> +		 *
> +		 * After this, schedule() must not care about p->state any more.
> +		 */
> +		deactivate_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
> +
> +		if (p->in_iowait) {
> +			atomic_inc(&rq->nr_iowait);
> +			delayacct_blkio_start();
> +		}
> +		return true;
> +	}
> +	return false;
> +}
> +
>   /*
>    * __schedule() is the main scheduler function.
>    *
> @@ -6662,35 +6698,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>   	 */
>   	prev_state = READ_ONCE(prev->__state);
>   	if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
> -		if (signal_pending_state(prev_state, prev)) {
> -			WRITE_ONCE(prev->__state, TASK_RUNNING);
> -		} else {
> -			prev->sched_contributes_to_load =
> -				(prev_state & TASK_UNINTERRUPTIBLE) &&
> -				!(prev_state & TASK_NOLOAD) &&
> -				!(prev_state & TASK_FROZEN);
> -
> -			if (prev->sched_contributes_to_load)
> -				rq->nr_uninterruptible++;
> -
> -			/*
> -			 * __schedule()			ttwu()
> -			 *   prev_state = prev->state;    if (p->on_rq && ...)
> -			 *   if (prev_state)		    goto out;
> -			 *     p->on_rq = 0;		  smp_acquire__after_ctrl_dep();
> -			 *				  p->state = TASK_WAKING
> -			 *
> -			 * Where __schedule() and ttwu() have matching control dependencies.
> -			 *
> -			 * After this, schedule() must not care about p->state any more.
> -			 */
> -			deactivate_task(rq, prev, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
> -
> -			if (prev->in_iowait) {
> -				atomic_inc(&rq->nr_iowait);
> -				delayacct_blkio_start();
> -			}
> -		}
> +		try_to_deactivate_task(rq, prev, prev_state);
>   		switch_count = &prev->nvcsw;
>   	}
>   


