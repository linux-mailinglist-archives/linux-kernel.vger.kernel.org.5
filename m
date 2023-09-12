Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7F779C9DC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjILI1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjILI06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:26:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F5310C4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Vgh2RnJs2w1PlGNDLTN7kPBghNxkaN0skqLPdimcsl4=; b=gnTg/fyJKCBGG4BoQ663gBIJr9
        TMjeHCGVPHMcuhtqIEMTRnDmlDJNDDT1kefi37451MyqDpGtv+mr99pJFZAxb4tpTWDLo1zXAz/RE
        jnFAlpcd8zNpjhSvu7bAAVT7tVB3ZyhYYkkbSO4H6Y3OfCTzx2p3+SbODMkZ722bsFucib2RvWxQ/
        gsYElfAIRSmLeKMX1WB0OaQOP5dwb1eMM2px8CJ3u+XsGXjy6eyUq6YQ6mY1BKbgB9/tt6o5rgHQX
        T9bwSKjRcnjB0X36RNIb7vQUzaCFG6AsnDJ7FmgNB6s0Se/jDW41uSNtUaZHzXBSUpFcQLK98WcgQ
        cH+ES4og==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qfyij-005xCV-0M;
        Tue, 12 Sep 2023 08:26:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 398A7300348; Tue, 12 Sep 2023 10:26:06 +0200 (CEST)
Date:   Tue, 12 Sep 2023 10:26:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        tglx@linutronix.de, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <20230912082606.GB35261@noisy.programming.kicks-ass.net>
References: <20230830184958.2333078-8-ankur.a.arora@oracle.com>
 <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <87zg1v3xxh.fsf@oracle.com>
 <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
 <87edj64rj1.fsf@oracle.com>
 <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <87zg1u1h5t.fsf@oracle.com>
 <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6o01w1a.fsf@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 10:04:17AM -0700, Ankur Arora wrote:
> 
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > On Sun, Sep 10, 2023 at 11:32:32AM -0700, Linus Torvalds wrote:
> >
> >> I was hoping that we'd have some generic way to deal with this where
> >> we could just say "this thing is reschedulable", and get rid of - or
> >> at least not increasingly add to - the cond_resched() mess.
> >
> > Isn't that called PREEMPT=y ? That tracks precisely all the constraints
> > required to know when/if we can preempt.
> >
> > The whole voluntary preempt model is basically the traditional
> > co-operative preemption model and that fully relies on manual yields.
> 
> Yeah, but as Linus says, this means a lot of code is just full of
> cond_resched(). For instance a loop the process_huge_page() uses
> this pattern:
> 
>    for (...) {
>        cond_resched();
>        clear_page(i);
> 
>        cond_resched();
>        clear_page(j);
>    }

Yeah, that's what co-operative preemption gets you.

> > The problem with the REP prefix (and Xen hypercalls) is that
> > they're long running instructions and it becomes fundamentally
> > impossible to put a cond_resched() in.
> >
> >> Yes. I'm starting to think that that the only sane solution is to
> >> limit cases that can do this a lot, and the "instruciton pointer
> >> region" approach would certainly work.
> >
> > From a code locality / I-cache POV, I think a sorted list of
> > (non overlapping) ranges might be best.
> 
> Yeah, agreed. There are a few problems with doing that though.
> 
> I was thinking of using a check of this kind to schedule out when
> it is executing in this "reschedulable" section:
>         !preempt_count() && in_resched_function(regs->rip);
> 
> For preemption=full, this should mostly work.
> For preemption=voluntary, though this'll only work with out-of-line
> locks, not if the lock is inlined.
> 
> (Both, should have problems with __this_cpu_* and the like, but
> maybe we can handwave that away with sparse/objtool etc.)

So one thing we can do is combine the TIF_ALLOW_RESCHED with the ranges
thing, and then only search the range when TIF flag is set.

And I'm thinking it might be a good idea to have objtool validate the
range only contains simple instructions, the moment it contains control
flow I'm thinking it's too complicated.

> How expensive would be always having PREEMPT_COUNT=y?

Effectively I think that is true today. At the very least Debian and
SuSE (I can't find a RHEL .config in a hurry but I would think they too)
ship with PREEMPT_DYNAMIC=y.

Mel, I'm sure you ran numbers at the time (you always do), what if any
was the measured overhead from PREEMPT_DYNAMIC vs 'regular' voluntary
preemption?
