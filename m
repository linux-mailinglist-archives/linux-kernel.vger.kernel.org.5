Return-Path: <linux-kernel+bounces-159483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CE08B2F35
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3682818FD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E5D7BB0F;
	Fri, 26 Apr 2024 03:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="HcycTAuf"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C1078C71
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714103011; cv=none; b=B8eGO1dbtijPnXMJK56QNpmMMLn8S4Xsz94ci1T+OB0W7yCqQcy2j3GeGk1Rob1BBzynx74F8F93j9fDGkyB/FNeKB6vW6C5aAFZIHJZNHTfcm6VTj/wm8t+v9uCuxkjZOu3poV9pEHnS9xu8v2cy2o0vs6PC7bpvZwsz9N9OUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714103011; c=relaxed/simple;
	bh=O9Gh1/Lqh0Xkd27Kwz4THqDapXdPbT/TrEKteKU3Atg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIpK0iSN4HjiTq79Rnq5PXgcUkvLwzvaqne9x1xtwOlJEWGKKDqkti1e9In6xmO1NxEFUFMVbvlm//hHs276dm8V3sFM0ajKqVNZXU9yldMH2NCMmjJg4MN9er7KAEKKL34m0W4LStUmGc+sjqWEiazBYMVKGC3cCKmysc2xIRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=HcycTAuf; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-436ee76c3b8so13107501cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 20:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1714103008; x=1714707808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0qKgoZHcRwjMzBnVukZSI3GExhXHJMz1htG24w59mTg=;
        b=HcycTAufqC+ahmJzKQkH8oAyJPT7cl+H1XyxaPpy9lkdZ3u6/vCmHSH82G7FxhWZtL
         MbaeIGM98SOAnr1655scxiqusL5GhO7w6L+5eXba3znWFX+R/wQIurNEOW+q1uiZbtGa
         /C8XLKASFhT2hWMREl13jxyrEyBKvW6++iKQMwf5XrkzAzbnEgXGOGZ02LVRRTmFB2H6
         Qa9B70YHfRicXID+eOEWaRA7LT5Pv1i5hLvK8tB5zVK47lrfu9b5tRQoOkMukSIpzyuG
         Wdj1jzUb5CDUZqZmmAtdmJvo0GURPRWTDCCFBR2wIZnukke6jbzdXFCJ9hViqAvenBtr
         tmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714103008; x=1714707808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qKgoZHcRwjMzBnVukZSI3GExhXHJMz1htG24w59mTg=;
        b=iNLtbioYttuUifCS92qYhH9E4GJ7y129ZJLifjd9A0rmSIHP5AeOHiDAP8IYbxfw9H
         bswEJlBdSeBi3yd0F0em8N3ChJdj1mjbrgsSpzh0AnrSIqv9LXG4UDT6mXzv5FTVArnD
         EM287E1JHRK6shhIPlxJihR+Gvs6/H7OroJvoaSEQEF5erKoSzwxlXDZl62nAf4cOhWT
         wpKs8Db5dYRWbWdcsttXAdjU3VSnFEhNdD9d8aErw6pwovFxDKpaziQ4ojSUzgwCfVpr
         rfasJScEFUjZ/3GXh+sg+XNeh2Zfx7MfztV5fQMYC1l8rSwerjYoWsxbApwMdlXcJIIS
         fUYw==
X-Forwarded-Encrypted: i=1; AJvYcCVWf8SX6SlePFxixBw1kuPi8jfJupbETWYNOOO80mrtqZnx/VgYv1ReLW+0pNn1AwkB5+0iNNepFvhpM1aKCwOIx0zM1GgZ/G9pAnWa
X-Gm-Message-State: AOJu0Yz6vDl6CdWX+71I7RDILZ/vFhIm2tQnlMI02ZWV6IW4L+eLhoSB
	xKziANKyQNwaFFnPHFa6HgqIRUWPg4o/O8u9W0psDB0cjXHfTRuWQB/hRzDZl0M=
X-Google-Smtp-Source: AGHT+IHmUgwf6vDm3AhjFFV4a78DkNgnzXWpFjgQ5FiiDRbS0nCVhPfbCsQnbjR/SyVu2r2tQ6OZiw==
X-Received: by 2002:ac8:7e81:0:b0:43a:7bc9:7c2f with SMTP id w1-20020ac87e81000000b0043a7bc97c2fmr325043qtj.2.1714103008254;
        Thu, 25 Apr 2024 20:43:28 -0700 (PDT)
