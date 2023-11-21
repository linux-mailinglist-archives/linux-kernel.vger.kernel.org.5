Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0357F22BA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 02:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjKUBBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 20:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjKUBBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 20:01:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE47BC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 17:01:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70F2C433C8;
        Tue, 21 Nov 2023 01:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700528460;
        bh=eFuGQ34wGE9sgrcqAbpQQH2cWyCk63YT2cso4pX9XSM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=daSGM7Soy9XlDP5Fe0btjSlPrxR1IBF9mwLgUIao/L6A9JP7pa336eFCFwY95Zo1x
         xhlkNjdhvgM4AyXhuzNfrM4YCWv20+I5dnQUeGNFLrDVJJDfB+kDODmLkSy+2mesU2
         lg8s8HzEUczfgx8OfkgL/Y0YhEk0jPi5ndqt9EvsovVzVIsvDT9fBEGJpqN4oHZD5v
         jU8jbyisBPvdWoxqnZXrD+S/hgzKwyKM+sjERNzwH6llrbUgCxvg+Fryk+1WqZO0Lf
         KF2F+YeZ5nOV7Q18piwe05DzkT8jGuvZrsO3XfszF47ujR+oFSPbku9dYH+xlM/+bI
         1gQwvLtem26Aw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 72F13CE1390; Mon, 20 Nov 2023 17:01:00 -0800 (PST)
Date:   Mon, 20 Nov 2023 17:01:00 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
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
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [RFC PATCH 59/86] treewide: rcu: remove cond_resched()
Message-ID: <f18b000f-1e3f-463e-91e5-b1d69a17643a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-3-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107230822.371443-3-ankur.a.arora@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 03:07:55PM -0800, Ankur Arora wrote:
> All the cond_resched() calls in the RCU interfaces here are to
> drive preemption once it has reported a potentially quiescent
> state, or to exit the grace period. With PREEMPTION=y that should
> happen implicitly.
> 
> So we can remove these.
> 
> [1] https://lore.kernel.org/lkml/20231107215742.363031-1-ankur.a.arora@oracle.com/
> 
> Cc: "Paul E. McKenney" <paulmck@kernel.org> 
> Cc: Frederic Weisbecker <frederic@kernel.org> 
> Cc: Ingo Molnar <mingo@redhat.com> 
> Cc: Peter Zijlstra <peterz@infradead.org> 
> Cc: Juri Lelli <juri.lelli@redhat.com> 
> Cc: Vincent Guittot <vincent.guittot@linaro.org> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  include/linux/rcupdate.h | 6 ++----
>  include/linux/sched.h    | 7 ++++++-
>  kernel/hung_task.c       | 6 +++---
>  kernel/rcu/tasks.h       | 5 +----
>  4 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 7246ee602b0b..58f8c7faaa52 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -238,14 +238,12 @@ static inline bool rcu_trace_implies_rcu_gp(void) { return true; }
>  /**
>   * cond_resched_tasks_rcu_qs - Report potential quiescent states to RCU
>   *
> - * This macro resembles cond_resched(), except that it is defined to
> - * report potential quiescent states to RCU-tasks even if the cond_resched()
> - * machinery were to be shut off, as some advocate for PREEMPTION kernels.
> + * This macro resembles cond_resched(), in that it reports potential
> + * quiescent states to RCU-tasks.
>   */
>  #define cond_resched_tasks_rcu_qs() \
>  do { \
>  	rcu_tasks_qs(current, false); \
> -	cond_resched(); \

I am a bit nervous about dropping the cond_resched() in a few cases,
for example, the call from rcu_tasks_trace_pregp_step() only momentarily
enables interrupts.  This should be OK given a scheduling-clock interrupt,
except that nohz_full CPUs don't necessarily have these.  At least not
unless RCU happens to be in a grace period at the time.

>  } while (0)
>  
>  /*
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 199f8f7211f2..bae6eed534dd 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2145,7 +2145,12 @@ static inline void cond_resched_rcu(void)
>  {
>  #if defined(CONFIG_DEBUG_ATOMIC_SLEEP) || !defined(CONFIG_PREEMPT_RCU)
>  	rcu_read_unlock();
> -	cond_resched();
> +
> +	/*
> +	 * Might reschedule here as we exit the RCU read-side
> +	 * critical section.
> +	 */
> +
>  	rcu_read_lock();

And here I am wondering if some of my nervousness about increased
grace-period latency due to removing cond_resched() might be addressed
by making preempt_enable() take over the help-RCU functionality currently
being provided by cond_resched()...

>  #endif
>  }
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index 9a24574988d2..4bdfad08a2e8 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -153,8 +153,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>   * To avoid extending the RCU grace period for an unbounded amount of time,
>   * periodically exit the critical section and enter a new one.
>   *
> - * For preemptible RCU it is sufficient to call rcu_read_unlock in order
> - * to exit the grace period. For classic RCU, a reschedule is required.
> + * Under a preemptive kernel, or with preemptible RCU, it is sufficient to
> + * call rcu_read_unlock in order to exit the grace period.
>   */
>  static bool rcu_lock_break(struct task_struct *g, struct task_struct *t)
>  {
> @@ -163,7 +163,7 @@ static bool rcu_lock_break(struct task_struct *g, struct task_struct *t)
>  	get_task_struct(g);
>  	get_task_struct(t);
>  	rcu_read_unlock();
> -	cond_resched();
> +
>  	rcu_read_lock();
>  	can_cont = pid_alive(g) && pid_alive(t);
>  	put_task_struct(t);
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 8d65f7d576a3..fa1d9aa31b36 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -541,7 +541,6 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
>  		local_bh_disable();
>  		rhp->func(rhp);
>  		local_bh_enable();
> -		cond_resched();

...and by local_bh_enable().

						Thanx, Paul

>  	}
>  	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
>  	rcu_segcblist_add_len(&rtpcp->cblist, -len);
> @@ -974,10 +973,8 @@ static void check_all_holdout_tasks(struct list_head *hop,
>  {
>  	struct task_struct *t, *t1;
>  
> -	list_for_each_entry_safe(t, t1, hop, rcu_tasks_holdout_list) {
> +	list_for_each_entry_safe(t, t1, hop, rcu_tasks_holdout_list)
>  		check_holdout_task(t, needreport, firstreport);
> -		cond_resched();
> -	}
>  }
>  
>  /* Finish off the Tasks-RCU grace period. */
> -- 
> 2.31.1
> 
