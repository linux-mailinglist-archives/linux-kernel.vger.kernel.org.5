Return-Path: <linux-kernel+bounces-159481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A66878B2F33
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA97B1C20B99
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6E178C95;
	Fri, 26 Apr 2024 03:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="x8ZVAN9I"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011B376408
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714103009; cv=none; b=AjI4GyEU6lmU27/nWBFi8qwuFY0xkmQGeXD4xdhJvCETZvvTOutaok8bNTnh0KfcZrTSXw8RzRekCzsnCLDFoEjsQVjhWsq6/w9rk+t+cDHoe8weSxN0W9JV7ZKb6DW8F9Z41MErQADmYQmBH7PomEUb2OewmGN9mf47JGQSrhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714103009; c=relaxed/simple;
	bh=z7tn/unxQEXHXGcuLbspU3ZbRdF8xTwEfu49p+gXjFQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otvxA3GFOfICYAxVc98XQK5Cc79M1S6RfJG4maUYdrGqwQKEUICelGrKvQjIOcm92dTl7RRXdZhY9XPeIxRB8GXvhukW0fOYoyh5Yj/QUcxjM53PMmQYN0enzVNrplWCMzbjEmAf2ZPz8o+pAKDrOPklT1HSf6C7PjuySIxdDAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=x8ZVAN9I; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-439dfa27003so9718101cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 20:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1714103007; x=1714707807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9nuts9l1zCDLqoFks7w3ko3FmsmK+1Col1dS1KLKxxU=;
        b=x8ZVAN9IThHFHV6tn+M2tHvtcBTVwS+69PY5P1S9D2HpBXUPsiS5ZK0bzjnnKns+UZ
         CWYWpPU70PfnrudbalOfNUyaA1Pgp+tBTmq/MJDBHVFtlROMUGabBDGk9fBdqHHSL1eB
         ydcTD+JINkbxaD3ICmHAZX3EGyfo/cPCr7QudoOTymz017eeu9JJsnKLT0o+YXmZW6li
         Gj1AzjZPQ2BsSicR/Kns27+PezgOiQzTmejngD3g1cwgUupaBQ5mbEJpRKyyAvFQmv58
         HHwM/bkytrDhaqv3TG4ED+79Fl3WKLkX3BQudUaQ/n4ArAjrq+oGGFg/CtJVA8SsTyal
         DHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714103007; x=1714707807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nuts9l1zCDLqoFks7w3ko3FmsmK+1Col1dS1KLKxxU=;
        b=UhSSBL1PkB92pq18/2Ge66f3mINynLTZBULnOVTeUO+Y/5QzU/p7RpJbcb3EMqKE+L
         2YQBiInXtCXFf8SCic87aaQ757jNMU1A1jZViJ8iroPSzWJKX1JNsCoManTkIA8NIXRX
         n+YTxJ/WpP08Wpmmjczw5UwDf5cHzOESrgRZsTvkekNNTSHqa1Het+fOdnAAtmusKVSf
         54KpNmGgaxugYqS2DaJkmFbeVK3VuOd7iWsKDMyLMUo4g0IKRZ8PVFsAabHTNxSqGDFA
         T2ys7fTAp4HHqyLq94Agz4jCIvUKVR6bv0bU8Tjj9aVpsQfTbHjhPYprGIneCOckIaDK
         a4Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXOih9ubjopsiItN2af5rXEIsGq/x3cO/KRMLAj3Q/c8SuuPxt2JAS4x3o/gQ103dg+FnGNaWR0PJgJOANkY826klh7Qvlct2IWxlND
X-Gm-Message-State: AOJu0Yy6n3p497vAkHkhXzYXOcbhb2AbqvlOFyNzb/jEGvQteOHeFLgU
	8qRjmYzsKd+bqZ0/9JMypP7H34poiQoLo/qGMRs266p3P9DwfJKmq3RJBX6NcK7mnvVYDY8UJ7a
	L
X-Google-Smtp-Source: AGHT+IE86KR+B7xfnZmKKOIt5yjOU6xWcIyovaxdsmvq0Zq76unVSgS9+jQ02n8Qi9Da0wnUCx3NpQ==
X-Received: by 2002:ac8:5981:0:b0:439:bb89:1fe1 with SMTP id e1-20020ac85981000000b00439bb891fe1mr1607609qte.4.1714103006889;
        Thu, 25 Apr 2024 20:43:26 -0700 (PDT)
Received: from soleen.c.googlers.com.com (129.177.85.34.bc.googleusercontent.com. [34.85.177.129])
        by smtp.gmail.com with ESMTPSA id c6-20020ac80546000000b00436bb57faddsm7540815qth.25.2024.04.25.20.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 20:43:26 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	pasha.tatashin@soleen.com,
	linux-kernel@vger.kernel.org,
	rientjes@google.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	iommu@lists.linux.dev
