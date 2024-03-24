Return-Path: <linux-kernel+bounces-112773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9238887DF8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 586FB1F213DF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1688458AD2;
	Sun, 24 Mar 2024 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8pa1pjN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441DD224F1;
	Sun, 24 Mar 2024 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711300037; cv=none; b=QcATRpcoqhWYDYX7tlcB12AEHDE9WqBGjT4SuvGz6eCJxqwxSdRSPv3YWVvOxOrB1MjQhhtwVeMmeB1uRwrdLA8MDy+ASrqwgcFvWgiy4Ar09vJQo2WaRQ9xmdvMXr/+hsnfzTKfr/8LqaPcNC+9ZP/PykSfaq/tLHRlfTBKbko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711300037; c=relaxed/simple;
	bh=5A4YIkHqVwwTm1pf2aHh/AAntir5ZY/Uchu5RnKY8fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ct8yUdkwlwIr6lZbSvz7PBEFhU+jsC1X2kkfGUA8qt8r+7daMvHByehL4YHpCgtQxz8hiKd0f9LlmE6laPgbyKiBpilysLHGt7aYfbzlQXV3lHYOG5eDDt9+AT0keMjwwqBktoO7vOrLSmaIZF5jfc1Xl+po/nIGbdw5N7hmi/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8pa1pjN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1E6C433A6;
	Sun, 24 Mar 2024 17:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711300037;
	bh=5A4YIkHqVwwTm1pf2aHh/AAntir5ZY/Uchu5RnKY8fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k8pa1pjNVVjd4x5fjrYImoEqu26NhpH5tQXv/6sdWPydFdv9Al4nwQ6wRxh111sDU
	 C+A1SE0ErHewITe7CQy/VV5xkizfSKY9eEx1JaV2i0xJRmxJh5QJskLoPcixR8NJBE
	 2mFkOhh+XZjUaGDZDp2/1weVNploOtxKqn7OsQ0q1LVYAZ2CcwyGobBZXnIP92nIcu
	 c5gaKFKiICfBT4o7uXasY03D6IhEMi+3q+simmOgTL4vuiwSfbisiReDkq8K1YbWR5
	 9BUa4vxLQsFIDWXkngPQj8X7iBI5CzOXZ+hev5d/1ZAxcjbmTCzZIcmkgDkA3XYr6p
	 NyTCb2JS0NVdw==
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
Subject: [PATCH AUTOSEL 6.1 4/7] rcu-tasks: Maintain lists to eliminate RCU-tasks/do_exit() deadlocks
Date: Sun, 24 Mar 2024 13:07:04 -0400
Message-ID: <20240324170709.546465-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324170709.546465-1-sashal@kernel.org>
References: <20240324170709.546465-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.82
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
index 919c22698569e..76ad0bc2b3312 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1014,25 +1014,48 @@ EXPORT_SYMBOL_GPL(show_rcu_tasks_classic_gp_kthread);
 #endif // !defined(CONFIG_TINY_RCU)
 
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


