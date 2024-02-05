Return-Path: <linux-kernel+bounces-52020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DDF8492E2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 04:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A747E1F21EE4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 03:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B03AD27;
	Mon,  5 Feb 2024 03:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gnz7E3ZI"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADAF9474
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 03:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707105274; cv=none; b=I9VeX0ZieQP6mhKz+iwRm3PTlM1v5eTrEOjz9AFIKlOaaaxqL5nwmTmXFUCqxmkvfmscEHOyOjWt7opRvKCXeuFq9MYgBfMBze4dPnJzr4X6ROmJa6obrV9XaU9Xt8CvsXvrjAct1CiMt+RHPMz8U7kTOEzbkHefuZ14lZsfOmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707105274; c=relaxed/simple;
	bh=5UZD8O3S7MyGqYNX0Pw4AhJoeza+Svr9UOPoihuLHms=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NE9gEBJ7yAmdzcjbVyJcJsnpEiqgho7drT5B+dWJrM1q+xDn43yXLdBGnCz3gOPFk5Qkwe15KeKKhSNt66Zp0RaD07WSwwrJjcirOBrt8H1GCWdjn7FmuXIb/cIVBvy0RUSgje5TFmNxMfo+928pSwXaB99XxnOys5yJ/KtBUyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gnz7E3ZI; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707105263; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=vSiJJMfX52mmBCYj2MFQe+6cAYIwJlgaq+HlVSo63jQ=;
	b=gnz7E3ZIzsp8TWYxHWpumdj1vQjFmS9Bu/RKi03bOKep7ZU///DhGjg02RAxzKqDJw6oFmpEHMB5XYJcun2G2C4Bz9BobDhXnBmVALWPUdvZYgaLhltkfJhfTxBVTk3FCpwmloOnofnKD8flRZRQegYwE8D8Ws0L3I3CV0nWZxU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W02KW8o_1707105262;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W02KW8o_1707105262)
          by smtp.aliyun-inc.com;
          Mon, 05 Feb 2024 11:54:23 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	muchun.song@linux.dev
Cc: osalvador@suse.de,
	david@redhat.com,
	mhocko@kernel.org,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: hugetlb: fix hugetlb allocation failure when handling freed or in-use hugetlb
Date: Mon,  5 Feb 2024 11:54:17 +0800
Message-Id: <b2e6ce111400670d8021baf4d7ac524ae78a40d5.1707105047.git.baolin.wang@linux.alibaba.com>
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
since we did not use the new allocated hugetlb in this 2 cases.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/hugetlb.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9d996fe4ecd9..212ab331d355 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3042,9 +3042,8 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
 	 * under the lock.
 	 */
 	new_folio = alloc_buddy_hugetlb_folio(h, gfp_mask, nid, NULL, NULL);
-	if (!new_folio)
-		return -ENOMEM;
-	__prep_new_hugetlb_folio(h, new_folio);
+	if (new_folio)
+		__prep_new_hugetlb_folio(h, new_folio);
 
 retry:
 	spin_lock_irq(&hugetlb_lock);
@@ -3075,6 +3074,11 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
 		cond_resched();
 		goto retry;
 	} else {
+		if (!new_folio) {
+			ret = -ENOMEM;
+			goto free_new;
+		}
+
 		/*
 		 * Ok, old_folio is still a genuine free hugepage. Remove it from
 		 * the freelist and decrease the counters. These will be
@@ -3102,9 +3106,11 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
 
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


