Return-Path: <linux-kernel+bounces-119751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7915788CCA8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA8C3430E8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D5F13CF84;
	Tue, 26 Mar 2024 19:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7xIR/58"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC0113D2A3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479895; cv=none; b=MxJw24gfwSCEQ53DTHJ9y6x23rSA/+GHC3NpweUQoNirjDFdbsh1l0AfdDIzDhpqwcbiUp00B6Lapm9Wl0XbpTdsik9Mt1R8CnSEAU749Sr2Wy7vUpv30Tdr3PVJKriaI1VbLxFiV6TFHb65GkrBghDKKGHNa2hVh1qXW5j6zpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479895; c=relaxed/simple;
	bh=f0zVv/g7JQMheKUGudEgr3gtKJTObnU/co0x7BzWjZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLZCUjamoKZuJY3szXzREsHjYnadG4cAscTx/3VWeVIPP13BmqaaMZWGGAR7j/kd5lSf+jXFaIGL+/92kJ5IXN0YStdqfBmTuRMxwHSp02BUhtKsuGAxm3O5opR6Xd0JaFVXgnKvsj+jtiAt5lqmE1b/Mph+xX9PHfymdFxqMc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7xIR/58; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5e152c757a5so3019939a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711479893; x=1712084693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eNwcqhEjkeWS6nrrKT5ddXoMcSlzEQZsZcHDot/JHBw=;
        b=O7xIR/58cuSNMZiCpqR9hvQO9+AJBV0rGxMx5oIMTr4+pL5qkQSC3VPUs5occZ+zE+
         6H1mxwe5X8tiZfqDKl6FrUbk8Z1oIIBVmVzX0vG6rv+W7g5t6S3r8DkbbQ0FXwz4wjvy
         uz39HZxsRkeqOROnV3ZLguulTrZn8uBLZU2x/6hdykTotHxImvSzMtnEW3xPHUIGpYi9
         69SRUxyTxxJccn/WP7JwMVCJLXc4x7AfvrDmigEPEwRFimEmSd/Tct9ikTOEVzLyBXdW
         ncxVF46LLLPikkEzgwsRLs4dDHHojK6GZuzlC7VkviHTbGCqj7SWsbiHaMRq4kReSQhR
         BS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711479893; x=1712084693;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eNwcqhEjkeWS6nrrKT5ddXoMcSlzEQZsZcHDot/JHBw=;
        b=GG4wupQXDPV5PYkCAusAXqFBJW+nJ9aCsdNQqvDgWEBEnKo5SYW2EAFOU2vNs5TN1K
         66w/DbxKpHi/BFHtWP3NmGWeZJjAQnqB5pkjJsq8/2TTvOXyX3xIVHhDsmE4yui+8Pdv
         0opySw95uEU6FI7JkJI9uSzA47CTjs3c0dhyOvG/0mZM8VSCFR5AjmMrjzoRwYkLBMIU
         a8NLcC/wTNPKBmhRkvyTFmTofypxCod88PUIQk+WdzINhgOqa7ZshmB6yKhIB3CSrz/s
         Ix9ztoa/1yE1nF0Tyys47xT3w2mS8IJsqydafblINBuxN8vY/Sw+9qXguEdC4kFHwvBr
         JJ0g==
X-Forwarded-Encrypted: i=1; AJvYcCVxAKeQ0GKe6M8F8/mci8fyD8vSmkf5ySG238+4WoiK7ZkMnY9szz7U94lonZrGPGLoM5/IwsEF88WHe9DtI2lxk2H/LoyaqEY27o/o
X-Gm-Message-State: AOJu0YxrgqRiAHLII3b8LzDHxO1K1jLR3H/TClKJR+sB28JHr3bCwPHf
	htKMf+MiPGxBCFFf+mfTZijyzFb12xXsTeu2LWQJkn76HkKt0K1r
X-Google-Smtp-Source: AGHT+IE1uRgBJe04k5mjQVIO8SkGfv0fgqgAL+aS6S8PniSAjL5L4mwgIBGMDQTd4YDhvGNyjqSaCQ==
X-Received: by 2002:a05:6a20:77a4:b0:1a3:6ed2:ee27 with SMTP id c36-20020a056a2077a400b001a36ed2ee27mr498166pzg.16.1711479892445;
        Tue, 26 Mar 2024 12:04:52 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([115.171.40.106])
        by smtp.gmail.com with ESMTPSA id j14-20020aa783ce000000b006ea790c2232sm6298350pfn.79.2024.03.26.12.04.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Mar 2024 12:04:51 -0700 (PDT)
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
Subject: [RFC PATCH 08/10] mm/swap: use swap cache as a synchronization layer
Date: Wed, 27 Mar 2024 02:50:30 +0800
Message-ID: <20240326185032.72159-9-ryncsn@gmail.com>
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

