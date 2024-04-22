Return-Path: <linux-kernel+bounces-152821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 570788AC4B4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E428280A6A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23984D9FE;
	Mon, 22 Apr 2024 07:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IN0hdimM"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249BD4D595
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713769393; cv=none; b=ufabPKDprOA57qrUagqHWw6tDcDV7gPsEMt2tiOMnUBjkmuyI/WuJFKatF9rT3p9w7lX45J4bSROtG//LBy20EBrOuGo/a5JZ1hyumYbQs2cgGSgfb3AlxHIbBuRW0XXYxzzdLpH1bRQqDjCtQeSXjvjhZLSyVtZbI+N7WprHUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713769393; c=relaxed/simple;
	bh=yWTurDLcdd+LcVTVcTzcMm/uwWFm+Hh2kWaKCWEaBTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=glDhGtYcRuVhHRfnMpNOMeCgTen4b//fKVRDhS35YvPtpAlfHQyD8ucBOjr2aAac3XdfyIS6pBEwM5o8vFwVsj0lCQmZpd4C+cwBPCIQ1ZMtqhikvyF4+x/3M68ht1LAYkyuRVABqFIXDMk7N+v90HYYonTProDPZQs/j/Ear0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IN0hdimM; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713769383; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=7TGllQsMjthzKZ5x9FWnodK5JAUiOYpAC2Vw3I8Fy2s=;
	b=IN0hdimMUqaWZcFSTaJIXjCH+tTFJzxeCmLPJhd2oCkve4kbVOBopXgZi3qJ563KQkqxzzrVybxfgvay497lLxddiSY2kLybvJDna37YJQPjRCbi+WO4iwNqXHlnHfiY+UO/czgukWWmIpvfq3HOh0obcaRMVfYCPqCPDLyjOwM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W5.WnjE_1713769380;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W5.WnjE_1713769380)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 15:03:01 +0800
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
Subject: [RFC PATCH 4/5] mm: shmem: add mTHP support for anonymous share pages
Date: Mon, 22 Apr 2024 15:02:42 +0800
Message-Id: <8f2725a856dc02c7c89b4139cc3628686c9de524.1713755580.git.baolin.wang@linux.alibaba.com>
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

Commit 19eaf44954df adds multi-size THP (mTHP) for anonymous pages, that
can allow THP to be configured through the sysfs interface located at
'/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled'.

However, the anonymous share pages will ignore the anonymous mTHP rule
configured through the sysfs interface, and can only use the PMD-mapped
THP, that is not reasonable. Users expect to apply the mTHP rule for
all anonymous pages, including the anonymous share pages, in order to
enjoy the benefits of mTHP. For example, lower latency than PMD-mapped THP,
smaller memory bloat than PMD-mapped THP, contiguous PTEs on ARM architecture
to reduce TLB miss etc.

