Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8F67CB70D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbjJPXcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbjJPXck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:32:40 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46B3592
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:32:38 -0700 (PDT)
Received: from localhost.localdomain (unknown [47.186.13.91])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4722E20B74C2;
        Mon, 16 Oct 2023 16:32:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4722E20B74C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1697499158;
        bh=gCRZvrUNaVTWzlYfg8ajlsIhID+99pYUDz5EwuiJdrY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Va2MWzBJiE+5QFXQOBeuFDPwG6UohLuTEtvYDdV1NU1S3AnzkcN+lpAsCfnZSws9X
         02z8spSvLHk4Rdm+4c5vfn6ld/jFgelZAb8HX8i+sv93KLN8lk6IDZnxa5J7ijOEyU
         3+o6EI6+W1t+HNOZbuWl1E6wulnRO3ectF4nwI3E=
From:   madvenka@linux.microsoft.com
To:     gregkh@linuxfoundation.org, pbonzini@redhat.com, rppt@kernel.org,
        jgowans@amazon.com, graf@amazon.de, arnd@arndb.de,
        keescook@chromium.org, stanislav.kinsburskii@gmail.com,
        anthony.yznaga@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        jamorris@linux.microsoft.com
Subject: [RFC PATCH v1 06/10] mm/prmem: Implement persistent XArray (and Radix Tree)
Date:   Mon, 16 Oct 2023 18:32:11 -0500
Message-Id: <20231016233215.13090-7-madvenka@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231016233215.13090-1-madvenka@linux.microsoft.com>
References: <1b1bc25eb87355b91fcde1de7c2f93f38abb2bf9>
 <20231016233215.13090-1-madvenka@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>

Consumers can persist their data structures by allocating persistent
memory for them.

Now, data structures are connected to one another using pointers, arrays,
linked lists, RB nodes, etc. These can all be persisted by allocating
memory for them from persistent memory. E.g., a linked list is persisted
if the data structures that embed the list head and the list nodes are
allocated from persistent memory. Ditto for RB trees.

One important exception is the XArray. The XArray itself can be embedded in
a persistent data structure. However, the XA nodes are allocated using the
kmem allocator.

Implement a persistent XArray. Introduce a new field, xa_persistent, in the
XArray. Implement an accessor function to set the field. If xa_persistent
is true, allocate XA nodes using the prmem allocator instead of the kmem
allocator. This makes the whole XArray persistent.

Since Radix Trees (lib/radix-tree.c) are implemented based on the XArray,
we also get persistent Radix Trees. The only difference is that pre-loading
is not supported for persistent Radix Tree nodes.

Signed-off-by: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
---
 include/linux/radix-tree.h |  4 ++++
 include/linux/xarray.h     | 15 ++++++++++++
 lib/radix-tree.c           | 49 +++++++++++++++++++++++++++++++-------
 lib/xarray.c               | 11 +++++----
 4 files changed, 66 insertions(+), 13 deletions(-)

diff --git a/include/linux/radix-tree.h b/include/linux/radix-tree.h
index eae67015ce51..74f0bdc60bea 100644
--- a/include/linux/radix-tree.h
+++ b/include/linux/radix-tree.h
@@ -82,6 +82,7 @@ static inline bool radix_tree_is_internal_node(void *ptr)
 	struct radix_tree_root name = RADIX_TREE_INIT(name, mask)
 
 #define INIT_RADIX_TREE(root, mask) xa_init_flags(root, mask)
