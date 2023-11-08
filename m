Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC187E5A41
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbjKHPiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234739AbjKHPiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:38:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222CD1FE1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 07:38:13 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699457891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=18UXkYkGm08AQHZBxS21cLjRT0YoIXe2siFB63ueLa0=;
        b=bCHL0UzoqJ4k+ydiCqDSGPqPJk1wUNFPASj3NywFEUtwqv3YAgQgmza2shT9fwGWz4dSLf
        Z47yBjsBmo4xTShOD953CfYU6WeU9iYOa32v04j4K7e71oWQxN4bZ5ops6ySLFi0PboAqF
        7+oBln+ji5AXRmrwT7LXevHuY42IMgcOgLtb6uE8yQ8NwA5EBpqkSc8yZajxkATB069U05
        FC6m3hTwoyC3wyFG8hWCOl12LOC+x6gXW/KP17XQZfdlrPimDTrUQBzWlc2w1RygMPXGdW
        06kgKW5NgVkFArzzednxNhbmALGRJvCRv79LVSG28eofYlglCyoIDzN/BqaGAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699457891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=18UXkYkGm08AQHZBxS21cLjRT0YoIXe2siFB63ueLa0=;
        b=IiM8I42Oi9ibnNKbFzDNnHjXg2zB7ZBR8wakKl39Y2K3ylt3Glo4UPGTNrWoNgYvRHdAJK
        9woTxhafpSOZwGCA==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 00/86] Make the kernel preemptible
In-Reply-To: <20231108101330.GK3818@noisy.programming.kicks-ass.net>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231108085156.GD8262@noisy.programming.kicks-ass.net>
 <87bkc4lfxp.fsf@oracle.com>
 <20231108101330.GK3818@noisy.programming.kicks-ass.net>
Date:   Wed, 08 Nov 2023 16:38:11 +0100
Message-ID: <877cmsgsrg.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08 2023 at 11:13, Peter Zijlstra wrote:
> On Wed, Nov 08, 2023 at 02:04:02AM -0800, Ankur Arora wrote:
> I'm not understanding, those should stay obviously.
>
> The current preempt_dynamic stuff has 5 toggles:
>
> /*
>  * SC:cond_resched
>  * SC:might_resched
>  * SC:preempt_schedule
>  * SC:preempt_schedule_notrace
>  * SC:irqentry_exit_cond_resched
>  *
>  *
>  * NONE:
>  *   cond_resched               <- __cond_resched
>  *   might_resched              <- RET0
>  *   preempt_schedule           <- NOP
>  *   preempt_schedule_notrace   <- NOP
>  *   irqentry_exit_cond_resched <- NOP
>  *
>  * VOLUNTARY:
>  *   cond_resched               <- __cond_resched
>  *   might_resched              <- __cond_resched
>  *   preempt_schedule           <- NOP
>  *   preempt_schedule_notrace   <- NOP
>  *   irqentry_exit_cond_resched <- NOP
>  *
>  * FULL:
>  *   cond_resched               <- RET0
>  *   might_resched              <- RET0
>  *   preempt_schedule           <- preempt_schedule
>  *   preempt_schedule_notrace   <- preempt_schedule_notrace
>  *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
>  */
>
> If you kill voluntary as we know it today, you can remove cond_resched
> and might_resched, but the remaining 3 are still needed to switch
> between NONE and FULL.

No. The whole point of LAZY is to keep preempt_schedule(),
preempt_schedule_notrace(), irqentry_exit_cond_resched() always enabled.

Look at my PoC: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/

The idea is to always enable preempt count and keep _all_ preemption
points enabled.

For NONE/VOLUNTARY mode let the scheduler set TIF_NEED_RESCHED_LAZY
instead of TIF_NEED_RESCHED. In full mode set TIF_NEED_RESCHED.

Here is where the regular and the lazy flags are evaluated:

                Ret2user        Ret2kernel      PreemptCnt=0  need_resched()

NEED_RESCHED       Y                Y               Y         Y
LAZY_RESCHED       Y                N               N         Y

The trick is that LAZY is not folded into preempt_count so a 1->0
counter transition won't cause preempt_schedule() to be invoked because
the topmost bit (NEED_RESCHED) is set.

The scheduler can still decide to set TIF_NEED_RESCHED which will cause
an immediate preemption at the next preemption point.

This allows to force out a task which loops, e.g. in a massive copy or
clear operation, as it did not reach a point where TIF_NEED_RESCHED_LAZY
is evaluated after a time which is defined by the scheduler itself.

For my PoC I did:

    1) Set TIF_NEED_RESCHED_LAZY

    2) Set TIF_NEED_RESCHED when the task did not react on
       TIF_NEED_RESCHED_LAZY within a tick

I know that's crude but it just works and obviously requires quite some
refinement.

So the way how you switch between preemption modes is to select when the
scheduler sets TIF_NEED_RESCHED/TIF_NEED_RESCHED_LAZY. No static call
switching at all.

In full preemption mode it sets always TIF_NEED_RESCHED and otherwise it
uses the LAZY bit first, grants some time and then gets out the hammer
and sets TIF_NEED_RESCHED when the task did not reach a LAZY preemption
point.

Which means once the whole thing is in place then the whole
PREEMPT_DYNAMIC along with NONE, VOLUNTARY, FULL can go away along with
the cond_resched() hackery.

So I think this series is backwards.

It should add the LAZY muck with a Kconfig switch like I did in my PoC
_first_. Once that is working and agreed on, the existing muck can be
removed.

Thanks,

        tglx
