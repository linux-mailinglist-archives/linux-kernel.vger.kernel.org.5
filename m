Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD3D7D7EBF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344604AbjJZIpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZIpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:45:46 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6614810E
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nz7VKBsdenxgTpTOdHB+C9mGiFHuzJaU++ZOYTWvdxQ=; b=ZYIbKNO53OgUvEkG/Us0fuh3Ds
        vYU6ICl6F8k46IdLhPdlYE5TpIcgAk8YUyDcccDDDw3g5Vgvi2lZdYK4yU/UFT22+K5oTApX2cCiB
        HJpVHfOolzEswLI9vOfCr2KsH3x7RvRvvWFYEdjlG85WdJPn0QzdK7tIP0I59uAm+XNKXMCfPZaX9
        9RYoqGuQhwKnwYDe27s3stjiEtEUxT8JJ3wDyVaejWRUeEgr/0mqMtri4FX8VtIpkNzZCQRzVEOuL
        HJnoLYEMfVIui8UFSLvgUMqbZarm9bAz63vpl/b+FSu6Dw4jWoDUwv+lU6dprjvJeQrJidHqrhdAL
        friE0vrQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qvvyE-00H9iA-1k;
        Thu, 26 Oct 2023 08:44:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 32081300473; Thu, 26 Oct 2023 10:44:02 +0200 (CEST)
Date:   Thu, 26 Oct 2023 10:44:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <20231026084402.GK31411@noisy.programming.kicks-ass.net>
References: <20231025054219.1acaa3dd@gandalf.local.home>
 <20231025102952.GG37471@noisy.programming.kicks-ass.net>
 <20231025085434.35d5f9e0@gandalf.local.home>
 <20231025135545.GG31201@noisy.programming.kicks-ass.net>
 <20231025103105.5ec64b89@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025103105.5ec64b89@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 10:31:05AM -0400, Steven Rostedt wrote:

> > > > So what if it doesn't ? Can we kill it for not playing nice ?  
> > > 
> > > No, it's no different than a system call running for a long time. You could  
> > 
> > Then why ask for it? What's the point. Also, did you define
> > sched_yield() semantics for OTHER to something useful? Because if you
> > didn't you just invoked UB :-) We could be setting your pets on fire.
> 
> Actually, it works with *any* system call. Not just sched_yield(). I just
> used that as it was the best one to annotate "the kernel asked me to
> schedule, I'm going to schedule". If you noticed, I did not modify
> sched_yield() in the patch. The NEED_RESCHED_LAZY is still set, and without
> the extend bit set, on return back to user space it will schedule.

So I fundamentally *HATE* you tie this hole thing to the
NEED_RESCHED_LAZY thing, that's 100% the wrong layer to be doing this
at.

It very much means you're creating an interface that won't work for a
significant number of setups -- those that use the FULL preempt setting.

> > > set this bit and leave it there for as long as you want, and it should not
> > > affect anything.  
> > 
> > It would affect the worst case interference terms of the system at the
> > very least.
> 
> If you are worried about that, it can easily be configurable to be turned
> off. Seriously, I highly doubt that this would be even measurable as
> interference. I could be wrong, I haven't tested that. It's something we
> can look at, but until it's considered a problem it should not be a show
> blocker.

If everybody sets the thing and leaves it on, you basically double the
worst case latency, no? And weren't you involved in a thread only last
week where the complaint was that Chrome was a pig^W^W^W latency was too
high?

> > > If you look at what Thomas's PREEMPT_AUTO.patch  
> > 
> > I know what it does, it also means your thing doesn't work the moment
> > you set things up to have the old full-preempt semantics back. It
> > doesn't work in the presence of RT/DL tasks, etc..
> 
> Note, I am looking at ways to make this work with full preempt semantics.

By not relying on the PREEMPT_AUTO stuff. If you noodle with the code
that actually sets preempt it should also work with preempt, but you're
working at the wrong layer.

Also see that old Oracle thread that got dug up.

> > More importantly, it doesn't work for RT/DL tasks, so having the bit set
> > and not having OTHER policy is an error.
> 
> It would basically be a nop.

Well yes, but that is not a nice interface is it, run your task as RT/DL
and suddenly it behaves differently.

> Remember, RT and DL are about deterministic behavior, SCHED_OTHER is about
> performance. This is a performance patch, not a deterministic one.

Yeah, but performance means something different depending on who and
when you talk to someone.

> > But even today (on good hardware or with mitigations=off):
> > 
> > gettid-1m:	179,650,423      cycles
> > xadd-1m:	 23,036,564      cycles
> > 
> > syscall is the cost of roughly 8 atomic ops. More expensive, sure. But
> > not insanely so. I've seen atomic ops go up to >1000 cycles if you
> > contend them hard enough.
> > 
> 
> This has been your argument for over a decade, and the real world has seen
> it differently. Performance matters significantly for user applications, and
> if system calls didn't have performance issues, I'm sure the performance
> centric applications would have used them.
> 
> This is because these critical sections run much less than 8 atomic ops. And
> when you are executing these critical sections millions of times a second,
> that adds up quickly.

But you wouldn't be doing syscalls on every section either. If syscalls
were free (0 cycles) and you could hand-wave any syscall you pleased,
how would you do this?

The typical futex like setup is you only syscall on contention, when
userspace is going to be spinning and wasting cycles anyhow. The current
problem is that futex_wait will instantly schedule-out / block, even if
the lock owner is currently one instruction away from releasing the lock.

