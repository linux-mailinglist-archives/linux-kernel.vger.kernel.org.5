Return-Path: <linux-kernel+bounces-152820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F0A8AC4B3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B14E61F21984
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060A84D584;
	Mon, 22 Apr 2024 07:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tDCV8JxE"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F97D4C62A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713769390; cv=none; b=Ovux13yXhI9GzWSeTwROWK1UhYIW/03baYpC69MjPZkOMEqczf42DyyJCJ6k6A3J+o3wmAY0ogLvPZgmlXkqMiDmEm6+62XhX0QyFqU6vnphGSr51rbRUMyeghRMtogTDbnvXdQOyNrQeLi/kTX+/ngb2ZBdBSFTDreblw/0Zrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713769390; c=relaxed/simple;
	bh=UVfFjDMATJJc4EWQb5F1toBkG4v8CsSGgcSCyesdW4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OLmCEJY+1dEBJubeQrbvzv0Iw3RsUl8Hwd02ARDvdqyXcE0DQSqsDgxmAxjIf80t2I6ve5SEL2RLIVI+aUoM4HGZPUMiC/kiLGY5v4MkPBoSZLh/ZZK2oS5r5i74aGukQ7h+YZJxtSgb8wPUsNCTAax+psAI7DJEBkQCnTQ/fSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tDCV8JxE; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713769380; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=BV2U/IeVyqp2XSH/3wx9gpceXxijONOM8cRleKyQmTE=;
	b=tDCV8JxEBCbqsQDyR0vP1FoyKkyzBNksQ1vUo9tSdXVQLC+8aj9bSUOj1fJ8OyL1HC1zu90J4qQ21uq0mOdfF2zWdEUhtdb7Q5z29x2j3J+9g9y9v/iUG9NQL5MtAuuh6jL4rlYLap2RbNR5G7N5jlTe9dTMuZ3xMRCuNqwqEys=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W5.T-YL_1713769377;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W5.T-YL_1713769377)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 15:02:58 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/5] mm: shmem: add an 'order' parameter for shmem_alloc_hugefolio()
Date: Mon, 22 Apr 2024 15:02:40 +0800
Message-Id: <2014bf7370d78bc1f5600731af5bf8f569e5868b.1713755580.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1713755580.git.baolin.wang@linux.alibaba.com>
References: <cover.1713755580.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new parameter to specify the huge page order for shmem_alloc_hugefolio(),
as a preparation to supoort mTHP.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index fa2a0ed97507..893c88efc45f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1604,14 +1604,14 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
 }
 
 static struct folio *shmem_alloc_hugefolio(gfp_t gfp,
-		struct shmem_inode_info *info, pgoff_t index)
+		struct shmem_inode_info *info, pgoff_t index, int order)
 {
 	struct mempolicy *mpol;
 	pgoff_t ilx;
 	struct page *page;
 
-	mpol = shmem_get_pgoff_policy(info, index, HPAGE_PMD_ORDER, &ilx);
-	page = alloc_pages_mpol(gfp, HPAGE_PMD_ORDER, mpol, ilx, numa_node_id());
+	mpol = shmem_get_pgoff_policy(info, index, order, &ilx);
+	page = alloc_pages_mpol(gfp, order, mpol, ilx, numa_node_id());
 	mpol_cond_put(mpol);
 
 	return page_rmappable_folio(page);
@@ -1639,13 +1639,14 @@ static struct folio *shmem_alloc_and_add_folio(gfp_t gfp,
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct folio *folio;
 	long pages;
-	int error;
+	int error, order;
 
 	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
 		huge = false;
 
 	if (huge) {
 		pages = HPAGE_PMD_NR;
+		order = HPAGE_PMD_ORDER;
 		index = round_down(index, HPAGE_PMD_NR);
 
 		/*
@@ -1660,7 +1661,7 @@ static struct folio *shmem_alloc_and_add_folio(gfp_t gfp,
 				index + HPAGE_PMD_NR - 1, XA_PRESENT))
 			return ERR_PTR(-E2BIG);
 
-		folio = shmem_alloc_hugefolio(gfp, info, index);
+		folio = shmem_alloc_hugefolio(gfp, info, index, order);
 		if (!folio)
 			count_vm_event(THP_FILE_FALLBACK);
 	} else {
-- 
2.39.3


