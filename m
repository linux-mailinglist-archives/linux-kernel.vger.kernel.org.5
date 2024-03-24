Return-Path: <linux-kernel+bounces-115323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE49889F3B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F76EB3009D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F70A1DF79F;
	Mon, 25 Mar 2024 02:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhQmHO44"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143C5811E0;
	Sun, 24 Mar 2024 22:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320526; cv=none; b=GvmJheYr49q/18PTlIXQO86iftVCNSTqFw1eKXcl1Zjt2Vse+3wwrLSAkGTB7gyCx55mIVzapZBjbPA1/8x/5notZoKZPDmq8348XupuEbtQh9ue3Yy+IDsuVXWa7jrN+IzlSPaoTpfR5dFrg8WULT5eD3/fl0MI9iGqzLNbzWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320526; c=relaxed/simple;
	bh=dUmGfVrxL7Wmgc2JNjSO7HBgRSs477Viq3KsCfXDnYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QwiGsiktSt94hDXTDURK8pgvZlwAIgLtsjkCtZNev0iSYeZQUen/6IkC2mrss14no5XoLVRQMG/0vyYCKeLzKwKrdgFOQQHO4jGwEwSY9FPTr36dQOZcFGXvyhQl+UlkYOkjV/jphfygmcR/v4Ea87XHDZZIp2EVVfoxY44hBvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhQmHO44; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DC9C43390;
	Sun, 24 Mar 2024 22:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320525;
	bh=dUmGfVrxL7Wmgc2JNjSO7HBgRSs477Viq3KsCfXDnYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GhQmHO44yvtwpC4nIkRiDN1YQZXv+PVTLb4nfzaIyDwbxd3gArTPh1zzBu4zScqVP
	 TDzo0hy7bIMMldwsUIOUWE7EBB3a4cKuv9XBEfhhi0t6volJSzZMLzLSqdCl33znQe
	 nbaDLAdKXihjw4P5/2BLr1yZOmanf4CPsG3NF04bu+/dCBb29nX4RUtzBIXkl/wJz1
	 nXCraobOMPIkIwBSviZ/1h0GxYzSI4nCDNHrRqQHyELyBTBeB8zmH1Oo6l8WpuaBcV
	 8AnJyF/CfLx0ZxxL/tIwh9ipsmOF4n/EY+uURLs4cK2fL4MKGay6OzsF4+l/w4x+JK
	 dteqF0FWorJgg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 086/713] workqueue: Move nr_active handling into helpers
Date: Sun, 24 Mar 2024 18:36:52 -0400
Message-ID: <20240324224720.1345309-87-sashal@kernel.org>
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

[ Upstream commit 1c270b79ce0b8290f146255ea9057243f6dd3c17 ]

__queue_work(), pwq_dec_nr_in_flight() and wq_adjust_max_active() were
open-coding nr_active handling, which is fine given that the operations are
trivial. However, the planned unbound nr_active update will make them more
complicated, so let's move them into helpers.

- pwq_tryinc_nr_active() is added. It increments nr_active if under
  max_active limit and return a boolean indicating whether inc was
  successful. Note that the function is structured to accommodate future
  changes. __queue_work() is updated to use the new helper.

- pwq_activate_first_inactive() is updated to use pwq_tryinc_nr_active() and
  thus no longer assumes that nr_active is under max_active and returns a
  boolean to indicate whether a work item has been activated.

- wq_adjust_max_active() no longer tests directly whether a work item can be
  activated. Instead, it's updated to use the return value of
  pwq_activate_first_inactive() to tell whether a work item has been
  activated.

- nr_active decrement and activating the first inactive work item is
  factored into pwq_dec_nr_active().

v3: - WARN_ON_ONCE(!WORK_STRUCT_INACTIVE) added to __pwq_activate_work() as
      now we're calling the function unconditionally from
      pwq_activate_first_inactive().

