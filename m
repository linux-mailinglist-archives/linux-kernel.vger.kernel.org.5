Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAB07A222F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbjIOPUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235968AbjIOPUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:20:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7C7E6D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q2UaZF/yJBa4aq+9naVBxJvmFVpSvqxDv3evZCTMQPQ=; b=vPQ9h02vSmDfVoSIm5o+hLXAUP
        oXI9pYbggPTvPhrcnH0euREVqbdJWVEvJACprB+lZ9Qo7EUfipKAa3cBMBGjPD48EoUb8ENbUkRVn
        AcyLWBC5wlWO/HBntLlxrTJ9+asqTQ/zZXgARmxsqlX8diXUlKKOUOt+i06oQ4fxhcwBd27c6Okvv
        4ICqrvmKQoA1j+IdV0iMCY73bY2ibymB5GNOzS4qZpuOBqwAX/ta/6mKSWc1UZ6B3AtBgbWtCs0qe
        pRhWS7EPq6AozFr97ExDZaIBP/p6W3NaK1vY+4ltCc8SkRVraTYYQ0gtospfiq79ShuNZD7WzfnY8
        wmwyzWpA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhAbg-00ARL8-9v; Fri, 15 Sep 2023 15:19:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id F322E300353; Fri, 15 Sep 2023 17:19:43 +0200 (CEST)
Date:   Fri, 15 Sep 2023 17:19:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        jstultz@google.com, juri.lelli@redhat.com, longman@redhat.com,
        mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org,
        swood@redhat.com, vincent.guittot@linaro.org, vschneid@redhat.com,
        will@kernel.org
Subject: Re: [PATCH v3 7/7] locking/rtmutex: Acquire the hb lock via trylock
 after wait-proxylock.
Message-ID: <20230915151943.GD6743@noisy.programming.kicks-ass.net>
References: <20230908162254.999499-1-bigeasy@linutronix.de>
 <20230908162254.999499-8-bigeasy@linutronix.de>
 <20230911141135.GB9098@noisy.programming.kicks-ass.net>
 <87fs3f1tl0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fs3f1tl0.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 02:58:35PM +0200, Thomas Gleixner wrote:

> I spent quite some time to convince myself that this is correct. I was
> not able to poke a hole into it. So that really should be safe to
> do. Famous last words ...

IKR :-/

Something like so then...

---
Subject: futex/pi: Fix recursive rt_mutex waiter state
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 12 Sep 2023 13:17:11 +0200

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
---
 pi.c      |   76 +++++++++++++++++++++++++++++++++++++++-----------------------
 requeue.c |    6 +++-
 2 files changed, 52 insertions(+), 30 deletions(-)

Index: linux-2.6/kernel/futex/pi.c
===================================================================
--- linux-2.6.orig/kernel/futex/pi.c
+++ linux-2.6/kernel/futex/pi.c
@@ -610,29 +610,16 @@ int futex_lock_pi_atomic(u32 __user *uad
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
@@ -1039,19 +1026,33 @@ retry_private:
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
+	 *
+	 * There be dragons here, since we must deal with the inconsistency on
+	 * the way out (here), it is impossible to detect/warn about the race
+	 * the other way around (missing an incoming waiter).
 	 *
-	 * In particular; it is important that futex_unlock_pi() can not
-	 * observe this inconsistency.
+	 * What could possibly go wrong...
 	 */
 	if (ret && !rt_mutex_cleanup_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter))
 		ret = 0;
 
+	/*
+	 * Now that the rt_waiter has been dequeued, it is safe to use
+	 * spinlock/rtlock (which might enqueue its own rt_waiter) and fix up
+	 * the
+	 */
+	spin_lock(q.lock_ptr);
 no_block:
 	/*
 	 * Fixup the pi_state owner and possibly acquire the lock if we
@@ -1132,6 +1133,7 @@ retry:
 	top_waiter = futex_top_waiter(hb, &key);
 	if (top_waiter) {
 		struct futex_pi_state *pi_state = top_waiter->pi_state;
+		struct rt_mutex_waiter *rt_waiter;
 
 		ret = -EINVAL;
 		if (!pi_state)
@@ -1144,22 +1146,39 @@ retry:
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
 
@@ -1187,6 +1206,7 @@ retry:
 		return ret;
 	}
 
+do_uncontended:
 	/*
 	 * We have no kernel internal state, i.e. no waiters in the
 	 * kernel. Waiters which are about to queue themselves are stuck
Index: linux-2.6/kernel/futex/requeue.c
===================================================================
--- linux-2.6.orig/kernel/futex/requeue.c
+++ linux-2.6/kernel/futex/requeue.c
@@ -850,11 +850,13 @@ int futex_wait_requeue_pi(u32 __user *ua
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
