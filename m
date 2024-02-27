Return-Path: <linux-kernel+bounces-82636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 076D886877C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C60C1C21867
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B244338DD5;
	Tue, 27 Feb 2024 03:03:17 +0000 (UTC)
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819B02D603
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 03:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709002997; cv=none; b=m3beYM5DYS8xD+5ssIuY7Ydl/UHZXY8uhWcwJwmAxoUFDx5gJjyF7zrcu7y542mHt6/NihFq9iZRwrT//qOJU2hnhq2t2FjpylBcupRLK8RebNmSg4k4aRjChpGX4hQkKcMKLBXrOMGZnGTOlvKj5SmFrdkTz+rdXGK2vJPJRsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709002997; c=relaxed/simple;
	bh=/M8dgwAyEda7XsNe3iFiXBlSIntC0kanjsl4nXxFc+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=in11NGnxUyKJy+w6hmCsH451dK8boiic8m7oFgg/xPytVR/21JXn+15BvNrBRhOvGQ1PACTvx6xL3e+qdSzCic+OJ/2/7jndPSW4PvGPtHo46SSx8dEoTyZ1JrKS2Rb0RQoPpAdwK5y8uVW/HWVXpw39bfAbnZuhBLimxlEaWJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Tue, 27 Feb 2024 03:02:55 +0000
Subject: [PATCH 2/2] mm/zsmalloc: remove the deferred free mechanism
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240226-zsmalloc-zspage-rcu-v1-2-456b0ef1a89d@bytedance.com>
References: <20240226-zsmalloc-zspage-rcu-v1-0-456b0ef1a89d@bytedance.com>
In-Reply-To: <20240226-zsmalloc-zspage-rcu-v1-0-456b0ef1a89d@bytedance.com>
To: yosryahmed@google.com, Sergey Senozhatsky <senozhatsky@chromium.org>, hannes@cmpxchg.org, nphamcs@gmail.com,
 Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Chengming Zhou <zhouchengming@bytedance.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709002985; l=5278;
 i=zhouchengming@bytedance.com; s=20240220; h=from:subject:message-id;
 bh=/M8dgwAyEda7XsNe3iFiXBlSIntC0kanjsl4nXxFc+E=;
 b=HKzHCzoHlRScN2CAHFL2LHEXBGcx4FZexrsgeFkUsWRTeBSsg2wQ+Kv5cGnhN6T8q7yMHkqfy
 LkC11bU4POFDX84RKgcD2IwlI1sl7CP9Dx9yfr3MiZEdk9Ydr9BUfAL
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=5+68Wfci+T30FoQos5RH+hfToF6SlC+S9LMPSPBFWuw=
X-Migadu-Flow: FLOW_OUT

Since the only user of kick_deferred_free() has gone, remove all the
deferred mechanism related code.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zsmalloc.c | 109 ----------------------------------------------------------
 1 file changed, 109 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index b153f2e5fc0f..1a044690b389 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -232,9 +232,6 @@ struct zs_pool {
 
 #ifdef CONFIG_ZSMALLOC_STAT
 	struct dentry *stat_dentry;
-#endif
-#ifdef CONFIG_COMPACTION
-	struct work_struct free_work;
 #endif
 	spinlock_t lock;
 	atomic_t compaction_in_progress;
@@ -281,12 +278,8 @@ static void migrate_write_lock(struct zspage *zspage);
 static void migrate_write_unlock(struct zspage *zspage);
 
 #ifdef CONFIG_COMPACTION
-static void kick_deferred_free(struct zs_pool *pool);
-static void init_deferred_free(struct zs_pool *pool);
 static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage);
 #else
-static void kick_deferred_free(struct zs_pool *pool) {}
-static void init_deferred_free(struct zs_pool *pool) {}
 static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage) {}
 #endif
 
@@ -1632,50 +1625,6 @@ static int putback_zspage(struct size_class *class, struct zspage *zspage)
 	return fullness;
 }
 
