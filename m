Return-Path: <linux-kernel+bounces-58601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C061B84E8BD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74A7E293049
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AB736118;
	Thu,  8 Feb 2024 19:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A90XOS4+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86652562E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 19:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707419571; cv=none; b=mO0M4tiO4m4Hp9wPFdzpbF1sQ3IcSfekJcR3A5Ob/NtwNwWT7BYxBrldRU9JtIa6E00eklKsTpKDM5+EFtn6JFrm21aoEt9imP2XNDb/Sl52Y5tkbqD1l2B8yty69kTunuXgGRAHi0hix3/RlFJRC+YtGWC3QqQueEznsOR3WSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707419571; c=relaxed/simple;
	bh=506h+I6jENuIwHl/+l3GqWz/VJuMQboUBhmMK6kLGrk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oyViu9OPoViZ5GqpPQ11qZB2/s7JalZhVvEE3AEPi1FhXZmtit8u8hoQ8Ey6F0mBNw7dP9GL/Fr1yYk1Re1HFV25bmhOArIbj75+2S/15ZEIHtOJSdUVgSze8U5dxxNvSY63L7S0MZjyh+/6NFbPYpsHCEzteV0ZHvCujd4ZPgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A90XOS4+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707419568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cSqFDht9oqySGNbtHUWvob5GvrVsWMq1FrhWjgIOu+Y=;
	b=A90XOS4+ohy8ukS65g6+RjJNcvxJed/DXeJfc6TKJcKg0fvHX0/KnluGj/UPurhyBBY14J
	KedE0d/tvz87sLoKrU5LB7ypxW/OKPI76uWuoryYNmyYS0CfjEM1H4hzpE4AsASJu5fenc
	kYzNlp1s8/b3ZomiLmGmiW08yNDjde0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-Jnbb78LxNU-dulUcC3EUvQ-1; Thu,
 08 Feb 2024 14:12:47 -0500
X-MC-Unique: Jnbb78LxNU-dulUcC3EUvQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BB4229AA3AF;
	Thu,  8 Feb 2024 19:12:47 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 77BA14011FF1;
	Thu,  8 Feb 2024 19:12:46 +0000 (UTC)
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
Subject: [PATCH wq/for-6.9 v6 2/4] workqueue: Enable unbound cpumask update on ordered workqueues
Date: Thu,  8 Feb 2024 14:12:20 -0500
Message-Id: <20240208191220.1094426-1-longman@redhat.com>
In-Reply-To: <20240208161014.1084943-1-longman@redhat.com>
References: <20240208161014.1084943-1-longman@redhat.com>
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
 kernel/workqueue.c | 69 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 59 insertions(+), 10 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index fa7bd3b34f52..da124859a691 100644
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
@@ -1782,6 +1786,43 @@ static bool pwq_activate_first_inactive(struct pool_workqueue *pwq, bool fill)
 	}
 }
 
+/**
+ * unplug_oldest_pwq - restart an oldest plugged pool_workqueue
+ * @wq: workqueue_struct to be restarted
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
+ */
+static void unplug_oldest_pwq(struct workqueue_struct *wq)
+{
+	struct pool_workqueue *pwq;
+
+	lockdep_assert_held(&wq->mutex);
+
+	/* Caller should make sure that pwqs isn't empty before calling */
+	pwq = list_first_entry_or_null(&wq->pwqs, struct pool_workqueue,
+				       pwqs_node);
+	raw_spin_lock_irq(&pwq->pool->lock);
+	if (pwq->plugged) {
+		pwq->plugged = false;
+		if (pwq_activate_first_inactive(pwq, true))
+			kick_pool(pwq->pool);
+	}
+	raw_spin_unlock_irq(&pwq->pool->lock);
+}
+
 /**
  * node_activate_pending_pwq - Activate a pending pwq on a wq_node_nr_active
  * @nna: wq_node_nr_active to activate a pending pwq for
@@ -4740,6 +4781,13 @@ static void pwq_release_workfn(struct kthread_work *work)
 		mutex_lock(&wq->mutex);
 		list_del_rcu(&pwq->pwqs_node);
 		is_last = list_empty(&wq->pwqs);
+
+		/*
+		 * For ordered workqueue with a plugged dfl_pwq, restart it now.
+		 */
+		if (!is_last && (wq->flags & __WQ_ORDERED))
+			unplug_oldest_pwq(wq);
+
 		mutex_unlock(&wq->mutex);
 	}
 
@@ -4966,6 +5014,15 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 	cpumask_copy(new_attrs->__pod_cpumask, new_attrs->cpumask);
 	ctx->attrs = new_attrs;
 
+	/*
+	 * For initialized ordered workqueues, there should only be one pwq
+	 * (dfl_pwq). Set the plugged flag of ctx->dfl_pwq to suspend execution
+	 * of newly queued work items until execution of older work items in
+	 * the old pwq's have completed.
+	 */
+	if ((wq->flags & __WQ_ORDERED) && !list_empty(&wq->pwqs))
+		ctx->dfl_pwq->plugged = true;
+
 	ctx->wq = wq;
 	return ctx;
 
@@ -5006,10 +5063,6 @@ static int apply_workqueue_attrs_locked(struct workqueue_struct *wq,
 	if (WARN_ON(!(wq->flags & WQ_UNBOUND)))
 		return -EINVAL;
 
-	/* creating multiple pwqs breaks ordering guarantee */
-	if (!list_empty(&wq->pwqs) && WARN_ON(wq->flags & __WQ_ORDERED))
-		return -EINVAL;
-
 	ctx = apply_wqattrs_prepare(wq, attrs, wq_unbound_cpumask);
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
@@ -6489,9 +6542,6 @@ static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
 	list_for_each_entry(wq, &workqueues, list) {
 		if (!(wq->flags & WQ_UNBOUND) || (wq->flags & __WQ_DESTROYING))
 			continue;
-		/* creating multiple pwqs breaks ordering guarantee */
-		if (wq->flags & __WQ_ORDERED)
-			continue;
 
 		ctx = apply_wqattrs_prepare(wq, wq->unbound_attrs, unbound_cpumask);
 		if (IS_ERR(ctx)) {
@@ -7006,9 +7056,8 @@ int workqueue_sysfs_register(struct workqueue_struct *wq)
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