Subject: [RFC v2 1/3] iommu/intel: Use page->_mapcount to count number of entries in IOMMU
Date: Fri, 26 Apr 2024 03:43:21 +0000
Message-ID: <20240426034323.417219-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
In-Reply-To: <20240426034323.417219-1-pasha.tatashin@soleen.com>
References: <20240426034323.417219-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to be able to efficiently free empty page table levels, count
the number of entries in each page table by incremeanting and
decremeanting mapcount every time a PTE is inserted or removed form the
page table.

For this to work correctly, add two helper function:
dma_clear_pte and dma_set_pte where counting is performed,

Also, modify the code so every page table entry is always updated using
the two new functions.

Finally, before pages are freed, we must restore mapcount to its original
state by calling page_mapcount_reset().

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/iommu/intel/iommu.c | 42 ++++++++++++++++++++++---------------
 drivers/iommu/intel/iommu.h | 39 ++++++++++++++++++++++++++++------
 drivers/iommu/iommu-pages.h | 30 +++++++++++++++++++-------
 3 files changed, 81 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7abe76f92a3c..1bfb6eccad05 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -862,7 +862,7 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 			if (domain->use_first_level)
 				pteval |= DMA_FL_PTE_XD | DMA_FL_PTE_US | DMA_FL_PTE_ACCESS;
 
-			if (cmpxchg64(&pte->val, 0ULL, pteval))
+			if (dma_set_pte(pte, pteval))
 				/* Someone else set it while we were thinking; use theirs. */
 				iommu_free_page(tmp_page);
 			else
@@ -934,7 +934,8 @@ static void dma_pte_clear_range(struct dmar_domain *domain,
 			continue;
 		}
 		do {
-			dma_clear_pte(pte);
+			if (dma_pte_present(pte))
+				dma_clear_pte(pte);
 			start_pfn += lvl_to_nr_pages(large_page);
 			pte++;
 		} while (start_pfn <= last_pfn && !first_pte_in_page(pte));
@@ -975,7 +976,8 @@ static void dma_pte_free_level(struct dmar_domain *domain, int level,
 		 */
 		if (level < retain_level && !(start_pfn > level_pfn ||
 		      last_pfn < level_pfn + level_size(level) - 1)) {
-			dma_clear_pte(pte);
+			if (dma_pte_present(pte))
+				dma_clear_pte(pte);
 			domain_flush_cache(domain, pte, sizeof(*pte));
 			iommu_free_page(level_pte);
 		}
@@ -1006,12 +1008,13 @@ static void dma_pte_free_pagetable(struct dmar_domain *domain,
 	}
 }
 
-/* When a page at a given level is being unlinked from its parent, we don't
-   need to *modify* it at all. All we need to do is make a list of all the
-   pages which can be freed just as soon as we've flushed the IOTLB and we
-   know the hardware page-walk will no longer touch them.
-   The 'pte' argument is the *parent* PTE, pointing to the page that is to
-   be freed. */
+/*
+ * A given page at a given level is being unlinked from its parent.
+ * We need to make a list of all the pages which can be freed just as soon as
+ * we've flushed the IOTLB and we know the hardware page-walk will no longer
+ * touch them. The 'pte' argument is the *parent* PTE, pointing to the page
+ * that is to be freed.
+ */
 static void dma_pte_list_pagetables(struct dmar_domain *domain,
 				    int level, struct dma_pte *pte,
 				    struct list_head *freelist)
