Return-Path: <linux-kernel+bounces-127029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A840D8945F8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DA351F20407
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CCA54FB7;
	Mon,  1 Apr 2024 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngFewra4"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1469253E15
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 20:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712003220; cv=none; b=LchHzKC6sRZvjckeereZR4LdU3QF0maG1IEAMK3NwF24TGdo6hPLh1VEqf/qiE6jVJCqeIesAYAXgd7G01dqjRXiQSfhKlNzr4mebegGFCrkc4Uz4D38WcNonEHiygnesI7qNFpAMxT80f2bUXyQ6jLVs1Ez7R8f3qAYOeHYxSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712003220; c=relaxed/simple;
	bh=sxYiMD+4k7jbC4+b4JZLo6dCWt7Ghka833gmn7CoIOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ryRx5zhCkxkdOVQNDNhc+wbV6s2okt+Nj1lv99EOJVtTkXUY22eoBlZ6N5R8lqrkXh72IoIoMbksIlkWzgWQYCZcSFWfyTrTYepWUEnjgatMT9pTmvI+SPWWTjOw0kT0yF+EVCeWaPMA88VeHqL3BfxTxLtsG0984Z6XxqpJ6hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngFewra4; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6150c1fa3daso6467687b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 13:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712003218; x=1712608018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLJjpIJjwOYqxNhCjRA5yTdkpLaMKAJot06YpeH+/j4=;
        b=ngFewra48yoC0n8rQMSo27sjM153zy/yXcB1UaZ/lszAbjUvRosQURH895Ly9MsPhu
         nNgRROjn201W4XgD+i0dsgaCOSc7EojG8uG9QHlbkIzPfA+2i8oNlSQTA10RAbH45rM2
         gXyALopPQ/uXbJjKntWU1aZDaUb4F2uCKG/wcZpIrflUjPhA9B3E/rC7mNsNQqWUeY4z
         gpDcSEkm9EOD8L2f3Q97ZU6XKNEFSnheeuZ/e6RGNWo2fmpKHHjcsDdmDlO01KapW4UH
         nUkFvEVuymRqA0ctYxjkIuMsyBAOV0AOfjg7pIds4po7CyMHNKjzMtaeEaAsPoCSWSD1
         TwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712003218; x=1712608018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OLJjpIJjwOYqxNhCjRA5yTdkpLaMKAJot06YpeH+/j4=;
        b=n0RrMubmmYMx03IzIpiBUg4xNnhl12UK9tz9GoDsVt6KkZQM/POv4sgdhfn4W4r833
         hW4oQU68avQBnjAmeJVjm/+IhDFi6ZBzLTjbKED0i2hB0qwL1jDe0STy+sTymFs6Uz2C
         TDPmFq1uGh5Mit4H0Zij5WxxQU+Fd9GKTZxDuFRhFIFDwNhwtjYjcgJuG6HPJ+c35839
         5wOsszdpPtbl+rFcl5zllXEA6BWptLhqFPCjwFIN7tl9B9QZTK19mbXO3FfItT1F+ibK
         dPDsDsFbrAN57hhigfqN+58tdpjcS/IqPURFNjhFp9DxfK4k7obOmB3knOm5vtHDjR1z
         FwzQ==
X-Gm-Message-State: AOJu0YwiGCYF4E6kpm3JVHSw58ZkJZ2KTUOOn2KFHaGHmb0T546SJ4Uj
	qlVJDj/L16WKg7nnUJI27XW7RABgb6/jJqBOiRblR4P6dV4BISZT
X-Google-Smtp-Source: AGHT+IFFZ8j7M33dVd9jUeXLmj/uGlOxSzCXNksanWE/EfYlyKZd130C69mAXSmbpVhDWvYUfcCEdg==
X-Received: by 2002:a0d:e211:0:b0:60a:243:547c with SMTP id l17-20020a0de211000000b0060a0243547cmr9827366ywe.44.1712003216926;
        Mon, 01 Apr 2024 13:26:56 -0700 (PDT)
Received: from fedora.attlocal.net ([2600:1700:2f7d:1800::23])
        by smtp.googlemail.com with ESMTPSA id y72-20020a81a14b000000b006142210a31esm1171181ywg.23.2024.04.01.13.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 13:26:56 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	muchun.song@linux.dev,
	willy@infradead.org,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 1/3] hugetlb: Convert hugetlb_fault() to use struct vm_fault
Date: Mon,  1 Apr 2024 13:26:49 -0700
Message-ID: <20240401202651.31440-2-vishal.moola@gmail.com>
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

