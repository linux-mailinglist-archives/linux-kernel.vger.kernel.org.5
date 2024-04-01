Return-Path: <linux-kernel+bounces-127030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3FF8945F9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21EA71F2241D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997E655E53;
	Mon,  1 Apr 2024 20:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGC06imR"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A8B53E3C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 20:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712003221; cv=none; b=S1MgmPsuTFNC9UjZeKCq0yJ1KiReJMA1RL4f1xN45m+D4h8m1VQGBrj6rhov/YY0GiouLiVruymm0E+SVBxUuoV4lTBYhtkpNEgZtQxc1k+GejXU76VdhP3t1fJUtbkqC87JlpZ+ardz6LysoDgVMbPzvBiaAHeNH0/JOWxc2ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712003221; c=relaxed/simple;
	bh=tiuLKvKM00xIkTz7M6ZfIlWlQS14HHGlVbF692jzUec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vb9F4GvUX0vbWfv0/M5RSwL6C2ETo0LYG/GGisktFqlDz0sjl7IEnVWpaB1FlyNkad05Eirj8v5XRBr8ruLb7B5JMVYUSMcYvHRwysn4il6QS82nB40SeAx4FW8vUZABjFCMbXOirlmKPy1fJo0WvXIXO7zZpoIQyzMtjDoedj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGC06imR; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6150c1fa3daso6467767b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 13:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712003219; x=1712608019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09S6vJM8RrkdrC/rkJ0OHkr1C8kqrWar9y0fEbWEbHY=;
        b=EGC06imRb/Ypj6noRCP5eM+y+/UJ0Y8MNwrZ53fKirt0HdJ+0LoSaoep+RK75gAYcg
         +kXTBI6lWhYZDfPCEg2VWP0YJy8gUYnAy+un34V6nzpHAhgxYqT28quHqqj7rzdFbZi0
         t1FrI933WImR6xkEKsHGBdzR9ELZEwoK67FWFd7qfl3dyXNxZfMtD6nUH/ywF+yF+7Nk
         ZhCZsB+zSK6OiP5flxv4XLmHL4ov6DaaZ6N85JvZ4/8pwxhMmqHphRlD3fbgvzxnxQ/B
         bITacghzH6L9rEwvOpR1f52qV2BjHgH+oeG+/HSkD2tIRaSZIp6Js8jkXSJwUL2jSYYO
         ns0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712003219; x=1712608019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09S6vJM8RrkdrC/rkJ0OHkr1C8kqrWar9y0fEbWEbHY=;
        b=cMmwfMQk8IWYt0KAT2ChsXksu6SX7PKhC6259VENh+nCOxSkE7WLzpjzUvlNgZBsa3
         tSjvjQluwicH2vLNjjvyww3H2GiB3k1PB7ZA0MjGXQ0MqSv0X1PCn1GpaOt3Wi96Udld
         M2weD7ERIPbVSBrEeon3C4j0BmSxO5RTftm30bRDtmoxwrgpW0e6M/kSND7XbUDW6JFc
         zRN0nDfF1F/d5d8zXQ+RGaGPAMlLHk8hJWj6yxphsdIR6jey/BxhuKpwe8QzOrKX0m08
         6nQoE7h+XY8Fd5mBSCv8m0AuIi6usE7O22m7s4biezqKWup0aI7nRyqes0dTDyi9mwzj
         Sy8w==
X-Gm-Message-State: AOJu0YwUHb3qLRa1gQlqqnbAU9CkB4SYKCqBVP76ok5FJWYSVw2EC5Hb
	QBYeb7YXFJInSu3IVpmGpFEQwI14BVznYJUG4X2KlYH2uqiKv85K
X-Google-Smtp-Source: AGHT+IFZ180aOPTb1CRRZ2Bu4ACYmdeIb3qE3iLlY2duuKwa7eQd71eLTyZ9BqrB+5kaF1LaPNv20Q==
X-Received: by 2002:a81:6f03:0:b0:610:1a19:14fa with SMTP id k3-20020a816f03000000b006101a1914famr9131808ywc.50.1712003218915;
        Mon, 01 Apr 2024 13:26:58 -0700 (PDT)
