Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61983798AA6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 18:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245098AbjIHQXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 12:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245045AbjIHQXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:23:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E445E1FDB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 09:23:04 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694190183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q8XyPC96iStfUFVrLnHs+IfiJcdMzFSK7KsPSMVSlGo=;
        b=hScGYXwinvNw5TInyfHW8weryumWcKTH5sBs615qtM0EWtOqsvWFjZCoXVNu2lRw9BWCQU
        h934IMuG6DPlGLAZoGiLWMa0W5QF0oh0mr3eISsONyvoE8xx2pr+O7lW4MChUJpzQU0tLo
        1Aowu2g9IvNm1IcvhEoXNE2lYcpQR24zGimPOH1DIDcyEWvnimVSCDV/RTiuP06n7rGmYU
        82/qaOOmVRlG5d5dzY8B4+d6Uwlgj41xcNFxjgRJtWNMcPvuWU2zlt3/ilHTZZpcCtlCGK
        mWOaTTDf1hv1DJPC2PUoA5O3JSPoZyOge7FCfUyZToAOXsNIIEEnhs4Xmkji9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694190183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q8XyPC96iStfUFVrLnHs+IfiJcdMzFSK7KsPSMVSlGo=;
        b=5vIyudG5J1u+lwH7EHsbb52FgVuIIJv0sgowgYcXHGreW9D6/1PCz3z6dTDwy6zvqlIeX1
        GUTTN8kzvLvyOOCQ==
To:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Cc:     bigeasy@linutronix.de, tglx@linutronix.de, boqun.feng@gmail.com,
        bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        jstultz@google.com, juri.lelli@redhat.com, longman@redhat.com,
        mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org,
        swood@redhat.com, vincent.guittot@linaro.org, vschneid@redhat.com,
        will@kernel.org
Subject: [PATCH v3 4/7] sched: Provide rt_mutex specific scheduler helpers
Date:   Fri,  8 Sep 2023 18:22:51 +0200
Message-Id: <20230908162254.999499-5-bigeasy@linutronix.de>
In-Reply-To: <20230908162254.999499-1-bigeasy@linutronix.de>
References: <20230908162254.999499-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Link: https://lore.kernel.org/r/20230825181033.504534-5-bigeasy@linutronix.=
de
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/sched.h    |  3 +++
 include/linux/sched/rt.h |  4 ++++
 kernel/sched/core.c      | 36 ++++++++++++++++++++++++++++++++----
 3 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 77f01ac385f7a..67623ffd4a8ea 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -911,6 +911,9 @@ struct task_struct {
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
index 1ea7ba53aad24..58d0346d1bb3b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6723,9 +6723,6 @@ static inline void sched_submit_work(struct task_stru=
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
@@ -6783,7 +6780,12 @@ asmlinkage __visible void __sched schedule(void)
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
@@ -7044,6 +7046,32 @@ static void __setscheduler_prio(struct task_struct *=
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