v2: - wq->max_active now uses WRITE/READ_ONCE() as suggested by Lai.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
Stable-dep-of: 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/workqueue.c | 86 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 67 insertions(+), 19 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 861d8c7d6449a..78b4f4e3e41dd 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1458,11 +1458,14 @@ static bool pwq_is_empty(struct pool_workqueue *pwq)
 static void __pwq_activate_work(struct pool_workqueue *pwq,
 				struct work_struct *work)
 {
+	unsigned long *wdb = work_data_bits(work);
+
+	WARN_ON_ONCE(!(*wdb & WORK_STRUCT_INACTIVE));
 	trace_workqueue_activate_work(work);
 	if (list_empty(&pwq->pool->worklist))
 		pwq->pool->watchdog_ts = jiffies;
 	move_linked_works(work, &pwq->pool->worklist, NULL);
-	__clear_bit(WORK_STRUCT_INACTIVE_BIT, work_data_bits(work));
+	__clear_bit(WORK_STRUCT_INACTIVE_BIT, wdb);
 }
 
 /**
@@ -1487,12 +1490,66 @@ static bool pwq_activate_work(struct pool_workqueue *pwq,
 	return true;
 }
 
-static void pwq_activate_first_inactive(struct pool_workqueue *pwq)
+/**
+ * pwq_tryinc_nr_active - Try to increment nr_active for a pwq
+ * @pwq: pool_workqueue of interest
+ *
+ * Try to increment nr_active for @pwq. Returns %true if an nr_active count is
+ * successfully obtained. %false otherwise.
+ */
+static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq)
+{
+	struct workqueue_struct *wq = pwq->wq;
+	struct worker_pool *pool = pwq->pool;
+	bool obtained;
+
+	lockdep_assert_held(&pool->lock);
+
+	obtained = pwq->nr_active < READ_ONCE(wq->max_active);
+
+	if (obtained)
+		pwq->nr_active++;
+	return obtained;
+}
+
+/**
+ * pwq_activate_first_inactive - Activate the first inactive work item on a pwq
+ * @pwq: pool_workqueue of interest
+ *
+ * Activate the first inactive work item of @pwq if available and allowed by
+ * max_active limit.
+ *
+ * Returns %true if an inactive work item has been activated. %false if no
+ * inactive work item is found or max_active limit is reached.
+ */
+static bool pwq_activate_first_inactive(struct pool_workqueue *pwq)
+{
+	struct work_struct *work =
+		list_first_entry_or_null(&pwq->inactive_works,
+					 struct work_struct, entry);
+
+	if (work && pwq_tryinc_nr_active(pwq)) {
+		__pwq_activate_work(pwq, work);
+		return true;
+	} else {
+		return false;
+	}
+}
+
+/**
+ * pwq_dec_nr_active - Retire an active count
+ * @pwq: pool_workqueue of interest
+ *
+ * Decrement @pwq's nr_active and try to activate the first inactive work item.
+ */
+static void pwq_dec_nr_active(struct pool_workqueue *pwq)
 {
-	struct work_struct *work = list_first_entry(&pwq->inactive_works,
-						    struct work_struct, entry);
+	struct worker_pool *pool = pwq->pool;
 
-	pwq_activate_work(pwq, work);
+	lockdep_assert_held(&pool->lock);
+
+	pwq->nr_active--;
+	pwq_activate_first_inactive(pwq);
 }
 
 /**
@@ -1510,14 +1567,8 @@ static void pwq_dec_nr_in_flight(struct pool_workqueue *pwq, unsigned long work_
 {
 	int color = get_work_color(work_data);
 
-	if (!(work_data & WORK_STRUCT_INACTIVE)) {
-		pwq->nr_active--;
-		if (!list_empty(&pwq->inactive_works)) {
-			/* one down, submit an inactive one */
-			if (pwq->nr_active < READ_ONCE(pwq->wq->max_active))
-				pwq_activate_first_inactive(pwq);
-		}
-	}
+	if (!(work_data & WORK_STRUCT_INACTIVE))
+		pwq_dec_nr_active(pwq);
 
 	pwq->nr_in_flight[color]--;
 
@@ -1819,13 +1870,11 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	 * @work must also queue behind existing inactive work items to maintain
 	 * ordering when max_active changes. See wq_adjust_max_active().
 	 */
-	if (list_empty(&pwq->inactive_works) &&
-	    pwq->nr_active < READ_ONCE(pwq->wq->max_active)) {
+	if (list_empty(&pwq->inactive_works) && pwq_tryinc_nr_active(pwq)) {
 		if (list_empty(&pool->worklist))
 			pool->watchdog_ts = jiffies;
 
 		trace_workqueue_activate_work(work);
-		pwq->nr_active++;
 		insert_work(pwq, work, &pool->worklist, work_flags);
 		kick_pool(pool);
 	} else {
@@ -4687,9 +4736,8 @@ static void wq_adjust_max_active(struct workqueue_struct *wq)
 		/* this function can be called during early boot w/ irq disabled */
 		raw_spin_lock_irqsave(&pwq->pool->lock, flags);
 
-		while (!list_empty(&pwq->inactive_works) &&
-		       pwq->nr_active < wq->max_active)
-			pwq_activate_first_inactive(pwq);
+		while (pwq_activate_first_inactive(pwq))
+			;
 
 		kick_pool(pwq->pool);
 
-- 
2.43.0


