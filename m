Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBA078DFE3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344210AbjH3T0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343976AbjH3Rn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:43:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5EB193;
        Wed, 30 Aug 2023 10:43:23 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UHPrGN029416;
        Wed, 30 Aug 2023 17:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : to : cc; s=qcppdkim1;
 bh=IZSrzbGR9cZTjeBSUQFtxp25FFCArycqdlPnbZn4g9A=;
 b=Fo/ypPNhTOFmkoAW90GY7tv5M1rEJs8NApA5kymphv93JnLeaOCZDbiwFrHPjPUJKmfp
 vVKYP/z298SGclrf41aQW//b7T0FPR4PQXi63ZniSkZD03apW57zYRlrwqbM08K/4oz9
 SLUnMFY9sjiP0ynAQfYRAfuVhOpzWmzS2xhdP6e8lVX/KBkQ0nchqhB/f8lwyG0Ozukd
 HVAZDVYNADW18VMdEiPdZTWsvrN3Ky9ONbva+jckBXdyCodYLN3XuEe61twXosY2uXrQ
 Trp2BkoGNjGHTILJ30ZSDcv+PMO4nqJXGYGUyQz68htcQwylggSSuB0KRnsyRr9ksBWz pw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ssy5q1ahj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 17:43:03 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37UHh21R001331
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 17:43:02 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 30 Aug 2023 10:42:59 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
Date:   Wed, 30 Aug 2023 10:42:39 -0700
Subject: [PATCH v2] freezer,sched: Use saved_state to reduce some spurious
 wakeups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230830-avoid-spurious-freezer-wakeups-v2-1-8877245cdbdc@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAI5/72QC/4WOzRKCIBRGX6Vh3W0EG8VWvUfjAvCadzIwCPpxf
 PfIad/ynMV3vpkF9ISBHTYz85gokLMZxHbDzKDsGYG6zEwUoiwkr0ElRx2EKXpyMUDvEd/o4aE
 uGKcATS8r3lSy0KVieUSrgKC9smbIMzaOY5aTx56ea/XUZh4o3J1/rScS/9pfT8h/vcSBg9QoT
 V9XfF+L4y2SIWt2xl1ZuyzLB2VXPwvjAAAA
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>
CC:     Thomas Gleixner <tglx@linutronix.de>, <kernel@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Prakash Viswalingam <quic_prakashv@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>
X-Mailer: b4 0.13-dev
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: POIg2uDqKKX59CPkPXmRS6q-VcIsbPJt
X-Proofpoint-GUID: POIg2uDqKKX59CPkPXmRS6q-VcIsbPJt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_14,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300163
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit f5d39b020809 ("freezer,sched: Rewrite core freezer logic"),
tasks that transition directly from TASK_FREEZABLE to TASK_FROZEN  are
always woken up on the thaw path. Prior to that commit, tasks could ask
freezer to consider them "frozen enough" via freezer_do_not_count(). The
commit replaced freezer_do_not_count() with a TASK_FREEZABLE state which
allows freezer to immediately mark the task as TASK_FROZEN without
waking up the task.  This is efficient for the suspend path, but on the
thaw path, the task is always woken up even if the task didn't need to
wake up and goes back to its TASK_(UN)INTERRUPTIBLE state. Although
these tasks are capable of handling of the wakeup, we can observe a
power/perf impact from the extra wakeup.

We observed on Android many tasks wait in the TASK_FREEZABLE state
(particularly due to many of them being binder clients). We observed
nearly 4x the number of tasks and a corresponding linear increase in
latency and power consumption when thawing the system. The latency
increased from ~15ms to ~50ms.

Avoid the spurious wakeups by saving the state of TASK_FREEZABLE tasks.
If the task was running before entering TASK_FROZEN state
(__refrigerator()) or if the task received a wake up for the saved
state, then the task is woken on thaw. saved_state from PREEMPT_RT locks
can be re-used because freezer would not stomp on the rtlock wait flow:
TASK_RTLOCK_WAIT isn't considered freezable.

Reported-by: Prakash Viswalingam <quic_prakashv@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
For testing purposes, I use these commands can help see how many tasks were
woken during thawing:

