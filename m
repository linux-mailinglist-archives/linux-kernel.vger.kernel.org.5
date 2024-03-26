Return-Path: <linux-kernel+bounces-119746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B0D88CCA3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BEAE1F80BAD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CBB13C9D1;
	Tue, 26 Mar 2024 19:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzVWRiSP"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC6813CFB0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479876; cv=none; b=LLoPtUIcFNd857fTLiCEBke5S32D7fSOG0HDJMX29eGO/lIqoucpHXORn5ISGrEjXyQ0xzsEgLvO6HVCzyB17Lrb59PtUr2nulUGt922r4qiEYCr4tL0dH4udOPz1LVW/G605fRfYUgwtOfa2E8PLzWLkQ/a8OiUXju8vKuDvTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479876; c=relaxed/simple;
	bh=eyZTUAHh8OYDAQTYqNh8h4hZVIRE+gV03Q04b8TImjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oldYAw3H4Gj8qM63ajxY08VfG+0LTzykOoetUdMtS3v2KItxPFgzWBBROM3HAF86BCuC18rzfQymvr2wtNVeA0GBaGQqHxWp17ZEVYObGQ2T0Kv5KEk6qGwx+k1Y6sCEwnnRIRROqzdeYv4uS0K1/DoBd1yX/deXK3BuC/yVcsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzVWRiSP; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e6b5432439so4576833b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711479874; x=1712084674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AlnFQa5IuF1FU+kiw8JlfLUfSH7ltUVyYlgQl237ZM0=;
        b=fzVWRiSPHOleXdKyZUp8F/rVo5I12zVscicmOUR5AONpRolCHIV6+dZhe1IqUon9i5
         N2oe/gn5XtzZbpDXHOud4ni91nIN70lY3dxoocWFmYReSr8fXdHP+jNZtWDAwTkAEzQd
         KHZHLZE1GSRLXAaVMos2YkGvSmUm49wUeBoq9wdcHbb52on40IiLVrs/X6k4Bd8S8vHk
         r/4fOWYSw/plBz5s/vObAi4XBaa9UN23OQWCq1N2RCJ5YmnuCjEbbpJ18LuaV5DGZ9F7
         jKjo6fDYdQ4Pmd6k4ZrFKbAMykccF0wNrZbnxED5TnOWF11MdRxNn4t2JjBR+E8KuCaI
         o1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711479874; x=1712084674;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AlnFQa5IuF1FU+kiw8JlfLUfSH7ltUVyYlgQl237ZM0=;
        b=m+fqH1+QXrzNqESXCcV9daeeQZm6IuVI5i06dfan3JE32BREBU7SpWm/d7f9utaFw4
         fVWWrLJcbgohGkpZCFRDa9sfQJ9lFeqaDGmAwwVlaLEmv+Edj14xLP4VcHVY1XjqTJsA
         VlEAFp/bBsVy6ThrdsQPHllOC4u3bWDt0QD1jt2GapXyZbRBvG+WEcsMXenH+bKHwPEs
         IJVELHdLPzxnYt/h4usrJAInaPNw4wGITnEjnXaGRtkINeuO3rZnIxJaFHs2m/JI9GEJ
         jvoZd6Sd6AU8Qi7J3EhcrfRKPFsLsO3mCqJg1ujAlGFUNLto+owYvoNsY8y5n4AaquwQ
         1S0w==
X-Forwarded-Encrypted: i=1; AJvYcCV9iTRU0qO+r89AD1bHHEGIN7Uj7oRbj7nAvSHLwd3MW7afeI1kT79AKRwwMJPVJgNvUtgycoPKH3f/VG77G57DfiiahQEci7/7L7DE
X-Gm-Message-State: AOJu0Yz9uw0YuFxWEENEBL58O0MqionGKZwkCSnz2IQvd7lJAbzG+5DQ
	Oqu19CEK9ZYSBcog8WkrsNhK+79xPcQ1R6oe2FAMU5kj0q+KIMrmxG5VPQHt93uoVzZP
