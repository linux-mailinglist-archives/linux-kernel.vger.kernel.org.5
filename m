Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781CB7D722D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjJYRRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjJYRRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:17:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B35F111
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:17:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E835FC433C7;
        Wed, 25 Oct 2023 17:17:33 +0000 (UTC)
Date:   Wed, 25 Oct 2023 13:17:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
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
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: Re: [POC][RFC][PATCH] sched: Extended Scheduler Time Slice
Message-ID: <20231025131731.48461873@gandalf.local.home>
In-Reply-To: <20231025162435.ibhdktcshhzltr3r@f>
References: <20231025054219.1acaa3dd@gandalf.local.home>
        <20231025102952.GG37471@noisy.programming.kicks-ass.net>
        <20231025085434.35d5f9e0@gandalf.local.home>
        <20231025135545.GG31201@noisy.programming.kicks-ass.net>
        <20231025103105.5ec64b89@gandalf.local.home>
        <884e4603-4d29-41ae-8715-a070c43482c4@efficios.com>
        <20231025162435.ibhdktcshhzltr3r@f>
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

On Wed, 25 Oct 2023 18:24:35 +0200
Mateusz Guzik <mjguzik@gmail.com> wrote:

> On Wed, Oct 25, 2023 at 11:42:34AM -0400, Mathieu Desnoyers wrote:
> > On 2023-10-25 10:31, Steven Rostedt wrote:  
> > > On Wed, 25 Oct 2023 15:55:45 +0200
> > > Peter Zijlstra <peterz@infradead.org> wrote:  
> > 
> > [...]
> > 
> > After digging lore for context, here are some thoughts about the actual
> > proposal: AFAIU the intent here is to boost the scheduling slice for a
> > userspace thread running with a mutex held so it can complete faster,
> > and therefore reduce contention.
> > 
> > I suspect this is not completely unrelated to priority inheritance
> > futexes, except that one goal stated by Steven is to increase the
> > owner slice without requiring to call a system call on the fast-path.

No, I wouldn't say it's the same as priority inheritance, which is to help
with determinism and not performance. PI adds overhead but removes
unbounded latency. On average, a non PI mutex is faster than PI mutex, but
can suffer from unbounded priority inversion.

For this code, I took off my RT hat, and put on my performance hat.

> > 
> > Compared to PI futexes, I think Steven's proposal misses the part
> > where a thread waiting on a futex boosts the lock owner's priority
> > so it can complete faster. By making the lock owner selfishly claim
> > that it needs a larger scheduling slice, it opens the door to
> > scheduler disruption, and it's hard to come up with upper-bounds
> > that work for all cases.

Currently, the extended time is only 1ms for 1000 HZ kernel. It's no
different than holding a kernel spin lock for that much time. It doesn't
happen often, but I have in the past measured spin locks being held for
that long in a non PREEMPT_RT kernel.

And with the new EEVDF, extended time slices will be handled by the
eligibility algorithm, by keeping the task that extended itself from being
eligible for a longer period of time. This keeps things "fair".

> > 
> > Hopefully I'm not oversimplifying if I state that we have mainly two
> > actors to consider:
> > 
> > [A] the lock owner thread
> > 
> > [B] threads that block trying to acquire the lock
> > 
> > The fast-path here is [A]. [B] can go through a system call, I don't
> > think it matters at all.

No, B going into a system call can be just as devastating. Adaptive
spinning helps with that. The thing here is that if A gets preempted, there
will be a lot more B's getting stuck.

I implemented the test with futexes (where you go to sleep on contention)
and the performance dropped considerably, where the benefits of not having
A get preempted made no difference at all. Sure, adaptive spinning helps in
that case, but adaptive spinning would only make it as good as my spinning
in user space logic is without any changes.

> > 
> > So perhaps we can extend the rseq per-thread area with a field that
> > implements a "held locks" list that allows [A] to let the kernel know
> > that it is currently holding a set of locks (those can be chained when
> > locks are nested). It would be updated on lock/unlock with just a few
> > stores in userspace.

And I can see that being a total nightmare to maintain and keep from races
and trusting user space.

> > 
> > Those lock addresses could then be used as keys for private locks,
> > or transformed into inode/offset keys for shared-memory locks. Threads
> > [B] blocking trying to acquire the lock can call a system call which
> > would boost the lock owner's slice and/or priority for a given lock key.

Do you mean that this would be done in user space? Going into the kernel to
do any of this would make it already lost.

