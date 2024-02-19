Return-Path: <linux-kernel+bounces-71407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C8A85A4B4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4581C283647
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCEE374EC;
	Mon, 19 Feb 2024 13:34:31 +0000 (UTC)
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB2037153
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708349671; cv=none; b=CbUfHhnnbF5+sVYDisWkM2ptAUBXqQZDeWTSqIER0aF2WSnJGvakR8JvBaHL9TyABiP0VwdFzT6+bohaOVfn8C64/2d2Vd3YNMMgl8p9bsdf1FEkjVwtyRGJ6g4AdMVXy1NUzTOcnVuIQ/tA1glfTYmU4OEvU06RAE0sm2610/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708349671; c=relaxed/simple;
	bh=4NV6DsrM5S+/h7ppU/k8FOJs/bnqzH3nRRreQTC9eDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jADPpBR9m7IInlRia2KYhh2g+kbq8EziZ24rbubQluLhsQiVB9JCLuN/qYHiL/+Bh+rR5J1CGbvvnSgIMbLWIqvNIdwHqj5j77nCg+2VA1PYz+88ejHyR4+47nkP1cScOx+heuB7UEE3U7fcso3Tf+hiHD39UZQv7RdldJquCKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Mon, 19 Feb 2024 13:33:53 +0000
Subject: [PATCH 3/3] mm/zsmalloc: remove unused zspage->isolated
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240219-b4-szmalloc-migrate-v1-3-34cd49c6545b@bytedance.com>
References: <20240219-b4-szmalloc-migrate-v1-0-34cd49c6545b@bytedance.com>
In-Reply-To: <20240219-b4-szmalloc-migrate-v1-0-34cd49c6545b@bytedance.com>
To: nphamcs@gmail.com, yosryahmed@google.com, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, hannes@cmpxchg.org
Cc: linux-mm@kvack.org, Chengming Zhou <zhouchengming@bytedance.com>, linux-kernel@vger.kernel.org
X-Migadu-Flow: FLOW_OUT

The zspage->isolated is not used anywhere, we don't need to maintain it,
which needs to hold the heavy pool lock to update it, so just remove it.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zsmalloc.c | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index f2ae7d4c6f21..a48f4651d143 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -116,7 +116,6 @@
 #define HUGE_BITS	1
 #define FULLNESS_BITS	4
 #define CLASS_BITS	8
-#define ISOLATED_BITS	5
 #define MAGIC_VAL_BITS	8
 
 #define MAX(a, b) ((a) >= (b) ? (a) : (b))
@@ -246,7 +245,6 @@ struct zspage {
 		unsigned int huge:HUGE_BITS;
 		unsigned int fullness:FULLNESS_BITS;
 		unsigned int class:CLASS_BITS + 1;
-		unsigned int isolated:ISOLATED_BITS;
 		unsigned int magic:MAGIC_VAL_BITS;
 	};
 	unsigned int inuse;
@@ -1732,17 +1730,6 @@ static void migrate_write_unlock(struct zspage *zspage)
 }
 
 #ifdef CONFIG_COMPACTION
-/* Number of isolated subpage for *page migration* in this zspage */
-static void inc_zspage_isolation(struct zspage *zspage)
-{
-	zspage->isolated++;
-}
-
-static void dec_zspage_isolation(struct zspage *zspage)
-{
-	VM_BUG_ON(zspage->isolated == 0);
-	zspage->isolated--;
-}
 
 static const struct movable_operations zsmalloc_mops;
 
@@ -1771,21 +1758,12 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 
 static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 {
-	struct zs_pool *pool;
-	struct zspage *zspage;
-
 	/*
 	 * Page is locked so zspage couldn't be destroyed. For detail, look at
 	 * lock_zspage in free_zspage.
 	 */
 	VM_BUG_ON_PAGE(PageIsolated(page), page);
 
-	zspage = get_zspage(page);
-	pool = zspage->pool;
-	spin_lock(&pool->lock);
-	inc_zspage_isolation(zspage);
-	spin_unlock(&pool->lock);
-
 	return true;
 }
 
@@ -1850,7 +1828,6 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	kunmap_atomic(s_addr);
 
 	replace_sub_page(class, zspage, newpage, page);
-	dec_zspage_isolation(zspage);
 	/*
 	 * Since we complete the data copy and set up new zspage structure,
 	 * it's okay to release the pool's lock.
@@ -1872,16 +1849,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 
 static void zs_page_putback(struct page *page)
 {
-	struct zs_pool *pool;
-	struct zspage *zspage;
-
 	VM_BUG_ON_PAGE(!PageIsolated(page), page);
-
-	zspage = get_zspage(page);
-	pool = zspage->pool;
-	spin_lock(&pool->lock);
-	dec_zspage_isolation(zspage);
-	spin_unlock(&pool->lock);
 }
 
 static const struct movable_operations zsmalloc_mops = {

-- 
b4 0.10.1

