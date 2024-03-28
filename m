Return-Path: <linux-kernel+bounces-115324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0484889ACA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE0D1C3376A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98BE1DF7A8;
	Mon, 25 Mar 2024 02:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpi1LjGz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46A4811F8;
	Sun, 24 Mar 2024 22:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320527; cv=none; b=j2s1KnEqjJfKwrDd3m8uvXe4dgQY7cEWBRMpG2CF1gx194iazxvbkUens8T7wMWbeClsSBHmWYbGNhJB5xMUTkLMxi0x0O9RgMrKPjpYsIP/kwvGAV7v+ZtL/0noKfuSZPbvqnSnYEZv0SWkT2LO/BiMZdf65GmqzvrOD0byJao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320527; c=relaxed/simple;
	bh=6+SYbOYNnKPwultYmz4ENRnWG3XaQXiJHsyiff95gzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECeuK2Z3WH15yZBnwtHSPOayH4GPXXIJPprbjT24C88K5pBZBxkGlPsj6L9rPGRQVIDUs/nQCXP/MqfH8sr6YKmw5vrY2/3WEo5Vkibs37rHGjD/0oYaFISkDoNkYlLQFIzZ6yel2+u7VDFARsLgBg8NGQ0M3K354wx5b6v4vik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpi1LjGz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00797C43399;
	Sun, 24 Mar 2024 22:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320527;
	bh=6+SYbOYNnKPwultYmz4ENRnWG3XaQXiJHsyiff95gzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qpi1LjGzm278bcC+eo1HJi7kM09//MDqElwYSOHWqpbJc6PRJaTJX6XcnciLc0wfg
	 SWBoDClKLSH2PbdKm3lPGltXHv1GE5ZtLKTybncW4jsOjR5saLCy7JofNL4hjMWNln
	 oKKNIxVWSXk75wHaIqeOZ6meuWjt8oHhSXtpWjfeJ5/jbksf3IOIF6NQfdQY+Id9UC
	 wt/tAK8/mWBQCnBs/BGWqRXXbTa4B/9XOY6zIY6vZKmeABiGgrCZ2I2EQDHbuoupg+
	 NImfYmbfWVHGL7px4QYc0cp2cMXrUcC96gW7/ZaDAorbRukOD5YVLHa9lUhZwRG7Xf
	 8qhqCpzcXjgPQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 089/713] workqueue: Introduce struct wq_node_nr_active
Date: Sun, 24 Mar 2024 18:36:55 -0400
Message-ID: <20240324224720.1345309-90-sashal@kernel.org>
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
index 53bebd8c8b457..be1fc91b9851c 100644
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
@@ -1415,6 +1426,31 @@ work_func_t wq_worker_last_func(struct task_struct *task)
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
@@ -1496,12 +1532,17 @@ static bool pwq_activate_work(struct pool_workqueue *pwq,
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
@@ -1518,14 +1559,18 @@ static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq)
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
 
@@ -1562,10 +1607,26 @@ static bool pwq_activate_first_inactive(struct pool_workqueue *pwq)
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
 
@@ -4020,11 +4081,63 @@ static void wq_free_lockdep(struct workqueue_struct *wq)
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
@@ -4776,7 +4889,8 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 {
 	va_list args;
 	struct workqueue_struct *wq;
-	int len;
+	size_t wq_size;
+	int name_len;
 
 	/*
 	 * Unbound && max_active == 1 used to imply ordered, which is no longer
@@ -4792,7 +4906,12 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
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
 
@@ -4803,11 +4922,12 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
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
@@ -4826,8 +4946,13 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
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
@@ -4852,6 +4977,9 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 
 	return wq;
 
+err_free_node_nr_active:
+	if (wq->flags & WQ_UNBOUND)
+		free_node_nr_active(wq->node_nr_active);
 err_unreg_lockdep:
 	wq_unregister_lockdep(wq);
 	wq_free_lockdep(wq);
-- 
2.43.0


