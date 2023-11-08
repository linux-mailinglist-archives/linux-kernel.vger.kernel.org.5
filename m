Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85517E4FDC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 06:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbjKHFMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 00:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbjKHFMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 00:12:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5C1D7D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 21:12:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585D4C433C8;
        Wed,  8 Nov 2023 05:12:14 +0000 (UTC)
Date:   Wed, 8 Nov 2023 00:12:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Christoph Lameter <cl@linux.com>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
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
        krypton@ulrich-teichert.org, David.Laight@ACULAB.COM,
        richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 00/86] Make the kernel preemptible
Message-ID: <20231108001217.068d20da@gandalf.local.home>
In-Reply-To: <385909b5-3077-42d4-07ef-7ae915d24b5a@linux.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
        <549c1cba-5cad-7706-de85-d61376db25cc@linux.com>
        <87bkc4vp89.fsf@oracle.com>
        <385909b5-3077-42d4-07ef-7ae915d24b5a@linux.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2023 20:52:39 -0800 (PST)
Christoph Lameter <cl@linux.com> wrote:

> On Tue, 7 Nov 2023, Ankur Arora wrote:
> 
> > This came up in an earlier discussion (See
> > https://lore.kernel.org/lkml/87cyyfxd4k.ffs@tglx/) and Thomas mentioned
> > that preempt_enable/_disable() overhead was relatively minimal.
> >
> > Is your point that always-on preempt_count is far too expensive?  
> 
> Yes over the years distros have traditionally delivered their kernels by 
> default without preemption because of these issues. If the overhead has 
> been minimized then that may have changed. Even if so there is still a lot 
> of code being generated that has questionable benefit and just 
> bloats the kernel.
> 
> >> These are needed to avoid adding preempt_enable/disable to a lot of primitives
> >> that are used for synchronization. You cannot remove those without changing a
> >> lot of synchronization primitives to always have to consider being preempted
> >> while operating.  
> >
> > I'm afraid I don't understand why you would need to change any
> > synchronization primitives. The code that does preempt_enable/_disable()
> > is compiled out because CONFIG_PREEMPT_NONE/_VOLUNTARY don't define
> > CONFIG_PREEMPT_COUNT.  
> 
> In the trivial cases it is simple like that. But look f.e.
> in the slub allocator at the #ifdef CONFIG_PREEMPTION section. There is a 
> overhead added to be able to allow the cpu to change under us. There are 
> likely other examples in the source.
> 

preempt_disable() and preempt_enable() are much lower overhead today than
it use to be.

If you are worried about changing CPUs, there's also migrate_disable() too.

> And the whole business of local data 
> access via per cpu areas suffers if we cannot rely on two accesses in a 
> section being able to see consistent values.
> 
> > The intent here is to always have CONFIG_PREEMPT_COUNT=y.  
> 
> Just for fun? Code is most efficient if it does not have to consider too 
> many side conditions like suddenly running on a different processor. This 
> introduces needless complexity into the code. It would be better to remove 
> PREEMPT_COUNT for good to just rely on voluntary preemption. We could 
> probably reduce the complexity of the kernel source significantly.

That is what caused this thread in the first place. Randomly scattered
"preemption points" does not scale!

And I'm sorry, we have latency sensitive use cases that require full
preemption.

> 
> I have never noticed a need to preemption at every instruction in the 
> kernel (if that would be possible at all... Locks etc prevent that ideal 
> scenario frequently). Preemption like that is more like a pipe dream.
> 
> High performance kernel solution usually disable 
> overhead like that.
> 

Please read the email from Thomas:

   https://lore.kernel.org/lkml/87cyyfxd4k.ffs@tglx/

This is not technically getting rid of PREEMPT_NONE. It is adding a new
NEED_RESCHED_LAZY flag, that will have the kernel preempt only when
entering or in user space. It will behave the same as PREEMPT_NONE, but
without the need for all the cond_resched() scattered randomly throughout
the kernel.

If the task is in the kernel for more than one tick (1ms at 1000Hz, 4ms at
250Hz and 10ms at 100Hz), it will then set NEED_RESCHED, and you will
preempt at the next available location (preempt_count == 0).

But yes, all locations that do not explicitly disable preemption, will now
possibly preempt (due to long running kernel threads).

-- Steve
