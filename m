Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DFD7F397B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbjKUWwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 17:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjKUWwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 17:52:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EF4DD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 14:51:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5FAC433C8;
        Tue, 21 Nov 2023 22:51:55 +0000 (UTC)
Date:   Tue, 21 Nov 2023 17:52:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, David.Laight@aculab.com,
        richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 48/86] rcu: handle quiescent states for
 PREEMPT_RCU=n
Message-ID: <20231121175209.1d7ec202@gandalf.local.home>
In-Reply-To: <4605b4f4-8a2b-4653-b684-9c696c36ebd0@paulmck-laptop>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
        <20231107215742.363031-49-ankur.a.arora@oracle.com>
        <2027da00-273d-41cf-b9e7-460776181083@paulmck-laptop>
        <87lear4wj6.fsf@oracle.com>
        <46a4c47a-ba1c-4776-a6f8-6c2146cbdd0d@paulmck-laptop>
        <31d50051-e42c-4ef2-a1ac-e45370c3752e@paulmck-laptop>
        <d10b6243-41b1-44a0-ba95-0cedc7f6856e@paulmck-laptop>
        <20231121203049.GN8262@noisy.programming.kicks-ass.net>
        <1cdbb0f6-9078-4023-bf37-8d826ca0c711@paulmck-laptop>
        <20231121163834.571abb52@gandalf.local.home>
        <4605b4f4-8a2b-4653-b684-9c696c36ebd0@paulmck-laptop>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023 14:26:33 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Tue, Nov 21, 2023 at 04:38:34PM -0500, Steven Rostedt wrote:
> > On Tue, 21 Nov 2023 13:14:16 -0800
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >   
> > > On Tue, Nov 21, 2023 at 09:30:49PM +0100, Peter Zijlstra wrote:  
> > > > On Tue, Nov 21, 2023 at 11:25:18AM -0800, Paul E. McKenney wrote:    
> > > > > #define preempt_enable() \
> > > > > do { \
> > > > > 	barrier(); \
> > > > > 	if (!IS_ENABLED(CONFIG_PREEMPT_RCU) && raw_cpu_read(rcu_data.rcu_urgent_qs) && \
> > > > > 	    (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK | HARDIRQ_MASK | NMI_MASK) == PREEMPT_OFFSET) &&
> > > > > 	    !irqs_disabled()) \  
> > 
> > Could we make the above an else case of the below if ?  
> 
> Wouldn't that cause the above preempt_count() test to always fail?

preempt_count_dec_and_test() returns true if preempt_count() is zero, which
happens only if NEED_RESCHED is set, and the rest of preempt_count() is not
set. (NEED_RESCHED bit in preempt_count() is really the inverse of
NEED_RESCHED). Do we need to call rcu_all_qs() when we call the scheduler?
Isn't scheduling a quiescent state for most RCU flavors?

I thought this was to help move along the quiescent states without added
cond_resched() around, which has:

int __sched __cond_resched(void)
{
	if (should_resched(0)) {
		preempt_schedule_common();
		return 1;
	}
	/*
	 * In preemptible kernels, ->rcu_read_lock_nesting tells the tick
	 * whether the current CPU is in an RCU read-side critical section,
	 * so the tick can report quiescent states even for CPUs looping
	 * in kernel context.  In contrast, in non-preemptible kernels,
	 * RCU readers leave no in-memory hints, which means that CPU-bound
	 * processes executing in kernel context might never report an
	 * RCU quiescent state.  Therefore, the following code causes
	 * cond_resched() to report a quiescent state, but only when RCU
	 * is in urgent need of one.
	 */
#ifndef CONFIG_PREEMPT_RCU
	rcu_all_qs();
#endif
	return 0;
}

Where if we schedule, we don't call rcu_all_qs().

I stand by that being in the else statement. It looks like that would keep
the previous work flow.

-- Steve
