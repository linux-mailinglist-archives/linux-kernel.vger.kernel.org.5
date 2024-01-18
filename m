Return-Path: <linux-kernel+bounces-29680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B118311A1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 04:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72458284CC3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 03:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF438F6F;
	Thu, 18 Jan 2024 03:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5RIQxZe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4003F8801
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 03:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705547163; cv=none; b=m3XMhGprj1ZP5+U+ctGJAJyASY74a7qt6s7hAj3pypfFw7dzIV9fzCLNhdfe9f5OBBE3xssyQJAhxEWwq7I9Jna9u+17s4WL4yt8zlQxqvovu+Y+6mMt3dk+FtsCQ9RRlNEOIBtMXnf5FuKGoNnZK1bLVt5GHLWDVAC5ffUbc9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705547163; c=relaxed/simple;
	bh=GHp2KzzBbnQ1JaxEb3GCoI9IFAmZSnUKBqj3CudwNdk=;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer; b=k7eeQXFSbIMFdZ25EalLxJqC8ZUn9NB0yhswUE+f7w0SjArJTdRB9dO6zNHWIlufhagNY9GUaOHal1k5gFII6MwTkDZnVoe6gY92c2e7CsBNzZoyZw/r6SJsF655xa72txT5vKhXizIoKx6pwPiaLQ5kzKmVO1HLZyVziDFQ9Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5RIQxZe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C828C43390;
	Thu, 18 Jan 2024 03:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705547162;
	bh=GHp2KzzBbnQ1JaxEb3GCoI9IFAmZSnUKBqj3CudwNdk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=t5RIQxZelFG8p0vIhHFUgSLhOWy89aW7w8rU+5tr6GrKaP4LPWttCPCfhYme38ZYa
	 ddSc6c4HMYuKRHJ5Q8lDr74UDwSYBTPMUvdEV66m2gltQzEymX93M8iEQ4YtoYsBUZ
	 kp2EzSvzg+GBIXXeCbJB2eiO2UE1D/68EtgLsUjuGhniobHj/BSnjZdUHHllQDpLfy
	 O4T75c3R0lY8GMwVzLHExfeJzKTMP/9KgEO0nQENmiwK/Bubl1+j0SLJhgTdsocsdi
	 ayiqZYKY08MGvsa7NVglyvTmBXwdBcqa7H+AkChbjy3YHgaiGw7SIwc2194GUY/F/Y
	 FCUjAuIaX4azQ==
From: Chris Li <chrisl@kernel.org>
Date: Wed, 17 Jan 2024 19:05:42 -0800
Subject: [PATCH 2/2] mm: zswap.c: remove RB tree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240117-zswap-xarray-v1-2-6daa86c08fae@kernel.org>
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
In-Reply-To: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 =?utf-8?q?Wei_Xu=EF=BF=BC?= <weixugc@google.com>, 
 Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>, 
 Chun-Tse Shao <ctshao@google.com>, 
 =?utf-8?q?Suren_Baghdasaryan=EF=BF=BC?= <surenb@google.com>, 
 Yosry Ahmed <yosryahmed@google.com>, Brain Geffon <bgeffon@google.com>, 
 Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Kairui Song <kasong@tencent.com>, 
 Zhongkun He <hezhongkun.hzk@bytedance.com>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Barry Song <v-songbaohua@oppo.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Joel Fernandes <joel@joelfernandes.org>, 
 Chengming Zhou <zhouchengming@bytedance.com>, Chris Li <chrisl@kernel.org>
X-Mailer: b4 0.12.3

remove the RB tree code and the RB tree data structure
from zswap.

The xarray insert and erase code have been updated to
use the XAS version of the API to cache the lookup before
the final xarray store.

The zswap tree spinlock hasn't been removed yet due to
other usage outside of the zswap tree. The zswap xarray
function should work fine with its internal lock on RCU
without the zswap tree lock.

This removes the RB node inside the zswap entry, saving
about three pointers in size.  Considering the extra
overhead of xarray lookup tables, this should have some
net saving in terms of memory overhead in zswap if the
index is dense.