1. Setup:
   mkdir /sys/kernel/tracing/instances/freezer
   cd /sys/kernel/tracing/instances/freezer 
   echo 0 > tracing_on ; echo > trace
   echo power:suspend_resume > set_event
   echo 'enable_event:sched:sched_wakeup if action == "thaw_processes" && start == 1' > events/power/suspend_resume/trigger
   echo 'traceoff if action == "thaw_processes" && start == 0' > events/power/suspend_resume/trigger
   echo 1 > tracing_on

2. Let kernel go to suspend

3. After kernel's back up:
   cat /sys/kernel/tracing/instances/freezer/trace | grep sched_wakeup | grep -o "pid=[0-9]*" | sort -u | wc -l
---
Changes in v2:
- Rebase to v6.5 which includes commit 1c06918788e8 ("sched: Consider task_struct::saved_state in wait_task_inactive()")
  This allows us to remove the special jobctl handling on thaw.
- Link to v1: https://lore.kernel.org/r/20230828-avoid-spurious-freezer-wakeups-v1-1-8be8cf761472@quicinc.com
---
 include/linux/sched.h |  4 ++--
 kernel/freezer.c      | 41 +++++++++++++++++++----------------------
 kernel/sched/core.c   | 29 +++++++++++++++++------------
 3 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 609bde814cb0..33124daa8f5e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -745,8 +745,8 @@ struct task_struct {
 #endif
 	unsigned int			__state;
 
-#ifdef CONFIG_PREEMPT_RT
-	/* saved state for "spinlock sleepers" */
+#if IS_ENABLED(CONFIG_PREEMPT_RT) || IS_ENABLED(CONFIG_FREEZER)
+	/* saved state for "spinlock sleepers" and freezer */
 	unsigned int			saved_state;
 #endif
 
diff --git a/kernel/freezer.c b/kernel/freezer.c
index 4fad0e6fca64..c450fa8b8b5e 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -71,7 +71,11 @@ bool __refrigerator(bool check_kthr_stop)
 	for (;;) {
 		bool freeze;
 
+		raw_spin_lock_irq(&current->pi_lock);
 		set_current_state(TASK_FROZEN);
+		/* unstale saved_state so that __thaw_task() will wake us up */
+		current->saved_state = TASK_RUNNING;
+		raw_spin_unlock_irq(&current->pi_lock);
 
 		spin_lock_irq(&freezer_lock);
 		freeze = freezing(current) && !(check_kthr_stop && kthread_should_stop());
@@ -129,6 +133,7 @@ static int __set_task_frozen(struct task_struct *p, void *arg)
 		WARN_ON_ONCE(debug_locks && p->lockdep_depth);
 #endif
 
+	p->saved_state = p->__state;
 	WRITE_ONCE(p->__state, TASK_FROZEN);
 	return TASK_FROZEN;
 }
@@ -170,42 +175,34 @@ bool freeze_task(struct task_struct *p)
 }
 
 /*
- * The special task states (TASK_STOPPED, TASK_TRACED) keep their canonical
- * state in p->jobctl. If either of them got a wakeup that was missed because
- * TASK_FROZEN, then their canonical state reflects that and the below will
- * refuse to restore the special state and instead issue the wakeup.
+ * Restore the saved_state before the task entered freezer. For typical task
+ * in the __refrigerator(), saved_state == TASK_RUNNING so nothing happens
+ * here. For tasks which were TASK_NORMAL | TASK_FREEZABLE, their initial state
+ * is restored unless they got an expected wakeup (see ttwu_state_match()).
+ * Returns 1 if the task state was restored.
  */