Rework how swapins are synchronized. Instead of spinning on the
swap map, simply use swap cache insert as the synchronization
point. Winner will insert a new locked folio, loser will just
get the locked folio and wait on unlock. This way we don't
need any extra mechanism and have a unified way to ensure all
swapin are race free.

Swap map is not removed, the HAS_CACHE bit is still set but updated with
a particular order and stay eventually consistent with xarray state
(it works fine with slot cache reservation), it will mostly be used
for fast cache state look up.

Two helpers now can be used to add a folio to swapcache:
- swap_cache_add_or_get for adding a folio with entry being used (swapin).
- swap_cache_add_wait for adding a folio with a freed entry (swapout).

swap_cache_add_or_get add a folio to swap cache, it return NULL if folio
is already swapped in or hitting OOM, it follows these steps:
1. Caller must ensure the folio is new allocated, this helper lock the
   folio.
2. Try to add the folio to Xarray (add_to_swap_cache).
3. If (2) success, try set SWAP_HAS_CACHE with swapcache_prepare. This
   step will now only fail if the entry is freed, which indicate
   the folio is swapped in by someone else, and if so, revert
   above steps and return NULL.
4. If (2) failed, try look up and return the locked folio. If a folio
   is returned, caller should try lock the folio and check if
   PG_swapcache is still set. If not, racer is hitting OOM or the
   folio is already swapped in, this can be tell easily (by checking
   page table for page table). Caller can bail out or retry conditionally.
5. If (4) failed to get a folio, the folio should have been swapped in
   by someone else, or racer is hitting OOM.

And swap_cache_add_wait is for adding a folio with a freed entry
to swap cache (for swapout path). Because swap_cache_add_or_get
will revert quickly if it accidentally added a folio with freed entry
to swapcache, so swap_cache_add_wait will simply wait on race.

To remove a folio from swap cache, one have to following these steps:
1. First start by acquiring folio lock.
2. Check if PG_swapcache is still set, if not, this folio is removed already.
3. Call put_swap_folio() to clear SWAP_HAS_CACHE flags in SWAP map first, do
   this before removing folio from Xarray to ensure insertions can
   successfully update SWAP map.
4. Remove folio from Xarray by __delete_from_swap_cache.
5. Clear folio flag PG_swapcache, unlock and put it.

Or just call delete_from_swap_cache after checking the folio is still
PG_swapcache set.

Note between step 3 and step 4, an entry may get loaded into swap slot
cache, but this is OK because swapout will uses swap_cache_add_wait which
wait for step 4.

By using swap cache as the synchronization for swapin/swapout, this help
removed a lot of hacks or fixes for the synchronization:

schedule_timeout_uninterruptible(1) introduced by (just wait on folio):
- commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcache")
- commit 029c4628b2eb ("mm: swap: get rid of livelock in swapin readahead")
skip_if_exist introduced by (now calls always return, it never waits inside):
- commit a65b0e7607cc ("zswap: make shrinking memcg-aware")
and the swapoff workaround by (swap map is now consistent with xarray,
and slot cache is disabled, so only need to check in swapoff now):
- commit ba81f8384254 ("mm/swap: skip readahead only when swap slot cache is enabled")

Test result of sequential swapin/out of 30G zero page on ZRAM:

               Before (us)        After (us)
Swapout:       33713283           33827215
Swapin:        40954646           39466754 (+3.7%)
Swapout (THP): 6921176            6917709
Swapin (THP) : 40891953           39566916 (+3.3%)

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/shmem.c      |   5 +-
 mm/swap.h       |  18 ++--
 mm/swap_state.c | 217 +++++++++++++++++++++++++-----------------------
 mm/swapfile.c   |  13 ++-
 mm/vmscan.c     |   2 +-
 mm/zswap.c      |   2 +-
 6 files changed, 132 insertions(+), 125 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 0aad0d9a621b..51e4593f9e2e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1512,9 +1512,8 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 	if (list_empty(&info->swaplist))
 		list_add(&info->swaplist, &shmem_swaplist);
 
