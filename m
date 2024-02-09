Return-Path: <linux-kernel+bounces-58997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9178384EFA6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 05:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3EA9B24495
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26BB5C96;
	Fri,  9 Feb 2024 04:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I335ID8P"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD53D5672
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 04:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707453687; cv=none; b=CWYWBGStOdPKQYpbhmyjddYz/gDWxn2OuDKtEIjMQdydRJHCsM4sCOy/UxNQJCEl2bP1Le/bENTZtNrzdbYtjF32nza4Lrjt1Vtxds6zx4PoK+TsP9+Uml3XWwXJijl1WTcDhTxENHsewlKsGgSgZCtGc2ymDz55ysEJ3g5V6fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707453687; c=relaxed/simple;
	bh=nsArxvzWQrtxwkgUmmJZXFm0ppE+dBXbmAR7EVcHb5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SxnRGj5qJYP4833aL7OfKcTrN/nQjwhnZ0QIHJanRteTp/yj5OCVOB0CUpLlMGEpT+37E1XtRh8K0GgosveZzy0AFruzl94nd5lRffliNl41oQMiazXJSsv+e2jE6y2Hi6StyD2a3x7YdDOsGcnY0Q/WGImWpbIxFhVc81msNj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I335ID8P; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707453682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n9ZcmxH5x/iNMg1fUZA7WKzgnA9rAGjtfWpy0ewB9vQ=;
	b=I335ID8PJECo9lA1iIAbMlbBicrenjJMo0+G62AkIn4CEaiwRTc95cmZBiToYDWLPl3utD
	nzqLAMSEyNktjNp6pToZNN/b2XmbyhsedEepDXc4yAipLThAChyseDkPJeD/Utu06+MqSs
	7YeqyzyG1qccEpOeBYz8QdOCpiupg+w=
From: chengming.zhou@linux.dev
To: hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Chris Li <chrisl@kernel.org>
Subject: [PATCH mm-unstable] mm/zswap: optimize and cleanup the invalidation of duplicate entry
Date: Fri,  9 Feb 2024 04:41:12 +0000
Message-Id: <20240209044112.3883835-1-chengming.zhou@linux.dev>
In-Reply-To: <20240207115406.3865746-1-chengming.zhou@linux.dev>
References: <20240207115406.3865746-1-chengming.zhou@linux.dev>
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

So we must invalidate the old duplicate entry before inserting the
new one, which actually doesn't have to be done at the beginning
of zswap_store().

The good point is that we don't need to lock the tree twice in the
normal store success path. And cleanup the loop as we are here.

Note we still need to invalidate the old duplicate entry when store
failed or zswap is disabled , otherwise the new data in swapfile
could be overwrite by the old data in zswap pool when lru writeback.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Chris Li <chrisl@kernel.org>
Acked-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zswap.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 96664cdee207..62fe307521c9 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1517,19 +1517,8 @@ bool zswap_store(struct folio *folio)
 	if (folio_test_large(folio))
 		return false;
 
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
-
 	if (!zswap_enabled)
-		return false;
+		goto check_old;
 
 	objcg = get_obj_cgroup_from_folio(folio);
 	if (objcg && !obj_cgroup_may_zswap(objcg)) {
@@ -1609,14 +1598,12 @@ bool zswap_store(struct folio *folio)
 	/* map */
 	spin_lock(&tree->lock);
 	/*
-	 * A duplicate entry should have been removed at the beginning of this
-	 * function. Since the swap entry should be pinned, if a duplicate is
-	 * found again here it means that something went wrong in the swap
-	 * cache.
+	 * The folio may have been dirtied again, invalidate the
+	 * possibly stale entry before inserting the new entry.
 	 */
-	while (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
-		WARN_ON(1);
+	if (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
 		zswap_invalidate_entry(tree, dupentry);
+		WARN_ON(zswap_rb_insert(&tree->rbroot, entry, &dupentry));
 	}
 	if (entry->length) {
 		INIT_LIST_HEAD(&entry->lru);
@@ -1639,6 +1626,17 @@ bool zswap_store(struct folio *folio)
 reject:
 	if (objcg)
 		obj_cgroup_put(objcg);
+check_old:
+	/*
+	 * If the zswap store fails or zswap is disabled, we must invalidate the
+	 * possibly stale entry which was previously stored at this offset.
+	 * Otherwise, writeback could overwrite the new data in the swapfile.
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


