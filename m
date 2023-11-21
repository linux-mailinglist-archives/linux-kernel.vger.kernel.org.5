Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2815E7F36C8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 20:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjKUTZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 14:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjKUTZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 14:25:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDA2193
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 11:25:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B9EC433C7;
        Tue, 21 Nov 2023 19:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700594718;
        bh=txS+NC9XfL0401PnsDenT1JWd4lisQJp6T4LJN6fisg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=c64K2SE3oDO62ebSsXI1mle4tjTOrX1Js8JNvA4shwAidhIP/TXtz0i10QhBRaXa9
         7CZWE0BunfGvmfJvqjqqXxSLOEioJE5h6EIGdgUwf+Z/15/XY/Hki8kDGZQulJM8CW
         5tuXvWNFKe4K9Pxcc8nkSN2DkPd7C9GX0/UrFBTjPgdhGYqn1IL4agaxJneotiQGYs
         HBcWAbjywsYSK0NoS5HD9tXMaWOSFrqzcTpjyZk70wMqerZxjxOPFVL+eOv08plPVP
         FoqJWDRa9rOIhcN5c6HYqzDdLz//cqwUhFK107N5aRXx/xqNx2Y1kENtOj2C7ToiTn
         2wExk7Yc35pOg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 62D57CE0594; Tue, 21 Nov 2023 11:25:18 -0800 (PST)
Date:   Tue, 21 Nov 2023 11:25:18 -0800
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
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 48/86] rcu: handle quiescent states for PREEMPT_RCU=n
Message-ID: <d10b6243-41b1-44a0-ba95-0cedc7f6856e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-49-ankur.a.arora@oracle.com>
 <2027da00-273d-41cf-b9e7-460776181083@paulmck-laptop>
 <87lear4wj6.fsf@oracle.com>
 <46a4c47a-ba1c-4776-a6f8-6c2146cbdd0d@paulmck-laptop>
 <31d50051-e42c-4ef2-a1ac-e45370c3752e@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31d50051-e42c-4ef2-a1ac-e45370c3752e@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 09:34:05PM -0800, Paul E. McKenney wrote:
