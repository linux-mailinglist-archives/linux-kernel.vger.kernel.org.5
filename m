Return-Path: <linux-kernel+bounces-71406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A9885A4B3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4004E281DE1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFDF37147;
	Mon, 19 Feb 2024 13:34:29 +0000 (UTC)
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4E5364C4
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708349669; cv=none; b=ZPjvRwHdfdIJtMmMPpTrVGKviN7hLlAov9lPQ/xVM3aVVzTRwi+TCIjodqCpo3UpVQ5yPozEpon/LJ3UXB5v/cEz2vdr7fDgEA6mScMb1Zz5lO8M9WPtjxsKbdTZFkWc53jTHvGpyydJPoBWw3JAANxJPD/LrZaOrl4xNuCdfvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708349669; c=relaxed/simple;
	bh=OUia51YESybtl45fp4ZaNAosIUgwtCmJ4/X7GVIhXhM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YvbcsMOtma6mi/a59jQbg2TXpKXJ35OIWsP7lj5udb1YoTfVvOUQdTQ/h2P3ZJcKV6c8dP9kW3iXeBiTZ1EDwDayX4yhcPlfwl2BOqMx4Jgqk/ZxWY4+Gl9Vb4d3Ps1uKPg6y7YOKExU18wrKvYNq/H/BB7fjZwSbqA0mYnMvAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Mon, 19 Feb 2024 13:33:52 +0000
Subject: [PATCH 2/3] mm/zsmalloc: remove migrate_write_lock_nested()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240219-b4-szmalloc-migrate-v1-2-34cd49c6545b@bytedance.com>
References: <20240219-b4-szmalloc-migrate-v1-0-34cd49c6545b@bytedance.com>
In-Reply-To: <20240219-b4-szmalloc-migrate-v1-0-34cd49c6545b@bytedance.com>
To: nphamcs@gmail.com, yosryahmed@google.com, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, hannes@cmpxchg.org
Cc: linux-mm@kvack.org, Chengming Zhou <zhouchengming@bytedance.com>, linux-kernel@vger.kernel.org
X-Migadu-Flow: FLOW_OUT

The migrate write lock is to protect the race between zspage migration
and zspage objects' map users.

We only need to lock out the map users of src zspage, not dst zspage,
which is safe to map by users concurrently, since we only need to do
obj_malloc() from dst zspage.

So we can remove the migrate_write_lock_nested() use case.

As we are here, cleanup the __zs_compact() by moving putback_zspage()
outside of migrate_write_unlock since we hold pool lock, no malloc or
free users can come in.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zsmalloc.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 64d5533fa5d8..f2ae7d4c6f21 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -279,7 +279,6 @@ static void migrate_lock_init(struct zspage *zspage);
 static void migrate_read_lock(struct zspage *zspage);
 static void migrate_read_unlock(struct zspage *zspage);
 static void migrate_write_lock(struct zspage *zspage);
-static void migrate_write_lock_nested(struct zspage *zspage);
 static void migrate_write_unlock(struct zspage *zspage);
 
 #ifdef CONFIG_COMPACTION
@@ -1727,11 +1726,6 @@ static void migrate_write_lock(struct zspage *zspage)
 	write_lock(&zspage->lock);
 }
 
-static void migrate_write_lock_nested(struct zspage *zspage)
-{
-	write_lock_nested(&zspage->lock, SINGLE_DEPTH_NESTING);
-}
-
 static void migrate_write_unlock(struct zspage *zspage)
 {
 	write_unlock(&zspage->lock);
@@ -2003,19 +1997,17 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 			dst_zspage = isolate_dst_zspage(class);
 			if (!dst_zspage)
 				break;
-			migrate_write_lock(dst_zspage);
 		}
 
 		src_zspage = isolate_src_zspage(class);
 		if (!src_zspage)
 			break;
 
-		migrate_write_lock_nested(src_zspage);
-
+		migrate_write_lock(src_zspage);
 		migrate_zspage(pool, src_zspage, dst_zspage);
-		fg = putback_zspage(class, src_zspage);
 		migrate_write_unlock(src_zspage);
 
+		fg = putback_zspage(class, src_zspage);
 		if (fg == ZS_INUSE_RATIO_0) {
 			free_zspage(pool, class, src_zspage);
 			pages_freed += class->pages_per_zspage;
@@ -2025,7 +2017,6 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 		if (get_fullness_group(class, dst_zspage) == ZS_INUSE_RATIO_100
 		    || spin_is_contended(&pool->lock)) {
 			putback_zspage(class, dst_zspage);
-			migrate_write_unlock(dst_zspage);
 			dst_zspage = NULL;
 
 			spin_unlock(&pool->lock);
@@ -2034,15 +2025,12 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 		}
 	}
 
-	if (src_zspage) {
+	if (src_zspage)
 		putback_zspage(class, src_zspage);
-		migrate_write_unlock(src_zspage);
-	}
 
-	if (dst_zspage) {
+	if (dst_zspage)
 		putback_zspage(class, dst_zspage);
-		migrate_write_unlock(dst_zspage);
-	}
+
 	spin_unlock(&pool->lock);
 
 	return pages_freed;

-- 
b4 0.10.1

