Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F1A77CB91
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbjHOLSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236690AbjHOLRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:17:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D0A107
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=64NfNxxnz3oqbDWJ7Rqn3og2SOfT9Ixlmb53B7Q5zlw=; b=jWfTWnPklh7nzbZ1u5U1RmIPkG
        6p6LupFaIZ6pDbasBubx7HCAUhqG+jpIT/Ybu6E1zHhhigADDEn3ea8RRj1dvRImpObZgBp6GPuTC
        a+C2/3SRwKhGEmUYyEHq/+yKLvkqO4Y+55lTGqBwfyX0FK8dzQbk5Xz3d9B8ZemST10EJkcWkMpYz
        WFaGiE92FrkrNsWhOPJwh4vrJH7IhUiLgiQIfkZJCVwW0C7klkod8wmm1Z+YQj/zbrirUjaR7Cymf
        dl8SZAAb1pSwYYnr0Oo5mxs3Dm248Aca0/rda6IRAMUULop92CtIGegOKug/0YCVjqpbFnk1fKpew
        tQWA1V4A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qVs2d-00Bo45-0U;
        Tue, 15 Aug 2023 11:16:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8C3463008CD;
        Tue, 15 Aug 2023 13:16:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0C73E2074B3DC; Tue, 15 Aug 2023 13:16:49 +0200 (CEST)
Message-ID: <20230815111430.421408298@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 15 Aug 2023 13:01:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     bigeasy@linutronix.de, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        bsegall@google.com, boqun.feng@gmail.com, swood@redhat.com,
        bristot@redhat.com, dietmar.eggemann@arm.com, mingo@redhat.com,
        jstultz@google.com, juri.lelli@redhat.com, mgorman@suse.de,
        rostedt@goodmis.org, vschneid@redhat.com,
        vincent.guittot@linaro.org, longman@redhat.com, will@kernel.org
Subject: [PATCH 5/6] locking/rtmutex: Use rt_mutex specific scheduler helpers
References: <20230815110121.117752409@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Have rt_mutex use the rt_mutex specific scheduler helpers to avoid
recursion vs rtlock on the PI state.

[[ peterz: adapted to new names ]]

Reported-by: Crystal Wood <swood@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/rtmutex.c     |   14 ++++++++++++--
 kernel/locking/rwbase_rt.c   |    2 ++
 kernel/locking/rwsem.c       |    8 +++++++-
 kernel/locking/spinlock_rt.c |    4 ++++
 4 files changed, 25 insertions(+), 3 deletions(-)

--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1636,7 +1636,7 @@ static int __sched rt_mutex_slowlock_blo
 		raw_spin_unlock_irq(&lock->wait_lock);
 
 		if (!owner || !rtmutex_spin_on_owner(lock, waiter, owner))
-			schedule();
+			rt_mutex_schedule();
 
 		raw_spin_lock_irq(&lock->wait_lock);
 		set_current_state(state);
@@ -1665,7 +1665,7 @@ static void __sched rt_mutex_handle_dead
 	WARN(1, "rtmutex deadlock detected\n");
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		schedule();
+		rt_mutex_schedule();
 	}
 }
 
@@ -1761,6 +1761,15 @@ static int __sched rt_mutex_slowlock(str
 	int ret;
 
 	/*
+	 * Do all pre-schedule work here, before we queue a waiter and invoke
+	 * PI -- any such work that trips on rtlock (PREEMPT_RT spinlock) would
+	 * otherwise recurse back into task_blocks_on_rt_mutex() through
+	 * rtlock_slowlock() and will then enqueue a second waiter for this
+	 * same task and things get really confusing real fast.
+	 */
+	rt_mutex_pre_schedule();
+
+	/*
 	 * Technically we could use raw_spin_[un]lock_irq() here, but this can
 	 * be called in early boot if the cmpxchg() fast path is disabled
 	 * (debug, no architecture support). In this case we will acquire the
@@ -1771,6 +1780,7 @@ static int __sched rt_mutex_slowlock(str
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	ret = __rt_mutex_slowlock_locked(lock, ww_ctx, state);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+	rt_mutex_post_schedule();
 
 	return ret;
 }
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -71,6 +71,7 @@ static int __sched __rwbase_read_lock(st
 	struct rt_mutex_base *rtm = &rwb->rtmutex;
 	int ret;
 
+	rwbase_pre_schedule();
 	raw_spin_lock_irq(&rtm->wait_lock);
 
 	/*
@@ -125,6 +126,7 @@ static int __sched __rwbase_read_lock(st
 		rwbase_rtmutex_unlock(rtm);
 
 	trace_contention_end(rwb, ret);
+	rwbase_post_schedule();
 	return ret;
 }
 
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1427,8 +1427,14 @@ static inline void __downgrade_write(str
 #define rwbase_signal_pending_state(state, current)	\
 	signal_pending_state(state, current)
 
+#define rwbase_pre_schedule()				\
+	rt_mutex_pre_schedule()
+
 #define rwbase_schedule()				\
-	schedule()
+	rt_mutex_schedule()
+
+#define rwbase_post_schedule()				\
+	rt_mutex_post_schedule()
 
 #include "rwbase_rt.c"
 
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -184,9 +184,13 @@ static __always_inline int  rwbase_rtmut
 
 #define rwbase_signal_pending_state(state, current)	(0)
 
+#define rwbase_pre_schedule()
+
 #define rwbase_schedule()				\
 	schedule_rtlock()
 
+#define rwbase_post_schedule()
+
 #include "rwbase_rt.c"
 /*
  * The common functions which get wrapped into the rwlock API.


