Return-Path: <linux-kernel+bounces-27402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B2D82EF6D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582631F24536
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122D61BC47;
	Tue, 16 Jan 2024 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dgQic6M3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ns4pw93v"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952C61BC3D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 16 Jan 2024 14:08:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705410492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Hds+0E3T4arkZ9lBM0loh4N8FIyDQ2ciNFdxXV0wwtc=;
	b=dgQic6M3LvAMmzybD231KuQjHHvtjawxl63BNJ3bNnBIQLSOFSNoklk01mFHvoskZjDDRF
	xNqHKobeE2byZRXpyzNiiqwdaxDs8fcsm1kUsX2U1J158HGWrVJL89vyIUy5NZzVkRJboc
	CPzjU9zk1CdurSSQdtb951f2UUd1uMHHCbwZvCjh6tUM3eYlGTAb5d6mCIHsfJeRwiWjxs
	jH/nXe7P6LTWGaMNcY8l2lb+TDgT3Ij2UJo3u/AWFNVzoioh7MIZrWpHoHIZipapLoZ81h
	Z2WAJ35kw4H/LSXUiMFi+QPGYxnM5tfj0stm3DNbvfQpxTdWalkM2i+jN25Vpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705410492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Hds+0E3T4arkZ9lBM0loh4N8FIyDQ2ciNFdxXV0wwtc=;
	b=ns4pw93vAKswCCXW+4jBrTYb63wwtJt3NxiXOJajejUqaq58mbrjVAtt6ozM99tq7prssF
	8otUcv5Ug0mzynBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jiri Slaby <jirislaby@kernel.org>, Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, boqun.feng@gmail.com, bristot@redhat.com,
	bsegall@google.com, dietmar.eggemann@arm.com, jstultz@google.com,
	juri.lelli@redhat.com, longman@redhat.com, mgorman@suse.de,
	mingo@redhat.com, rostedt@goodmis.org, swood@redhat.com,
	vincent.guittot@linaro.org, vschneid@redhat.com, will@kernel.org
Subject: [PATCH] futex: Avoid reusing outdated pi_state.
Message-ID: <20240116130810.ji1YCxpg@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Jiri Slaby reported a futex state inconsistency resulting in -EINVAL
during a lock operation for a PI futex. A requirement is that the lock
process is interrupted by a timeout or signal:

T1		T2
*owns* futex
		futex_lock_pi()
            	*create PI state, attach to it, queue RT waiter*
		rt_mutex_wait_proxy_lock() /* -ETIMEDOUT */
		rt_mutex_cleanup_proxy_lock()
		  remove_waiter()

futex_unlock_pi()
spin_lock(&hb->lock);
top_waiter = futex_top_waiter(hb, &key);
/* top_waiter is NULL, do_uncontended */
spin_unlock(&hb->lock);

To spice things up, player T3 and T4 enter the game:

	T3 			T4
	*acquires futex in userland*
				futex_lock_pi()
				futex_q_lock(&q);
				futex_lock_pi_atomic()
				top_waiter = futex_top_waiter(hb, key);
				/* top_waiter is from T1, still */
				attach_to_pi_state()
				/* Here -EINVAL is returned because uval
				 *  points to T3 but pi_state says T1.
				 */

We must not unlock the futex for userland as long as there is still a
state pending in kernel. It can be used by further futex_lock_pi()
caller (as it has been observed by futex_unlock_pi()). The caller will
observe an outdated state of the futex because it was not removed during
unlock operation in kernel.

The lock can not be handed over to T1 because it already gave up and
stared to clean up.
All futex_q entries point to the same pi_state and the pi_mutex has no
waiters. A waiter can not be enqueued because hb->lock +
pi_mutex.wait_lock is acquired (by the unlock operation) and the same
ordering is used by futex_lock_pi() during locking.

Remove all futex_q entries from the hb list which point to the futex if
no waiter has been observed. This closes the race window by removing all
pointer to the previous in-kernel state.
The leaving futex_lock_pi() caller can clean up the pi-state once it
acquires hb->lock. The following futex_lock_pi() caller will create a
new in-kernel state.
The optional removal from hb->chain is only needed if the futex was not
acquired because it might have been done by the unlock path with
hb->lock acquired.

