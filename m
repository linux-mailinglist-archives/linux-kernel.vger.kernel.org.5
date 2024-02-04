Return-Path: <linux-kernel+bounces-51393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 545B3848AC2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088D21F234E1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957F2DDCD;
	Sun,  4 Feb 2024 03:06:27 +0000 (UTC)
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6237EBE4C
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 03:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707015987; cv=none; b=LLqb2iaf5y6he+5wiskzCi/Ta/noJgITzG1ySh8UUwpT5sApVrQzSvn3gTHFZassSHnKMkNvYgs0rlTOcCcDwOIlIshLNWTY74AmveMpm9+hN1I+W3i0M6X/WmK3qK893bkv9yioA+gcP5WVZMZdsYYEYmGzEf83DiQMZ6BuRlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707015987; c=relaxed/simple;
	bh=Iwy2TxI1TgOBTx+y9m1xIIKgohEFXyY3VOBZsXNpH5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rgao2Xj9UKdrUYCY384h6qcL8eihBMeIEBwPQX00vPk7y5wk06/ELQTd92Eo6s/0KZb90hhp/nLNaiUHUUkxTHlaCRRiF5DtQoQ8Q3cVLF6Kypm2uNH0L/depgWBgefYLjgZtYIgdUvUxEUerTrcUcXPMGv1Xe3n3VId0U1HJU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Sun, 04 Feb 2024 03:06:02 +0000
Subject: [PATCH v2 4/6] mm/zswap: remove duplicate_entry debug value
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240201-b4-zswap-invalidate-entry-v2-4-99d4084260a0@bytedance.com>
References: <20240201-b4-zswap-invalidate-entry-v2-0-99d4084260a0@bytedance.com>
In-Reply-To: <20240201-b4-zswap-invalidate-entry-v2-0-99d4084260a0@bytedance.com>
To: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-mm@kvack.org, Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <zhouchengming@bytedance.com>,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

cat /sys/kernel/debug/zswap/duplicate_entry
2086447

When testing, the duplicate_entry value is very high, but no warning
message in the kernel log. From the comment of duplicate_entry
"Duplicate store was encountered (rare)", it seems something goes wrong.

Actually it's incremented in the beginning of zswap_store(), which found
its zswap entry has already on the tree. And this is a normal case,
since the folio could leave zswap entry on the tree after swapin,
later it's dirtied and swapout/zswap_store again, found its original
zswap entry.

So duplicate_entry should be only incremented in the real bug case,
which already have "WARN_ON(1)", it looks redundant to count bug case,
so this patch just remove it.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zswap.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 4381b7a2d4d6..3fbb7e2c8b8d 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -71,8 +71,6 @@ static u64 zswap_reject_compress_poor;
 static u64 zswap_reject_alloc_fail;
 /* Store failed because the entry metadata could not be allocated (rare) */
 static u64 zswap_reject_kmemcache_fail;
-/* Duplicate store was encountered (rare) */
-static u64 zswap_duplicate_entry;
 
 /* Shrinker work queue */
 static struct workqueue_struct *shrink_wq;
@@ -1571,10 +1569,8 @@ bool zswap_store(struct folio *folio)
 	 */
 	spin_lock(&tree->lock);
 	entry = zswap_rb_search(&tree->rbroot, offset);
-	if (entry) {
+	if (entry)
 		zswap_invalidate_entry(tree, entry);
-		zswap_duplicate_entry++;
-	}
 	spin_unlock(&tree->lock);
 	objcg = get_obj_cgroup_from_folio(folio);
 	if (objcg && !obj_cgroup_may_zswap(objcg)) {
@@ -1661,7 +1657,6 @@ bool zswap_store(struct folio *folio)
 	 */
 	while (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
 		WARN_ON(1);
-		zswap_duplicate_entry++;
 		zswap_invalidate_entry(tree, dupentry);
 	}
 	if (entry->length) {
@@ -1822,8 +1817,6 @@ static int zswap_debugfs_init(void)
 			   zswap_debugfs_root, &zswap_reject_compress_poor);
 	debugfs_create_u64("written_back_pages", 0444,
 			   zswap_debugfs_root, &zswap_written_back_pages);
-	debugfs_create_u64("duplicate_entry", 0444,
-			   zswap_debugfs_root, &zswap_duplicate_entry);
 	debugfs_create_u64("pool_total_size", 0444,
 			   zswap_debugfs_root, &zswap_pool_total_size);
 	debugfs_create_atomic_t("stored_pages", 0444,

-- 
b4 0.10.1

