Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329477D6C6F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344230AbjJYMyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344192AbjJYMyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:54:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CECB111
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 05:54:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CB0C433C7;
        Wed, 25 Oct 2023 12:54:36 +0000 (UTC)
Date:   Wed, 25 Oct 2023 08:54:34 -0400
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
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: Re: [POC][RFC][PATCH] sched: Extended Scheduler Time Slice
Message-ID: <20231025085434.35d5f9e0@gandalf.local.home>
In-Reply-To: <20231025102952.GG37471@noisy.programming.kicks-ass.net>
References: <20231025054219.1acaa3dd@gandalf.local.home>
        <20231025102952.GG37471@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Peter!

[ After watching Thomas and Paul reply to each other, I figured this is the
  new LMKL greeting. ]


On Wed, 25 Oct 2023 12:29:52 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Oct 25, 2023 at 05:42:19AM -0400, Steven Rostedt wrote:
> 
> > That is, there's this structure for every thread. It's assigned with:
> > 
> > 	fd = open("/sys/kernel/extend_sched", O_RDWR);
> > 	extend_map = mmap(NULL, getpagesize(), PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> > 
> > I don't actually like this interface, as it wastes a full page for just two
> > bits :-p  Perhaps it should be a new system call, where it just locks in
> > existing memory from the user application? The requirement is that each
> > thread needs its own bits to play with. It should not be shared with other
> > threads. It could be, as it will not mess up the kernel, but will mess up
> > the application.  
> 
> What was wrong with using rseq?

I didn't want to overload that for something completely different. This is
not a "restartable sequence".

> 
> > Anyway, to tell the kernel to "extend" the time slice if possible because
> > it's in a critical section, we have:
> > 
> >  static void extend(void)
> >  {
> > 	if (!extend_map)
> > 		return;
> > 
> > 	extend_map->flags = 1;
> >  }
> > 
> > And to say that's it's done:
> > 
> >  static void unextend(void)
> >  {
> > 	unsigned long prev;
> > 
> > 	if (!extend_map)
> > 		return;
> > 
> > 	prev = xchg(&extend_map->flags, 0);
> > 	if (prev & 2)
> > 		sched_yield();
> >  }
> > 
> > So, bit 1 is for user space to tell the kernel "please extend me", and bit
> > two is for the kernel to tell user space "OK, I extended you, but call
> > sched_yield() when done".  
> 
> So what if it doesn't ? Can we kill it for not playing nice ?

No, it's no different than a system call running for a long time. You could
set this bit and leave it there for as long as you want, and it should not
affect anything. If you look at what Thomas's PREEMPT_AUTO.patch does, is
that it sets NEED_RESCHED_LAZY at the tick. Without my patch, this will not
schedule right away, but will schedule when going into user space. My patch
will ignore the schedule if NEED_RESCHED_LAZY is set when going into user
space.

With Thomas's patch, if a task is in the kernel for too long, on the next
tick (if I read his code correctly), if NEED_RESCHED_LAZY is still set,
it will then force the schedule. That is, you get two ticks instead of one.
I may have misread the code, but that's what it looks like it does in
update_deadline() in fair.c.

 https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/PREEMPT_AUTO.patch?h=v6.6-rc6-rt10-patches#n587

With my patch, the same thing happens but in user space. This does not give
any more power to any task. I don't expect nor want this to be a privilege
operation. It's no different than running a long system call. And EEVDF
should even keep it fair. As if you use an extra tick, it will go against
your eligibility for the next time around.

Note, NEED_RESCHED still schedules. If a RT or DL task were to wake up, it
will immediately preempt this task regardless of that bit being set.

> 
> [ aside from it being bit 0 and bit 1 as you yourself point out, it is
>   also jarring you use a numeral for one and write out the other. ]
> 
> That said, I properly hate all these things, extending a slice doesn't
> reliably work and we're always left with people demanding an ever longer
> extension.

We could possibly make it adjustable. I'm guessing that will happen anyway
with Thomas's patch. Anyway, my test shows that it makes a huge improvement
for user space implemented spin locks, which I tailored this after how
Postgresql does their spin locks. That is, this is a real world use case. I
plan to implement this in Postgresql and see what improvements it makes in
their tests.

I also plan on testing VMs.

> 
> The *much* better heuristic is what the kernel uses, don't spin if the
> lock holder isn't running.

No it is not. That is a completely useless heuristic for this use case.
That's for waiters and I would guess would make no difference in my test.
The point of this patch is to keep the lock holder running not the waiter
spinning. The reason for the improvement in my test is that the lock was
always held for a very short time and when the time slice came up while the
task was holding the lock, it was able to get it extended to release it, and
then schedule.

Without my patch, you get a several hundreds of this:

    extend-sched-3773  [000]  9628.573272: print:                tracing_mark_write: Have lock!
    extend-sched-3773  [000]  9628.573278: sched_switch:         extend-sched:3773 [120] R ==> mysqld:1216 [120]
          mysqld-1216  [000]  9628.573286: sched_switch:         mysqld:1216 [120] S ==> extend-sched:3773 [120]
    extend-sched-3773  [000]  9628.573287: print:                tracing_mark_write: released lock!

[ Ironically, this example is preempted by mysqld ]

With my patch, there was only a single instance during the run.

When a lock holder schedules out, it greatly increases contention on that
lock. That's the entire reason Thomas implemented NEED_RESCHED_LAZY in the
first place. The aggressive preemption in PREEMPT_RT caused a lot more
contention on spin lock turned mutexes. My patch is to do the exact same
thing for user space implement spin locks, which also includes spin locks
in VM kernels. Adaptive spin locks (spin on owner running) helped
PREEMPT_RT for waiters, but that did nothing to help the lock holder being
preempted, and why NEED_RESCHED_LAZY was still needed even when the kernel
already had adaptive spinners.

The reason I've been told over the last few decades of why people implement
100% user space spin locks is because the overhead of going int the kernel
is way too high. Sleeping is much worse (but that is where the adaptive
spinning comes in, which is a separate issue).

Allowing user space to say "hey, give me a few more microseconds and I'm
fine being preempted" is a very good heuristic. And a way for the kernel to
say, "hey, I gave it to you, you better go into the kernel when you can,
otherwise I'll preempt you no matter what!"

-- Steve
