Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73705807368
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442414AbjLFPKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442456AbjLFPKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:10:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82E2D53
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 07:10:21 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701875419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DlA3J6KeiLPwS0f/3dubTvabmwmYjyMo2XWsrB4w408=;
        b=nzFjv87JXZiNZNWNyj4RR/ie5cSZDXusw/aYYqYLsm/ikFiNJPWDmUnQQJnaxQ2uDJaS1A
        2A5CqhGtwWTb0BOyCrG0yRmikNVa5Usbqz+EJktFDnFrJYgnCTQFh1aV5wf0wRNkHllni5
        5RZ9pn9BKOyo5LpH6p5yFNGyE7h7docpauB4MBc9mRJZ6xxuoKK1qe3kRtVcvOLXdVA25+
        4l3m7wUW1RknCQH/GL5R9p+sLpdMaFI2WmL2ycBHpDenpdumnC5v3U2nO0qhhgjtpueFsm
        0dbwJZ2Gmcn7/pOLp9N4KRjIQKrSIS3qzDQ97GHPDdKIjde0o4uX8RZYI1B5Kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701875419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DlA3J6KeiLPwS0f/3dubTvabmwmYjyMo2XWsrB4w408=;
        b=s0GXFYFibOv7iKdtRRl6+1zP6sqdWCve1nXTradVU1o7nofS9PlGTCqL14MjhLUGqzJnnJ
        bR2fhq4jnrYTlNCg==
To:     paulmck@kernel.org
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, linux-mm@kvack.org, x86@kernel.org,
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
Subject: Re: [RFC PATCH 48/86] rcu: handle quiescent states for PREEMPT_RCU=n
In-Reply-To: <209f0e89-7ebd-4759-9883-21d842d0d26c@paulmck-laptop>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-49-ankur.a.arora@oracle.com>
 <2027da00-273d-41cf-b9e7-460776181083@paulmck-laptop>
 <87v89lzu5a.ffs@tglx>
 <209f0e89-7ebd-4759-9883-21d842d0d26c@paulmck-laptop>
Date:   Wed, 06 Dec 2023 16:10:18 +0100
Message-ID: <875y1bwen9.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul!

On Mon, Dec 04 2023 at 17:33, Paul E. McKenney wrote:
> On Tue, Nov 28, 2023 at 06:04:33PM +0100, Thomas Gleixner wrote:
>> So:
>> 
>>     loop()
>> 
>>       preempt_disable();
>> 
>>       --> tick interrupt
>>             rcu_flavor_sched_clock_irq()
>>                 sets NEED_RESCHED
>> 
>>       preempt_enable()
>>         preempt_schedule()
>>           schedule()
>>             report_QS()
>> 
>> See? No magic nonsense in preempt_enable(), no cond_resched(), nothing.
>
> Understood, but that does delay detection of that quiescent state by up
> to one tick.

Sure, but does that really matter in practice?

>> So if that turns out to matter in reality and not just by academic
>> inspection, then we are far better off to annotate such code with:
>> 
>>     do {
>>         preempt_lazy_disable();
>>         mutex_lock();
>>         do_stuff();
>>         mutex_unlock();
>>         preempt_lazy_enable();
>>     }
>> 
>> and let preempt_lazy_enable() evaluate the NEED_RESCHED_LAZY bit.
>
> I am not exactly sure what semantics you are proposing with this pairing
> as opposed to "this would be a good time to preempt in response to the
> pending lazy request".  But I do agree that something like this could
> replace at least a few more instance of cond_resched(), so that is good.
> Not necessarily all of them, though.

The main semantic difference is that such a mechanism is properly
nesting and can be eventually subsumed into the actual locking
constructs.

>> Just insisting that RCU_PREEMPT=n requires cond_resched() and whatsoever
>> is not really getting us anywhere.
>
> Except that this is not what is happening, Thomas.  ;-)
>
> You are asserting that all of the cond_resched() calls can safely be
> eliminated.  That might well be, but more than assertion is required.
> You have come up with some good ways of getting rid of some classes of
> them, which is a very good and very welcome thing.  But that is not the
> same as having proved that all of them may be safely removed.

Neither have you proven that any of them will be required with the new
PREEMPT_LAZY model. :)

Your experience and knowledge in this area is certainly appreciated, but
under the changed semantics of LAZY it's debatable whether observations
and assumptions which are based on PREEMPT_NONE behaviour still apply.

We'll see.

Thanks,

        tglx
