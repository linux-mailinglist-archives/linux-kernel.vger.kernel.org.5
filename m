Return-Path: <linux-kernel+bounces-159482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BED1C8B2F34
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757EC2830F8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED68D78C97;
	Fri, 26 Apr 2024 03:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="D0E/MEca"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988F178C66
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714103010; cv=none; b=FU7rdTlN1L/L+VaQW+Bh0tVXp/YZazKbu0za1o6m25fhiunBdRQd7Zdq7d1PnXdAAZrkPnE1mmuizEra0acENYqiysBORcvfhSfgjzkQpQ09rvxnm2opun2CBZlTYjqdofgLlu3bL84ffIgU3s9Az91SVJj7XsIuy/0xOmzn9pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714103010; c=relaxed/simple;
	bh=3z+GXuQGkWoDNcuvF/alZVLngGHITQXAlp4EnS0+nzc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NxR8IVvDlU7RQGvr/ZD03h6is19dGwiMDNvkEBFLbh6PVzzRJvWuDpuBru/ej1+M62Rba5b2k9FXFEKp89Lecyxo1pLS6CgEpzubbHYZH3kOHFNsWsxftFlAxnoiLiwEg/uD8CLcAMZfT8x9aIgGDooSpqIbY878ieDyRUkcwCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=D0E/MEca; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4365c1451d4so11449801cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 20:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1714103007; x=1714707807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GURCfQOZVuUrKhF3OYuy9zEmklzBEXgHfus1Ew76lR0=;
        b=D0E/MEcaVUca9EgN+Gu4xAHiryQIW2fSYwh/A62FAD8M5FXI1BM1qAid+vJrIqFHHK
         CBI+rUIxP8wCkecZcgQTUE2OGJRvubB584ssMV3k21Mz66vuc0wp/NohWvnwzYrYG7G7
         jK9ojxZM2cGg7eu5Xr1Q2GUDcbWeG6DymM2m83XBfbjPunt7LYOU463wWHenzjQwk72a
         jRU8CAI+OJIzGgFqJ9uCJGpf7cwzgg8Y00JqsUMad7KMfpR/yAGQtMCkJjjVCDG7RE57
         ed5g4qvvBl+t5tJkTbR61fGpl530bf50sQ+DtYgImfJXhtv56tIEdh+wSHcNz/0dfOWg
         wO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714103007; x=1714707807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GURCfQOZVuUrKhF3OYuy9zEmklzBEXgHfus1Ew76lR0=;
        b=a53KuBMqVdq8/NPfglVlrV+cbeS7ZQJ2YayMSlaNM5Vx71cdmpsfmOZljX7bgsKFjm
         gQNNgpm4tNq3g4pV3nIpJW63fgI5xamo9W+8Bsh1X7yWDY339/Ki7du1MGsejBLVD9Mn
         75j6SaowOSkN0+kM26ePxfTp/u4Hvwut748Rdi/krdfG4JcgWNumQY8X4sXYoMmI9cCC
         HOfeEE47GfmpnklSBgC2934ozpFlMdNS3qRTPaGT4XDKb61od0jzxqQMiQKGH3RerkJ0
         4G4aZHVpKYo+tsjssHtpoljxafuANVdTe1Ko9JW+vC/ONLujJLONbDyUEpuEo/MlHPfQ
         HtuA==
X-Forwarded-Encrypted: i=1; AJvYcCU0zcepMT1BB3bjzM/YzoZH2oGKyX9/3mywoIpB61M7QUqMKFd0q7On/1KPOOkiQ3U47Vd6Ps1tP61PoC0pMu7B0FA2p2TsGwa+xB41
X-Gm-Message-State: AOJu0YylFfhK4oT1KsDksHIi7cyq71rbJDPk50x+TeN7ZnKDpDS7whBy
	Fm/IPKDxatCXHi2FkohRTU8Olp+14ACG8C74O+FYNCoKnQoZUHkSiHusuR0fMoI=
X-Google-Smtp-Source: AGHT+IHx2jRF9sHZe0ji37o0f9d/WxOmNqlXZKb8rptZFsjIiM8LnbaBigJJCVNFjwy+WUFUifGdEw==
X-Received: by 2002:ac8:7f0e:0:b0:437:a1a2:f832 with SMTP id f14-20020ac87f0e000000b00437a1a2f832mr2149126qtk.11.1714103007410;
        Thu, 25 Apr 2024 20:43:27 -0700 (PDT)
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
Subject: [RFC v2 2/3] iommu/intel: synchronize page table map and unmap operations
Date: Fri, 26 Apr 2024 03:43:22 +0000
Message-ID: <20240426034323.417219-3-pasha.tatashin@soleen.com>
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

Since, we are going to update  parent page table entries when lower
level page tables become emtpy and we add them to the free list.
We need a way to synchronize the operation.

