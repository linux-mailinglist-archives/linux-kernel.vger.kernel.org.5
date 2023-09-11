Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB9D79BD5C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359667AbjIKWST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243086AbjIKQtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:49:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4F510C2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:49:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAE8C433C8;
        Mon, 11 Sep 2023 16:48:42 +0000 (UTC)
Date:   Mon, 11 Sep 2023 12:48:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, tglx@linutronix.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <20230911124856.453fba22@gandalf.local.home>
In-Reply-To: <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
        <20230830184958.2333078-8-ankur.a.arora@oracle.com>
        <20230908070258.GA19320@noisy.programming.kicks-ass.net>
        <87zg1v3xxh.fsf@oracle.com>
        <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
        <87edj64rj1.fsf@oracle.com>
        <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
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

On Sat, 9 Sep 2023 21:35:54 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, 9 Sept 2023 at 20:49, Ankur Arora <ankur.a.arora@oracle.com> wrote:
> >
> > I think we can keep these checks, but with this fixed definition of
> > resched_allowed(). This might be better:
> >
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -2260,7 +2260,8 @@ static inline void disallow_resched(void)
> >
> >  static __always_inline bool resched_allowed(void)
> >  {
> > -       return unlikely(test_tsk_thread_flag(current, TIF_RESCHED_ALLOW));
> > +       return unlikely(!preempt_count() &&
> > +                        test_tsk_thread_flag(current, TIF_RESCHED_ALLOW));
> >  }  
> 
> I'm not convinced (at all) that the preempt count is the right thing.
> 
> It works for interrupts, yes, because interrupts will increment the
> preempt count even on non-preempt kernels (since the preempt count is
> also the interrupt context level).
> 
> But what about any synchronous trap handling?
> 
> In other words, just something like a page fault? A page fault doesn't
> increment the preemption count (and in fact many page faults _will_
> obviously re-schedule as part of waiting for IO).

I wonder if we should make it a rule to not allow page faults when
RESCHED_ALLOW is set? Yeah, we can preempt in page faults, but that's not
what the allow_resched() is about. Since the main purpose of that function,
according to the change log, is for kernel threads. Do kernel threads page
fault? (perhaps for vmalloc? but do we take locks in those cases?).

That is, treat allow_resched() like preempt_disable(). If we page fault
with "preempt_disable()" we usually complain about that (unless we do some
magic with *_nofault() functions).

Then we could just add checks in the page fault handlers to see if
allow_resched() is set, and if so, complain about it like we do with
preempt_disable in the might_fault() function.


-- Steve
