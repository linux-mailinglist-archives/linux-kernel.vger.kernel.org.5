Return-Path: <linux-kernel+bounces-85930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E26B886BCE5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99CB728878B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727462C850;
	Thu, 29 Feb 2024 00:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eahb1Mc7"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2162772A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709167148; cv=none; b=VXn3tONwMC8wLvnOwrxJPPbVr/df6Xy6G4guOWqV2W2cZoNNebmrbZfAMSlQorq9Lu3uLkjPOm1B3k4pkXQnq0mfCQQoN12KoJasjuUj7N6WA9kHDlyUxdCSJlkRblnF+U7C6Ll5GANymEbMyNk40WO4ZwZ4RyURBJq9GkzTujU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709167148; c=relaxed/simple;
	bh=6f5FbMtgjFQJN+a8Ug3AwZsfgcPneqGUkmK0PoSEDgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LLU7DaPV6oRuf9xCddzIvRq7UMYsOUuMSZG/w7D4a8bVp/9bKeL8L0bSyhzBxlQJS7vqI+KEUGlI9rolr02C1kIA2NEBHIqpMJY6prwIfjuYWnKQzXBNX2B105swJCQ4cDVQRwOv447TAuRX20hMGH7lCbpxzvpX6fWWZZU1lzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eahb1Mc7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d93edfa76dso4077485ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709167146; x=1709771946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbI/XApED6aL6ip36JGDw3HTQoLAAxWC9U5cpk4hjWc=;
        b=eahb1Mc7HlHzH/r+qKtJ7ti9VTrEAZA5NIihXqg3Y30mLE9V6R2eY65vQrJ7VOSZYO
         4aezt/9QII4sUjF8/FgtLLWQvG8fWIl3VlfZAmbkTJ8v0ZmFpFcQ1KnehqBJW0bJdiVN
         CvxrGJINTc6LIfycMUqm5t+SeWEO7Qr0FEB6kzGVvGTJ8DDSQCmUW+JKIIi2+bsZQ5/Z
         WVkt8buG6+u4tNKNbEnOULm8GRnh6/9cfYRh4/9/QFweFmpJu9CRsNo8oYPoLfKbjeTK
         1BxpNTIvr1PVnmKtefJZ8skvlMZ+23ILbT0zFFTGKkAUeWvne492MDYfZuCQ6QOVHQ76
         iazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709167146; x=1709771946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qbI/XApED6aL6ip36JGDw3HTQoLAAxWC9U5cpk4hjWc=;
        b=dgMJtPXjoWVR/rb6CFbrCvljhouEKhL6wXJBiyZQ9qVNTURqr2rokYgHYV8kJsoJum
         Hc6EPyV6bzIqtsgd2yejrN8K2ff3+TnzjeG8Pvnm1oBCCidOMv2UeV2nJZsLMwaI52Za
         u1YlHWn++h2f2Y/t/TLC5abgO8hdunRtN4yfNf3JIjV2d0FiKqWttWtbZ04PZ3Hla/gi
         OUbflt9SOci5IGL+6XIXkakC3PYX4yliEyxrxBEI/h+eGZb5gvirX+FCBx6nueKTtL7+
         0NV0h5BU/UEVRJbOkPwwm92rg6HsGm/466veFR0FvICnRFsLCDu0Hk8NRFzp8jS/u4EQ
         KFIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlY/HR+STd/WdabtDHQzzLdBQTkTztya1B4+73eAxmUCQj2LpdA/BIXDTaiV+tu1Sn2DSf+1BbvCE5hhrJ3M1+RpVHSb03/4t8Q3En
X-Gm-Message-State: AOJu0YzBHlJVs/pHbsKnwZMgnaniTEOB0wXcmJHMFuGvJ8kfeZt/5+GV
	Ul+beHBRDdaAh8jkbwq/55jN/SWPD9oEHLILX+nNCcEDwJ8aB+Fh
X-Google-Smtp-Source: AGHT+IG+S6jcynauDRSdZ9l3zET/zqstY86gTNFzUYCAszncMlV3OluHiIng2OvqNpYj0yUVvzvDwg==
X-Received: by 2002:a17:902:b192:b0:1dc:5efc:8498 with SMTP id s18-20020a170902b19200b001dc5efc8498mr527487plr.56.1709167145576;
        Wed, 28 Feb 2024 16:39:05 -0800 (PST)
Received: from localhost.localdomain ([2407:7000:8942:5500:5158:ed66:78b3:7fda])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902780300b001d9641003cfsm62647pll.142.2024.02.28.16.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 16:39:05 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	linux-mm@kvack.org,
	ryan.roberts@arm.com,
	chrisl@kernel.org
