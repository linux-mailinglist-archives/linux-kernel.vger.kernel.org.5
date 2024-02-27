Return-Path: <linux-kernel+bounces-83804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C15BA869EB2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7886328373D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AED146015;
	Tue, 27 Feb 2024 18:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lruHPCYs"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E4F249EB
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709057633; cv=none; b=sBKHS82qoHzx9HHAaoH/IPrLNvTHE/z9RNhbP1OYv34PnLtE8hZQ3GKeUTbI6pQWJbGr4WhcseIY/UFbFywrPFfw9JxxCHahTLtgur5MeIE0MGCWdNQ0owDdMs5Yk2Vjm05l+/msh5Ns/s+wjhEwoXBMehX+KEAjPgcgHZ3FR5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709057633; c=relaxed/simple;
	bh=BzeGJh5AX1Xtn2QWlBjRHcniA/l6L6jzqn//rRonRic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gmu0DD/+teUeuWp99xUEWnQENA/qEc5OZNwJnBV57+HEPcjjm7SnyYVcheTjXkFeBpWlvFfXddISBtzyMyC+qyORCeBxP6ZFnQhXyQTgt/0+/hcpeYMbLQUCSf79M0VXOU3DkkdUodsBRLT+EMsnTTGNeC8ZB8OUc1A150STdvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lruHPCYs; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41RFYmbb004322;
	Tue, 27 Feb 2024 18:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=iUe/oKMMxdsui1EO/dF5egzqhKb3BoqTHl1Xh3CABlI=;
 b=lruHPCYsN0fB6HgweN3NH4fhH4Ih3pYd+tOXliIzwt97KbMWvacVfpb4FHkMvGOr78dL
 t5Gz1Mqi9NVQ33/ygB74y1/gcZ4SV6IUfgD7L3vcU4OqTowMKdFLJQXs2zwuSp62KDK9
 auDCZUaBj1WC/NJrPbd37eDUBhDtL98ypA+ixJldaXNNnz3mrn3uP5YOD+xPahmoJorn
 I8ODXg0a0YOBp94A5H0yhcRPBKVnYyFB397/oqHAPKas3FIBlWAyfMgN+t8QVZQxedRp
 rm/1s6gf/ufQ3NGZWvhDkzaP6R1j+8gCPwQOAXgJrej5qrp3T+9UpugJT24fJA8O+OQ/ lA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf7ccg1k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 18:13:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41RHlc8s019133;
	Tue, 27 Feb 2024 18:13:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wgbdkfg66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 18:13:40 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41RI9wv7013611;
	Tue, 27 Feb 2024 18:13:40 GMT
Received: from jfwang-mac.us.oracle.com (dhcp-10-65-152-123.vpn.oracle.com [10.65.152.123])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3wgbdkfg50-1;
	Tue, 27 Feb 2024 18:13:40 +0000
From: Jianfeng Wang <jianfeng.w.wang@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, willy@infradead.org, sidhartha.kumar@oracle.com,
        Jianfeng Wang <jianfeng.w.wang@oracle.com>
Subject: [PATCH] mm/cma: convert cma_alloc() to return folio
Date: Tue, 27 Feb 2024 10:13:38 -0800
Message-ID: <20240227181338.59932-1-jianfeng.w.wang@oracle.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_05,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402270141
X-Proofpoint-ORIG-GUID: bx7yr8DJcLOXnd4_IXYq_K9O6H_JGT6O
X-Proofpoint-GUID: bx7yr8DJcLOXnd4_IXYq_K9O6H_JGT6O

Change cma_alloc() to return struct folio. This further increases the
usage of folios in mm/hugetlb.

Signed-off-by: Jianfeng Wang <jianfeng.w.wang@oracle.com>
---
 arch/powerpc/kvm/book3s_hv_builtin.c |  6 ++++--
 drivers/dma-buf/heaps/cma_heap.c     | 18 +++++++++---------
 drivers/s390/char/vmcp.c             |  8 ++++----
 include/linux/cma.h                  |  3 ++-
 kernel/dma/contiguous.c              |  8 ++++++--
 mm/cma.c                             |  4 ++--
 mm/cma_debug.c                       |  6 +++---
 mm/hugetlb.c                         | 13 +++++++------
 8 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index fa0e3a22cac0..f6cd8a55bb1d 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -57,10 +57,12 @@ early_param("kvm_cma_resv_ratio", early_parse_kvm_cma_resv);
 
 struct page *kvm_alloc_hpt_cma(unsigned long nr_pages)
 {
+	struct folio *folio;
 	VM_BUG_ON(order_base_2(nr_pages) < KVM_CMA_CHUNK_ORDER - PAGE_SHIFT);
 
-	return cma_alloc(kvm_cma, nr_pages, order_base_2(HPT_ALIGN_PAGES),
-			 false);
+	folio = cma_alloc(kvm_cma, nr_pages, order_base_2(HPT_ALIGN_PAGES),
+			false);
+	return folio ? &folio->page : NULL;
 }
 EXPORT_SYMBOL_GPL(kvm_alloc_hpt_cma);
 
diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
index 4a63567e93ba..526f7de50759 100644
--- a/drivers/dma-buf/heaps/cma_heap.c
+++ b/drivers/dma-buf/heaps/cma_heap.c
@@ -283,7 +283,7 @@ static struct dma_buf *cma_heap_allocate(struct dma_heap *heap,
 	size_t size = PAGE_ALIGN(len);
 	pgoff_t pagecount = size >> PAGE_SHIFT;
 	unsigned long align = get_order(size);
-	struct page *cma_pages;
+	struct folio *cma_folios;
 	struct dma_buf *dmabuf;
 	int ret = -ENOMEM;
 	pgoff_t pg;
@@ -299,14 +299,14 @@ static struct dma_buf *cma_heap_allocate(struct dma_heap *heap,
 	if (align > CONFIG_CMA_ALIGNMENT)
 		align = CONFIG_CMA_ALIGNMENT;
 
-	cma_pages = cma_alloc(cma_heap->cma, pagecount, align, false);
-	if (!cma_pages)
+	cma_folios = cma_alloc(cma_heap->cma, pagecount, align, false);
+	if (!cma_folios)
 		goto free_buffer;
 
 	/* Clear the cma pages */
-	if (PageHighMem(cma_pages)) {
+	if (folio_test_highmem(cma_folios)) {
 		unsigned long nr_clear_pages = pagecount;
-		struct page *page = cma_pages;
+		struct page *page = &cma_folios->page;
 
 		while (nr_clear_pages > 0) {
 			void *vaddr = kmap_atomic(page);
@@ -323,7 +323,7 @@ static struct dma_buf *cma_heap_allocate(struct dma_heap *heap,
 			nr_clear_pages--;
 		}
 	} else {
-		memset(page_address(cma_pages), 0, size);
+		memset(folio_address(cma_folios), 0, size);
 	}
 
 	buffer->pages = kmalloc_array(pagecount, sizeof(*buffer->pages), GFP_KERNEL);
@@ -333,9 +333,9 @@ static struct dma_buf *cma_heap_allocate(struct dma_heap *heap,
 	}
 
 	for (pg = 0; pg < pagecount; pg++)
-		buffer->pages[pg] = &cma_pages[pg];
+		buffer->pages[pg] = &cma_folios[pg].page;
 
-	buffer->cma_pages = cma_pages;
+	buffer->cma_pages = &cma_folios->page;
 	buffer->heap = cma_heap;
 	buffer->pagecount = pagecount;
 
@@ -355,7 +355,7 @@ static struct dma_buf *cma_heap_allocate(struct dma_heap *heap,
 free_pages:
 	kfree(buffer->pages);
 free_cma:
-	cma_release(cma_heap->cma, cma_pages, pagecount);
+	cma_release(cma_heap->cma, &cma_folios->page, pagecount);
 free_buffer:
 	kfree(buffer);
 
diff --git a/drivers/s390/char/vmcp.c b/drivers/s390/char/vmcp.c
index eb0520a9d4af..b23147e4dba4 100644
--- a/drivers/s390/char/vmcp.c
+++ b/drivers/s390/char/vmcp.c
@@ -59,7 +59,7 @@ void __init vmcp_cma_reserve(void)
 
 static void vmcp_response_alloc(struct vmcp_session *session)
 {
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	int nr_pages, order;
 
 	order = get_order(session->bufsize);
@@ -70,9 +70,9 @@ static void vmcp_response_alloc(struct vmcp_session *session)
 	 * anymore the system won't work anyway.
 	 */
 	if (order > 2)
-		page = cma_alloc(vmcp_cma, nr_pages, 0, false);
-	if (page) {
-		session->response = (char *)page_to_virt(page);
+		folio = cma_alloc(vmcp_cma, nr_pages, 0, false);
+	if (folio) {
+		session->response = (char *)page_to_virt(&folio->page);
 		session->cma_alloc = 1;
 		return;
 	}
diff --git a/include/linux/cma.h b/include/linux/cma.h
index 63873b93deaa..4c6234787fd8 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -25,6 +25,7 @@
 #define CMA_MIN_ALIGNMENT_BYTES (PAGE_SIZE * CMA_MIN_ALIGNMENT_PAGES)
 
 struct cma;
+struct page;
 
 extern unsigned long totalcma_pages;
 extern phys_addr_t cma_get_base(const struct cma *cma);
@@ -48,7 +49,7 @@ extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 					unsigned int order_per_bit,
 					const char *name,
 					struct cma **res_cma);
-extern struct page *cma_alloc(struct cma *cma, unsigned long count, unsigned int align,
+extern struct folio *cma_alloc(struct cma *cma, unsigned long count, unsigned int align,
 			      bool no_warn);
 extern bool cma_pages_valid(struct cma *cma, const struct page *pages, unsigned long count);
 extern bool cma_release(struct cma *cma, const struct page *pages, unsigned long count);
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index f005c66f378c..af00d96fba7b 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -310,10 +310,12 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
 struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
 				       unsigned int align, bool no_warn)
 {
+	struct folio *folio;
 	if (align > CONFIG_CMA_ALIGNMENT)
 		align = CONFIG_CMA_ALIGNMENT;
 
-	return cma_alloc(dev_get_cma_area(dev), count, align, no_warn);
+	folio = cma_alloc(dev_get_cma_area(dev), count, align, no_warn);
+	return folio ? &folio->page : NULL;
 }
 
 /**
@@ -334,9 +336,11 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
 
 static struct page *cma_alloc_aligned(struct cma *cma, size_t size, gfp_t gfp)
 {
+	struct folio *folio;
 	unsigned int align = min(get_order(size), CONFIG_CMA_ALIGNMENT);
 
-	return cma_alloc(cma, size >> PAGE_SHIFT, align, gfp & __GFP_NOWARN);
+	folio = cma_alloc(cma, size >> PAGE_SHIFT, align, gfp & __GFP_NOWARN);
+	return folio ? &folio->page : NULL;
 }
 
 /**
diff --git a/mm/cma.c b/mm/cma.c
index 7c09c47e530b..44db112b8aa5 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -426,7 +426,7 @@ static inline void cma_debug_show_areas(struct cma *cma) { }
  * This function allocates part of contiguous memory on specific
  * contiguous memory area.
  */
-struct page *cma_alloc(struct cma *cma, unsigned long count,
+struct folio *cma_alloc(struct cma *cma, unsigned long count,
 		       unsigned int align, bool no_warn)
 {
 	unsigned long mask, offset;
@@ -525,7 +525,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 			cma_sysfs_account_fail_pages(cma, count);
 	}
 
-	return page;
+	return page ? page_folio(page) : NULL;
 }
 
 bool cma_pages_valid(struct cma *cma, const struct page *pages,
diff --git a/mm/cma_debug.c b/mm/cma_debug.c
index 602fff89b15f..703a6b93d964 100644
--- a/mm/cma_debug.c
+++ b/mm/cma_debug.c
@@ -131,14 +131,14 @@ DEFINE_DEBUGFS_ATTRIBUTE(cma_free_fops, NULL, cma_free_write, "%llu\n");
 static int cma_alloc_mem(struct cma *cma, int count)
 {
 	struct cma_mem *mem;
-	struct page *p;
+	struct folio *folio;
 
 	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
 	if (!mem)
 		return -ENOMEM;
 
-	p = cma_alloc(cma, count, 0, false);
-	if (!p) {
+	folio = cma_alloc(cma, count, 0, false);
+	if (!folio) {
 		kfree(mem);
 		return -ENOMEM;
 	}
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ed1581b670d4..22a3741e6e04 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1571,13 +1571,14 @@ static struct folio *alloc_gigantic_folio(struct hstate *h, gfp_t gfp_mask,
 
 #ifdef CONFIG_CMA
 	{
+		struct folio *folio;
 		int node;
 
 		if (hugetlb_cma[nid]) {
-			page = cma_alloc(hugetlb_cma[nid], nr_pages,
+			folio = cma_alloc(hugetlb_cma[nid], nr_pages,
 					huge_page_order(h), true);
-			if (page)
-				return page_folio(page);
+			if (folio)
+				return folio;
 		}
 
 		if (!(gfp_mask & __GFP_THISNODE)) {
@@ -1585,10 +1586,10 @@ static struct folio *alloc_gigantic_folio(struct hstate *h, gfp_t gfp_mask,
 				if (node == nid || !hugetlb_cma[node])
 					continue;
 
-				page = cma_alloc(hugetlb_cma[node], nr_pages,
+				folio = cma_alloc(hugetlb_cma[node], nr_pages,
 						huge_page_order(h), true);
-				if (page)
-					return page_folio(page);
+				if (folio)
+					return folio;
 			}
 		}
 	}
-- 
2.42.1