@@ -1019,17 +1022,21 @@ static void dma_pte_list_pagetables(struct dmar_domain *domain,
 	struct page *pg;
 
 	pg = pfn_to_page(dma_pte_addr(pte) >> PAGE_SHIFT);
-	list_add_tail(&pg->lru, freelist);
-
-	if (level == 1)
-		return;
-
 	pte = page_address(pg);
+
 	do {
-		if (dma_pte_present(pte) && !dma_pte_superpage(pte))
-			dma_pte_list_pagetables(domain, level - 1, pte, freelist);
+		if (dma_pte_present(pte)) {
+			if (level > 1 && !dma_pte_superpage(pte)) {
+				dma_pte_list_pagetables(domain, level - 1, pte,
+							freelist);
+			}
+			dma_clear_pte(pte);
+		}
 		pte++;
 	} while (!first_pte_in_page(pte));
+
+	page_mapcount_reset(pg);
+	list_add_tail(&pg->lru, freelist);
 }
 
 static void dma_pte_clear_level(struct dmar_domain *domain, int level,
@@ -1093,6 +1100,7 @@ static void domain_unmap(struct dmar_domain *domain, unsigned long start_pfn,
 	/* free pgd */
 	if (start_pfn == 0 && last_pfn == DOMAIN_MAX_PFN(domain->gaw)) {
 		struct page *pgd_page = virt_to_page(domain->pgd);
+		page_mapcount_reset(pgd_page);
 		list_add_tail(&pgd_page->lru, freelist);
 		domain->pgd = NULL;
 	}
@@ -2113,7 +2121,7 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 		/* We don't need lock here, nobody else
 		 * touches the iova range
 		 */
-		tmp = cmpxchg64_local(&pte->val, 0ULL, pteval);
+		tmp = dma_set_pte(pte, pteval);
 		if (tmp) {
 			static int dumps = 5;
 			pr_crit("ERROR: DMA PTE for vPFN 0x%lx already set (to %llx not %llx)\n",
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 8d081d8c6f41..e5c1eb23897f 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -814,11 +814,6 @@ struct dma_pte {
 	u64 val;
 };
 
-static inline void dma_clear_pte(struct dma_pte *pte)
-{
-	pte->val = 0;
-}
-
 static inline u64 dma_pte_addr(struct dma_pte *pte)
 {
 #ifdef CONFIG_64BIT
@@ -830,9 +825,41 @@ static inline u64 dma_pte_addr(struct dma_pte *pte)
 #endif
 }
 
+#define DMA_PTEVAL_PRESENT(pteval) (((pteval) & 3) != 0)
 static inline bool dma_pte_present(struct dma_pte *pte)
 {
-	return (pte->val & 3) != 0;
+	return DMA_PTEVAL_PRESENT(pte->val);
+}
+
+static inline void dma_clear_pte(struct dma_pte *pte)
+{
+	u64 old_pteval;
+
+	old_pteval = xchg(&pte->val, 0ULL);
+	if (DMA_PTEVAL_PRESENT(old_pteval)) {
+		struct page *pg = virt_to_page(pte);
+
+		atomic_dec(&pg->_mapcount);
+	} else {
+		/* Ensure that we cleared a valid entry from the page table */
+		WARN_ON_ONCE(1);
+	}
+}
+
+static inline u64 dma_set_pte(struct dma_pte *pte, u64 pteval)
+{
+	u64 old_pteval;
+
+	/* Ensure we about to set a valid entry to the page table */
+	WARN_ON_ONCE(!DMA_PTEVAL_PRESENT(pteval));
+	old_pteval = cmpxchg64(&pte->val, 0ULL, pteval);
+	if (old_pteval == 0) {
+		struct page *pg = virt_to_page(pte);
+
+		atomic_inc(&pg->_mapcount);
+	}
+
+	return old_pteval;
 }
 
 static inline bool dma_sl_pte_test_and_clear_dirty(struct dma_pte *pte,
diff --git a/drivers/iommu/iommu-pages.h b/drivers/iommu/iommu-pages.h
index 82ebf0033081..b8b332951944 100644
--- a/drivers/iommu/iommu-pages.h
+++ b/drivers/iommu/iommu-pages.h
@@ -119,7 +119,8 @@ static inline void *iommu_alloc_pages(gfp_t gfp, int order)
 }
 
 /**
- * iommu_alloc_page_node - allocate a zeroed page at specific NUMA node.
+ * iommu_alloc_page_node - allocate a zeroed page at specific NUMA node, and set
+ *                         mapcount in its struct page to 0.
  * @nid: memory NUMA node id
  * @gfp: buddy allocator flags
  *
@@ -127,18 +128,29 @@ static inline void *iommu_alloc_pages(gfp_t gfp, int order)
  */
 static inline void *iommu_alloc_page_node(int nid, gfp_t gfp)
 {
-	return iommu_alloc_pages_node(nid, gfp, 0);
+	void *virt = iommu_alloc_pages_node(nid, gfp, 0);
+
+	if (virt)
+		atomic_set(&(virt_to_page(virt))->_mapcount, 0);
+
+	return virt;
 }
 
 /**
- * iommu_alloc_page - allocate a zeroed page
+ * iommu_alloc_page - allocate a zeroed page, and set mapcount in its struct
+ *                    page to 0.
  * @gfp: buddy allocator flags
  *
  * returns the virtual address of the allocated page
  */
 static inline void *iommu_alloc_page(gfp_t gfp)
 {
-	return iommu_alloc_pages(gfp, 0);
+	void *virt = iommu_alloc_pages(gfp, 0);
+
+	if (virt)
+		atomic_set(&(virt_to_page(virt))->_mapcount, 0);
+
+	return virt;
 }
 
 /**
@@ -155,16 +167,19 @@ static inline void iommu_free_pages(void *virt, int order)
 }
 
 /**
- * iommu_free_page - free page
+ * iommu_free_page - free page, and reset mapcount
  * @virt: virtual address of the page to be freed.
  */
 static inline void iommu_free_page(void *virt)
 {
-	iommu_free_pages(virt, 0);
+	if (virt) {
+		page_mapcount_reset(virt_to_page(virt));
+		iommu_free_pages(virt, 0);
+	}
 }
 
 /**
- * iommu_put_pages_list - free a list of pages.
+ * iommu_put_pages_list - free a list of pages, and reset mapcount.
  * @page: the head of the lru list to be freed.
  *
  * There are no locking requirement for these pages, as they are going to be
@@ -177,6 +192,7 @@ static inline void iommu_put_pages_list(struct list_head *page)
 	while (!list_empty(page)) {
 		struct page *p = list_entry(page->prev, struct page, lru);
 
+		page_mapcount_reset(p);
 		list_del(&p->lru);
 		__iommu_free_account(p, 0);
 		put_page(p);
-- 
2.44.0.769.g3c40516874-goog


