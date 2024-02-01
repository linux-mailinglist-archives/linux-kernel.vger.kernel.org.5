Return-Path: <linux-kernel+bounces-48445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1174845C23
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0FE1C21EBF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3967815CD5F;
	Thu,  1 Feb 2024 15:50:36 +0000 (UTC)
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E695626C9
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802635; cv=none; b=nS/wLUCLJTAfxN/omllxJyRrb0qECwyGOR+mmjBDW+61Q2FlfT5PsLhWK1bedL8ZMrAyNgy+YqE0KFfBvSbKayuyr42mrziNFAobM0GUlkAXYSyK26TErSeFzw5odIFdYBSbTfM83MaSz4w/UVfvCdtLhh70LAzYJemTvI+w6lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802635; c=relaxed/simple;
	bh=J1uE4pWFkFDvS8emS66Pzl+FOQ1T7dXIIEbsITHmLoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S0AYtfpgTShW5HPdpajPDCUV/P8OI4V9yh5jMV/ilFWLswMLZllGnexwyl6Gf1e795sh8mXeVpYvhKWskEHJdp/RQLAJHHirZPOoZn4WQLZXz/Z3/4iDmKg5Lu0knX5+YsrtlleMM7pgYs9Hzmz6WNH2Jhodo7kHhjh9el2V1VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Thu, 01 Feb 2024 15:49:04 +0000
Subject: [PATCH 4/6] mm/zswap: remove duplicate_entry debug value
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240201-b4-zswap-invalidate-entry-v1-4-56ed496b6e55@bytedance.com>
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
In-Reply-To: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
To: Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>,
 Yosry Ahmed <yosryahmed@google.com>
Cc: linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>, Chengming Zhou <zhouchengming@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org
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
zswap entry. (Maybe we can reuse it instead of invalidating it?)

So duplicate_entry should be only incremented in the real bug case,
which already have "WARN_ON(1)", it looks redundant to count bug case,
so this patch just remove it.

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

