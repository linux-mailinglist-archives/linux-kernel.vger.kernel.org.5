Return-Path: <linux-kernel+bounces-55794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3138484C1D4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04A81F22957
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5431CD2D;
	Wed,  7 Feb 2024 01:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TpTVTw/k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7076C13FF2
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 01:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707268780; cv=none; b=BNVNWM3nusxX4Zj8dtwXcevU9UPgLQoB9I1Iix6OXbtAdBhV3a+RpCxuWtJjD9Y8DiI3ijStvinvFlzuof9svBErs5sspXomGXBOk+zfNeQ/s/Y5IktxAsPk2yCbwRQ0NUTbX7+585oGnpdAhl2AYGxF80/tUIxI2Xhrr0vIVDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707268780; c=relaxed/simple;
	bh=QOD1jsvG/al9EJLO1f2eMnYHH/QabzJmg01wtGY+e5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mliHu2ri9plmM0PgZZ3slrw1PZYyMIfjpQKbIm4961zoHNnr5Vw1ivv5bU4PaxqhnDb7LvLLPZY4DEqw/A7w1VKntUO8GwOmGdQdKXH9lwhizS1aXwLF2c+KkiCGvBvaQ7HybNvxOxUvsZ4VYmck9sZlfjrWPvG7bvWLrz7is2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TpTVTw/k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707268777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwZ9dmpqpCvKkj51vCJ2+0Ny4PTM8rYb+AJFZphIZm4=;
	b=TpTVTw/kW/opBsCK53tyQ3125grgdh5v0lRyD58ucQVn1pG/xUgsmKn6tHTAHLJx+puDmF
	Gg2mW19BCFFK8RyJPIJoSegr4Ful8T43PtKIVj+Yp+9vzdjyZOp4sVVvLPDJ3qm5eg+O09
	qXOlHwE6UP9QLfBOzOXzbgGe1nQ4Q1g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-fHpVIqdqNauEsen1Ax00gg-1; Tue, 06 Feb 2024 20:19:33 -0500
X-MC-Unique: fHpVIqdqNauEsen1Ax00gg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3ECC985A58E;
	Wed,  7 Feb 2024 01:19:33 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BA51540C9444;
	Wed,  7 Feb 2024 01:19:32 +0000 (UTC)
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
Subject: [PATCH wq/for-6.9 v4 2/4] workqueue: Enable unbound cpumask update on ordered workqueues
Date: Tue,  6 Feb 2024 20:19:09 -0500
Message-Id: <20240207011911.975608-3-longman@redhat.com>
In-Reply-To: <20240207011911.975608-1-longman@redhat.com>
References: <20240207011911.975608-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Ordered workqueues does not currently follow changes made to the
global unbound cpumask because per-pool workqueue changes may break
the ordering guarantee. IOW, a work function in an ordered workqueue
may run on an isolated CPU.

This patch enables ordered workqueues to follow changes made to the
global unbound cpumask by temporaily plug or suspend the newly allocated
pool_workqueue from executing newly queued work items until the old
pwq has been properly drained. For ordered workqueues, there should
only be one pwq that is unplugged, the rests should be plugged.

This enables ordered workqueues to follow the unbound cpumask changes
like other unbound workqueues at the expense of some delay in execution
of work functions during the transition period.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/workqueue.c | 102 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 92 insertions(+), 10 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index fa7bd3b34f52..49fe082fe328 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -255,6 +255,7 @@ struct pool_workqueue {
 	int			refcnt;		/* L: reference count */
 	int			nr_in_flight[WORK_NR_COLORS];
 						/* L: nr of in_flight works */
+	bool			plugged;	/* L: execution suspended */
 
 	/*
 	 * nr_active management and WORK_STRUCT_INACTIVE:
@@ -1708,6 +1709,9 @@ static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq, bool fill)
 		goto out;
 	}
 
+	if (unlikely(pwq->plugged))
+		return false;
+
 	/*
 	 * Unbound workqueue uses per-node shared nr_active $nna. If @pwq is
 	 * already waiting on $nna, pwq_dec_nr_active() will maintain the
@@ -1782,6 +1786,58 @@ static bool pwq_activate_first_inactive(struct pool_workqueue *pwq, bool fill)
 	}
 }
 
+/**
+ * unplug_oldest_pwq - restart an oldest plugged pool_workqueue
+ * @wq: workqueue_struct to be restarted
+ * @pwq: pwq to be excluded
+ *
+ * pwq's are linked into wq->pwqs with the oldest first. For ordered
+ * workqueues, only the oldest pwq is unplugged, the others are plugged to
+ * suspend execution until the oldest one is drained. When this happens, the
+ * next oldest one (first plugged pwq in iteration) will be unplugged to
+ * restart work item execution to ensure proper work item ordering.
+ *
+ *    dfl_pwq --------------+     [P] - plugged
+ *                          |
+ *                          v
+ *    pwqs -> A -> B [P] -> C [P] (newest)
+ *            |    |        |
+ *            1    3        5
+ *            |    |        |
+ *            2    4        6
+ *
+ * The unplugging is done either in apply_wqattrs_cleanup() [fast path] when
+ * the workqueue was idle or in pwq_release_workfn() [slow path] when the
+ * workqueue was busy.
+ */
+static void unplug_oldest_pwq(struct workqueue_struct *wq,
+			      struct pool_workqueue *exlude_pwq)
+{
+	struct pool_workqueue *pwq;
+	unsigned long flags;
+	bool found = false;
+
+	for_each_pwq(pwq, wq) {
+		if (pwq == exlude_pwq)
+			continue;
+		if (!pwq->plugged)
+			return;	/* No unplug needed */
+		found = true;
+		break;
+	}
+	if (WARN_ON_ONCE(!found))
+		return;
+
+	raw_spin_lock_irqsave(&pwq->pool->lock, flags);
+	if (!pwq->plugged)
+		goto out_unlock;
+	pwq->plugged = false;
+	if (pwq_activate_first_inactive(pwq, true))
+		kick_pool(pwq->pool);
+out_unlock:
+	raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
+}
+
 /**
  * node_activate_pending_pwq - Activate a pending pwq on a wq_node_nr_active
  * @nna: wq_node_nr_active to activate a pending pwq for
@@ -4740,6 +4796,13 @@ static void pwq_release_workfn(struct kthread_work *work)
 		mutex_lock(&wq->mutex);
 		list_del_rcu(&pwq->pwqs_node);
 		is_last = list_empty(&wq->pwqs);
+
+		/*
+		 * For ordered workqueue with a plugged dfl_pwq, restart it now.
+		 */
+		if (!is_last && (wq->flags & __WQ_ORDERED))
+			unplug_oldest_pwq(wq, NULL);
+
 		mutex_unlock(&wq->mutex);
 	}
 
