Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E9C7E5B13
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjKHQWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjKHQWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:22:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F17CC6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 08:22:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2548FC433C8;
        Wed,  8 Nov 2023 16:22:24 +0000 (UTC)
Date:   Wed, 8 Nov 2023 11:22:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
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
        krypton@ulrich-teichert.org, David.Laight@aculab.com,
        richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 00/86] Make the kernel preemptible
Message-ID: <20231108112227.62f0c5a8@gandalf.local.home>
In-Reply-To: <877cmsgsrg.ffs@tglx>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
        <20231108085156.GD8262@noisy.programming.kicks-ass.net>
        <87bkc4lfxp.fsf@oracle.com>
        <20231108101330.GK3818@noisy.programming.kicks-ass.net>
        <877cmsgsrg.ffs@tglx>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Nov 2023 16:38:11 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Wed, Nov 08 2023 at 11:13, Peter Zijlstra wrote:
> > On Wed, Nov 08, 2023 at 02:04:02AM -0800, Ankur Arora wrote:
> > I'm not understanding, those should stay obviously.
> >
> > The current preempt_dynamic stuff has 5 toggles:
> >
> > /*
> >  * SC:cond_resched
> >  * SC:might_resched
> >  * SC:preempt_schedule
> >  * SC:preempt_schedule_notrace
> >  * SC:irqentry_exit_cond_resched
> >  *
> >  *
> >  * NONE:
> >  *   cond_resched               <- __cond_resched
> >  *   might_resched              <- RET0
> >  *   preempt_schedule           <- NOP
> >  *   preempt_schedule_notrace   <- NOP
> >  *   irqentry_exit_cond_resched <- NOP
> >  *
> >  * VOLUNTARY:
> >  *   cond_resched               <- __cond_resched
> >  *   might_resched              <- __cond_resched
> >  *   preempt_schedule           <- NOP
> >  *   preempt_schedule_notrace   <- NOP
> >  *   irqentry_exit_cond_resched <- NOP
> >  *
> >  * FULL:
> >  *   cond_resched               <- RET0
> >  *   might_resched              <- RET0
> >  *   preempt_schedule           <- preempt_schedule
> >  *   preempt_schedule_notrace   <- preempt_schedule_notrace
> >  *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
> >  */
> >
> > If you kill voluntary as we know it today, you can remove cond_resched
> > and might_resched, but the remaining 3 are still needed to switch
> > between NONE and FULL.  
> 
> No. The whole point of LAZY is to keep preempt_schedule(),
> preempt_schedule_notrace(), irqentry_exit_cond_resched() always enabled.

Right.

 * NONE:
 *   cond_resched               <- __cond_resched
 *   might_resched              <- RET0
 *   preempt_schedule           <- NOP
 *   preempt_schedule_notrace   <- NOP
 *   irqentry_exit_cond_resched <- NOP

Peter, how can you say we can get rid of cond_resched() in NONE when you
show that NONE still uses it? I thought the entire point of this was to get
rid of all the cond_resched() and they are there for PREEMPT_NONE as well as
VOLUNTARY. As you showed above, the only difference between NONE and
VOLUNTARY was the might_sleep.

> 
> Look at my PoC: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/

And I've been saying that many times already ;-)

Thanks Thomas for reiterating it.

-- Steve
