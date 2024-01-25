Return-Path: <linux-kernel+bounces-39005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F292083C98E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239E01C21DCA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C05813F001;
	Thu, 25 Jan 2024 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kS6UTCSy"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECC713E235
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202405; cv=none; b=ddDO4IV3OMgIinhG6FFZLcjD4uAUHSmSpPR33AeSkVXjRQW5rCFzo9Bw4z9weJWqtH0mOBu4v9t9cKN8MKdrylnT0okP80QduELiY3riOHaUNIAHOMu2F+7m0dWMQhhpzNa3LaZ0GNx9+XSd5vBL02JvzgUqOEy11bn3D6WP4KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202405; c=relaxed/simple;
	bh=p6ESWBBlugiEPfT3EbaQ1tA4SWxU38fz+PGD8jFP6Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1jdl7cs7P4Jsp4OMRXPC5VRJXrckAAiq0fvnPw+oBm/FQJP4oBlTZ4WFph92+t+PsetWLwYta3UXlel0arVEpkX3vaL50XHliq2Ut3TzMpfu8mdE2fYCNi0VPole6rusT3qvBs0b390ghKyX6tQZCIrP+ls7mIltAtiZTJsBRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kS6UTCSy; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d75ea3a9b6so37775955ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706202403; x=1706807203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrI8s5Fa0esd/vQ/zkP3XD+zVWXEEpv6gr+KDzi1Kmk=;
        b=kS6UTCSyLj7+FISlDqPVWiGQrA0dvTb5Du7bRL1rVrvrNFWm5plvvFnXwsPXxnGtaA
         BKQux5Wg//9ByGR0eHtclHeMFCJ93CPcxzJTj5gaZ/pHzifvKKEoAP4Fj9D66virV+7A
         e2xr8XCxPwTVGov5MVu2quJYT35UNgTdRfcqsYYhJ5rrKzZlBJxFkYFCu4UByz9hannk
         B2sEugbrr0SBcL41SAa2U7sMOPYROPA0vf5GbWncEVYbxa4aOzNPdXn6ccNzf0eG7W+V
         kMt51oqhy7MF5VkcDs7yWoobwZApkhvJ9fGrt1/q3ZB0N2po5R36dVvsleAfk2EOAZGU
         j28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706202403; x=1706807203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PrI8s5Fa0esd/vQ/zkP3XD+zVWXEEpv6gr+KDzi1Kmk=;
        b=ZOkaJzM8lJxfl7z4Cj/O39+Kov1wqeBScD1Drm2fs1+fEO8xP+P2H5nZDrzJLUwp2n
         k0/6MMhf1evUJBmXW6MhNOgL+TkA5zM7s6XFMjOVdUyi7ATsVRdPwtzfDd9h1R95kSs8
         zWuTZwR9VEs4PGh5/B1WPZnXN7oVNFRXcnFDGfQG3PG3IfQZqUIF/HMNvC0Wk1Bc7pDs
         h59/FmghnMDlXJNSDXCwn3U5oDcdXo+cwrVPG0sFphAb4hilN76widYZw/EYxybdzArz
         MbJhKOBTHRxHgtILJsaLJHc+X4QuswjHoc+iZrJ9GXAlngvJp8wf7M0IjcMoTNNhZeqM
         vUNQ==
X-Gm-Message-State: AOJu0Yxk1p6oxhoVeC849ulErLRN39nJttmnAIgnANf1VOBtqwp7iIJW
	UwvKwyImZqaT4qMtO3HnrBoX0UThoaslNBa3wti2M7RWUptgLY7N
X-Google-Smtp-Source: AGHT+IFqYj3uDZOhXOEXisjG7eyi/mnA1Y5nERt+KGik3GYrTcXuzRxENxnXctWMrfmKBu795J0OeA==
X-Received: by 2002:a17:902:db05:b0:1d6:fd5e:84a2 with SMTP id m5-20020a170902db0500b001d6fd5e84a2mr1357574plx.119.1706202402874;
        Thu, 25 Jan 2024 09:06:42 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id r11-20020a170903410b00b001d721ee41c6sm10334385pld.232.2024.01.25.09.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 09:06:42 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 08/10] workqueue: Introduce struct wq_node_nr_active
Date: Thu, 25 Jan 2024 07:06:01 -1000
Message-ID: <20240125170628.2017784-9-tj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125170628.2017784-1-tj@kernel.org>
References: <20240125170628.2017784-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, for both percpu and unbound workqueues, max_active applies
per-cpu, which is a recent change for unbound workqueues. The change for
unbound workqueues was a significant departure from the previous behavior of
per-node application. It made some use cases create undesirable number of
concurrent work items and left no good way of fixing them. To address the
problem, workqueue is implementing a NUMA node segmented global nr_active
mechanism, which will be explained further in the next patch.