X-Google-Smtp-Source: AGHT+IG6+WnJXSjAIBqkKDWHn5ts/KmlVMWEdeN8j0WCY8uGY9blEEX6n3YjmXe+budCoU47FIqAOg==
X-Received: by 2002:a05:6a00:3d49:b0:6e8:f8a9:490e with SMTP id lp9-20020a056a003d4900b006e8f8a9490emr2484291pfb.5.1711479874359;
        Tue, 26 Mar 2024 12:04:34 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([115.171.40.106])
        by smtp.gmail.com with ESMTPSA id j14-20020aa783ce000000b006ea790c2232sm6298350pfn.79.2024.03.26.12.04.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Mar 2024 12:04:33 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: "Huang, Ying" <ying.huang@intel.com>,
	Chris Li <chrisl@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yu Zhao <yuzhao@google.com>,
	SeongJae Park <sj@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [RFC PATCH 04/10] mm/swap: remove cache bypass swapin
Date: Wed, 27 Mar 2024 02:50:26 +0800
Message-ID: <20240326185032.72159-5-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326185032.72159-1-ryncsn@gmail.com>
References: <20240326185032.72159-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

We used to have the cache bypass swapin path for better performance,
but by removing it, more optimization can be applied and have
an even better overall performance and less hackish.

And these optimizations are not easily doable or not doable at all
without this.

This patch simply removes it, and the performance will drop heavily
for simple swapin, things won't get this worse for real workloads
but still observable. Following commits will fix this and archive a
better performance.

Swapout/in 30G zero pages from ZRAM (This mostly measures overhead
of swap path itself, because zero pages are not compressed but simply
recorded in ZRAM, and performance drops more as SWAP device is getting
full):

Test result of sequential swapin/out:

               Before (us)        After (us)
Swapout:       33619409           33624641
Swapin:        32393771           41614858 (-28.4%)
Swapout (THP): 7817909            7795530
Swapin (THP) : 32452387           41708471 (-28.4%)

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/memory.c     | 18 ++++-------------
 mm/swap.h       | 10 +++++-----
 mm/swap_state.c | 53 ++++++++++---------------------------------------
 mm/swapfile.c   | 13 ------------
 4 files changed, 19 insertions(+), 75 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index dfdb620a9123..357d239ee2f6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3932,7 +3932,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	struct page *page;
 	struct swap_info_struct *si = NULL;
 	rmap_t rmap_flags = RMAP_NONE;
-	bool need_clear_cache = false;
 	bool exclusive = false;
 	swp_entry_t entry;
 	pte_t pte;
@@ -4000,14 +3999,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (!folio) {
 		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
 		    __swap_count(entry) == 1) {
-			/* skip swapcache and readahead */
 			folio = swapin_direct(entry, GFP_HIGHUSER_MOVABLE, vmf);
-			if (PTR_ERR(folio) == -EBUSY)
-				goto out;
-			need_clear_cache = true;
 		} else {
 			folio = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE, vmf);
-			swapcache = folio;
 		}
 
 		if (!folio) {
@@ -4023,6 +4017,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			goto unlock;
 		}
 
+		swapcache = folio;
 		page = folio_file_page(folio, swp_offset(entry));
 
 		/* Had to read the page from swap area: Major fault */
@@ -4187,7 +4182,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	vmf->orig_pte = pte;
 
 	/* ksm created a completely new copy */
