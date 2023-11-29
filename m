Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55E27FDD25
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjK2QfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjK2QfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:35:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 704DCD7F;
        Wed, 29 Nov 2023 08:35:08 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DED0C15;
        Wed, 29 Nov 2023 08:35:55 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.31.168])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16EB33F73F;
        Wed, 29 Nov 2023 08:35:06 -0800 (PST)
Date:   Wed, 29 Nov 2023 16:35:01 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Ashley, William" <wash@amazon.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        will@kernel.org
Subject: Re: armv8pmu: Pending overflow interrupt is discarded when perf
 event is disabled
Message-ID: <ZWdoNWps4izj5WJy@FVFF77S0Q05N.cambridge.arm.com>
References: <950001BD-490C-4BAC-8EEA-CDB9F7C4ADFC@amazon.com>
 <EBAF38AB-2BE5-425F-8A52-DDCB0B390309@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EBAF38AB-2BE5-425F-8A52-DDCB0B390309@amazon.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

On Mon, Nov 20, 2023 at 10:32:10PM +0000, Ashley, William wrote:
> Adding linux-arm-kernel@lists.infradead.org and linux-kernel@vger.kernel.org,
> sorry for the noise.

Thanks for this!

For the benefit of others, the original mail (and attachment) can be found at:

  https://lore.kernel.org/linux-perf-users/950001BD-490C-4BAC-8EEA-CDB9F7C4ADFC@amazon.com/

For some reason, links and whitespace seem to have been mangled in the resend;
I'm not sure what happened there.

I've added Will Deacon, as Will and I co-maintain the ARM PMU drivers.

> ﻿On 11/20/23, 12:36 PM, "Ashley, William" <wash@amazon.com <mailto:wash@amazon.com>> wrote:
> 
> 
> An issue [1] was opened in the rr-debugger project reporting occasional missed
> perf event overflow signals on arm64. I've been digging into this and think I
> understand what's happening, but wanted to confirm my understanding.
> 
> The attached example application, derived from an rr-debugger test case, reports
> when the value of a counter doesn't increase by the expected period +/- some
> tolerance. When it is ping-ponged between cores (e.g. with taskset) at a high
> frequency, it frequently reports increases of ~2x the expected. I've confirmed
> this same behavior on kernels 5.4, 5.10, 6.1 and 6.5.
> 
> 
> I found armv8pmu_disable_intens [2] that is called as part of event
> de-scheduling and contains
> /* Clear the overflow flag in case an interrupt is pending. */
> write_pmovsclr(mask);
> which results in any pending overflow interrupt being dropped. I added some
> debug output here and indeed there is a correlation of this bit being high at
> the point of the above code and the reproducer identifying a missed signal.

I think you're right that if we had an overflow asserted at this point, we'll
throw away the occurrence of the overflow (and so not call
perf_event_overflow() and generate a sample, etc).

It looks like we only lose the occurrence of the overflow; the actual counts
will get sampled correctly and when we next reprogram the event,
armpmu_event_set_period() should set up the next overflow period.

> This behavior does not occur with pseudo-NMIs (irqchip.gicv3_pseudo_nmi=1)
> enabled.

That's interesting, because it implies that the PMU overflow interrupt is being
recognised by the CPU while regular interrupts are disabled. There are some
narrow races where that could occur (e.g. taking a timer or scheduler IRQ
*just* as an overflow occurs), and some other cases I'd expect RR to avoid by
construction (e.g. if RR isn't using mode exclusion and also counts kernel
events). It's also worth noting that this means there are races even with
pseudo-NMI where overflows could be lost.

How often do you see the overflow being lost?

Does RR set any of the perf_event_attr::exclude_* bits? If not, does RR
intentionally count events that occur within the kernel?

> When an event is not being explicitly torn down (e.g. being closed), this seems
> like an undesirable behavior.

I agree it's undesirable, though my understanding is that for most other users
this isn't any worse than losing samples for other reasons (e.g. the perf ring
buffer being full), and for the general case of sample-based profiling, losing
a sample every so often isn't the end of the world.

> I haven't attempted to demo it yet, but I suspect
> an application disabling an event temporarily could occasionally see the same
> missed overflow signals. Is my understanding here correct?

That sounds right to me, though I haven't checked that end-to-end yet.

> Does anyone have thoughts on how this could be addressed without creating
> other issues?

We should be able to detect overflow from the counter value alone, so we might
be able to account for that when we actually read the event out, or when we
schedule it back in and reprogram the period.

I'm not sure if we can reasonably do that when scheduling the event out, since
if we're switching tasks, that'll queue up IRQ work which will be triggered in
the context of the next task.

We might be able to figure out that we have an overflow when we schedule the
event in under armpmu_start(), but I'll need to go digging to see if there are
any free-running counters as the comment above the call to
armpmu_event_set_period() says, or whether that's a historical artifact.

I suspect we might need to restructure the code somewhat to be able to catch
overflows more consistently. I'll see if I can come up with something, but we
might not be able to guarantee this in all cases.

Mark.

> [1] https://github.com/rr-debugger/rr/issues/3607 <https://github.com/rr-debugger/rr/issues/3607>
> [2] https://github.com/torvalds/linux/blob/c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c/drivers/perf/arm_pmuv3.c#L652C20-L652C43 <https://github.com/torvalds/linux/blob/c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c/drivers/perf/arm_pmuv3.c#L652C20-L652C43>
