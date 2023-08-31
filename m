Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC6E78EF98
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 16:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245115AbjHaOdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 10:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjHaOdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:33:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10793113;
        Thu, 31 Aug 2023 07:33:10 -0700 (PDT)
Date:   Thu, 31 Aug 2023 16:33:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693492387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=0dLfExl6OyA1FL3EWUqd5FLAlpEdUZJdWxajYdG4idU=;
        b=HI3VBQChi75w7aynRgrXHxDObDpd9ObRuGmYsA6ap61TBVQYMVMoneVAz/2f7/RYU4xexC
        fTtHXxfDT9B2GK7K7gdzTB0hQWpN5Sdv0vyF4jY7/w65oDi1eVuWP2XZKO+incCIaz3ShD
        JOOHl5V+mdb9QR1LgJ/84FPXFjsNh6LPFz2+GvLZbBRet3nNGIqu/n3VAiBVtjNkr/XHbL
        j5kJikPw5/P0hoCnYeAj4g+cL9wyQDHeI4ya51aGU0BjYS+8dFywdA8YrtaOSaLJ/SzPGS
        2ZY34jJ9mZLxPKP4HkAK2q3IdNpmM8Yp33DmSXHxZW2+YWjW/L249uaWsoI8+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693492387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=0dLfExl6OyA1FL3EWUqd5FLAlpEdUZJdWxajYdG4idU=;
        b=U48J36C0YRMg4kwOf9F+Za6KZ8JGVpgnb9OA7FhRR/Oiwmj5MzSfgDUhU1+qik4hrmnnIx
        tY9Jxudjo1o6NcAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.5-rt6
Message-ID: <20230831143305.sfEVXv7Y@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v6.5-rt6 patch set. 

Changes since v6.5-rt5:

  - An error in the Futex requeue-PI has been noticed after the recent
    rework.

  - The "NOHZ tick-stop error" was printed in legetime cases. Patch by
    Paul Gortmaker.

Known issues
     None

The delta patch against v6.5-rt5 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.5/incr/patch-6.5-rt5-rt6.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.5-rt6

The RT patch against v6.5 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.5/older/patch-6.5-rt6.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.5/older/patches-6.5-rt6.tar.xz

Sebastian

diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index b5379c0e6d6d1..58fbc34a59811 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -254,6 +254,29 @@ double_unlock_hb(struct futex_hash_bucket *hb1, struct futex_hash_bucket *hb2)
 		spin_unlock(&hb2->lock);
 }
 
+static inline void futex_trylock_hblock(spinlock_t *lock)
+{
+	do {
+		ktime_t chill_time;;
+
+		/*
+		 * Current is not longer pi_blocked_on if it owns the lock. It
+		 * can still have pi_blocked_on set if the lock acquiring was
+		 * interrupted by signal or timeout. The trylock operation does
+		 * not clobber pi_blocked_on so it is the only option.
+		 * Should the try-lock operation fail then it needs leave the CPU
+		 * to avoid a busy loop in case it is the task with the highest
+		 * priority.
+		 */
+		if (spin_trylock(lock))
+			return;
+
+		chill_time = ktime_set(0, NSEC_PER_MSEC);
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_hrtimeout(&chill_time, HRTIMER_MODE_REL_HARD);
+	} while (1);
+}
+
 /* syscalls */
 
 extern int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags, u32
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index f8e65b27d9d6b..1440fdcdbfd8c 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -1046,7 +1046,10 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int tryl
 	ret = rt_mutex_wait_proxy_lock(&q.pi_state->pi_mutex, to, &rt_waiter);
 
 cleanup:
-	spin_lock(q.lock_ptr);
+	rt_mutex_post_schedule();
+
+	futex_trylock_hblock(q.lock_ptr);
+
 	/*
 	 * If we failed to acquire the lock (deadlock/signal/timeout), we must
 	 * first acquire the hb->lock before removing the lock from the
@@ -1058,11 +1061,6 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int tryl
 	 */
 	if (ret && !rt_mutex_cleanup_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter))
 		ret = 0;
-
-	/*
-	 * Waiter is unqueued.
-	 */
-	rt_mutex_post_schedule();
 no_block:
 	/*
 	 * Fixup the pi_state owner and possibly acquire the lock if we
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index cba8b1a6a4cc2..26888cfa74449 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -850,8 +850,8 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		pi_mutex = &q.pi_state->pi_mutex;
 		ret = rt_mutex_wait_proxy_lock(pi_mutex, to, &rt_waiter);
 
-		/* Current is not longer pi_blocked_on */
-		spin_lock(q.lock_ptr);
+		futex_trylock_hblock(q.lock_ptr);
+
 		if (ret && !rt_mutex_cleanup_proxy_lock(pi_mutex, &rt_waiter))
 			ret = 0;
 
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 4a10e8c16fd2b..e56585ef489c8 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1166,10 +1166,13 @@ try_to_take_rt_mutex(struct rt_mutex_base *lock, struct task_struct *task,
 	 * Clear @task->pi_blocked_on. Requires protection by
 	 * @task->pi_lock. Redundant operation for the @waiter == NULL
 	 * case, but conditionals are more expensive than a redundant
-	 * store.
+	 * store. But then there is FUTEX and if rt_mutex_wait_proxy_lock()
+	 * did not acquire the lock it try-locks another lock before it clears
+	 * @task->pi_blocked_on so we mustn't clear it here premature.
 	 */
 	raw_spin_lock(&task->pi_lock);
-	task->pi_blocked_on = NULL;
+	if (waiter)
+		task->pi_blocked_on = NULL;
 	/*
 	 * Finish the lock acquisition. @task is the new owner. If
 	 * other waiters exist we have to insert the highest priority
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index b417fe6e43f6d..3bea1d0f20169 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1045,7 +1045,7 @@ static bool report_idle_softirq(void)
 		return false;
 
 	/* On RT, softirqs handling may be waiting on some lock */
-	if (!local_bh_blocked())
+	if (local_bh_blocked())
 		return false;
 
 	pr_warn("NOHZ tick-stop error: local softirq work is pending, handler #%02x!!!\n",
diff --git a/localversion-rt b/localversion-rt
index 0efe7ba1930e1..8fc605d806670 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt5
+-rt6
