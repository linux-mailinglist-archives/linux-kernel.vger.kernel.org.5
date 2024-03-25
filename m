Return-Path: <linux-kernel+bounces-118126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 310DF88B437
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA521FA0119
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1478662A;
	Mon, 25 Mar 2024 22:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWlQfQCI"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F6284D15
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711406028; cv=none; b=jQGAZ2FBsKJ7taos+LfNsaJvLAapCsDieVzQ6px6RL6YgiX9IpW994k/HaJ7FXr5zpImu046Gzvlo94cazNzc2XFu2VmdWSVg0IHkQSaFAyeiomF3Bep08zgG/fr4aszvsBuhZNNr/+zhAU2vuNV6Z93/x7bvIQiOeG3kHOvUaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711406028; c=relaxed/simple;
	bh=VrAow78uMHuAALAVFOGL+L/XvOFKIVUCc06t1rv74As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNpDbS2yEdplazYjpEhVHewT4lOUApdROl/lpvs8on6IXdx8mC0yuy0D5WSIeZspJOSTgotGZ8ke7SZQlhCH4kRROerjuXEGmXT7y+yZmLnfmcJYkkkFfM5DohOia43D+hcum1MdcBKi80XP7qJa70hk3JnR2B+rFBbvHP2utuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWlQfQCI; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5e8470c1cb7so3379647a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711406025; x=1712010825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVOzucr5mvu7KOVzAqxUx6FA7sdm3qrl6lnpegwv/As=;
        b=lWlQfQCI82Nml2GZUL+QeopzbIppMQEMr5ZNbFeyg9A8eOWPQ0Y0GE6zn24cXaMhzM
         rG8DReUfP46I3z+FOYrkjaZPkx3Ah4t9x5uqHf3Bm1FkH5SEEpFFUzHZdjH5a/5sRXWh
         z15MFbUYaNtcsMGJBAM5HyjaPC0yETtVvUx3dHGSOG17L8w9HSWyHRk5o2smH9u9ARKu
         rzTbCgHQyEV9IQjk8r8kmKmEVvAPl8RiII8Abzd23TSsd/Lr78OIoH+v5N0s2qC3ly2Y
         mjpF9BXEAoln1i5Xpt+YR85FLN8E5bQXJ0yqPqch2acebvKoKxNE9D7TW6hwGpU53XgL
         x0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711406025; x=1712010825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVOzucr5mvu7KOVzAqxUx6FA7sdm3qrl6lnpegwv/As=;
        b=dCjPyYXnfNeW9tMtmOULuENga9izITTft7L8HCw3oLohVPWJQn5tVIWCz6/44vIJUc
         G4gAQdmY6SnqCST1ATcrXFSjdM5pEkW8buYIZjo7l2TgS0pwgRWZf2xOWnYZP4AO5ZTL
         jbcJFO+55zl4rsyRj5N+tPt7fJCWzWm9U2DqbilQFrqBi9gHiHsCbgnr+n7Sha1dXGzJ
         B+0sqpXHNDgY00eERfhCpq7bhwaNeYIQqWs+Ogz8svyHKS19J6e1ZybEIJ7DFnQlW5c0
         SZ7fqgV2ddJUOuFmk/otB+dpLu7G8IzP+TCq6YvV0pRGHj+5V563dVgMejgqIiGTImBU
         cY5Q==
X-Gm-Message-State: AOJu0YxSxAds5ZJBvNRvNqVj5FIiKS2I0g59QmUGOnJacC19K8yj4/rR
	8P2bMYIL3D6qop3Voab8OHoJu4OS1UNyccQDUel5R8xx7+5RRG7S
X-Google-Smtp-Source: AGHT+IFDk0utxLL00lJGKaaeGgNK3Hrl4HLtx0LXzLecUbp3ONOONhamzCvdDjqJbMq5Hf8iz/uE5Q==
X-Received: by 2002:a17:90a:8a03:b0:29c:6000:a12b with SMTP id w3-20020a17090a8a0300b0029c6000a12bmr1164130pjn.38.1711406025338;
        Mon, 25 Mar 2024 15:33:45 -0700 (PDT)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id sx16-20020a17090b2cd000b002a053cdd4e5sm4356173pjb.9.2024.03.25.15.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 15:33:45 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	muchun.song@linux.dev,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 3/5] hugetlb: Convert hugetlb_wp() to use struct vm_fault
Date: Mon, 25 Mar 2024 15:33:37 -0700
Message-ID: <20240325223339.169350-4-vishal.moola@gmail.com>
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

hugetlb_wp() can use the struct vm_fault passed in from hugetlb_fault().
This alleviates the stack by consolidating 5 variables into a single
struct.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/hugetlb.c | 61 ++++++++++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 819a6d067985..107b47329b9f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5825,18 +5825,16 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
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
@@ -5859,7 +5857,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	/* Let's take out MAP_SHARED mappings first. */
 	if (vma->vm_flags & VM_MAYSHARE) {
-		set_huge_ptep_writable(vma, haddr, ptep);
+		set_huge_ptep_writable(vma, vmf->address, vmf->pte);
 		return 0;
 	}
 
@@ -5878,7 +5876,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 			SetPageAnonExclusive(&old_folio->page);
 		}
 		if (likely(!unshare))
-			set_huge_ptep_writable(vma, haddr, ptep);
+			set_huge_ptep_writable(vma, vmf->address, vmf->pte);
 
 		delayacct_wpcopy_end();
 		return 0;
@@ -5905,8 +5903,8 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * Drop page table lock as buddy allocator may be called. It will
 	 * be acquired again before returning to the caller, as expected.
 	 */
-	spin_unlock(ptl);
-	new_folio = alloc_hugetlb_folio(vma, haddr, outside_reserve);
+	spin_unlock(vmf->ptl);
+	new_folio = alloc_hugetlb_folio(vma, vmf->address, outside_reserve);
 
 	if (IS_ERR(new_folio)) {
 		/*
@@ -5931,19 +5929,21 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
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
@@ -5965,37 +5965,38 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
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
@@ -6003,12 +6004,12 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
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
@@ -6272,8 +6273,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	hugetlb_count_add(pages_per_huge_page(h), mm);
 	if ((vmf->flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
 		/* Optimization, do the COW without a second fault */
-		ret = hugetlb_wp(mm, vma, vmf->real_address, vmf->pte,
-				vmf->flags, folio, vmf->ptl, vmf);
+		ret = hugetlb_wp(mm, vma, folio, vmf);
 	}
 
 	spin_unlock(vmf->ptl);
@@ -6486,8 +6486,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
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


