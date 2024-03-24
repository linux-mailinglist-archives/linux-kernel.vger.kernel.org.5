Return-Path: <linux-kernel+bounces-114072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E78588883E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB2ADB23F99
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DE723453D;
	Sun, 24 Mar 2024 23:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhmgTXAP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55BC1FEC77;
	Sun, 24 Mar 2024 23:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321361; cv=none; b=bbXqD54qd20Mv3fgnGHOIuivhWj2jfV9X5TZXEdcT9B7HnGpc1DGIzcU9400bQMWZjLoRcK9UCdtQJ3ojXrqIfjPB37a0V3A32V/Tvk2I++YpqNgOy4QRw7SguNEL0Nri1WehaGsYT68NnYjnMt8H4JrHuyy69Q8BZBYjRmBxFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321361; c=relaxed/simple;
	bh=LI6vEUK9JAbeco/CKxsnuzWccc8g9vABQTvNLTvFBRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrcW1YlwZtz7KdPlKIcv5/+5yALtfWEBEY5RtJXbJCXfSnqyt5lVo6FPum1nYT2qfs840RMQHFzpShUyqxeAlzMf5d2MEHdEUx2Ow29yHZ6fKnV8s3P9S9VypSk4UKZgI8mlEGvRfzzZWmMk3fSfk9opC4PDY64z1DXTSs0qCDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhmgTXAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F15C43390;
	Sun, 24 Mar 2024 23:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321360;
	bh=LI6vEUK9JAbeco/CKxsnuzWccc8g9vABQTvNLTvFBRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FhmgTXAPURSfopCduNfGBGgNRpRi9pSDTHI+i6bBmh83lXTa56ekmWZZ4iM42OfYk
	 tg74fV1/6kcn37QpD+T8x0hUuxFmJ9tvsaN86z/QHsQ3MvnyU9qu2EqOqTroET5KTu
	 m2IhcN7s0faLbAJPcs84adVAvtjxCkenYz/40vG+wM8KwBSFdNC8l5IHZg/zYqy/G+
	 2y1xBejL8ZGkl5vHzmzv47CXHCgcSGkbQvQIERVIe8KMK3bMSCK9DxsccHZfOJAuwZ
	 syQzbjsd6880LHA+6GX+V+8bA3YXCerL/AAEQHc5f56rvVq48qfa1lGx+nX3rXmxLD
	 8FDD34BSu/svQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 085/638] rcu/exp: Handle RCU expedited grace period kworker allocation failure
Date: Sun, 24 Mar 2024 18:52:02 -0400
Message-ID: <20240324230116.1348576-86-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 2e8d4572e8620..8cf6a6fef7965 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4671,6 +4671,7 @@ static void __init rcu_start_exp_gp_kworkers(void)
 	rcu_exp_gp_kworker = kthread_create_worker(0, gp_kworker_name);
 	if (IS_ERR_OR_NULL(rcu_exp_gp_kworker)) {
 		pr_err("Failed to create %s!\n", gp_kworker_name);
+		rcu_exp_gp_kworker = NULL;
 		return;
 	}
 
@@ -4679,6 +4680,7 @@ static void __init rcu_start_exp_gp_kworkers(void)
 		pr_err("Failed to create %s!\n", par_gp_kworker_name);
 		rcu_exp_par_gp_kworker = NULL;
 		kthread_destroy_worker(rcu_exp_gp_kworker);
+		rcu_exp_gp_kworker = NULL;
 		return;
 	}
 
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 6e87dc764f471..733b18077f5a0 100644
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
@@ -952,7 +962,7 @@ static void rcu_exp_print_detail_task_stall_rnp(struct rcu_node *rnp)
  */
 void synchronize_rcu_expedited(void)
 {
-	bool boottime = (rcu_scheduler_active == RCU_SCHEDULER_INIT);
+	bool use_worker;
 	unsigned long flags;
 	struct rcu_exp_work rew;
 	struct rcu_node *rnp;
@@ -963,6 +973,9 @@ void synchronize_rcu_expedited(void)
 			 lock_is_held(&rcu_sched_lock_map),
 			 "Illegal synchronize_rcu_expedited() in RCU read-side critical section");
 
+	use_worker = (rcu_scheduler_active != RCU_SCHEDULER_INIT) &&
+		      rcu_exp_worker_started();
+
 	/* Is the state is such that the call is a grace period? */
 	if (rcu_blocking_is_gp()) {
 		// Note well that this code runs with !PREEMPT && !SMP.
@@ -992,7 +1005,7 @@ void synchronize_rcu_expedited(void)
 		return;  /* Someone else did our work for us. */
 
 	/* Ensure that load happens before action based on it. */
-	if (unlikely(boottime)) {
+	if (unlikely(!use_worker)) {
 		/* Direct call during scheduler init and early_initcalls(). */
 		rcu_exp_sel_wait_wake(s);
 	} else {
@@ -1010,7 +1023,7 @@ void synchronize_rcu_expedited(void)
 	/* Let the next expedited grace period start. */
 	mutex_unlock(&rcu_state.exp_mutex);
 
-	if (likely(!boottime))
+	if (likely(use_worker))
 		synchronize_rcu_expedited_destroy_work(&rew);
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
-- 
2.43.0


