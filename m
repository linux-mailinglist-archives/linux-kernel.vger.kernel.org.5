Return-Path: <linux-kernel+bounces-119753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C96D88CCAB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51CBF3053A1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CFB13D530;
	Tue, 26 Mar 2024 19:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Joeb5x+y"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350E613D514
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479904; cv=none; b=LijGsZQFTNnaiINlbA/HV/+8VZGR5l0l4GcH0/0BpVz2X19XLqUXI1749YJN914zUw7o/Le0xxQk86xPuc6niK6lNaMwL0wXbO4Txxu1qYM8YSCF7Riy4PVxdAaumw3FYopDIRbyDD4yVADYMXQJF3LF8k16jjdVhtGHdK1bpj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479904; c=relaxed/simple;
	bh=zup3Hox8pcGlMo1byKXDE2MR4LTc5jra6TlpSxEJ8Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWIV3/Eyjv1AZRYeu322kfr5zQVWSe+DMT2iZzy5Zeyy8IfLXw3WqkLEf60Mv+lyNXCVUXBCpMkOTTLQcek6SL8nJhA1IJrUiiJe3l+MROTpycxeMInkOzK5EWdYgkjbDAwtjKv6DX2cE/uUfpm5iZwVFU1TC6W9hH/LtVWO+sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Joeb5x+y; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cedfc32250so3765153a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711479901; x=1712084701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tWXkY/VwUtjvuoCiK/XtYUVIg6+3qA3wRWNZvOL3LW8=;
        b=Joeb5x+yynIhaelotZsvl1zNvO0MkM6cBhOo3EAN0wcvQa0NGJq5UJ/oXsT3IMKGAU
         QWtEdjvqrJXIjfw/sQYSD76n7QPi8mGKWHUvw9Nlbd+e2dcTsq+JRA7JezXj0J3D+PhQ
         S6ZG+ydIUdmimPEqVfOaUlIOe6P3ML3xFrfWAD6OF/5QkmRxnjhqm2klE2NCLVVa6cr1
         XIa8HpqbhXw+PjU93jorpRiGqoGcdTwIrlX+Rq5owVWSEpu4rxIWmW1xrupDupCKXexo
         k/rpKBm3InwcsH1Q9ufP6xFzIcxWLVXaqMjTsrwgZvFEULGw6vPcAaIU/CIs2pp5i18D
         K4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711479901; x=1712084701;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tWXkY/VwUtjvuoCiK/XtYUVIg6+3qA3wRWNZvOL3LW8=;
        b=i6cXgWFFq/JojUnTYSdW4/4iYxE6VXNXp4cUKAbx3O3h/NfH7vmyuL//Jym3Ms4fb3
         acP/E9TAhUYC/U9MuJfNJb0z0uwLczweqSPWsjofRvMLcVkFTEdzEuflZIiHBWoaTQP3
         o8MX6nJLFWiQAu2tJVNr3C7BnB+jN0CM4J4B8LTqksW2rSRttHXOUXJiEbzbVWyBLG63
         /eJ6Wb8angnSxkktFK2RtlxvJaQAH4ZcsVZpjW9H/ctv+6Yi9okmcqjHzLKcMWxAcXnW
         is/XnBe23Z1qFRNqf/Eqy+EazmHJcaTitY3cBrMBZFYDJgLK30PWmoj5c7zZ63oIjKZd
         TDdg==
X-Forwarded-Encrypted: i=1; AJvYcCX+AkNTHbkkYUgV2waSVhZw2YJxF2M9XC6Xi1P5f1Cm4qOLyBh1mavjkPOaFvT9a5xvJHEPeWC+C7d+PBwwEz8Kyax6qqqMg13r+wHZ
X-Gm-Message-State: AOJu0Yy90eJ+IqwU3OplZ8eNXsKtbe9728pK48mZ4lmmJbsrlMQfDWvw
	diox6zpuJ52haUSFSwHqbZiSxWin3Y0i1ZKl4qxP799K4uVJAl7k
X-Google-Smtp-Source: AGHT+IH8mmais3geKY69O252RCFhbpsrIur2CeiaE4pHWZEEsNx+hS+y2YV8F+RXgoCHWzKftRyqmg==
X-Received: by 2002:a05:6a21:3284:b0:1a3:68ff:5805 with SMTP id yt4-20020a056a21328400b001a368ff5805mr599508pzb.44.1711479901200;
        Tue, 26 Mar 2024 12:05:01 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([115.171.40.106])
        by smtp.gmail.com with ESMTPSA id j14-20020aa783ce000000b006ea790c2232sm6298350pfn.79.2024.03.26.12.04.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Mar 2024 12:05:00 -0700 (PDT)
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
Subject: [RFC PATCH 10/10] mm/swap: optimize synchronous swapin
Date: Wed, 27 Mar 2024 02:50:32 +0800
Message-ID: <20240326185032.72159-11-ryncsn@gmail.com>
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

