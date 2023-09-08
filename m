Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CF8799276
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 00:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344463AbjIHWvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 18:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344415AbjIHWvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 18:51:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD991FEB;
        Fri,  8 Sep 2023 15:50:57 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388Mcsiu011303;
        Fri, 8 Sep 2023 22:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=bs7FO/jLfKZR5eJqufatrmjM1HtZcwMoltAhdaNuRtM=;
 b=eTsUP2Kq3Vz6sY/ymnXAsr+NWsnb1z66whmPjz47+pP7CVwLens4WU8ZFRu+cewo2pGs
 XiD922yjRny2a0lfjB4CC7mNlbj3gnc6mVem7SFUvNCdACwpfsnJU9ncp7L6vQLdspJW
 fHk1s4fSWff788Ig+wIXo8bJqKz3OkqURD+mc3mvwi9baL/7Vzhs6w2jcOq5hzl+zk+3
 L1b0FuPPYDKkl5hybUnXeolkA0qLNSL0DtGbo99jiDoK2OY6NMIeNcXX47Fh+AehfF03
 h1wGzrSJL0ZaHvSMIzylUT//KjVP0b52FP2aTzKsxtFUzvnNaFCxN3z8wZ//ZlVOI1SZ QQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3synyqawdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 22:50:43 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 388MogOS000727
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 22:50:42 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 8 Sep 2023 15:50:39 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
Date:   Fri, 8 Sep 2023 15:49:16 -0700
Subject: [PATCH v4 2/2] freezer,sched: Use saved_state to reduce some
 spurious wakeups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230908-avoid-spurious-freezer-wakeups-v4-2-6155aa3dafae@quicinc.com>
References: <20230908-avoid-spurious-freezer-wakeups-v4-0-6155aa3dafae@quicinc.com>
In-Reply-To: <20230908-avoid-spurious-freezer-wakeups-v4-0-6155aa3dafae@quicinc.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>
CC:     Thomas Gleixner <tglx@linutronix.de>, <kernel@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        "Prakash Viswalingam" <quic_prakashv@quicinc.com>
X-Mailer: b4 0.13-dev
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Nlq7pfKuwTrAlUz89VQZJs8X7CqY0Dl0
X-Proofpoint-GUID: Nlq7pfKuwTrAlUz89VQZJs8X7CqY0Dl0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_18,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080208
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 kernel/freezer.c    | 41 +++++++++++++++++++----------------------
 kernel/sched/core.c | 23 ++++++++++++++---------
 2 files changed, 33 insertions(+), 31 deletions(-)

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
index 58921ab7442b..12f3c500622a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2229,8 +2229,8 @@ static __always_inline
 int task_state_match(struct task_struct *p, unsigned int state)
 {
 	/*
-	 * Serialize against current_save_and_set_rtlock_wait_state() and
-	 * current_restore_rtlock_saved_state().
+	 * Serialize against current_save_and_set_rtlock_wait_state(),
+	 * current_restore_rtlock_saved_state(), and __refrigerator().
 	 */
 	guard(raw_spinlock_irq)(&p->pi_lock);
 	return __task_state_match(p, state);
@@ -4023,13 +4023,17 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
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
@@ -4045,10 +4049,11 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
 
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

-- 
2.41.0