> On Mon, Nov 20, 2023 at 09:17:57PM -0800, Paul E. McKenney wrote:
> > On Mon, Nov 20, 2023 at 07:26:05PM -0800, Ankur Arora wrote:
> > > 
> > > Paul E. McKenney <paulmck@kernel.org> writes:
> > > > On Tue, Nov 07, 2023 at 01:57:34PM -0800, Ankur Arora wrote:
> > > >> cond_resched() is used to provide urgent quiescent states for
> > > >> read-side critical sections on PREEMPT_RCU=n configurations.
> > > >> This was necessary because lacking preempt_count, there was no
> > > >> way for the tick handler to know if we were executing in RCU
> > > >> read-side critical section or not.
> > > >>
> > > >> An always-on CONFIG_PREEMPT_COUNT, however, allows the tick to
> > > >> reliably report quiescent states.
> > > >>
> > > >> Accordingly, evaluate preempt_count() based quiescence in
> > > >> rcu_flavor_sched_clock_irq().
> > > >>
> > > >> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > > >> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> > > >> ---
> > > >>  kernel/rcu/tree_plugin.h |  3 ++-
> > > >>  kernel/sched/core.c      | 15 +--------------
> > > >>  2 files changed, 3 insertions(+), 15 deletions(-)
> > > >>
> > > >> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > >> index f87191e008ff..618f055f8028 100644
> > > >> --- a/kernel/rcu/tree_plugin.h
> > > >> +++ b/kernel/rcu/tree_plugin.h
> > > >> @@ -963,7 +963,8 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
> > > >>   */
> > > >>  static void rcu_flavor_sched_clock_irq(int user)
> > > >>  {
> > > >> -	if (user || rcu_is_cpu_rrupt_from_idle()) {
> > > >> +	if (user || rcu_is_cpu_rrupt_from_idle() ||
> > > >> +	    !(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) {
> > > >
> > > > This looks good.
> > > >
> > > >>  		/*
> > > >>  		 * Get here if this CPU took its interrupt from user
> > > >> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > >> index bf5df2b866df..15db5fb7acc7 100644
> > > >> --- a/kernel/sched/core.c
> > > >> +++ b/kernel/sched/core.c
> > > >> @@ -8588,20 +8588,7 @@ int __sched _cond_resched(void)
> > > >>  		preempt_schedule_common();
> > > >>  		return 1;
> > > >>  	}
> > > >> -	/*
> > > >> -	 * In preemptible kernels, ->rcu_read_lock_nesting tells the tick
> > > >> -	 * whether the current CPU is in an RCU read-side critical section,
> > > >> -	 * so the tick can report quiescent states even for CPUs looping
> > > >> -	 * in kernel context.  In contrast, in non-preemptible kernels,
> > > >> -	 * RCU readers leave no in-memory hints, which means that CPU-bound
> > > >> -	 * processes executing in kernel context might never report an
> > > >> -	 * RCU quiescent state.  Therefore, the following code causes
> > > >> -	 * cond_resched() to report a quiescent state, but only when RCU
> > > >> -	 * is in urgent need of one.
> > > >> -	 *      /
> > > >> -#ifndef CONFIG_PREEMPT_RCU
> > > >> -	rcu_all_qs();
> > > >> -#endif
> > > >
> > > > But...
> > > >
> > > > Suppose we have a long-running loop in the kernel that regularly
> > > > enables preemption, but only momentarily.  Then the added
> > > > rcu_flavor_sched_clock_irq() check would almost always fail, making
> > > > for extremely long grace periods.
> > > 
> > > So, my thinking was that if RCU wants to end a grace period, it would
> > > force a context switch by setting TIF_NEED_RESCHED (and as patch 38 mentions
> > > RCU always uses the the eager version) causing __schedule() to call
> > > rcu_note_context_switch().
> > > That's similar to the preempt_schedule_common() case in the
> > > _cond_resched() above.
> > 
> > But that requires IPIing that CPU, correct?
> > 
> > > But if I see your point, RCU might just want to register a quiescent
> > > state and for this long-running loop rcu_flavor_sched_clock_irq() does
> > > seem to fall down.
> > > 
> > > > Or did I miss a change that causes preempt_enable() to help RCU out?
> > > 
> > > Something like this?
> > > 
> > > diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> > > index dc5125b9c36b..e50f358f1548 100644
> > > --- a/include/linux/preempt.h
> > > +++ b/include/linux/preempt.h
> > > @@ -222,6 +222,8 @@ do { \
> > >         barrier(); \
> > >         if (unlikely(preempt_count_dec_and_test())) \
> > >                 __preempt_schedule(); \
> > > +       if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) \
> > > +               rcu_all_qs(); \
> > >  } while (0)
> > 
> > Or maybe something like this to lighten the load a bit:
> > 
> > #define preempt_enable() \
> > do { \
> > 	barrier(); \
> > 	if (unlikely(preempt_count_dec_and_test())) { \
> > 		__preempt_schedule(); \
> > 		if (raw_cpu_read(rcu_data.rcu_urgent_qs) && \
> > 		    !(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) \
> > 			rcu_all_qs(); \
> > 	} \
> > } while (0)
> > 
> > And at that point, we should be able to drop the PREEMPT_MASK, not
> > that it makes any difference that I am aware of:
> > 
> > #define preempt_enable() \
> > do { \
> > 	barrier(); \
> > 	if (unlikely(preempt_count_dec_and_test())) { \
> > 		__preempt_schedule(); \
> > 		if (raw_cpu_read(rcu_data.rcu_urgent_qs) && \
> > 		    !(preempt_count() & SOFTIRQ_MASK)) \
> > 			rcu_all_qs(); \
> > 	} \
> > } while (0)
> > 
> > Except that we can migrate as soon as that preempt_count_dec_and_test()
> > returns.  And that rcu_all_qs() disables and re-enables preemption,
> > which will result in undesired recursion.  Sigh.
> > 
> > So maybe something like this:
> > 
> > #define preempt_enable() \
> > do { \
> > 	if (raw_cpu_read(rcu_data.rcu_urgent_qs) && \
> > 	    !(preempt_count() & SOFTIRQ_MASK)) \
> 
> Sigh.  This needs to include (PREEMPT_MASK | SOFTIRQ_MASK),
> but check for equality to something like (1UL << PREEMPT_SHIFT).
> 
> Clearly time to sleep.  :-/

Maybe this might actually work:

#define preempt_enable() \
do { \
	barrier(); \
	if (!IS_ENABLED(CONFIG_PREEMPT_RCU) && raw_cpu_read(rcu_data.rcu_urgent_qs) && \
	    (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK | HARDIRQ_MASK | NMI_MASK) == PREEMPT_OFFSET) &&
	    !irqs_disabled()) \
		rcu_all_qs(); \
	if (unlikely(preempt_count_dec_and_test())) { \
		__preempt_schedule(); \
	} \
} while (0)

And the rcu_all_qs() below might also work.

							Thanx, Paul

> > 		rcu_all_qs(); \
> > 	barrier(); \
> > 	if (unlikely(preempt_count_dec_and_test())) { \
> > 		__preempt_schedule(); \
> > 	} \
> > } while (0)
> > 
> > Then rcu_all_qs() becomes something like this:
> > 
> > void rcu_all_qs(void)
> > {
> > 	unsigned long flags;
> > 
> > 	/* Load rcu_urgent_qs before other flags. */
> > 	if (!smp_load_acquire(this_cpu_ptr(&rcu_data.rcu_urgent_qs)))
> > 		return;
> > 	this_cpu_write(rcu_data.rcu_urgent_qs, false);
> > 	if (unlikely(raw_cpu_read(rcu_data.rcu_need_heavy_qs))) {
> > 		local_irq_save(flags);
> > 		rcu_momentary_dyntick_idle();
> > 		local_irq_restore(flags);
> > 	}
> > 	rcu_qs();
> > }
> > EXPORT_SYMBOL_GPL(rcu_all_qs);
> > 
> > > Though I do wonder about the likelihood of hitting the case you describe
> > > and maybe instead of adding the check on every preempt_enable()
> > > it might be better to instead force a context switch in the
> > > rcu_flavor_sched_clock_irq() (as we do in the PREEMPT_RCU=y case.)
> > 
> > Maybe.  But rcu_all_qs() is way lighter weight than a context switch.
> > 
> > 							Thanx, Paul
