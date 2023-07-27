Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2B076570D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbjG0PKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbjG0PKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:10:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5E630EA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:10:38 -0700 (PDT)
Date:   Thu, 27 Jul 2023 17:10:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690470636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JmZUY5HL7mxzNObUMoolfY4LWdTMi99W9UaFt95hWy0=;
        b=pE+oxar15oNKB0QzXGcEcfcCK04CDhxmdAeQyEJP1CewY5ty+ViRtoMT6xbK7rmp1IoVvg
        RRSPLn/CXhWJb+kNiCQWV944mTvO7c5H28A/AJRUeB+Z4C/0yQ6dQd8MqdpDOIp09btLhc
        Ou6NF4uVBI6a+XiI8mGlAfN3hgAthyzETbHU79ZLWOgwRxJX+YTS3/YEfQjUTy4eRjWboq
        uqq1FDWTK2DMp8WXq1ploJbvv43mQFWiqdSVmwQZVr6Z8uQ96qvKfTR28tU6h7RVV/muPv
        8hg34Ojr2Rt+3/SfrQCgmR5MNUCtXTX3d8BjYG0hqnnS1LW+zM0bnfPnHlNfYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690470636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JmZUY5HL7mxzNObUMoolfY4LWdTMi99W9UaFt95hWy0=;
        b=4fLVNyMmc+WQaVm3LN6OQZfOh2EoLerlauWoEk9JsijohOijLEVpDQ/IXFTXihIZ/gyk5I
        Pii9C6TPD1GRZdDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/2] seqlock: Do the lockdep annotation before locking
 in do_write_seqcount_begin_nested()
Message-ID: <20230727151029.e_M9bi8N@linutronix.de>
References: <20230623171232.892937-1-bigeasy@linutronix.de>
 <20230623171232.892937-2-bigeasy@linutronix.de>
 <d9b7c170-ed0d-5d37-e099-20d233115943@I-love.SAKURA.ne.jp>
 <20230626081254.XmorFrhs@linutronix.de>
 <ZJmkPuqpW-wQAyNz@alley>
 <a1c559b7-335e-5401-d167-301c5b1cd312@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a1c559b7-335e-5401-d167-301c5b1cd312@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-28 21:14:16 [+0900], Tetsuo Handa wrote:
> > Anyway, please do not do this change only because of printk().
> > IMHO, the current ordering is more logical and the printk() problem
> > should be solved another way.
> 
> Then, since [PATCH 1/2] cannot be applied, [PATCH 2/2] is automatically
> rejected.

My understanding is that this patch gets applied and your objection will
be noted.

> I found
> 
>   /*
>    * Locking a pcp requires a PCP lookup followed by a spinlock. To avoid
>    * a migration causing the wrong PCP to be locked and remote memory being
>    * potentially allocated, pin the task to the CPU for the lookup+lock.
>    * preempt_disable is used on !RT because it is faster than migrate_disable.
>    * migrate_disable is used on RT because otherwise RT spinlock usage is
>    * interfered with and a high priority task cannot preempt the allocator.
>    */
>   #ifndef CONFIG_PREEMPT_RT
>   #define pcpu_task_pin()         preempt_disable()
>   #define pcpu_task_unpin()       preempt_enable()
>   #else
>   #define pcpu_task_pin()         migrate_disable()
>   #define pcpu_task_unpin()       migrate_enable()
>   #endif
> 
> in mm/page_alloc.c . Thus, I think that calling migrate_disable() if CONFIG_PREEMPT_RT=y
> and calling local_irq_save() if CONFIG_PREEMPT_RT=n (i.e. Alternative 3) will work.
> 
> But thinking again, since CONFIG_PREEMPT_RT=y uses special printk() approach where messages
> are printed from a dedicated kernel thread, do we need to call printk_deferred_enter() if
> CONFIG_PREEMPT_RT=y ? That is, isn't the fix as straightforward as below?

That below will cause a splat with CONFIG_PROVE_RAW_LOCK_NESTING. That
is because seqlock_t::lock is acquired without disabling interrupts.
Additionally it is a bad example because the seqcount API is bypassed
due to printk's limitations and the problems, that are caused on
PREEMPT_RT, are "ifdefed away". None of this is documented/ explained.

Let me summarize your remaining problem:
- With (and only with) CONFIG_PROVE_LOCKING there can be a printk splat
  caused by a lock validation error noticed by lockdep during
  write_sequnlock_irqrestore().

- This can deadlock if there is a printing output on the tty which is
  using the same console as printk and memory hotplug is active at the
  same time.
  That is because the tty layer acquires the same lock as printk's
  console during memory allocation (of the tty layer).

Now:
- before this deadlocks (with CONFIG_PROVE_LOCKING) chances are high
  that a splat is seen first.

- printk is reworked and the printk output should either happen from a
  dedicated thread or directly via a different console driver which is
  not using uart_port::lock. Thus avoiding the deadlock.

Sebastian
