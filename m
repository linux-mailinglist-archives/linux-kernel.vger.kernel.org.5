Return-Path: <linux-kernel+bounces-112908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA4B887FA9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01AF21F2171F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF645D73D;
	Sun, 24 Mar 2024 22:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnIq1OuU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE7F5D477;
	Sun, 24 Mar 2024 22:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319719; cv=none; b=Wo925uK1cHg8gaJzdsHjGRaz4GOSlD+eHBlUBV9m6sQo010kY3Nq9pFh6oo5w4q+0k0iFlrVs0JZLO3FNFmd2xgH6rPqPn1Xk6L9jZHMrVAUSgdaCU4n/DnmAlJd86ORba8UNSOCxb1xi5g44MmIXwiJzVyU9lRuArVE9Bnpvg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319719; c=relaxed/simple;
	bh=85vqVoxtI42H/ALYmgrcO3An3l6bGc3itYafrMJW/oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gY7e4rA7gdkGtyqnarZGQEdjqUAhJ7EkGdyTg9K7MDpRZEVDgW3qH81nvopTqMwXYFlwredMAiEoF+yFv76dz23aXeeIX3T7L/NdQgc2MmFXTsTSuVyR1iYhuXNGFOaVkBh30ojrtfi0EnZ+1AWXCdGSeaEf5WbML5EEtl0tUbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnIq1OuU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BD2C43394;
	Sun, 24 Mar 2024 22:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319718;
	bh=85vqVoxtI42H/ALYmgrcO3An3l6bGc3itYafrMJW/oc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jnIq1OuUe26o0Iz2M6CLuXP0Gb/uidr57ZSsu5XbTz2UOHyiSnN0hxGKR9x9e+mow
	 AZi4xrqIY4xqQEr3vUovygvEtl/jVrbApiVdSRl49LY5sNXwiUooWb2iZhOjfsMA9O
	 0j3JzHPcz6vGRvbIYgCWEyt7YKdkBIysxhJE2OJWEqa6O79B5dLyJVpWdWwyPEj5OO
	 1NVIER/AP2nJOI6CD6Uk6weo/OE1qXcQl+ari4u7UZ53LKKN0XMS4MNNdtc8kkR+iI
	 6E3VTk+eXEf3Q/I5LE9kFQIH7yP47xCe92w4ptjixAu7OMyw8msb7CWMgPxYtieCiT
	 w46ZQWTbFQjBw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 021/715] rcu/exp: Handle RCU expedited grace period kworker allocation failure
Date: Sun, 24 Mar 2024 18:23:20 -0400
Message-ID: <20240324223455.1342824-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

[ Upstream commit e7539ffc9a770f36bacedcf0fbfb4bf2f244f4a5 ]

Just like is done for the kworker performing nodes initialization,
gracefully handle the possible allocation failure of the RCU expedited
grace period main kworker.

While at it perform a rename of the related checking functions to better
reflect the expedited specifics.

Reviewed-by: Kalesh Singh <kaleshsingh@google.com>
Fixes: 9621fbee44df ("rcu: Move expedited grace period (GP) work to RT kthread_worker")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/tree.c     |  2 ++
 kernel/rcu/tree_exp.h | 25 +++++++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 38c86f2c040b5..f2c10d351b597 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4743,6 +4743,7 @@ static void __init rcu_start_exp_gp_kworkers(void)
 	rcu_exp_gp_kworker = kthread_create_worker(0, gp_kworker_name);
 	if (IS_ERR_OR_NULL(rcu_exp_gp_kworker)) {
 		pr_err("Failed to create %s!\n", gp_kworker_name);
+		rcu_exp_gp_kworker = NULL;
 		return;
 	}
 
@@ -4751,6 +4752,7 @@ static void __init rcu_start_exp_gp_kworkers(void)
 		pr_err("Failed to create %s!\n", par_gp_kworker_name);
 		rcu_exp_par_gp_kworker = NULL;
 		kthread_destroy_worker(rcu_exp_gp_kworker);
+		rcu_exp_gp_kworker = NULL;
 		return;
 	}
 
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 2ac440bc7e10b..8107f818455da 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -428,7 +428,12 @@ static void sync_rcu_exp_select_node_cpus(struct kthread_work *wp)
 	__sync_rcu_exp_select_node_cpus(rewp);
 }
 
-static inline bool rcu_gp_par_worker_started(void)
+static inline bool rcu_exp_worker_started(void)
+{
+	return !!READ_ONCE(rcu_exp_gp_kworker);
+}
+
+static inline bool rcu_exp_par_worker_started(void)
 {
 	return !!READ_ONCE(rcu_exp_par_gp_kworker);
 }
@@ -478,7 +483,12 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 	__sync_rcu_exp_select_node_cpus(rewp);
 }
 
-static inline bool rcu_gp_par_worker_started(void)
+static inline bool rcu_exp_worker_started(void)
+{
+	return !!READ_ONCE(rcu_gp_wq);
+}
+
+static inline bool rcu_exp_par_worker_started(void)
 {
 	return !!READ_ONCE(rcu_par_gp_wq);
 }
@@ -541,7 +551,7 @@ static void sync_rcu_exp_select_cpus(void)
 		rnp->exp_need_flush = false;
 		if (!READ_ONCE(rnp->expmask))
 			continue; /* Avoid early boot non-existent wq. */
-		if (!rcu_gp_par_worker_started() ||
+		if (!rcu_exp_par_worker_started() ||
 		    rcu_scheduler_active != RCU_SCHEDULER_RUNNING ||
 		    rcu_is_last_leaf_node(rnp)) {
 			/* No worker started yet or last leaf, do direct call. */
@@ -956,7 +966,7 @@ static void rcu_exp_print_detail_task_stall_rnp(struct rcu_node *rnp)
  */
 void synchronize_rcu_expedited(void)
 {
-	bool boottime = (rcu_scheduler_active == RCU_SCHEDULER_INIT);
+	bool use_worker;
 	unsigned long flags;
 	struct rcu_exp_work rew;
 	struct rcu_node *rnp;
@@ -967,6 +977,9 @@ void synchronize_rcu_expedited(void)
 			 lock_is_held(&rcu_sched_lock_map),
 			 "Illegal synchronize_rcu_expedited() in RCU read-side critical section");
 
+	use_worker = (rcu_scheduler_active != RCU_SCHEDULER_INIT) &&
+		      rcu_exp_worker_started();
+
 	/* Is the state is such that the call is a grace period? */
 	if (rcu_blocking_is_gp()) {
 		// Note well that this code runs with !PREEMPT && !SMP.
@@ -996,7 +1009,7 @@ void synchronize_rcu_expedited(void)
 		return;  /* Someone else did our work for us. */
 
 	/* Ensure that load happens before action based on it. */
-	if (unlikely(boottime)) {
+	if (unlikely(!use_worker)) {
 		/* Direct call during scheduler init and early_initcalls(). */
 		rcu_exp_sel_wait_wake(s);
 	} else {
@@ -1014,7 +1027,7 @@ void synchronize_rcu_expedited(void)
 	/* Let the next expedited grace period start. */
 	mutex_unlock(&rcu_state.exp_mutex);
 
-	if (likely(!boottime))
+	if (likely(use_worker))
 		synchronize_rcu_expedited_destroy_work(&rew);
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
-- 
2.43.0


