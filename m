Return-Path: <linux-kernel+bounces-112752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A830887DCB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA69281408
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4BC3D555;
	Sun, 24 Mar 2024 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="najFPLaW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B80B3D0C1;
	Sun, 24 Mar 2024 17:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711299993; cv=none; b=rxVg7cDliqGlLJXh/zS5utUBQPr9iLrAUM7Yrh5GtLxoIuGnTxHOG+N4bl3wLMaQRsQBaKhri8AoPrHMsRadrDS/E5fKkf7YAuFW/JUzmn87ZQ9Ya+oVRfnqsRpAVQXICjBC44XbVmHyjGLsnRZbH23P/NpHeS+2SdoLGFusLEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711299993; c=relaxed/simple;
	bh=PHD6Ti9d1l+EPXZmD2UV0w8BRuZR2EcJ18oxTak23vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/svcgImvRUGBmAS1J7H7oFa5LlDGYByW8TTebFN4CYdjI8qujPNmMSxWQ0YYvJB2vlPTpWqvNgZj0EEOLYFYwqWKA7clCOONNhxAoeISxLfW0//kspbDlMmDK+nrkZwtV4zQoRYLdHCXjdDCGDvYcUxO5Skcz9iBm0G4NY669c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=najFPLaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E59C433F1;
	Sun, 24 Mar 2024 17:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711299992;
	bh=PHD6Ti9d1l+EPXZmD2UV0w8BRuZR2EcJ18oxTak23vY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=najFPLaWfrmYSvKu4nDNl72SMkid1XPssEEIeYiI1SGcA5LqdWtV5A2vf7iQFlIWk
	 OXNvdXTxvlQnLSNOYSNuPnoVGfbNOirI4K8+NGGI0hc3HSOauC1aHOxW8aBOrPqFjE
	 kwANW1rrYq/oMnJbRiGQEkiTtZY1ez3zvJjgvLamGROLB+tTXBUkLR7Twxa5UEdEWO
	 E7OXddKqtRt7ROcttBGCzmkGr8Hejj64c5u8qyb8jNshthWUWQVKgxLRy1alx6oRbE
	 1HxWK+Hl1Cf2rs4AlVKveJUVhXk30zHhWWJ4DtURyQOfSXpnSLGEhF8EqPXIh2EUfc
	 +CFOgNn5uWrYA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Chen Zhongjin <chenzhongjin@huawei.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	quic_neeraju@quicinc.com,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 06/11] rcu-tasks: Eliminate deadlocks involving do_exit() and RCU tasks
Date: Sun, 24 Mar 2024 13:06:09 -0400
Message-ID: <20240324170619.545975-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324170619.545975-1-sashal@kernel.org>
References: <20240324170619.545975-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.10
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit 1612160b91272f5b1596f499584d6064bf5be794 ]

Holding a mutex across synchronize_rcu_tasks() and acquiring
that same mutex in code called from do_exit() after its call to
exit_tasks_rcu_start() but before its call to exit_tasks_rcu_stop()
results in deadlock.  This is by design, because tasks that are far
enough into do_exit() are no longer present on the tasks list, making
it a bit difficult for RCU Tasks to find them, let alone wait on them
to do a voluntary context switch.  However, such deadlocks are becoming
more frequent.  In addition, lockdep currently does not detect such
deadlocks and they can be difficult to reproduce.

In addition, if a task voluntarily context switches during that time
(for example, if it blocks acquiring a mutex), then this task is in an
RCU Tasks quiescent state.  And with some adjustments, RCU Tasks could
just as well take advantage of that fact.

This commit therefore eliminates these deadlock by replacing the
SRCU-based wait for do_exit() completion with per-CPU lists of tasks
currently exiting.  A given task will be on one of these per-CPU lists for
the same period of time that this task would previously have been in the
previous SRCU read-side critical section.  These lists enable RCU Tasks
to find the tasks that have already been removed from the tasks list,
but that must nevertheless be waited upon.

The RCU Tasks grace period gathers any of these do_exit() tasks that it
must wait on, and adds them to the list of holdouts.  Per-CPU locking
and get_task_struct() are used to synchronize addition to and removal
from these lists.

Link: https://lore.kernel.org/all/20240118021842.290665-1-chenzhongjin@huawei.com/

Reported-by: Chen Zhongjin <chenzhongjin@huawei.com>
Reported-by: Yang Jihong <yangjihong1@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Yang Jihong <yangjihong1@huawei.com>
Tested-by: Chen Zhongjin <chenzhongjin@huawei.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/tasks.h | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 6d84cdbd2a0ec..774408899e715 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -146,8 +146,6 @@ static struct rcu_tasks rt_name =							\
 }
 
 #ifdef CONFIG_TASKS_RCU
