Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116297D9E31
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344674AbjJ0Qtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjJ0Qtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:49:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EC01A5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 09:49:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA1BC433C8;
        Fri, 27 Oct 2023 16:49:33 +0000 (UTC)
Date:   Fri, 27 Oct 2023 12:49:30 -0400
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
Message-ID: <20231027124930.3753cdd4@gandalf.local.home>
In-Reply-To: <f0741a5b-229a-429a-8451-8af17261be9e@efficios.com>
References: <20231025235413.597287e1@gandalf.local.home>
        <20231026105944.GJ33965@noisy.programming.kicks-ass.net>
        <20231026071413.4ed47b0e@gandalf.local.home>
        <f5b0fffa-423a-4571-be6c-383399274328@efficios.com>
        <CAHk-=whnyt2TccpDaWGTbDsVkKApL3c2FtDPMEwuTmeu_cEL8Q@mail.gmail.com>
        <7871472b-a0c4-4475-9671-69a3244f956d@efficios.com>
        <20231026164549.14d45c60@gandalf.local.home>
        <644da047-2f7a-4d55-a339-f2dc28d2c852@efficios.com>
        <20231027122442.5c76dd62@gandalf.local.home>
        <f0741a5b-229a-429a-8451-8af17261be9e@efficios.com>
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

On Fri, 27 Oct 2023 12:35:56 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > Does that make more sense?  
> 
> Not really.
> 
> Please see my other email about the need for a reference count here, for
> nested locks use-cases.

Note, my original implementation of nested locking was done completely in
user space.

int __thread lock_cnt;

extend() {
	if (lock_cnt++)
		return;
	...
}

unextend() {
	if (--lock_cnt)
		return;
	...
}

> 
> By "atomic" operation I suspect you only mean "single instruction" which can
> alter the state of the field and keep its prior content in a register, not a
> lock-prefixed atomic operation, right ?

Correct. Just a per cpu atomic. Hence a "andb" instruction, or the "subl",
or whatever.

> 
> The only reason why you have this asm trickiness is because both states
> are placed into different bits from the same word, which is just an
> optimization. You could achieve the same much more simply by splitting
> this state in two different words, e.g.:
> 
> extend() {
>    WRITE_ONCE(__rseq_abi->cr_nest, __rseq_abi->cr_nest + 1);
>    barrier()
> }
> 
> unextend() {
>    barrier()
>    WRITE_ONCE(__rseq_abi->cr_nest, __rseq_abi->cr_nest - 1);
>    if (READ_ONCE(__rseq_abi->must_yield)) {
>      WRITE_ONCE(__rseq_abi->must_yield, 0);
>      sched_yield();
>    }
> }
> 
> Or am I missing something ?

I mentioned about placing this in different bytes, although I meant words,
but yeah, if we make them separate it would make it easier. But me being
frugal about memory, If this was just two bits (or even a counter with an
extra bit) I didn't think about wasting two words for what can be done with
one. 

But this is still an implementation detail, and this code is still very
much in flux, and I'm not as worried about those details yet.

-- Steve