-	if (unlikely(folio != swapcache && swapcache)) {
+	if (unlikely(folio != swapcache)) {
 		folio_add_new_anon_rmap(folio, vma, vmf->address);
 		folio_add_lru_vma(folio, vma);
 	} else {
@@ -4201,7 +4196,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
 
 	folio_unlock(folio);
-	if (folio != swapcache && swapcache) {
+	if (folio != swapcache) {
 		/*
 		 * Hold the lock to avoid the swap entry to be reused
 		 * until we take the PT lock for the pte_same() check
@@ -4227,9 +4222,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (vmf->pte)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 out:
-	/* Clear the swap cache pin for direct swapin after PTL unlock */
-	if (need_clear_cache)
-		swapcache_clear(si, entry);
 	if (si)
 		put_swap_device(si);
 	return ret;
@@ -4240,12 +4232,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	folio_unlock(folio);
 out_release:
 	folio_put(folio);
-	if (folio != swapcache && swapcache) {
+	if (folio != swapcache) {
 		folio_unlock(swapcache);
 		folio_put(swapcache);
 	}
-	if (need_clear_cache)
-		swapcache_clear(si, entry);
 	if (si)
 		put_swap_device(si);
 	return ret;
diff --git a/mm/swap.h b/mm/swap.h
index aee134907a70..ac9573b03432 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -41,7 +41,6 @@ void __delete_from_swap_cache(struct folio *folio,
 void delete_from_swap_cache(struct folio *folio);
 void clear_shadow_from_swap_cache(int type, unsigned long begin,
 				  unsigned long end);
-void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry);
 struct folio *swap_cache_get_folio(swp_entry_t entry,
 		struct vm_area_struct *vma, unsigned long addr);
 struct folio *filemap_get_incore_folio(struct address_space *mapping,
@@ -100,14 +99,15 @@ static inline struct folio *swapin_readahead(swp_entry_t swp, gfp_t gfp_mask,
 {
 	return NULL;
 }
-
-static inline int swap_writepage(struct page *p, struct writeback_control *wbc)
+static inline struct folio *swapin_direct(swp_entry_t entry, gfp_t flag,
+			struct vm_fault *vmf);
 {
-	return 0;
+	return NULL;
 }
 
-static inline void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
+static inline int swap_writepage(struct page *p, struct writeback_control *wbc)
 {
+	return 0;
 }
 
 static inline struct folio *swap_cache_get_folio(swp_entry_t entry,
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 2a9c6bdff5ea..49ef6250f676 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -880,61 +880,28 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 }
 
 /**
- * swapin_direct - swap in folios skipping swap cache and readahead
+ * swapin_direct - swap in folios skipping readahead
  * @entry: swap entry of this memory
  * @gfp_mask: memory allocation flags
  * @vmf: fault information
  *
- * Returns the struct folio for entry and addr after the swap entry is read
- * in.
+ * Returns the folio for entry after it is read in.
  */
 struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
 			    struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct mempolicy *mpol;
 	struct folio *folio;
-	void *shadow = NULL;
-
-	/*
-	 * Prevent parallel swapin from proceeding with
-	 * the cache flag. Otherwise, another thread may
-	 * finish swapin first, free the entry, and swapout
-	 * reusing the same entry. It's undetectable as
-	 * pte_same() returns true due to entry reuse.
-	 */
-	if (swapcache_prepare(entry)) {
-		/* Relax a bit to prevent rapid repeated page faults */
-		schedule_timeout_uninterruptible(1);
-		return ERR_PTR(-EBUSY);
-	}
-
-	/* skip swapcache */
-	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
-				vma, vmf->address, false);
-	if (folio) {
-		__folio_set_locked(folio);
-		__folio_set_swapbacked(folio);
-
-		if (mem_cgroup_swapin_charge_folio(folio,
-					vma->vm_mm, GFP_KERNEL,
-					entry)) {
-			folio_unlock(folio);
-			folio_put(folio);
-			return NULL;
-		}
-		mem_cgroup_swapin_uncharge_swap(entry);
-
-		shadow = get_shadow_from_swap_cache(entry);
-		if (shadow)
-			workingset_refault(folio, shadow);
+	bool page_allocated;
+	pgoff_t ilx;
 
-		folio_add_lru(folio);
+	mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
+	folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
+					&page_allocated, false);
+	mpol_cond_put(mpol);
 
-		/* To provide entry to swap_read_folio() */
-		folio->swap = entry;
+	if (page_allocated)
 		swap_read_folio(folio, true, NULL);
-		folio->private = NULL;
-	}
 
 	return folio;
 }
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4dd894395a0f..ae8d3aa05df7 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3389,19 +3389,6 @@ int swapcache_prepare(swp_entry_t entry)
 	return __swap_duplicate(entry, SWAP_HAS_CACHE);
 }
 
-void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
-{
-	struct swap_cluster_info *ci;
-	unsigned long offset = swp_offset(entry);
-	unsigned char usage;
-
-	ci = lock_cluster_or_swap_info(si, offset);
-	usage = __swap_entry_free_locked(si, offset, SWAP_HAS_CACHE);
-	unlock_cluster_or_swap_info(si, ci);
-	if (!usage)
-		free_swap_slot(entry);
-}
-
 struct swap_info_struct *swp_swap_info(swp_entry_t entry)
 {
 	return swap_type_to_swap_info(swp_type(entry));
-- 
2.43.0


