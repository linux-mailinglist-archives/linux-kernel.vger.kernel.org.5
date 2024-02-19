Return-Path: <linux-kernel+bounces-71405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C04EC85A4B2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C65228159A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748B836AE0;
	Mon, 19 Feb 2024 13:34:28 +0000 (UTC)
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0630236137
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708349668; cv=none; b=CZQ/boAiDV0a/4lcatRjjUQ2THkQYdJy+zPjx/7RgguDHZ+KXCbWFQj5ONBdTuw6LZIe2WoIop1igU45ffVqJkOY+lEVWMAbiaTnKS2oepSSrWhNgR+M4alFM6u3dxhevDsyEETviK7T4GHCWnS4kveD3rgEwefj+g91gnFpa8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708349668; c=relaxed/simple;
	bh=UHSVodPnpBiivncRsTV1Arftl0WePz5UFf9WpjK+7+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d1rKpxE8LaOlSizWoe0QwLSgG3Iro+tYiebXrw6IQWrckhx/hSSrvIE57mH3ag1ZDWoOzCNFEAStz81X/KaflRvXpWe70Qaxb9ysXAILFskau76EJEm4sWTTXD/GB+ny/kzWScDpC3pfHe0d9kK0USH2rGOEXyQuHS3PkM7lVlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Mon, 19 Feb 2024 13:33:51 +0000
Subject: [PATCH 1/3] mm/zsmalloc: fix migrate_write_lock() when !CONFIG_COMPACTION
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240219-b4-szmalloc-migrate-v1-1-34cd49c6545b@bytedance.com>
References: <20240219-b4-szmalloc-migrate-v1-0-34cd49c6545b@bytedance.com>
In-Reply-To: <20240219-b4-szmalloc-migrate-v1-0-34cd49c6545b@bytedance.com>
To: nphamcs@gmail.com, yosryahmed@google.com, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, hannes@cmpxchg.org
Cc: linux-mm@kvack.org, Chengming Zhou <zhouchengming@bytedance.com>, linux-kernel@vger.kernel.org
X-Migadu-Flow: FLOW_OUT

migrate_write_lock() is a empty function when !CONFIG_COMPACTION, in
which case zs_compact() can be triggered from shrinker reclaim context.
(Maybe it's better to rename it to zs_shrink()?)

And zspage map object users rely on this migrate_read_lock() so object
won't be migrated elsewhere.

Fix it by always implementing the migrate_write_lock() related functions.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zsmalloc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index c937635e0ad1..64d5533fa5d8 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -278,18 +278,15 @@ static bool ZsHugePage(struct zspage *zspage)
 static void migrate_lock_init(struct zspage *zspage);
 static void migrate_read_lock(struct zspage *zspage);
 static void migrate_read_unlock(struct zspage *zspage);
-
-#ifdef CONFIG_COMPACTION
 static void migrate_write_lock(struct zspage *zspage);
 static void migrate_write_lock_nested(struct zspage *zspage);
 static void migrate_write_unlock(struct zspage *zspage);
+
+#ifdef CONFIG_COMPACTION
 static void kick_deferred_free(struct zs_pool *pool);
 static void init_deferred_free(struct zs_pool *pool);
 static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage);
 #else
-static void migrate_write_lock(struct zspage *zspage) {}
-static void migrate_write_lock_nested(struct zspage *zspage) {}
-static void migrate_write_unlock(struct zspage *zspage) {}
 static void kick_deferred_free(struct zs_pool *pool) {}
 static void init_deferred_free(struct zs_pool *pool) {}
 static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage) {}
@@ -1725,7 +1722,6 @@ static void migrate_read_unlock(struct zspage *zspage) __releases(&zspage->lock)
 	read_unlock(&zspage->lock);
 }
 
-#ifdef CONFIG_COMPACTION
 static void migrate_write_lock(struct zspage *zspage)
 {
 	write_lock(&zspage->lock);
@@ -1741,6 +1737,7 @@ static void migrate_write_unlock(struct zspage *zspage)
 	write_unlock(&zspage->lock);
 }
 
+#ifdef CONFIG_COMPACTION
 /* Number of isolated subpage for *page migration* in this zspage */
 static void inc_zspage_isolation(struct zspage *zspage)
 {

-- 
b4 0.10.1