-	if (add_to_swap_cache(folio, swap,
-			__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN,
-			NULL) == 0) {
+	if (!swap_cache_add_wait(folio, swap,
+				 __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN)) {
 		shmem_recalc_inode(inode, 0, 1);
 		swap_shmem_alloc(swap);
 		shmem_delete_from_page_cache(folio, swp_to_radix_entry(swap));
diff --git a/mm/swap.h b/mm/swap.h
index 5fbbc4a42787..be2d1642b5d9 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -34,23 +34,20 @@ extern struct address_space *swapper_spaces[];
 void show_swap_cache_info(void);
 bool add_to_swap(struct folio *folio);
 void *get_shadow_from_swap_cache(swp_entry_t entry);
-int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
-		      gfp_t gfp, void **shadowp);
 void __delete_from_swap_cache(struct folio *folio,
 			      swp_entry_t entry, void *shadow);
 void delete_from_swap_cache(struct folio *folio);
 void clear_shadow_from_swap_cache(swp_entry_t entry);
+int swap_cache_add_wait(struct folio *folio, swp_entry_t entry, gfp_t gfp);
 struct folio *swap_cache_get_folio(swp_entry_t entry,
 		struct vm_area_struct *vma, unsigned long addr);
 struct folio *filemap_get_incore_folio(struct address_space *mapping,
 		pgoff_t index);
-
 struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		struct vm_area_struct *vma, unsigned long addr,
 		struct swap_iocb **plug);
 struct folio *swap_cache_alloc_or_get(swp_entry_t entry, gfp_t gfp_flags,
-		struct mempolicy *mpol, pgoff_t ilx, bool *new_page_allocated,
-		bool skip_if_exists);
+		struct mempolicy *mpol, pgoff_t ilx, bool *folio_allocated);
 struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
 		struct mempolicy *mpol, pgoff_t ilx);
 struct folio *swapin_direct(swp_entry_t entry, gfp_t flag,
@@ -109,6 +106,11 @@ static inline int swap_writepage(struct page *p, struct writeback_control *wbc)
 	return 0;
 }
 
+static inline int swap_cache_add_wait(struct folio *folio, swp_entry_t entry, gfp_t gfp)
+{
+	return -1;
+}
+
 static inline struct folio *swap_cache_get_folio(swp_entry_t entry,
 		struct vm_area_struct *vma, unsigned long addr)
 {
@@ -132,12 +134,6 @@ static inline void *get_shadow_from_swap_cache(swp_entry_t entry)
 	return NULL;
 }
 
