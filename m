Return-Path: <linux-kernel+bounces-119752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECD088CCAA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A58E1F80AF4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F00B13D508;
	Tue, 26 Mar 2024 19:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ze0imY2Q"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD15013CC41
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479899; cv=none; b=JLerG1PkXn00n2IAxI12g0qSHkSr3sICF3HWw6ElorEyuN59xdOzthCp+Qb9KySCDOIN8nCyWqkrkdt+3GNm8FT+ZSwqy0mzSfnyiXdElCjpU7j61vM+rZ+jjsxmE1w15/X3RwLbO3os1yT7JHId1ASNtgnDKynfJDl/pHF5BJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479899; c=relaxed/simple;
	bh=LEqO9glT06R8lUGEzWv4WdTlSBATZXDH0+cOLd8idhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3gS+iLaMGxX3Mc115Z0j9Q+1nEMmKQ+8rCKzD45vJVErmwEJVBLvgJWkTBbGwMINH9U9K1l9GYUQ66Lc8/ewBYLneiURdSW6kaLfcxY28cGHffrXZ3uxYj/exj8/dXT6FDGXKxXeQ6qfi0Y4tNFdECIjUXsFhoPn3r6uVWRkBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ze0imY2Q; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso3546709a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711479897; x=1712084697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FiBJhEEfHQ3r2jOMm8KhSAJcpn1B/ejykzOxerrHt3Q=;
        b=Ze0imY2Q/BHWjZhJQ3mbCzX2D/U9N3wpxlaIBxCuRbYc+kysje6aIN3ceMuxiRf7uJ
         kRr/eI5Dk109pjEQnKVVCDxClus88hu1EQk/5589MS542z8WMAtoy3nrmYbcmf0mrb60
         tbkCMUq4vEEGEoY/grF1TWAnipkV0/TaylHNcy3h2rjTJdiebEuS76n/k8tRFQAYYovy
         U67zGYhjSbb6g5I9UM1kl38Nm+Y9m1vM767hvEgnXg2HaviobiufwJt3EkhidJyd08hv
         /FRYOyDHs1jrf2A4/L7FhN3jBZPcz2oRaWBud/fvC0dtgQZBI2v0T/Ebei+5ngmjpxKI
         0h5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711479897; x=1712084697;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FiBJhEEfHQ3r2jOMm8KhSAJcpn1B/ejykzOxerrHt3Q=;
        b=TFE9ag9RfWlaQGhWK6Nk1daSQ5EOx6s6+VW7t1SusAA1/EMU6odni28tHKfB5cA0Ie
         zwFd6huHvv4DNQ94p/0KDqAJ+OqB5mvKRctJL12nL3jKFXMN/BhGnF3OQkbhIcdmntxr
         DL4kMCJ0zQ69L3C2t+UNbb3i/ITyQo3hpbLOUCUxuKimwdSPyDFh3Z5Efa96mzj/hdfu
         9/U8N7Mg6ZxWhMlQmfNl6pT4MghxB3GNg5T9HkdKdn3a0uvhi2xqtNBqijXdQIEXoAmt
         KtPsqWKQ9ppUnJiE8e494pGtP+GNQoMVDauAbigfIRuWU2HMHGbVld5iVvzcwFSC7AiF
         Y75A==
X-Forwarded-Encrypted: i=1; AJvYcCVbootu81hlkiPrL6sAgbcl8YfIoJligXFVQlDEWwiEInz1YIq8oY7kcZlRvGIvGm7gqSlwfKOViHtCjoYJiKViCBJQQSWc5A3droQz
X-Gm-Message-State: AOJu0YwqAmiMKaaQR5Fe9hKht7aRU87Y9fo9F3Z9FsW7JP8o71kwZjwn
	yYoX/witnD9AF8EQw6fwkW1/KdAvwuUKn/+umOipSIre9s5szV2s
X-Google-Smtp-Source: AGHT+IFAystA0TApX/vqWOxEy6ce1dqGKGk+EmA27apR47RybsEuxh6FntAjcGODdXvlJspRq1GUwA==
X-Received: by 2002:a05:6a21:3512:b0:1a3:df1a:271e with SMTP id zc18-20020a056a21351200b001a3df1a271emr752917pzb.19.1711479896808;
        Tue, 26 Mar 2024 12:04:56 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([115.171.40.106])
        by smtp.gmail.com with ESMTPSA id j14-20020aa783ce000000b006ea790c2232sm6298350pfn.79.2024.03.26.12.04.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Mar 2024 12:04:56 -0700 (PDT)
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
Subject: [RFC PATCH 09/10] mm/swap: delay the swap cache lookup for swapin
Date: Wed, 27 Mar 2024 02:50:31 +0800
Message-ID: <20240326185032.72159-10-ryncsn@gmail.com>
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

