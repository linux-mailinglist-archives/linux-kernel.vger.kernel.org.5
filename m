Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F547E5237
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 09:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbjKHIxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 03:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343628AbjKHIx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 03:53:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31D11717
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 00:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ew0pjkTaVlRlSlP9yHv6pHGhMc/rPDL4MInWiMJucXU=; b=ogS2QB56Sr7RRY2Q+ZZjJz4fYi
        wyQJfhGRqsA+LFwTVUe92NlR6V1fCOvnMoVNPyPEOhmhtwBH6a9qoMOi7TAB3j8ZV4Xupuu/iKbH7
        RUJPLlSGzMRWHX2d/kBHcstuORZwpB/moRxuf18/L9C6krlo+qzCnIFSgEh687eLEVc7HwIcOZBq9
        GpkIYEpk+Rd5vohQFm9FEVpuFZUBGKl/vCvYLBQH7qOUWu9wCFtz+maMwD2sQQhl4w9ylWnal6lgr
        BTlI1J9NDjIm2ymdUMadaAxGH4AvpeA4qO8/keANPhdOcHCVR3G6R5e3WRJSTqdkIL0ovEjbSH3v4
        2v6FAghQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r0eI0-0000cp-Az; Wed, 08 Nov 2023 08:51:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id AAF6130049D; Wed,  8 Nov 2023 09:51:56 +0100 (CET)
Date:   Wed, 8 Nov 2023 09:51:56 +0100
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
Message-ID: <20231108085156.GD8262@noisy.programming.kicks-ass.net>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 01:56:46PM -0800, Ankur Arora wrote:
> Hi,
> 
> We have two models of preemption: voluntary and full 

3, also none (RT is not actually a preemption model).

> (and RT which is
> a fuller form of full preemption.)

It is not in fact a different preemption model, it is the same full
preemption, the difference with RT is that it makes a lot more stuff
preemptible, but the fundamental preemption model is the same -- full.

> In this series -- which is based
> on Thomas' PoC (see [1]), we try to unify the two by letting the
> scheduler enforce policy for the voluntary preemption models as well.

Well, you've also taken out preempt_dynamic for some obscure reason :/


> Please review.

> Ankur Arora (86):
>   Revert "riscv: support PREEMPT_DYNAMIC with static keys"
>   Revert "sched/core: Make sched_dynamic_mutex static"
>   Revert "ftrace: Use preemption model accessors for trace header
>     printout"
>   Revert "preempt/dynamic: Introduce preemption model accessors"
>   Revert "kcsan: Use preemption model accessors"
>   Revert "entry: Fix compile error in
>     dynamic_irqentry_exit_cond_resched()"
>   Revert "livepatch,sched: Add livepatch task switching to
>     cond_resched()"
>   Revert "arm64: Support PREEMPT_DYNAMIC"
>   Revert "sched/preempt: Add PREEMPT_DYNAMIC using static keys"
>   Revert "sched/preempt: Decouple HAVE_PREEMPT_DYNAMIC from
>     GENERIC_ENTRY"
>   Revert "sched/preempt: Simplify irqentry_exit_cond_resched() callers"
>   Revert "sched/preempt: Refactor sched_dynamic_update()"
>   Revert "sched/preempt: Move PREEMPT_DYNAMIC logic later"
>   Revert "preempt/dynamic: Fix setup_preempt_mode() return value"
>   Revert "preempt: Restore preemption model selection configs"
>   Revert "sched: Provide Kconfig support for default dynamic preempt
>     mode"
>   sched/preempt: remove PREEMPT_DYNAMIC from the build version
>   Revert "preempt/dynamic: Fix typo in macro conditional statement"
>   Revert "sched,preempt: Move preempt_dynamic to debug.c"
>   Revert "static_call: Relax static_call_update() function argument
>     type"
>   Revert "sched/core: Use -EINVAL in sched_dynamic_mode()"
>   Revert "sched/core: Stop using magic values in sched_dynamic_mode()"
>   Revert "sched,x86: Allow !PREEMPT_DYNAMIC"
>   Revert "sched: Harden PREEMPT_DYNAMIC"
>   Revert "sched: Add /debug/sched_preempt"
>   Revert "preempt/dynamic: Support dynamic preempt with preempt= boot
>     option"
>   Revert "preempt/dynamic: Provide irqentry_exit_cond_resched() static
>     call"
>   Revert "preempt/dynamic: Provide preempt_schedule[_notrace]() static
>     calls"
>   Revert "preempt/dynamic: Provide cond_resched() and might_resched()
>     static calls"
>   Revert "preempt: Introduce CONFIG_PREEMPT_DYNAMIC"

NAK

Even if you were to remove PREEMPT_NONE, which should be a separate
series, but that isn't on the table at all afaict, removing
preempt_dynamic doesn't make sense.

You still want the preempt= boot time argument and the
/debug/sched/preempt things to dynamically switch between the models.

Please, focus on the voluntary thing, gut that and then replace it with
the lazy thing, but leave everything else in place.

Re dynamic preempt, gutting the current voluntary preemption model means
getting rid of the cond_resched and might_resched toggles but you'll
gain a switch to kill the lazy stuff.