Received: from soleen.c.googlers.com.com (129.177.85.34.bc.googleusercontent.com. [34.85.177.129])
        by smtp.gmail.com with ESMTPSA id c6-20020ac80546000000b00436bb57faddsm7540815qth.25.2024.04.25.20.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 20:43:27 -0700 (PDT)
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
Subject: [RFC v2 3/3] iommu/intel: free empty page tables on unmaps
Date: Fri, 26 Apr 2024 03:43:23 +0000
Message-ID: <20240426034323.417219-4-pasha.tatashin@soleen.com>
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

When page tables become empty, add them to the freelist so that they
can also be freed.

This is means that a page tables that are outside of the imediat iova
range might be freed as well, therefore, only in the case where such
page tables are going to be freed, we take the writer lock.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/iommu/intel/iommu.c | 91 +++++++++++++++++++++++++++++++------
 1 file changed, 77 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 8c7e596728b5..2dedcd4f6060 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1044,7 +1044,7 @@ static void dma_pte_list_pagetables(struct dmar_domain *domain,
 static void dma_pte_clear_level(struct dmar_domain *domain, int level,
 				struct dma_pte *pte, unsigned long pfn,
 				unsigned long start_pfn, unsigned long last_pfn,
-				struct list_head *freelist)
+				struct list_head *freelist, int *freed_level)
 {
 	struct dma_pte *first_pte = NULL, *last_pte = NULL;
 
@@ -1070,11 +1070,47 @@ static void dma_pte_clear_level(struct dmar_domain *domain, int level,
 				first_pte = pte;
 			last_pte = pte;
 		} else if (level > 1) {
+			struct dma_pte *npte = phys_to_virt(dma_pte_addr(pte));
+			struct page *npage = virt_to_page(npte);
+
 			/* Recurse down into a level that isn't *entirely* obsolete */
-			dma_pte_clear_level(domain, level - 1,
-					    phys_to_virt(dma_pte_addr(pte)),
+			dma_pte_clear_level(domain, level - 1, npte,
 					    level_pfn, start_pfn, last_pfn,
-					    freelist);
+					    freelist, freed_level);
+
+			/*
+			 * Free next level page table if it became empty.
+			 *
+			 * We only holding the reader lock, and it is possible
+			 * that other threads are accessing page table as
+			 * readers as well. We can only free page table that
+			 * is outside of the request IOVA space only if
+			 * we grab the writer lock. Since we need to drop reader
+			 * lock, we are incrementing the mapcount in the npage
+			 * so it (and the current page table) does not
+			 * dissappear due to concurrent unmapping threads.
+			 *
+			 * Store the size maximum size of the freed page table
+			 * into freed_level, so the size of the IOTLB flush
+			 * can be determined.
+			 */
+			if (freed_level && !atomic_read(&npage->_mapcount)) {
+				atomic_inc(&npage->_mapcount);
+				read_unlock(&domain->pgd_lock);
+				write_lock(&domain->pgd_lock);
+				atomic_dec(&npage->_mapcount);
+				if (!atomic_read(&npage->_mapcount)) {
+					dma_clear_pte(pte);
+					if (!first_pte)
+						first_pte = pte;
+					last_pte = pte;
+					page_mapcount_reset(npage);
+					list_add_tail(&npage->lru, freelist);
+					*freed_level = level;
+				}
+				write_unlock(&domain->pgd_lock);
+				read_lock(&domain->pgd_lock);
+			}
 		}
 next:
 		pfn = level_pfn + level_size(level);
@@ -1089,7 +1125,8 @@ static void dma_pte_clear_level(struct dmar_domain *domain, int level,
    the page tables, and may have cached the intermediate levels. The
    pages can only be freed after the IOTLB flush has been done. */
 static void domain_unmap(struct dmar_domain *domain, unsigned long start_pfn,
-			 unsigned long last_pfn, struct list_head *freelist)
+			 unsigned long last_pfn, struct list_head *freelist,
+			 int *level)
 {
 	if (WARN_ON(!domain_pfn_supported(domain, last_pfn)) ||
 	    WARN_ON(start_pfn > last_pfn))
@@ -1098,7 +1135,8 @@ static void domain_unmap(struct dmar_domain *domain, unsigned long start_pfn,
 	read_lock(&domain->pgd_lock);
 	/* we don't need lock here; nobody else touches the iova range */
 	dma_pte_clear_level(domain, agaw_to_level(domain->agaw),
-			    domain->pgd, 0, start_pfn, last_pfn, freelist);
+			    domain->pgd, 0, start_pfn, last_pfn, freelist,
+			    level);
 	read_unlock(&domain->pgd_lock);
 
 	/* free pgd */
@@ -1479,11 +1517,11 @@ static void __iommu_flush_iotlb_psi(struct intel_iommu *iommu, u16 did,
 
 static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 				  struct dmar_domain *domain,
-				  unsigned long pfn, unsigned int pages,
+				  unsigned long pfn, unsigned long pages,
 				  int ih, int map)
 {
-	unsigned int aligned_pages = __roundup_pow_of_two(pages);
-	unsigned int mask = ilog2(aligned_pages);
+	unsigned long aligned_pages = __roundup_pow_of_two(pages);
+	unsigned long mask = ilog2(aligned_pages);
 	uint64_t addr = (uint64_t)pfn << VTD_PAGE_SHIFT;
 	u16 did = domain_id_iommu(domain, iommu);
 
@@ -1837,7 +1875,8 @@ static void domain_exit(struct dmar_domain *domain)
 	if (domain->pgd) {
 		LIST_HEAD(freelist);
 
-		domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw), &freelist);
+		domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw), &freelist,
+			     NULL);
 		iommu_put_pages_list(&freelist);
 	}
 