From: Kairui Song <ryncsn@gmail.com>

Currently we do a swap cache lookup first, then call into the ordinary
swapin path. But all swapin path will call swap_cache_add_or_get,
which will do a swap cache lookup again on race, because the first
lookup is racy and could miss the swap cache.

If the race happened (could be frequent on busy device), caller have no
way of knowing that, not be able to distinguish minor / major fault,
and the first lookup is redundant.

So try to do swapcache lookup and readahead update late, defer it to
swap_cache_alloc_or_get, and make it faster by avoiding lookup if
HAS_CACHE flag is not set. This will be less accurate but the
later look up will always ensure we never miss a existing swap cache.
This provides 100% accuracy swap cache usage info for callers,
improve minor / major page fault info, and also improve performance.

Test result of sequential swapin/out of 30G zero page on ZRAM:

               Before (us)        After (us)
Swapout:       33827215           33853883
Swapin:        39466754           38336519 (+2.9%)
Swapout (THP): 6917709            6814619
Swapin (THP) : 39566916           38383367 (+3.0%)

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/memory.c     |  45 ++++++++----------
 mm/shmem.c      |  39 +++++++---------
 mm/swap.h       |  16 +++++--
 mm/swap_state.c | 122 +++++++++++++++++++++++++++++-------------------
 mm/swapfile.c   |  32 +++++++------
 5 files changed, 141 insertions(+), 113 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 357d239ee2f6..774a912eb46d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3932,6 +3932,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	struct page *page;
 	struct swap_info_struct *si = NULL;
 	rmap_t rmap_flags = RMAP_NONE;
+	bool folio_allocated = false;
 	bool exclusive = false;
 	swp_entry_t entry;
 	pte_t pte;
@@ -3991,35 +3992,29 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (unlikely(!si))
 		goto out;
 