Received: from fedora.attlocal.net ([2600:1700:2f7d:1800::23])
        by smtp.googlemail.com with ESMTPSA id y72-20020a81a14b000000b006142210a31esm1171181ywg.23.2024.04.01.13.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 13:26:58 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	muchun.song@linux.dev,
	willy@infradead.org,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 3/3] hugetlb: Convert hugetlb_wp() to use struct vm_fault
Date: Mon,  1 Apr 2024 13:26:51 -0700
Message-ID: <20240401202651.31440-4-vishal.moola@gmail.com>
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

hugetlb_wp() can use the struct vm_fault passed in from hugetlb_fault().
This alleviates the stack by consolidating 5 variables into a single
struct.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/hugetlb.c | 61 ++++++++++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index aca2f11b4138..d4f26947173e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5918,18 +5918,16 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
  * Keep the pte_same checks anyway to make transition from the mutex easier.
  */
 static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
-		       unsigned long address, pte_t *ptep, unsigned int flags,
-		       struct folio *pagecache_folio, spinlock_t *ptl,
+		       struct folio *pagecache_folio,
 		       struct vm_fault *vmf)
 {
-	const bool unshare = flags & FAULT_FLAG_UNSHARE;
-	pte_t pte = huge_ptep_get(ptep);
+	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
+	pte_t pte = huge_ptep_get(vmf->pte);
 	struct hstate *h = hstate_vma(vma);
 	struct folio *old_folio;
 	struct folio *new_folio;
 	int outside_reserve = 0;
 	vm_fault_t ret = 0;
-	unsigned long haddr = address & huge_page_mask(h);
 	struct mmu_notifier_range range;
 
 	/*
@@ -5952,7 +5950,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	/* Let's take out MAP_SHARED mappings first. */
 	if (vma->vm_flags & VM_MAYSHARE) {
-		set_huge_ptep_writable(vma, haddr, ptep);
+		set_huge_ptep_writable(vma, vmf->address, vmf->pte);
 		return 0;
 	}
 
@@ -5971,7 +5969,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 			SetPageAnonExclusive(&old_folio->page);
 		}
 		if (likely(!unshare))
-			set_huge_ptep_writable(vma, haddr, ptep);
+			set_huge_ptep_writable(vma, vmf->address, vmf->pte);
 
 		delayacct_wpcopy_end();
 		return 0;
@@ -5998,8 +5996,8 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * Drop page table lock as buddy allocator may be called. It will
 	 * be acquired again before returning to the caller, as expected.
 	 */