Cc: 21cnbao@gmail.com,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	shy828301@gmail.com,
	steven.price@arm.com,
	surenb@google.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yuzhao@google.com,
	kasong@tencent.com,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	hannes@cmpxchg.org,
	linux-arm-kernel@lists.infradead.org,
	Chuanhua Han <hanchuanhua@oppo.com>,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH RFC v2 5/5] mm: support large folios swapin as a whole
Date: Thu, 29 Feb 2024 13:37:53 +1300
Message-Id: <20240229003753.134193-6-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229003753.134193-1-21cnbao@gmail.com>
References: <20240229003753.134193-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuanhua Han <hanchuanhua@oppo.com>

On an embedded system like Android, more than half of anon memory is actually
in swap devices such as zRAM. For example, while an app is switched to back-
ground, its most memory might be swapped-out.

Now we have mTHP features, unfortunately, if we don't support large folios
swap-in, once those large folios are swapped-out, we immediately lose the
performance gain we can get through large folios and hardware optimization
such as CONT-PTE.

This patch brings up mTHP swap-in support. Right now, we limit mTHP swap-in
to those contiguous swaps which were likely swapped out from mTHP as a whole.

On the other hand, the current implementation only covers the SWAP_SYCHRONOUS
case. It doesn't support swapin_readahead as large folios yet.

Right now, we are re-faulting large folios which are still in swapcache as a
whole, this can effectively decrease extra loops and early-exitings which we
have increased in arch_swap_restore() while supporting MTE restore for folios
rather than page. On the other hand, it can also decrease do_swap_page as PTEs
used to be set one by one even we hit a large folio in swapcache.

Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
Co-developed-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/memory.c | 191 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 157 insertions(+), 34 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 90b08b7cbaac..471689ce4e91 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -104,9 +104,16 @@ struct page *mem_map;
 EXPORT_SYMBOL(mem_map);
 #endif
 
+/* A choice of behaviors for alloc_anon_folio() */
+enum behavior {
+	DO_SWAP_PAGE,
+	DO_ANON_PAGE,
+};
+
 static vm_fault_t do_fault(struct vm_fault *vmf);
 static vm_fault_t do_anonymous_page(struct vm_fault *vmf);
 static bool vmf_pte_changed(struct vm_fault *vmf);
+static struct folio *alloc_anon_folio(struct vm_fault *vmf, enum behavior behavior);
 
 /*
  * Return true if the original pte was a uffd-wp pte marker (so the pte was
@@ -3974,6 +3981,52 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 	return VM_FAULT_SIGBUS;
 }
 
+/*
+ * check a range of PTEs are completely swap entries with
+ * contiguous swap offsets and the same SWAP_HAS_CACHE.
+ * pte must be first one in the range
+ */
+static bool is_pte_range_contig_swap(pte_t *pte, int nr_pages)
+{
+	int i;
+	struct swap_info_struct *si;
+	swp_entry_t entry;
+	unsigned type;
+	pgoff_t start_offset;
+	char has_cache;
+
+	entry = pte_to_swp_entry(ptep_get_lockless(pte));
+	if (non_swap_entry(entry))
+		return false;
+	start_offset = swp_offset(entry);
+	if (start_offset % nr_pages)
+		return false;
+
+	si = swp_swap_info(entry);
+	type = swp_type(entry);
+	has_cache = si->swap_map[start_offset] & SWAP_HAS_CACHE;
+	for (i = 1; i < nr_pages; i++) {
+		entry = pte_to_swp_entry(ptep_get_lockless(pte + i));
+		if (non_swap_entry(entry))
+			return false;
+		if (swp_offset(entry) != start_offset + i)
+			return false;
+		if (swp_type(entry) != type)
+			return false;
+		/*
+		 * while allocating a large folio and doing swap_read_folio for the
+		 * SWP_SYNCHRONOUS_IO path, which is the case the being faulted pte
+		 * doesn't have swapcache. We need to ensure all PTEs have no cache
+		 * as well, otherwise, we might go to swap devices while the content
+		 * is in swapcache
+		 */
+		if ((si->swap_map[start_offset + i] & SWAP_HAS_CACHE) != has_cache)
+			return false;
+	}
+
+	return true;
+}
+
 /*
  * We enter with non-exclusive mmap_lock (to exclude vma changes,
  * but allow concurrent faults), and pte mapped but not yet locked.
@@ -3995,6 +4048,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	pte_t pte;
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
+	int nr_pages = 1;
+	unsigned long start_address;
+	pte_t *start_pte;
 
 	if (!pte_unmap_same(vmf))
 		goto out;
@@ -4058,28 +4114,32 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (!folio) {
 		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
 		    __swap_count(entry) == 1) {
-			/*
-			 * Prevent parallel swapin from proceeding with
-			 * the cache flag. Otherwise, another thread may
-			 * finish swapin first, free the entry, and swapout
-			 * reusing the same entry. It's undetectable as
-			 * pte_same() returns true due to entry reuse.
-			 */
-			if (swapcache_prepare(entry)) {
-				/* Relax a bit to prevent rapid repeated page faults */
-				schedule_timeout_uninterruptible(1);
-				goto out;
-			}
-			need_clear_cache = true;
-
 			/* skip swapcache */
