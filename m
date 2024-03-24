Return-Path: <linux-kernel+bounces-112890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A7A887F85
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C351F1F2103C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C8E43149;
	Sun, 24 Mar 2024 22:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1trqFIo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672843FB8B;
	Sun, 24 Mar 2024 22:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319701; cv=none; b=MzpVS+iXrVGZQ2BD2S/PYlgg81XpCa91oNLesKGGcTFVkvVebhc5R9RWcUNGlmqViHt4PTVtE6ttI6XNOsmbX7Gy/UqlJxOJcLrr9egFtwZsZsnDZpKZkXWAwxLSmkePp1No9ySlgzyF6lAMrKQivL4xKLhLafE2kcYOAP1bFNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319701; c=relaxed/simple;
	bh=VjgA9eV7DuaiugXZY3qZanrdV+wvoAHbsCqc6iB2qSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYv2uHDT1/KUKezT9SmfIFx5Ixe49FiS+u63LL4T6drML56TFi08c9DnTCr+JhVIcgd3gBc4VfFdVMp1b5pKIecgtDaot1FnEL32dJTwaxtiTYFhmsCW5xYAzIZy1QKKYEPlFWKZRXZLac37rsg8h9IVoG6RWJSEKxEOn0uQl1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1trqFIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58043C433C7;
	Sun, 24 Mar 2024 22:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319701;
	bh=VjgA9eV7DuaiugXZY3qZanrdV+wvoAHbsCqc6iB2qSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n1trqFIoY4QeV3CzugjEbTdCk0tADoyaTZVQ0ONq1aq8yjCJFWZNXJLvIsnjK4O4C
	 xIOkWUonJcAC7o5fKuggwGxiFtt3dQR7Gvxzcs6yVU4W2tdPtv8zU9SsCw5zMIHFA3
	 IV9ir3dqE81Jj7lAxjF/HCxxLQrMWmU3mhOsNj2Wq+qwNNmzKZMVME1szkQ5L11/lw
	 GsZc4Hg3Hq/WLxSBye+YyzYULq7mdh2tmW1rDiZiTHo7kJnbo7R+RHdd4Tcij0RekM
	 jFKF0Y+Nq5iQlQR3G+SaM6RPr82Fq+T5Ok6H9WXyXU4OA3lqRZQz1n49K7ejw2Pv/Z
	 IXkQc3b1NqsNw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 003/715] workqueue: Move pwq->max_active to wq->max_active
Date: Sun, 24 Mar 2024 18:23:02 -0400
Message-ID: <20240324223455.1342824-4-sashal@kernel.org>
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

From: Tejun Heo <tj@kernel.org>

[ Upstream commit a045a272d887575da17ad86d6573e82871b50c27 ]

max_active is a workqueue-wide setting and the configured value is stored in
wq->saved_max_active; however, the effective value was stored in
pwq->max_active. While this is harmless, it makes max_active update process
more complicated and gets in the way of the planned max_active semantic
updates for unbound workqueues.

This patches moves pwq->max_active to wq->max_active. This simplifies the
code and makes freezing and noop max_active updates cheaper too. No
user-visible behavior change is intended.

As wq->max_active is updated while holding wq mutex but read without any
locking, it now uses WRITE/READ_ONCE(). A new locking locking rule WO is
added for it.

