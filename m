Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34E17D6F46
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344910AbjJYObS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234893AbjJYObQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:31:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832E5A3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:31:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D6FC433C7;
        Wed, 25 Oct 2023 14:31:08 +0000 (UTC)
Date:   Wed, 25 Oct 2023 10:31:05 -0400
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
Message-ID: <20231025103105.5ec64b89@gandalf.local.home>
In-Reply-To: <20231025135545.GG31201@noisy.programming.kicks-ass.net>
References: <20231025054219.1acaa3dd@gandalf.local.home>
        <20231025102952.GG37471@noisy.programming.kicks-ass.net>
        <20231025085434.35d5f9e0@gandalf.local.home>
        <20231025135545.GG31201@noisy.programming.kicks-ass.net>
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

On Wed, 25 Oct 2023 15:55:45 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Oct 25, 2023 at 08:54:34AM -0400, Steven Rostedt wrote:
> 
> > I didn't want to overload that for something completely different. This is
> > not a "restartable sequence".  
> 
> Your hack is arguably worse. At least rseq already exists and most
> threads will already have it set up if you have a recent enough glibc.

I don't expect that file to be the final solution. I can look at the rseq
code, but I really hate to overload that. I'm thinking perhaps another
system call, or what the hell, add another ioctl like feature to prctl()!
Actually, prctl() may be the proper place for this.

> 
> > > So what if it doesn't ? Can we kill it for not playing nice ?  
> > 
> > No, it's no different than a system call running for a long time. You could  
> 
> Then why ask for it? What's the point. Also, did you define
> sched_yield() semantics for OTHER to something useful? Because if you
> didn't you just invoked UB :-) We could be setting your pets on fire.

Actually, it works with *any* system call. Not just sched_yield(). I just
used that as it was the best one to annotate "the kernel asked me to
schedule, I'm going to schedule". If you noticed, I did not modify
sched_yield() in the patch. The NEED_RESCHED_LAZY is still set, and without
the extend bit set, on return back to user space it will schedule.

> 
> > set this bit and leave it there for as long as you want, and it should not
> > affect anything.  
> 
> It would affect the worst case interference terms of the system at the
> very least.

If you are worried about that, it can easily be configurable to be turned
off. Seriously, I highly doubt that this would be even measurable as
interference. I could be wrong, I haven't tested that. It's something we
can look at, but until it's considered a problem it should not be a show
blocker.

> 
> > If you look at what Thomas's PREEMPT_AUTO.patch  
> 
> I know what it does, it also means your thing doesn't work the moment
> you set things up to have the old full-preempt semantics back. It
> doesn't work in the presence of RT/DL tasks, etc..

Note, I am looking at ways to make this work with full preempt semantics.
This is still a POC, there's a lot of room for improvements here. From my
understanding, the potential of Thomas's patch is to get rid of the
build time configurable semantics of NONE, VOLUNTARY and PREEMPT (only
PREEMPT_RT will be different).

> 
> More importantly, it doesn't work for RT/DL tasks, so having the bit set
> and not having OTHER policy is an error.

It would basically be a nop.

> 
> Do you want an interface that randomly doesn't work ?

An RT task doesn't get preempted by ticks, so how would in randomly not
work? We could allow RR tasks to get a bit more time if it has this bit set
too. Or maybe allow DL to get a little more if there's not another DL task
needing to run.

But for now, this is only for SCHED_OTHER, as this is not usually a problem
for RT/DL tasks. The extend bit is only a hint for the kernel, there's no
guarantees that it will be available or even if the kernel will honor it.
But because there's a lot of code out there that implements user space spin
locks, this could be a huge win for them when implemented, without changing
much.

Remember, RT and DL are about deterministic behavior, SCHED_OTHER is about
performance. This is a performance patch, not a deterministic one.

> 
> > We could possibly make it adjustable.   
> 
> Tunables are not a good thing.
> 
> > The reason I've been told over the last few decades of why people implement
> > 100% user space spin locks is because the overhead of going int the kernel
> > is way too high.  
> 
> Over the last few decades that has been a blatant falsehood. At some
> point (right before the whole meltdown trainwreck) amluto had syscall
> overhead down to less than 150 cycles.

Well, as far as I know, the testing that Postgresql has done has never seen
that.

> 
> Then of course meltdown happened and it all went to shit.

True dat.

> 
> But even today (on good hardware or with mitigations=off):
> 
> gettid-1m:	179,650,423      cycles
> xadd-1m:	 23,036,564      cycles
> 
> syscall is the cost of roughly 8 atomic ops. More expensive, sure. But
> not insanely so. I've seen atomic ops go up to >1000 cycles if you
> contend them hard enough.
> 

This has been your argument for over a decade, and the real world has seen
it differently. Performance matters significantly for user applications, and
if system calls didn't have performance issues, I'm sure the performance
centric applications would have used them.

This is because these critical sections run much less than 8 atomic ops. And
when you are executing these critical sections millions of times a second,
that adds up quickly.

-- Steve

