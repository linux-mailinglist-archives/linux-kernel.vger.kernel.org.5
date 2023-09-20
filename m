Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8817A778A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbjITJad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbjITJab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:30:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3091D3;
        Wed, 20 Sep 2023 02:30:22 -0700 (PDT)
Date:   Wed, 20 Sep 2023 11:30:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695202218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=hhCYI+PeWEvc67H6YD9WCNTIMASfjH2wx16HCENacCE=;
        b=rfCR8vEaESxonkkT7GovT/1/5BmcBNeGyDMKKlFSNZaLkzePT5vhDCPs82DWVug3KF5M44
        Ddqh1k/swKDT3f0SH/G2vgRpRSv7hUk6dZ8/XO0CV9ALCzDUb+/4LfVkqA1mi1JOQURG1r
        /r5WkkSB7kTpRpsJo/XAt6SE29FRmrQEqT4UThKFWrwT7+Onf5f8sbBClWTXd8ySKFR+Zp
        /0x5AXX4OVi3qqTn2ev9pI2znSX9ELDvJ9W7q5bwpXYObsdTHjfHZXxnFRHYL1bKCh6fUa
        ahj2qQIt7rh9IsYbqBIq72tWlJnSZAqZsS+4ef4PyhMUqfaRiAYEpYS/Op8acA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695202218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=hhCYI+PeWEvc67H6YD9WCNTIMASfjH2wx16HCENacCE=;
        b=FOZHJQ0/1sXkeAQoO/fyp8vCk2CQN/8MyfyXU81exOyQ81lChOm6jiVZhfTAvOHXOF1Mjo
        bzasBbEirmJtuiDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.6-rc2-rt3
Message-ID: <20230920093016.xGpZHYvz@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v6.6-rc2-rt3 patch set. 

Changes since v6.6-rc2-rt2:

  - The locking patches for flushed queued I/O have been applied to the
    tip tree. This update synchronises the patches with the version as
    applied to the tip tree.

Known issues
     None

The delta patch against v6.6-rc2-rt2 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/incr/patch-6.6-rc2-rt2-rt3.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.6-rc2-rt3

The RT patch against v6.6-rc2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/older/patch-6.6-rc2-rt3.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/older/patches-6.6-rc2-rt3.tar.xz

Sebastian

diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 58fbc34a59811..b5379c0e6d6d1 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -254,29 +254,6 @@ double_unlock_hb(struct futex_hash_bucket *hb1, struct futex_hash_bucket *hb2)
 		spin_unlock(&hb2->lock);
 }
 
-static inline void futex_trylock_hblock(spinlock_t *lock)
-{
-	do {
-		ktime_t chill_time;;
-
-		/*
-		 * Current is not longer pi_blocked_on if it owns the lock. It
-		 * can still have pi_blocked_on set if the lock acquiring was
-		 * interrupted by signal or timeout. The trylock operation does
-		 * not clobber pi_blocked_on so it is the only option.
-		 * Should the try-lock operation fail then it needs leave the CPU
-		 * to avoid a busy loop in case it is the task with the highest
-		 * priority.
-		 */
-		if (spin_trylock(lock))
-			return;
-
-		chill_time = ktime_set(0, NSEC_PER_MSEC);
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_hrtimeout(&chill_time, HRTIMER_MODE_REL_HARD);
-	} while (1);
-}
-
 /* syscalls */
 
 extern int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags, u32
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index 1440fdcdbfd8c..d636a1bbd7d06 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -611,29 +611,16 @@ int futex_lock_pi_atomic(u32 __user *uaddr, struct futex_hash_bucket *hb,
 /*
  * Caller must hold a reference on @pi_state.
  */
-static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_state)
+static int wake_futex_pi(u32 __user *uaddr, u32 uval,
+			 struct futex_pi_state *pi_state,
+			 struct rt_mutex_waiter *top_waiter)
 {
-	struct rt_mutex_waiter *top_waiter;
 	struct task_struct *new_owner;
 	bool postunlock = false;
 	DEFINE_RT_WAKE_Q(wqh);
 	u32 curval, newval;
 	int ret = 0;
 
-	top_waiter = rt_mutex_top_waiter(&pi_state->pi_mutex);
-	if (WARN_ON_ONCE(!top_waiter)) {
-		/*
-		 * As per the comment in futex_unlock_pi() this should not happen.
-		 *
-		 * When this happens, give up our locks and try again, giving
-		 * the futex_lock_pi() instance time to complete, either by
-		 * waiting on the rtmutex or removing itself from the futex
-		 * queue.
-		 */
-		ret = -EAGAIN;
-		goto out_unlock;
-	}
-
 	new_owner = top_waiter->task;
 
 	/*
@@ -1046,21 +1033,37 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int tryl
 	ret = rt_mutex_wait_proxy_lock(&q.pi_state->pi_mutex, to, &rt_waiter);
 
 cleanup:
-	rt_mutex_post_schedule();
-
-	futex_trylock_hblock(q.lock_ptr);
-
 	/*
 	 * If we failed to acquire the lock (deadlock/signal/timeout), we must
-	 * first acquire the hb->lock before removing the lock from the
-	 * rt_mutex waitqueue, such that we can keep the hb and rt_mutex wait
-	 * lists consistent.
+	 * must unwind the above, however we canont lock hb->lock because
+	 * rt_mutex already has a waiter enqueued and hb->lock can itself try
+	 * and enqueue an rt_waiter through rtlock.
 	 *
-	 * In particular; it is important that futex_unlock_pi() can not
-	 * observe this inconsistency.
+	 * Doing the cleanup without holding hb->lock can cause inconsistent
+	 * state between hb and pi_state, but only in the direction of not
+	 * seeing a waiter that is leaving.
+	 *
+	 * See futex_unlock_pi(), it deals with this inconsistency.
+	 *
+	 * There be dragons here, since we must deal with the inconsistency on
+	 * the way out (here), it is impossible to detect/warn about the race
+	 * the other way around (missing an incoming waiter).
+	 *
+	 * What could possibly go wrong...
 	 */
 	if (ret && !rt_mutex_cleanup_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter))
 		ret = 0;