As a preparation, this patch introduces struct wq_node_nr_active. It's a
data structured allocated for each workqueue and NUMA node pair and
currently only tracks the workqueue's number of active work items on the
node. This is split out from the next patch to make it easier to understand
and review.

Note that there is an extra wq_node_nr_active allocated for the invalid node
nr_node_ids which is used to track nr_active for pools which don't have NUMA
node associated such as the default fallback system-wide pool.

This doesn't cause any behavior changes visible to userland yet. The next
patch will expand to implement the control mechanism on top.

v3: - Use flexible array for wq->node_nr_active as suggested by Lai.

v2: - wq->max_active now uses WRITE/READ_ONCE() as suggested by Lai.

    - Lai pointed out that pwq_tryinc_nr_active() incorrectly dropped
      pwq->max_active check. Restored. As the next patch replaces the
      max_active enforcement mechanism, this doesn't change the end result.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
---
 kernel/workqueue.c | 139 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 132 insertions(+), 7 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 38d4957b08d1..3c9daa264265 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -280,6 +280,16 @@ struct wq_flusher {
 
 struct wq_device;
 
+/*
+ * Unlike in a per-cpu workqueue where max_active limits its concurrency level
+ * on each CPU, in an unbound workqueue, max_active applies to the whole system.
+ * As sharing a single nr_active across multiple sockets can be very expensive,
+ * the counting and enforcement is per NUMA node.
+ */
+struct wq_node_nr_active {
+	atomic_t		nr;		/* per-node nr_active count */
+};
+
 /*
  * The externally visible workqueue.  It relays the issued work items to
  * the appropriate worker_pool through its pool_workqueues.
@@ -326,6 +336,7 @@ struct workqueue_struct {
 	/* hot fields used during command issue, aligned to cacheline */
 	unsigned int		flags ____cacheline_aligned; /* WQ: WQ_* flags */
 	struct pool_workqueue __percpu __rcu **cpu_pwq; /* I: per-cpu pwqs */
+	struct wq_node_nr_active *node_nr_active[]; /* I: per-node nr_active */
 };
 
 static struct kmem_cache *pwq_cache;
@@ -1421,6 +1432,31 @@ work_func_t wq_worker_last_func(struct task_struct *task)
 	return worker->last_func;
 }
 
+/**
+ * wq_node_nr_active - Determine wq_node_nr_active to use
+ * @wq: workqueue of interest
+ * @node: NUMA node, can be %NUMA_NO_NODE
+ *
+ * Determine wq_node_nr_active to use for @wq on @node. Returns:
+ *
+ * - %NULL for per-cpu workqueues as they don't need to use shared nr_active.
+ *
+ * - node_nr_active[nr_node_ids] if @node is %NUMA_NO_NODE.
+ *
+ * - Otherwise, node_nr_active[@node].
+ */
+static struct wq_node_nr_active *wq_node_nr_active(struct workqueue_struct *wq,
+						   int node)
+{
+	if (!(wq->flags & WQ_UNBOUND))
+		return NULL;
+
+	if (node == NUMA_NO_NODE)
+		node = nr_node_ids;
+
+	return wq->node_nr_active[node];
+}
+
 /**
  * get_pwq - get an extra reference on the specified pool_workqueue
  * @pwq: pool_workqueue to get
@@ -1502,12 +1538,17 @@ static bool pwq_activate_work(struct pool_workqueue *pwq,
 			      struct work_struct *work)
 {
 	struct worker_pool *pool = pwq->pool;
+	struct wq_node_nr_active *nna;
 
 	lockdep_assert_held(&pool->lock);
 
 	if (!(*work_data_bits(work) & WORK_STRUCT_INACTIVE))
 		return false;
 
+	nna = wq_node_nr_active(pwq->wq, pool->node);
+	if (nna)
+		atomic_inc(&nna->nr);
+
 	pwq->nr_active++;
 	__pwq_activate_work(pwq, work);
 	return true;
@@ -1524,14 +1565,18 @@ static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq)
 {
 	struct workqueue_struct *wq = pwq->wq;
 	struct worker_pool *pool = pwq->pool;
+	struct wq_node_nr_active *nna = wq_node_nr_active(wq, pool->node);
 	bool obtained;
 
 	lockdep_assert_held(&pool->lock);
 
 	obtained = pwq->nr_active < READ_ONCE(wq->max_active);
 
-	if (obtained)
+	if (obtained) {
 		pwq->nr_active++;
+		if (nna)
+			atomic_inc(&nna->nr);
+	}
 	return obtained;
 }
 
@@ -1568,10 +1613,26 @@ static bool pwq_activate_first_inactive(struct pool_workqueue *pwq)
 static void pwq_dec_nr_active(struct pool_workqueue *pwq)
 {
 	struct worker_pool *pool = pwq->pool;
+	struct wq_node_nr_active *nna = wq_node_nr_active(pwq->wq, pool->node);
 
 	lockdep_assert_held(&pool->lock);
 
+	/*
+	 * @pwq->nr_active should be decremented for both percpu and unbound
+	 * workqueues.
+	 */
 	pwq->nr_active--;
