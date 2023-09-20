Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCB17A7444
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbjITHgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbjITHgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:36:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33140C9;
        Wed, 20 Sep 2023 00:36:11 -0700 (PDT)
Date:   Wed, 20 Sep 2023 07:36:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695195369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Q74FB9/4yC4dcbvYA0o0Hqac36vtO9tM3QqXo8q4G4=;
        b=YKx4QPb5wDnI0zhrT6M62SJ8h22MKqmfI/2qLmd8PRn+i2CFQmpFpRKXtY0bA1A525z22J
        6fmvurKZZf2KHPa1rAwGFjwRFu8zjOFDPL5yC3FBBBAfEVDPSgLq34zl7U8DRXZEa+t1fI
        iAfyaGrwx8WTAVHYoxONVB1ZAOVg2OTObhgjYP1sXCDDiPums3PnVJDGsxTsKrtRtI0Dko
        JmTtjw2NWnFIpRhsme4oJCIx0m8DppsfxpT816hBIJhip92jGCI5iPagCGYzVKJwKPti21
        u3WZS11FHlQjdpa0Bcf62yLE6Cv7GssrYd9ttFRxd4FgGxp4BnDFKApALPwZ+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695195369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Q74FB9/4yC4dcbvYA0o0Hqac36vtO9tM3QqXo8q4G4=;
        b=A8QBr8d2q7A+Jl5KBzbTtcYDBRk/TyARlDHJIH/3VwF9JeAqRuo70O0DIrKfXGebqrRrcL
        yKPz9PBrF3bguuBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex/pi: Fix recursive rt_mutex waiter state
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230915151943.GD6743@noisy.programming.kicks-ass.net>
References: <20230915151943.GD6743@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <169519536885.27769.11385463382531777656.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     fbeb558b0dd0d6348e0872bbbbe96e30c65867b7
Gitweb:        https://git.kernel.org/tip/fbeb558b0dd0d6348e0872bbbbe96e30c65867b7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 15 Sep 2023 17:19:44 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 20 Sep 2023 09:31:14 +02:00

futex/pi: Fix recursive rt_mutex waiter state

Some new assertions pointed out that the existing code has nested rt_mutex wait
state in the futex code.

Specifically, the futex_lock_pi() cancel case uses spin_lock() while there
still is a rt_waiter enqueued for this task, resulting in a state where there
are two waiters for the same task (and task_struct::pi_blocked_on gets
scrambled).

The reason to take hb->lock at this point is to avoid the wake_futex_pi()
EAGAIN case.

This happens when futex_top_waiter() and rt_mutex_top_waiter() state becomes
inconsistent. The current rules are such that this inconsistency will not be
observed.

Notably the case that needs to be avoided is where futex_lock_pi() and
futex_unlock_pi() interleave such that unlock will fail to observe a new
waiter.

*However* the case at hand is where a waiter is leaving, in this case the race
means a waiter that is going away is not observed -- which is harmless,
provided this race is explicitly handled.

This is a somewhat dangerous proposition because the converse race is not
observing a new waiter, which must absolutely not happen. But since the race is
valid this cannot be asserted.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lkml.kernel.org/r/20230915151943.GD6743@noisy.programming.kicks-ass.net
---
 kernel/futex/pi.c      | 76 +++++++++++++++++++++++++----------------
 kernel/futex/requeue.c |  6 ++-
 2 files changed, 52 insertions(+), 30 deletions(-)

diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index f8e65b2..d636a1b 100644
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
@@ -1046,20 +1033,34 @@ retry_private:
 	ret = rt_mutex_wait_proxy_lock(&q.pi_state->pi_mutex, to, &rt_waiter);
 
 cleanup:
-	spin_lock(q.lock_ptr);
 	/*
 	 * If we failed to acquire the lock (deadlock/signal/timeout), we must
-	 * first acquire the hb->lock before removing the lock from the
-	 * rt_mutex waitqueue, such that we can keep the hb and rt_mutex wait
-	 * lists consistent.
+	 * must unwind the above, however we canont lock hb->lock because
+	 * rt_mutex already has a waiter enqueued and hb->lock can itself try
+	 * and enqueue an rt_waiter through rtlock.
+	 *
+	 * Doing the cleanup without holding hb->lock can cause inconsistent
+	 * state between hb and pi_state, but only in the direction of not
+	 * seeing a waiter that is leaving.
+	 *
+	 * See futex_unlock_pi(), it deals with this inconsistency.
 	 *
-	 * In particular; it is important that futex_unlock_pi() can not
-	 * observe this inconsistency.
+	 * There be dragons here, since we must deal with the inconsistency on
+	 * the way out (here), it is impossible to detect/warn about the race
+	 * the other way around (missing an incoming waiter).
+	 *
+	 * What could possibly go wrong...
 	 */
 	if (ret && !rt_mutex_cleanup_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter))
 		ret = 0;
 
 	/*
+	 * Now that the rt_waiter has been dequeued, it is safe to use
+	 * spinlock/rtlock (which might enqueue its own rt_waiter) and fix up
+	 * the
+	 */
+	spin_lock(q.lock_ptr);
+	/*
 	 * Waiter is unqueued.
 	 */
 	rt_mutex_post_schedule();
@@ -1143,6 +1144,7 @@ retry:
 	top_waiter = futex_top_waiter(hb, &key);
 	if (top_waiter) {
 		struct futex_pi_state *pi_state = top_waiter->pi_state;
+		struct rt_mutex_waiter *rt_waiter;
 
 		ret = -EINVAL;
 		if (!pi_state)
@@ -1155,22 +1157,39 @@ retry:
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
 
@@ -1198,6 +1217,7 @@ retry:
 		return ret;
 	}
 
+do_uncontended:
 	/*
 	 * We have no kernel internal state, i.e. no waiters in the
 	 * kernel. Waiters which are about to queue themselves are stuck
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index cba8b1a..4c73e0b 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -850,11 +850,13 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		pi_mutex = &q.pi_state->pi_mutex;
 		ret = rt_mutex_wait_proxy_lock(pi_mutex, to, &rt_waiter);
 
-		/* Current is not longer pi_blocked_on */
-		spin_lock(q.lock_ptr);
+		/*
+		 * See futex_unlock_pi()'s cleanup: comment.
+		 */
 		if (ret && !rt_mutex_cleanup_proxy_lock(pi_mutex, &rt_waiter))
 			ret = 0;
 
+		spin_lock(q.lock_ptr);
 		debug_rt_mutex_free_waiter(&rt_waiter);
 		/*
 		 * Fixup the pi_state owner and possibly acquire the lock if we