v2: wq->max_active now uses WRITE/READ_ONCE() as suggested by Lai.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
Stable-dep-of: 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/workqueue.c | 133 ++++++++++++++++++++++-----------------------
 1 file changed, 66 insertions(+), 67 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 8a06fddb23e66..8ee754dd319da 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -143,6 +143,9 @@ enum {
  *
  * WR: wq->mutex protected for writes.  RCU protected for reads.
  *
+ * WO: wq->mutex protected for writes. Updated with WRITE_ONCE() and can be read
+ *     with READ_ONCE() without locking.
+ *
  * MD: wq_mayday_lock protected.
  *
  * WD: Used internally by the watchdog.
@@ -250,7 +253,6 @@ struct pool_workqueue {
 	 * is marked with WORK_STRUCT_INACTIVE iff it is in pwq->inactive_works.
 	 */
 	int			nr_active;	/* L: nr of active works */
-	int			max_active;	/* L: max active works */
 	struct list_head	inactive_works;	/* L: inactive works */
 	struct list_head	pwqs_node;	/* WR: node on wq->pwqs */
 	struct list_head	mayday_node;	/* MD: node on wq->maydays */
@@ -298,7 +300,8 @@ struct workqueue_struct {
 	struct worker		*rescuer;	/* MD: rescue worker */
 
 	int			nr_drainers;	/* WQ: drain in progress */
-	int			saved_max_active; /* WQ: saved pwq max_active */
+	int			max_active;	/* WO: max active works */
+	int			saved_max_active; /* WQ: saved max_active */
 
 	struct workqueue_attrs	*unbound_attrs;	/* PW: only for unbound wqs */
 	struct pool_workqueue	*dfl_pwq;	/* PW: only for unbound wqs */
@@ -1492,7 +1495,7 @@ static void pwq_dec_nr_in_flight(struct pool_workqueue *pwq, unsigned long work_
 		pwq->nr_active--;
 		if (!list_empty(&pwq->inactive_works)) {
 			/* one down, submit an inactive one */
-			if (pwq->nr_active < pwq->max_active)
+			if (pwq->nr_active < READ_ONCE(pwq->wq->max_active))
 				pwq_activate_first_inactive(pwq);
 		}
 	}
@@ -1793,7 +1796,13 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	pwq->nr_in_flight[pwq->work_color]++;
 	work_flags = work_color_to_flags(pwq->work_color);
 
-	if (likely(pwq->nr_active < pwq->max_active)) {
+	/*
+	 * Limit the number of concurrently active work items to max_active.
+	 * @work must also queue behind existing inactive work items to maintain
+	 * ordering when max_active changes. See wq_adjust_max_active().
+	 */
+	if (list_empty(&pwq->inactive_works) &&
+	    pwq->nr_active < READ_ONCE(pwq->wq->max_active)) {
 		if (list_empty(&pool->worklist))
 			pool->watchdog_ts = jiffies;
 
@@ -4142,50 +4151,6 @@ static void pwq_release_workfn(struct kthread_work *work)
 	}
 }
 
-/**
- * pwq_adjust_max_active - update a pwq's max_active to the current setting
- * @pwq: target pool_workqueue
- *
- * If @pwq isn't freezing, set @pwq->max_active to the associated
- * workqueue's saved_max_active and activate inactive work items
- * accordingly.  If @pwq is freezing, clear @pwq->max_active to zero.
- */
-static void pwq_adjust_max_active(struct pool_workqueue *pwq)
-{
-	struct workqueue_struct *wq = pwq->wq;
-	bool freezable = wq->flags & WQ_FREEZABLE;
-	unsigned long flags;
-
-	/* for @wq->saved_max_active */
-	lockdep_assert_held(&wq->mutex);
-
-	/* fast exit for non-freezable wqs */
-	if (!freezable && pwq->max_active == wq->saved_max_active)
-		return;
-
-	/* this function can be called during early boot w/ irq disabled */
-	raw_spin_lock_irqsave(&pwq->pool->lock, flags);
-
-	/*
-	 * During [un]freezing, the caller is responsible for ensuring that
-	 * this function is called at least once after @workqueue_freezing
-	 * is updated and visible.
-	 */
-	if (!freezable || !workqueue_freezing) {
-		pwq->max_active = wq->saved_max_active;
-
-		while (!list_empty(&pwq->inactive_works) &&
-		       pwq->nr_active < pwq->max_active)
-			pwq_activate_first_inactive(pwq);
-
-		kick_pool(pwq->pool);
-	} else {
-		pwq->max_active = 0;
-	}
-
-	raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
-}
-
 /* initialize newly allocated @pwq which is associated with @wq and @pool */
 static void init_pwq(struct pool_workqueue *pwq, struct workqueue_struct *wq,
 		     struct worker_pool *pool)
@@ -4218,9 +4183,6 @@ static void link_pwq(struct pool_workqueue *pwq)
 	/* set the matching work_color */
 	pwq->work_color = wq->work_color;
 
-	/* sync max_active to the current setting */
-	pwq_adjust_max_active(pwq);
-
 	/* link in @pwq */
 	list_add_rcu(&pwq->pwqs_node, &wq->pwqs);
 }
@@ -4658,6 +4620,52 @@ static int init_rescuer(struct workqueue_struct *wq)
 	return 0;
 }
 
+/**
+ * wq_adjust_max_active - update a wq's max_active to the current setting
+ * @wq: target workqueue
+ *
+ * If @wq isn't freezing, set @wq->max_active to the saved_max_active and
+ * activate inactive work items accordingly. If @wq is freezing, clear
+ * @wq->max_active to zero.
+ */
+static void wq_adjust_max_active(struct workqueue_struct *wq)
+{
+	struct pool_workqueue *pwq;
+
+	lockdep_assert_held(&wq->mutex);
+
+	if ((wq->flags & WQ_FREEZABLE) && workqueue_freezing) {
+		WRITE_ONCE(wq->max_active, 0);
+		return;
+	}
+
+	if (wq->max_active == wq->saved_max_active)
+		return;
+
+	/*
+	 * Update @wq->max_active and then kick inactive work items if more
+	 * active work items are allowed. This doesn't break work item ordering
+	 * because new work items are always queued behind existing inactive
+	 * work items if there are any.
+	 */
+	WRITE_ONCE(wq->max_active, wq->saved_max_active);
+
+	for_each_pwq(pwq, wq) {
+		unsigned long flags;
+
+		/* this function can be called during early boot w/ irq disabled */
+		raw_spin_lock_irqsave(&pwq->pool->lock, flags);
+
+		while (!list_empty(&pwq->inactive_works) &&
+		       pwq->nr_active < wq->max_active)
+			pwq_activate_first_inactive(pwq);
+
+		kick_pool(pwq->pool);
+
+		raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
+	}
+}
+
 __printf(1, 4)
 struct workqueue_struct *alloc_workqueue(const char *fmt,
 					 unsigned int flags,
@@ -4665,7 +4673,6 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 {
 	va_list args;
 	struct workqueue_struct *wq;
-	struct pool_workqueue *pwq;
 	int len;
 
 	/*
@@ -4704,6 +4711,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 
 	/* init wq */
 	wq->flags = flags;
+	wq->max_active = max_active;
 	wq->saved_max_active = max_active;
 	mutex_init(&wq->mutex);
 	atomic_set(&wq->nr_pwqs_to_flush, 0);
@@ -4732,8 +4740,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	mutex_lock(&wq_pool_mutex);
 
 	mutex_lock(&wq->mutex);
-	for_each_pwq(pwq, wq)
-		pwq_adjust_max_active(pwq);
+	wq_adjust_max_active(wq);
 	mutex_unlock(&wq->mutex);
 
 	list_add_tail_rcu(&wq->list, &workqueues);
@@ -4871,8 +4878,6 @@ EXPORT_SYMBOL_GPL(destroy_workqueue);
  */
 void workqueue_set_max_active(struct workqueue_struct *wq, int max_active)
 {
-	struct pool_workqueue *pwq;
-
 	/* disallow meddling with max_active for ordered workqueues */
 	if (WARN_ON(wq->flags & __WQ_ORDERED_EXPLICIT))
 		return;
@@ -4883,9 +4888,7 @@ void workqueue_set_max_active(struct workqueue_struct *wq, int max_active)
 
 	wq->flags &= ~__WQ_ORDERED;
 	wq->saved_max_active = max_active;
-
-	for_each_pwq(pwq, wq)
-		pwq_adjust_max_active(pwq);
+	wq_adjust_max_active(wq);
 
 	mutex_unlock(&wq->mutex);
 }
@@ -5132,8 +5135,8 @@ static void show_pwq(struct pool_workqueue *pwq)
 	pr_info("  pwq %d:", pool->id);
 	pr_cont_pool_info(pool);
 
-	pr_cont(" active=%d/%d refcnt=%d%s\n",
-		pwq->nr_active, pwq->max_active, pwq->refcnt,
+	pr_cont(" active=%d refcnt=%d%s\n",
+		pwq->nr_active, pwq->refcnt,
 		!list_empty(&pwq->mayday_node) ? " MAYDAY" : "");
 
 	hash_for_each(pool->busy_hash, bkt, worker, hentry) {
@@ -5681,7 +5684,6 @@ EXPORT_SYMBOL_GPL(work_on_cpu_safe_key);
 void freeze_workqueues_begin(void)
 {
 	struct workqueue_struct *wq;
-	struct pool_workqueue *pwq;
 
 	mutex_lock(&wq_pool_mutex);
 
@@ -5690,8 +5692,7 @@ void freeze_workqueues_begin(void)
 
 	list_for_each_entry(wq, &workqueues, list) {
 		mutex_lock(&wq->mutex);
-		for_each_pwq(pwq, wq)
-			pwq_adjust_max_active(pwq);
+		wq_adjust_max_active(wq);
 		mutex_unlock(&wq->mutex);
 	}
 
@@ -5756,7 +5757,6 @@ bool freeze_workqueues_busy(void)
 void thaw_workqueues(void)
 {
 	struct workqueue_struct *wq;
-	struct pool_workqueue *pwq;
 
 	mutex_lock(&wq_pool_mutex);
 
@@ -5768,8 +5768,7 @@ void thaw_workqueues(void)
 	/* restore max_active and repopulate worklist */
 	list_for_each_entry(wq, &workqueues, list) {
 		mutex_lock(&wq->mutex);
-		for_each_pwq(pwq, wq)
-			pwq_adjust_max_active(pwq);
+		wq_adjust_max_active(wq);
 		mutex_unlock(&wq->mutex);
 	}
 
-- 
2.43.0


