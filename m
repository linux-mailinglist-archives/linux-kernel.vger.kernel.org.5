Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FB278E9CB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 11:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238495AbjHaJx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 05:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbjHaJx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:53:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58595CED
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 02:53:21 -0700 (PDT)
Date:   Thu, 31 Aug 2023 11:53:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693475599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yPBlYtLozkMuEAYxQ7Chu1MKOc7ySAG4sE0hHicbhw8=;
        b=GCIWCYkZDTfjdcptuiNX10YAxvC7YtnSFEVwIK7TI9+08pj4jf0feSnganxn6kHZ0efkdv
        G1j6DgwTn56/87Ljv4uSI4l5pDWDV6jz1fFocR4XzLPDIWvIOvEdk8UiNqy2TOaaORtPwP
        8/vh2wT3275XmlT2BIQKgQp6d4VIUHzIJzydmUEyE3L/QZ3S1FSrSM9pCrmWGdOInun2jj
        WC1CxtQn+t+4f4heoabyBIel1j0tGTIz1hZT2qvVcAA1y0eTQyoW+jW2hznxERJf8GwjRD
        S8bCZ7nnDUur2zlObL12Y58q4IfRcFPYqswEz7zjHpim1NIyd0Ez0G8nHMi3Ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693475599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yPBlYtLozkMuEAYxQ7Chu1MKOc7ySAG4sE0hHicbhw8=;
        b=iUTuPv+i0USKWe/1RSTZ88MVdC4jlSaVPGOkSXR+sTTtCkQCbqtC41PIQl/DeWr1CS+iUN
        SkgtR5dkwyG583Cg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, boqun.feng@gmail.com, bristot@redhat.com,
        bsegall@google.com, dietmar.eggemann@arm.com, jstultz@google.com,
        juri.lelli@redhat.com, longman@redhat.com, mgorman@suse.de,
        mingo@redhat.com, rostedt@goodmis.org, swood@redhat.com,
        vincent.guittot@linaro.org, vschneid@redhat.com, will@kernel.org
Subject: [PATCH v2 7/6] locking/rtmutex: Acquire the hb lock via trylock
 after wait-proxylock.
Message-ID: <20230831095314.fTliy0Bh@linutronix.de>
References: <20230825181033.504534-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230825181033.504534-1-bigeasy@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After rt_mutex_wait_proxy_lock() task_struct::pi_blocked_on is cleared
if current owns the lock. If the operation has been interrupted by a
signal or timeout then pi_blocked_on can be set. This means spin_lock()
*can* overwrite pi_blocked_on on PREEMPT_RT. This has been noticed by
the recently added lockdep-asserts=E2=80=A6

The rt_mutex_cleanup_proxy_lock() operation will clear pi_blocked_on
(and update pending waiters as expected) but it must happen under the hb
lock to ensure the same state in rtmutex and userland.

Given all the possibilities it is probably the simplest option to
try-lock the hb lock. In case the lock is occupied a quick nap is
needed. A busy loop can lock up the system if performed by a task with
high priorioty preventing the owner from running.

The rt_mutex_post_schedule() needs to be put before try-lock-loop
because otherwie the schedule() in schedule_hrtimeout() will trip over
the !sched_rt_mutex assert.

Introduce futex_trylock_hblock() to try-lock the hb lock and sleep until
the try-lock operation succeeds. Use it after rt_mutex_wait_proxy_lock()
to acquire the lock.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
On 2023-08-25 20:10:27 [+0200], To Peter Zijlstra wrote:
> but then why over complicate things. Speaking of over complicating, this
> triggered:
> | ------------[ cut here ]------------
> | WARNING: CPU: 6 PID: 2155 at kernel/locking/spinlock_rt.c:40 rt_spin_lo=
ck+0x5a/0xf0
=E2=80=A6
> Here, rt_mutex_wait_proxy_lock() returned with -EINTR, didn't acquire
> the lock. Later rt_mutex_cleanup_proxy_lock() would clean
> ->pi_blocked_on but that happens after=20
> |                 /* Current is not longer pi_blocked_on */
> |                 spin_lock(q.lock_ptr);

So this seems to do the job. Gross but =E2=80=A6

 kernel/futex/futex.h     | 23 +++++++++++++++++++++++
 kernel/futex/pi.c        | 10 ++++------
 kernel/futex/requeue.c   |  4 ++--
 kernel/locking/rtmutex.c |  7 +++++--
 4 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index b5379c0e6d6d1..b0b2a5b35ae57 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -254,6 +254,29 @@ double_unlock_hb(struct futex_hash_bucket *hb1, struct=
 futex_hash_bucket *hb2)
 		spin_unlock(&hb2->lock);
 }
=20
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
+		chill_time =3D ktime_set(0, NSEC_PER_MSEC);
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_hrtimeout(&chill_time, HRTIMER_MODE_REL_HARD);
+	} while (1);
+}
+
 /* syscalls */
=20
 extern int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags, u32
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index f8e65b27d9d6b..1440fdcdbfd8c 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -1046,7 +1046,10 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int fl=
ags, ktime_t *time, int tryl
 	ret =3D rt_mutex_wait_proxy_lock(&q.pi_state->pi_mutex, to, &rt_waiter);
=20
 cleanup:
-	spin_lock(q.lock_ptr);
+	rt_mutex_post_schedule();
+
+	futex_trylock_hblock(q.lock_ptr);
+
 	/*
 	 * If we failed to acquire the lock (deadlock/signal/timeout), we must
 	 * first acquire the hb->lock before removing the lock from the
@@ -1058,11 +1061,6 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int fl=
ags, ktime_t *time, int tryl
 	 */
 	if (ret && !rt_mutex_cleanup_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter=
))
 		ret =3D 0;
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
@@ -850,8 +850,8 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned i=
nt flags,
 		pi_mutex =3D &q.pi_state->pi_mutex;
 		ret =3D rt_mutex_wait_proxy_lock(pi_mutex, to, &rt_waiter);
=20
-		/* Current is not longer pi_blocked_on */
-		spin_lock(q.lock_ptr);
+		futex_trylock_hblock(q.lock_ptr);
+
 		if (ret && !rt_mutex_cleanup_proxy_lock(pi_mutex, &rt_waiter))
 			ret =3D 0;
=20
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 4a10e8c16fd2b..e56585ef489c8 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1166,10 +1166,13 @@ try_to_take_rt_mutex(struct rt_mutex_base *lock, st=
ruct task_struct *task,
 	 * Clear @task->pi_blocked_on. Requires protection by
 	 * @task->pi_lock. Redundant operation for the @waiter =3D=3D NULL
 	 * case, but conditionals are more expensive than a redundant
-	 * store.
+	 * store. But then there is FUTEX and if rt_mutex_wait_proxy_lock()
+	 * did not acquire the lock it try-locks another lock before it clears
+	 * @task->pi_blocked_on so we mustn't clear it here premature.
 	 */
 	raw_spin_lock(&task->pi_lock);
-	task->pi_blocked_on =3D NULL;
+	if (waiter)
+		task->pi_blocked_on =3D NULL;
 	/*
 	 * Finish the lock acquisition. @task is the new owner. If
 	 * other waiters exist we have to insert the highest priority
--=20
2.40.1

