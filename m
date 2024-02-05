Return-Path: <linux-kernel+bounces-52658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B9A849B1E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60864B21F0F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235EC210ED;
	Mon,  5 Feb 2024 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LEE5vTzE"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3189E1D6AE
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137469; cv=none; b=OQh1djMjcBO0DAWQJTOTgxznAwv5aOO8p76NUFUa4dJKqUq9EYhuoCtSzYvistwqtC/IweEFoYdYEb9GTjjZqmFncNRKSXcd1CRhLXBvSA577nLDYQbUOJAzM84sMwTHskbADRE7qTfIJSjeV0QyftZT5DYh/KWjhCFMjLfW5oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137469; c=relaxed/simple;
	bh=nslXHNI8v0F+oMDNIFeZ05nX7qB4EcFT9zHVVXaoppM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ScWc469y+dgp0LRGsUVR4gNB8LvGMe9rU5Q4fzL0yt1FFjGiJw8LIJ5WVS+tVT12JiCRy9tK//gl9Ed9tOaeXGKAy75wANo3AgoLfYRm/tb7x28WcVV3CFzWTvEdT+IpExr8uWEsOqvFdYX5rnEeY4mmtD4tnmW8SdJxm9AGoMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LEE5vTzE; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707137459; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=s/Pp95J1WK6GTpmalhMVjkVH/7wA3cd9KPuozZdyxCQ=;
	b=LEE5vTzElrI4TMZU1TZ5xU/oPSx81vChYf8A5DeD1HJ7cDLJXfg1KtCwLaYeSS/X2318IslOwbK2cWR01Nw7CnwDsBEwSHFBv+VHBGcjOjQ69ILllfSEntPrmsUt/s9KnKanO0DNp+RKwBS5USaYOzKDQ48F1Uu5zFlXyEaZbXA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W0AV717_1707137458;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W0AV717_1707137458)
          by smtp.aliyun-inc.com;
          Mon, 05 Feb 2024 20:50:59 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	muchun.song@linux.dev
Cc: osalvador@suse.de,
	david@redhat.com,
	mhocko@kernel.org,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm: hugetlb: improve the handling of hugetlb allocation failure for freed or in-use hugetlb
Date: Mon,  5 Feb 2024 20:50:51 +0800
Message-Id: <23814ccce5dd3cd30fd67aa692fd0bf3514b0166.1707137359.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When handling the freed hugetlb or in-use hugetlb, we should ignore the
failure of alloc_buddy_hugetlb_folio() to dissolve the old hugetlb successfully,
since we did not use the new allocated hugetlb in this 2 cases. Moreover,
moving the allocation into the free hugetlb handling branch.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
Changes from v1:
 - Update the suject line per Muchun.
 - Move the allocation into the free hugetlb handling branch per Michal.
---
 mm/hugetlb.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9d996fe4ecd9..4899167d3652 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3031,21 +3031,9 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
 {
 	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
 	int nid = folio_nid(old_folio);
-	struct folio *new_folio;
+	struct folio *new_folio = NULL;
 	int ret = 0;
 
-	/*
-	 * Before dissolving the folio, we need to allocate a new one for the
-	 * pool to remain stable.  Here, we allocate the folio and 'prep' it
-	 * by doing everything but actually updating counters and adding to
-	 * the pool.  This simplifies and let us do most of the processing
-	 * under the lock.
-	 */
-	new_folio = alloc_buddy_hugetlb_folio(h, gfp_mask, nid, NULL, NULL);
-	if (!new_folio)
-		return -ENOMEM;
-	__prep_new_hugetlb_folio(h, new_folio);
-
 retry:
 	spin_lock_irq(&hugetlb_lock);
 	if (!folio_test_hugetlb(old_folio)) {
@@ -3075,6 +3063,24 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
 		cond_resched();
 		goto retry;
 	} else {
+		if (!new_folio) {
+			spin_unlock_irq(&hugetlb_lock);
+			/*
+			 * Before dissolving the free hugetlb, we need to allocate
+			 * a new one for the pool to remain stable.  Here, we
+			 * allocate the folio and 'prep' it by doing everything
+			 * but actually updating counters and adding to the pool.
+			 * This simplifies and let us do most of the processing
+			 * under the lock.
+			 */
+			new_folio = alloc_buddy_hugetlb_folio(h, gfp_mask, nid,
+							      NULL, NULL);
+			if (!new_folio)
+				return -ENOMEM;
+			__prep_new_hugetlb_folio(h, new_folio);
+			goto retry;
+		}
+
 		/*
 		 * Ok, old_folio is still a genuine free hugepage. Remove it from
 		 * the freelist and decrease the counters. These will be
@@ -3102,9 +3108,11 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
 
 free_new:
 	spin_unlock_irq(&hugetlb_lock);
-	/* Folio has a zero ref count, but needs a ref to be freed */
-	folio_ref_unfreeze(new_folio, 1);
-	update_and_free_hugetlb_folio(h, new_folio, false);
+	if (new_folio) {
+		/* Folio has a zero ref count, but needs a ref to be freed */
+		folio_ref_unfreeze(new_folio, 1);
+		update_and_free_hugetlb_folio(h, new_folio, false);
+	}
 
 	return ret;
 }
-- 
2.39.3


