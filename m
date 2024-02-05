Return-Path: <linux-kernel+bounces-53859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE07A84A760
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E85D1C26F3A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D577F461;
	Mon,  5 Feb 2024 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aG5bp3gT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBA27E57B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162402; cv=none; b=ZLPl0c9k2xp8WChfgaJRUVZC458bTSVXo9UbM9Um2h5W7b12eF2g+oYXKmTnKR0hdZLQ80DGRNB8j1QVNEHdFyQZkH8G38jeFrfD0CT3P9Z+z99Xbgu2c/X5R9yvJH4GNQe4c3CSKJPt7sGRzDiYmCGEKjuNeYMJNS4KdugdvHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162402; c=relaxed/simple;
	bh=Q+FFFAKX8L0wFsTUyEe+rGAUs3xDIwQRI/Gs81w7hWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jiev9hZJvs7ddy74GS/IiLT9hDLnwmShg1/uHKTsJd8Q1xou+VMBw2/K0/qbgarrv3wCLxr9+J2VT6dfyZMT+evqrsv5M5fAgkkoazN0tqSr+Kl1In4tU671Pb+ZZeERxYruEPAuI/m3Fvtlkkv7qNd14rfOzKVrSFtxPmW0wbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aG5bp3gT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707162399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iAw8XR8UIKF5pxcWD9Lf41raO40/9bfeM2Aq6TfckS8=;
	b=aG5bp3gTP13nJNj3TRZHvYq1G40oNAlPzYyADdC/cv4YVwQ/yopYOssBw3Szbe5ZZ/eXRc
	V4jwQTpc+zbVKKd4o5pw/kzI5YGHp+6EYaFZAF/63mHnBVaHopadyy0NvOztN6npwi9fZq
	U/1OTYGx83T4bn/mSKyTRzjXuhfwya8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-jbBf-C3IMaayxZIYikLHnA-1; Mon,
 05 Feb 2024 14:46:36 -0500
X-MC-Unique: jbBf-C3IMaayxZIYikLHnA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7D221C04331;
	Mon,  5 Feb 2024 19:46:35 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.212])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 72F041C060B3;
	Mon,  5 Feb 2024 19:46:35 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Alex Gladkov <agladkov@redhat.com>,
	Phil Auld <pauld@redhat.com>,
	Costa Shulyupin <cshulyup@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-wq v3 1/4] workqueue: Enable unbound cpumask update on ordered workqueues
Date: Mon,  5 Feb 2024 14:45:59 -0500
Message-Id: <20240205194602.871505-2-longman@redhat.com>
In-Reply-To: <20240205194602.871505-1-longman@redhat.com>
References: <20240205194602.871505-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Ordered workqueues does not currently follow changes made to the
global unbound cpumask because per-pool workqueue changes may break
the ordering guarantee. IOW, a work function in an ordered workqueue
may run on an isolated CPU.

This patch enables ordered workqueues to follow changes made to
the global unbound cpumask by temporaily freeze the newly allocated
pool_workqueue by using the new frozen flag to freeze execution of
newly queued work items until the old pwq has been properly flushed.

This enables ordered workqueues to follow the unbound cpumask changes
like other unbound workqueues at the expense of some delay in execution
of work functions during the transition period.

Signed-off-by: Waiman Long <longman@redhat.com>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/workqueue.c | 93 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 80 insertions(+), 13 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 68c48489eab3..9b107e8a2c15 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -255,6 +255,7 @@ struct pool_workqueue {
 	int			refcnt;		/* L: reference count */
 	int			nr_in_flight[WORK_NR_COLORS];
 						/* L: nr of in_flight works */
+	int			frozen;		/* L: temporarily frozen */
 
 	/*
 	 * nr_active management and WORK_STRUCT_INACTIVE:
@@ -1702,6 +1703,9 @@ static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq, bool fill)
 
 	lockdep_assert_held(&pool->lock);
 
+	if (pwq->frozen)
+		return false;
+
 	if (!nna) {
 		/* BH or per-cpu workqueue, pwq->nr_active is sufficient */
 		obtained = pwq->nr_active < READ_ONCE(wq->max_active);
@@ -1782,6 +1786,21 @@ static bool pwq_activate_first_inactive(struct pool_workqueue *pwq, bool fill)
 	}
 }
 
+/**
+ * thaw_pwq - thaw a frozen pool_workqueue
+ * @pwq: pool_workqueue to be thawed
+ */
+static void thaw_pwq(struct pool_workqueue *pwq)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&pwq->pool->lock, flags);
+	pwq->frozen = false;
+	if (pwq_activate_first_inactive(pwq, true))
+		kick_pool(pwq->pool);
+	raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
+}
+
 /**
  * node_activate_pending_pwq - Activate a pending pwq on a wq_node_nr_active
  * @nna: wq_node_nr_active to activate a pending pwq for
@@ -4740,6 +4759,18 @@ static void pwq_release_workfn(struct kthread_work *work)
 		mutex_lock(&wq->mutex);
 		list_del_rcu(&pwq->pwqs_node);
 		is_last = list_empty(&wq->pwqs);
+
+		/*
+		 * For ordered workqueue with a frozen dfl_pwq, thaw it now.
+		 */
+		if (!is_last && (wq->flags & __WQ_ORDERED_EXPLICIT)) {
+			struct pool_workqueue *dfl_pwq;
+
+			dfl_pwq = rcu_access_pointer(wq->dfl_pwq);
+			if (dfl_pwq && dfl_pwq->frozen)
+				thaw_pwq(dfl_pwq);
+		}
+
 		mutex_unlock(&wq->mutex);
 	}
 
