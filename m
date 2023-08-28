Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A302878B68B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbjH1Red (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbjH1ReH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:34:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD5A129;
        Mon, 28 Aug 2023 10:34:03 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SFqkAp014958;
        Mon, 28 Aug 2023 17:33:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : to : cc; s=qcppdkim1;
 bh=SY4V2LfRkvPZ5cOmZFW4/tO8UYuxhGUSh1QM1JL3LPQ=;
 b=pFCNtBvFS+NeMVMWWLsmdHxbABGcBycgaGgDwh7R1VbkucETqZlKwfYK3n0RsduJeFK0
 R8XZTnhjcFAJbQ+oXRUKme3m3uqFtv44YW4BU+XxURvMKDBPZpLmx4+8U5vz5PiPtt6J
 6lLEr1iXdgOphn1V9qmyqJPL88TZ/YZkoIhDxU0xXOMiK6bkUMfgz4sxCYly7tU6he4n
 1Vg5zg6CypD9meWa+xU0xi6UEYvVJACOoVnkKZyqPr8amyPBfLXKBGeeKVx0qRcgSXqN
 tCsuYy5OETA0hQg5eImQkPDdb/TjJA1CwgPUV1x02qJPm7QNeB/DN8gSXvtQlxH3C+us iQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sqapfm880-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 17:33:34 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37SHXYMf014363
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 17:33:34 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 28 Aug 2023 10:33:31 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
Date:   Mon, 28 Aug 2023 10:33:04 -0700
Subject: [PATCH] freezer,sched: Use saved_state to reduce some spurious
 wakeups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230828-avoid-spurious-freezer-wakeups-v1-1-8be8cf761472@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAE/a7GQC/x2NQQqDMBAAvyI5dyFRsLFfKT1sdFOXShJ2iS0V/
 97Q48xh5jBKwqTm1h1GaGflnBq4S2fmFdOTgJfGprf9YL27Au6ZF9BShXNViEL0JYE3vqgWhSn
 60U2jt2FA0yIBlSAIpnltmVS3rckiFPnzv94f5/kDk4wMBIUAAAA=
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
X-Proofpoint-ORIG-GUID: 5YYWwWCdHj09Katurg19d5gF535fbu9L
X-Proofpoint-GUID: 5YYWwWCdHj09Katurg19d5gF535fbu9L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_15,2023-08-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280154
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit f5d39b020809 ("freezer,sched: Rewrite core freezer logic"),
tasks that are in TASK_FREEZABLE state and end up getting frozen are
always woken up. Prior to that commit, tasks could ask freezer to
consider them "frozen enough" via freezer_do_not_conut(). As described
in Peter's commit, the reason for this change is to prevent these tasks
from being woken before SMP is back. The commit introduced a
TASK_FREEZABLE state which allows freezer to immediately mark the task
as TASK_FROZEN without waking up the task. On the thaw path, the task is
woken up even if the task didn't need to wake up and goes back to its
TASK_(UN)INTERRUPTIBLE state. Although these tasks are capable of
handling of the wakeup, we can observe a power/perf impact from the
extra wakeup.

We observed on Android many tasks wait in the TASK_FREEZABLE state
(particularly due to many of them being binder clients). We observed
nearly 4x the number of tasks and a corresponding (almost) linear increase in
latency and power consumption when thawing the system. The latency
increased from ~15ms to ~50ms.

Save the state of TASK_FREEZABLE tasks and restore it after thawing the
task without waking the task up. If the task received a wake up for the
saved_state before thawing, then the task is still woken upon thawing.

Re-use saved_state from RT sleeping spinlocks because freezer doesn't
consider TASK_RTLOCK_WAIT freezable.

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
   echo 'enable_event:sched:sched_wakeup if action == \"thaw_processes\" && start == 1' > events/power/suspend_resume/trigger
   echo 'traceoff if action == \"thaw_processes\" && start == 0' > events/power/suspend_resume/trigger
   echo 1 > tracing_on

2. Let kernel go to suspend

3. After kernel's back up:
   cat /sys/kernel/tracing/instances/freezer/trace | grep sched_wakeup | grep -o "pid=[0-9]*" | sort -u | wc -l
---
 include/linux/sched.h |  4 ++--
 kernel/freezer.c      | 15 +++++++++++++--
 kernel/sched/core.c   | 21 +++++++++++++--------
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index eed5d65b8d1f..e4ade5a18df2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -746,8 +746,8 @@ struct task_struct {
 #endif
 	unsigned int			__state;
 
-#ifdef CONFIG_PREEMPT_RT
-	/* saved state for "spinlock sleepers" */
+#if IS_ENABLED(CONFIG_PREEMPT_RT) || IS_ENABLED(CONFIG_FREEZER)
+	/* saved state for "spinlock sleepers" and freezer */
 	unsigned int			saved_state;
 #endif
 
diff --git a/kernel/freezer.c b/kernel/freezer.c
index 4fad0e6fca64..6222cbfd97ab 100644
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
@@ -174,10 +179,16 @@ bool freeze_task(struct task_struct *p)
  * state in p->jobctl. If either of them got a wakeup that was missed because
  * TASK_FROZEN, then their canonical state reflects that and the below will
  * refuse to restore the special state and instead issue the wakeup.
+ *
+ * Otherwise, restore the saved_state before the task entered freezer. For
+ * typical tasks in the __refrigerator(), saved_state == 0 so nothing happens
+ * here. For tasks which were TASK_NORMAL | TASK_FREEZABLE, their initial state
+ * is returned unless they got an expected wakeup. Then they will be woken up as
+ * TASK_FROZEN back in __thaw_task().
  */
 static int __set_task_special(struct task_struct *p, void *arg)
 {
-	unsigned int state = 0;
+	unsigned int state = p->saved_state;
 
 	if (p->jobctl & JOBCTL_TRACED)
 		state = TASK_TRACED;
@@ -188,7 +199,7 @@ static int __set_task_special(struct task_struct *p, void *arg)
 	if (state)
 		WRITE_ONCE(p->__state, state);
 
-	return state;
+	return state & ~TASK_FROZEN;
 }
 
 void __thaw_task(struct task_struct *p)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a68d1276bab0..815d955764a5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3992,13 +3992,17 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
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
@@ -4013,13 +4017,14 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
 		return true;
 	}
 
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
base-commit: 6995e2de6891c724bfeb2db33d7b87775f913ad1
change-id: 20230817-avoid-spurious-freezer-wakeups-9f8619680b3a

Best regards,
-- 
Elliot Berman <quic_eberman@quicinc.com>

