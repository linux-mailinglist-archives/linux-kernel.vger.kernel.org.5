Return-Path: <linux-kernel+bounces-82635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B851486877B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEB6AB2581B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009A533987;
	Tue, 27 Feb 2024 03:03:16 +0000 (UTC)
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE692C18F
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 03:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709002995; cv=none; b=bYNM4aPKIz/Ce+Phh8bCqqYt4oVu9NC3blfcKgi3eTmSdDPA+EC4Y9wyBUX/zmC8H1Dysm6hGxix/I+OozShKDJI2vE/WEDP5VH9S5Cb9Q2kT0ToAg2nUKmXUI+etwPkjImOesL5C01Suuydc9EYJittOnJKMOxbOwEF6G7gYi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709002995; c=relaxed/simple;
	bh=/Y+8Rr5r7R4qG0VPWtmHKI3CmlgVA1JjzF5IldWYPOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fgmHFrcwJ47DzP8q9u2PnWcT5OBtJD12xLFcigDhUp3z9jOAyF2B+HIQad2mEopJothWhVNXZoFWKOtKwrII9Y3gQAfrOj7hs3Y8XMqIXHlcdJ6PrGPYKLdZVxZvz9E6Y8UuzGzVlQ+1ckUfvne3I9w5iQnEDwDgJTdFSh16odc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Tue, 27 Feb 2024 03:02:54 +0000
Subject: [PATCH 1/2] mm/zsmalloc: don't hold locks of all pages when free_zspage()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240226-zsmalloc-zspage-rcu-v1-1-456b0ef1a89d@bytedance.com>
References: <20240226-zsmalloc-zspage-rcu-v1-0-456b0ef1a89d@bytedance.com>
In-Reply-To: <20240226-zsmalloc-zspage-rcu-v1-0-456b0ef1a89d@bytedance.com>
To: yosryahmed@google.com, Sergey Senozhatsky <senozhatsky@chromium.org>, hannes@cmpxchg.org, nphamcs@gmail.com,
 Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Chengming Zhou <zhouchengming@bytedance.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709002985; l=7649;
 i=zhouchengming@bytedance.com; s=20240220; h=from:subject:message-id;
 bh=/Y+8Rr5r7R4qG0VPWtmHKI3CmlgVA1JjzF5IldWYPOo=;
 b=Ipe8SF91JeqdJP/MV2fbyh7lbm0zV5Funv1K3Qy6bYmAr/Mo669Z/C6TNDwxz1AL+WdI8ItTm
 pWaD8WRhpRYDB285bxUKML+G8G1G1EV72v/91+bR9W3Kf9H97jTCK7k
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=5+68Wfci+T30FoQos5RH+hfToF6SlC+S9LMPSPBFWuw=
X-Migadu-Flow: FLOW_OUT

free_zspage() has to hold locks of all pages, since zs_page_migrate()
path rely on this page lock to protect the race between zs_free() and
it, so it can safely get zspage from page->private.

But this way is not good and simple enough:

1. Since zs_free() couldn't be sleepable, it can only trylock pages,
   or has to kick_deferred_free() to defer that to a work.

