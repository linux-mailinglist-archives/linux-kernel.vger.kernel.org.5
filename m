Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31FB7E5320
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343889AbjKHKOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKHKOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:14:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5A01725
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 02:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2h5F5cEqywAQejXftRJY11d82vM8zMGKqSMTRf5CE1g=; b=UFiQLvmS4+Gx8p6q0/VylFwpkR
        gAZnD7BP2yOefLqEVD/mEF0J6cpnr/kK5A6SDPZyNJshyNEEMmwywe78YxjlFSlXFEXZUkQ/FTexc
        Qj163Z4gt8LbS3U4q6FZF7GDfMqT+EG18J7RAI0nUgsHgnPbbWvXQ/Xi+bO2HmF7S9S1eRrWCGzTA
        WnEsqJopdy1UuNwVEBd+5u+LoyrjDGJt8zXt3Cnky9HRB9K85QaP94yPU+uHsNO6xlVBMj97ccmaN
        X56maLqZf8UjyyOb24fS0is8nfuK0Cc84W7nzbdw9QvRQNRUh7489ghUynDeQeRStOmjYO+rRYz2Q
        MAEdip3w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r0fYw-000OYq-OK; Wed, 08 Nov 2023 10:13:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A45F30049D; Wed,  8 Nov 2023 11:13:31 +0100 (CET)
Date:   Wed, 8 Nov 2023 11:13:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 00/86] Make the kernel preemptible
Message-ID: <20231108101330.GK3818@noisy.programming.kicks-ass.net>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231108085156.GD8262@noisy.programming.kicks-ass.net>
 <87bkc4lfxp.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkc4lfxp.fsf@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 02:04:02AM -0800, Ankur Arora wrote:

> >>   Revert "riscv: support PREEMPT_DYNAMIC with static keys"
> >>   Revert "livepatch,sched: Add livepatch task switching to
> >>     cond_resched()"
> >>   Revert "arm64: Support PREEMPT_DYNAMIC"
> >>   Revert "sched/preempt: Add PREEMPT_DYNAMIC using static keys"
> 
> What's the best way to handle these? With the lazy bit, cond_resched()
> and might_resched() are gone. So we don't need all of the static
> key inftrastructure for toggling etc.
> 
> The part of preempt_dynamic that makes sense to me is the one that
> switches dynamically between none/voluntary/full. Here it would need
> to be wired onto controls of the lazy bit.
> (Right now the preemption policy is controlled by sched_feat in
> patches 43, and 44 but sched/preempt is a much better interface.)

I'm not understanding, those should stay obviously.

The current preempt_dynamic stuff has 5 toggles:

/*
 * SC:cond_resched
 * SC:might_resched
 * SC:preempt_schedule
 * SC:preempt_schedule_notrace
 * SC:irqentry_exit_cond_resched
 *
 *
 * NONE:
 *   cond_resched               <- __cond_resched
 *   might_resched              <- RET0
 *   preempt_schedule           <- NOP
 *   preempt_schedule_notrace   <- NOP
 *   irqentry_exit_cond_resched <- NOP
 *
 * VOLUNTARY:
 *   cond_resched               <- __cond_resched
 *   might_resched              <- __cond_resched
 *   preempt_schedule           <- NOP
 *   preempt_schedule_notrace   <- NOP
 *   irqentry_exit_cond_resched <- NOP
 *
 * FULL:
 *   cond_resched               <- RET0
 *   might_resched              <- RET0
 *   preempt_schedule           <- preempt_schedule
 *   preempt_schedule_notrace   <- preempt_schedule_notrace
 *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
 */

If you kill voluntary as we know it today, you can remove cond_resched
and might_resched, but the remaining 3 are still needed to switch
between NONE and FULL.

Additionally, you'll get one new state to enable/disable the LAZY stuff.
Neither NONE nor FULL want the LAZY thing on.

You'll then end up with something like:

/*
 * SK:preempt_lazy
 * SC:preempt_schedule
 * SC:preempt_schedule_notrace
 * SC:irqentry_exit_cond_resched
 *
 *
 * NONE:
 *   preempt_lazy		<- OFF
 *   preempt_schedule           <- NOP
 *   preempt_schedule_notrace   <- NOP
 *   irqentry_exit_cond_resched <- NOP
 *
 * VOLUNTARY:
 *   preempt_lazy		<- ON
 *   preempt_schedule           <- preempt_schedule
 *   preempt_schedule_notrace   <- preempt_schedule_notrace
 *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
 *
 * FULL:
 *   preempt_lazy		<- OFF
 *   preempt_schedule           <- preempt_schedule
 *   preempt_schedule_notrace   <- preempt_schedule_notrace
 *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
 */

For the architectures that do not have static_call but instead use
static_key for everything, the SC's are obviously static_key based
wrappers around the function calls -- like now.