-static int __set_task_special(struct task_struct *p, void *arg)
+static int __restore_freezer_state(struct task_struct *p, void *arg)
 {
-	unsigned int state = 0;
+	unsigned int state = p->saved_state;
 
-	if (p->jobctl & JOBCTL_TRACED)
-		state = TASK_TRACED;
-
-	else if (p->jobctl & JOBCTL_STOPPED)
-		state = TASK_STOPPED;
-
-	if (state)
+	if (state != TASK_RUNNING) {
 		WRITE_ONCE(p->__state, state);
+		return 1;
+	}
 
-	return state;
+	return 0;
 }
 
 void __thaw_task(struct task_struct *p)
 {
-	unsigned long flags, flags2;
+	unsigned long flags;
 
 	spin_lock_irqsave(&freezer_lock, flags);
 	if (WARN_ON_ONCE(freezing(p)))
 		goto unlock;
 
-	if (lock_task_sighand(p, &flags2)) {
-		/* TASK_FROZEN -> TASK_{STOPPED,TRACED} */
-		bool ret = task_call_func(p, __set_task_special, NULL);
-		unlock_task_sighand(p, &flags2);
-		if (ret)
-			goto unlock;
-	}
+	if (task_call_func(p, __restore_freezer_state, NULL))
+		goto unlock;
 
 	wake_up_state(p, TASK_FROZEN);
 unlock:
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c52c2eba7c73..085624e3098d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2219,7 +2219,7 @@ int __task_state_match(struct task_struct *p, unsigned int state)
 	if (READ_ONCE(p->__state) & state)
 		return 1;
 
-#ifdef CONFIG_PREEMPT_RT
+#if IS_ENABLED(CONFIG_PREEMPT_RT) || IS_ENABLED(CONFIG_FREEZER)
 	if (READ_ONCE(p->saved_state) & state)
 		return -1;
 #endif
@@ -2229,12 +2229,12 @@ int __task_state_match(struct task_struct *p, unsigned int state)
 static __always_inline
 int task_state_match(struct task_struct *p, unsigned int state)
 {
-#ifdef CONFIG_PREEMPT_RT
+#if IS_ENABLED(CONFIG_PREEMPT_RT) || IS_ENABLED(CONFIG_FREEZER)
 	int match;
 
 	/*
-	 * Serialize against current_save_and_set_rtlock_wait_state() and
-	 * current_restore_rtlock_saved_state().
+	 * Serialize against current_save_and_set_rtlock_wait_state(),
+	 * current_restore_rtlock_saved_state(), and __refrigerator().
 	 */
 	raw_spin_lock_irq(&p->pi_lock);
 	match = __task_state_match(p, state);
@@ -4033,13 +4033,17 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
  * The caller holds p::pi_lock if p != current or has preemption
  * disabled when p == current.
  *
- * The rules of PREEMPT_RT saved_state:
+ * The rules of saved_state:
  *
  *   The related locking code always holds p::pi_lock when updating
  *   p::saved_state, which means the code is fully serialized in both cases.
  *
- *   The lock wait and lock wakeups happen via TASK_RTLOCK_WAIT. No other
- *   bits set. This allows to distinguish all wakeup scenarios.
+ *   For PREEMPT_RT, the lock wait and lock wakeups happen via TASK_RTLOCK_WAIT.
+ *   No other bits set. This allows to distinguish all wakeup scenarios.
+ *
+ *   For FREEZER, the wakeup happens via TASK_FROZEN. No other bits set. This
+ *   allows us to prevent early wakeup of tasks before they can be run on
+ *   asymmetric ISA architectures (eg ARMv9).
  */
 static __always_inline
 bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
@@ -4053,13 +4057,14 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
 
 	*success = !!(match = __task_state_match(p, state));
 
-#ifdef CONFIG_PREEMPT_RT
+#if IS_ENABLED(CONFIG_PREEMPT_RT) || IS_ENABLED(CONFIG_FREEZER)
 	/*
 	 * Saved state preserves the task state across blocking on
-	 * an RT lock.  If the state matches, set p::saved_state to
-	 * TASK_RUNNING, but do not wake the task because it waits
-	 * for a lock wakeup. Also indicate success because from
-	 * the regular waker's point of view this has succeeded.
+	 * an RT lock or TASK_FREEZABLE tasks.  If the state matches,
+	 * set p::saved_state to TASK_RUNNING, but do not wake the task
+	 * because it waits for a lock wakeup or __thaw_task(). Also
+	 * indicate success because from the regular waker's point of
+	 * view this has succeeded.
 	 *
 	 * After acquiring the lock the task will restore p::__state
 	 * from p::saved_state which ensures that the regular

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230817-avoid-spurious-freezer-wakeups-9f8619680b3a

Best regards,
-- 
Elliot Berman <quic_eberman@quicinc.com>