+
+	/*
+	 * Now that the rt_waiter has been dequeued, it is safe to use
+	 * spinlock/rtlock (which might enqueue its own rt_waiter) and fix up
+	 * the
+	 */
+	spin_lock(q.lock_ptr);
+	/*
+	 * Waiter is unqueued.
+	 */
+	rt_mutex_post_schedule();
 no_block:
 	/*
 	 * Fixup the pi_state owner and possibly acquire the lock if we
@@ -1141,6 +1144,7 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 	top_waiter = futex_top_waiter(hb, &key);
 	if (top_waiter) {
 		struct futex_pi_state *pi_state = top_waiter->pi_state;
+		struct rt_mutex_waiter *rt_waiter;
 
 		ret = -EINVAL;
 		if (!pi_state)
@@ -1153,22 +1157,39 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 		if (pi_state->owner != current)
 			goto out_unlock;
 
-		get_pi_state(pi_state);
 		/*
 		 * By taking wait_lock while still holding hb->lock, we ensure
-		 * there is no point where we hold neither; and therefore
-		 * wake_futex_p() must observe a state consistent with what we
-		 * observed.
+		 * there is no point where we hold neither; and thereby
+		 * wake_futex_pi() must observe any new waiters.
+		 *
+		 * Since the cleanup: case in futex_lock_pi() removes the
+		 * rt_waiter without holding hb->lock, it is possible for
+		 * wake_futex_pi() to not find a waiter while the above does,
+		 * in this case the waiter is on the way out and it can be
+		 * ignored.
 		 *
 		 * In particular; this forces __rt_mutex_start_proxy() to
 		 * complete such that we're guaranteed to observe the
-		 * rt_waiter. Also see the WARN in wake_futex_pi().
+		 * rt_waiter.
 		 */
 		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
+
+		/*
+		 * Futex vs rt_mutex waiter state -- if there are no rt_mutex
+		 * waiters even though futex thinks there are, then the waiter
+		 * is leaving and the uncontended path is safe to take.
+		 */
+		rt_waiter = rt_mutex_top_waiter(&pi_state->pi_mutex);
+		if (!rt_waiter) {
+			raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
+			goto do_uncontended;
+		}
+
+		get_pi_state(pi_state);
 		spin_unlock(&hb->lock);
 
 		/* drops pi_state->pi_mutex.wait_lock */
-		ret = wake_futex_pi(uaddr, uval, pi_state);
+		ret = wake_futex_pi(uaddr, uval, pi_state, rt_waiter);
 
 		put_pi_state(pi_state);
 
@@ -1196,6 +1217,7 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 		return ret;
 	}
 
+do_uncontended:
 	/*
 	 * We have no kernel internal state, i.e. no waiters in the
 	 * kernel. Waiters which are about to queue themselves are stuck
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index 26888cfa74449..4c73e0b81accd 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -850,11 +850,13 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		pi_mutex = &q.pi_state->pi_mutex;
 		ret = rt_mutex_wait_proxy_lock(pi_mutex, to, &rt_waiter);
 
-		futex_trylock_hblock(q.lock_ptr);
-
+		/*
+		 * See futex_unlock_pi()'s cleanup: comment.
+		 */
 		if (ret && !rt_mutex_cleanup_proxy_lock(pi_mutex, &rt_waiter))
 			ret = 0;
 
+		spin_lock(q.lock_ptr);
 		debug_rt_mutex_free_waiter(&rt_waiter);
 		/*
 		 * Fixup the pi_state owner and possibly acquire the lock if we
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index e56585ef489c8..4a10e8c16fd2b 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1166,13 +1166,10 @@ try_to_take_rt_mutex(struct rt_mutex_base *lock, struct task_struct *task,
 	 * Clear @task->pi_blocked_on. Requires protection by
 	 * @task->pi_lock. Redundant operation for the @waiter == NULL
 	 * case, but conditionals are more expensive than a redundant
-	 * store. But then there is FUTEX and if rt_mutex_wait_proxy_lock()
-	 * did not acquire the lock it try-locks another lock before it clears
-	 * @task->pi_blocked_on so we mustn't clear it here premature.
+	 * store.
 	 */
 	raw_spin_lock(&task->pi_lock);
-	if (waiter)
-		task->pi_blocked_on = NULL;
+	task->pi_blocked_on = NULL;
 	/*
 	 * Finish the lock acquisition. @task is the new owner. If
 	 * other waiters exist we have to insert the highest priority
diff --git a/localversion-rt b/localversion-rt
index c3054d08a1129..1445cd65885cd 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt2
+-rt3