2. Even in the worker context, async_free_zspage() can't simply
   lock all pages in lock_zspage(), it's still trylock because of
   the race between zs_free() and zs_page_migrate(). Please see
   the commit 2505a981114d ("zsmalloc: fix races between asynchronous
   zspage free and page migration") for details.

Actually, all free_zspage() needs is to get zspage from page safely,
we can use RCU to achieve it easily. Then free_zspage() don't need to
hold locks of all pages, so don't need the deferred free mechanism
at all.

The updated zs_page_migrate() now has two more cases to consider:

1. get_zspage_lockless() return NULL: it means free_zspage() has used
   reset_page() on this page and its reference of page.

2. get_zspage_lockless() return zspage but it's not on pool list:
   it means zspage has been removed from list and in process of free.

I'm not sure what value should be returned in these cases? -EINVAL or
-EAGAIN or other value? If the migration caller can find that page
has no extra referenced and can just free it, I think we should return
-EAGAIN to let the migration caller retry this page later to free it.
Now I choose to use -EINVAL to skip migration of this page, it seems
not a big deal to fail migration of some pages?

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zsmalloc.c | 97 ++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 56 insertions(+), 41 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 63ec385cd670..b153f2e5fc0f 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -253,6 +253,7 @@ struct zspage {
 	struct list_head list; /* fullness list */
 	struct zs_pool *pool;
 	rwlock_t lock;
+	struct rcu_head rcu_head;
 };
 
 struct mapping_area {
@@ -310,6 +311,8 @@ static int create_cache(struct zs_pool *pool)
 static void destroy_cache(struct zs_pool *pool)
 {
 	kmem_cache_destroy(pool->handle_cachep);
+	/* Synchronize RCU to free zspage. */
+	synchronize_rcu();
 	kmem_cache_destroy(pool->zspage_cachep);
 }
 
@@ -335,6 +338,14 @@ static void cache_free_zspage(struct zs_pool *pool, struct zspage *zspage)
 	kmem_cache_free(pool->zspage_cachep, zspage);
 }
 
+static void rcu_free_zspage(struct rcu_head *h)
+{
+	struct zspage *zspage = container_of(h, struct zspage, rcu_head);
+	struct zs_pool *pool = zspage->pool;
+
+	kmem_cache_free(pool->zspage_cachep, zspage);
+}
+
 /* pool->lock(which owns the handle) synchronizes races */
 static void record_obj(unsigned long handle, unsigned long obj)
 {
@@ -710,14 +721,31 @@ static int fix_fullness_group(struct size_class *class, struct zspage *zspage)
 	return newfg;
 }
 
+static void set_zspage(struct page *page, struct zspage *zspage)
+{
+	struct zspage __rcu **private = (struct zspage __rcu **)&page->private;
+
+	rcu_assign_pointer(*private, zspage);
+}
+
 static struct zspage *get_zspage(struct page *page)
 {
-	struct zspage *zspage = (struct zspage *)page_private(page);
+	struct zspage __rcu **private = (struct zspage __rcu **)&page->private;
+	struct zspage *zspage;
 
+	zspage = rcu_dereference_protected(*private, true);
 	BUG_ON(zspage->magic != ZSPAGE_MAGIC);
 	return zspage;
 }
 
+/* Only used in zs_page_migrate() to get zspage locklessly. */
+static struct zspage *get_zspage_lockless(struct page *page)
+{
+	struct zspage __rcu **private = (struct zspage __rcu **)&page->private;
+
+	return rcu_dereference(*private);
+}
+
 static struct page *get_next_page(struct page *page)
 {
 	struct zspage *zspage = get_zspage(page);
@@ -793,32 +821,11 @@ static void reset_page(struct page *page)
 {
 	__ClearPageMovable(page);
 	ClearPagePrivate(page);
-	set_page_private(page, 0);
+	set_zspage(page, NULL);
 	page_mapcount_reset(page);
 	page->index = 0;
 }
 
-static int trylock_zspage(struct zspage *zspage)
-{
-	struct page *cursor, *fail;
-
-	for (cursor = get_first_page(zspage); cursor != NULL; cursor =
-					get_next_page(cursor)) {
-		if (!trylock_page(cursor)) {
-			fail = cursor;
-			goto unlock;
-		}
-	}
-
-	return 1;
-unlock:
-	for (cursor = get_first_page(zspage); cursor != fail; cursor =
-					get_next_page(cursor))
-		unlock_page(cursor);
-
-	return 0;
-}
-
 static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 				struct zspage *zspage)
 {
@@ -834,13 +841,12 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
 		next = get_next_page(page);
 		reset_page(page);
-		unlock_page(page);
 		dec_zone_page_state(page, NR_ZSPAGES);
 		put_page(page);
 		page = next;
 	} while (page != NULL);
 
-	cache_free_zspage(pool, zspage);
+	call_rcu(&zspage->rcu_head, rcu_free_zspage);
 
 	class_stat_dec(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
 	atomic_long_sub(class->pages_per_zspage, &pool->pages_allocated);
@@ -852,16 +858,6 @@ static void free_zspage(struct zs_pool *pool, struct size_class *class,
 	VM_BUG_ON(get_zspage_inuse(zspage));
 	VM_BUG_ON(list_empty(&zspage->list));
 
-	/*
-	 * Since zs_free couldn't be sleepable, this function cannot call
-	 * lock_page. The page locks trylock_zspage got will be released
-	 * by __free_zspage.
-	 */
-	if (!trylock_zspage(zspage)) {
-		kick_deferred_free(pool);
-		return;
-	}
-
 	remove_zspage(class, zspage);
 	__free_zspage(pool, class, zspage);
 }
@@ -929,7 +925,7 @@ static void create_page_chain(struct size_class *class, struct zspage *zspage,
 	 */
 	for (i = 0; i < nr_pages; i++) {
 		page = pages[i];
-		set_page_private(page, (unsigned long)zspage);
+		set_zspage(page, zspage);
 		page->index = 0;
 		if (i == 0) {
 			zspage->first_page = page;
@@ -978,10 +974,11 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 		pages[i] = page;
 	}
 
-	create_page_chain(class, zspage, pages);
 	init_zspage(class, zspage);
 	zspage->pool = pool;
 	zspage->class = class->index;
+	/* RCU set_zspage() after zspage initialized. */
+	create_page_chain(class, zspage, pages);
 
 	return zspage;
 }
@@ -1765,17 +1762,35 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 
 	VM_BUG_ON_PAGE(!PageIsolated(page), page);
 
-	/* The page is locked, so this pointer must remain valid */
-	zspage = get_zspage(page);
-	pool = zspage->pool;
+	rcu_read_lock();
+	zspage = get_zspage_lockless(page);
+	if (!zspage) {
+		rcu_read_unlock();
+		return -EINVAL;
+	}
 
 	/*
 	 * The pool's lock protects the race between zpage migration
-	 * and zs_free.
+	 * and zs_free. We check if the zspage is still in pool with
+	 * pool->lock protection. If the zspage isn't in pool anymore,
+	 * it should be freed by RCU soon.
 	 */
+	pool = zspage->pool;
 	spin_lock(&pool->lock);
 	class = zspage_class(pool, zspage);
 
+	if (list_empty(&zspage->list)) {
+		spin_unlock(&pool->lock);
+		rcu_read_unlock();
+		return -EINVAL;
+	}
+
+	/*
+	 * Now the zspage is still on pool, and we held pool->lock,
+	 * it can't be freed in the meantime.
+	 */
+	rcu_read_unlock();
+
 	/* the migrate_write_lock protects zpage access via zs_map_object */
 	migrate_write_lock(zspage);
 

-- 
b4 0.10.1