-static inline int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
-					gfp_t gfp_mask, void **shadowp)
-{
-	return -1;
-}
-
 static inline void __delete_from_swap_cache(struct folio *folio,
 					swp_entry_t entry, void *shadow)
 {
diff --git a/mm/swap_state.c b/mm/swap_state.c
index cd1a16afcd9f..b5ea13295e17 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -85,8 +85,8 @@ void *get_shadow_from_swap_cache(swp_entry_t entry)
  * add_to_swap_cache resembles filemap_add_folio on swapper_space,
  * but sets SwapCache flag and private instead of mapping and index.
  */
-int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
-			gfp_t gfp, void **shadowp)
+static int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
+			     gfp_t gfp, void **shadowp)
 {
 	struct address_space *address_space = swap_address_space(entry);
 	pgoff_t idx = swp_offset(entry);
@@ -169,14 +169,16 @@ bool add_to_swap(struct folio *folio)
 	/*
 	 * Add it to the swap cache.
 	 */
-	err = add_to_swap_cache(folio, entry,
-			__GFP_HIGH|__GFP_NOMEMALLOC|__GFP_NOWARN, NULL);
-	if (err)
+	err = swap_cache_add_wait(folio, entry,
+				  __GFP_HIGH|__GFP_NOMEMALLOC|__GFP_NOWARN);
+	if (err) {
 		/*
-		 * add_to_swap_cache() doesn't return -EEXIST, so we can safely
-		 * clear SWAP_HAS_CACHE flag.
+		 * swap_cache_add_wait() doesn't return -EEXIST, so we can
+		 * safely clear SWAP_HAS_CACHE flag.
 		 */
 		goto fail;
+	}
+
 	/*
 	 * Normally the folio will be dirtied in unmap because its
 	 * pte should be dirty. A special case is MADV_FREE page. The
@@ -208,11 +210,12 @@ void delete_from_swap_cache(struct folio *folio)
 	swp_entry_t entry = folio->swap;
 	struct address_space *address_space = swap_address_space(entry);
 
+	put_swap_folio(folio, entry);
+
 	xa_lock_irq(&address_space->i_pages);
 	__delete_from_swap_cache(folio, entry, NULL);
 	xa_unlock_irq(&address_space->i_pages);
 
-	put_swap_folio(folio, entry);
 	folio_ref_sub(folio, folio_nr_pages(folio));
 }
 
@@ -385,119 +388,123 @@ struct folio *filemap_get_incore_folio(struct address_space *mapping,
 	return folio;
 }
 
-struct folio *swap_cache_alloc_or_get(swp_entry_t entry, gfp_t gfp_mask,
-		struct mempolicy *mpol, pgoff_t ilx, bool *new_page_allocated,
-		bool skip_if_exists)
+/*
+ * Try add a new folio, return NULL if the entry is swapped in by someone
+ * else or hitting OOM.
+ */
+static struct folio *swap_cache_add_or_get(struct folio *folio,
+		swp_entry_t entry, gfp_t gfp_mask)
 {
-	struct swap_info_struct *si;
-	struct folio *folio;
+	int ret = 0;
 	void *shadow = NULL;
+	struct address_space *address_space = swap_address_space(entry);
 
-	*new_page_allocated = false;
-	si = get_swap_device(entry);
-	if (!si)
-		return NULL;
-
-	for (;;) {
-		int err;
-		/*
-		 * First check the swap cache.  Since this is normally
-		 * called after swap_cache_get_folio() failed, re-calling
-		 * that would confuse statistics.
-		 */
-		folio = filemap_get_folio(swap_address_space(entry),
-						swp_offset(entry));
-		if (!IS_ERR(folio))
-			goto got_folio;
-
-		/*
-		 * Just skip read ahead for unused swap slot.
-		 * During swap_off when swap_slot_cache is disabled,
-		 * we have to handle the race between putting
-		 * swap entry in swap cache and marking swap slot
-		 * as SWAP_HAS_CACHE.  That's done in later part of code or
-		 * else swap_off will be aborted if we return NULL.
-		 */
-		if (!swap_swapcount(si, entry) && swap_slot_cache_enabled)
-			goto fail_put_swap;
-
-		/*
-		 * Get a new folio to read into from swap.  Allocate it now,
-		 * before marking swap_map SWAP_HAS_CACHE, when -EEXIST will
-		 * cause any racers to loop around until we add it to cache.
-		 */
-		folio = (struct folio *)alloc_pages_mpol(gfp_mask, 0,
-						mpol, ilx, numa_node_id());
-		if (!folio)
-                        goto fail_put_swap;
-
-		/*
-		 * Swap entry may have been freed since our caller observed it.
-		 */
-		err = swapcache_prepare(entry);
-		if (!err)
-			break;
-
-		folio_put(folio);
-		if (err != -EEXIST)
-			goto fail_put_swap;
-
-		/*
-		 * Protect against a recursive call to swap_cache_alloc_or_get()
-		 * on the same entry waiting forever here because SWAP_HAS_CACHE
-		 * is set but the folio is not the swap cache yet. This can
-		 * happen today if mem_cgroup_swapin_charge_folio() below
-		 * triggers reclaim through zswap, which may call
-		 * swap_cache_alloc_or_get() in the writeback path.
-		 */
-		if (skip_if_exists)
-			goto fail_put_swap;
+	/* If folio is NULL, simply go lookup the swapcache */
+	if (folio) {
+		__folio_set_locked(folio);
+		__folio_set_swapbacked(folio);
+		ret = add_to_swap_cache(folio, entry, gfp_mask, &shadow);
+		if (ret)
+			__folio_clear_locked(folio);
+	}
 
-		/*
-		 * We might race against __delete_from_swap_cache(), and
-		 * stumble across a swap_map entry whose SWAP_HAS_CACHE
-		 * has not yet been cleared.  Or race against another
-		 * swap_cache_alloc_or_get(), which has set SWAP_HAS_CACHE
-		 * in swap_map, but not yet added its folio to swap cache.
-		 */
-		schedule_timeout_uninterruptible(1);
+	if (!folio || ret) {
+		/* If the folio is already added, return it untouched. */
+		folio = filemap_get_folio(address_space, swp_offset(entry));
+		/* If not, either the entry have been freed or we are OOM. */
+		if (IS_ERR(folio))
+			return NULL;
+		return folio;
 	}
 
 	/*
-	 * The swap entry is ours to swap in. Prepare the new folio.
+	 * The folio is now added to swap cache, try update the swap map
+	 * to ensure the entry is still valid. If we accidentally added
+	 * a stalled entry, undo the add.
 	 */
+	ret = swapcache_prepare(entry);
+	if (unlikely(ret))
+		goto fail_delete_cache;
 
-	__folio_set_locked(folio);
-	__folio_set_swapbacked(folio);
-
+	/* Charge and shadow check */
 	if (mem_cgroup_swapin_charge_folio(folio, NULL, gfp_mask, entry))
-		goto fail_unlock;
-
-	/* May fail (-ENOMEM) if XArray node allocation failed. */
-	if (add_to_swap_cache(folio, entry, gfp_mask & GFP_RECLAIM_MASK, &shadow))
-		goto fail_unlock;
-
+		goto fail_put_flag;
 	mem_cgroup_swapin_uncharge_swap(entry);
-
 	if (shadow)
 		workingset_refault(folio, shadow);
 
-	/* Caller will initiate read into locked folio */
+	/* Return new added folio locked */
 	folio_add_lru(folio);
-	*new_page_allocated = true;
-got_folio:
-	put_swap_device(si);
 	return folio;
 
-fail_unlock:
+fail_put_flag:
 	put_swap_folio(folio, entry);
+fail_delete_cache:
+	xa_lock_irq(&address_space->i_pages);
+	__delete_from_swap_cache(folio, entry, shadow);
+	xa_unlock_irq(&address_space->i_pages);
+	folio_ref_sub(folio, folio_nr_pages(folio));
 	folio_unlock(folio);
-	folio_put(folio);
-fail_put_swap:
-	put_swap_device(si);
+
 	return NULL;
 }
 
+/*
+ * Try to add a folio to swap cache, caller must ensure entry is freed.
+ * May block if swap_cache_alloc_or_get accidently loaded a freed entry
+ * and it will be removed very soon, so just wait and retry.
+ */
+int swap_cache_add_wait(struct folio *folio, swp_entry_t entry, gfp_t gfp)
+{
+	int ret;
+	struct folio *wait_folio;
+
+	for (;;) {
+		ret = add_to_swap_cache(folio, entry, gfp, NULL);
+		if (ret != -EEXIST)
+			break;
+		wait_folio = filemap_get_folio(swap_address_space(entry),
+				swp_offset(entry));
+		if (!IS_ERR(wait_folio)) {
+			folio_wait_locked(wait_folio);
+			folio_put(wait_folio);
+		}
+	}
+
+	return ret;
+}
+
+struct folio *swap_cache_alloc_or_get(swp_entry_t entry, gfp_t gfp_mask,
+		struct mempolicy *mpol, pgoff_t ilx, bool *folio_allocated)
+{
+	struct folio *folio, *swapcache = NULL;
+	struct swap_info_struct *si;
+
+	/* Prevent swapoff from happening to us */
+	si = get_swap_device(entry);
+	if (!si)
+		goto out_no_device;
+
+	/* We are very likely the first user, alloc and try add to the swapcache. */
+	folio = (struct folio *)alloc_pages_mpol(gfp_mask, 0, mpol, ilx,
+						 numa_node_id());
+	swapcache = swap_cache_add_or_get(folio, entry, gfp_mask);
+	if (swapcache != folio) {
+		folio_put(folio);
+		goto out_no_alloc;
+	}
+
+	put_swap_device(si);
+	*folio_allocated = true;
+	return swapcache;
+
+out_no_alloc:
+	put_swap_device(si);
+out_no_device:
+	*folio_allocated = false;
+	return swapcache;
+}
+
 /*
  * Locate a page of swap in physical memory, reserving swap cache space
  * and reading the disk if it is not already cached.
@@ -519,7 +526,7 @@ struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 
 	mpol = get_vma_policy(vma, addr, 0, &ilx);
 	folio = swap_cache_alloc_or_get(entry, gfp_mask, mpol, ilx,
-					&page_allocated, false);
+					&page_allocated);
 	mpol_cond_put(mpol);
 
 	if (page_allocated)
@@ -636,7 +643,7 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 		/* Ok, do the async read-ahead now */
 		folio = swap_cache_alloc_or_get(
 				swp_entry(swp_type(entry), offset),
-				gfp_mask, mpol, ilx, &page_allocated, false);
+				gfp_mask, mpol, ilx, &page_allocated);
 		if (!folio)
 			continue;
 		if (page_allocated) {
@@ -654,7 +661,7 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 skip:
 	/* The page was likely read above, so no need for plugging here */
 	folio = swap_cache_alloc_or_get(entry, gfp_mask, mpol, ilx,
-					&page_allocated, false);
+					&page_allocated);
 	if (unlikely(page_allocated)) {
 		zswap_folio_swapin(folio);
 		swap_read_folio(folio, false, NULL);
@@ -810,7 +817,7 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 		pte_unmap(pte);
 		pte = NULL;
 		folio = swap_cache_alloc_or_get(entry, gfp_mask, mpol, ilx,
-						&page_allocated, false);
+						&page_allocated);
 		if (!folio)
 			continue;
 		if (page_allocated) {
@@ -830,7 +837,7 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 skip:
 	/* The folio was likely read above, so no need for plugging here */
 	folio = swap_cache_alloc_or_get(targ_entry, gfp_mask, mpol, targ_ilx,
-					&page_allocated, false);
+					&page_allocated);
 	if (unlikely(page_allocated)) {
 		zswap_folio_swapin(folio);
 		swap_read_folio(folio, false, NULL);
@@ -856,7 +863,7 @@ struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
 
 	mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
 	folio = swap_cache_alloc_or_get(entry, gfp_mask, mpol, ilx,
-					&page_allocated, false);
+					&page_allocated);
 	mpol_cond_put(mpol);
 
 	if (page_allocated)
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 332ce4e578e8..8225091d42b6 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -149,9 +149,10 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	 * in usual operations.
 	 */
 	if (folio_trylock(folio)) {
-		if ((flags & TTRS_ANYWAY) ||
+		if (folio_test_swapcache(folio) &&
+		    ((flags & TTRS_ANYWAY) ||
 		    ((flags & TTRS_UNMAPPED) && !folio_mapped(folio)) ||
-		    ((flags & TTRS_FULL) && mem_cgroup_swap_full(folio)))
+		    ((flags & TTRS_FULL) && mem_cgroup_swap_full(folio))))
 			ret = folio_free_swap(folio);
 		folio_unlock(folio);
 	}
@@ -1344,7 +1345,8 @@ void swap_free(swp_entry_t entry)
 }
 
 /*
- * Called after dropping swapcache to decrease refcnt to swap entries.
+ * Called before dropping swapcache, free the entry and ensure
+ * new insertion will success.
  */
 void put_swap_folio(struct folio *folio, swp_entry_t entry)
 {
@@ -1897,13 +1899,15 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		}
 		if (!folio) {
 			swp_count = READ_ONCE(si->swap_map[offset]);
-			if (swp_count == 0 || swp_count == SWAP_MAP_BAD)
+			if (swap_count(swp_count) == 0 || swp_count == SWAP_MAP_BAD)
 				continue;
 			return -ENOMEM;
 		}
 
 		folio_lock(folio);
 		folio_wait_writeback(folio);
