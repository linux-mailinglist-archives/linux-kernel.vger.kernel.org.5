Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D537D741D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjJYTUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYTUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:20:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E8713A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 12:19:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6ACDC433C7;
        Wed, 25 Oct 2023 19:19:55 +0000 (UTC)
Date:   Wed, 25 Oct 2023 15:19:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
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
Message-ID: <20231025151951.5f1a9ab1@gandalf.local.home>
In-Reply-To: <0d95385f-1be1-4dcf-93cb-8c5df3bc9d0c@efficios.com>
References: <20231025054219.1acaa3dd@gandalf.local.home>
        <20231025102952.GG37471@noisy.programming.kicks-ass.net>
        <20231025085434.35d5f9e0@gandalf.local.home>
        <20231025135545.GG31201@noisy.programming.kicks-ass.net>
        <20231025103105.5ec64b89@gandalf.local.home>
        <884e4603-4d29-41ae-8715-a070c43482c4@efficios.com>
        <20231025162435.ibhdktcshhzltr3r@f>
        <20231025131731.48461873@gandalf.local.home>
        <0d95385f-1be1-4dcf-93cb-8c5df3bc9d0c@efficios.com>
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

On Wed, 25 Oct 2023 14:49:44 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > 
> > No, I wouldn't say it's the same as priority inheritance, which is to help
> > with determinism and not performance. PI adds overhead but removes
> > unbounded latency. On average, a non PI mutex is faster than PI mutex, but
> > can suffer from unbounded priority inversion.  
> 
> AFAIU, this is because PI mutex as implemented by sys futex only boosts the
> priority of the lock owner. In my proposal here the owner would be able to
> borrow scheduler slices from the waiters as well.

I would be worried that that could cause even more scheduling disruption.
Now we are taking time slices from other CPUs to run the current one?

> 
> [...]
> 
> >>>
> >>> Hopefully I'm not oversimplifying if I state that we have mainly two
> >>> actors to consider:
> >>>
> >>> [A] the lock owner thread
> >>>
> >>> [B] threads that block trying to acquire the lock
> >>>
> >>> The fast-path here is [A]. [B] can go through a system call, I don't
> >>> think it matters at all.  
> > 
> > No, B going into a system call can be just as devastating. Adaptive
> > spinning helps with that. The thing here is that if A gets preempted, there
> > will be a lot more B's getting stuck.  
> 
> I would indeed combine this with an adaptive spinning scheme to allow waiters to
> stay in userspace if contention is short. As you know, rseq can also help there:
> 
> https://lore.kernel.org/lkml/20230529191416.53955-1-mathieu.desnoyers@efficios.com/
> 
> Therefore, it's only the blocking case that would call into the kernel, which
> should not be so devastating.

I think we are in agreement about the blocking case, which I believe you
mean "go to sleep and wait to be woken up when the resource is available".

> 
> > 
> > I implemented the test with futexes (where you go to sleep on contention)
> > and the performance dropped considerably, where the benefits of not having
> > A get preempted made no difference at all. Sure, adaptive spinning helps in
> > that case, but adaptive spinning would only make it as good as my spinning
> > in user space logic is without any changes.  
> 
> I'm not sure what you are arguing here.
> 
> My overall idea would be to combine:
> 
> 1) Adaptive spinning in userspace,
> 2) Priority inheritance,
> 3) Scheduler slices inheritance.

The PI and slice inheritance can become very complex. It does sound more
like the proxy server, which in theory sounds great but is very difficult
to implement in practice.

> 
> >   
> >>>
> >>> Those lock addresses could then be used as keys for private locks,
> >>> or transformed into inode/offset keys for shared-memory locks. Threads
> >>> [B] blocking trying to acquire the lock can call a system call which
> >>> would boost the lock owner's slice and/or priority for a given lock key.  
> > 
> > Do you mean that this would be done in user space? Going into the kernel to
> > do any of this would make it already lost.  
> 
> Going to the kernel only happens when threads need to block, which means
> that the typical contended half-happy path should be busy-spinning in userspace
> (adaptive spinning).
> 
> I see why blocking in a scenario where busy-spinning would be better is
> inefficient, but I don't see how going to the kernel for the _blocking_
> case is bad.

My point of view in this patch is for very short duration critical
sections. This patch is not for the blocking use case at all. For that, I'm
100% on board with adaptive spinning.

IOW, "blocking" is out of scope for this patch.

> 
> >   
> >>>
> >>> When the scheduler preempts [A], it would check whether the rseq
> >>> per-thread area has a "held locks" field set and use this information
> >>> to find the slice/priority boost which are currently active for each
> >>> lock, and use this information to boost the task slice/priority
> >>> accordingly.  
> > 
> > Why do we care about locks here? Note, I'm looking at using this same
> > feature for VMs on interrupt handlers. The only thing user space needs to
> > tell the kernel is "It's not a good time to preempt me, but it will be
> > shortly".
> >   
> 
> Quoting https://lore.kernel.org/lkml/20231024103426.4074d319@gandalf.local.home/
> 
> "The goal is to prevent a thread / vCPU being preempted while holding a lock
> or resource that other threads / vCPUs will want. That is, prevent
> contention, as that's usually the biggest issue with performance in user
> space and VMs."

I should have been more specific. Yes, locks is a major use case here, and
the one I brought up as it's the easiest to understand, but this can be for
any use case that there's a short critical section were preemption could be
bad. I don't want to implement a policy that this is only for locking.

> 
> We care about locks here because this is in fact your own problem statement.
> If you want to consider the different problem of making VM interrupt handlers
> go fast, then you should state it up front. Those two distinct problems may
> or may not require entirely different solutions.

We'll soon know as we'll be testing that too. Anyway, this patch is for the
"short critical section". It's not good for all locking. It's only good for
very short held locks.

Going back to PREEMPT_RT, I did tests where I implemented NEED_RESCHED_LAZY
on all kernel mutexes (it's currently only used for PREEMPT_RT spin locks
that turn into mutexes), and found that it made no difference. Maybe a
little bit, but not enough to push it. The reason is that long held locks,
are either not contended heavily, or if they are, the fact that they are
long held, keeping them running isn't as big of a difference than if they
stop to let something else run. Of course, RT has priority inheritance, so
the PI isn't as much of a overhead compared to the time the locks were held.

> 
> >>>
> >>> A scheme like this should allow lock priority inheritance without
> >>> requiring system calls on the userspace lock/unlock fast path.  
> > 
> > Priority inheritance doesn't make sense when everything is running.  
> 
> I should have also said that this scheme should allow the lock owner to
> borrow scheduler time slices from waiters (in addition to PI).

As I mentioned, that sounds like proxy execution, which is something that's
been a work in progress for some time now.

Anyway, this patch is a very simple solution that can help a large number
of use cases. Even if those use cases are very specific (highly contended
short duration critical sections).

-- Steve