> > 
> > When the scheduler preempts [A], it would check whether the rseq
> > per-thread area has a "held locks" field set and use this information
> > to find the slice/priority boost which are currently active for each
> > lock, and use this information to boost the task slice/priority
> > accordingly.

Why do we care about locks here? Note, I'm looking at using this same
feature for VMs on interrupt handlers. The only thing user space needs to
tell the kernel is "It's not a good time to preempt me, but it will be
shortly".

> > 
> > A scheme like this should allow lock priority inheritance without
> > requiring system calls on the userspace lock/unlock fast path.

Priority inheritance doesn't make sense when everything is running.

> >   
> 
> I think both this proposal and the original in this thread are opening a
> can of worms and I don't think going down that road was properly
> justified. A proper justification would demonstrate a big enough(tm)
> improvement over a locking primitive with adaptive spinning.
> 
> It is well known that what mostly shafts performance of regular
> userspace locking is all the nasty going off cpu to wait.
> 
> The original benchmark with slice extension disabled keeps using CPUs,
> virtually guaranteeing these threads will keep getting preempted, some
> of the time while holding the lock. Should that happen all other threads
> which happened to get preempted actively waste time.
> 
> Adaptive spinning was already mentioned elsewhere in the thread and the
> idea itself is at least 2 decades old. If anything I find it strange it
> did not land years ago.

I tried pushing it a long time ago but I believe Peter didn't like the
logic touching the scheduler. Which it had to do, so I dropped it.

Anyway, as I stated previously, my experience here is based on the work I
had done with PREEMPT_RT. Let me give you a little history:

A long time ago, when an 8 CPU machine was considered "huge!", we got
priority inheritance spin-lock turn mutexes working nicely. But because rw
locks were exponentially complex to add PI to (believe me, I tried!), we
gave up and just turned them into a single mutex. This caused huge
contention on the mmap_sem (which was now a mutex and not a rwsem)
especially when running java (which for some unknown reasons creates
hundreds of threads for "Hello world!").

When we booted a machine with 16 or more CPUs, it took forever to boot up
on PREEMPT_RT. The lock contention between all these spin-lock turn mutexes
and rwsems turn mutexes was crazy. PREEMPT_RT took exponentially longer to
boot than the vanilla kernel as the number of CPUs went up.

SUSE proposed a new feature called "adaptive spinning", where on contention
to one of these spin-locks turned mutexes, it would spin if the owner of
the lock was held, and otherwise go to sleep. This was a huge win, as we
found that the contention on these locks dropped significantly. So much so,
that the difference between PREEMPT_RT and vanilla only linearly degraded
as the number of CPUs increased.

The PREEMPT_RT folks continued happily along. But the performance of
PREEMPT_RT was still significantly behind that of the vanilla kernel.
Thomas realized that a large part of this performance gap was due to the
over aggressive preemption that PREEMPT_RT would cause. What PREEMPT_RT
does, is simply allow for more places in the kernel to be preempted where
CONFIG_PREEMPT does not. Specifically, while holding a spin_lock. That
means, when you preempted a kernel when holding a spin_lock, that spin_lock
was much more likely to be contended upon for the simple fact that it is
now held for a much longer time. Thomas realized that introducing
NEED_RECHED_LAZY, and by allowing SCHED_OTHER scheduling to be delayed
while these spin locks are held it would decrease the number of times
preemption happened while these locks are taken. This would decrease the
time that the locks are held and that would decrease the number of times
they were contended.

IMPORTANT NOTE: The above was noticed *with* adaptive spin locks enabled!

That is, adaptive spinning did not solve the issue with tasks holding locks
being preempted.

This is why I'm saying that user space adaptive spin locks solves a
*different* problem. This patch solves the preemption of lock holders
problem, which adaptive spinning DOES NOT ADDRESS.

> 
> I find there is a preliminary patch by you which exports the state so
> one can nicely spin without even going to the kernel:
> https://lore.kernel.org/lkml/20230529191416.53955-1-mathieu.desnoyers@efficios.com/
> 
> To be clear, I think a locking primitive which can do adaptive spinning
> *and* futexes *and* not get preempted while holding locks is the fastest
> option. What is not clear to me if it is sufficiently faster than
> adaptive spinning and futexes.

And I'm stating it is, simply because it worked so well with PREEMPT_RT.

> 
> tl;dr perhaps someone(tm) could carry the above to a state where it can
> be benchmarked vs the original patch

And don't get me wrong. I *want* adaptive spinning in user space. I'm just
saying that this is solving a different issue.

-- Steve