-	spin_unlock(ptl);
-	new_folio = alloc_hugetlb_folio(vma, haddr, outside_reserve);
+	spin_unlock(vmf->ptl);
+	new_folio = alloc_hugetlb_folio(vma, vmf->address, outside_reserve);
 
 	if (IS_ERR(new_folio)) {
 		/*
@@ -6024,19 +6022,21 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 			 *
 			 * Reacquire both after unmap operation.
 			 */
-			idx = vma_hugecache_offset(h, vma, haddr);
+			idx = vma_hugecache_offset(h, vma, vmf->address);
 			hash = hugetlb_fault_mutex_hash(mapping, idx);
 			hugetlb_vma_unlock_read(vma);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 
-			unmap_ref_private(mm, vma, &old_folio->page, haddr);
+			unmap_ref_private(mm, vma, &old_folio->page,
+					vmf->address);
 
 			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 			hugetlb_vma_lock_read(vma);
-			spin_lock(ptl);
-			ptep = hugetlb_walk(vma, haddr, huge_page_size(h));
-			if (likely(ptep &&
-				   pte_same(huge_ptep_get(ptep), pte)))
+			spin_lock(vmf->ptl);
+			vmf->pte = hugetlb_walk(vma, vmf->address,
+					huge_page_size(h));
+			if (likely(vmf->pte &&
+				   pte_same(huge_ptep_get(vmf->pte), pte)))
 				goto retry_avoidcopy;
 			/*
 			 * race occurs while re-acquiring page table
@@ -6058,37 +6058,38 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (unlikely(ret))
 		goto out_release_all;
 
-	if (copy_user_large_folio(new_folio, old_folio, address, vma)) {
+	if (copy_user_large_folio(new_folio, old_folio, vmf->real_address, vma)) {
 		ret = VM_FAULT_HWPOISON_LARGE;
 		goto out_release_all;
 	}
 	__folio_mark_uptodate(new_folio);
 
-	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, haddr,
-				haddr + huge_page_size(h));
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, vmf->address,
+				vmf->address + huge_page_size(h));
 	mmu_notifier_invalidate_range_start(&range);
 
 	/*
 	 * Retake the page table lock to check for racing updates
 	 * before the page tables are altered
 	 */
-	spin_lock(ptl);
-	ptep = hugetlb_walk(vma, haddr, huge_page_size(h));
-	if (likely(ptep && pte_same(huge_ptep_get(ptep), pte))) {
+	spin_lock(vmf->ptl);
+	vmf->pte = hugetlb_walk(vma, vmf->address, huge_page_size(h));
+	if (likely(vmf->pte && pte_same(huge_ptep_get(vmf->pte), pte))) {
 		pte_t newpte = make_huge_pte(vma, &new_folio->page, !unshare);
 
 		/* Break COW or unshare */
-		huge_ptep_clear_flush(vma, haddr, ptep);
+		huge_ptep_clear_flush(vma, vmf->address, vmf->pte);
 		hugetlb_remove_rmap(old_folio);
-		hugetlb_add_new_anon_rmap(new_folio, vma, haddr);
+		hugetlb_add_new_anon_rmap(new_folio, vma, vmf->address);
 		if (huge_pte_uffd_wp(pte))
 			newpte = huge_pte_mkuffd_wp(newpte);
-		set_huge_pte_at(mm, haddr, ptep, newpte, huge_page_size(h));
+		set_huge_pte_at(mm, vmf->address, vmf->pte, newpte,
+				huge_page_size(h));
 		folio_set_hugetlb_migratable(new_folio);
 		/* Make the old page be freed below */
 		new_folio = old_folio;
 	}
-	spin_unlock(ptl);
+	spin_unlock(vmf->ptl);
 	mmu_notifier_invalidate_range_end(&range);
 out_release_all:
 	/*
@@ -6096,12 +6097,12 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * unshare)
 	 */
 	if (new_folio != old_folio)
-		restore_reserve_on_error(h, vma, haddr, new_folio);
+		restore_reserve_on_error(h, vma, vmf->address, new_folio);
 	folio_put(new_folio);
 out_release_old:
 	folio_put(old_folio);
 
-	spin_lock(ptl); /* Caller expects lock to be held */
+	spin_lock(vmf->ptl); /* Caller expects lock to be held */
 
 	delayacct_wpcopy_end();
 	return ret;
@@ -6365,8 +6366,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	hugetlb_count_add(pages_per_huge_page(h), mm);
 	if ((vmf->flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
 		/* Optimization, do the COW without a second fault */
-		ret = hugetlb_wp(mm, vma, vmf->real_address, vmf->pte,
-				vmf->flags, folio, vmf->ptl, vmf);
+		ret = hugetlb_wp(mm, vma, folio, vmf);
 	}
 
 	spin_unlock(vmf->ptl);
@@ -6579,8 +6579,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	if (flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
 		if (!huge_pte_write(vmf.orig_pte)) {
-			ret = hugetlb_wp(mm, vma, address, vmf.pte, flags,
-					 pagecache_folio, vmf.ptl, &vmf);
+			ret = hugetlb_wp(mm, vma, pagecache_folio, &vmf);
 			goto out_put_page;
 		} else if (likely(flags & FAULT_FLAG_WRITE)) {
 			vmf.orig_pte = huge_pte_mkdirty(vmf.orig_pte);
-- 
2.43.0


