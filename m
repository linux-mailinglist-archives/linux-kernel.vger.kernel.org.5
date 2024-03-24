Return-Path: <linux-kernel+bounces-112763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE818887DE2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835FD1F20F34
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B934CE0E;
	Sun, 24 Mar 2024 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOKegucs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853364C634;
	Sun, 24 Mar 2024 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711300017; cv=none; b=aXoMk81jbUxQtGo8278D7BdZ4IsmxZrOXdo4JlE92lOtzHZ5FHbfe+OmoH5JVnjhsDzsekVoeHNxPXH7w1YGY8oPe5GvlgKoMyJFnS0g9odqPngoUZvdtuoCMflFX7N297Yiij/r0Qnd85Ic6EPpe/FkuzUtfK1+kVH0izXWUTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711300017; c=relaxed/simple;
	bh=VgyaeUwL81K3JwGawdXWxkuvS3TadJYrMxPFDBxaChY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LekHEbRNfZ2UOr8qTJIoVJePASWz+B6JvVufKpH/fLqqIRRrm+ckOFyt6F5Rmt941+6d9pRxgM52+OfbOCBn8l3XZ7M5x5RygaLgJH/SxNiJcEKkwn5PmQbPGwIMuAcQI/ZYqlaF8iPRRP8qHGs0YDeplJFqgt1jIjly4Td6CzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOKegucs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2728C43399;
	Sun, 24 Mar 2024 17:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711300017;
	bh=VgyaeUwL81K3JwGawdXWxkuvS3TadJYrMxPFDBxaChY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FOKegucs+WlLorY8nOAqY4pfhOsTtW7PrPDvyQIDzShFMSNCemEdpV5LwjBB1LNbD
	 EdZ2gP82yWLnmlj0v2faMS0AUResD+9XPUgaOSJb/8y5DME9n+MPX90HU2lUptD/Lq
	 MxwAmJabhYOa7dMymBBdqPb2lgGsOEfQIVSovcZ/AqqHpPCcAa1eH/O93oMV1GFYD8
	 OyLNC3y47ZHK01AXov9GWrl3O1cHoodDE/gTuBgeCBTK/aRI+FCYlQlyYexKaQwGZK
	 l8zDw5evdphozlAQpPewVycVzvYjveDHk8M1AMbjF4/SMM5aV0EklSxtbuiWBwxsp9
	 Uv9RIwxf5GbTg==
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
Subject: [PATCH AUTOSEL 6.6 05/11] rcu-tasks: Maintain lists to eliminate RCU-tasks/do_exit() deadlocks
Date: Sun, 24 Mar 2024 13:06:35 -0400
Message-ID: <20240324170645.546220-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324170645.546220-1-sashal@kernel.org>
References: <20240324170645.546220-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.22
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit 6b70399f9ef3809f6e308fd99dd78b072c1bd05c ]

This commit continues the elimination of deadlocks involving do_exit()
and RCU tasks by causing exit_tasks_rcu_start() to add the current
task to a per-CPU list and causing exit_tasks_rcu_stop() to remove the
current task from whatever list it is on.  These lists will be used to
track tasks that are exiting, while still accounting for any RCU-tasks
quiescent states that these tasks pass though.

[ paulmck: Apply Frederic Weisbecker feedback. ]

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
 kernel/rcu/tasks.h | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 91ed14b83333b..bfbb5090b7b79 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1148,25 +1148,48 @@ struct task_struct *get_rcu_tasks_gp_kthread(void)
 EXPORT_SYMBOL_GPL(get_rcu_tasks_gp_kthread);
 
 /*
- * Contribute to protect against tasklist scan blind spot while the
- * task is exiting and may be removed from the tasklist. See
- * corresponding synchronize_srcu() for further details.
+ * Protect against tasklist scan blind spot while the task is exiting and
+ * may be removed from the tasklist.  Do this by adding the task to yet
+ * another list.
+ *
+ * Note that the task will remove itself from this list, so there is no
+ * need for get_task_struct(), except in the case where rcu_tasks_pertask()
+ * adds it to the holdout list, in which case rcu_tasks_pertask() supplies
+ * the needed get_task_struct().
  */
-void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
+void exit_tasks_rcu_start(void)
 {
-	current->rcu_tasks_idx = __srcu_read_lock(&tasks_rcu_exit_srcu);
+	unsigned long flags;
+	struct rcu_tasks_percpu *rtpcp;
+	struct task_struct *t = current;
+
+	WARN_ON_ONCE(!list_empty(&t->rcu_tasks_exit_list));
+	preempt_disable();
+	rtpcp = this_cpu_ptr(rcu_tasks.rtpcpu);
+	t->rcu_tasks_exit_cpu = smp_processor_id();
+	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
+	if (!rtpcp->rtp_exit_list.next)
+		INIT_LIST_HEAD(&rtpcp->rtp_exit_list);
+	list_add(&t->rcu_tasks_exit_list, &rtpcp->rtp_exit_list);
+	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
+	preempt_enable();
 }
 
 /*
- * Contribute to protect against tasklist scan blind spot while the
- * task is exiting and may be removed from the tasklist. See
- * corresponding synchronize_srcu() for further details.
+ * Remove the task from the "yet another list" because do_exit() is now
+ * non-preemptible, allowing synchronize_rcu() to wait beyond this point.
  */
-void exit_tasks_rcu_stop(void) __releases(&tasks_rcu_exit_srcu)
+void exit_tasks_rcu_stop(void)
 {
+	unsigned long flags;
+	struct rcu_tasks_percpu *rtpcp;
 	struct task_struct *t = current;
 
-	__srcu_read_unlock(&tasks_rcu_exit_srcu, t->rcu_tasks_idx);
+	WARN_ON_ONCE(list_empty(&t->rcu_tasks_exit_list));
+	rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, t->rcu_tasks_exit_cpu);
+	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
+	list_del_init(&t->rcu_tasks_exit_list);
+	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 }
 
 /*
-- 
2.43.0


