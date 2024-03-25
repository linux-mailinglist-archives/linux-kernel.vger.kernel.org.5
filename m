Return-Path: <linux-kernel+bounces-118124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BC088B69A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BCF4B23595
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F97784D22;
	Mon, 25 Mar 2024 22:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLdYuMmy"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052107F48F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711406026; cv=none; b=X5doCUPFxhAr36zG94WILr5NgTOHOWFBnICtSIr6M1ZEQFlJ2uQ24t8QjULFxCAsFNDrOqNNLEK1u0LlVksnijE+obagaFVLhZ7x+e24AxBJBJX1MNhtcU03z+vucRkWLn1neBtm5sYNUNwdHgjj9+W8sgWdfAWBgOcH4yImT+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711406026; c=relaxed/simple;
	bh=V+cGmqZ84ky38wT7ptHjAMrWPr+0QyKC4IpVVER8XpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cAbU+78s6OOXtNhMScinoE75aiT0l+7e8Xt46ST6/QI0JjTMeGOLXsj/eIdCB1wq7vdhIE6REqtkKyNto/rEUng+mil+Q/fmMfVvOPdEjNOcN2srPubMsJ5UC0HkHgu4iABgc3mMP7og3Ffy+x8kD6u38hT/CcWfrdlx7tINODI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLdYuMmy; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29f749b6667so3579290a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711406024; x=1712010824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sP/HrRtOaF5YRIfX9u0RpV4cBbAlDIrGYsjsP3+O3X8=;
        b=kLdYuMmyJxwm1RO9iE1ZEmc0jvoP7PDRFNsWSlcA5E91axCFPcEDZ0YM2twQgPW+tT
         SBWTTlODtG1sWcQiKb7i+5By2r+xfdrKevRRyBuAFqdwV+/ikmheL9UxwwsnbtJ4Wuv/
         6YCoC6V7snkjKTZ+8tHzT+sECYNnR4R9sSkU2FCxeLfO5LLhRiEjHEzprn0egdNvIM1S
         Pue+McX1Pkmao4dhLEeo18Xr9+MZraSg0aqPakc3PcMtMIjDbimZZ7ThDLWiXhebkhGb
         /hAoq2wf3MjtMET4cq+BM+nJm12gUjZaamojamf1FZBqc2SSQa/p7LBtgtLcLakemU//
         7HzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711406024; x=1712010824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sP/HrRtOaF5YRIfX9u0RpV4cBbAlDIrGYsjsP3+O3X8=;
        b=NGqUqg8vN8fc02thXEZdBKS/8v3Sb7rzuB+wbxWntGElhqNoGyXkyIqqE+GH8GwiFm
         dJaa88XSYx9ghqjNaVu4bIHk/s6NFeNlbFackvgnbsnPuXBD4O/VafZtRHggW9UKDYzJ
         o6n1tkoS360S7N5FC9rb+6OMQ+pgIQwGYJD12vCXfL8uCVGoRNoF6CkjNnEQPBETURp4
         0XdI9bP+fz2hZ9a1fL1iGKuHTlrmiZBg/VYnl54y3fG5qD3nIa7kXyqG6G6pYr8CcmKz
         yPfUpfHE9oM0NVlIOLmrryg4TFOEyNn/Q2w6dOZ23v2rbuLCff4BWguPqBUlW4lmKd/D
         rSmA==
X-Gm-Message-State: AOJu0Yz8OQvQRcpDLA7gqe3xDWcDfs2NwaynPGA39GmHCoBb0klREuSu
	+OL+LQUs4rSGXCJ6Mn2Cpq5MbrXB73CLsEIg6txbUBcAyBvPEl+0
X-Google-Smtp-Source: AGHT+IGyWxFaoFa1+IvC2ORjow3Na1wp3zhzntyvupejForDNfjnFm53ZyuyQXm9jJ+7DPPZog8puQ==
X-Received: by 2002:a17:90a:2f26:b0:29c:7769:419b with SMTP id s35-20020a17090a2f2600b0029c7769419bmr8194248pjd.9.1711406024293;
        Mon, 25 Mar 2024 15:33:44 -0700 (PDT)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id sx16-20020a17090b2cd000b002a053cdd4e5sm4356173pjb.9.2024.03.25.15.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 15:33:43 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	muchun.song@linux.dev,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 2/5] hugetlb: Convert hugetlb_no_page() to use struct vm_fault
