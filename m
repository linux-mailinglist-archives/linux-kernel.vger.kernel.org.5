Return-Path: <linux-kernel+bounces-127028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB9D8945F7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19FF1C21739
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D25F54F91;
	Mon,  1 Apr 2024 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mjk1Sx6x"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D141853E12
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 20:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712003220; cv=none; b=NuJtpRvjKsJ0KVhvl93xueLjA4CPmcFww/Jv5Jr1iscBvx0pLIDT69A0YCQX77Epc3vzyBOp2hufoD3S5gMyNfn6uiZr9YSzb9mjyaf/SRk/BTNe+PqlOmUi/sr1AVusKWrB/nVLsCXYThhxhC9KNykJ3I+Irm1rtLPi5sz0SOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712003220; c=relaxed/simple;
	bh=K2uUxOa/BPDSkpao/7L01Qy9c+58bEbnJO9fU8fkXq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cc/cbgvBXjBwP+K2Hj2x8lC73YptAQyFY8iERYBVjDWWL4aLdrUsbsJcfU/OuflY0DuwYnJCzMfi1hpZqlBbtrRPZWMPuOCDB+fBvwFdFXm+REMhby0goSZlGJhAh7Rm0XzZyUiZgnwx3iWzkLi0Fak4+bY+1TumIuafKrKskNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mjk1Sx6x; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-615038fc5baso7222667b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 13:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712003218; x=1712608018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwRQK61zxAOtZTuzQkMVrkDP5lES+e4npSppnKc4AGI=;
        b=Mjk1Sx6x8CAgnv7UDMs2S+DU12YDXHVaTuumIfu3DF/NslvNiRskDCfCXglzlCNkb9
         +zpmbUIRJlVT1WC/y5nuqTNkKskUO3dAXt0hKELOqY4Z1xynXA6ZMr1dnGgbs1EswKnB
         j/Sf0t/PV4C7P12T3ZHSjv3jluYHDXSo0jq5GvgKSXwomFCuLVGza2nTIcHArujmYSTO
         oopgHCCu3JzSwmUMVDr2Ept5az+sb4AVQ55IxxsphQji8PwoWVuqKLqTYtVEfw8l6y51
         KBToE58dpxhGITHGmNOmwWaGOTkh5tAenOLnx/dd89d9tCNXDJF5AmZvMPSr3W+rebpc
         Eulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712003218; x=1712608018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwRQK61zxAOtZTuzQkMVrkDP5lES+e4npSppnKc4AGI=;
        b=ttSFxrY3aevkQKeGgrNdiZl3ZFF9gskrCQKTbPMk+EbZKHjZADaQzJMNTxn0tSukRf
         7ORK3XG92JS0kDFTJmzmf8bRpDP4JPgZiiHKieZXVCgOOLXms/iddry1+MGEHYzSOewN
         idoGULBn3NCENbnv2kCyNYMDlbZhKTrHpo1ynsZVWzGI9HsTL/4E3dzcwtsiqcp1qj+5
         Tv+5yyqHuS/ugZAqSoNgdntGGIoda9AxMVeNmMFcUlXotky56Lyj3KQMtWSLiDbvDPxu
         MvGZ3HIaUEaKQ+trMj9oRj7YGhzzMxsxAYY65RZLziwi6LvecR4ULqzoRtHDlt2igvnf
         M1nw==
X-Gm-Message-State: AOJu0Yw/q8EYzsghZQyWk6PDowBmB/e1dNKZ/NrQFP/ATz0Lw1in61l4
	tyKY3zt25uLFbnj/5nIV9PHteSRiPtEmw2jIXUqk6x1dKIYPoKyJ
X-Google-Smtp-Source: AGHT+IFisZq4EuxDLU4uS1EpjFvcKMqEqYfO+yamypsLgW77pMy3m4jr7Iv/oNYRYg9OIrA5cUAWAg==
X-Received: by 2002:a0d:e7c6:0:b0:611:30a2:1758 with SMTP id q189-20020a0de7c6000000b0061130a21758mr9909937ywe.37.1712003217812;
        Mon, 01 Apr 2024 13:26:57 -0700 (PDT)
Received: from fedora.attlocal.net ([2600:1700:2f7d:1800::23])
        by smtp.googlemail.com with ESMTPSA id y72-20020a81a14b000000b006142210a31esm1171181ywg.23.2024.04.01.13.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 13:26:57 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	muchun.song@linux.dev,
	willy@infradead.org,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 2/3] hugetlb: Convert hugetlb_no_page() to use struct vm_fault
Date: Mon,  1 Apr 2024 13:26:50 -0700
Message-ID: <20240401202651.31440-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240401202651.31440-1-vishal.moola@gmail.com>
References: <20240401202651.31440-1-vishal.moola@gmail.com>
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
index 360b82374a89..aca2f11b4138 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6189,9 +6189,7 @@ static bool hugetlb_pte_stable(struct hstate *h, struct mm_struct *mm,
 
 static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			struct vm_area_struct *vma,
-			struct address_space *mapping, pgoff_t idx,
-			unsigned long address, pte_t *ptep,
-			pte_t old_pte, unsigned int flags,
+			struct address_space *mapping,
 			struct vm_fault *vmf)
 {
 	struct hstate *h = hstate_vma(vma);
@@ -6200,10 +6198,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
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
@@ -6222,10 +6218,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
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
@@ -6246,7 +6242,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			 * never happen on the page after UFFDIO_COPY has
 			 * correctly installed the page and returned.
 			 */
-			if (!hugetlb_pte_stable(h, mm, ptep, old_pte)) {
+			if (!hugetlb_pte_stable(h, mm, vmf->pte, vmf->orig_pte)) {
 				ret = 0;
 				goto out;
 			}
@@ -6255,7 +6251,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 							VM_UFFD_MISSING);
 		}
 
-		folio = alloc_hugetlb_folio(vma, haddr, 0);
+		folio = alloc_hugetlb_folio(vma, vmf->address, 0);
 		if (IS_ERR(folio)) {
 			/*
 			 * Returning error will result in faulting task being
@@ -6269,18 +6265,20 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
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
@@ -6289,7 +6287,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 				 * to the page cache. So it's safe to call
 				 * restore_reserve_on_error() here.
 				 */
-				restore_reserve_on_error(h, vma, haddr, folio);
+				restore_reserve_on_error(h, vma, vmf->address,
+							folio);
 				folio_put(folio);
 				goto out;
 			}
@@ -6319,7 +6318,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			folio_unlock(folio);
 			folio_put(folio);
 			/* See comment in userfaultfd_missing() block above */
-			if (!hugetlb_pte_stable(h, mm, ptep, old_pte)) {
+			if (!hugetlb_pte_stable(h, mm, vmf->pte, vmf->orig_pte)) {
 				ret = 0;
 				goto out;
 			}
@@ -6334,23 +6333,23 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
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
@@ -6359,17 +6358,18 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
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
@@ -6386,10 +6386,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
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
@@ -6485,8 +6485,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
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


