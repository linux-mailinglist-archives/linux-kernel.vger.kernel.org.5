Return-Path: <linux-kernel+bounces-158704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8B58B2403
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B120E1F2115D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83E914A61E;
	Thu, 25 Apr 2024 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pkilc+Ep"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2827314A4F0;
	Thu, 25 Apr 2024 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714055050; cv=none; b=FdQvw/wOCigWr1h3kcc1wZLWHz0E8KH3BdiSORNa6C1ZMKMWK7YDpyh+Ggn8lvmG5DAkougOFQ3Z4vGGt7ByDTqiybNVmXfl5YjCpgDPt0cJ/Y4TBLhjFjxulnhtBie2MFWM48gKwa2lcTASHbBc4dWvxE83Kuu79/8sN8FkbIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714055050; c=relaxed/simple;
	bh=qva/6Fv0XiO0LVG9iIShXhoXPvI6LttQFZoNgfBI9Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eNOWYDVkl+h5ptM0xUUeu2q8va14/poN5PuEiak3AOP0fnZBY0BPEskbUcorP6te27KGzVzIRbTByioDOsomVZ7VijOTI5rYFmpq+It83b18IGkdvlnXqwpX2R6f11AMvav6AIWaO4d7RQVUatw5EcZen1gp9a8/HjDPX3XS4gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pkilc+Ep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C49C4AF07;
	Thu, 25 Apr 2024 14:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714055049;
	bh=qva/6Fv0XiO0LVG9iIShXhoXPvI6LttQFZoNgfBI9Wc=;
	h=From:To:Cc:Subject:Date:From;
	b=Pkilc+EpkcWQdwLo3gpgV/koXF1h9fzPEGqTYN0rhyyVNZUyoA8ZSlMaFTPJJiwdf
	 Wkd7a1QjB7DKiySvEnqENW2Qd1LiNzheBIHXexjOxpfVVkY8920iW1vV/HcGdvLSg0
	 f70qLcebEFokvH2Mbdp+kJrTeXS0dlNG4SQLLv/lQOhVYVBoxjdWpShTjLDr73dwhp
	 2csY/pZ1wp/jb2usZ2dRj5CRquofRPOVsh4+tmgZ/y+lfwGaWNK7YhWd8eVPpkYFRE
	 d3eGjgN5gMR2sAkDxKkG0nixNP+T2GFFvVqTfvBc3sZWIyM3BDVOxp7pC3yANrrrOT
	 YSMJG0UsS1T4Q==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH] Revert "rcu-tasks: Fix synchronize_rcu_tasks() VS zap_pid_ns_processes()"
Date: Thu, 25 Apr 2024 16:24:04 +0200
Message-ID: <20240425142404.19927-1-frederic@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 28319d6dc5e2ffefa452c2377dd0f71621b5bff0. The race
it fixed was subject to conditions that don't exist anymore since:

	1612160b9127 ("rcu-tasks: Eliminate deadlocks involving do_exit() and RCU tasks")

This latter commit removes the use of SRCU that used to cover the
RCU-tasks blind spot on exit between the tasklist's removal and the
final preemption disabling. The task is now placed instead into a
temporary list inside which voluntary sleeps are accounted as RCU-tasks
quiescent states. This would disarm the deadlock initially reported
against PID namespace exit.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/rcupdate.h |  2 --
 kernel/pid_namespace.c   | 17 -----------------
 kernel/rcu/tasks.h       | 16 +++-------------
 3 files changed, 3 insertions(+), 32 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 8470a85f6563..be450a3477be 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -209,7 +209,6 @@ void synchronize_rcu_tasks_rude(void);
 
 #define rcu_note_voluntary_context_switch(t) rcu_tasks_qs(t, false)
 void exit_tasks_rcu_start(void);
-void exit_tasks_rcu_stop(void);
 void exit_tasks_rcu_finish(void);
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
 #define rcu_tasks_classic_qs(t, preempt) do { } while (0)
@@ -218,7 +217,6 @@ void exit_tasks_rcu_finish(void);
 #define call_rcu_tasks call_rcu
 #define synchronize_rcu_tasks synchronize_rcu
 static inline void exit_tasks_rcu_start(void) { }
-static inline void exit_tasks_rcu_stop(void) { }
 static inline void exit_tasks_rcu_finish(void) { }
 #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
 
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 7ade20e95232..20a0b3ceb064 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -248,24 +248,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (pid_ns->pid_allocated == init_pids)
 			break;
-		/*
-		 * Release tasks_rcu_exit_srcu to avoid following deadlock:
-		 *
-		 * 1) TASK A unshare(CLONE_NEWPID)
-		 * 2) TASK A fork() twice -> TASK B (child reaper for new ns)
-		 *    and TASK C
-		 * 3) TASK B exits, kills TASK C, waits for TASK A to reap it
-		 * 4) TASK A calls synchronize_rcu_tasks()
-		 *                   -> synchronize_srcu(tasks_rcu_exit_srcu)
-		 * 5) *DEADLOCK*
-		 *
-		 * It is considered safe to release tasks_rcu_exit_srcu here
-		 * because we assume the current task can not be concurrently
-		 * reaped at this point.
-		 */
-		exit_tasks_rcu_stop();
 		schedule();
-		exit_tasks_rcu_start();
 	}
 	__set_current_state(TASK_RUNNING);
 
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 445561ee4d22..8c9538b555e3 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -858,7 +858,7 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 //	not know to synchronize with this RCU Tasks grace period) have
 //	completed exiting.  The synchronize_rcu() in rcu_tasks_postgp()
 //	will take care of any tasks stuck in the non-preemptible region
-//	of do_exit() following its call to exit_tasks_rcu_stop().
+//	of do_exit() following its call to exit_tasks_rcu_finish().
 // check_all_holdout_tasks(), repeatedly until holdout list is empty:
 //	Scans the holdout list, attempting to identify a quiescent state
 //	for each task on the list.  If there is a quiescent state, the
@@ -1220,7 +1220,7 @@ void exit_tasks_rcu_start(void)
  * Remove the task from the "yet another list" because do_exit() is now
  * non-preemptible, allowing synchronize_rcu() to wait beyond this point.
  */
-void exit_tasks_rcu_stop(void)
+void exit_tasks_rcu_finish(void)
 {
 	unsigned long flags;
 	struct rcu_tasks_percpu *rtpcp;
@@ -1231,22 +1231,12 @@ void exit_tasks_rcu_stop(void)
 	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
 	list_del_init(&t->rcu_tasks_exit_list);
 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
-}
 
-/*
- * Contribute to protect against tasklist scan blind spot while the
- * task is exiting and may be removed from the tasklist. See
- * corresponding synchronize_srcu() for further details.
- */
-void exit_tasks_rcu_finish(void)
-{
-	exit_tasks_rcu_stop();
-	exit_tasks_rcu_finish_trace(current);
+	exit_tasks_rcu_finish_trace(t);
 }
 
 #else /* #ifdef CONFIG_TASKS_RCU */
 void exit_tasks_rcu_start(void) { }
-void exit_tasks_rcu_stop(void) { }
 void exit_tasks_rcu_finish(void) { exit_tasks_rcu_finish_trace(current); }
 #endif /* #else #ifdef CONFIG_TASKS_RCU */
 
-- 
2.44.0


