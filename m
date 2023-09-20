Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752807A7448
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbjITHgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbjITHgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:36:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E729E;
        Wed, 20 Sep 2023 00:36:12 -0700 (PDT)
Date:   Wed, 20 Sep 2023 07:36:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695195371;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IfjCkGSUzZIAS5GF7Q7Yq7fEldgU3hvl4AditqhqRTk=;
        b=XJG3bTnasZIAcGpZrUrL+xSyDMeYWnqp5NfP3B1mxzRqCSA/XomvZA9+2pHzWdK8Pm96u9
        NfhEhBlbiXiNg88ng3uZFg3VF4llLHkbM8tN+AepSBe1ntFa2hZTDu7t3DSRAkZW1ZpeY5
        cWNbYMh/3ZXhUvIDIBJLJxekyrNzjtdyCQuwaIw1X4YEGjTbcMWbB0W85FVgJRAUle0McO
        6D2XJq7VlXQGWcoAH1feo+spoUuuMYBLc5CQW6F3JsdNnQ1xqJLurh0NLzvfQtlPd6/lwZ
        wlU9I+PIY1QVEZLa4Tm0n1c3/vpf//Gb8NFFrrj5JKz8dKX5xUTxzrO2XQUWSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695195371;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IfjCkGSUzZIAS5GF7Q7Yq7fEldgU3hvl4AditqhqRTk=;
        b=Nf1exM4X1NFZGzqjtuwbUCpKiFPT+oxsby/Q3KsNzLAWyrEmZ8Lx8tDccdXHmtc40OmWEW
        o2KIgDPnCH0VWoAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] sched: Provide rt_mutex specific scheduler helpers
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230908162254.999499-5-bigeasy@linutronix.de>
References: <20230908162254.999499-5-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <169519537073.27769.17755473188215858233.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     6b596e62ed9f90c4a97e68ae1f7b1af5beeb3c05
Gitweb:        https://git.kernel.org/tip/6b596e62ed9f90c4a97e68ae1f7b1af5beeb3c05
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 08 Sep 2023 18:22:51 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 20 Sep 2023 09:31:12 +02:00

sched: Provide rt_mutex specific scheduler helpers

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230908162254.999499-5-bigeasy@linutronix.de
---
 include/linux/sched.h    |  3 +++
 include/linux/sched/rt.h |  4 ++++
 kernel/sched/core.c      | 36 ++++++++++++++++++++++++++++++++----
 3 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 77f01ac..67623ff 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -911,6 +911,9 @@ struct task_struct {
 	 * ->sched_remote_wakeup gets used, so it can be in this word.
 	 */
 	unsigned			sched_remote_wakeup:1;
+#ifdef CONFIG_RT_MUTEXES
+	unsigned			sched_rt_mutex:1;
+#endif
 
 	/* Bit to tell LSMs we're in execve(): */
 	unsigned			in_execve:1;
diff --git a/include/linux/sched/rt.h b/include/linux/sched/rt.h
index 994c256..b2b9e6e 100644
--- a/include/linux/sched/rt.h
+++ b/include/linux/sched/rt.h
@@ -30,6 +30,10 @@ static inline bool task_is_realtime(struct task_struct *tsk)
 }
 
 #ifdef CONFIG_RT_MUTEXES
+extern void rt_mutex_pre_schedule(void);
+extern void rt_mutex_schedule(void);
+extern void rt_mutex_post_schedule(void);
+
 /*
  * Must hold either p->pi_lock or task_rq(p)->lock.
  */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1ea7ba5..58d0346 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6723,9 +6723,6 @@ static inline void sched_submit_work(struct task_struct *tsk)
 	static DEFINE_WAIT_OVERRIDE_MAP(sched_map, LD_WAIT_CONFIG);
 	unsigned int task_flags;
 
-	if (task_is_running(tsk))
-		return;
-
 	/*
 	 * Establish LD_WAIT_CONFIG context to ensure none of the code called
 	 * will use a blocking primitive -- which would lead to recursion.
@@ -6783,7 +6780,12 @@ asmlinkage __visible void __sched schedule(void)
 {
 	struct task_struct *tsk = current;
 
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
@@ -7044,6 +7046,32 @@ static void __setscheduler_prio(struct task_struct *p, int prio)
 
 #ifdef CONFIG_RT_MUTEXES
 
+/*
+ * Would be more useful with typeof()/auto_type but they don't mix with
+ * bit-fields. Since it's a local thing, use int. Keep the generic sounding
+ * name such that if someone were to implement this function we get to compare
+ * notes.
+ */
+#define fetch_and_set(x, v) ({ int _x = (x); (x) = (v); _x; })
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
 static inline int __rt_effective_prio(struct task_struct *pi_task, int prio)
 {
 	if (pi_task)