Date: Mon, 25 Mar 2024 15:33:36 -0700
Message-ID: <20240325223339.169350-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325223339.169350-1-vishal.moola@gmail.com>
References: <20240325223339.169350-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hugetlb_no_page() can use the struct vm_fault passed in from
hugetlb_fault(). This alleviates the stack by consolidating 7
variables into a single struct.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/hugetlb.c | 59 ++++++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 81e8ade53b64..819a6d067985 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6096,9 +6096,7 @@ static bool hugetlb_pte_stable(struct hstate *h, struct mm_struct *mm,
 
 static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			struct vm_area_struct *vma,
-			struct address_space *mapping, pgoff_t idx,
-			unsigned long address, pte_t *ptep,
-			pte_t old_pte, unsigned int flags,
+			struct address_space *mapping,
 			struct vm_fault *vmf)
 {
 	struct hstate *h = hstate_vma(vma);
@@ -6107,10 +6105,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	unsigned long size;
 	struct folio *folio;
 	pte_t new_pte;
-	spinlock_t *ptl;
-	unsigned long haddr = address & huge_page_mask(h);
 	bool new_folio, new_pagecache_folio = false;
-	u32 hash = hugetlb_fault_mutex_hash(mapping, idx);
+	u32 hash = hugetlb_fault_mutex_hash(mapping, vmf->pgoff);
 
 	/*
 	 * Currently, we are forced to kill the process in the event the
@@ -6129,10 +6125,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	 * before we get page_table_lock.
 	 */
 	new_folio = false;
-	folio = filemap_lock_hugetlb_folio(h, mapping, idx);
+	folio = filemap_lock_hugetlb_folio(h, mapping, vmf->pgoff);
 	if (IS_ERR(folio)) {
 		size = i_size_read(mapping->host) >> huge_page_shift(h);
-		if (idx >= size)
+		if (vmf->pgoff >= size)
 			goto out;
 		/* Check for page in userfault range */
 		if (userfaultfd_missing(vma)) {
@@ -6153,7 +6149,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			 * never happen on the page after UFFDIO_COPY has
 			 * correctly installed the page and returned.
 			 */
-			if (!hugetlb_pte_stable(h, mm, ptep, old_pte)) {
+			if (!hugetlb_pte_stable(h, mm, vmf->pte, vmf->orig_pte)) {
 				ret = 0;
 				goto out;
 			}
@@ -6162,7 +6158,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 							VM_UFFD_MISSING);
 		}
 
-		folio = alloc_hugetlb_folio(vma, haddr, 0);
+		folio = alloc_hugetlb_folio(vma, vmf->address, 0);
 		if (IS_ERR(folio)) {
 			/*
 			 * Returning error will result in faulting task being
@@ -6176,18 +6172,20 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			 * here.  Before returning error, get ptl and make
 			 * sure there really is no pte entry.
 			 */
-			if (hugetlb_pte_stable(h, mm, ptep, old_pte))
+			if (hugetlb_pte_stable(h, mm, vmf->pte, vmf->orig_pte))
 				ret = vmf_error(PTR_ERR(folio));
 			else
 				ret = 0;
 			goto out;
 		}
-		clear_huge_page(&folio->page, address, pages_per_huge_page(h));
+		clear_huge_page(&folio->page, vmf->real_address,
+				pages_per_huge_page(h));
 		__folio_mark_uptodate(folio);
 		new_folio = true;
 
 		if (vma->vm_flags & VM_MAYSHARE) {
-			int err = hugetlb_add_to_page_cache(folio, mapping, idx);
+			int err = hugetlb_add_to_page_cache(folio, mapping,
+							vmf->pgoff);
 			if (err) {
 				/*
 				 * err can't be -EEXIST which implies someone
@@ -6196,7 +6194,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 				 * to the page cache. So it's safe to call
 				 * restore_reserve_on_error() here.
 				 */
-				restore_reserve_on_error(h, vma, haddr, folio);
+				restore_reserve_on_error(h, vma, vmf->address,
+							folio);
 				folio_put(folio);
 				goto out;
 			}
@@ -6226,7 +6225,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			folio_unlock(folio);
 			folio_put(folio);
 			/* See comment in userfaultfd_missing() block above */
-			if (!hugetlb_pte_stable(h, mm, ptep, old_pte)) {
+			if (!hugetlb_pte_stable(h, mm, vmf->pte, vmf->orig_pte)) {
 				ret = 0;
 				goto out;
 			}
@@ -6241,23 +6240,23 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	 * any allocations necessary to record that reservation occur outside
 	 * the spinlock.
 	 */
-	if ((flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
-		if (vma_needs_reservation(h, vma, haddr) < 0) {
+	if ((vmf->flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
+		if (vma_needs_reservation(h, vma, vmf->address) < 0) {
 			ret = VM_FAULT_OOM;
 			goto backout_unlocked;
 		}
 		/* Just decrements count, does not deallocate */
-		vma_end_reservation(h, vma, haddr);
+		vma_end_reservation(h, vma, vmf->address);
 	}
 
-	ptl = huge_pte_lock(h, mm, ptep);
+	vmf->ptl = huge_pte_lock(h, mm, vmf->pte);
 	ret = 0;
 	/* If pte changed from under us, retry */
-	if (!pte_same(huge_ptep_get(ptep), old_pte))
+	if (!pte_same(huge_ptep_get(vmf->pte), vmf->orig_pte))
 		goto backout;
 
 	if (anon_rmap)
-		hugetlb_add_new_anon_rmap(folio, vma, haddr);
+		hugetlb_add_new_anon_rmap(folio, vma, vmf->address);
 	else
 		hugetlb_add_file_rmap(folio);
 	new_pte = make_huge_pte(vma, &folio->page, ((vma->vm_flags & VM_WRITE)
@@ -6266,17 +6265,18 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	 * If this pte was previously wr-protected, keep it wr-protected even
 	 * if populated.
 	 */
-	if (unlikely(pte_marker_uffd_wp(old_pte)))
+	if (unlikely(pte_marker_uffd_wp(vmf->orig_pte)))
 		new_pte = huge_pte_mkuffd_wp(new_pte);
-	set_huge_pte_at(mm, haddr, ptep, new_pte, huge_page_size(h));
+	set_huge_pte_at(mm, vmf->address, vmf->pte, new_pte, huge_page_size(h));
 
 	hugetlb_count_add(pages_per_huge_page(h), mm);
-	if ((flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
+	if ((vmf->flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
 		/* Optimization, do the COW without a second fault */
-		ret = hugetlb_wp(mm, vma, address, ptep, flags, folio, ptl, vmf);
+		ret = hugetlb_wp(mm, vma, vmf->real_address, vmf->pte,
+				vmf->flags, folio, vmf->ptl, vmf);
 	}
 
-	spin_unlock(ptl);
+	spin_unlock(vmf->ptl);
 
 	/*
 	 * Only set hugetlb_migratable in newly allocated pages.  Existing pages
@@ -6293,10 +6293,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	return ret;
 
 backout:
-	spin_unlock(ptl);
+	spin_unlock(vmf->ptl);
 backout_unlocked:
 	if (new_folio && !new_pagecache_folio)
-		restore_reserve_on_error(h, vma, haddr, folio);
+		restore_reserve_on_error(h, vma, vmf->address, folio);
 
 	folio_unlock(folio);
 	folio_put(folio);
@@ -6392,8 +6392,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * hugetlb_no_page will drop vma lock and hugetlb fault
 		 * mutex internally, which make us return immediately.
 		 */
-		return hugetlb_no_page(mm, vma, mapping, vmf.pgoff, address,
-					vmf.pte, vmf.orig_pte, flags, &vmf);
+		return hugetlb_no_page(mm, vma, mapping, &vmf);
 	}
 
 	ret = 0;
-- 
2.43.0


