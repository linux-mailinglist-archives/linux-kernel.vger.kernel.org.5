Return-Path: <linux-kernel+bounces-51529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BFB848C35
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48A28B244AC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493B114296;
	Sun,  4 Feb 2024 08:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LChvhoaI"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C011427A
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 08:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707035733; cv=none; b=EZ5IdQApmjTifnQGsVAzME++N2eQ5ETon4lnUDvnnx4tqPnX9wnRQ/gVH6Mk8vxpm4XFShXp/jPBfdpioJAzCS72cNkVz2UBqhTsjQ0gubwIR5bKs8njyysNY+GgUL0KRhA/NkDGwhBF+Lu8LUaNUb+7C+4yvDyQClwfSZvO/Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707035733; c=relaxed/simple;
	bh=MCPeAivxQ0qxlpWbWJvDut4U8iutpFpR6TzSF2LDF1s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DK0frTV7udZBItmUUeHibRGIfRX9t49OmQgQbmU0jfuEWvuymkz/EficcmukCh0wh6KL0ogIUDG5GCKRtVrlN4f8FDrVSY+voCMheK9Nythd7i7EAeIZLrTJa3nD1fa95hjARDwf+UfE1J4+mvKfBL6rhybu1r+z057a7eKrVE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LChvhoaI; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707035727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Pbt84SQ0eMAct0yO+KuRCNRVPEgcExEkWU6nZFC8ea8=;
	b=LChvhoaIhcZ6/hsqUPJEAUZUHV/gRdrP42CjAcuvwiYvTOsVaLLc6efBOMJk+LpmTog1wQ
	pOm5xY1EOmu42MeHI95DQcyqYCQ588RUrZQD/l1Yvj+HkWCihFqZ9KntIDAlmJJ640OYSR
	iaAGKZn+vdSF+CHtaOX71CxoxmjGVKU=
From: chengming.zhou@linux.dev
To: hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] mm/zswap: invalidate old entry when store fail or !zswap_enabled
Date: Sun,  4 Feb 2024 08:34:11 +0000
Message-Id: <20240204083411.3762683-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

We may encounter duplicate entry in the zswap_store():

1. swap slot that freed to per-cpu swap cache, doesn't invalidate
   the zswap entry, then got reused. This has been fixed.

2. !exclusive load mode, swapin folio will leave its zswap entry
   on the tree, then swapout again. This has been removed.

3. one folio can be dirtied again after zswap_store(), so need to
   zswap_store() again. This should be handled correctly.

So we must invalidate the old duplicate entry before insert the
new one, which actually doesn't have to be done at the beginning
of zswap_store(). And this is a normal situation, we shouldn't
WARN_ON(1) in this case, so delete it. (The WARN_ON(1) seems want
to detect swap entry UAF problem? But not very necessary here.)

The good point is that we don't need to lock tree twice in the
store success path.

Note we still need to invalidate the old duplicate entry in the
store failure path, otherwise the new data in swapfile could be
overwrite by the old data in zswap pool when lru writeback.

We have to do this even when !zswap_enabled since zswap can be
disabled anytime. If the folio store success before, then got
dirtied again but zswap disabled, we won't invalidate the old
duplicate entry in the zswap_store(). So later lru writeback
may overwrite the new data in swapfile.

This fix is not good, since we have to grab lock to check everytime
even when zswap is disabled, but it's simple.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zswap.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index cd67f7f6b302..0b7599f4116d 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1518,18 +1518,8 @@ bool zswap_store(struct folio *folio)
 		return false;
 
 	if (!zswap_enabled)
-		return false;
+		goto check_old;
 
-	/*
-	 * If this is a duplicate, it must be removed before attempting to store
-	 * it, otherwise, if the store fails the old page won't be removed from
-	 * the tree, and it might be written back overriding the new data.
-	 */
-	spin_lock(&tree->lock);
-	entry = zswap_rb_search(&tree->rbroot, offset);
-	if (entry)
-		zswap_invalidate_entry(tree, entry);
-	spin_unlock(&tree->lock);
 	objcg = get_obj_cgroup_from_folio(folio);
 	if (objcg && !obj_cgroup_may_zswap(objcg)) {
 		memcg = get_mem_cgroup_from_objcg(objcg);
@@ -1608,15 +1598,11 @@ bool zswap_store(struct folio *folio)
 	/* map */
 	spin_lock(&tree->lock);
 	/*
-	 * A duplicate entry should have been removed at the beginning of this
-	 * function. Since the swap entry should be pinned, if a duplicate is
-	 * found again here it means that something went wrong in the swap
-	 * cache.
+	 * The folio could be dirtied again, invalidate the possible old entry
+	 * before insert this new entry.
 	 */
-	while (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
-		WARN_ON(1);
+	while (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST)
 		zswap_invalidate_entry(tree, dupentry);
-	}
 	if (entry->length) {
 		INIT_LIST_HEAD(&entry->lru);
 		zswap_lru_add(&entry->pool->list_lru, entry);
@@ -1638,6 +1624,17 @@ bool zswap_store(struct folio *folio)
 reject:
 	if (objcg)
 		obj_cgroup_put(objcg);
+check_old:
+	/*
+	 * If zswap store fail or zswap disabled, we must invalidate possible
+	 * old entry which previously stored by this folio. Otherwise, later
+	 * writeback could overwrite the new data in swapfile.
+	 */
+	spin_lock(&tree->lock);
+	entry = zswap_rb_search(&tree->rbroot, offset);
+	if (entry)
+		zswap_invalidate_entry(tree, entry);
+	spin_unlock(&tree->lock);
 	return false;
 
 shrink:
-- 
2.40.1


