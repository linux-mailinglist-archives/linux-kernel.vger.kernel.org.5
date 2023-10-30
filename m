Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4D87DBB2D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 14:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjJ3N5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 09:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjJ3NwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 09:52:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D04D3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 06:52:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342C3C433C8;
        Mon, 30 Oct 2023 13:52:05 +0000 (UTC)
Date:   Mon, 30 Oct 2023 09:52:03 -0400
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
Message-ID: <20231030095203.33325aee@gandalf.local.home>
In-Reply-To: <20231030132949.GA38123@noisy.programming.kicks-ass.net>
References: <20231025054219.1acaa3dd@gandalf.local.home>
        <20231025102952.GG37471@noisy.programming.kicks-ass.net>
        <20231025085434.35d5f9e0@gandalf.local.home>
        <20231025135545.GG31201@noisy.programming.kicks-ass.net>
        <20231025103105.5ec64b89@gandalf.local.home>
        <20231026084402.GK31411@noisy.programming.kicks-ass.net>
        <20231026091658.1dcf2106@gandalf.local.home>
        <20231030132949.GA38123@noisy.programming.kicks-ass.net>
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

On Mon, 30 Oct 2023 14:29:49 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Oct 26, 2023 at 09:16:58AM -0400, Steven Rostedt wrote:
> 
> > I said:
> > 
> >   If we are worried about abuse, we could even punish tasks that don't call
> >   sched_yield() by the time its extended time slice is taken.  
> 
> This is a user interface, ofcourse I'm worried about abuse. That's the
> first thing you *should* think about.
> 
> Userspace is out to get you -- must assume hostile.

100% agree!

> 
> Notably, we were talking usec latencies in the Chrome thread, you're
> adding 1000 usec latencies here (in the best case, delaying scheduling
> until the next tick, 10000usec for the HZ=100 folks). This is quite
> 'unfortunate'.
> 
> On my very aged IVB-EP I can get 50us scheduling latencies on a good
> day, on my brand spanking new SPR I can get 20us (more faster more
> better etc..).
> 
> Ideally we don't allow userspace to extend much (if any) beyond the
> granularity already imposed by the kernel's preempt/IRQ-disable regions.
> Sadly we don't have a self-measure of that around.
> 
> So I had a poke at all this and ended up with the below. I still utterly
> detest all this, but it appears to actually work -- although I don't
> much see the improvement, the numbers are somewhat unstable. (I say it
> works because I see the 'yield -- made it' trace_printk when I do it
> right and the 'timeout -- force resched' when I do it 'wrong'.
> 
> This thing works across the board and gives userspace 50usec, equal to
> what the kernel already imposes on (on the IVB).
> 
> I simply took a bit from the existing flags field, and userspace can use
> BTR to test if the kernel cleared it -- in which case it needs yield
> (and not any other syscall).
> 
> Additinally doing a syscall with the bit set will SIGSEGV (when
> DEBUG_RSEQ).
> 

Thanks for looking into this even though you detest it ;-)

Unfortunately, now that the merge window has opened (and someone reported a
bug in my code from linux-next :-( ), I need to take a step back from this
and may not be able to work on it again until plumbers. By then, I hope to
have time to dig deeper into what you have done here.

Thanks again Peter!

-- Steve