-	folio = swap_cache_get_folio(entry, vma, vmf->address);
-	if (folio)
-		page = folio_file_page(folio, swp_offset(entry));
-	swapcache = folio;
+	if (data_race(si->flags & SWP_SYNCHRONOUS_IO) && __swap_count(entry) == 1) {
+		folio = swapin_direct(entry, GFP_HIGHUSER_MOVABLE, vmf, &folio_allocated);
+	} else {
+		folio = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE, vmf, &folio_allocated);
+	}
 
 	if (!folio) {
-		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
-		    __swap_count(entry) == 1) {
-			folio = swapin_direct(entry, GFP_HIGHUSER_MOVABLE, vmf);
-		} else {
-			folio = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE, vmf);
-		}
-
-		if (!folio) {
-			/*
-			 * Back out if somebody else faulted in this pte
-			 * while we released the pte lock.
-			 */
-			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
-					vmf->address, &vmf->ptl);
-			if (likely(vmf->pte &&
-				   pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
-				ret = VM_FAULT_OOM;
-			goto unlock;
-		}
+		/*
+		 * Back out if somebody else faulted in this pte
+		 * while we released the pte lock.
+		 */
+		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
+				vmf->address, &vmf->ptl);
+		if (likely(vmf->pte &&
+			   pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
+			ret = VM_FAULT_OOM;
+		goto unlock;
+	}
 
-		swapcache = folio;
-		page = folio_file_page(folio, swp_offset(entry));
+	swapcache = folio;
+	page = folio_file_page(folio, swp_offset(entry));
 
+	if (folio_allocated) {
 		/* Had to read the page from swap area: Major fault */
 		ret = VM_FAULT_MAJOR;
 		count_vm_event(PGMAJFAULT);
diff --git a/mm/shmem.c b/mm/shmem.c
index 51e4593f9e2e..7884bbe28731 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1570,20 +1570,6 @@ static inline struct mempolicy *shmem_get_sbmpol(struct shmem_sb_info *sbinfo)
 static struct mempolicy *shmem_get_pgoff_policy(struct shmem_inode_info *info,
 			pgoff_t index, unsigned int order, pgoff_t *ilx);
 
-static struct folio *shmem_swapin_cluster(swp_entry_t swap, gfp_t gfp,
-			struct shmem_inode_info *info, pgoff_t index)
-{
-	struct mempolicy *mpol;
-	pgoff_t ilx;
-	struct folio *folio;
-
-	mpol = shmem_get_pgoff_policy(info, index, 0, &ilx);
-	folio = swap_cluster_readahead(swap, gfp, mpol, ilx);
-	mpol_cond_put(mpol);
-
-	return folio;
-}
-
 /*
  * Make sure huge_gfp is always more limited than limit_gfp.
  * Some of the flags set permissions, while others set limitations.
@@ -1857,9 +1843,12 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct shmem_inode_info *info = SHMEM_I(inode);
+	bool folio_allocated = false;
 	struct swap_info_struct *si;
 	struct folio *folio = NULL;
+	struct mempolicy *mpol;
 	swp_entry_t swap;
+	pgoff_t ilx;
 	int error;
 
 	VM_BUG_ON(!*foliop || !xa_is_value(*foliop));
@@ -1878,22 +1867,28 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	}
 
 	/* Look it up and read it in.. */
-	folio = swap_cache_get_folio(swap, NULL, 0);
+	folio = swap_cache_try_get(swap);
 	if (!folio) {
-		/* Or update major stats only when swapin succeeds?? */
-		if (fault_type) {
-			*fault_type |= VM_FAULT_MAJOR;
-			count_vm_event(PGMAJFAULT);
-			count_memcg_event_mm(fault_mm, PGMAJFAULT);
-		}
 		/* Here we actually start the io */
-		folio = shmem_swapin_cluster(swap, gfp, info, index);
+		mpol = shmem_get_pgoff_policy(info, index, 0, &ilx);
+		folio = swap_cluster_readahead(swap, gfp, mpol, ilx, &folio_allocated);
+		mpol_cond_put(mpol);
 		if (!folio) {
 			error = -ENOMEM;
 			goto failed;
 		}
+
+		/* Update major stats only when swapin succeeds */
+		if (folio_allocated && fault_type) {
+			*fault_type |= VM_FAULT_MAJOR;
+			count_vm_event(PGMAJFAULT);
+			count_memcg_event_mm(fault_mm, PGMAJFAULT);
+		}
 	}
 
+	if (!folio_allocated)
+		swap_cache_update_ra(folio, NULL, 0);
+
 	/* We have to do this with folio locked to prevent races */
 	folio_lock(folio);
 	if (!folio_test_swapcache(folio) ||
diff --git a/mm/swap.h b/mm/swap.h
index be2d1642b5d9..bd872b157950 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -39,7 +39,8 @@ void __delete_from_swap_cache(struct folio *folio,
 void delete_from_swap_cache(struct folio *folio);
 void clear_shadow_from_swap_cache(swp_entry_t entry);
 int swap_cache_add_wait(struct folio *folio, swp_entry_t entry, gfp_t gfp);
-struct folio *swap_cache_get_folio(swp_entry_t entry,
+struct folio *swap_cache_try_get(swp_entry_t entry);
+void swap_cache_update_ra(struct folio *folio,
 		struct vm_area_struct *vma, unsigned long addr);
 struct folio *filemap_get_incore_folio(struct address_space *mapping,
 		pgoff_t index);
@@ -49,16 +50,18 @@ struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 struct folio *swap_cache_alloc_or_get(swp_entry_t entry, gfp_t gfp_flags,
 		struct mempolicy *mpol, pgoff_t ilx, bool *folio_allocated);
 struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
-		struct mempolicy *mpol, pgoff_t ilx);
+		struct mempolicy *mpol, pgoff_t ilx, bool *folio_allocated);
 struct folio *swapin_direct(swp_entry_t entry, gfp_t flag,
-			    struct vm_fault *vmf);
+			    struct vm_fault *vmf, bool *folio_allocated);
 struct folio *swapin_readahead(swp_entry_t entry, gfp_t flag,
-			      struct vm_fault *vmf);
+			      struct vm_fault *vmf, bool *folio_allocated);
 
 static inline unsigned int folio_swap_flags(struct folio *folio)
 {
 	return swp_swap_info(folio->swap)->flags;
 }
+
+bool __swap_has_cache(swp_entry_t entry);
 #else /* CONFIG_SWAP */
 struct swap_iocb;
 static inline void swap_read_folio(struct folio *folio, bool do_poll,
@@ -151,5 +154,10 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
 {
 	return 0;
 }
+
+static inline bool __swap_has_cache(swp_entry_t entry);
+{
+	return false;
+}
 #endif /* CONFIG_SWAP */
 #endif /* _MM_SWAP_H */
diff --git a/mm/swap_state.c b/mm/swap_state.c
index b5ea13295e17..cf178dd1131a 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -300,54 +300,54 @@ static inline bool swap_use_vma_readahead(void)
 }
 
 /*
- * Lookup a swap entry in the swap cache. A found folio will be returned
- * unlocked and with its refcount incremented - we rely on the kernel
- * lock getting page table operations atomic even if we drop the folio
- * lock before returning.
- *
- * Caller must lock the swap device or hold a reference to keep it valid.
+ * Try get the swap cache, bail out quickly if swapcache bit is not set.
  */
-struct folio *swap_cache_get_folio(swp_entry_t entry,
-		struct vm_area_struct *vma, unsigned long addr)
+struct folio *swap_cache_try_get(swp_entry_t entry)
 {
 	struct folio *folio;
 
-	folio = filemap_get_folio(swap_address_space(entry), swp_offset(entry));
-	if (!IS_ERR(folio)) {
-		bool vma_ra = swap_use_vma_readahead();
-		bool readahead;
-
-		/*
-		 * At the moment, we don't support PG_readahead for anon THP
-		 * so let's bail out rather than confusing the readahead stat.
-		 */
-		if (unlikely(folio_test_large(folio)))
+	if (__swap_has_cache(entry)) {
+		folio = filemap_get_folio(swap_address_space(entry),
+				swp_offset(entry));
+		if (!IS_ERR(folio))
 			return folio;
+	}
 
-		readahead = folio_test_clear_readahead(folio);
-		if (vma && vma_ra) {
-			unsigned long ra_val;
-			int win, hits;
-
-			ra_val = GET_SWAP_RA_VAL(vma);
-			win = SWAP_RA_WIN(ra_val);
-			hits = SWAP_RA_HITS(ra_val);
-			if (readahead)
-				hits = min_t(int, hits + 1, SWAP_RA_HITS_MAX);
-			atomic_long_set(&vma->swap_readahead_info,
-					SWAP_RA_VAL(addr, win, hits));
-		}
+	return NULL;
+}
 
-		if (readahead) {
-			count_vm_event(SWAP_RA_HIT);
-			if (!vma || !vma_ra)
-				atomic_inc(&swapin_readahead_hits);
-		}
-	} else {
-		folio = NULL;
+void swap_cache_update_ra(struct folio *folio, struct vm_area_struct *vma,
+			  unsigned long addr)
+{
+	bool vma_ra = swap_use_vma_readahead();
+	bool readahead;
+
+	/*
+	 * At the moment, we don't support PG_readahead for anon THP
+	 * so let's bail out rather than confusing the readahead stat.
+	 */
+	if (unlikely(folio_test_large(folio)))
+		return;
+
+	readahead = folio_test_clear_readahead(folio);
+	if (vma && vma_ra) {
+		unsigned long ra_val;
+		int win, hits;
+
+		ra_val = GET_SWAP_RA_VAL(vma);
+		win = SWAP_RA_WIN(ra_val);
+		hits = SWAP_RA_HITS(ra_val);
+		if (readahead)
+			hits = min_t(int, hits + 1, SWAP_RA_HITS_MAX);
+		atomic_long_set(&vma->swap_readahead_info,
+				SWAP_RA_VAL(addr, win, hits));
 	}
 
-	return folio;
+	if (readahead) {
+		count_vm_event(SWAP_RA_HIT);
+		if (!vma || !vma_ra)
+			atomic_inc(&swapin_readahead_hits);
+	}
 }
 
 /**
@@ -485,6 +485,11 @@ struct folio *swap_cache_alloc_or_get(swp_entry_t entry, gfp_t gfp_mask,
 	if (!si)
 		goto out_no_device;
 
+	/* First do a racy check if cache is already loaded. */
+	swapcache = swap_cache_try_get(entry);
+	if (swapcache)
+		goto out_no_alloc;
+
 	/* We are very likely the first user, alloc and try add to the swapcache. */
 	folio = (struct folio *)alloc_pages_mpol(gfp_mask, 0, mpol, ilx,
 						 numa_node_id());
@@ -614,7 +619,8 @@ static unsigned long swapin_nr_pages(unsigned long offset)
  * are fairly likely to have been swapped out from the same node.
  */
 struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
-				    struct mempolicy *mpol, pgoff_t ilx)
+				     struct mempolicy *mpol, pgoff_t ilx,
+				     bool *folio_allocated)
 {
 	struct folio *folio;
 	unsigned long entry_offset = swp_offset(entry);
@@ -644,6 +650,10 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 		folio = swap_cache_alloc_or_get(
 				swp_entry(swp_type(entry), offset),
 				gfp_mask, mpol, ilx, &page_allocated);
+		if (offset == entry_offset) {
+			*folio_allocated = page_allocated;
+			folio_allocated = NULL;
+		}
 		if (!folio)
 			continue;
 		if (page_allocated) {
@@ -666,6 +676,8 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 		zswap_folio_swapin(folio);
 		swap_read_folio(folio, false, NULL);
 	}
+	if (folio_allocated)
+		*folio_allocated = page_allocated;
 	return folio;
 }
 
