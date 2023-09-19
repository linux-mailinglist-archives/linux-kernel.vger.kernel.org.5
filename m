Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931517A659C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 15:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjISNof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 09:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbjISNoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:44:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDE11738
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 06:43:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695131008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F6HJIRD4PyaX4+pUjqGdadn05E3sV+30VO4ObkBi4tA=;
        b=INe3beAVUGy7X1rPg0jVCOBApZrBIols9AlzAGXgMjPV257Vi8uogUm7f+1Kqn1dxss5w3
        Qd0i8v4W/KraIOm+0T08nhMyYiNAOuSdipyvpsH3wNCmEDgs6EpI6kzYy1p6edIzt5fRsM
        P3qq2iMbd4rnkAcfTNo2E4Mimdyz7ezivL28bRK930bJKJgeepHh1qRS0BwzW2gGyPjpzO
        FsKZToH8pgbrfbDvRRO4VZRnQlJziFXI2AOfdGkEzVhRgYrR7LTr5h7nXciBgTG+k58Etx
        Ndd3xkgzvmITTLqDMaD3fS+b1tdLInm1s1/Jc1ttwJ+JYsXw7NcqZLonBfCbWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695131008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F6HJIRD4PyaX4+pUjqGdadn05E3sV+30VO4ObkBi4tA=;
        b=tqREo84zIB2g7/8J6CTjDIfHTI+ZuUEpff2uM/m8NQcbyKurWmVLCLHVVCMc9TsZfuSA/a
        /Stk4hnv9k0JS6Bw==
To:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
In-Reply-To: <ZQlfHAXFFPZBPFgD@gmail.com>
References: <87edj64rj1.fsf@oracle.com>
 <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <87zg1u1h5t.fsf@oracle.com>
 <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <ZQlV5l4pbKunQJug@gmail.com> <ZQlfHAXFFPZBPFgD@gmail.com>
Date:   Tue, 19 Sep 2023 15:43:27 +0200
Message-ID: <87fs3awa68.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19 2023 at 10:43, Ingo Molnar wrote:
> * Ingo Molnar <mingo@kernel.org> wrote:
> Ie. a modern scheduler might have mooted much of this change:
>
>    4542057e18ca ("mm: avoid 'might_sleep()' in get_mmap_lock_carefully()")
>
> ... because now we'll only reschedule on timeslice exhaustion, or if a task 
> comes in with a big deadline deficit.
>
> And even the deadline-deficit wakeup preemption can be turned off further 
> with:
>
>     $ echo NO_WAKEUP_PREEMPTION > /debug/sched/features
>
> And we are considering making that the default behavior for same-prio tasks 
> - basically turn same-prio SCHED_OTHER tasks into SCHED_BATCH - which 
> should be quite similar to what NEED_RESCHED_LAZY achieves on -rt.

I don't think that you can get rid of NEED_RESCHED_LAZY for !RT because
there is a clear advantage of having the return to user preemption
point.

It spares to have the kernel/user transition just to get the task back
via the timeslice interrupt. I experimented with that on RT and the
result was definitely worse.

We surely can revisit that, but I'd really start with the straight
forward mappable LAZY bit approach and if experimentation turns out to
provide good enough results by not setting that bit at all, then we
still can do so without changing anything except the core scheduler
decision logic.

It's again a cheap thing due to the way how the return to user TIF
handling works:

	ti_work = read_thread_flags();
	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
		ti_work = exit_to_user_mode_loop(regs, ti_work);

TIF_LAZY_RESCHED is part of EXIT_TO_USER_MODE_WORK, so the non-work case
does not become more expensive than today. If any of the bits is set,
then the slowpath wont get measurably different performance whether the bit
is evaluated or not in exit_to_user_mode_loop().

As we really want TIF_LAZY_RESCHED for RT, we just keep all of this
consistent in terms of code and purely a scheduler decision whether it
utilizes it or not. As a consequence PREEMPT_RT is not longer special in
that regard and the main RT difference becomes the lock substitution and
forced interrupt threading.

For the magic 'spare me the extra conditional' optimization of
exit_to_user_mode_loop() if LAZY can be optimized out for !RT because
the scheduler is sooo clever (which I doubt), we can just use the same
approach as for other TIF bits and define them to 0 :)

So lets start consistent and optimize on top if really required.

Thanks,

        tglx
