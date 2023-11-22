Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9BC7F3A88
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 01:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbjKVABc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 19:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbjKVAB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 19:01:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210F79F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 16:01:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988D4C433C8;
        Wed, 22 Nov 2023 00:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700611284;
        bh=SQLOLBDlMnBI/mq/51HaPLasJW//OWPjVkbjwRsgkDM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=m856fzwao6VC1b7rfMpHRHSwFRBn/HzA0R6GPpPfTRdeX7+IUoayUxL4OKGE7LETf
         duVfYQOhpHLCp6GgodseTyNakLsR3hBmzXm+BHjQ5O9JuGuFn7/bot4Goy/hHsdkK0
         OBBfUE6vhVacg36l5pHklboO+uTdYAEuedRQ3tqw9U/xF/zW7HERoka4z28vpo4H1k
         60BNPJHTQah3ZUXTYsCYkX4oSA63PkeKmcj3kNNy3FSHrXHMNDQSoPBCfpdeub+ZWg
         mNmZNfzisfubfYp/KOAzFOLlgcf9VHKreihLjT8Vlm6mTsXS6mnkyZpSWWJ9Hs9aV5
         zPt+h9maJR/Tg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1E650CE0ACF; Tue, 21 Nov 2023 16:01:24 -0800 (PST)
Date:   Tue, 21 Nov 2023 16:01:24 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Subject: Re: [RFC PATCH 48/86] rcu: handle quiescent states for PREEMPT_RCU=n
Message-ID: <0d6a8e80-c89b-4ded-8de1-8c946874f787@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <2027da00-273d-41cf-b9e7-460776181083@paulmck-laptop>
 <87lear4wj6.fsf@oracle.com>
 <46a4c47a-ba1c-4776-a6f8-6c2146cbdd0d@paulmck-laptop>
 <31d50051-e42c-4ef2-a1ac-e45370c3752e@paulmck-laptop>
 <d10b6243-41b1-44a0-ba95-0cedc7f6856e@paulmck-laptop>
 <20231121203049.GN8262@noisy.programming.kicks-ass.net>
 <1cdbb0f6-9078-4023-bf37-8d826ca0c711@paulmck-laptop>
 <20231121163834.571abb52@gandalf.local.home>
 <4605b4f4-8a2b-4653-b684-9c696c36ebd0@paulmck-laptop>
 <20231121175209.1d7ec202@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121175209.1d7ec202@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 05:52:09PM -0500, Steven Rostedt wrote:
> On Tue, 21 Nov 2023 14:26:33 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > On Tue, Nov 21, 2023 at 04:38:34PM -0500, Steven Rostedt wrote:
> > > On Tue, 21 Nov 2023 13:14:16 -0800
> > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > >   
> > > > On Tue, Nov 21, 2023 at 09:30:49PM +0100, Peter Zijlstra wrote:  
> > > > > On Tue, Nov 21, 2023 at 11:25:18AM -0800, Paul E. McKenney wrote:    
> > > > > > #define preempt_enable() \
> > > > > > do { \
> > > > > > 	barrier(); \
> > > > > > 	if (!IS_ENABLED(CONFIG_PREEMPT_RCU) && raw_cpu_read(rcu_data.rcu_urgent_qs) && \
> > > > > > 	    (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK | HARDIRQ_MASK | NMI_MASK) == PREEMPT_OFFSET) &&
> > > > > > 	    !irqs_disabled()) \  
> > > 
> > > Could we make the above an else case of the below if ?  
> > 
> > Wouldn't that cause the above preempt_count() test to always fail?
> 
> preempt_count_dec_and_test() returns true if preempt_count() is zero, which
> happens only if NEED_RESCHED is set, and the rest of preempt_count() is not
> set. (NEED_RESCHED bit in preempt_count() is really the inverse of
> NEED_RESCHED). Do we need to call rcu_all_qs() when we call the scheduler?
> Isn't scheduling a quiescent state for most RCU flavors?
> 
> I thought this was to help move along the quiescent states without added
> cond_resched() around, which has:
> 
> int __sched __cond_resched(void)
> {
> 	if (should_resched(0)) {
> 		preempt_schedule_common();
> 		return 1;
> 	}
> 	/*
> 	 * In preemptible kernels, ->rcu_read_lock_nesting tells the tick
> 	 * whether the current CPU is in an RCU read-side critical section,
> 	 * so the tick can report quiescent states even for CPUs looping
> 	 * in kernel context.  In contrast, in non-preemptible kernels,
> 	 * RCU readers leave no in-memory hints, which means that CPU-bound
> 	 * processes executing in kernel context might never report an
> 	 * RCU quiescent state.  Therefore, the following code causes
> 	 * cond_resched() to report a quiescent state, but only when RCU
> 	 * is in urgent need of one.
> 	 */
> #ifndef CONFIG_PREEMPT_RCU
> 	rcu_all_qs();
> #endif
> 	return 0;
> }
> 
> Where if we schedule, we don't call rcu_all_qs().

True enough, but in this __cond_resched() case we know that we are in
an RCU quiescent state regardless of what should_resched() says.

In contrast, with preempt_enable(), we are only in a quiescent state
if __preempt_count_dec_and_test() returns true, and even then only if
interrupts are enabled.

> I stand by that being in the else statement. It looks like that would keep
> the previous work flow.

Ah, because PREEMPT_NEED_RESCHED is zero when we need to reschedule,
so that when __preempt_count_dec_and_test() returns false, we might
still be in an RCU quiescent state in the case where there was no need
to reschedule.  Good point!

In which case...

#define preempt_enable() \
do { \
	barrier(); \
	if (unlikely(preempt_count_dec_and_test())) \
		__preempt_schedule(); \
	else if (!sched_feat(FORCE_PREEMPT) && \
		 (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK | HARDIRQ_MASK | NMI_MASK) == PREEMPT_OFFSET) && \
		 !irqs_disabled()) \
) \
			rcu_all_qs(); \
} while (0)

Keeping rcu_all_qs() pretty much as is.  Or some or all of the "else if"
condition could be pushed down into rcu_all_qs(), depending on whether
Peter's objection was call-site object code size, execution path length,
or both.  ;-)

If the objection is both call-site object code size and execution path
length, then maybe all but the preempt_count() check should be pushed
into rcu_all_qs().

Was that what you had in mind, or am I missing your point?

							Thanx, Paul