+		if (!folio_test_swapcache(folio))
+			goto free_folio;
 		ret = unuse_pte(vma, pmd, addr, entry, folio);
 		if (ret < 0) {
 			folio_unlock(folio);
@@ -1912,6 +1916,7 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		}
 
 		folio_free_swap(folio);
+free_folio:
 		folio_unlock(folio);
 		folio_put(folio);
 	} while (addr += PAGE_SIZE, addr != end);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 3ef654addd44..c3db39393428 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -732,10 +732,10 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 
 		if (reclaimed && !mapping_exiting(mapping))
 			shadow = workingset_eviction(folio, target_memcg);
+		put_swap_folio(folio, swap);
 		__delete_from_swap_cache(folio, swap, shadow);
 		mem_cgroup_swapout(folio, swap);
 		xa_unlock_irq(&mapping->i_pages);
-		put_swap_folio(folio, swap);
 	} else {
 		void (*free_folio)(struct folio *);
 
diff --git a/mm/zswap.c b/mm/zswap.c
index e4d96816be70..c80e33c74235 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1127,7 +1127,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	/* try to allocate swap cache folio */
 	mpol = get_task_policy(current);
 	folio = swap_cache_alloc_or_get(swpentry, GFP_KERNEL, mpol,
-				NO_INTERLEAVE_INDEX, &folio_was_allocated, true);
+				NO_INTERLEAVE_INDEX, &folio_was_allocated);
 	if (!folio)
 		return -ENOMEM;
 
-- 
2.43.0