The primary strategy is that, the use of huge pages for anonymous shared pages
still follows the global control determined by the mount option "huge=" parameter
or the sysfs interface at '/sys/kernel/mm/transparent_hugepage/shmem_enabled'.
The utilization of mTHP is allowed only when the global 'huge' switch is enabled.
Subsequently, the mTHP sysfs interface (/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled)
is checked to determine the mTHP size that can be used for large folio allocation
for these anonymous shared pages.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/huge_mm.h |  2 +-
 mm/huge_memory.c        |  4 +-
 mm/shmem.c              | 92 +++++++++++++++++++++++++++++++----------
 3 files changed, 74 insertions(+), 24 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index b67294d5814f..26b6fa98d8ac 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -246,7 +246,7 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 				       unsigned long orders)
 {
 	/* Optimization to check if required orders are enabled early. */
-	if (enforce_sysfs && vma_is_anonymous(vma)) {
+	if (enforce_sysfs && (vma_is_anonymous(vma) || vma_is_anon_shmem(vma))) {
 		unsigned long mask = READ_ONCE(huge_anon_orders_always);
 
 		if (vm_flags & VM_HUGEPAGE)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9a1b57ef9c60..9e52c0db7580 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -86,7 +86,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 					 unsigned long orders)
 {
 	/* Check the intersection of requested and supported orders. */
-	orders &= vma_is_anonymous(vma) ?
+	orders &= (vma_is_anonymous(vma) || vma_is_anon_shmem(vma)) ?
 			THP_ORDERS_ALL_ANON : THP_ORDERS_ALL_FILE;
 	if (!orders)
 		return 0;
@@ -152,7 +152,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 				     !enforce_sysfs, vma->vm_mm, vm_flags)
 			? orders : 0;
 
-	if (!vma_is_anonymous(vma)) {
+	if (!vma_is_anonymous(vma) && !vma_is_anon_shmem(vma)) {
 		/*
 		 * Enforce sysfs THP requirements as necessary. Anonymous vmas
 		 * were already handled in thp_vma_allowable_orders().
diff --git a/mm/shmem.c b/mm/shmem.c
index b4afda71a3f0..8b009e7040b2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1603,6 +1603,39 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
 	return result;
 }
 
+static unsigned long anon_shmem_suitable_orders(struct vm_fault *vmf,
+					struct address_space *mapping, pgoff_t index)
+{
+	struct vm_area_struct *vma = vmf ? vmf->vma : NULL;
+	unsigned long orders, pages;
+	int order;
+
+	/*
+	 * Get a list of all the (large) orders below PMD_ORDER + 1 that are enabled
+	 * for this vma. Then filter out the orders that can't be allocated over
+	 * the faulting address and still be fully contained in the vma.
+	 */
+	orders = thp_vma_allowable_orders(vma, vma->vm_flags, false, true, true,
+					  BIT(PMD_ORDER + 1) - 1);
+	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
+
+	if (!orders)
+		return orders;
+
+	/* Find the highest order that can add into the page cache */
+	order = highest_order(orders);
+	while (orders) {
+		pages = 1UL << order;
+		index = round_down(index, pages);
+		if (!xa_find(&mapping->i_pages, &index,
+			     index + pages - 1, XA_PRESENT))
+			break;
+		order = next_order(&orders, order);
+	}
+
+	return orders;
+}
+
 static struct folio *shmem_alloc_hugefolio(gfp_t gfp,
 		struct shmem_inode_info *info, pgoff_t index, int order)
 {
@@ -1631,39 +1664,55 @@ static struct folio *shmem_alloc_folio(gfp_t gfp,
 	return (struct folio *)page;
 }
 
-static struct folio *shmem_alloc_and_add_folio(gfp_t gfp,
-		struct inode *inode, pgoff_t index,
+static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
+		gfp_t gfp, struct inode *inode, pgoff_t index,
 		struct mm_struct *fault_mm, bool huge)
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct shmem_inode_info *info = SHMEM_I(inode);
+	struct vm_area_struct *vma = vmf ? vmf->vma : NULL;
 	struct folio *folio;
 	long pages;
 	int error, order;
+	unsigned long orders;
 
 	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
 		huge = false;
 
 	if (huge) {
-		pages = HPAGE_PMD_NR;
-		order = HPAGE_PMD_ORDER;
-		index = round_down(index, HPAGE_PMD_NR);
+		if (vma && vma_is_anon_shmem(vma)) {
+			orders = anon_shmem_suitable_orders(vmf, mapping, index);
+			WARN_ON_ONCE(!orders);
+		} else {
+			pages = HPAGE_PMD_NR;
+			orders = BIT(HPAGE_PMD_ORDER);
+			index = round_down(index, HPAGE_PMD_NR);
 
-		/*
-		 * Check for conflict before waiting on a huge allocation.
-		 * Conflict might be that a huge page has just been allocated
-		 * and added to page cache by a racing thread, or that there
-		 * is already at least one small page in the huge extent.
-		 * Be careful to retry when appropriate, but not forever!
-		 * Elsewhere -EEXIST would be the right code, but not here.
-		 */
-		if (xa_find(&mapping->i_pages, &index,
+			/*
+			 * Check for conflict before waiting on a huge allocation.
+			 * Conflict might be that a huge page has just been allocated
+			 * and added to page cache by a racing thread, or that there
+			 * is already at least one small page in the huge extent.
+			 * Be careful to retry when appropriate, but not forever!
+			 * Elsewhere -EEXIST would be the right code, but not here.
+			 */
+			if (xa_find(&mapping->i_pages, &index,
 				index + HPAGE_PMD_NR - 1, XA_PRESENT))
-			return ERR_PTR(-E2BIG);
+				return ERR_PTR(-E2BIG);
+		}
 
-		folio = shmem_alloc_hugefolio(gfp, info, index, order);
-		if (!folio && pages == HPAGE_PMD_NR)
-			count_vm_event(THP_FILE_FALLBACK);
+		order = highest_order(orders);
+		while (orders) {
+			pages = 1 << order;
+			index = round_down(index, pages);
+			folio = shmem_alloc_hugefolio(gfp, info, index, order);
+			if (folio)
+				goto allocated;
+
+			if (pages == HPAGE_PMD_NR)
+				count_vm_event(THP_FILE_FALLBACK);
+			order = next_order(&orders, order);
+		}
 	} else {
 		pages = 1;
 		folio = shmem_alloc_folio(gfp, info, index);
@@ -1671,6 +1720,7 @@ static struct folio *shmem_alloc_and_add_folio(gfp_t gfp,
 	if (!folio)
 		return ERR_PTR(-ENOMEM);
 
+allocated:
 	__folio_set_locked(folio);
 	__folio_set_swapbacked(folio);
 
@@ -2043,7 +2093,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 
 		huge_gfp = vma_thp_gfp_mask(vma);
 		huge_gfp = limit_gfp_mask(huge_gfp, gfp);
-		folio = shmem_alloc_and_add_folio(huge_gfp,
+		folio = shmem_alloc_and_add_folio(vmf, huge_gfp,
 				inode, index, fault_mm, true);
 		if (!IS_ERR(folio)) {
 			if (folio_test_pmd_mappable(folio))
@@ -2054,7 +2104,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 			goto repeat;
 	}
 
-	folio = shmem_alloc_and_add_folio(gfp, inode, index, fault_mm, false);
+	folio = shmem_alloc_and_add_folio(vmf, gfp, inode, index, fault_mm, false);
 	if (IS_ERR(folio)) {
 		error = PTR_ERR(folio);
 		if (error == -EEXIST)
@@ -2065,7 +2115,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 
 alloced:
 	alloced = true;
-	if (folio_test_pmd_mappable(folio) &&
+	if (folio_test_large(folio) &&
 	    DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE) <
 					folio_next_index(folio) - 1) {
 		struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
-- 
2.39.3