The zswap RB tree spin lock is still there to protect
the zswap entry. Expect the follow up change to merge
the RB tree spin lock with the xarray lock.
---
 mm/zswap.c | 98 +++++++++++++++++++++++---------------------------------------
 1 file changed, 36 insertions(+), 62 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index a40b0076722b..555d5608d401 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -197,7 +197,6 @@ struct zswap_pool {
  * This structure contains the metadata for tracking a single compressed
  * page within zswap.
  *
- * rbnode - links the entry into red-black tree for the appropriate swap type
  * swpentry - associated swap entry, the offset indexes into the red-black tree
  * refcount - the number of outstanding reference to the entry. This is needed
  *            to protect against premature freeing of the entry by code
@@ -215,7 +214,6 @@ struct zswap_pool {
  * lru - handle to the pool's lru used to evict pages.
  */
 struct zswap_entry {
-	struct rb_node rbnode;
 	swp_entry_t swpentry;
 	int refcount;
 	unsigned int length;
@@ -234,7 +232,6 @@ struct zswap_entry {
  * - the refcount field of each entry in the tree
  */
 struct zswap_tree {
-	struct rb_root rbroot;
 	struct xarray xarray;
 	spinlock_t lock;
 };
@@ -357,7 +354,6 @@ static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp, int nid)
 	if (!entry)
 		return NULL;
 	entry->refcount = 1;
-	RB_CLEAR_NODE(&entry->rbnode);
 	return entry;
 }
 
@@ -465,25 +461,7 @@ static void zswap_lru_putback(struct list_lru *list_lru,
 **********************************/
 static struct zswap_entry *zswap_search(struct zswap_tree *tree, pgoff_t offset)
 {
-	struct rb_node *node = tree->rbroot.rb_node;
-	struct zswap_entry *entry;
-	pgoff_t entry_offset;
-
-	while (node) {
-		entry = rb_entry(node, struct zswap_entry, rbnode);
-		entry_offset = swp_offset(entry->swpentry);
-		if (entry_offset > offset)
-			node = node->rb_left;
-		else if (entry_offset < offset)
-			node = node->rb_right;
-		else {
-			struct zswap_entry *e = xa_load(&tree->xarray, offset);
-
-			BUG_ON(entry != e);
-			return entry;
-		}
-	}
-	return NULL;
+	return xa_load(&tree->xarray, offset);
 }
 
 /*
@@ -493,45 +471,47 @@ static struct zswap_entry *zswap_search(struct zswap_tree *tree, pgoff_t offset)
 static int zswap_insert(struct zswap_tree *tree, struct zswap_entry *entry,
 			struct zswap_entry **dupentry)
 {
-	struct rb_root *root = &tree->rbroot;
-	struct rb_node **link = &root->rb_node, *parent = NULL;
-	struct zswap_entry *myentry, *old;
-	pgoff_t myentry_offset, entry_offset = swp_offset(entry->swpentry);
-
-
-	while (*link) {
-		parent = *link;
-		myentry = rb_entry(parent, struct zswap_entry, rbnode);
-		myentry_offset = swp_offset(myentry->swpentry);
-		if (myentry_offset > entry_offset)
-			link = &(*link)->rb_left;
-		else if (myentry_offset < entry_offset)
-			link = &(*link)->rb_right;
-		else {
-			old = xa_load(&tree->xarray, entry_offset);
-			BUG_ON(old != myentry);
-			*dupentry = myentry;
+	struct zswap_entry *e;
+	pgoff_t offset = swp_offset(entry->swpentry);
+	XA_STATE(xas, &tree->xarray, offset);
+
+	do {
+		xas_lock_irq(&xas);
+		do {
+			e = xas_load(&xas);
+			if (xa_is_zero(e))
+				e = NULL;
+		} while (xas_retry(&xas, e));
+		if (xas_valid(&xas) && e) {
+			xas_unlock_irq(&xas);
+			*dupentry = e;
 			return -EEXIST;
 		}
-	}
-	rb_link_node(&entry->rbnode, parent, link);
-	rb_insert_color(&entry->rbnode, root);
-	old = xa_store(&tree->xarray, entry_offset, entry, GFP_KERNEL);
-	return 0;
+		xas_store(&xas, entry);
+		xas_unlock_irq(&xas);
+	} while (xas_nomem(&xas, GFP_KERNEL));
+	return xas_error(&xas);
 }
 
 static bool zswap_erase(struct zswap_tree *tree, struct zswap_entry *entry)
 {
+	struct zswap_entry *e;
 	pgoff_t offset = swp_offset(entry->swpentry);
-	if (!RB_EMPTY_NODE(&entry->rbnode)) {
-		struct zswap_entry *old;
-		old = xa_erase(&tree->xarray, offset);
-		BUG_ON(old != entry);
-		rb_erase(&entry->rbnode, &tree->rbroot);
-		RB_CLEAR_NODE(&entry->rbnode);
-		return true;
-	}
-	return false;
+	XA_STATE(xas, &tree->xarray, offset);
+
+	do {
+		xas_lock_irq(&xas);
+		do {
+			e = xas_load(&xas);
+		} while (xas_retry(&xas, e));
+		if (xas_valid(&xas) && e != entry) {
+			xas_unlock_irq(&xas);
+			return false;
+		}
+		xas_store(&xas, NULL);
+		xas_unlock_irq(&xas);
+	} while (xas_nomem(&xas, GFP_KERNEL));
+	return !xas_error(&xas);
 }
 
 static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
@@ -583,7 +563,6 @@ static void zswap_entry_put(struct zswap_tree *tree,
 
 	WARN_ON_ONCE(refcount < 0);
 	if (refcount == 0) {
-		WARN_ON_ONCE(!RB_EMPTY_NODE(&entry->rbnode));
 		zswap_free_entry(entry);
 	}
 }
@@ -1799,7 +1778,6 @@ void zswap_swapon(int type)
 		return;
 	}
 
-	tree->rbroot = RB_ROOT;
 	xa_init(&tree->xarray);
 	spin_lock_init(&tree->lock);
 	zswap_trees[type] = tree;
@@ -1808,7 +1786,7 @@ void zswap_swapon(int type)
 void zswap_swapoff(int type)
 {
 	struct zswap_tree *tree = zswap_trees[type];
-	struct zswap_entry *entry, *e, *n;
+	struct zswap_entry *e;
 	XA_STATE(xas, tree ? &tree->xarray : NULL, 0);
 
 	if (!tree)
@@ -1820,10 +1798,6 @@ void zswap_swapoff(int type)
 	xas_for_each(&xas, e, ULONG_MAX)
 		zswap_invalidate_entry(tree, e);
 
-	rbtree_postorder_for_each_entry_safe(entry, n, &tree->rbroot, rbnode)
-		BUG_ON(entry);
-
-	tree->rbroot = RB_ROOT;
 	spin_unlock(&tree->lock);
 	kfree(tree);
 	zswap_trees[type] = NULL;

-- 
2.43.0.429.g432eaa2c6b-goog


