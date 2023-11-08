Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981127E52B6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbjKHJht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKHJhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:37:48 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB12199
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 01:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7UGEVbPDKW86arlOpWMG5o+CcD0Juo30JkEeKJv9V3M=; b=afZpI7csGSh+SqgCIhXY62tgk8
        AV51dYsaKnNvbumqESqqM6q7ZTecUoeACxWM8jVxgJMh9SB5rZN9ybqDkbPqsDxm62G3HgzgAD5cm
        19DI9HU9tnX6wuu/vXCfvEWd8ZfnF0cy0hnQiLdfymfdClt6J90mRV+/2olQbiBzLsntQ8uQyarjT
        nnRF66smjzoSuAo8QtNoE+ZM+2KVOl/YSEnoLilmyS3ZmYgRnlUoSLbk8DtdwrOjZDb1HEXXnqaX/
        B+Gj+OtOaK9wKQuNSRyDWdHy+Q3lKvCC1lbg+HjadBN7rgr3DDlzOJltLzrrODV0kztlLYSoV5hgk
        FZ2wAZPg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r0ezN-00DNKk-2K;
        Wed, 08 Nov 2023 09:36:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 61EEB30049D; Wed,  8 Nov 2023 10:36:45 +0100 (CET)
Date:   Wed, 8 Nov 2023 10:36:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 41/86] sched: handle resched policy in resched_curr()
Message-ID: <20231108093645.GL8262@noisy.programming.kicks-ass.net>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-42-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107215742.363031-42-ankur.a.arora@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 01:57:27PM -0800, Ankur Arora wrote:

> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1027,13 +1027,13 @@ void wake_up_q(struct wake_q_head *head)
>  }
>  
>  /*
> - * resched_curr - mark rq's current task 'to be rescheduled now'.
> + * __resched_curr - mark rq's current task 'to be rescheduled'.
>   *
> - * On UP this means the setting of the need_resched flag, on SMP it
> - * might also involve a cross-CPU call to trigger the scheduler on
> - * the target CPU.
> + * On UP this means the setting of the need_resched flag, on SMP, for
> + * eager resched it might also involve a cross-CPU call to trigger
> + * the scheduler on the target CPU.
>   */
> -void resched_curr(struct rq *rq)
> +void __resched_curr(struct rq *rq, resched_t rs)
>  {
>  	struct task_struct *curr = rq->curr;
>  	int cpu;
> @@ -1046,17 +1046,77 @@ void resched_curr(struct rq *rq)
>  	cpu = cpu_of(rq);
>  
>  	if (cpu == smp_processor_id()) {
> -		set_tsk_need_resched(curr, RESCHED_eager);
> -		set_preempt_need_resched();
> +		set_tsk_need_resched(curr, rs);
> +		if (rs == RESCHED_eager)
> +			set_preempt_need_resched();
>  		return;
>  	}
>  
> -	if (set_nr_and_not_polling(curr, RESCHED_eager))
> -		smp_send_reschedule(cpu);
> -	else
> +	if (set_nr_and_not_polling(curr, rs)) {
> +		if (rs == RESCHED_eager)
> +			smp_send_reschedule(cpu);

I think you just broke things.

Not all idle threads have POLLING support, in which case you need that
IPI to wake them up, even if it's LAZY.

> +	} else if (rs == RESCHED_eager)
>  		trace_sched_wake_idle_without_ipi(cpu);
>  }



>  
> +/*
> + * resched_curr - mark rq's current task 'to be rescheduled' eagerly
> + * or lazily according to the current policy.
> + *
> + * Always schedule eagerly, if:
> + *
> + *  - running under full preemption
> + *
> + *  - idle: when not polling (or if we don't have TIF_POLLING_NRFLAG)
> + *    force TIF_NEED_RESCHED to be set and send a resched IPI.
> + *    (the polling case has already set TIF_NEED_RESCHED via
> + *     set_nr_if_polling()).
> + *
> + *  - in userspace: run to completion semantics are only for kernel tasks
> + *
> + * Otherwise (regardless of priority), run to completion.
> + */
> +void resched_curr(struct rq *rq)
> +{
> +	resched_t rs = RESCHED_lazy;
> +	int context;
> +
> +	if (IS_ENABLED(CONFIG_PREEMPT) ||
> +	    (rq->curr->sched_class == &idle_sched_class)) {
> +		rs = RESCHED_eager;
> +		goto resched;
> +	}
> +
> +	/*
> +	 * We might race with the target CPU while checking its ct_state:
> +	 *
> +	 * 1. The task might have just entered the kernel, but has not yet
> +	 * called user_exit(). We will see stale state (CONTEXT_USER) and
> +	 * send an unnecessary resched-IPI.
> +	 *
> +	 * 2. The user task is through with exit_to_user_mode_loop() but has
> +	 * not yet called user_enter().
> +	 *
> +	 * We'll see the thread's state as CONTEXT_KERNEL and will try to
> +	 * schedule it lazily. There's obviously nothing that will handle
> +	 * this need-resched bit until the thread enters the kernel next.
> +	 *
> +	 * The scheduler will still do tick accounting, but a potentially
> +	 * higher priority task waited to be scheduled for a user tick,
> +	 * instead of execution time in the kernel.
> +	 */
> +	context = ct_state_cpu(cpu_of(rq));
> +	if ((context == CONTEXT_USER) ||
> +	    (context == CONTEXT_GUEST)) {
> +
> +		rs = RESCHED_eager;
> +		goto resched;
> +	}

Like said, this simply cannot be. You must not rely on the remote CPU
being in some state or not. Also, it's racy, you could observe USER and
then it enters KERNEL.

> +
> +resched:
> +	__resched_curr(rq, rs);
> +}
> +
>  void resched_cpu(int cpu)
>  {
>  	struct rq *rq = cpu_rq(cpu);