Fixes: fbeb558b0dd0d ("futex/pi: Fix recursive rt_mutex waiter state")
Reported-by: Jiri Slaby <jirislaby@kernel.org>
Closes: c737a604-d441-49c6-a5cd-ef01e9f2a454@kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex/core.c    |  9 +++++++--
 kernel/futex/futex.h   |  2 +-
 kernel/futex/pi.c      | 11 +++++++----
 kernel/futex/requeue.c |  2 +-
 4 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index dad981a865b84..31505b0a405ae 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -628,10 +628,15 @@ int futex_unqueue(struct futex_q *q)
 /*
  * PI futexes can not be requeued and must remove themselves from the
  * hash bucket. The hash bucket lock (i.e. lock_ptr) is held.
+ * If the PI futex was not acquired (due to timeout or signal) then it removes
+ * its rt_waiter before it removes itself from the futex queue. The unlocker
+ * will remove the futex_q from the queue if it observes an empty waitqueue.
+ * Therefore the unqueue is optional in this case.
  */
-void futex_unqueue_pi(struct futex_q *q)
+void futex_unqueue_pi(struct futex_q *q, bool have_lock)
 {
-	__futex_unqueue(q);
+	if (have_lock || !plist_node_empty(&q->list))
+		__futex_unqueue(q);
 
 	BUG_ON(!q->pi_state);
 	put_pi_state(q->pi_state);
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 8b195d06f4e8e..c7133ffb381fd 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -252,7 +252,7 @@ static inline void futex_queue(struct futex_q *q, struct futex_hash_bucket *hb)
 	spin_unlock(&hb->lock);
 }
 
-extern void futex_unqueue_pi(struct futex_q *q);
+extern void futex_unqueue_pi(struct futex_q *q, bool have_lock);
 
 extern void wait_for_owner_exiting(int ret, struct task_struct *exiting);
 
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index 90e5197f4e569..4023841358eea 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -1070,6 +1070,7 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int tryl
 	 * haven't already.
 	 */
 	res = fixup_pi_owner(uaddr, &q, !ret);
+	futex_unqueue_pi(&q, !ret);
 	/*
 	 * If fixup_pi_owner() returned an error, propagate that.  If it acquired
 	 * the lock, clear our -ETIMEDOUT or -EINTR.
@@ -1077,7 +1078,6 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int tryl
 	if (res)
 		ret = (res < 0) ? res : 0;
 
-	futex_unqueue_pi(&q);
 	spin_unlock(q.lock_ptr);
 	goto out;
 
@@ -1135,6 +1135,7 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 
 	hb = futex_hash(&key);
 	spin_lock(&hb->lock);
+retry_hb:
 
 	/*
 	 * Check waiters first. We do not trust user space values at
@@ -1177,12 +1178,15 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 		/*
 		 * Futex vs rt_mutex waiter state -- if there are no rt_mutex
 		 * waiters even though futex thinks there are, then the waiter
-		 * is leaving and the uncontended path is safe to take.
+		 * is leaving. We need to remove it from the list so that the
+		 * current PI-state is not observed by future pi_futex_lock()
+		 * caller before the leaving waiter had a chance to clean up.
 		 */
 		rt_waiter = rt_mutex_top_waiter(&pi_state->pi_mutex);
 		if (!rt_waiter) {
+			__futex_unqueue(top_waiter);
 			raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
-			goto do_uncontended;
+			goto retry_hb;
 		}
 
 		get_pi_state(pi_state);
@@ -1217,7 +1221,6 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 		return ret;
 	}
 
-do_uncontended:
 	/*
 	 * We have no kernel internal state, i.e. no waiters in the
 	 * kernel. Waiters which are about to queue themselves are stuck
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index eb21f065816ba..57869ef20bda3 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -873,7 +873,7 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		if (res)
 			ret = (res < 0) ? res : 0;
 
-		futex_unqueue_pi(&q);
+		futex_unqueue_pi(&q, true);
 		spin_unlock(q.lock_ptr);
 
 		if (ret == -EINTR) {
-- 
2.43.0