Interestingly the major performance overhead of synchronous is actually
from the workingset nodes update, that's because synchronous swap in
keeps adding single folios into a xa_node, making the node no longer
a shadow node and have to be removed from shadow_nodes, then remove
the folio very shortly and making the node a shadow node again,
so it has to add back to the shadow_nodes.

Mark synchronous swapin folio with a special bit in swap entry embedded
in folio->swap, as we still have some usable bits there. Skip workingset
node update on insertion of such folio because it will be removed very
quickly, and will trigger the update ensuring the workingset info is
eventual consensus.

Test result of sequential swapin/out of 30G zero page on ZRAM:

               Before (us)        After (us)
Swapout:       33853883           33886008
Swapin:        38336519           32465441 (+15.4%)
Swapout (THP): 6814619            6899938
Swapin (THP) : 38383367           33193479 (+13.6%)

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swapops.h |  5 +++-
 mm/filemap.c            | 16 +++++++++---
 mm/memory.c             | 34 ++++++++++++++----------
 mm/swap.h               | 15 +++++++++++
 mm/swap_state.c         | 57 ++++++++++++++++++++++++-----------------
 mm/vmscan.c             |  6 +++++
 mm/workingset.c         |  2 +-
 7 files changed, 92 insertions(+), 43 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 48b700ba1d18..ebc0c3e4668d 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -25,7 +25,10 @@
  * swp_entry_t's are *never* stored anywhere in their arch-dependent format.
  */
 #define SWP_TYPE_SHIFT	(BITS_PER_XA_VALUE - MAX_SWAPFILES_SHIFT)
-#define SWP_OFFSET_MASK	((1UL << SWP_TYPE_SHIFT) - 1)
+#define SWP_CACHE_FLAG_BITS	1
+#define SWP_CACHE_SYNCHRONOUS	BIT(SWP_TYPE_SHIFT - 1)
+#define SWP_OFFSET_BITS	(SWP_TYPE_SHIFT - SWP_CACHE_FLAG_BITS)
+#define SWP_OFFSET_MASK	(BIT(SWP_OFFSET_BITS) - 1)
 
 /*
  * Definitions only for PFN swap entries (see is_pfn_swap_entry()).  To
diff --git a/mm/filemap.c b/mm/filemap.c
index 5e8e3fd26b8d..ac24cc65d1da 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -923,12 +923,20 @@ int __filemap_add_swapcache(struct address_space *mapping, struct folio *folio,
 			    pgoff_t index, gfp_t gfp, void **shadowp)
 {
 	XA_STATE_ORDER(xas, &mapping->i_pages, index, folio_order(folio));
+	bool synchronous = swap_cache_test_synchronous(folio);
 	long nr;
 	int ret;
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(!folio_test_swapcache(folio), folio);
-	mapping_set_update(&xas, mapping);
+
+	/*
+	 * Skip node update for synchronous folio insertion, it will be
+	 * updated on folio deletion very soon, avoid repeated LRU locking.
+	 */
+	if (!synchronous)
+		xas_set_update(&xas, workingset_update_node);
+	xas_set_lru(&xas, &shadow_nodes);
 
 	nr = folio_nr_pages(folio);
 	folio_ref_add(folio, nr);