+
+	/*
+	 * For a percpu workqueue, it's simple. Just need to kick the first
+	 * inactive work item on @pwq itself.
+	 */
+	if (!nna) {
+		pwq_activate_first_inactive(pwq);
+		return;
+	}
+
+	atomic_dec(&nna->nr);
 	pwq_activate_first_inactive(pwq);
 }
 
@@ -4036,12 +4097,62 @@ static void wq_free_lockdep(struct workqueue_struct *wq)
 }
 #endif
 
+static void free_node_nr_active(struct wq_node_nr_active **nna_ar)
+{
+	int node;
+
+	for_each_node(node) {
+		kfree(nna_ar[node]);
+		nna_ar[node] = NULL;
+	}
+
+	kfree(nna_ar[nr_node_ids]);
+	nna_ar[nr_node_ids] = NULL;
+}
+
+static void init_node_nr_active(struct wq_node_nr_active *nna)
+{
+	atomic_set(&nna->nr, 0);
+}
+
+/*
+ * Each node's nr_active counter will be accessed mostly from its own node and
+ * should be allocated in the node.
+ */
+static int alloc_node_nr_active(struct wq_node_nr_active **nna_ar)
+{
+	struct wq_node_nr_active *nna;
+	int node;
+
+	for_each_node(node) {
+		nna = kzalloc_node(sizeof(*nna), GFP_KERNEL, node);
+		if (!nna)
+			goto err_free;
+		init_node_nr_active(nna);
+		nna_ar[node] = nna;
+	}
+
+	/* [nr_node_ids] is used as the fallback */
+	nna = kzalloc_node(sizeof(*nna), GFP_KERNEL, NUMA_NO_NODE);
+	if (!nna)
+		goto err_free;
+	init_node_nr_active(nna);
+	nna_ar[nr_node_ids] = nna;
+
+	return 0;
+
+err_free:
+	free_node_nr_active(nna_ar);
+	return -ENOMEM;
+}
+
 static void rcu_free_wq(struct rcu_head *rcu)
 {
 	struct workqueue_struct *wq =
 		container_of(rcu, struct workqueue_struct, rcu);
 
 	wq_free_lockdep(wq);
+	free_node_nr_active(wq->node_nr_active);
 	free_percpu(wq->cpu_pwq);
 	free_workqueue_attrs(wq->unbound_attrs);
 	kfree(wq);
@@ -4782,7 +4893,8 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 {
 	va_list args;
 	struct workqueue_struct *wq;
-	int len;
+	size_t wq_size;
+	int name_len;
 
 	/*
 	 * Unbound && max_active == 1 used to imply ordered, which is no longer
@@ -4798,7 +4910,12 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 		flags |= WQ_UNBOUND;
 
 	/* allocate wq and format name */
-	wq = kzalloc(sizeof(*wq), GFP_KERNEL);
+	if (flags & WQ_UNBOUND)
+		wq_size = struct_size(wq, node_nr_active, nr_node_ids + 1);
+	else
+		wq_size = sizeof(*wq);
+
+	wq = kzalloc(wq_size, GFP_KERNEL);
 	if (!wq)
 		return NULL;
 
@@ -4809,11 +4926,12 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	}
 
 	va_start(args, max_active);
-	len = vsnprintf(wq->name, sizeof(wq->name), fmt, args);
+	name_len = vsnprintf(wq->name, sizeof(wq->name), fmt, args);
 	va_end(args);
 
-	if (len >= WQ_NAME_LEN)
-		pr_warn_once("workqueue: name exceeds WQ_NAME_LEN. Truncating to: %s\n", wq->name);
+	if (name_len >= WQ_NAME_LEN)
+		pr_warn_once("workqueue: name exceeds WQ_NAME_LEN. Truncating to: %s\n",
+			     wq->name);
 
 	max_active = max_active ?: WQ_DFL_ACTIVE;
 	max_active = wq_clamp_max_active(max_active, flags, wq->name);
@@ -4832,8 +4950,13 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	wq_init_lockdep(wq);
 	INIT_LIST_HEAD(&wq->list);
 
+	if (flags & WQ_UNBOUND) {
+		if (alloc_node_nr_active(wq->node_nr_active) < 0)
+			goto err_unreg_lockdep;
+	}
+
 	if (alloc_and_link_pwqs(wq) < 0)
-		goto err_unreg_lockdep;
+		goto err_free_node_nr_active;
 
 	if (wq_online && init_rescuer(wq) < 0)
 		goto err_destroy;
@@ -4858,6 +4981,8 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 
 	return wq;
 
+err_free_node_nr_active:
+	free_node_nr_active(wq->node_nr_active);
 err_unreg_lockdep:
 	wq_unregister_lockdep(wq);
 	wq_free_lockdep(wq);
-- 
2.43.0