@@ -779,7 +791,8 @@ static void swap_ra_info(struct vm_fault *vmf,
  *
  */
 static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
-		struct mempolicy *mpol, pgoff_t targ_ilx, struct vm_fault *vmf)
+					struct mempolicy *mpol, pgoff_t targ_ilx,
+					struct vm_fault *vmf, bool *folio_allocated)
 {
 	struct blk_plug plug;
 	struct swap_iocb *splug = NULL;
@@ -818,6 +831,10 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 		pte = NULL;
 		folio = swap_cache_alloc_or_get(entry, gfp_mask, mpol, ilx,
 						&page_allocated);
+		if (i == ra_info.offset) {
+			*folio_allocated = page_allocated;
+			folio_allocated = NULL;
+		}
 		if (!folio)
 			continue;
 		if (page_allocated) {
@@ -842,6 +859,8 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 		zswap_folio_swapin(folio);
 		swap_read_folio(folio, false, NULL);
 	}
+	if (folio_allocated)
+		*folio_allocated = page_allocated;
 	return folio;
 }
 
@@ -854,20 +873,21 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
  * Returns the folio for entry after it is read in.
  */
 struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
-			    struct vm_fault *vmf)
+			    struct vm_fault *vmf, bool *folio_allocated)
 {
 	struct mempolicy *mpol;
 	struct folio *folio;
-	bool page_allocated;
 	pgoff_t ilx;
 
 	mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
 	folio = swap_cache_alloc_or_get(entry, gfp_mask, mpol, ilx,
-					&page_allocated);
+					folio_allocated);
 	mpol_cond_put(mpol);
 
