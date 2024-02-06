Return-Path: <linux-kernel+bounces-54238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DCC84ACB7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE81288682
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C49273163;
	Tue,  6 Feb 2024 03:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CKPkvmNm"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5483B4BAAA
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 03:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707188905; cv=none; b=dLSylD2ZtHuaXt19LFxiK7X9pnVGSKD8DyHCU4/+xi1yJ69qnY24cs73VANxhMkHZf8w81zYWU4EQbpDUiKelm5Kk+qF+W5Cpw3OPgqOz0pdih8JyM0hwG7kGAmOjJ1haBzK+rHjhJg5U3kox/VuY21I65gSc6kMhOXSkieXngE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707188905; c=relaxed/simple;
	bh=W9VSracklWdFWQ06kTb4tXZEKnLldZkwFebfVEFrakA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LsdcuQ1LtqT9F/TONgXgtdwnHauaoKR2w5yM68fsrZ9CRiZoHSRUDl7r6HnubYqB1282uuBQsZ0fFK56ipMU0oLXVWBEPRmN8aQgYW9RS02NDtx4ZLug7FlnOfW6rrIgtTPwHdUUNTFzH1iodJqoaFbrvZxbg/bs/J7FjMfDAps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CKPkvmNm; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707188900; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=lsjZbfVW8/WKO3D8nyVLEixZPG0VzeutC5Yw93QCPIQ=;
	b=CKPkvmNm/pKI/lLVh59JkKEXSXh1mMbKh1voRCLIf3M+kwG4MXYlDZRZ56sWdQtNojWWkrhzqdkJD1ZbVHDf6P223ZKIN+CmWkZJqDPS3oTo6aVtTR5oE8e7h6YGttV8IYYQ0jECf2ibWJpbcX48dMeu6rOxigIdR/mozLKd3Iw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W0CACps_1707188899;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W0CACps_1707188899)
          by smtp.aliyun-inc.com;
          Tue, 06 Feb 2024 11:08:19 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	muchun.song@linux.dev
Cc: osalvador@suse.de,
	david@redhat.com,
	mhocko@kernel.org,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] mm: hugetlb: improve the handling of hugetlb allocation failure for freed or in-use hugetlb
Date: Tue,  6 Feb 2024 11:08:11 +0800
Message-Id: <62890fd60b1ecd5bf1cdc476c973f60fe37aa0cb.1707181934.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

alloc_and_dissolve_hugetlb_folio() preallocates a new hugetlb page before
it takes hugetlb_lock. In 3 out of 4 cases the page is not really used and
therefore the newly allocated page is just freed right away. This is
wasteful and it might cause pre-mature failures in those cases.

Address that by moving the allocation down to the only case (hugetlb
page is really in the free pages pool). We need to drop hugetlb_lock
to do so and therefore need to recheck the page state after regaining
it.

The patch is more of a cleanup than an actual fix to an existing
problem. There are no known reports about pre-mature failures.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
Changes from v2；
 - Update the commit message suggested by Michal.
 - Remove unnecessary comments.
Changes from v1:
 - Update the suject line per Muchun.
 - Move the allocation into the free hugetlb handling branch per Michal.
---
 mm/hugetlb.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9d996fe4ecd9..a05507a2143f 100644
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
@@ -3075,6 +3063,16 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
 		cond_resched();
 		goto retry;
 	} else {
+		if (!new_folio) {
+			spin_unlock_irq(&hugetlb_lock);
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
@@ -3102,9 +3100,11 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
 
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


