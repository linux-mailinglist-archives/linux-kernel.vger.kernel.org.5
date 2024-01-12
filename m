Return-Path: <linux-kernel+bounces-24821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F90482C303
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E0E41C21BD7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA01745D0;
	Fri, 12 Jan 2024 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uS5uBpu4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089C57319F;
	Fri, 12 Jan 2024 15:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB5FC433B1;
	Fri, 12 Jan 2024 15:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705074398;
	bh=/cQxWnqvZS3pZ1bKPTWJvWEqbyrOWscjBjQf2J79KU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uS5uBpu4kmfDvBa6MjrP2/TzKSp5FYWW9aaF9yP9XYVFRx/Nk8Ha0xuiBe2SY+EJX
	 h/Q3e+WveP34vV+jJ1/sZLgVmR+Seez65KaL1eyTtt5ocdYzk6NRzSKm2eOo4h0I18
	 AgJ+iR0rMeJfLB3om+1zMJe2fIQKmUchD7AKm623NtIb3GgLXwR6ElPrqH5dZTulrI
	 wqftYvX92Qlasa0lmfgLGibORq3bpTvZnK35ILr9XBb30e4jyMecA7mjIM5/ZPJXo1
	 TsQdm53r0YNHKy/LA9rCOnPR4LZ7v7pIBw274xP/kVqssVLp7/b6X/PUkr+ewoqOsh
	 9gZ47S9YFKGLg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 3/7] rcu: s/boost_kthread_mutex/kthread_mutex
Date: Fri, 12 Jan 2024 16:46:17 +0100
Message-Id: <20240112154621.261852-4-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240112154621.261852-1-frederic@kernel.org>
References: <20240112154621.261852-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This mutex is currently protecting per node boost kthreads creation and
affinity setting across CPU hotplug operations.

Since the expedited kworkers will soon be split per node as well, they
will be subject to the same concurrency constraints against hotplug.

Therefore their creation and affinity tuning operations will be grouped
with those of boost kthreads and then rely on the same mutex.

To prepare for that, generalize its name.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c        |  2 +-
 kernel/rcu/tree.h        |  2 +-
 kernel/rcu/tree_plugin.h | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5cd90f1762e9..0c818e75e8e2 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4929,7 +4929,7 @@ static void __init rcu_init_one(void)
 			init_waitqueue_head(&rnp->exp_wq[2]);
 			init_waitqueue_head(&rnp->exp_wq[3]);
 			spin_lock_init(&rnp->exp_lock);
-			mutex_init(&rnp->boost_kthread_mutex);
+			mutex_init(&rnp->kthread_mutex);
 			raw_spin_lock_init(&rnp->exp_poll_lock);
 			rnp->exp_seq_poll_rq = RCU_GET_STATE_COMPLETED;
 			INIT_WORK(&rnp->exp_poll_wq, sync_rcu_do_polled_gp);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index e9821a8422db..13e7b0d907ab 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -113,7 +113,7 @@ struct rcu_node {
 				/*  side effect, not as a lock. */
 	unsigned long boost_time;
 				/* When to start boosting (jiffies). */
-	struct mutex boost_kthread_mutex;
+	struct mutex kthread_mutex;
 				/* Exclusion for thread spawning and affinity */
 				/*  manipulation. */
 	struct task_struct *boost_kthread_task;
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 41021080ad25..0d307674915c 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1195,7 +1195,7 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 	struct sched_param sp;
 	struct task_struct *t;
 
-	mutex_lock(&rnp->boost_kthread_mutex);
+	mutex_lock(&rnp->kthread_mutex);
 	if (rnp->boost_kthread_task || !rcu_scheduler_fully_active)
 		goto out;
 
@@ -1212,7 +1212,7 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 	wake_up_process(t); /* get to TASK_INTERRUPTIBLE quickly. */
 
  out:
-	mutex_unlock(&rnp->boost_kthread_mutex);
+	mutex_unlock(&rnp->kthread_mutex);
 }
 
 /*
@@ -1224,7 +1224,7 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
  * no outgoing CPU.  If there are no CPUs left in the affinity set,
  * this function allows the kthread to execute on any CPU.
  *
- * Any future concurrent calls are serialized via ->boost_kthread_mutex.
+ * Any future concurrent calls are serialized via ->kthread_mutex.
  */
 static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 {
@@ -1237,7 +1237,7 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 		return;
 	if (!zalloc_cpumask_var(&cm, GFP_KERNEL))
 		return;
-	mutex_lock(&rnp->boost_kthread_mutex);
+	mutex_lock(&rnp->kthread_mutex);
 	mask = rcu_rnp_online_cpus(rnp);
 	for_each_leaf_node_possible_cpu(rnp, cpu)
 		if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
@@ -1250,7 +1250,7 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 			cpumask_clear_cpu(outgoingcpu, cm);
 	}
 	set_cpus_allowed_ptr(t, cm);
-	mutex_unlock(&rnp->boost_kthread_mutex);
+	mutex_unlock(&rnp->kthread_mutex);
 	free_cpumask_var(cm);
 }
 
-- 
2.34.1