-	if (page_allocated)
+	if (*folio_allocated)
 		swap_read_folio(folio, true, NULL);
+	else if (folio)
+		swap_cache_update_ra(folio, vmf->vma, vmf->address);
 
 	return folio;
 }
@@ -885,18 +905,22 @@ struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
  * or vma-based(ie, virtual address based on faulty address) readahead.
  */
 struct folio *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
-				struct vm_fault *vmf)
+			       struct vm_fault *vmf, bool *folio_allocated)
 {
 	struct mempolicy *mpol;
-	pgoff_t ilx;
 	struct folio *folio;
+	bool allocated;
+	pgoff_t ilx;
 
 	mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
 	folio = swap_use_vma_readahead() ?
-		swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf) :
-		swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
+		swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf, &allocated) :
+		swap_cluster_readahead(entry, gfp_mask, mpol, ilx, &allocated);
 	mpol_cond_put(mpol);
 
+	if (!*folio_allocated && folio)
+		swap_cache_update_ra(folio, vmf->vma, vmf->address);
+
 	return folio;
 }
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 8225091d42b6..ddcf2ff91c39 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1455,6 +1455,15 @@ int __swap_count(swp_entry_t entry)
 	return swap_count(si->swap_map[offset]);
 }
 
+bool __swap_has_cache(swp_entry_t entry)
+{
+	pgoff_t offset = swp_offset(entry);
+	struct swap_info_struct *si = swp_swap_info(entry);
+	unsigned char count = READ_ONCE(si->swap_map[offset]);
+
+	return swap_count(count) && (count & SWAP_HAS_CACHE);
+}
+
 /*
  * How many references to @entry are currently swapped out?
  * This does not give an exact answer when swap count is continued,
@@ -1862,10 +1871,18 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		struct folio *folio;
 		unsigned long offset;
 		unsigned char swp_count;
+		bool folio_allocated;
 		swp_entry_t entry;
 		int ret;
 		pte_t ptent;
 
+		struct vm_fault vmf = {
+			.vma = vma,
+			.address = addr,
+			.real_address = addr,
+			.pmd = pmd,
+		};
+
 		if (!pte++) {
 			pte = pte_offset_map(pmd, addr);
 			if (!pte)
@@ -1884,19 +1901,8 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		offset = swp_offset(entry);
 		pte_unmap(pte);
 		pte = NULL;
-
-		folio = swap_cache_get_folio(entry, vma, addr);
-		if (!folio) {
-			struct vm_fault vmf = {
-				.vma = vma,
-				.address = addr,
-				.real_address = addr,
-				.pmd = pmd,
-			};
-
-			folio = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
-						&vmf);
-		}
+		folio = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
+				&vmf, &folio_allocated);
 		if (!folio) {
 			swp_count = READ_ONCE(si->swap_map[offset]);
 			if (swap_count(swp_count) == 0 || swp_count == SWAP_MAP_BAD)
-- 
2.43.0