-			folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
-						vma, vmf->address, false);
+			folio = alloc_anon_folio(vmf, DO_SWAP_PAGE);
 			page = &folio->page;
 			if (folio) {
 				__folio_set_locked(folio);
 				__folio_set_swapbacked(folio);
 
+				if (folio_test_large(folio)) {
+					nr_pages = folio_nr_pages(folio);
+					entry.val = ALIGN_DOWN(entry.val, nr_pages);
+				}
+
+				/*
+				 * Prevent parallel swapin from proceeding with
+				 * the cache flag. Otherwise, another thread may
+				 * finish swapin first, free the entry, and swapout
+				 * reusing the same entry. It's undetectable as
+				 * pte_same() returns true due to entry reuse.
+				 */
+				if (swapcache_prepare_nr(entry, nr_pages)) {
+					/* Relax a bit to prevent rapid repeated page faults */
+					schedule_timeout_uninterruptible(1);
+					goto out;
+				}
+				need_clear_cache = true;
+
 				if (mem_cgroup_swapin_charge_folio(folio,
 							vma->vm_mm, GFP_KERNEL,
 							entry)) {
@@ -4185,6 +4245,42 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	 */
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 			&vmf->ptl);
+
+	start_address = vmf->address;
+	start_pte = vmf->pte;
+	if (folio_test_large(folio)) {
+		unsigned long nr = folio_nr_pages(folio);
+		unsigned long addr = ALIGN_DOWN(vmf->address, nr * PAGE_SIZE);
+		pte_t *aligned_pte = vmf->pte - (vmf->address - addr) / PAGE_SIZE;
+
+		/*
+		 * case 1: we are allocating large_folio, try to map it as a whole
+		 * iff the swap entries are still entirely mapped;
+		 * case 2: we hit a large folio in swapcache, and all swap entries
+		 * are still entirely mapped, try to map a large folio as a whole.
+		 * otherwise, map only the faulting page within the large folio
+		 * which is swapcache
+		 */
+		if (!is_pte_range_contig_swap(aligned_pte, nr)) {
+			if (nr_pages > 1) /* ptes have changed for case 1 */
+				goto out_nomap;
+			goto check_pte;
+		}
+
+		start_address = addr;
+		start_pte = aligned_pte;
+		/*
+		 * the below has been done before swap_read_folio()
+		 * for case 1
+		 */
+		if (unlikely(folio == swapcache)) {
+			nr_pages = nr;
+			entry.val = ALIGN_DOWN(entry.val, nr_pages);
+			page = &folio->page;
+		}
+	}
+
+check_pte:
 	if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
 		goto out_nomap;
 
@@ -4252,12 +4348,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	 * We're already holding a reference on the page but haven't mapped it
 	 * yet.
 	 */
-	swap_free(entry);
+	swap_nr_free(entry, nr_pages);
 	if (should_try_to_free_swap(folio, vma, vmf->flags))
 		folio_free_swap(folio);
 
-	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
-	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
+	folio_ref_add(folio, nr_pages - 1);
+	add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
+	add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
+
 	pte = mk_pte(page, vma->vm_page_prot);
 
 	/*
@@ -4267,14 +4365,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	 * exclusivity.
 	 */
 	if (!folio_test_ksm(folio) &&
-	    (exclusive || folio_ref_count(folio) == 1)) {
+	    (exclusive || folio_ref_count(folio) == nr_pages)) {
 		if (vmf->flags & FAULT_FLAG_WRITE) {
 			pte = maybe_mkwrite(pte_mkdirty(pte), vma);
 			vmf->flags &= ~FAULT_FLAG_WRITE;
 		}
 		rmap_flags |= RMAP_EXCLUSIVE;
 	}
-	flush_icache_page(vma, page);
+	flush_icache_pages(vma, page, nr_pages);
 	if (pte_swp_soft_dirty(vmf->orig_pte))
 		pte = pte_mksoft_dirty(pte);
 	if (pte_swp_uffd_wp(vmf->orig_pte))
@@ -4283,17 +4381,19 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 	/* ksm created a completely new copy */
 	if (unlikely(folio != swapcache && swapcache)) {
-		folio_add_new_anon_rmap(folio, vma, vmf->address);
+		folio_add_new_anon_rmap(folio, vma, start_address);
 		folio_add_lru_vma(folio, vma);
+	} else if (!folio_test_anon(folio)) {
+		folio_add_new_anon_rmap(folio, vma, start_address);
 	} else {
-		folio_add_anon_rmap_pte(folio, page, vma, vmf->address,
+		folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, start_address,
 					rmap_flags);
 	}
 
 	VM_BUG_ON(!folio_test_anon(folio) ||
 			(pte_write(pte) && !PageAnonExclusive(page)));
-	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
-	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
+	set_ptes(vma->vm_mm, start_address, start_pte, pte, nr_pages);
+	arch_do_swap_page(vma->vm_mm, vma, start_address, pte, vmf->orig_pte);
 
 	folio_unlock(folio);
 	if (folio != swapcache && swapcache) {
@@ -4310,6 +4410,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	}
 
 	if (vmf->flags & FAULT_FLAG_WRITE) {
+		if (nr_pages > 1)
+			vmf->orig_pte = ptep_get(vmf->pte);
+
 		ret |= do_wp_page(vmf);
 		if (ret & VM_FAULT_ERROR)
 			ret &= VM_FAULT_ERROR;
@@ -4317,14 +4420,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	}
 
 	/* No need to invalidate - it was non-present before */
-	update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
+	update_mmu_cache_range(vmf, vma, start_address, start_pte, nr_pages);
 unlock:
 	if (vmf->pte)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 out:
 	/* Clear the swap cache pin for direct swapin after PTL unlock */
 	if (need_clear_cache)
-		swapcache_clear(si, entry);
+		swapcache_clear_nr(si, entry, nr_pages);
 	if (si)
 		put_swap_device(si);
 	return ret;
@@ -4340,7 +4443,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		folio_put(swapcache);
 	}
 	if (need_clear_cache)
