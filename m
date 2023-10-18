Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6020B7CE4CB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjJRRlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjJRRlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:41:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8617AB0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:41:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0DEC433C8;
        Wed, 18 Oct 2023 17:41:09 +0000 (UTC)
Date:   Wed, 18 Oct 2023 13:41:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <20231018134107.1941dcf5@gandalf.local.home>
In-Reply-To: <61bb51f7-99ed-45bf-8c3e-f1d65137c894@paulmck-laptop>
References: <87ttrngmq0.ffs@tglx>
        <87jzshhexi.ffs@tglx>
        <a375674b-de27-4965-a4bf-e0679229e28e@paulmck-laptop>
        <87pm1c3wbn.ffs@tglx>
        <61bb51f7-99ed-45bf-8c3e-f1d65137c894@paulmck-laptop>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023 10:19:53 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> Isn't rcu_read_lock() defined as preempt_disable() and rcu_read_unlock()
> as preempt_enable() in this approach?  I certainly hope so, as RCU
> priority boosting would be a most unwelcome addition to many datacenter
> workloads.
> 
> > With this approach the kernel is by definition fully preemptible, which
> > means means rcu_read_lock() is preemptible too. That's pretty much the
> > same situation as with PREEMPT_DYNAMIC.  
> 
> Please, just no!!!

Note, when I first read Thomas's proposal, I figured that Paul would no
longer get to brag that:

 "In CONFIG_PREEMPT_NONE, rcu_read_lock() and rcu_read_unlock() are simply
 nops!"

But instead, they would be:

static void rcu_read_lock(void)
{
	preempt_disable();
}

static void rcu_read_unlock(void)
{
	preempt_enable();
}

as it was mentioned that today's preempt_disable() is fast and not an issue
like it was in older kernels.

That would mean that there will still be a "non preempt" version of RCU.

As the preempt version of RCU adds a lot more logic when scheduling out in
an RCU critical section, that I can envision not all workloads would want
around. Adding "preempt_disable()" is now low overhead, but adding the RCU
logic to handle preemption isn't as lightweight as that.

Not to mention the logic to boost those threads that were preempted and
being starved for some time.



> > > 6.	You might think that RCU Tasks (as opposed to RCU Tasks Trace
> > > 	or RCU Tasks Rude) would need those pesky cond_resched() calls
> > > 	to stick around.  The reason is that RCU Tasks readers are ended
> > > 	only by voluntary context switches.  This means that although a
> > > 	preemptible infinite loop in the kernel won't inconvenience a
> > > 	real-time task (nor an non-real-time task for all that long),
> > > 	and won't delay grace periods for the other flavors of RCU,
> > > 	it would indefinitely delay an RCU Tasks grace period.
> > >
> > > 	However, RCU Tasks grace periods seem to be finite in preemptible
> > > 	kernels today, so they should remain finite in limited-preemptible
> > > 	kernels tomorrow.  Famous last words...  
> > 
> > That's an issue which you have today with preempt FULL, right? So if it
> > turns out to be a problem then it's not a problem of the new model.  
> 
> Agreed, and hence my last three lines of text above.  Plus the guy who
> requested RCU Tasks said that it was OK for its grace periods to take
> a long time, and I am holding Steven Rostedt to that.  ;-)

Matters what your definition of "long time" is ;-)

-- Steve
