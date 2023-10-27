Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02587D9DF6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjJ0QZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjJ0QYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:24:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0224E10A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 09:24:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A892C433C7;
        Fri, 27 Oct 2023 16:24:44 +0000 (UTC)
Date:   Fri, 27 Oct 2023 12:24:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ankur Arora <ankur.a.arora@oracle.com>, linux-mm@kvack.org,
        x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, juri.lelli@redhat.com,
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
Message-ID: <20231027122442.5c76dd62@gandalf.local.home>
In-Reply-To: <644da047-2f7a-4d55-a339-f2dc28d2c852@efficios.com>
References: <20231025235413.597287e1@gandalf.local.home>
        <20231026105944.GJ33965@noisy.programming.kicks-ass.net>
        <20231026071413.4ed47b0e@gandalf.local.home>
        <f5b0fffa-423a-4571-be6c-383399274328@efficios.com>
        <CAHk-=whnyt2TccpDaWGTbDsVkKApL3c2FtDPMEwuTmeu_cEL8Q@mail.gmail.com>
        <7871472b-a0c4-4475-9671-69a3244f956d@efficios.com>
        <20231026164549.14d45c60@gandalf.local.home>
        <644da047-2f7a-4d55-a339-f2dc28d2c852@efficios.com>
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

On Fri, 27 Oct 2023 12:09:56 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > I need to clear one bit while seeing if another bit is set. I could also
> > use subl, as that would also atomically clear the bit.  
> 
> Ah ok, I did not get that you needed to test for a different bit than 
> the one you clear.

Yeah, maybe I'm not articulating the implementation as well.

  bit 0: Set by user space to tell the kernel it's in a critical section

  bit 1: Set by kernel that it gave user space extend time slice

Bit 1 will only be set by the kernel if bit 0 is set.

When entering a critical section, user space will set bit 0. When it leaves
the critical section, it needs to clear bit 0, but also needs to handle the
race condition from where it clears the bit and where the kernel could
preempt it and set bit 1. Thus it needs an atomic operation to clear bit 0
without affecting bit 1. Once bit 0 is cleared, it does not need to worry
about bit 1 being set after that as the kernel will only set bit 1 if it
sees that bit 0 was set. After user space clears bit 0, it must check bit 1
to see if it should now schedule. And it's also up to user space to clear
bit 1, but it can do that at any time with bit 0 cleared.

 extend() {
	cr_flags = 1;
 }

 unextend() {
	cr_flags &= ~1;  /* Must be atomic */
	if (cr_flags & 2) {
		cr_flags = 0;  /* May not be necessary as it gets cleared by extend() */
		sched_yield();
	}
 }

Does that make more sense?

-- Steve
 