-		swapcache_clear(si, entry);
+		swapcache_clear_nr(si, entry, nr_pages);
 	if (si)
 		put_swap_device(si);
 	return ret;
@@ -4358,7 +4461,7 @@ static bool pte_range_none(pte_t *pte, int nr_pages)
 	return true;
 }
 
-static struct folio *alloc_anon_folio(struct vm_fault *vmf)
+static struct folio *alloc_anon_folio(struct vm_fault *vmf, enum behavior behavior)
 {
 	struct vm_area_struct *vma = vmf->vma;
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -4376,6 +4479,19 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 	if (unlikely(userfaultfd_armed(vma)))
 		goto fallback;
 
+	/*
+	 * a large folio being swapped-in could be partially in
+	 * zswap and partially in swap devices, zswap doesn't
+	 * support large folios yet, we might get corrupted
+	 * zero-filled data by reading all subpages from swap
+	 * devices while some of them are actually in zswap
+	 */
+	if (behavior == DO_SWAP_PAGE && is_zswap_enabled())
+		goto fallback;
+
+	if (unlikely(behavior != DO_ANON_PAGE && behavior != DO_SWAP_PAGE))
+		return ERR_PTR(-EINVAL);
+
 	/*
 	 * Get a list of all the (large) orders below PMD_ORDER that are enabled
 	 * for this vma. Then filter out the orders that can't be allocated over
@@ -4393,15 +4509,22 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 		return ERR_PTR(-EAGAIN);
 
 	/*
-	 * Find the highest order where the aligned range is completely
-	 * pte_none(). Note that all remaining orders will be completely
+	 * For do_anonymous_page, find the highest order where the aligned range is
+	 * completely pte_none(). Note that all remaining orders will be completely
 	 * pte_none().
+	 * For do_swap_page, find the highest order where the aligned range is
+	 * completely swap entries with contiguous swap offsets.
 	 */
 	order = highest_order(orders);
 	while (orders) {
 		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
-		if (pte_range_none(pte + pte_index(addr), 1 << order))
-			break;
+		if (behavior == DO_ANON_PAGE) {
+			if (pte_range_none(pte + pte_index(addr), 1 << order))
+				break;
+		} else  {
+			if (is_pte_range_contig_swap(pte + pte_index(addr), 1 << order))
+				break;
+		}
 		order = next_order(&orders, order);
 	}
 
@@ -4485,7 +4608,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	if (unlikely(anon_vma_prepare(vma)))
 		goto oom;
 	/* Returns NULL on OOM or ERR_PTR(-EAGAIN) if we must retry the fault */
-	folio = alloc_anon_folio(vmf);
+	folio = alloc_anon_folio(vmf, DO_ANON_PAGE);
 	if (IS_ERR(folio))
 		return 0;
 	if (!folio)
-- 
2.34.1


