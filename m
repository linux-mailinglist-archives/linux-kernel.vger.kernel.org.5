Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7FB7E690E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjKILAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjKILAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:00:52 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F7072702
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 03:00:49 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4B7512FC;
        Thu,  9 Nov 2023 03:01:33 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.37.150])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 544683F64C;
        Thu,  9 Nov 2023 03:00:44 -0800 (PST)
Date:   Thu, 9 Nov 2023 11:00:38 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
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
Message-ID: <ZUy71lC6mxP7ft-t@FVFF77S0Q05N>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <ZUu4Z8a8dPLfW7Ru@FVFF77S0Q05N>
 <87o7g3epcu.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7g3epcu.fsf@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 04:34:41PM -0800, Ankur Arora wrote:
> Mark Rutland <mark.rutland@arm.com> writes:
> 
> > On Tue, Nov 07, 2023 at 01:56:46PM -0800, Ankur Arora wrote:
> >> What's broken:
> >>  - ARCH_NO_PREEMPT (See patch-45 "preempt: ARCH_NO_PREEMPT only preempts
> >>    lazily")
> >>  - Non-x86 architectures. It's trivial to support other archs (only need
> >>    to add TIF_NEED_RESCHED_LAZY) but wanted to hold off until I got some
> >>    comments on the series.
> >>    (From some testing on arm64, didn't find any surprises.)
> >
> > When you say "testing on arm64, didn't find any surprises", I assume you mean
> > with an additional patch adding TIF_NEED_RESCHED_LAZY?
> 
> Yeah. And, handling that in the user exit path.
> 
> > Note that since arm64 doesn't use the generic entry code, that also requires
> > changes to arm64_preempt_schedule_irq() in arch/arm64/kernel/entry-common.c, to
> > handle TIF_NEED_RESCHED_LAZY.
> 
> So, the intent (which got muddied due to this overly large series)
> was to delay handling TIF_NEED_RESCHED_LAZY until we are about to
> return to user.

Ah, I missed that detail -- thanks for clarifying!

> I think arm64_preempt_schedule_irq() should only handle TIF_NEED_RESCHED
> and the _TIF_NEED_RESCHED_LAZY should be handled via _TIF_WORK_MASK
> and do_notify_resume().

Digging a bit more, I think that should still work.

One slight clarification: arm64_preempt_schedule_irq() doesn't look at
TIF_NEED_RESCHED today, as it relies on the scheduler IPI calling
preempt_fold_need_resched() to propogate TIF_NEED_RESCHED into
PREEMPT_NEED_RESCHED. That should still work since this series makes
preempt_fold_need_resched() check tif_need_resched(RESCHED_eager).

I was a bit cnofused because in the generic entry code,
irqentry_exit_cond_resched() explicitly checks for TIF_NEED_RESCHED, and I'm
not sure why it does that rather than relying on the scheduler IPI as above.

> (The design is much clearer in Thomas' PoC:
> https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/)
> 
> >>  - ftrace support for need-resched-lazy is incomplete
> >
> > What exactly do we need for ftrace here?
> 
> Only support for TIF_NEED_RESCHED_LAZY which should be complete.
> That comment was based on a misreading of the code.

Cool; thanks!

Mark.