Use domain->pgd_lock to protect all map and unmap operations.
This is reader/writer lock. At the beginning everything is going to be
read only mode, however, later, when free page table on unmap is added
we will add a writer section as well.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/iommu/intel/iommu.c | 21 +++++++++++++++++++--
 drivers/iommu/intel/iommu.h |  3 +++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 1bfb6eccad05..8c7e596728b5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -995,11 +995,13 @@ static void dma_pte_free_pagetable(struct dmar_domain *domain,
 				   unsigned long last_pfn,
 				   int retain_level)
 {
+	read_lock(&domain->pgd_lock);
 	dma_pte_clear_range(domain, start_pfn, last_pfn);
 
 	/* We don't need lock here; nobody else touches the iova range */
 	dma_pte_free_level(domain, agaw_to_level(domain->agaw), retain_level,
 			   domain->pgd, 0, start_pfn, last_pfn);
+	read_unlock(&domain->pgd_lock);
 
 	/* free pgd */
 	if (start_pfn == 0 && last_pfn == DOMAIN_MAX_PFN(domain->gaw)) {
@@ -1093,9 +1095,11 @@ static void domain_unmap(struct dmar_domain *domain, unsigned long start_pfn,
 	    WARN_ON(start_pfn > last_pfn))
 		return;
 
+	read_lock(&domain->pgd_lock);
 	/* we don't need lock here; nobody else touches the iova range */
 	dma_pte_clear_level(domain, agaw_to_level(domain->agaw),
 			    domain->pgd, 0, start_pfn, last_pfn, freelist);
+	read_unlock(&domain->pgd_lock);
 
 	/* free pgd */
 	if (start_pfn == 0 && last_pfn == DOMAIN_MAX_PFN(domain->gaw)) {
@@ -2088,6 +2092,7 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 
 	pteval = ((phys_addr_t)phys_pfn << VTD_PAGE_SHIFT) | attr;
 
+	read_lock(&domain->pgd_lock);
 	while (nr_pages > 0) {
 		uint64_t tmp;
 
@@ -2097,8 +2102,10 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 
 			pte = pfn_to_dma_pte(domain, iov_pfn, &largepage_lvl,
 					     gfp);
-			if (!pte)
+			if (!pte) {
+				read_unlock(&domain->pgd_lock);
 				return -ENOMEM;
+			}
 			first_pte = pte;
 
 			lvl_pages = lvl_to_nr_pages(largepage_lvl);
@@ -2158,6 +2165,7 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 			pte = NULL;
 		}
 	}
+	read_unlock(&domain->pgd_lock);
 
 	return 0;
 }
@@ -3829,6 +3837,7 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width)
 	domain->pgd = iommu_alloc_page_node(domain->nid, GFP_ATOMIC);
 	if (!domain->pgd)
 		return -ENOMEM;
+	rwlock_init(&domain->pgd_lock);
 	domain_flush_cache(domain, domain->pgd, PAGE_SIZE);
 	return 0;
 }
@@ -4074,11 +4083,15 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 	unsigned long start_pfn, last_pfn;
 	int level = 0;
 
+	read_lock(&dmar_domain->pgd_lock);
 	/* Cope with horrid API which requires us to unmap more than the
 	   size argument if it happens to be a large-page mapping. */
 	if (unlikely(!pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT,
-				     &level, GFP_ATOMIC)))
+				     &level, GFP_ATOMIC))) {
+		read_unlock(&dmar_domain->pgd_lock);
 		return 0;
+	}
+	read_unlock(&dmar_domain->pgd_lock);
 
 	if (size < VTD_PAGE_SIZE << level_to_offset_bits(level))
 		size = VTD_PAGE_SIZE << level_to_offset_bits(level);
@@ -4145,8 +4158,10 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 	int level = 0;
 	u64 phys = 0;
 
+	read_lock(&dmar_domain->pgd_lock);
 	pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level,
 			     GFP_ATOMIC);
+	read_unlock(&dmar_domain->pgd_lock);
 	if (pte && dma_pte_present(pte))
 		phys = dma_pte_addr(pte) +
 			(iova & (BIT_MASK(level_to_offset_bits(level) +
@@ -4801,8 +4816,10 @@ static int intel_iommu_read_and_clear_dirty(struct iommu_domain *domain,
 		struct dma_pte *pte;
 		int lvl = 0;
 
+		read_lock(&dmar_domain->pgd_lock);
 		pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &lvl,
 				     GFP_ATOMIC);
+		read_unlock(&dmar_domain->pgd_lock);
 		pgsize = level_size(lvl) << VTD_PAGE_SHIFT;
 		if (!pte || !dma_pte_present(pte)) {
 			iova += pgsize;
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index e5c1eb23897f..2f38b087ea4f 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -615,6 +615,9 @@ struct dmar_domain {
 		struct {
 			/* virtual address */
 			struct dma_pte	*pgd;
+
+			/* Synchronizes pgd map/unmap operations */
+			rwlock_t	pgd_lock;
 			/* max guest address width */
 			int		gaw;
 			/*
-- 
2.44.0.769.g3c40516874-goog


