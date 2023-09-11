Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C35679ACA0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238190AbjIKUxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239107AbjIKOL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:11:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8456CD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=OEhNaVtuTTgc8nwhAYPeuFShLZ+1PP6rC+Ya8+zdK3M=; b=B1g4ByoyoYM1sfdWj5JXLrXSgl
        Xbr7C/CdVj4vwYMtVb9+NHS6YagDkbHEzAyUQnqeZtqQl/LJtty0VxxEVELx5VFjqAaC1+U45E9hv
        Vaaw1Rf+68wuRcLyHcSdvJmV2B1Vv/QJiaf2PCjnyelhmRcs1MPKd0HQrhfi1Z5JBxw9YFNMwq0+G
        P5vlkIqJf3KFlTlec6nd7GuwUujBiioRt+dcflq0RadqUvUoFuv9tSaWJxi+FRlOXSBg3hqIe7Nxt
        TaSvyngrFCk7JO/q8o5BH36rDNp5srraWQVeK/p8ZX+2hyOcZUbEYSq93fy69SDzm77e8E0plz68x
        9vn7/P8A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qfhdW-0052Bn-10;
        Mon, 11 Sep 2023 14:11:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 676233005B2; Mon, 11 Sep 2023 16:11:35 +0200 (CEST)
Date:   Mon, 11 Sep 2023 16:11:35 +0200
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
Message-ID: <20230911141135.GB9098@noisy.programming.kicks-ass.net>
References: <20230908162254.999499-1-bigeasy@linutronix.de>
 <20230908162254.999499-8-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230908162254.999499-8-bigeasy@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Aside from this being just plain gross, this also destroys determinism
of futex_pi, which completely defeats the purpose of the whole thing.


Now.. the reason we need hb->lock at this point is to avoid the
wake_futex_pi() -EAGAIN case.

This happens when futex_top_waiter() and rt_mutex_top_waiter() state
becomes inconsistent. The current rules are such that this inconsistency
will not be observed.

Notably the case that needs to be avoided is where futex_lock_pi() and
futex_unlock_pi() interleave such that unlock will fail to observe a new
waiter.

*However* the case at hand is where a waiter is leaving, in this case
what happens is that we'll fail to observe a waiter that is already
gone, which is harmless afaict.

Would not something like the below work instead?

---
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index ce2889f12375..8c76a52da9bd 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -610,29 +610,16 @@ int futex_lock_pi_atomic(u32 __user *uaddr, struct futex_hash_bucket *hb,
 /*
  * Caller must hold a reference on @pi_state.
  */
-static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_state)
+static int wake_futex_pi(u32 __user *uaddr, u32 uval,
+			 struct futex_pi_state *pi_state,
+			 rt_mutex_waiter *top_waiter)
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
@@ -1039,19 +1026,27 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int tryl
 	ret = rt_mutex_wait_proxy_lock(&q.pi_state->pi_mutex, to, &rt_waiter);
 
 cleanup:
-	spin_lock(q.lock_ptr);
 	/*
 	 * If we failed to acquire the lock (deadlock/signal/timeout), we must
 	 * first acquire the hb->lock before removing the lock from the
 	 * rt_mutex waitqueue, such that we can keep the hb and rt_mutex wait
 	 * lists consistent.
 	 *
-	 * In particular; it is important that futex_unlock_pi() can not
-	 * observe this inconsistency.
+	 * Cannot hold hb->lock because rt_mutex already has a waiter enqueued
+	 * and hb->lock can itself try and enqueue an rt_waiter through rtlock.
+	 *
+	 * Doing the cleanup without holding hb->lock can cause inconsistent
+	 * state between hb and pi_state, but only in the direction of seeing a
+	 * waiter that is leaving.
 	 */
 	if (ret && !rt_mutex_cleanup_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter))
 		ret = 0;
 
+	/*
+	 * Now that the rt_waiter has been dequeued, it is safe to use
+	 * spinlock/rtlock, which will enqueue a new rt_waiter.
+	 */
+	spin_lock(q.lock_ptr);
 no_block:
 	/*
 	 * Fixup the pi_state owner and possibly acquire the lock if we
@@ -1132,6 +1127,7 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 	top_waiter = futex_top_waiter(hb, &key);
 	if (top_waiter) {
 		struct futex_pi_state *pi_state = top_waiter->pi_state;
+		struct rt_mutex_waiter *rt_waiter;
 
 		ret = -EINVAL;
 		if (!pi_state)
@@ -1147,19 +1143,34 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 		get_pi_state(pi_state);
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
+		 * Futex vs rt_mutex waiter state -- if there are on rt_mutex
+		 * waiters even though futex thinkgs there are, then the waiter
+		 * is leaving and the uncontended path is safe to take.
+		 */
+		rt_waiter = rt_mutex_top_waiter(&pi_state->pi_mutex);
+		if (!rt_waiter)
+			goto do_uncontended;
+
 		spin_unlock(&hb->lock);
 
 		/* drops pi_state->pi_mutex.wait_lock */
-		ret = wake_futex_pi(uaddr, uval, pi_state);
+		ret = wake_futex_pi(uaddr, uval, pi_state, rt_waiter);
 
 		put_pi_state(pi_state);
 
@@ -1187,6 +1198,7 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 		return ret;
 	}
 
+do_uncontended:
 	/*
 	 * We have no kernel internal state, i.e. no waiters in the
 	 * kernel. Waiters which are about to queue themselves are stuck

