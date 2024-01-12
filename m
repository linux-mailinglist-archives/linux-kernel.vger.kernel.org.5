Return-Path: <linux-kernel+bounces-24822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D86482C304
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE251C21A41
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE3B745E9;
	Fri, 12 Jan 2024 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWqY4Itv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053B1745DD;
	Fri, 12 Jan 2024 15:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C57C43390;
	Fri, 12 Jan 2024 15:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705074400;
	bh=eRD9p7kQfk59EpEoFx0hyM9cqrA750l1QKynzHAEjBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iWqY4ItvYn/nlg+ThvpzoZmAGs/jIV+67i8VsPEXEae22c4PqUqPVjG5/Es9L9/cH
	 MVnPX0UQ+TC1bA4tjGVTMrUmwFwpiwYZdvKA0sUDEGQtxhckBPOjSHiwtrV4V60d0o
	 mIfeTXKDqQh3+F594UCw65oHTiXxJnWyJeCeWuZw19Hhjl0VIe56RRaLRtxnWfEVlN
	 mdpzwcB0vahoysza8T6RAWQkAtsBDjoIDKTrA9z002TjOyLXLXTO9KeJpGa4fRmH7B
	 UClUcnjoMyIuMgb/utu957OSGEkKyDqMOxkulGaffBmSgu2TI+dFADCASmJrPsLD9i
	 360pRstM54iNg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 4/7] rcu/exp: Move expedited kthread worker creation functions above rcutree_prepare_cpu()
Date: Fri, 12 Jan 2024 16:46:18 +0100
Message-Id: <20240112154621.261852-5-frederic@kernel.org>
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

The expedited kthread worker performing the per node initialization is
going to be split into per node kthreads. As such, the future per node
kthread creation will need to be called from CPU hotplug callbacks
instead of an initcall, right beside the per node boost kthread
creation.

To prepare for that, move the kthread worker creation above
rcutree_prepare_cpu() as a first step to make the review smoother for
the upcoming modifications.

No intended functional change.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c | 96 +++++++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0c818e75e8e2..8f4fc8882e93 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4405,6 +4405,54 @@ rcu_boot_init_percpu_data(int cpu)
 	rcu_boot_init_nocb_percpu_data(rdp);
 }
 
+#ifdef CONFIG_RCU_EXP_KTHREAD
+struct kthread_worker *rcu_exp_gp_kworker;
+struct kthread_worker *rcu_exp_par_gp_kworker;
+
+static void __init rcu_start_exp_gp_kworkers(void)
+{
+	const char *par_gp_kworker_name = "rcu_exp_par_gp_kthread_worker";
+	const char *gp_kworker_name = "rcu_exp_gp_kthread_worker";
+	struct sched_param param = { .sched_priority = kthread_prio };
+
+	rcu_exp_gp_kworker = kthread_create_worker(0, gp_kworker_name);
+	if (IS_ERR_OR_NULL(rcu_exp_gp_kworker)) {
+		pr_err("Failed to create %s!\n", gp_kworker_name);
+		rcu_exp_gp_kworker = NULL;
+		return;
+	}
+
+	rcu_exp_par_gp_kworker = kthread_create_worker(0, par_gp_kworker_name);
+	if (IS_ERR_OR_NULL(rcu_exp_par_gp_kworker)) {
+		pr_err("Failed to create %s!\n", par_gp_kworker_name);
+		rcu_exp_par_gp_kworker = NULL;
+		kthread_destroy_worker(rcu_exp_gp_kworker);
+		rcu_exp_gp_kworker = NULL;
+		return;
+	}
+
+	sched_setscheduler_nocheck(rcu_exp_gp_kworker->task, SCHED_FIFO, &param);
+	sched_setscheduler_nocheck(rcu_exp_par_gp_kworker->task, SCHED_FIFO,
+				   &param);
+}
+
+static inline void rcu_alloc_par_gp_wq(void)
+{
+}
+#else /* !CONFIG_RCU_EXP_KTHREAD */
+struct workqueue_struct *rcu_par_gp_wq;
+
+static void __init rcu_start_exp_gp_kworkers(void)
+{
+}
+
+static inline void rcu_alloc_par_gp_wq(void)
+{
+	rcu_par_gp_wq = alloc_workqueue("rcu_par_gp", WQ_MEM_RECLAIM, 0);
+	WARN_ON(!rcu_par_gp_wq);
+}
+#endif /* CONFIG_RCU_EXP_KTHREAD */
+
 /*
  * Invoked early in the CPU-online process, when pretty much all services
  * are available.  The incoming CPU is not present.
@@ -4741,54 +4789,6 @@ static int rcu_pm_notify(struct notifier_block *self,
 	return NOTIFY_OK;
 }
 
-#ifdef CONFIG_RCU_EXP_KTHREAD
-struct kthread_worker *rcu_exp_gp_kworker;
-struct kthread_worker *rcu_exp_par_gp_kworker;
-
-static void __init rcu_start_exp_gp_kworkers(void)
-{
-	const char *par_gp_kworker_name = "rcu_exp_par_gp_kthread_worker";
-	const char *gp_kworker_name = "rcu_exp_gp_kthread_worker";
-	struct sched_param param = { .sched_priority = kthread_prio };
-
-	rcu_exp_gp_kworker = kthread_create_worker(0, gp_kworker_name);
-	if (IS_ERR_OR_NULL(rcu_exp_gp_kworker)) {
-		pr_err("Failed to create %s!\n", gp_kworker_name);
-		rcu_exp_gp_kworker = NULL;
-		return;
-	}
-
-	rcu_exp_par_gp_kworker = kthread_create_worker(0, par_gp_kworker_name);
-	if (IS_ERR_OR_NULL(rcu_exp_par_gp_kworker)) {
-		pr_err("Failed to create %s!\n", par_gp_kworker_name);
-		rcu_exp_par_gp_kworker = NULL;
-		kthread_destroy_worker(rcu_exp_gp_kworker);
-		rcu_exp_gp_kworker = NULL;
-		return;
-	}
-
-	sched_setscheduler_nocheck(rcu_exp_gp_kworker->task, SCHED_FIFO, &param);
-	sched_setscheduler_nocheck(rcu_exp_par_gp_kworker->task, SCHED_FIFO,
-				   &param);
-}
-
-static inline void rcu_alloc_par_gp_wq(void)
-{
-}
-#else /* !CONFIG_RCU_EXP_KTHREAD */
-struct workqueue_struct *rcu_par_gp_wq;
-
-static void __init rcu_start_exp_gp_kworkers(void)
-{
-}
-
-static inline void rcu_alloc_par_gp_wq(void)
-{
-	rcu_par_gp_wq = alloc_workqueue("rcu_par_gp", WQ_MEM_RECLAIM, 0);
-	WARN_ON(!rcu_par_gp_wq);
-}
-#endif /* CONFIG_RCU_EXP_KTHREAD */
-
 /*
  * Spawn the kthreads that handle RCU's grace periods.
  */
-- 
2.34.1


