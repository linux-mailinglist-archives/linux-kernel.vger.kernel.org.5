Return-Path: <linux-kernel+bounces-115330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA30889ACD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72A002A55A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C6D1E1694;
	Mon, 25 Mar 2024 02:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFTcr+OU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F138120A;
	Sun, 24 Mar 2024 22:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320527; cv=none; b=X1NvMg9/wJ+0v+Z/XNh8COO2BJtfmybYzdqo30G8jXU8FnBifQXwjAJEKJx1QPP4uYFN1vGoSfjRBEv6NlQomq1WQrKO8L1n7poZPDz4XV2lI9XnoATrR/2yNlJFoOHFQd0bnW0kiswLgqBAYwhN9l4NAluuI1IgDJ+CzaGplHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320527; c=relaxed/simple;
	bh=OpbSXIs9k98gbYogvjWK31VrjqjDrXBfziuOBKHJiw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DuaFNUnZr4Ugd6n/KiXORrsl7iBYYk4UuCWI0P5z2MOXXMfrasz/SBy/JKyIGe29b2wXNSVCb2/N/UFEZo+T4w+ld2WLioKdRWi2YmfXO3vmx4j7ODrbfvEh299seUxboN7tuEgkY892kxYQJPfklXQkWrD6MI65bvKAXgdtxjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFTcr+OU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC93C433C7;
	Sun, 24 Mar 2024 22:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320526;
	bh=OpbSXIs9k98gbYogvjWK31VrjqjDrXBfziuOBKHJiw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OFTcr+OUneQA9qpVMqeSPRz8LJIuvl+AHVkz6vLnSYewPyA7Ye8fftWLn4YADaT0d
	 NGEC+rPNgOabG//TB4pLTtNcIrplfHRMjp9MCfaqbydoT1jwEnbIGp2jaLDZsZ+zYg
	 /YGI+j3I3VPdlLI+1UoT/lqX0WnfWNRJDuoY2C+zmQrt20NsXmpr5YDOOm2A4JNu9z
	 bhwp0MJlTIEPZXo/vdf+Efa83131vZ2y+r/tSB393rJs1/ujU1H0C5GrkIA8ufv2JC
	 tvL5BdRMPHV0z60L20xPu0Xdc/Ne+ll0bD/n6v2Dlqv6KgIR4Ga5LuMB7rFdDQ4tP/
	 CzdZCy9pmeRdg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 088/713] workqueue: RCU protect wq->dfl_pwq and implement accessors for it
Date: Sun, 24 Mar 2024 18:36:54 -0400
Message-ID: <20240324224720.1345309-89-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 9f66cff212bb3c1cd25996aaa0dfd0c9e9d8baab ]

wq->cpu_pwq is RCU protected but wq->dfl_pwq isn't. This is okay because
currently wq->dfl_pwq is used only accessed to install it into wq->cpu_pwq
which doesn't require RCU access. However, we want to be able to access
wq->dfl_pwq under RCU in the future to access its __pod_cpumask and the code
can be made easier to read by making the two pwq fields behave in the same
way.

- Make wq->dfl_pwq RCU protected.

- Add unbound_pwq_slot() and unbound_pwq() which can access both ->dfl_pwq
  and ->cpu_pwq. The former returns the double pointer that can be used
  access and update the pwqs. The latter performs locking check and
  dereferences the double pointer.

- pwq accesses and updates are converted to use unbound_pwq[_slot]().

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
Stable-dep-of: 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/workqueue.c | 64 +++++++++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 24 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 059f122563def..53bebd8c8b457 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -304,7 +304,7 @@ struct workqueue_struct {
 	int			saved_max_active; /* WQ: saved max_active */
 
 	struct workqueue_attrs	*unbound_attrs;	/* PW: only for unbound wqs */
-	struct pool_workqueue	*dfl_pwq;	/* PW: only for unbound wqs */
+	struct pool_workqueue __rcu *dfl_pwq;   /* PW: only for unbound wqs */
 
 #ifdef CONFIG_SYSFS
 	struct wq_device	*wq_dev;	/* I: for sysfs interface */
@@ -629,6 +629,23 @@ static int worker_pool_assign_id(struct worker_pool *pool)
 	return ret;
 }
 
+static struct pool_workqueue __rcu **
+unbound_pwq_slot(struct workqueue_struct *wq, int cpu)
+{
+       if (cpu >= 0)
+               return per_cpu_ptr(wq->cpu_pwq, cpu);
+       else
+               return &wq->dfl_pwq;
+}
+
+/* @cpu < 0 for dfl_pwq */
+static struct pool_workqueue *unbound_pwq(struct workqueue_struct *wq, int cpu)
+{
+	return rcu_dereference_check(*unbound_pwq_slot(wq, cpu),
+				     lockdep_is_held(&wq_pool_mutex) ||
+				     lockdep_is_held(&wq->mutex));
+}
+
 static unsigned int work_color_to_flags(int color)
 {
 	return color << WORK_STRUCT_COLOR_SHIFT;
@@ -4318,10 +4335,11 @@ static void wq_calc_pod_cpumask(struct workqueue_attrs *attrs, int cpu,
 				"possible intersect\n");
 }
 
