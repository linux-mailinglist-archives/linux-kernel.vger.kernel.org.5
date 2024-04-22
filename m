Return-Path: <linux-kernel+bounces-152817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA1B8AC4B0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B311C20CBB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6E8487B0;
	Mon, 22 Apr 2024 07:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="d9H7dXA3"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D6C482CA
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713769383; cv=none; b=CYftjywwC/1PmhtAnYDJX0BvMWxyOL48jbk1MKh+sp+k8zlA8Koj0UzUNGBRQvz8g9G/EyEMAfPnFPla9Fpxvl/45YJzIpxdB7W6FX0g1JWso2ZjlG39Ez7ibO73hKkitBDlnYNlRKDhxqTOXNbszvkrZ2n7qYxXk4q9zIiO8Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713769383; c=relaxed/simple;
	bh=TBzYTl2S89wFgHKU5IZMBLPsDVAVa/SBQeUl+du9Wzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PAtPjmD8Vv/ilVhhYQlfeX//vJO2Bt8x4XTbZMzMdVrcs9DkXx812aF6RC/3sIlNMvfnDqKKV/OqUrJ87gl3UM7IDjrHI9TDCTONRRCaNaSmTAp3u8QyC8bNnrGi70zaS5iFwhSG5K4FWTvh0x74uz5vVD4iIIvjh6bRb2t3ooI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=d9H7dXA3; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713769378; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=iA51Bkqzy9zcXZ9S3Nkg6q/BBso18kv2IFiMWpEhGCs=;
	b=d9H7dXA3OkN5DMCvZyHjmmKv7zMP+IdJ9zqkOuoZ0p+W8tBIIEhqlgSceJJq1t1yms1JHJ2VSlMYTqaz2Au6/rREcdgMlWllo4gONZI28TaeFugKCrksHHLgAiAl2M0XWaegw8q2PG7XtPQTDGlwjijQnre9x+n77yV/drgkE6s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W5.T-Y-_1713769375;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W5.T-Y-_1713769375)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 15:02:57 +0800
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
Subject: [RFC PATCH 1/5] mm: memory: extend finish_fault() to support large folio
Date: Mon, 22 Apr 2024 15:02:39 +0800
Message-Id: <358aefb1858b63164894d7d8504f3dae0b495366.1713755580.git.baolin.wang@linux.alibaba.com>
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

Add large folio mapping establishment support for finish_fault() as a preparation,
to support multi-size THP allocation of anonymous shared pages in the following
patches.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/memory.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index b6fa5146b260..094a76730776 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4766,7 +4766,10 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct page *page;
+	struct folio *folio;
 	vm_fault_t ret;
+	int nr_pages, i;
+	unsigned long addr;
 
 	/* Did we COW the page? */
 	if ((vmf->flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED))
@@ -4797,22 +4800,30 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 			return VM_FAULT_OOM;
 	}
 
+	folio = page_folio(page);
+	nr_pages = folio_nr_pages(folio);
+	addr = ALIGN_DOWN(vmf->address, nr_pages * PAGE_SIZE);
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
-				      vmf->address, &vmf->ptl);
+				       addr, &vmf->ptl);
 	if (!vmf->pte)
 		return VM_FAULT_NOPAGE;
 
 	/* Re-check under ptl */
-	if (likely(!vmf_pte_changed(vmf))) {
-		struct folio *folio = page_folio(page);
-
-		set_pte_range(vmf, folio, page, 1, vmf->address);
-		ret = 0;
-	} else {
+	if (nr_pages == 1 && vmf_pte_changed(vmf)) {
 		update_mmu_tlb(vma, vmf->address, vmf->pte);
 		ret = VM_FAULT_NOPAGE;
+		goto unlock;
+	} else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
+		for (i = 0; i < nr_pages; i++)
+			update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pte + i);
+		ret = VM_FAULT_NOPAGE;
+		goto unlock;
 	}
 
+	set_pte_range(vmf, folio, &folio->page, nr_pages, addr);
+	ret = 0;
+
+unlock:
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	return ret;
 }
-- 
2.39.3