@@ -4906,8 +4969,26 @@ static void apply_wqattrs_cleanup(struct apply_wqattrs_ctx *ctx)
 
 		for_each_possible_cpu(cpu)
 			put_pwq_unlocked(ctx->pwq_tbl[cpu]);
+
+		/*
+		 * Acquire rcu_read_lock() before refcnt can become 0 to
+		 * ensure that ctx->dfl_pwq won't be freed & we can
+		 * iterate wq->pwqs.
+		 */
+		rcu_read_lock();
 		put_pwq_unlocked(ctx->dfl_pwq);
 
+		/*
+		 * It is possible that ctx->dfl_pwq (previous wq->dfl_pwq)
+		 * may not be the oldest one with the plugged flag still set.
+		 * unplug_oldest_pwq() will still do the right thing to allow
+		 * only one unplugged pwq in the workqueue.
+		 */
+		if ((ctx->wq->flags & __WQ_ORDERED) &&
+		     ctx->dfl_pwq && !ctx->dfl_pwq->refcnt)
+			unplug_oldest_pwq(ctx->wq, ctx->dfl_pwq);
+		rcu_read_unlock();
+
 		free_workqueue_attrs(ctx->attrs);
 
 		kfree(ctx);
@@ -4966,6 +5047,15 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 	cpumask_copy(new_attrs->__pod_cpumask, new_attrs->cpumask);
 	ctx->attrs = new_attrs;
 
+	/*
+	 * For initialized ordered workqueues, there is only one pwq (dfl_pwq).
+	 * Set the plugged flag of ctx->dfl_pwq to suspend execution of newly
+	 * queued work items until execution of older work items in the old
+	 * pwq's have completed.
+	 */
+	if (!list_empty(&wq->pwqs) && (wq->flags & __WQ_ORDERED))
+		ctx->dfl_pwq->plugged = true;
+
 	ctx->wq = wq;
 	return ctx;
 
@@ -5006,10 +5096,6 @@ static int apply_workqueue_attrs_locked(struct workqueue_struct *wq,
 	if (WARN_ON(!(wq->flags & WQ_UNBOUND)))
 		return -EINVAL;
 
-	/* creating multiple pwqs breaks ordering guarantee */
-	if (!list_empty(&wq->pwqs) && WARN_ON(wq->flags & __WQ_ORDERED))
-		return -EINVAL;
-
 	ctx = apply_wqattrs_prepare(wq, attrs, wq_unbound_cpumask);
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
@@ -6489,9 +6575,6 @@ static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
 	list_for_each_entry(wq, &workqueues, list) {
 		if (!(wq->flags & WQ_UNBOUND) || (wq->flags & __WQ_DESTROYING))
 			continue;
-		/* creating multiple pwqs breaks ordering guarantee */
-		if (wq->flags & __WQ_ORDERED)
-			continue;
 
 		ctx = apply_wqattrs_prepare(wq, wq->unbound_attrs, unbound_cpumask);
 		if (IS_ERR(ctx)) {
@@ -7006,9 +7089,8 @@ int workqueue_sysfs_register(struct workqueue_struct *wq)
 	int ret;
 
 	/*
-	 * Adjusting max_active or creating new pwqs by applying
-	 * attributes breaks ordering guarantee.  Disallow exposing ordered
-	 * workqueues.
+	 * Adjusting max_active breaks ordering guarantee.  Disallow exposing
+	 * ordered workqueues.
 	 */
 	if (WARN_ON(wq->flags & __WQ_ORDERED))
 		return -EINVAL;
-- 
2.39.3


