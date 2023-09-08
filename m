Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBA6798AA8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 18:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245116AbjIHQXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 12:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245055AbjIHQXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:23:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83921FDC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 09:23:07 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694190183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p78TCAeYLfEIiaLWFh2fUP2KxDHjOeSpz9mjG1lU/Pk=;
        b=aItuojN9btuYIQJt9txwKKWqwlgOWnyN26xd33wCIJIAoJR69pHwE7Fh0v3D9SCJ0QcGve
        0b8TR1YMZfHhPlo0ZcW9ZcBDm7bu5/icSbH7PPGgeAAw7nH/NZb6WfrJDwaG3SkXvPOQ9l
        LXczbYh8OLy7t9jDjTn5fGKiV1pk5dhHqiScgyDKJlRviqJc4/I+WhtCGQcZ7FKzpZj1j3
        qL+5VRKM2+7y29v1GNa7S9gFrycsfdiTVmqxwWw00q9Bl9XVpFnJyGAc2FpeUY5K3Bp8jQ
        0loAOA/A7164jCgC26E2JgaXlfk03dbJ+GUjcZXMfZ7tcss+JyYpVfswGo/zOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694190183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p78TCAeYLfEIiaLWFh2fUP2KxDHjOeSpz9mjG1lU/Pk=;
        b=tv3yTXjoj4vBzm2Bm6s/MU1yCJYYyL20YyXJ9cNmsDlO9cXyZ0qBBP9q7DLEUXUix7vbki
        OlCEX2BB8AN4D9BQ==
To:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Cc:     bigeasy@linutronix.de, tglx@linutronix.de, boqun.feng@gmail.com,
        bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        jstultz@google.com, juri.lelli@redhat.com, longman@redhat.com,
        mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org,
        swood@redhat.com, vincent.guittot@linaro.org, vschneid@redhat.com,
        will@kernel.org
Subject: [PATCH v3 5/7] locking/rtmutex: Use rt_mutex specific scheduler helpers
Date:   Fri,  8 Sep 2023 18:22:52 +0200
Message-Id: <20230908162254.999499-6-bigeasy@linutronix.de>
In-Reply-To: <20230908162254.999499-1-bigeasy@linutronix.de>
References: <20230908162254.999499-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Have rt_mutex use the rt_mutex specific scheduler helpers to avoid
recursion vs rtlock on the PI state.

[[ peterz: adapted to new names ]]

Reported-by: Crystal Wood <swood@redhat.com>
Signed-off-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230815111430.421408298@infradead.org
Link: https://lore.kernel.org/r/20230825181033.504534-6-bigeasy@linutronix.=
de
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex/pi.c            | 11 +++++++++++
 kernel/locking/rtmutex.c     | 14 ++++++++++++--
 kernel/locking/rwbase_rt.c   |  6 ++++++
 kernel/locking/rwsem.c       |  8 +++++++-
 kernel/locking/spinlock_rt.c |  4 ++++
 5 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index ce2889f123755..f8e65b27d9d6b 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
=20
 #include <linux/slab.h>
+#include <linux/sched/rt.h>
 #include <linux/sched/task.h>
=20
 #include "futex.h"
@@ -1002,6 +1003,12 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int fl=
ags, ktime_t *time, int tryl
 		goto no_block;
 	}
=20
+	/*
+	 * Must be done before we enqueue the waiter, here is unfortunately
+	 * under the hb lock, but that *should* work because it does nothing.
+	 */
+	rt_mutex_pre_schedule();
+
 	rt_mutex_init_waiter(&rt_waiter);