-/* Track exiting tasks in order to allow them to be waited for. */
-DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
 
 /* Report delay in synchronize_srcu() completion in rcu_tasks_postscan(). */
 static void tasks_rcu_exit_srcu_stall(struct timer_list *unused);
@@ -855,10 +853,12 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 //	number of voluntary context switches, and add that task to the
 //	holdout list.
 // rcu_tasks_postscan():
-//	Invoke synchronize_srcu() to ensure that all tasks that were
-//	in the process of exiting (and which thus might not know to
-//	synchronize with this RCU Tasks grace period) have completed
-//	exiting.
+//	Gather per-CPU lists of tasks in do_exit() to ensure that all
+//	tasks that were in the process of exiting (and which thus might
+//	not know to synchronize with this RCU Tasks grace period) have
+//	completed exiting.  The synchronize_rcu() in rcu_tasks_postgp()
+//	will take care of any tasks stuck in the non-preemptible region
+//	of do_exit() following its call to exit_tasks_rcu_stop().
 // check_all_holdout_tasks(), repeatedly until holdout list is empty:
 //	Scans the holdout list, attempting to identify a quiescent state
 //	for each task on the list.  If there is a quiescent state, the
@@ -871,8 +871,10 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 //	with interrupts disabled.
 //
 // For each exiting task, the exit_tasks_rcu_start() and
-// exit_tasks_rcu_finish() functions begin and end, respectively, the SRCU
-// read-side critical sections waited for by rcu_tasks_postscan().
+// exit_tasks_rcu_finish() functions add and remove, respectively, the
+// current task to a per-CPU list of tasks that rcu_tasks_postscan() must
+// wait on.  This is necessary because rcu_tasks_postscan() must wait on
+// tasks that have already been removed from the global list of tasks.
 //
 // Pre-grace-period update-side code is ordered before the grace
 // via the raw_spin_lock.*rcu_node().  Pre-grace-period read-side code
@@ -936,9 +938,13 @@ static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
 	}
 }
 
+void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func);
+DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks, "RCU Tasks");
+
 /* Processing between scanning taskslist and draining the holdout list. */
 static void rcu_tasks_postscan(struct list_head *hop)
 {
+	int cpu;
 	int rtsi = READ_ONCE(rcu_task_stall_info);
 
 	if (!IS_ENABLED(CONFIG_TINY_RCU)) {
@@ -952,9 +958,9 @@ static void rcu_tasks_postscan(struct list_head *hop)
 	 * this, divide the fragile exit path part in two intersecting
 	 * read side critical sections:
 	 *
-	 * 1) An _SRCU_ read side starting before calling exit_notify(),
-	 *    which may remove the task from the tasklist, and ending after
-	 *    the final preempt_disable() call in do_exit().
+	 * 1) A task_struct list addition before calling exit_notify(),
+	 *    which may remove the task from the tasklist, with the
+	 *    removal after the final preempt_disable() call in do_exit().
 	 *
 	 * 2) An _RCU_ read side starting with the final preempt_disable()
 	 *    call in do_exit() and ending with the final call to schedule()
@@ -963,7 +969,17 @@ static void rcu_tasks_postscan(struct list_head *hop)
 	 * This handles the part 1). And postgp will handle part 2) with a
 	 * call to synchronize_rcu().
 	 */
-	synchronize_srcu(&tasks_rcu_exit_srcu);
+
+	for_each_possible_cpu(cpu) {
+		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, cpu);
+		struct task_struct *t;
+
+		raw_spin_lock_irq_rcu_node(rtpcp);
+		list_for_each_entry(t, &rtpcp->rtp_exit_list, rcu_tasks_exit_list)
+			if (list_empty(&t->rcu_tasks_holdout_list))
+				rcu_tasks_pertask(t, hop);
+		raw_spin_unlock_irq_rcu_node(rtpcp);
+	}
 
 	if (!IS_ENABLED(CONFIG_TINY_RCU))
 		del_timer_sync(&tasks_rcu_exit_srcu_stall_timer);
@@ -1031,7 +1047,6 @@ static void rcu_tasks_postgp(struct rcu_tasks *rtp)
 	 *
 	 * In addition, this synchronize_rcu() waits for exiting tasks
 	 * to complete their final preempt_disable() region of execution,
-	 * cleaning up after synchronize_srcu(&tasks_rcu_exit_srcu),
 	 * enforcing the whole region before tasklist removal until
 	 * the final schedule() with TASK_DEAD state to be an RCU TASKS
 	 * read side critical section.
@@ -1039,9 +1054,6 @@ static void rcu_tasks_postgp(struct rcu_tasks *rtp)
 	synchronize_rcu();
 }
 
-void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func);
-DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks, "RCU Tasks");
-
 static void tasks_rcu_exit_srcu_stall(struct timer_list *unused)
 {
 #ifndef CONFIG_TINY_RCU
-- 
2.43.0


