Return-Path: <linux-kernel+bounces-118127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3A588B438
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B7131C61624
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26BA84D08;
	Mon, 25 Mar 2024 22:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qp1KvW6N"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE2184D35
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711406030; cv=none; b=R+vvmb4WXEyE/nOHsXzvDNTPveQ2dMghg1iLEJPcOOLakwIer1dhhF18ArDPXSw070TovUJ8sK2ZuuSEsomUPDCQiHXkAL43492xhn44CuBSSUUZuQuDpkgC3BwPtZ+KXt5fLSia+B+iwX99rlCbGTKZSYa897daKc/IagQ6FzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711406030; c=relaxed/simple;
	bh=tBZdwXXPGB1xRNSiIH7furKYYODiVU7bBfowL2w3GfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLs4DV8Qgk3JXAAeYhm0XXvtfAfu31ktzNVPnHoiWaGzHtFDteGV42mbGZgWNLW2RGZ9FPTh35jg+LWod34bVEBj9/GQzFQcih9qpmGoCJx/mSCgsV8IK+r7xi2IYsYe1Y90nlGnBT1mPlIgjMz5xoYkLjN9O3q0EDadzDasyTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qp1KvW6N; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29fb12a22afso3264523a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711406028; x=1712010828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xa0qOW5rWdjbo+w+QnIgdTmY7x8+eguqE2o56xDAiCo=;
        b=Qp1KvW6NVBKkkqNk1dGgax1WAB0wLfthV6nfS5h3OLig2YtRvEwDqoi+QfWWgQewa4
         ryGKl2suHY2PdiY/PJyNrK8CdP51FZ37tTuARQO1z63n0s+Zzk7tmFKeqr78NBsGAz+x
         GvACJtsXw/dx83drgdwKSGNH3XthmnLsKcJSJKrmYEuhP2VDPakscBBSeKIEb4HXNdMG
         YSioh5x+Plp8Uz1zMyxEesxpDzQml3MAMSoMm342s+AYXxbwyLnVkLCLV5E8qv3wYhdr
         OrMrq+tjhCbglybe414cBRE0d2IXPq//Hr1f7/5PTtJGJlhurbwyrWB9GTCmIc0SJ7BL
         07IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711406028; x=1712010828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xa0qOW5rWdjbo+w+QnIgdTmY7x8+eguqE2o56xDAiCo=;
        b=SI2lkNdWoxswUG7mrmJG/3qMGaGQv1X8KVN8BlizUjbXV/1jx+SoBDSnBw2AjdNl78
         N2u5h6nhj7u6moao4iSa3xQBiSXENfqzZOvpEU1iTcqq9w65x+BFxoZTsxuKW9Q4dZjV
         GmhLHhnGt+y2TQa5Y+wstcvdxmmLpPLkkBgjvduuWTcBkB8s3ydl0bzsmOcg7RES39L0
         AofD2mMkNa9aqOOR6xPp5VyM4RSp2DWBDc7emTSa0EfhOyOvDRijAAcAvB1XRcDeLru/
         8grTTYjvLF+N0zpJCzokL9oTNg8cK4/kHGV0rCozUfv0g01FakVXI0r1g1kw8IyjbsJ2
         sdVw==
X-Gm-Message-State: AOJu0YxoBJKOwN3K7j2bU3h5i/THpJPWsvqjctUfBEBkGf1pKe4FZYKj
	nLF6TVTlDKwKQu9cK6vV5ZRxOsBU5Cp83OZ5MoEbtlr5IkG0hTc/f6RZ9GV9OEE=
