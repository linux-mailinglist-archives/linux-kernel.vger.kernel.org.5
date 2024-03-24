Return-Path: <linux-kernel+bounces-112760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EECC887DDD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25741F21371
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C00B482C9;
	Sun, 24 Mar 2024 17:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgNQMkVv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C756247A6F;
	Sun, 24 Mar 2024 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711300011; cv=none; b=MS07d/U1zEQ3BACFxGH3MsM9st85q4+aJca0wb6LFsRe9CCM6qchw0nopY8mu0KgRPVZWO8fd3a7ogmiBvvcQwoaWRdKEYMXuXqCn0br6oouQmnI/qUW3bFqol0pA1YC2g6WIRY+7e+t01pMcjEinYnEdTo2BAzhKOS98Lc6F/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711300011; c=relaxed/simple;
	bh=OtAGbeU5mxTavpUec3StFvPEE4SSEplTjeR8N2SdDAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKdMhO++4BDT8SdK7EQiXBTXRo/Qyix3KQ83LCqx7wSV+i3x1Ce9ML1gNyeFpPcLh1QG4JHnfVlap3pIBjseDwp/3yWzLZWfXCdBcv/00TX5KVO8PUd11bN99nuaaahFvTalX5jtq75D9ICcl0sqnP0HUBpc0R2s0/xuZYqvsqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgNQMkVv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A376AC433C7;
	Sun, 24 Mar 2024 17:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711300011;
	bh=OtAGbeU5mxTavpUec3StFvPEE4SSEplTjeR8N2SdDAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YgNQMkVvRTxAi9UIP0yYkbIB/3k2b6+1/nXj6yVLEMqCzFadVn1DdSABSzYVcVtGA
	 kQvyZIKvSrpOfu+A2Jv3vbSbDTE9+cmqNNqRHRvnyU5eqaQ4QlDM5BIB3f9VwSND7B
	 lkcERyy8uOGIv13Z6R4HcqA5v7c40TxOjHqqMjdCsazqE3hb9zoEpyYdO28Q50OlEv
	 PpyCLeG1Ik6a3UEJjwyABouIngx+wUM9sVB5deF6MX56deoguWhwQRULRAuFobjmmO
	 59UO1rCjkBQinoYzVr96Gckg7c40wTFPQVUuLmdpHhh0Q4YVTG/XbuH5LY2VkyrjO8
	 RgOX1RQU7Ha0A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Chen Zhongjin <chenzhongjin@huawei.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	quic_neeraju@quicinc.com,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 03/11] rcu-tasks: Add data to eliminate RCU-tasks/do_exit() deadlocks
Date: Sun, 24 Mar 2024 13:06:33 -0400
Message-ID: <20240324170645.546220-3-sashal@kernel.org>
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

[ Upstream commit bfe93930ea1ea3c6c115a7d44af6e4fea609067e ]

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

This commit therefore adds the data structures that will be needed
to rely on these quiescent states and to eliminate these deadlocks.

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
 include/linux/sched.h | 2 ++
 kernel/rcu/tasks.h    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 77f01ac385f7a..3d83cc397eac1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -854,6 +854,8 @@ struct task_struct {
 	u8				rcu_tasks_idx;
 	int				rcu_tasks_idle_cpu;
 	struct list_head		rcu_tasks_holdout_list;
+	int				rcu_tasks_exit_cpu;
+	struct list_head		rcu_tasks_exit_list;
 #endif /* #ifdef CONFIG_TASKS_RCU */
 
 #ifdef CONFIG_TASKS_TRACE_RCU
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 65e000ca332cc..cce0604f6fcc1 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -32,6 +32,7 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
  * @rtp_irq_work: IRQ work queue for deferred wakeups.
  * @barrier_q_head: RCU callback for barrier operation.
  * @rtp_blkd_tasks: List of tasks blocked as readers.
+ * @rtp_exit_list: List of tasks in the latter portion of do_exit().
  * @cpu: CPU number corresponding to this entry.
  * @rtpp: Pointer to the rcu_tasks structure.
  */
@@ -46,6 +47,7 @@ struct rcu_tasks_percpu {
 	struct irq_work rtp_irq_work;
 	struct rcu_head barrier_q_head;
 	struct list_head rtp_blkd_tasks;
+	struct list_head rtp_exit_list;
 	int cpu;
 	struct rcu_tasks *rtpp;
 };
-- 
2.43.0


