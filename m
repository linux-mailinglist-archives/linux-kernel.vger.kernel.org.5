Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17B6788E47
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjHYSK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjHYSKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:10:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10B81BF6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:10:38 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692987037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sEiDarfZytMC81gX6rswyLHInvaAEer86wNzf/7j3Cc=;
        b=hyUbF/41PoElNtCIj72ODJ8T/ojWzWa3y77DHNpp9SO8nIhkcfr9oVg5JG5LSM7MfO88Xy
        8K5Aa/grJG/Tc2CtWAi/NQPkeSzI7hmX01NvP/sFdr5i7gnfq81XHu3ajkz0Ld/H9uL/0L
        ydVglCWtDEWXYlt1tlpwGJJIXvRFCSGoocJxUm9E8Ofp7F8Y5CK79VKzDwcYBq6i2zuOZ+
        L6jCDa6KK9P8dEkfA6TrUMsw7detJ6fwZVF2+cECIgKFJTsahS5ApsYzpZDLGfxoJOwm4J
        rz9ZDp1Qd8rtLXdbTCkjcCbVakGyrXt6dLPSiV5bEVH/qb3Z823qF5+9uUdJpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692987037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sEiDarfZytMC81gX6rswyLHInvaAEer86wNzf/7j3Cc=;
        b=DAgnOvWzMK303tKGW0aokfPjKZXPlOBp1JwPQKYaMKsffmONNKm729XLfQUIVHkTA3ShtV
        /FIo0YZn8dE/hNCg==
To:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Cc:     bigeasy@linutronix.de, tglx@linutronix.de, boqun.feng@gmail.com,
        bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        jstultz@google.com, juri.lelli@redhat.com, longman@redhat.com,
        mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org,
        swood@redhat.com, vincent.guittot@linaro.org, vschneid@redhat.com,
        will@kernel.org
Subject: [PATCH v2 4/6] sched: Provide rt_mutex specific scheduler helpers
Date:   Fri, 25 Aug 2023 20:10:31 +0200
Message-Id: <20230825181033.504534-5-bigeasy@linutronix.de>
In-Reply-To: <20230825181033.504534-1-bigeasy@linutronix.de>
References: <20230825181033.504534-1-bigeasy@linutronix.de>
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

From: Peter Zijlstra <peterz@infradead.org>

With PREEMPT_RT there is a rt_mutex recursion problem where
sched_submit_work() can use an rtlock (aka spinlock_t). More
specifically what happens is:

  mutex_lock() /* really rt_mutex */
    ...
      __rt_mutex_slowlock_locked()
	task_blocks_on_rt_mutex()
          // enqueue current task as waiter
          // do PI chain walk
        rt_mutex_slowlock_block()
          schedule()
            sched_submit_work()
              ...
              spin_lock() /* really rtlock */
                ...
                  __rt_mutex_slowlock_locked()
                    task_blocks_on_rt_mutex()
                      // enqueue current task as waiter *AGAIN*
                      // *CONFUSION*

Fix this by making rt_mutex do the sched_submit_work() early, before
it enqueues itself as a waiter -- before it even knows *if* it will
wait.

[[ basically Thomas' patch but with different naming and a few asserts
   added ]]

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230815111430.355375399@infradead.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/sched.h    |  3 +++
 include/linux/sched/rt.h |  4 ++++
 kernel/sched/core.c      | 36 ++++++++++++++++++++++++++++++++----
 3 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 609bde814cb06..0ea7a023c6c73 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -906,6 +906,9 @@ struct task_struct {
 	 * ->sched_remote_wakeup gets used, so it can be in this word.
 	 */
 	unsigned			sched_remote_wakeup:1;
+#ifdef CONFIG_RT_MUTEXES
+	unsigned			sched_rt_mutex:1;
+#endif
=20
 	/* Bit to tell LSMs we're in execve(): */
 	unsigned			in_execve:1;
diff --git a/include/linux/sched/rt.h b/include/linux/sched/rt.h
index 994c25640e156..b2b9e6eb96830 100644
--- a/include/linux/sched/rt.h
+++ b/include/linux/sched/rt.h
@@ -30,6 +30,10 @@ static inline bool task_is_realtime(struct task_struct *=
tsk)
 }
=20
 #ifdef CONFIG_RT_MUTEXES
+extern void rt_mutex_pre_schedule(void);
+extern void rt_mutex_schedule(void);
+extern void rt_mutex_post_schedule(void);
+
 /*
  * Must hold either p->pi_lock or task_rq(p)->lock.
  */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 901766a88afc3..bba1ed28608ab 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6738,9 +6738,6 @@ static inline void sched_submit_work(struct task_stru=
ct *tsk)
 	static DEFINE_WAIT_OVERRIDE_MAP(sched_map, LD_WAIT_CONFIG);
 	unsigned int task_flags;
=20
-	if (task_is_running(tsk))
-		return;
-
 	/*
 	 * Establish LD_WAIT_CONFIG context to ensure none of the code called
 	 * will use a blocking primitive -- which would lead to recursion.
@@ -6798,7 +6795,12 @@ asmlinkage __visible void __sched schedule(void)
 {
 	struct task_struct *tsk =3D current;
=20
-	sched_submit_work(tsk);
+#ifdef CONFIG_RT_MUTEXES
+	lockdep_assert(!tsk->sched_rt_mutex);
+#endif
+
+	if (!task_is_running(tsk))
+		sched_submit_work(tsk);
 	__schedule_loop(SM_NONE);
 	sched_update_worker(tsk);
 }
@@ -7059,6 +7061,32 @@ static void __setscheduler_prio(struct task_struct *=
p, int prio)
=20
 #ifdef CONFIG_RT_MUTEXES
=20
+/*
+ * Would be more useful with typeof()/auto_type but they don't mix with
+ * bit-fields. Since it's a local thing, use int. Keep the generic sounding
+ * name such that if someone were to implement this function we get to com=
pare
+ * notes.
+ */
+#define fetch_and_set(x, v) ({ int _x =3D (x); (x) =3D (v); _x; })
+
+void rt_mutex_pre_schedule(void)
+{
+	lockdep_assert(!fetch_and_set(current->sched_rt_mutex, 1));
+	sched_submit_work(current);
+}
+
+void rt_mutex_schedule(void)
+{
+	lockdep_assert(current->sched_rt_mutex);
+	__schedule_loop(SM_NONE);
+}
+
+void rt_mutex_post_schedule(void)
+{
+	sched_update_worker(current);
+	lockdep_assert(fetch_and_set(current->sched_rt_mutex, 0));
+}
+
 static inline int __rt_effective_prio(struct task_struct *pi_task, int pri=
o)
 {
 	if (pi_task)
--=20
2.40.1

