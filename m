Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AA37D88DE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 21:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjJZTUd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 26 Oct 2023 15:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJZTUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 15:20:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679961A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:20:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91384C433C8;
        Thu, 26 Oct 2023 19:20:24 +0000 (UTC)
Date:   Thu, 26 Oct 2023 15:20:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [POC][RFC][PATCH v2] sched: Extended Scheduler Time Slice
Message-ID: <20231026152022.668ca0f3@gandalf.local.home>
In-Reply-To: <f5b0fffa-423a-4571-be6c-383399274328@efficios.com>
References: <20231025235413.597287e1@gandalf.local.home>
        <20231026105944.GJ33965@noisy.programming.kicks-ass.net>
        <20231026071413.4ed47b0e@gandalf.local.home>
        <f5b0fffa-423a-4571-be6c-383399274328@efficios.com>
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

On Thu, 26 Oct 2023 14:36:36 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > static inline unsigned long
> > xchg(volatile unsigned *ptr, unsigned new)
> > {
> >          unsigned ret = new;
> > 
> > 	asm volatile("xchg %b0,%1"  
> 
> which has an implicit lock prefix (xchg with a memory operand is a 
> special-case):
> 
> Quoting Intel manual:
> 
> "If a memory operand is referenced, the processor’s locking protocol is 
> automatically implemented for the duration of the exchange operation, 
> regardless of the presence or absence of the LOCK prefix or of the value 
> of the IOPL. (See the LOCK prefix description in this chapter for more 
> information on the locking protocol.)"
> 

Bah. I learn something new every day :-p

I thought xchg required specifying lock too. This means that cmpxchg is
actually faster than xchg! It's been a long time since I had written
assembly.

What makes this interesting though, is that when I ran my tests originally,
when my change was disabled, the xchg() code never executed, and it still
showed a significant improvement. That is, even with adding xchg(), it
still improved much more. But that's probably because the xchg() happens
after releasing the lock and after that it goes into a loop waiting for
another thread to make the update, which requires a lock cmpxchg(). Hence,
the xchg() slowdown wasn't in a critical path of the test.

Anyway, I changed the code to use:

static inline unsigned clrbit(volatile unsigned *ptr)
{
	unsigned ret;

	asm volatile("andb %b1,%0"
		     : "+m" (*(volatile char *)ptr)
		     : "iq" (0x2)
		     : "memory");

	ret = *ptr;
	*ptr = 0;

	return ret;
}

I just used andb as that's a locally atomic operation. I could also use bts
(as Mathieu suggested to me on IRC). It doesn't matter as this is just
example code and is not in production. How this is implemented is not an
important part of the algorithm. Just that it can atomically clear the bit
it sets without a race with the kernel setting the bit it sets. I could
modify the code to put these bits in separate bytes as well. That's just an
implementation detail we can work on later.

I updated my test to have:

static bool no_rseq;

static void init_extend_map(void)
{
	int ret;

	if (no_rseq)
		return;

	ret = rseq(&rseq_map, sizeof(rseq_map), 0, 0);
	perror("rseq");
	printf("ret = %d (%zd) %p\n", ret, sizeof(rseq_map), &rseq_map);
}

static inline unsigned clrbit(volatile unsigned *ptr)
{
	unsigned ret;

	asm volatile("andb %b1,%0"
		     : "+m" (*(volatile char *)ptr)
		     : "iq" (0x2)
		     : "memory");

	ret = *ptr;
	*ptr = 0;

	return ret;
}

static void extend(void)
{
	if (no_rseq)
		return;

	rseq_map.cr_flags = 1;
}

static void unextend(void)
{
	unsigned prev;

	if (no_rseq)
		return;

	prev = clrbit(&rseq_map.cr_flags);
	if (prev & 2) {
		tracefs_printf(NULL, "Yield!\n");
		sched_yield();
	}
}

where the tests with it disabled do not run the extend or unextend() code
(as it makes sense to only perform that code with this feature, as that
would be part of the overhead to implement it).

Here's the results:

With no_rseq = true, with 5 runs, which were basically all the same, but
the best run was:

Ran for 4260797 times
Total wait time: 33.905306

And with no_rseq = false;

Most runs were like:

Ran for 5378845 times
Total wait time: 32.253018

But the worse run was:

Ran for 4991411 times
Total wait time: 31.745662

But with that lower "wait time" it probably was preempted by a something
else during that run, as the lower the "wait time" the better the result.

-- Steve