+#define PERSIST_RADIX_TREE(root) xa_persistent(root)
 
 static inline bool radix_tree_empty(const struct radix_tree_root *root)
 {
@@ -254,6 +255,9 @@ unsigned int radix_tree_gang_lookup_tag_slot(const struct radix_tree_root *,
 		void __rcu ***results, unsigned long first_index,
 		unsigned int max_items, unsigned int tag);
 int radix_tree_tagged(const struct radix_tree_root *, unsigned int tag);
+struct radix_tree_node *radix_node_alloc(struct radix_tree_root *root,
+		struct list_lru *lru, gfp_t gfp);
+void radix_node_free(struct radix_tree_node *node);
 
 static inline void radix_tree_preload_end(void)
 {
diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 741703b45f61..3176a5f62caf 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -295,6 +295,7 @@ enum xa_lock_type {
  */
 struct xarray {
 	spinlock_t	xa_lock;
+	bool		xa_persistent;
 /* private: The rest of the data structure is not to be used directly. */
 	gfp_t		xa_flags;
 	void __rcu *	xa_head;
@@ -302,6 +303,7 @@ struct xarray {
 
 #define XARRAY_INIT(name, flags) {				\
 	.xa_lock = __SPIN_LOCK_UNLOCKED(name.xa_lock),		\
+	.xa_persistent = false,					\
 	.xa_flags = flags,					\
 	.xa_head = NULL,					\
 }
@@ -378,6 +380,7 @@ void xa_destroy(struct xarray *);
 static inline void xa_init_flags(struct xarray *xa, gfp_t flags)
 {
 	spin_lock_init(&xa->xa_lock);
+	xa->xa_persistent = false;
 	xa->xa_flags = flags;
 	xa->xa_head = NULL;
 }
@@ -395,6 +398,17 @@ static inline void xa_init(struct xarray *xa)
 	xa_init_flags(xa, 0);
 }
 
+/**
+ * xa_peristent() - xa_root and xa_node allocated from persistent memory.
+ * @xa: XArray.
+ *
+ * Context: Any context.
+ */
+static inline void xa_persistent(struct xarray *xa)
+{
+	xa->xa_persistent = true;
+}
+
 /**
  * xa_empty() - Determine if an array has any present entries.
  * @xa: XArray.
@@ -1142,6 +1156,7 @@ struct xa_node {
 	unsigned char	offset;		/* Slot offset in parent */
 	unsigned char	count;		/* Total entry count */
 	unsigned char	nr_values;	/* Value entry count */
+	bool		persistent;	/* Allocated from persistent memory. */
 	struct xa_node __rcu *parent;	/* NULL at top of tree */
 	struct xarray	*array;		/* The array we belong to */
 	union {
diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 976b9bd02a1b..d3af6ff6c625 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -21,6 +21,7 @@
 #include <linux/kmemleak.h>
 #include <linux/percpu.h>
 #include <linux/preempt.h>		/* in_interrupt() */
+#include <linux/prmem.h>
 #include <linux/radix-tree.h>
 #include <linux/rcupdate.h>
 #include <linux/slab.h>
@@ -225,6 +226,36 @@ static unsigned long next_index(unsigned long index,
 	return (index & ~node_maxindex(node)) + (offset << node->shift);
 }
 
+static void radix_tree_node_ctor(void *arg);
+
+struct radix_tree_node *
+radix_node_alloc(struct radix_tree_root *root, struct list_lru *lru, gfp_t gfp)
+{
+	struct radix_tree_node *node;
+
+	if (root && root->xa_persistent) {
+		node = prmem_alloc(sizeof(struct radix_tree_node), gfp);
+		if (node) {
+			radix_tree_node_ctor(node);
+			node->persistent = true;
+		}
+	} else {
+		node = kmem_cache_alloc_lru(radix_tree_node_cachep, lru, gfp);
+		if (node)
+			node->persistent = false;
+	}
+	return node;
+}
+
+void radix_node_free(struct radix_tree_node *node)
+{
+	if (node->persistent) {
+		prmem_free(node, sizeof(*node));
+		return;
+	}
+	kmem_cache_free(radix_tree_node_cachep, node);
+}
+
 /*
  * This assumes that the caller has performed appropriate preallocation, and
  * that the caller has pinned this thread of control to the current CPU.
@@ -241,8 +272,11 @@ radix_tree_node_alloc(gfp_t gfp_mask, struct radix_tree_node *parent,
 	 * Preload code isn't irq safe and it doesn't make sense to use
 	 * preloading during an interrupt anyway as all the allocations have
 	 * to be atomic. So just do normal allocation when in interrupt.
+	 *
+	 * Also, there is no preloading for persistent trees.
 	 */
-	if (!gfpflags_allow_blocking(gfp_mask) && !in_interrupt()) {
+	if (!gfpflags_allow_blocking(gfp_mask) && !in_interrupt() &&
+	    !root->xa_persistent) {
 		struct radix_tree_preload *rtp;
 
 		/*
@@ -250,8 +284,7 @@ radix_tree_node_alloc(gfp_t gfp_mask, struct radix_tree_node *parent,
 		 * cache first for the new node to get accounted to the memory
 		 * cgroup.
 		 */
-		ret = kmem_cache_alloc(radix_tree_node_cachep,
-				       gfp_mask | __GFP_NOWARN);
+		ret = radix_node_alloc(root, NULL, gfp_mask | __GFP_NOWARN);
 		if (ret)
 			goto out;
 
@@ -273,7 +306,7 @@ radix_tree_node_alloc(gfp_t gfp_mask, struct radix_tree_node *parent,
 		kmemleak_update_trace(ret);
 		goto out;
 	}
-	ret = kmem_cache_alloc(radix_tree_node_cachep, gfp_mask);
+	ret = radix_node_alloc(root, NULL, gfp_mask);
 out:
 	BUG_ON(radix_tree_is_internal_node(ret));
 	if (ret) {
@@ -301,7 +334,7 @@ void radix_tree_node_rcu_free(struct rcu_head *head)
 	memset(node->tags, 0, sizeof(node->tags));
 	INIT_LIST_HEAD(&node->private_list);
 
-	kmem_cache_free(radix_tree_node_cachep, node);
+	radix_node_free(node);
 }
 
 static inline void
@@ -335,7 +368,7 @@ static __must_check int __radix_tree_preload(gfp_t gfp_mask, unsigned nr)
 	rtp = this_cpu_ptr(&radix_tree_preloads);
 	while (rtp->nr < nr) {
 		local_unlock(&radix_tree_preloads.lock);
-		node = kmem_cache_alloc(radix_tree_node_cachep, gfp_mask);
+		node = radix_node_alloc(NULL, NULL, gfp_mask);
 		if (node == NULL)
 			goto out;
 		local_lock(&radix_tree_preloads.lock);
@@ -345,7 +378,7 @@ static __must_check int __radix_tree_preload(gfp_t gfp_mask, unsigned nr)
 			rtp->nodes = node;
 			rtp->nr++;
 		} else {
-			kmem_cache_free(radix_tree_node_cachep, node);
+			radix_node_free(node);
 		}
 	}
 	ret = 0;
@@ -1585,7 +1618,7 @@ static int radix_tree_cpu_dead(unsigned int cpu)
 	while (rtp->nr) {
 		node = rtp->nodes;
 		rtp->nodes = node->parent;
-		kmem_cache_free(radix_tree_node_cachep, node);
+		radix_node_free(node);
 		rtp->nr--;
 	}
 	return 0;
diff --git a/lib/xarray.c b/lib/xarray.c
index 2071a3718f4e..33a74b713e6a 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -9,6 +9,7 @@
 #include <linux/bitmap.h>
 #include <linux/export.h>
 #include <linux/list.h>
+#include <linux/prmem.h>
 #include <linux/slab.h>
 #include <linux/xarray.h>
 
@@ -303,7 +304,7 @@ bool xas_nomem(struct xa_state *xas, gfp_t gfp)
 	}
 	if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
 		gfp |= __GFP_ACCOUNT;
-	xas->xa_alloc = kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp);
+	xas->xa_alloc = radix_node_alloc(xas->xa, xas->xa_lru, gfp);
 	if (!xas->xa_alloc)
 		return false;
 	xas->xa_alloc->parent = NULL;
@@ -335,10 +336,10 @@ static bool __xas_nomem(struct xa_state *xas, gfp_t gfp)
 		gfp |= __GFP_ACCOUNT;
 	if (gfpflags_allow_blocking(gfp)) {
 		xas_unlock_type(xas, lock_type);
-		xas->xa_alloc = kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp);
+		xas->xa_alloc = radix_node_alloc(xas->xa, xas->xa_lru, gfp);
 		xas_lock_type(xas, lock_type);
 	} else {
-		xas->xa_alloc = kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp);
+		xas->xa_alloc = radix_node_alloc(xas->xa, xas->xa_lru, gfp);
 	}
 	if (!xas->xa_alloc)
 		return false;
@@ -372,7 +373,7 @@ static void *xas_alloc(struct xa_state *xas, unsigned int shift)
 		if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
 			gfp |= __GFP_ACCOUNT;
 
-		node = kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp);
+		node = radix_node_alloc(xas->xa, xas->xa_lru, gfp);
 		if (!node) {
 			xas_set_err(xas, -ENOMEM);
 			return NULL;
@@ -1017,7 +1018,7 @@ void xas_split_alloc(struct xa_state *xas, void *entry, unsigned int order,
 		void *sibling = NULL;
 		struct xa_node *node;
 
-		node = kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp);
+		node = radix_node_alloc(xas->xa, xas->xa_lru, gfp);
 		if (!node)
 			goto nomem;
 		node->array = xas->xa;
-- 
2.25.1