-/* install @pwq into @wq's cpu_pwq and return the old pwq */
+/* install @pwq into @wq and return the old pwq, @cpu < 0 for dfl_pwq */
 static struct pool_workqueue *install_unbound_pwq(struct workqueue_struct *wq,
 					int cpu, struct pool_workqueue *pwq)
 {
+	struct pool_workqueue __rcu **slot = unbound_pwq_slot(wq, cpu);
 	struct pool_workqueue *old_pwq;
 
 	lockdep_assert_held(&wq_pool_mutex);
@@ -4330,8 +4348,8 @@ static struct pool_workqueue *install_unbound_pwq(struct workqueue_struct *wq,
 	/* link_pwq() can handle duplicate calls */
 	link_pwq(pwq);
 
-	old_pwq = rcu_access_pointer(*per_cpu_ptr(wq->cpu_pwq, cpu));
-	rcu_assign_pointer(*per_cpu_ptr(wq->cpu_pwq, cpu), pwq);
+	old_pwq = rcu_access_pointer(*slot);
+	rcu_assign_pointer(*slot, pwq);
 	return old_pwq;
 }
 
@@ -4431,14 +4449,11 @@ static void apply_wqattrs_commit(struct apply_wqattrs_ctx *ctx)
 
 	copy_workqueue_attrs(ctx->wq->unbound_attrs, ctx->attrs);
 
-	/* save the previous pwq and install the new one */
+	/* save the previous pwqs and install the new ones */
 	for_each_possible_cpu(cpu)
 		ctx->pwq_tbl[cpu] = install_unbound_pwq(ctx->wq, cpu,
 							ctx->pwq_tbl[cpu]);
-
-	/* @dfl_pwq might not have been used, ensure it's linked */
-	link_pwq(ctx->dfl_pwq);
-	swap(ctx->wq->dfl_pwq, ctx->dfl_pwq);
+	ctx->dfl_pwq = install_unbound_pwq(ctx->wq, -1, ctx->dfl_pwq);
 
 	mutex_unlock(&ctx->wq->mutex);
 }
@@ -4561,9 +4576,7 @@ static void wq_update_pod(struct workqueue_struct *wq, int cpu,
 
 	/* nothing to do if the target cpumask matches the current pwq */
 	wq_calc_pod_cpumask(target_attrs, cpu, off_cpu);
-	pwq = rcu_dereference_protected(*per_cpu_ptr(wq->cpu_pwq, cpu),
-					lockdep_is_held(&wq_pool_mutex));
-	if (wqattrs_equal(target_attrs, pwq->pool->attrs))
+	if (wqattrs_equal(target_attrs, unbound_pwq(wq, cpu)->pool->attrs))
 		return;
 
 	/* create a new pwq */
@@ -4581,10 +4594,11 @@ static void wq_update_pod(struct workqueue_struct *wq, int cpu,
 
 use_dfl_pwq:
 	mutex_lock(&wq->mutex);
-	raw_spin_lock_irq(&wq->dfl_pwq->pool->lock);
-	get_pwq(wq->dfl_pwq);
-	raw_spin_unlock_irq(&wq->dfl_pwq->pool->lock);
-	old_pwq = install_unbound_pwq(wq, cpu, wq->dfl_pwq);
+	pwq = unbound_pwq(wq, -1);
+	raw_spin_lock_irq(&pwq->pool->lock);
+	get_pwq(pwq);
+	raw_spin_unlock_irq(&pwq->pool->lock);
+	old_pwq = install_unbound_pwq(wq, cpu, pwq);
 out_unlock:
 	mutex_unlock(&wq->mutex);
 	put_pwq_unlocked(old_pwq);
@@ -4622,10 +4636,13 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 
 	cpus_read_lock();
 	if (wq->flags & __WQ_ORDERED) {
+		struct pool_workqueue *dfl_pwq;
+
 		ret = apply_workqueue_attrs(wq, ordered_wq_attrs[highpri]);
 		/* there should only be single pwq for ordering guarantee */
-		WARN(!ret && (wq->pwqs.next != &wq->dfl_pwq->pwqs_node ||
-			      wq->pwqs.prev != &wq->dfl_pwq->pwqs_node),
+		dfl_pwq = rcu_access_pointer(wq->dfl_pwq);
+		WARN(!ret && (wq->pwqs.next != &dfl_pwq->pwqs_node ||
+			      wq->pwqs.prev != &dfl_pwq->pwqs_node),
 		     "ordering guarantee broken for workqueue %s\n", wq->name);
 	} else {
 		ret = apply_workqueue_attrs(wq, unbound_std_wq_attrs[highpri]);
@@ -4856,7 +4873,7 @@ static bool pwq_busy(struct pool_workqueue *pwq)
 		if (pwq->nr_in_flight[i])
 			return true;
 
-	if ((pwq != pwq->wq->dfl_pwq) && (pwq->refcnt > 1))
+	if ((pwq != rcu_access_pointer(pwq->wq->dfl_pwq)) && (pwq->refcnt > 1))
 		return true;
 	if (!pwq_is_empty(pwq))
 		return true;
@@ -4940,13 +4957,12 @@ void destroy_workqueue(struct workqueue_struct *wq)
 	rcu_read_lock();
 
 	for_each_possible_cpu(cpu) {
-		pwq = rcu_access_pointer(*per_cpu_ptr(wq->cpu_pwq, cpu));
-		RCU_INIT_POINTER(*per_cpu_ptr(wq->cpu_pwq, cpu), NULL);
-		put_pwq_unlocked(pwq);
+		put_pwq_unlocked(unbound_pwq(wq, cpu));
+		RCU_INIT_POINTER(*unbound_pwq_slot(wq, cpu), NULL);
 	}
 
-	put_pwq_unlocked(wq->dfl_pwq);
-	wq->dfl_pwq = NULL;
+	put_pwq_unlocked(unbound_pwq(wq, -1));
+	RCU_INIT_POINTER(*unbound_pwq_slot(wq, -1), NULL);
 
 	rcu_read_unlock();
 }
-- 
2.43.0