@@ -4906,7 +4937,22 @@ static void apply_wqattrs_cleanup(struct apply_wqattrs_ctx *ctx)
 
 		for_each_possible_cpu(cpu)
 			put_pwq_unlocked(ctx->pwq_tbl[cpu]);
+
+		/*
+		 * Acquire rcu_read_lock() before refcnt can become 0 to
+		 * ensure that ctx->dfl_pwq won't be freed.
+		 */
+		rcu_read_lock();
 		put_pwq_unlocked(ctx->dfl_pwq);
+		if ((ctx->wq->flags & __WQ_ORDERED_EXPLICIT) &&
+		     ctx->dfl_pwq && !ctx->dfl_pwq->refcnt) {
+			struct pool_workqueue *dfl_pwq;
+
+			dfl_pwq = rcu_access_pointer(ctx->wq->dfl_pwq);
+			if (dfl_pwq && dfl_pwq->frozen)
+				thaw_pwq(dfl_pwq);
+		}
+		rcu_read_unlock();
 
 		free_workqueue_attrs(ctx->attrs);
 
@@ -4966,6 +5012,15 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 	cpumask_copy(new_attrs->__pod_cpumask, new_attrs->cpumask);
 	ctx->attrs = new_attrs;
 
+	/*
+	 * For initialized ordered workqueues, there is only one pwq (dfl_pwq).
+	 * Temporarily the frozen flag of ctx->dfl_pwq to freeze the execution
+	 * of newly queued work items until execution of older work items in
+	 * the old pwq has completed.
+	 */
+	if (!list_empty(&wq->pwqs) && (wq->flags & __WQ_ORDERED_EXPLICIT))
+		ctx->dfl_pwq->frozen = true;
+
 	ctx->wq = wq;
 	return ctx;
 
@@ -5006,13 +5061,8 @@ static int apply_workqueue_attrs_locked(struct workqueue_struct *wq,
 	if (WARN_ON(!(wq->flags & WQ_UNBOUND)))
 		return -EINVAL;
 
-	/* creating multiple pwqs breaks ordering guarantee */
-	if (!list_empty(&wq->pwqs)) {
-		if (WARN_ON(wq->flags & __WQ_ORDERED_EXPLICIT))
-			return -EINVAL;
-
+	if (!list_empty(&wq->pwqs) && !(wq->flags & __WQ_ORDERED_EXPLICIT))
 		wq->flags &= ~__WQ_ORDERED;
-	}
 
 	ctx = apply_wqattrs_prepare(wq, attrs, wq_unbound_cpumask);
 	if (IS_ERR(ctx))
@@ -6504,11 +6554,29 @@ static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
 		if (!(wq->flags & WQ_UNBOUND) || (wq->flags & __WQ_DESTROYING))
 			continue;
 
-		/* creating multiple pwqs breaks ordering guarantee */
+		/*
+		 * We does not support changing cpumask of an ordered workqueue
+		 * again before the previous cpumask change is completed.
+		 * Sleep up to 100ms in 10ms interval to allow previous
+		 * operation to complete and skip it if not done by then.
+		 */
 		if (!list_empty(&wq->pwqs)) {
-			if (wq->flags & __WQ_ORDERED_EXPLICIT)
-				continue;
-			wq->flags &= ~__WQ_ORDERED;
+			struct pool_workqueue *dfl_pwq;
+
+			dfl_pwq = rcu_access_pointer(wq->dfl_pwq);
+			if (!(wq->flags & __WQ_ORDERED_EXPLICIT)) {
+				wq->flags &= ~__WQ_ORDERED;
+			} else if (dfl_pwq && dfl_pwq->frozen) {
+				int i;
+
+				for (i = 0; i < 10; i++) {
+					msleep(10);
+					if (!dfl_pwq->frozen)
+						break;
+				}
+				if (WARN_ON_ONCE(dfl_pwq->frozen))
+					continue;
+			}
 		}
 
 		ctx = apply_wqattrs_prepare(wq, wq->unbound_attrs, unbound_cpumask);
@@ -7024,9 +7092,8 @@ int workqueue_sysfs_register(struct workqueue_struct *wq)
 	int ret;
 
 	/*
-	 * Adjusting max_active or creating new pwqs by applying
-	 * attributes breaks ordering guarantee.  Disallow exposing ordered
-	 * workqueues.
+	 * Adjusting max_active breaks ordering guarantee.  Disallow exposing
+	 * ordered workqueues.
 	 */
 	if (WARN_ON(wq->flags & __WQ_ORDERED_EXPLICIT))
 		return -EINVAL;
-- 
2.39.3