@@ -3419,7 +3458,8 @@ static int intel_iommu_memory_notifier(struct notifier_block *nb,
 			struct intel_iommu *iommu;
 			LIST_HEAD(freelist);
 
-			domain_unmap(si_domain, start_vpfn, last_vpfn, &freelist);
+			domain_unmap(si_domain, start_vpfn, last_vpfn,
+				     &freelist, NULL);
 
 			rcu_read_lock();
 			for_each_active_iommu(iommu, drhd)
@@ -4080,6 +4120,7 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 				struct iommu_iotlb_gather *gather)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	bool queued = iommu_iotlb_gather_queued(gather);
 	unsigned long start_pfn, last_pfn;
 	int level = 0;
 
@@ -4099,7 +4140,16 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 	start_pfn = iova >> VTD_PAGE_SHIFT;
 	last_pfn = (iova + size - 1) >> VTD_PAGE_SHIFT;
 
-	domain_unmap(dmar_domain, start_pfn, last_pfn, &gather->freelist);
+	/*
+	 * pass level only if !queued, which means we will do iotlb
+	 * flush callback before freeing pages from freelist.
+	 *
+	 * When level is passed domain_unamp will attempt to add empty
+	 * page tables to freelist, and pass the level number of the highest
+	 * page table that was added to the freelist.
+	 */
+	domain_unmap(dmar_domain, start_pfn, last_pfn, &gather->freelist,
+		     queued ? NULL : &level);
 
 	if (dmar_domain->max_addr == iova + size)
 		dmar_domain->max_addr = iova;
@@ -4108,8 +4158,21 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 	 * We do not use page-selective IOTLB invalidation in flush queue,
 	 * so there is no need to track page and sync iotlb.
 	 */
-	if (!iommu_iotlb_gather_queued(gather))
-		iommu_iotlb_gather_add_page(domain, gather, iova, size);
+	if (!queued) {
+		size_t sz = size;
+
+		/*
+		 * Increase iova and sz for flushing if level was returned,
+		 * as it means we also are freeing some page tables.
+		 */
+		if (level) {
+			unsigned long pgsize = level_size(level) << VTD_PAGE_SHIFT;
+
+			iova = ALIGN_DOWN(iova, pgsize);
+			sz = ALIGN(size, pgsize);
+		}
+		iommu_iotlb_gather_add_page(domain, gather, iova, sz);
+	}
 
 	return size;
 }
-- 
2.44.0.769.g3c40516874-goog