-#ifdef CONFIG_COMPACTION
-/*
- * To prevent zspage destroy during migration, zspage freeing should
- * hold locks of all pages in the zspage.
- */
-static void lock_zspage(struct zspage *zspage)
-{
-	struct page *curr_page, *page;
-
-	/*
-	 * Pages we haven't locked yet can be migrated off the list while we're
-	 * trying to lock them, so we need to be careful and only attempt to
-	 * lock each page under migrate_read_lock(). Otherwise, the page we lock
-	 * may no longer belong to the zspage. This means that we may wait for
-	 * the wrong page to unlock, so we must take a reference to the page
-	 * prior to waiting for it to unlock outside migrate_read_lock().
-	 */
-	while (1) {
-		migrate_read_lock(zspage);
-		page = get_first_page(zspage);
-		if (trylock_page(page))
-			break;
-		get_page(page);
-		migrate_read_unlock(zspage);
-		wait_on_page_locked(page);
-		put_page(page);
-	}
-
-	curr_page = page;
-	while ((page = get_next_page(curr_page))) {
-		if (trylock_page(page)) {
-			curr_page = page;
-		} else {
-			get_page(page);
-			migrate_read_unlock(zspage);
-			wait_on_page_locked(page);
-			put_page(page);
-			migrate_read_lock(zspage);
-		}
-	}
-	migrate_read_unlock(zspage);
-}
-#endif /* CONFIG_COMPACTION */
-
 static void migrate_lock_init(struct zspage *zspage)
 {
 	rwlock_init(&zspage->lock);
@@ -1730,10 +1679,6 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 
 static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 {
-	/*
-	 * Page is locked so zspage couldn't be destroyed. For detail, look at
-	 * lock_zspage in free_zspage.
-	 */
 	VM_BUG_ON_PAGE(PageIsolated(page), page);
 
 	return true;
@@ -1848,56 +1793,6 @@ static const struct movable_operations zsmalloc_mops = {
 	.putback_page = zs_page_putback,
 };
 
-/*
- * Caller should hold page_lock of all pages in the zspage
- * In here, we cannot use zspage meta data.
- */
-static void async_free_zspage(struct work_struct *work)
-{
-	int i;
-	struct size_class *class;
-	struct zspage *zspage, *tmp;
-	LIST_HEAD(free_pages);
-	struct zs_pool *pool = container_of(work, struct zs_pool,
-					free_work);
-
-	for (i = 0; i < ZS_SIZE_CLASSES; i++) {
-		class = pool->size_class[i];
-		if (class->index != i)
-			continue;
-
-		spin_lock(&pool->lock);
-		list_splice_init(&class->fullness_list[ZS_INUSE_RATIO_0],
-				 &free_pages);
-		spin_unlock(&pool->lock);
-	}
-
-	list_for_each_entry_safe(zspage, tmp, &free_pages, list) {
-		list_del(&zspage->list);
-		lock_zspage(zspage);
-
-		spin_lock(&pool->lock);
-		class = zspage_class(pool, zspage);
-		__free_zspage(pool, class, zspage);
-		spin_unlock(&pool->lock);
-	}
-};
-
-static void kick_deferred_free(struct zs_pool *pool)
-{
-	schedule_work(&pool->free_work);
-}
-
-static void zs_flush_migration(struct zs_pool *pool)
-{
-	flush_work(&pool->free_work);
-}
-
-static void init_deferred_free(struct zs_pool *pool)
-{
-	INIT_WORK(&pool->free_work, async_free_zspage);
-}
-
 static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage)
 {
 	struct page *page = get_first_page(zspage);
@@ -1908,8 +1803,6 @@ static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage)
 		unlock_page(page);
 	} while ((page = get_next_page(page)) != NULL);
 }
-#else
-static inline void zs_flush_migration(struct zs_pool *pool) { }
 #endif
 
 /*
@@ -2121,7 +2014,6 @@ struct zs_pool *zs_create_pool(const char *name)
 	if (!pool)
 		return NULL;
 
-	init_deferred_free(pool);
 	spin_lock_init(&pool->lock);
 	atomic_set(&pool->compaction_in_progress, 0);
 
@@ -2229,7 +2121,6 @@ void zs_destroy_pool(struct zs_pool *pool)
 	int i;
 
 	zs_unregister_shrinker(pool);
-	zs_flush_migration(pool);
 	zs_pool_stat_destroy(pool);
 
 	for (i = 0; i < ZS_SIZE_CLASSES; i++) {

-- 
b4 0.10.1

