Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CDE7A7446
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbjITHgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbjITHgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:36:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A55197;
        Wed, 20 Sep 2023 00:36:12 -0700 (PDT)
Date:   Wed, 20 Sep 2023 07:36:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695195370;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iUexxCBLwPFp5aWH62AQDgFy7yp+ore6PnYzOXd+ANk=;
        b=j5DNR2RHfKs+UiXB/iW2kBNN8bDuTE1QQXz/hd2ETg/0LTt5sBny82hZ84qIE1igZCGgZ9
        saeJozcDXTzz6zpkcbdZOIGZTiNEFLVE8oN2xHQhA8oogkUxV8vexm17J2mT1gF4O2gngV
        raGAy09xo9gsH+lYS/+qZB1XEgcyG4YixTcd2FQ31fo2gQGTmHmfolTDrZhRsDZ8TwG8RL
        2j/VCcyQVLabbJ5Z5Iehz0nJV+uUC04dZKxFPEN9cGkkxACMBbbOReKO3QPp9z3P8I7BcN
        StXWGXnumv7jjRYVvlZ52Lz6YWbssx03iDtsj0cAwyUH2igCHRUBQ/N5zXL23Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695195370;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iUexxCBLwPFp5aWH62AQDgFy7yp+ore6PnYzOXd+ANk=;
        b=YPrwgFmpAMrRKaldMu/AhtSW9IAxvXt5PsF4ykBakaLCiIAexjAy+FJd1Q98BTQP9hSMOM
        0S/f7McMv24aM4Ag==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Use rt_mutex specific scheduler helpers
Cc:     Crystal Wood <swood@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230908162254.999499-6-bigeasy@linutronix.de>
References: <20230908162254.999499-6-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <169519537017.27769.1840935326971122859.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d14f9e930b9073de264c106bf04968286ef9b3a4
Gitweb:        https://git.kernel.org/tip/d14f9e930b9073de264c106bf04968286ef9b3a4
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 08 Sep 2023 18:22:52 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 20 Sep 2023 09:31:13 +02:00

locking/rtmutex: Use rt_mutex specific scheduler helpers

Have rt_mutex use the rt_mutex specific scheduler helpers to avoid
recursion vs rtlock on the PI state.

[[ peterz: adapted to new names ]]

Reported-by: Crystal Wood <swood@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230908162254.999499-6-bigeasy@linutronix.de
---
 kernel/futex/pi.c            | 11 +++++++++++
 kernel/locking/rtmutex.c     | 14 ++++++++++++--
 kernel/locking/rwbase_rt.c   |  6 ++++++
 kernel/locking/rwsem.c       |  8 +++++++-
 kernel/locking/spinlock_rt.c |  4 ++++
 5 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index ce2889f..f8e65b2 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 #include <linux/slab.h>
+#include <linux/sched/rt.h>
 #include <linux/sched/task.h>
 
 #include "futex.h"
@@ -1002,6 +1003,12 @@ retry_private:
 		goto no_block;
 	}
 
+	/*
+	 * Must be done before we enqueue the waiter, here is unfortunately
+	 * under the hb lock, but that *should* work because it does nothing.
+	 */
+	rt_mutex_pre_schedule();
+
 	rt_mutex_init_waiter(&rt_waiter);
 
 	/*
@@ -1052,6 +1059,10 @@ cleanup:
 	if (ret && !rt_mutex_cleanup_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter))
 		ret = 0;
 
+	/*
+	 * Waiter is unqueued.
+	 */
+	rt_mutex_post_schedule();
 no_block:
 	/*
 	 * Fixup the pi_state owner and possibly acquire the lock if we
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index bcec053..a3fe05d 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1632,7 +1632,7 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 		raw_spin_unlock_irq(&lock->wait_lock);
 
 		if (!owner || !rtmutex_spin_on_owner(lock, waiter, owner))
-			schedule();
+			rt_mutex_schedule();
 
 		raw_spin_lock_irq(&lock->wait_lock);
 		set_current_state(state);
@@ -1661,7 +1661,7 @@ static void __sched rt_mutex_handle_deadlock(int res, int detect_deadlock,
 	WARN(1, "rtmutex deadlock detected\n");
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		schedule();
+		rt_mutex_schedule();
 	}
 }
 
@@ -1757,6 +1757,15 @@ static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock,
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
@@ -1767,6 +1776,7 @@ static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock,
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	ret = __rt_mutex_slowlock_locked(lock, ww_ctx, state);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+	rt_mutex_post_schedule();
 
 	return ret;
 }
diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index 25ec023..c7258cb 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -71,6 +71,7 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
 	struct rt_mutex_base *rtm = &rwb->rtmutex;
 	int ret;
 
+	rwbase_pre_schedule();
 	raw_spin_lock_irq(&rtm->wait_lock);
 
 	/*
@@ -125,6 +126,7 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
 		rwbase_rtmutex_unlock(rtm);
 
 	trace_contention_end(rwb, ret);
+	rwbase_post_schedule();
 	return ret;
 }
 
@@ -237,6 +239,8 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
 	/* Force readers into slow path */
 	atomic_sub(READER_BIAS, &rwb->readers);
 
+	rwbase_pre_schedule();
+
 	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
 	if (__rwbase_write_trylock(rwb))
 		goto out_unlock;
@@ -248,6 +252,7 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
 		if (rwbase_signal_pending_state(state, current)) {
 			rwbase_restore_current_state();
 			__rwbase_write_unlock(rwb, 0, flags);
+			rwbase_post_schedule();
 			trace_contention_end(rwb, -EINTR);
 			return -EINTR;
 		}
@@ -266,6 +271,7 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
 
 out_unlock:
 	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
+	rwbase_post_schedule();
 	return 0;
 }
 
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 9eabd58..2340b6d 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1427,8 +1427,14 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
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
 
diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index 48a19ed..842037b 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -184,9 +184,13 @@ static __always_inline int  rwbase_rtmutex_trylock(struct rt_mutex_base *rtm)
 
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