@@ -936,8 +944,10 @@ int __filemap_add_swapcache(struct address_space *mapping, struct folio *folio,
 	ret = __filemap_lock_store(&xas, folio, index, gfp, shadowp);
 	if (likely(!ret)) {
 		mapping->nrpages += nr;
-		__node_stat_mod_folio(folio, NR_FILE_PAGES, nr);
-		__lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr);
+		if (!synchronous) {
+			__node_stat_mod_folio(folio, NR_FILE_PAGES, nr);
+			__lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr);
+		}
 		xas_unlock_irq(&xas);
 	} else {
 		folio_put_refs(folio, nr);
diff --git a/mm/memory.c b/mm/memory.c
index 774a912eb46d..bb40202b4f29 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3933,6 +3933,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	struct swap_info_struct *si = NULL;
 	rmap_t rmap_flags = RMAP_NONE;
 	bool folio_allocated = false;
+	bool synchronous_io = false;
 	bool exclusive = false;
 	swp_entry_t entry;
 	pte_t pte;
@@ -4032,18 +4033,19 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (ret & VM_FAULT_RETRY)
 		goto out_release;
 
-	if (swapcache) {
-		/*
-		 * Make sure folio_free_swap() or swapoff did not release the
-		 * swapcache from under us.  The page pin, and pte_same test
-		 * below, are not enough to exclude that.  Even if it is still
-		 * swapcache, we need to check that the page's swap has not
-		 * changed.
-		 */
-		if (unlikely(!folio_test_swapcache(folio) ||
-			     page_swap_entry(page).val != entry.val))
-			goto out_page;
+	/*
+	 * Make sure folio_free_swap() or swapoff did not release the
+	 * swapcache from under us.  The page pin, and pte_same test
+	 * below, are not enough to exclude that.  Even if it is still
+	 * swapcache, we need to check that the page's swap has not
+	 * changed.
+	 */
+	if (unlikely(!folio_test_swapcache(folio) ||
+		     (page_swap_entry(page).val & ~SWP_CACHE_SYNCHRONOUS) != entry.val))
+		goto out_page;
 
+	synchronous_io = swap_cache_test_synchronous(folio);
+	if (!synchronous_io) {
 		/*
 		 * KSM sometimes has to copy on read faults, for example, if
 		 * page->index of !PageKSM() pages would be nonlinear inside the
@@ -4105,9 +4107,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	 */
 	if (!folio_test_ksm(folio)) {
 		exclusive = pte_swp_exclusive(vmf->orig_pte);
-		if (folio != swapcache) {
+		if (synchronous_io || folio != swapcache) {
 			/*
-			 * We have a fresh page that is not exposed to the
+			 * We have a fresh page that is not sharable through the
 			 * swapcache -> certainly exclusive.
 			 */
 			exclusive = true;
@@ -4148,7 +4150,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	 * yet.
 	 */
 	swap_free(entry);
-	if (should_try_to_free_swap(folio, vma, vmf->flags))
+	if (synchronous_io)
+		delete_from_swap_cache(folio);
+	else if (should_try_to_free_swap(folio, vma, vmf->flags))
 		folio_free_swap(folio);
 
 	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
@@ -4223,6 +4227,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 out_nomap:
 	if (vmf->pte)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
+	if (synchronous_io)
+		delete_from_swap_cache(folio);
 out_page:
 	folio_unlock(folio);
 out_release:
diff --git a/mm/swap.h b/mm/swap.h
index bd872b157950..9d106eebddbd 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -31,6 +31,21 @@ extern struct address_space *swapper_spaces[];
 	(&swapper_spaces[swp_type(entry)][swp_offset(entry) \
 		>> SWAP_ADDRESS_SPACE_SHIFT])
 
+static inline void swap_cache_mark_synchronous(struct folio *folio)
+{
+	folio->swap.val |= SWP_CACHE_SYNCHRONOUS;
+}
+
+static inline bool swap_cache_test_synchronous(struct folio *folio)
+{
+	return folio->swap.val & SWP_CACHE_SYNCHRONOUS;
+}
+
+static inline void swap_cache_clear_synchronous(struct folio *folio)
+{
+	folio->swap.val &= ~SWP_CACHE_SYNCHRONOUS;
+}
+
 void show_swap_cache_info(void);
 bool add_to_swap(struct folio *folio);
 void *get_shadow_from_swap_cache(swp_entry_t entry);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index cf178dd1131a..b0b1b5391ac1 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -86,7 +86,7 @@ void *get_shadow_from_swap_cache(swp_entry_t entry)
  * but sets SwapCache flag and private instead of mapping and index.
  */
 static int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
-			     gfp_t gfp, void **shadowp)
+			     gfp_t gfp, bool synchronous, void **shadowp)
 {
 	struct address_space *address_space = swap_address_space(entry);
 	pgoff_t idx = swp_offset(entry);
@@ -98,11 +98,12 @@ static int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
 
 	folio_set_swapcache(folio);
 	folio->swap = entry;
-
+	if (synchronous)
+		swap_cache_mark_synchronous(folio);
 	ret = __filemap_add_swapcache(address_space, folio, idx, gfp, shadowp);
 	if (ret) {
-		folio_clear_swapcache(folio);
 		folio->swap.val = 0;
+		folio_clear_swapcache(folio);
 	}
 
 	return ret;
@@ -129,11 +130,13 @@ void __delete_from_swap_cache(struct folio *folio,
 	xas_set_order(&xas, idx, folio_order(folio));
 	xas_store(&xas, shadow);
 
-	folio->swap.val = 0;
 	folio_clear_swapcache(folio);
 	address_space->nrpages -= nr;
-	__node_stat_mod_folio(folio, NR_FILE_PAGES, -nr);
-	__lruvec_stat_mod_folio(folio, NR_SWAPCACHE, -nr);
+	if (!swap_cache_test_synchronous(folio)) {
+		__node_stat_mod_folio(folio, NR_FILE_PAGES, -nr);
+		__lruvec_stat_mod_folio(folio, NR_SWAPCACHE, -nr);
+	}
+	folio->swap.val = 0;
 }
 
 /**
@@ -393,7 +396,7 @@ struct folio *filemap_get_incore_folio(struct address_space *mapping,
  * else or hitting OOM.
  */
 static struct folio *swap_cache_add_or_get(struct folio *folio,
-		swp_entry_t entry, gfp_t gfp_mask)
+		swp_entry_t entry, gfp_t gfp_mask, bool synchronous)
 {
 	int ret = 0;
 	void *shadow = NULL;
@@ -403,7 +406,7 @@ static struct folio *swap_cache_add_or_get(struct folio *folio,
 	if (folio) {
 		__folio_set_locked(folio);
 		__folio_set_swapbacked(folio);
-		ret = add_to_swap_cache(folio, entry, gfp_mask, &shadow);
+		ret = add_to_swap_cache(folio, entry, gfp_mask, synchronous, &shadow);
 		if (ret)
 			__folio_clear_locked(folio);
 	}
@@ -460,7 +463,7 @@ int swap_cache_add_wait(struct folio *folio, swp_entry_t entry, gfp_t gfp)
 	struct folio *wait_folio;
 
 	for (;;) {
-		ret = add_to_swap_cache(folio, entry, gfp, NULL);
+		ret = add_to_swap_cache(folio, entry, gfp, false, NULL);
 		if (ret != -EEXIST)
 			break;
 		wait_folio = filemap_get_folio(swap_address_space(entry),
@@ -493,7 +496,7 @@ struct folio *swap_cache_alloc_or_get(swp_entry_t entry, gfp_t gfp_mask,
 	/* We are very likely the first user, alloc and try add to the swapcache. */
 	folio = (struct folio *)alloc_pages_mpol(gfp_mask, 0, mpol, ilx,
 						 numa_node_id());
-	swapcache = swap_cache_add_or_get(folio, entry, gfp_mask);
+	swapcache = swap_cache_add_or_get(folio, entry, gfp_mask, false);
 	if (swapcache != folio) {
 		folio_put(folio);
 		goto out_no_alloc;
@@ -875,21 +878,27 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
 			    struct vm_fault *vmf, bool *folio_allocated)
 {
-	struct mempolicy *mpol;
-	struct folio *folio;
-	pgoff_t ilx;
-
-	mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
-	folio = swap_cache_alloc_or_get(entry, gfp_mask, mpol, ilx,
-					folio_allocated);
-	mpol_cond_put(mpol);
-
-	if (*folio_allocated)
+	struct folio *folio = NULL, *swapcache;
+	/* First do a racy check if cache is already loaded. */
+	swapcache = swap_cache_try_get(entry);
+	if (unlikely(swapcache))
+		goto out;
+	folio = vma_alloc_folio(gfp_mask, 0, vmf->vma, vmf->address, false);
+	swapcache = swap_cache_add_or_get(folio, entry, gfp_mask, true);
+	if (!swapcache)
+		goto out_nocache;
+	if (swapcache == folio) {
 		swap_read_folio(folio, true, NULL);
-	else if (folio)
-		swap_cache_update_ra(folio, vmf->vma, vmf->address);
-
-	return folio;
+		*folio_allocated = true;
+		return folio;
+	}
+out:
+	swap_cache_update_ra(swapcache, vmf->vma, vmf->address);
+out_nocache:
+	if (folio)
+		folio_put(folio);
+	*folio_allocated = false;
+	return swapcache;
 }
 
 /**
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c3db39393428..e71b049fee01 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1228,6 +1228,12 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 					if (!add_to_swap(folio))
 						goto activate_locked_split;
 				}
+			} else if (swap_cache_test_synchronous(folio)) {
+				/*
+				 * We see a folio being swapped in but not activated either
+				 * due to missing shadow or lived too short, active it.
+				 */
+				goto activate_locked;
 			}
 		} else if (folio_test_swapbacked(folio) &&
 			   folio_test_large(folio)) {
diff --git a/mm/workingset.c b/mm/workingset.c
index f2a0ecaf708d..83a0b409be0f 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -753,7 +753,7 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
 	 */
 	if (WARN_ON_ONCE(!node->nr_values))
 		goto out_invalid;
-	if (WARN_ON_ONCE(node->count != node->nr_values))
+	if (WARN_ON_ONCE(node->count != node->nr_values && mapping->host != NULL))
 		goto out_invalid;
 	xa_delete_node(node, workingset_update_node);
 	__inc_lruvec_kmem_state(node, WORKINGSET_NODERECLAIM);
-- 
2.43.0


