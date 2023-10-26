Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEEC7D8365
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345046AbjJZNRJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 26 Oct 2023 09:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjJZNRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:17:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44F4D54
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:17:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0ECC433C9;
        Thu, 26 Oct 2023 13:16:59 +0000 (UTC)
Date:   Thu, 26 Oct 2023 09:16:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Youssef Esmat <youssefesmat@chromium.org>,
        Vineeth Pillai <vineethrp@google.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [POC][RFC][PATCH] sched: Extended Scheduler Time Slice
Message-ID: <20231026091658.1dcf2106@gandalf.local.home>
In-Reply-To: <20231026084402.GK31411@noisy.programming.kicks-ass.net>
References: <20231025054219.1acaa3dd@gandalf.local.home>
        <20231025102952.GG37471@noisy.programming.kicks-ass.net>
        <20231025085434.35d5f9e0@gandalf.local.home>
        <20231025135545.GG31201@noisy.programming.kicks-ass.net>
        <20231025103105.5ec64b89@gandalf.local.home>
        <20231026084402.GK31411@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 10:44:02 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > Actually, it works with *any* system call. Not just sched_yield(). I just
> > used that as it was the best one to annotate "the kernel asked me to
> > schedule, I'm going to schedule". If you noticed, I did not modify
> > sched_yield() in the patch. The NEED_RESCHED_LAZY is still set, and without
> > the extend bit set, on return back to user space it will schedule.  
> 
> So I fundamentally *HATE* you tie this hole thing to the
> NEED_RESCHED_LAZY thing, that's 100% the wrong layer to be doing this
> at.
> 
> It very much means you're creating an interface that won't work for a
> significant number of setups -- those that use the FULL preempt setting.

And why can't the FULL preempt setting still use the NEED_RESCHED_LAZY?
PREEMPT_RT does. The beauty about NEED_RESCHED_LAZY is that it tells you
whether you *should* schedule, or you *must* schedule (NEED_RESCHED).

> 
> > > > set this bit and leave it there for as long as you want, and it should not
> > > > affect anything.    
> > > 
> > > It would affect the worst case interference terms of the system at the
> > > very least.  
> > 
> > If you are worried about that, it can easily be configurable to be turned
> > off. Seriously, I highly doubt that this would be even measurable as
> > interference. I could be wrong, I haven't tested that. It's something we
> > can look at, but until it's considered a problem it should not be a show
> > blocker.  
> 
> If everybody sets the thing and leaves it on, you basically double the
> worst case latency, no? And weren't you involved in a thread only last
> week where the complaint was that Chrome was a pig^W^W^W latency was too
> high?

In my first email about this:

  https://lore.kernel.org/all/20231024103426.4074d319@gandalf.local.home/

I said:

  If we are worried about abuse, we could even punish tasks that don't call
  sched_yield() by the time its extended time slice is taken.

To elaborate further on this punishment, if we find that it does become an
issue if a bunch of tasks were to always have this bit set and not giving
up the CPU in a timely manner, it could be flagged to ignore that bit
and/or remove some of its eligibility.

That is, it wouldn't take too long before the abuser gets whacked and is no
longer able to abuse.

But I figured we would look into that if EEVDF doesn't naturally take care
of it.

> 
> > > > If you look at what Thomas's PREEMPT_AUTO.patch    
> > > 
> > > I know what it does, it also means your thing doesn't work the moment
> > > you set things up to have the old full-preempt semantics back. It
> > > doesn't work in the presence of RT/DL tasks, etc..  
> > 
> > Note, I am looking at ways to make this work with full preempt semantics.  
> 
> By not relying on the PREEMPT_AUTO stuff. If you noodle with the code
> that actually sets preempt it should also work with preempt, but you're
> working at the wrong layer.

My guess is that NEED_RESCHED_LAZY will work with PREEMPT as well. That
code is still a work in progress, and this code is dependent on that. Right
now it depends on PREEMPT_AUTO because that's the only option that
currently gives us NEED_RESCHED_LAZY. From reading the discussions from
Thomas, it looks like NEED_RESCHED_LAZY will eventually be available in
CONFIG_PREEMPT.

> 
> Also see that old Oracle thread that got dug up.

I'll go back and read that.

> 
> > > More importantly, it doesn't work for RT/DL tasks, so having the bit set
> > > and not having OTHER policy is an error.  
> > 
> > It would basically be a nop.  
> 
> Well yes, but that is not a nice interface is it, run your task as RT/DL
> and suddenly it behaves differently.

User space spin locks would most definitely run differently in RT/DL today!

That could cause them to easily deadlock.

User space spin locks only make sense with SCHED_OTHER, otherwise great
care needs to be taken to not cause unbounded priority inversion.
Especially with FIFO.

> > This is because these critical sections run much less than 8 atomic ops. And
> > when you are executing these critical sections millions of times a second,
> > that adds up quickly.  
> 
> But you wouldn't be doing syscalls on every section either. If syscalls
> were free (0 cycles) and you could hand-wave any syscall you pleased,
> how would you do this?
> 
> The typical futex like setup is you only syscall on contention, when
> userspace is going to be spinning and wasting cycles anyhow. The current
> problem is that futex_wait will instantly schedule-out / block, even if
> the lock owner is currently one instruction away from releasing the lock.

And that is what user space adaptive spin locks are to solve, which I'm
100% all for! (I'm the one that talked André Almeida into working on this).

But as my tests show, the speed up is from keeping the lock holder from
being preempted. The same is true for why Thomas created NEED_RESCHED_LAZY
for PREEMPT_RT when it already had adaptive spin locks.

-- Steve