Now that hugetlb_fault() has a vm_fault available for fault tracking, use
it throughout. This cleans up the code by removing 2 variables, and
prepares hugetlb_fault() to take in a struct vm_fault argument.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/hugetlb.c | 84 +++++++++++++++++++++++++---------------------------
 1 file changed, 41 insertions(+), 43 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8267e221ca5d..360b82374a89 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6423,8 +6423,6 @@ u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx)
 vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, unsigned int flags)
 {
-	pte_t *ptep, entry;
-	spinlock_t *ptl;
 	vm_fault_t ret;
 	u32 hash;
 	struct folio *folio = NULL;
@@ -6432,13 +6430,13 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	struct hstate *h = hstate_vma(vma);
 	struct address_space *mapping;
 	int need_wait_lock = 0;
-	unsigned long haddr = address & huge_page_mask(h);
 	struct vm_fault vmf = {
 		.vma = vma,
-		.address = haddr,
+		.address = address & huge_page_mask(h),
 		.real_address = address,
 		.flags = flags,
-		.pgoff = vma_hugecache_offset(h, vma, haddr),
+		.pgoff = vma_hugecache_offset(h, vma,
+				address & huge_page_mask(h)),
 		/* TODO: Track hugetlb faults using vm_fault */
 
 		/*
@@ -6458,22 +6456,22 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	/*
 	 * Acquire vma lock before calling huge_pte_alloc and hold
-	 * until finished with ptep.  This prevents huge_pmd_unshare from
-	 * being called elsewhere and making the ptep no longer valid.
+	 * until finished with vmf.pte.  This prevents huge_pmd_unshare from
+	 * being called elsewhere and making the vmf.pte no longer valid.
 	 */
 	hugetlb_vma_lock_read(vma);
-	ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
-	if (!ptep) {
+	vmf.pte = huge_pte_alloc(mm, vma, vmf.address, huge_page_size(h));
+	if (!vmf.pte) {
 		hugetlb_vma_unlock_read(vma);
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		return VM_FAULT_OOM;
 	}
 
-	entry = huge_ptep_get(ptep);
-	if (huge_pte_none_mostly(entry)) {
-		if (is_pte_marker(entry)) {
+	vmf.orig_pte = huge_ptep_get(vmf.pte);
+	if (huge_pte_none_mostly(vmf.orig_pte)) {
+		if (is_pte_marker(vmf.orig_pte)) {
 			pte_marker marker =
-				pte_marker_get(pte_to_swp_entry(entry));
+				pte_marker_get(pte_to_swp_entry(vmf.orig_pte));
 
 			if (marker & PTE_MARKER_POISONED) {
 				ret = VM_FAULT_HWPOISON_LARGE;
@@ -6488,20 +6486,20 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * mutex internally, which make us return immediately.
 		 */
 		return hugetlb_no_page(mm, vma, mapping, vmf.pgoff, address,
-					ptep, entry, flags, &vmf);
+					vmf.pte, vmf.orig_pte, flags, &vmf);
 	}
 
 	ret = 0;
 
 	/*
-	 * entry could be a migration/hwpoison entry at this point, so this
-	 * check prevents the kernel from going below assuming that we have
-	 * an active hugepage in pagecache. This goto expects the 2nd page
-	 * fault, and is_hugetlb_entry_(migration|hwpoisoned) check will
-	 * properly handle it.
+	 * vmf.orig_pte could be a migration/hwpoison vmf.orig_pte at this
+	 * point, so this check prevents the kernel from going below assuming
+	 * that we have an active hugepage in pagecache. This goto expects
+	 * the 2nd page fault, and is_hugetlb_entry_(migration|hwpoisoned)
+	 * check will properly handle it.
 	 */
-	if (!pte_present(entry)) {
-		if (unlikely(is_hugetlb_entry_migration(entry))) {
+	if (!pte_present(vmf.orig_pte)) {
+		if (unlikely(is_hugetlb_entry_migration(vmf.orig_pte))) {
 			/*
 			 * Release the hugetlb fault lock now, but retain
 			 * the vma lock, because it is needed to guard the
@@ -6510,9 +6508,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			 * be released there.
 			 */
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			migration_entry_wait_huge(vma, ptep);
+			migration_entry_wait_huge(vma, vmf.pte);
 			return 0;
-		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
+		} else if (unlikely(is_hugetlb_entry_hwpoisoned(vmf.orig_pte)))
 			ret = VM_FAULT_HWPOISON_LARGE |
 			    VM_FAULT_SET_HINDEX(hstate_index(h));
 		goto out_mutex;
@@ -6526,13 +6524,13 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * determine if a reservation has been consumed.
 	 */
 	if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
-	    !(vma->vm_flags & VM_MAYSHARE) && !huge_pte_write(entry)) {
-		if (vma_needs_reservation(h, vma, haddr) < 0) {
+	    !(vma->vm_flags & VM_MAYSHARE) && !huge_pte_write(vmf.orig_pte)) {
+		if (vma_needs_reservation(h, vma, vmf.address) < 0) {
 			ret = VM_FAULT_OOM;
 			goto out_mutex;
 		}
 		/* Just decrements count, does not deallocate */
-		vma_end_reservation(h, vma, haddr);
+		vma_end_reservation(h, vma, vmf.address);
 
 		pagecache_folio = filemap_lock_hugetlb_folio(h, mapping,
 							     vmf.pgoff);
@@ -6540,17 +6538,17 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			pagecache_folio = NULL;
 	}
 
-	ptl = huge_pte_lock(h, mm, ptep);
+	vmf.ptl = huge_pte_lock(h, mm, vmf.pte);
 
 	/* Check for a racing update before calling hugetlb_wp() */
-	if (unlikely(!pte_same(entry, huge_ptep_get(ptep))))
+	if (unlikely(!pte_same(vmf.orig_pte, huge_ptep_get(vmf.pte))))
 		goto out_ptl;
 
 	/* Handle userfault-wp first, before trying to lock more pages */
-	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(huge_ptep_get(ptep)) &&
-	    (flags & FAULT_FLAG_WRITE) && !huge_pte_write(entry)) {
+	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(huge_ptep_get(vmf.pte)) &&
+	    (flags & FAULT_FLAG_WRITE) && !huge_pte_write(vmf.orig_pte)) {
 		if (!userfaultfd_wp_async(vma)) {
-			spin_unlock(ptl);
+			spin_unlock(vmf.ptl);
 			if (pagecache_folio) {
 				folio_unlock(pagecache_folio);
 				folio_put(pagecache_folio);
@@ -6560,18 +6558,18 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			return handle_userfault(&vmf, VM_UFFD_WP);
 		}
 
-		entry = huge_pte_clear_uffd_wp(entry);
-		set_huge_pte_at(mm, haddr, ptep, entry,
+		vmf.orig_pte = huge_pte_clear_uffd_wp(vmf.orig_pte);
+		set_huge_pte_at(mm, vmf.address, vmf.pte, vmf.orig_pte,
 				huge_page_size(hstate_vma(vma)));
 		/* Fallthrough to CoW */
 	}
 
 	/*
-	 * hugetlb_wp() requires page locks of pte_page(entry) and
+	 * hugetlb_wp() requires page locks of pte_page(vmf.orig_pte) and
 	 * pagecache_folio, so here we need take the former one
 	 * when folio != pagecache_folio or !pagecache_folio.
 	 */
-	folio = page_folio(pte_page(entry));
+	folio = page_folio(pte_page(vmf.orig_pte));
 	if (folio != pagecache_folio)
 		if (!folio_trylock(folio)) {
 			need_wait_lock = 1;
@@ -6581,24 +6579,24 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	folio_get(folio);
 
 	if (flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
-		if (!huge_pte_write(entry)) {
-			ret = hugetlb_wp(mm, vma, address, ptep, flags,
-					 pagecache_folio, ptl, &vmf);
+		if (!huge_pte_write(vmf.orig_pte)) {
+			ret = hugetlb_wp(mm, vma, address, vmf.pte, flags,
+					 pagecache_folio, vmf.ptl, &vmf);
 			goto out_put_page;
 		} else if (likely(flags & FAULT_FLAG_WRITE)) {
-			entry = huge_pte_mkdirty(entry);
+			vmf.orig_pte = huge_pte_mkdirty(vmf.orig_pte);
 		}
 	}
-	entry = pte_mkyoung(entry);
-	if (huge_ptep_set_access_flags(vma, haddr, ptep, entry,
+	vmf.orig_pte = pte_mkyoung(vmf.orig_pte);
+	if (huge_ptep_set_access_flags(vma, vmf.address, vmf.pte, vmf.orig_pte,
 						flags & FAULT_FLAG_WRITE))
-		update_mmu_cache(vma, haddr, ptep);
+		update_mmu_cache(vma, vmf.address, vmf.pte);
 out_put_page:
 	if (folio != pagecache_folio)
 		folio_unlock(folio);
 	folio_put(folio);
 out_ptl:
-	spin_unlock(ptl);
+	spin_unlock(vmf.ptl);
 
 	if (pagecache_folio) {
 		folio_unlock(pagecache_folio);
-- 
2.43.0


