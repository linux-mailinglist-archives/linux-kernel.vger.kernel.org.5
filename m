Return-Path: <linux-kernel+bounces-8616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B839581BA29
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC4828C7EE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488E34E1B0;
	Thu, 21 Dec 2023 15:03:13 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684094AF75
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93F6C2F4;
	Thu, 21 Dec 2023 07:03:54 -0800 (PST)
Received: from [10.1.25.50] (e132833.arm.com [10.1.25.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA3CE3F64C;
	Thu, 21 Dec 2023 07:03:06 -0800 (PST)
Message-ID: <de0ac26f-1fde-4472-8570-7d0bf730176a@arm.com>
Date: Thu, 21 Dec 2023 15:03:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/23] sched: Fix proxy/current (push,pull)ability
Content-Language: en-US
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>,
 Joel Fernandes <joelaf@google.com>, Qais Yousef <qyousef@google.com>,
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
 <20231220001856.3710363-13-jstultz@google.com>
From: Metin Kaya <metin.kaya@arm.com>
In-Reply-To: <20231220001856.3710363-13-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/12/2023 12:18 am, John Stultz wrote:
> From: Valentin Schneider <valentin.schneider@arm.com>
> 
> Proxy execution forms atomic pairs of tasks: The selected task
> (scheduling context) and a proxy (execution context). The
> selected task, along with the rest of the blocked chain,
> follows the proxy wrt CPU placement.
> 
> They can be the same task, in which case push/pull doesn't need any
> modification. When they are different, however,
> FIFO1 & FIFO42:
> 
> 	      ,->  RT42
> 	      |     | blocked-on
> 	      |     v
> blocked_donor |   mutex
> 	      |     | owner
> 	      |     v
> 	      `--  RT1
> 
>     RT1
>     RT42
> 
>    CPU0            CPU1
>     ^                ^
>     |                |
>    overloaded    !overloaded
>    rq prio = 42  rq prio = 0
> 
> RT1 is eligible to be pushed to CPU1, but should that happen it will
> "carry" RT42 along. Clearly here neither RT1 nor RT42 must be seen as
> push/pullable.
> 
> Unfortunately, only the selected task is usually dequeued from the
> rq, and the proxy'ed execution context (rq->curr) remains on the rq.
> This can cause RT1 to be selected for migration from logic like the
> rt pushable_list.
> 
> This patch adds a dequeue/enqueue cycle on the proxy task before
> __schedule returns, which allows the sched class logic to avoid
> adding the now current task to the pushable_list.
> 
> Furthermore, tasks becoming blocked on a mutex don't need an explicit
> dequeue/enqueue cycle to be made (push/pull)able: they have to be running
> to block on a mutex, thus they will eventually hit put_prev_task().
> 
> XXX: pinned tasks becoming unblocked should be removed from the push/pull
> lists, but those don't get to see __schedule() straight away.
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
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Connor O'Brien <connoro@google.com>
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
> v3:
> * Tweaked comments & commit message
> v5:
> * Minor simplifications to utilize the fix earlier
>    in the patch series.
> * Rework the wording of the commit message to match selected/
>    proxy terminology and expand a bit to make it more clear how
>    it works.
> v6:
> * Droped now-unused proxied value, to be re-added later in the

   Dropped

>    series when it is used, as caught by Dietmar
> v7:
> * Unused function argument fixup
> * Commit message nit pointed out by Metin Kaya
> * Droped unproven unlikely() and use sched_proxy_exec()

   ditto

>    in proxy_tag_curr, suggested by Metin Kaya
> ---
>   kernel/sched/core.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 12f5a0618328..f6bf3b62194c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6674,6 +6674,23 @@ find_proxy_task(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
>   }
>   #endif /* SCHED_PROXY_EXEC */
>   
> +static inline void proxy_tag_curr(struct rq *rq, struct task_struct *next)
> +{
> +	if (sched_proxy_exec()) {

Should we immediately return in !sched_proxy_exec() case to save one 
level of indentation?

> +		/*
> +		 * pick_next_task() calls set_next_task() on the selected task
> +		 * at some point, which ensures it is not push/pullable.
> +		 * However, the selected task *and* the ,mutex owner form an

Super-nit: , before mutex should be dropped.

> +		 * atomic pair wrt push/pull.
> +		 *
> +		 * Make sure owner is not pushable. Unfortunately we can only
> +		 * deal with that by means of a dequeue/enqueue cycle. :-/
> +		 */
> +		dequeue_task(rq, next, DEQUEUE_NOCLOCK | DEQUEUE_SAVE);
> +		enqueue_task(rq, next, ENQUEUE_NOCLOCK | ENQUEUE_RESTORE);
> +	}
> +}
> +
>   /*
>    * __schedule() is the main scheduler function.
>    *
> @@ -6796,6 +6813,10 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>   		 * changes to task_struct made by pick_next_task().
>   		 */
>   		RCU_INIT_POINTER(rq->curr, next);
> +
> +		if (!task_current_selected(rq, next))
> +			proxy_tag_curr(rq, next);
> +
>   		/*
>   		 * The membarrier system call requires each architecture
>   		 * to have a full memory barrier after updating
> @@ -6820,6 +6841,10 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>   		/* Also unlocks the rq: */
>   		rq = context_switch(rq, prev, next, &rf);
>   	} else {
> +		/* In case next was already curr but just got blocked_donor*/

Super-nit: please keep a space before */.

> +		if (!task_current_selected(rq, next))
> +			proxy_tag_curr(rq, next);
> +
>   		rq_unpin_lock(rq, &rf);
>   		__balance_callbacks(rq);
>   		raw_spin_rq_unlock_irq(rq);