X-Google-Smtp-Source: AGHT+IFRm0SsVYiVz6wu55o5NNu1OirYSh8Wnv/Y+CNLuAFTeLpCWCaL50rUVsBgY/cv4dzw/fjRUw==
X-Received: by 2002:a17:90a:16c2:b0:29a:3c70:1525 with SMTP id y2-20020a17090a16c200b0029a3c701525mr5308309pje.45.1711406027625;
        Mon, 25 Mar 2024 15:33:47 -0700 (PDT)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id sx16-20020a17090b2cd000b002a053cdd4e5sm4356173pjb.9.2024.03.25.15.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 15:33:47 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	muchun.song@linux.dev,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 5/5] memory: Define struct vm_fault in handle_mm_fault()
Date: Mon, 25 Mar 2024 15:33:39 -0700
Message-ID: <20240325223339.169350-6-vishal.moola@gmail.com>
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

Define struct vm_fault in handle_mm_fault() to be passed throughout the
rest of the fault pathway. Pass it through to hugetlb_fault() and
__handle_mm_fault(), making any necessary trivial changes.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/hugetlb.h |   7 +--
 mm/hugetlb.c            | 106 +++++++++++++++++++---------------------
 mm/memory.c             |  87 +++++++++++++++++----------------
 3 files changed, 98 insertions(+), 102 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index c1ee640d87b1..0e0a93b4d9fc 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -147,8 +147,7 @@ void hugetlb_report_meminfo(struct seq_file *);
 int hugetlb_report_node_meminfo(char *buf, int len, int nid);
 void hugetlb_show_meminfo_node(int nid);
 unsigned long hugetlb_total_pages(void);
-vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
-			unsigned long address, unsigned int flags);
+vm_fault_t hugetlb_fault(struct vm_fault *vmf);
 #ifdef CONFIG_USERFAULTFD
 int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 			     struct vm_area_struct *dst_vma,
@@ -482,9 +481,7 @@ static inline void __unmap_hugepage_range(struct mmu_gather *tlb,
 	BUG();
 }
 
-static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,
-			struct vm_area_struct *vma, unsigned long address,
-			unsigned int flags)
+static inline vm_fault_t hugetlb_fault(struct vm_fault *vmf)
 {
 	BUG();
 	return 0;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 107b47329b9f..7ecc680f4681 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6327,30 +6327,24 @@ u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx)
 }
 #endif
 
-vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
-			unsigned long address, unsigned int flags)
+vm_fault_t hugetlb_fault(struct vm_fault *vmf)
 {
 	vm_fault_t ret;
 	u32 hash;
+	struct vm_area_struct *vma = vmf->vma;
+	struct mm_struct *mm = vma->vm_mm;
 	struct folio *folio = NULL;
 	struct folio *pagecache_folio = NULL;
 	struct hstate *h = hstate_vma(vma);
 	struct address_space *mapping;
 	int need_wait_lock = 0;
-	struct vm_fault vmf = {
-		.vma = vma,
-		.address = address & huge_page_mask(h),
-		.real_address = address,
-		.flags = flags,
-		.pgoff = vma_hugecache_offset(h, vma,
-				address & huge_page_mask(h)),
-		/* TODO: Track hugetlb faults using vm_fault */
-
-		/*
-		 * Some fields may not be initialized, be careful as it may
-		 * be hard to debug if called functions make assumptions
-		 */
-	};
+	/*
+	 * Some fields of vmf may not be initialized, be careful as it may
+	 * be hard to debug if called functions make assumptions
+	 */
+	vmf->address = vmf->real_address & huge_page_mask(h);
+	vmf->pgoff = vma_hugecache_offset(h, vma,
+				vmf->address & huge_page_mask(h));
 
 	/*
 	 * Serialize hugepage allocation and instantiation, so that we don't
@@ -6358,27 +6352,27 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * the same page in the page cache.
 	 */
 	mapping = vma->vm_file->f_mapping;
-	hash = hugetlb_fault_mutex_hash(mapping, vmf.pgoff);
+	hash = hugetlb_fault_mutex_hash(mapping, vmf->pgoff);
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 	/*
 	 * Acquire vma lock before calling huge_pte_alloc and hold
-	 * until finished with vmf.pte.  This prevents huge_pmd_unshare from
-	 * being called elsewhere and making the vmf.pte no longer valid.
+	 * until finished with vmf->pte.  This prevents huge_pmd_unshare from
+	 * being called elsewhere and making the vmf->pte no longer valid.
 	 */
 	hugetlb_vma_lock_read(vma);
-	vmf.pte = huge_pte_alloc(mm, vma, vmf.address, huge_page_size(h));
-	if (!vmf.pte) {
+	vmf->pte = huge_pte_alloc(mm, vma, vmf->address, huge_page_size(h));
+	if (!vmf->pte) {
 		hugetlb_vma_unlock_read(vma);
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		return VM_FAULT_OOM;
 	}
 
-	vmf.orig_pte = huge_ptep_get(vmf.pte);
-	if (huge_pte_none_mostly(vmf.orig_pte)) {
-		if (is_pte_marker(vmf.orig_pte)) {
+	vmf->orig_pte = huge_ptep_get(vmf->pte);
+	if (huge_pte_none_mostly(vmf->orig_pte)) {
+		if (is_pte_marker(vmf->orig_pte)) {
 			pte_marker marker =
-				pte_marker_get(pte_to_swp_entry(vmf.orig_pte));
+				pte_marker_get(pte_to_swp_entry(vmf->orig_pte));
 
 			if (marker & PTE_MARKER_POISONED) {
 				ret = VM_FAULT_HWPOISON_LARGE;
@@ -6392,20 +6386,20 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * hugetlb_no_page will drop vma lock and hugetlb fault
 		 * mutex internally, which make us return immediately.
 		 */
-		return hugetlb_no_page(mm, vma, mapping, &vmf);
+		return hugetlb_no_page(mm, vma, mapping, vmf);
 	}
 
 	ret = 0;
 
 	/*
-	 * vmf.orig_pte could be a migration/hwpoison vmf.orig_pte at this
+	 * vmf->orig_pte could be a migration/hwpoison vmf->orig_pte at this
 	 * point, so this check prevents the kernel from going below assuming
 	 * that we have an active hugepage in pagecache. This goto expects
 	 * the 2nd page fault, and is_hugetlb_entry_(migration|hwpoisoned)
 	 * check will properly handle it.
 	 */
-	if (!pte_present(vmf.orig_pte)) {
-		if (unlikely(is_hugetlb_entry_migration(vmf.orig_pte))) {
+	if (!pte_present(vmf->orig_pte)) {
+		if (unlikely(is_hugetlb_entry_migration(vmf->orig_pte))) {
 			/*
 			 * Release the hugetlb fault lock now, but retain
 			 * the vma lock, because it is needed to guard the
@@ -6414,9 +6408,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			 * be released there.
 			 */
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			migration_entry_wait_huge(vma, vmf.pte);
+			migration_entry_wait_huge(vma, vmf->pte);
 			return 0;
-		} else if (unlikely(is_hugetlb_entry_hwpoisoned(vmf.orig_pte)))
+		} else if (unlikely(is_hugetlb_entry_hwpoisoned(vmf->orig_pte)))
 			ret = VM_FAULT_HWPOISON_LARGE |
 			    VM_FAULT_SET_HINDEX(hstate_index(h));
 		goto out_mutex;
@@ -6429,53 +6423,53 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * spinlock. Also lookup the pagecache page now as it is used to
 	 * determine if a reservation has been consumed.
 	 */
-	if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
-	    !(vma->vm_flags & VM_MAYSHARE) && !huge_pte_write(vmf.orig_pte)) {
-		if (vma_needs_reservation(h, vma, vmf.address) < 0) {
+	if ((vmf->flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
+	    !(vma->vm_flags & VM_MAYSHARE) && !huge_pte_write(vmf->orig_pte)) {
+		if (vma_needs_reservation(h, vma, vmf->address) < 0) {
 			ret = VM_FAULT_OOM;
 			goto out_mutex;
 		}
 		/* Just decrements count, does not deallocate */
-		vma_end_reservation(h, vma, vmf.address);
+		vma_end_reservation(h, vma, vmf->address);
 
 		pagecache_folio = filemap_lock_hugetlb_folio(h, mapping,
-							     vmf.pgoff);
+							     vmf->pgoff);
 		if (IS_ERR(pagecache_folio))
 			pagecache_folio = NULL;
 	}
 
-	vmf.ptl = huge_pte_lock(h, mm, vmf.pte);
+	vmf->ptl = huge_pte_lock(h, mm, vmf->pte);
 
 	/* Check for a racing update before calling hugetlb_wp() */
-	if (unlikely(!pte_same(vmf.orig_pte, huge_ptep_get(vmf.pte))))
+	if (unlikely(!pte_same(vmf->orig_pte, huge_ptep_get(vmf->pte))))
 		goto out_ptl;
 
 	/* Handle userfault-wp first, before trying to lock more pages */
-	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(huge_ptep_get(vmf.pte)) &&
-	    (flags & FAULT_FLAG_WRITE) && !huge_pte_write(vmf.orig_pte)) {
+	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(huge_ptep_get(vmf->pte)) &&
+	    (vmf->flags & FAULT_FLAG_WRITE) && !huge_pte_write(vmf->orig_pte)) {
 		if (!userfaultfd_wp_async(vma)) {
-			spin_unlock(vmf.ptl);
+			spin_unlock(vmf->ptl);
 			if (pagecache_folio) {
 				folio_unlock(pagecache_folio);
 				folio_put(pagecache_folio);
 			}
 			hugetlb_vma_unlock_read(vma);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			return handle_userfault(&vmf, VM_UFFD_WP);
+			return handle_userfault(vmf, VM_UFFD_WP);
 		}
 
-		vmf.orig_pte = huge_pte_clear_uffd_wp(vmf.orig_pte);
-		set_huge_pte_at(mm, vmf.address, vmf.pte, vmf.orig_pte,
+		vmf->orig_pte = huge_pte_clear_uffd_wp(vmf->orig_pte);
+		set_huge_pte_at(mm, vmf->address, vmf->pte, vmf->orig_pte,
 				huge_page_size(hstate_vma(vma)));
 		/* Fallthrough to CoW */
 	}
 
 	/*
-	 * hugetlb_wp() requires page locks of pte_page(vmf.orig_pte) and
+	 * hugetlb_wp() requires page locks of pte_page(vmf->orig_pte) and
 	 * pagecache_folio, so here we need take the former one
 	 * when folio != pagecache_folio or !pagecache_folio.
 	 */
-	folio = page_folio(pte_page(vmf.orig_pte));
+	folio = page_folio(pte_page(vmf->orig_pte));
 	if (folio != pagecache_folio)
 		if (!folio_trylock(folio)) {
 			need_wait_lock = 1;
@@ -6484,24 +6478,24 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	folio_get(folio);
 
-	if (flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
-		if (!huge_pte_write(vmf.orig_pte)) {
-			ret = hugetlb_wp(mm, vma, pagecache_folio, &vmf);
+	if (vmf->flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
+		if (!huge_pte_write(vmf->orig_pte)) {
+			ret = hugetlb_wp(mm, vma, pagecache_folio, vmf);
 			goto out_put_page;
-		} else if (likely(flags & FAULT_FLAG_WRITE)) {
-			vmf.orig_pte = huge_pte_mkdirty(vmf.orig_pte);
+		} else if (likely(vmf->flags & FAULT_FLAG_WRITE)) {
+			vmf->orig_pte = huge_pte_mkdirty(vmf->orig_pte);
 		}
 	}
-	vmf.orig_pte = pte_mkyoung(vmf.orig_pte);
-	if (huge_ptep_set_access_flags(vma, vmf.address, vmf.pte, vmf.orig_pte,
-						flags & FAULT_FLAG_WRITE))
-		update_mmu_cache(vma, vmf.address, vmf.pte);
+	vmf->orig_pte = pte_mkyoung(vmf->orig_pte);
+	if (huge_ptep_set_access_flags(vma, vmf->address, vmf->pte,
+				vmf->orig_pte, vmf->flags & FAULT_FLAG_WRITE))
+		update_mmu_cache(vma, vmf->address, vmf->pte);
 out_put_page:
 	if (folio != pagecache_folio)
 		folio_unlock(folio);
 	folio_put(folio);
 out_ptl:
-	spin_unlock(vmf.ptl);
+	spin_unlock(vmf->ptl);
 
 	if (pagecache_folio) {
 		folio_unlock(pagecache_folio);
diff --git a/mm/memory.c b/mm/memory.c
index c93b058adfb2..a2fcb0322b11 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5191,39 +5191,35 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
  * the result, the mmap_lock is not held on exit.  See filemap_fault()
  * and __folio_lock_or_retry().
  */
-static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
-		unsigned long address, unsigned int flags)
+static vm_fault_t __handle_mm_fault(struct vm_fault *vmf)
 {
-	struct vm_fault vmf = {
-		.vma = vma,
-		.address = address & PAGE_MASK,
-		.real_address = address,
-		.flags = flags,
-		.pgoff = linear_page_index(vma, address),
-		.gfp_mask = __get_fault_gfp_mask(vma),
-	};
+	struct vm_area_struct *vma = vmf->vma;
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long vm_flags = vma->vm_flags;
+	const unsigned long address = vmf->real_address;
 	pgd_t *pgd;
 	p4d_t *p4d;
 	vm_fault_t ret;
 
+	vmf->address = address & PAGE_MASK;
+	vmf->pgoff = linear_page_index(vma, address);
 	pgd = pgd_offset(mm, address);
 	p4d = p4d_alloc(mm, pgd, address);
 	if (!p4d)
 		return VM_FAULT_OOM;
 
-	vmf.pud = pud_alloc(mm, p4d, address);
-	if (!vmf.pud)
+	vmf->pud = pud_alloc(mm, p4d, address);
+	if (!vmf->pud)
 		return VM_FAULT_OOM;
 retry_pud:
-	if (pud_none(*vmf.pud) &&
-	    thp_vma_allowable_order(vma, vm_flags, false, true, true, PUD_ORDER)) {
-		ret = create_huge_pud(&vmf);
+	if (pud_none(*vmf->pud) &&
+	    thp_vma_allowable_order(vma, vm_flags, false, true,
+				true, PUD_ORDER)) {
+		ret = create_huge_pud(vmf);
 		if (!(ret & VM_FAULT_FALLBACK))
 			return ret;
 	} else {
-		pud_t orig_pud = *vmf.pud;
+		pud_t orig_pud = *vmf->pud;
 
 		barrier();
 		if (pud_trans_huge(orig_pud) || pud_devmap(orig_pud)) {
@@ -5232,57 +5228,60 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 			 * TODO once we support anonymous PUDs: NUMA case and
 			 * FAULT_FLAG_UNSHARE handling.
 			 */
-			if ((flags & FAULT_FLAG_WRITE) && !pud_write(orig_pud)) {
-				ret = wp_huge_pud(&vmf, orig_pud);
+			if ((vmf->flags & FAULT_FLAG_WRITE) &&
+					!pud_write(orig_pud)) {
+				ret = wp_huge_pud(vmf, orig_pud);
 				if (!(ret & VM_FAULT_FALLBACK))
 					return ret;
 			} else {
-				huge_pud_set_accessed(&vmf, orig_pud);
+				huge_pud_set_accessed(vmf, orig_pud);
 				return 0;
 			}
 		}
 	}
 
-	vmf.pmd = pmd_alloc(mm, vmf.pud, address);
-	if (!vmf.pmd)
+	vmf->pmd = pmd_alloc(mm, vmf->pud, address);
+	if (!vmf->pmd)
 		return VM_FAULT_OOM;
 
 	/* Huge pud page fault raced with pmd_alloc? */
-	if (pud_trans_unstable(vmf.pud))
+	if (pud_trans_unstable(vmf->pud))
 		goto retry_pud;
 
-	if (pmd_none(*vmf.pmd) &&
-	    thp_vma_allowable_order(vma, vm_flags, false, true, true, PMD_ORDER)) {
-		ret = create_huge_pmd(&vmf);
+	if (pmd_none(*vmf->pmd) &&
+	    thp_vma_allowable_order(vma, vm_flags, false, true,
+			true, PMD_ORDER)) {
+		ret = create_huge_pmd(vmf);
 		if (!(ret & VM_FAULT_FALLBACK))
 			return ret;
 	} else {
-		vmf.orig_pmd = pmdp_get_lockless(vmf.pmd);
+		vmf->orig_pmd = pmdp_get_lockless(vmf->pmd);
 
-		if (unlikely(is_swap_pmd(vmf.orig_pmd))) {
+		if (unlikely(is_swap_pmd(vmf->orig_pmd))) {
 			VM_BUG_ON(thp_migration_supported() &&
-					  !is_pmd_migration_entry(vmf.orig_pmd));
-			if (is_pmd_migration_entry(vmf.orig_pmd))
-				pmd_migration_entry_wait(mm, vmf.pmd);
+					  !is_pmd_migration_entry(vmf->orig_pmd));
+			if (is_pmd_migration_entry(vmf->orig_pmd))
+				pmd_migration_entry_wait(mm, vmf->pmd);
 			return 0;
 		}
-		if (pmd_trans_huge(vmf.orig_pmd) || pmd_devmap(vmf.orig_pmd)) {
-			if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma))
-				return do_huge_pmd_numa_page(&vmf);
-
-			if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
-			    !pmd_write(vmf.orig_pmd)) {
-				ret = wp_huge_pmd(&vmf);
+		if (pmd_trans_huge(vmf->orig_pmd) ||
+				pmd_devmap(vmf->orig_pmd)) {
+			if (pmd_protnone(vmf->orig_pmd) && vma_is_accessible(vma))
+				return do_huge_pmd_numa_page(vmf);
+
+			if ((vmf->flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE))
+					&& !pmd_write(vmf->orig_pmd)) {
+				ret = wp_huge_pmd(vmf);
 				if (!(ret & VM_FAULT_FALLBACK))
 					return ret;
 			} else {
-				huge_pmd_set_accessed(&vmf);
+				huge_pmd_set_accessed(vmf);
 				return 0;
 			}
 		}
 	}
 
-	return handle_pte_fault(&vmf);
+	return handle_pte_fault(vmf);
 }
 
 /**
@@ -5421,6 +5420,12 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	/* If the fault handler drops the mmap_lock, vma may be freed */
 	struct mm_struct *mm = vma->vm_mm;
 	vm_fault_t ret;
+	struct vm_fault vmf = {
+		.vma = vma,
+		.real_address = address,
+		.flags = flags,
+		.gfp_mask = __get_fault_gfp_mask(vma),
+	};
 
 	__set_current_state(TASK_RUNNING);
 
@@ -5445,9 +5450,9 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	lru_gen_enter_fault(vma);
 
 	if (unlikely(is_vm_hugetlb_page(vma)))
-		ret = hugetlb_fault(vma->vm_mm, vma, address, flags);
+		ret = hugetlb_fault(&vmf);
 	else
-		ret = __handle_mm_fault(vma, address, flags);
+		ret = __handle_mm_fault(&vmf);
 
 	lru_gen_exit_fault();
 
-- 
2.43.0


