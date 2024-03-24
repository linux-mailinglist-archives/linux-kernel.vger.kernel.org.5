Return-Path: <linux-kernel+bounces-112896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C4A887F92
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AADEA1C210BC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA33D53393;
	Sun, 24 Mar 2024 22:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zq/FRVC8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859C251C56;
	Sun, 24 Mar 2024 22:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319706; cv=none; b=Ps9R6wG/ezBr272dlVgK+wIuYAyhAW6rV9eIY8DNzNoNWsWoBJqzqLC4sEHGONNMd9WlWedHm3Shv644+jRweuQ/NUycSixAC1U0tULhQpvlFuNvE30wCeytwuu/0nfbZ74R8ByJRIbqpArRktCvLplt77bORQgeH1eOkkmrebo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319706; c=relaxed/simple;
	bh=qPveSif7G2kTOKM12YWkv4+XvUMrMVRIT48FgzPizp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oehCRPmY5GE9DZXg90ZpjGgN81ArxVRbZkKSwkUWlGrdBk1LiP8bQ8VTyJHx2B9NqZ+2kFVfdvEDp7N6uNSmESsn84GAhmg9SMjJtuUsGJAN9LEs/wTfreMO2BiSu9+ksqhbRx483Z9QrKN6zhetPqSZjax09mOQ5YJ5A3qZIW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zq/FRVC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47B6C433F1;
	Sun, 24 Mar 2024 22:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319706;
	bh=qPveSif7G2kTOKM12YWkv4+XvUMrMVRIT48FgzPizp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zq/FRVC8WMBdcTCf4RlzE7hDIdXVBmYUUvF0nbJgah1+npOLS/8PAAqFXpmoyoAs1
	 EsSWkcfrXrkiWqt6/5Ao6xfZ/Pr3OcFLBzzaHHal+Qj4JYkqXs7tBl/bIdlU2B+w0f
	 Ikwggy4G/7vSwfHaDMwWQmQe5A7eBgA0GvAP+/Ep8P/7vaw12qyTGeUi0f1b54CfrD
	 xonM4gM2TKsLgiFSJ9bIXenY44dxowVZcZzz/gJBjnfo16sSwBcE6pSj2gwRf7/+ps
	 h43yi8M+t7vJWcnNK5tiuRCWUnpXPdC65HAKc02o7tAz7zNW1nxkmrrJcH67IKnyrf
	 p4k1tSMZ+nTPg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 009/715] workqueue: Introduce struct wq_node_nr_active
Date: Sun, 24 Mar 2024 18:23:08 -0400
Message-ID: <20240324223455.1342824-10-sashal@kernel.org>
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

[ Upstream commit 91ccc6e7233bb10a9c176aa4cc70d6f432a441a5 ]

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

v4: - Fixed out-of-bound access when freeing per-cpu workqueues.

v3: - Use flexible array for wq->node_nr_active as suggested by Lai.

v2: - wq->max_active now uses WRITE/READ_ONCE() as suggested by Lai.

    - Lai pointed out that pwq_tryinc_nr_active() incorrectly dropped
      pwq->max_active check. Restored. As the next patch replaces the
      max_active enforcement mechanism, this doesn't change the end result.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
Stable-dep-of: 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/workqueue.c | 142 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 135 insertions(+), 7 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 5cfc04dd05ad6..686899845475f 100644
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
 
@@ -4026,11 +4087,63 @@ static void wq_free_lockdep(struct workqueue_struct *wq)
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
 
+	if (wq->flags & WQ_UNBOUND)
+		free_node_nr_active(wq->node_nr_active);
+
 	wq_free_lockdep(wq);
 	free_percpu(wq->cpu_pwq);
 	free_workqueue_attrs(wq->unbound_attrs);
@@ -4769,7 +4882,8 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 {
 	va_list args;
 	struct workqueue_struct *wq;
-	int len;
+	size_t wq_size;
+	int name_len;
 
 	/*
 	 * Unbound && max_active == 1 used to imply ordered, which is no longer
@@ -4785,7 +4899,12 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
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
 
@@ -4796,11 +4915,12 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
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
@@ -4819,8 +4939,13 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
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
@@ -4845,6 +4970,9 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 
 	return wq;
 
+err_free_node_nr_active:
+	if (wq->flags & WQ_UNBOUND)
+		free_node_nr_active(wq->node_nr_active);
 err_unreg_lockdep:
 	wq_unregister_lockdep(wq);
 	wq_free_lockdep(wq);
-- 
2.43.0


