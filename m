Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79347799A6E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 20:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239985AbjIISa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 14:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjIISa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 14:30:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEE59C
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 11:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=mWzsluDlOvimDvepi8JqubaSh0K884hvB6/k13JhDn0=; b=j6IincSJGy9iNb4u7Q6vbaf/GX
        jyHY8HRgHLvIZrBNMmnTYvCCwgrOaHLKqEFNbgEA2zE6oNP5NMdp9P4Sg5WUpewhQW8wPIyQTwOUY
        3x6FduPrQ4hC7zRnnJOx8EjPQG96hPGmHwYbxcjt76VwiRtJICfSjgsIGY3hCMo6oTxi9xsXAmhAS
        Ier6JV5v/ScddVqqW4jwQqcuRdhAXletVHyrwb0Sx0tbdNZqB3+OdhxNFAH3Wo2BZcR8HDZX2IW8o
        qtgR/lFzoahakm19/iBY+DKJnQWTxXiffvLHWMTIIVfzA1L5TlBFevhd1GOzeA5BqJ1mB1C6IuNgv
        tSgL1wsw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qf2iS-003SbF-39;
        Sat, 09 Sep 2023 18:29:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1766C300348; Sat,  9 Sep 2023 20:29:58 +0200 (CEST)
Date:   Sat, 9 Sep 2023 20:29:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        boqun.feng@gmail.com, bristot@redhat.com, bsegall@google.com,
        dietmar.eggemann@arm.com, jstultz@google.com,
        juri.lelli@redhat.com, longman@redhat.com, mgorman@suse.de,
        mingo@redhat.com, rostedt@goodmis.org, swood@redhat.com,
        vincent.guittot@linaro.org, vschneid@redhat.com, will@kernel.org
Subject: Re: [PATCH v3 7/7] locking/rtmutex: Acquire the hb lock via trylock
 after wait-proxylock.
Message-ID: <20230909182957.GC33532@noisy.programming.kicks-ass.net>
References: <20230908162254.999499-1-bigeasy@linutronix.de>
 <20230908162254.999499-8-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230908162254.999499-8-bigeasy@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 06:22:54PM +0200, Sebastian Andrzej Siewior wrote:
> After rt_mutex_wait_proxy_lock() task_struct::pi_blocked_on is cleared
> if current owns the lock. If the operation has been interrupted by a
> signal or timeout then pi_blocked_on can be set. This means spin_lock()
> *can* overwrite pi_blocked_on on PREEMPT_RT. This has been noticed by
> the recently added lockdep-asserts…
> 
> The rt_mutex_cleanup_proxy_lock() operation will clear pi_blocked_on
> (and update pending waiters as expected) but it must happen under the hb
> lock to ensure the same state in rtmutex and userland.
> 
> Given all the possibilities it is probably the simplest option to
> try-lock the hb lock. In case the lock is occupied a quick nap is
> needed. A busy loop can lock up the system if performed by a task with
> high priorioty preventing the owner from running.
> 
> The rt_mutex_post_schedule() needs to be put before try-lock-loop
> because otherwie the schedule() in schedule_hrtimeout() will trip over
> the !sched_rt_mutex assert.
> 
> Introduce futex_trylock_hblock() to try-lock the hb lock and sleep until
> the try-lock operation succeeds. Use it after rt_mutex_wait_proxy_lock()
> to acquire the lock.
> 

Arggggh... this just keeps getting better :/

