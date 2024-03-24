Return-Path: <linux-kernel+bounces-115808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8649C8897FF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B82391C31266
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176E9372A94;
	Mon, 25 Mar 2024 03:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWoQxUXC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FF114535F;
	Sun, 24 Mar 2024 23:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321992; cv=none; b=KCixBVRnLS8Q/zfUJ/3DLXHGZBefbWf8yvHywdk4wo/wrbeaIpiHLQOcpVKJhFQlprX3G+HQNvJpnKntzPHzMI4dRriR+5JB94C/M8qdx42jFReuo2ea2ivNe5mv3eguqRytD7BXLrkme4z97bx6y72kdq/hN76I+9vCy4nD9Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321992; c=relaxed/simple;
	bh=5awp1bcyZakFRNXi5eAuflCy5SvpRj0npXXKVdVf74g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DcSJpuGMdcez/npfkP/5i+ZIZW81QhI3N9HaKpXrKDJAv4VIUbjjdXZK+o4Fyeq/M2ojcAJjBglizcDV9ejLevndamzfTm2YUmMKZOnaYCSpokBhlDT5fK30TicleeGDDdy+KI2DosGw7FWVKxZPgsHe7QyIBubLV0wd44UXBmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWoQxUXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF47C433F1;
	Sun, 24 Mar 2024 23:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321992;
	bh=5awp1bcyZakFRNXi5eAuflCy5SvpRj0npXXKVdVf74g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kWoQxUXCtc+lhchJKjVlYk17KAlbP4sk4B2pBfYRpipEQtbSJQRXUJQ9T5Qo2KhEy
	 FjjSTGqheeiu4XcPdPJedwHgVLooHsNzkTq54+BM20iLHxgU55LmhXlSI+4kMRS8iq
	 SscPhsnE8BlnsMVzZnK/MeNVw6XZKHup8KhrKqStacZYtJBvcCWH4sW+6SQIytyxZq
	 10EP7t3FwFcBnJ/7q/oQKUB9nP0IIl70Wd1thAxOHt3lwDJX9Nuhz7aibT7rz6yFFn
	 R4JuBdNtxdPPNjyKYwmalH2cdLodASWFzu8uRLIUqIXcoYYMCklvjUdcYHN0/P72Yr
	 +sLd0FGJeWIiQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 064/451] rcu/exp: Handle RCU expedited grace period kworker allocation failure
Date: Sun, 24 Mar 2024 19:05:40 -0400
Message-ID: <20240324231207.1351418-65-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index c879ed0c55079..61f9503a5fe9c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4465,6 +4465,7 @@ static void __init rcu_start_exp_gp_kworkers(void)
 	rcu_exp_gp_kworker = kthread_create_worker(0, gp_kworker_name);
 	if (IS_ERR_OR_NULL(rcu_exp_gp_kworker)) {
 		pr_err("Failed to create %s!\n", gp_kworker_name);
+		rcu_exp_gp_kworker = NULL;
 		return;
 	}
 
@@ -4473,6 +4474,7 @@ static void __init rcu_start_exp_gp_kworkers(void)
 		pr_err("Failed to create %s!\n", par_gp_kworker_name);
 		rcu_exp_par_gp_kworker = NULL;
 		kthread_destroy_worker(rcu_exp_gp_kworker);
+		rcu_exp_gp_kworker = NULL;
 		return;
 	}
 
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 6d2cbed96b462..75e8d9652f7bb 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -427,7 +427,12 @@ static void sync_rcu_exp_select_node_cpus(struct kthread_work *wp)
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
@@ -477,7 +482,12 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
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
@@ -540,7 +550,7 @@ static void sync_rcu_exp_select_cpus(void)
 		rnp->exp_need_flush = false;
 		if (!READ_ONCE(rnp->expmask))
 			continue; /* Avoid early boot non-existent wq. */
-		if (!rcu_gp_par_worker_started() ||
+		if (!rcu_exp_par_worker_started() ||
 		    rcu_scheduler_active != RCU_SCHEDULER_RUNNING ||
 		    rcu_is_last_leaf_node(rnp)) {
 			/* No worker started yet or last leaf, do direct call. */
@@ -910,7 +920,7 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
  */
 void synchronize_rcu_expedited(void)
 {
-	bool boottime = (rcu_scheduler_active == RCU_SCHEDULER_INIT);
+	bool use_worker;
 	unsigned long flags;
 	struct rcu_exp_work rew;
 	struct rcu_node *rnp;
@@ -921,6 +931,9 @@ void synchronize_rcu_expedited(void)
 			 lock_is_held(&rcu_sched_lock_map),
 			 "Illegal synchronize_rcu_expedited() in RCU read-side critical section");
 
+	use_worker = (rcu_scheduler_active != RCU_SCHEDULER_INIT) &&
+		      rcu_exp_worker_started();
+
 	/* Is the state is such that the call is a grace period? */
 	if (rcu_blocking_is_gp()) {
 		// Note well that this code runs with !PREEMPT && !SMP.
@@ -950,7 +963,7 @@ void synchronize_rcu_expedited(void)
 		return;  /* Someone else did our work for us. */
 
 	/* Ensure that load happens before action based on it. */
-	if (unlikely(boottime)) {
+	if (unlikely(!use_worker)) {
 		/* Direct call during scheduler init and early_initcalls(). */
 		rcu_exp_sel_wait_wake(s);
 	} else {
@@ -968,7 +981,7 @@ void synchronize_rcu_expedited(void)
 	/* Let the next expedited grace period start. */
 	mutex_unlock(&rcu_state.exp_mutex);
 
-	if (likely(!boottime))
+	if (likely(use_worker))
 		synchronize_rcu_expedited_destroy_work(&rew);
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
-- 
2.43.0