=20
 	/*
@@ -1052,6 +1059,10 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int fl=
ags, ktime_t *time, int tryl
 	if (ret && !rt_mutex_cleanup_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter=
))
 		ret =3D 0;
=20
+	/*
+	 * Waiter is unqueued.
+	 */
+	rt_mutex_post_schedule();
 no_block:
 	/*
 	 * Fixup the pi_state owner and possibly acquire the lock if we
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index bcec0533a0cc0..a3fe05dfd0d8f 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1632,7 +1632,7 @@ static int __sched rt_mutex_slowlock_block(struct rt_=
mutex_base *lock,
 		raw_spin_unlock_irq(&lock->wait_lock);
=20
 		if (!owner || !rtmutex_spin_on_owner(lock, waiter, owner))
-			schedule();
+			rt_mutex_schedule();
=20
 		raw_spin_lock_irq(&lock->wait_lock);
 		set_current_state(state);
@@ -1661,7 +1661,7 @@ static void __sched rt_mutex_handle_deadlock(int res,=
 int detect_deadlock,
 	WARN(1, "rtmutex deadlock detected\n");
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		schedule();
+		rt_mutex_schedule();
 	}
 }
=20
@@ -1756,6 +1756,15 @@ static int __sched rt_mutex_slowlock(struct rt_mutex=
_base *lock,
 	unsigned long flags;
 	int ret;
=20
+	/*
+	 * Do all pre-schedule work here, before we queue a waiter and invoke
+	 * PI -- any such work that trips on rtlock (PREEMPT_RT spinlock) would
+	 * otherwise recurse back into task_blocks_on_rt_mutex() through
+	 * rtlock_slowlock() and will then enqueue a second waiter for this
+	 * same task and things get really confusing real fast.
+	 */
+	rt_mutex_pre_schedule();
+
 	/*
 	 * Technically we could use raw_spin_[un]lock_irq() here, but this can
 	 * be called in early boot if the cmpxchg() fast path is disabled
@@ -1767,6 +1776,7 @@ static int __sched rt_mutex_slowlock(struct rt_mutex_=
base *lock,
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	ret =3D __rt_mutex_slowlock_locked(lock, ww_ctx, state);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+	rt_mutex_post_schedule();
=20
 	return ret;
 }
diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index 25ec0239477c2..c7258cb32d91b 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -71,6 +71,7 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *r=
wb,
 	struct rt_mutex_base *rtm =3D &rwb->rtmutex;
 	int ret;
=20
+	rwbase_pre_schedule();
 	raw_spin_lock_irq(&rtm->wait_lock);
=20
 	/*
@@ -125,6 +126,7 @@ static int __sched __rwbase_read_lock(struct rwbase_rt =
*rwb,
 		rwbase_rtmutex_unlock(rtm);
=20
 	trace_contention_end(rwb, ret);
+	rwbase_post_schedule();
 	return ret;
 }
=20
@@ -237,6 +239,8 @@ static int __sched rwbase_write_lock(struct rwbase_rt *=
rwb,
 	/* Force readers into slow path */
 	atomic_sub(READER_BIAS, &rwb->readers);
=20
+	rwbase_pre_schedule();
+
 	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
 	if (__rwbase_write_trylock(rwb))
 		goto out_unlock;
@@ -248,6 +252,7 @@ static int __sched rwbase_write_lock(struct rwbase_rt *=
rwb,
 		if (rwbase_signal_pending_state(state, current)) {
 			rwbase_restore_current_state();
 			__rwbase_write_unlock(rwb, 0, flags);
+			rwbase_post_schedule();
 			trace_contention_end(rwb, -EINTR);
 			return -EINTR;
 		}
@@ -266,6 +271,7 @@ static int __sched rwbase_write_lock(struct rwbase_rt *=
rwb,
=20
 out_unlock:
 	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
+	rwbase_post_schedule();
 	return 0;
 }
=20
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 9eabd585ce7af..2340b6d90ec6f 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1427,8 +1427,14 @@ static inline void __downgrade_write(struct rw_semap=
hore *sem)
 #define rwbase_signal_pending_state(state, current)	\
 	signal_pending_state(state, current)
=20
+#define rwbase_pre_schedule()				\
+	rt_mutex_pre_schedule()
+
 #define rwbase_schedule()				\
-	schedule()
+	rt_mutex_schedule()
+
+#define rwbase_post_schedule()				\
+	rt_mutex_post_schedule()
=20
 #include "rwbase_rt.c"
=20
diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index 48a19ed8486d8..842037b2ba548 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -184,9 +184,13 @@ static __always_inline int  rwbase_rtmutex_trylock(str=
uct rt_mutex_base *rtm)
=20
 #define rwbase_signal_pending_state(state, current)	(0)
=20
+#define rwbase_pre_schedule()
+
 #define rwbase_schedule()				\
 	schedule_rtlock()
=20
+#define rwbase_post_schedule()
+
 #include "rwbase_rt.c"
 /*
  * The common functions which get wrapped into the rwlock API.
--=20
2.40.1

