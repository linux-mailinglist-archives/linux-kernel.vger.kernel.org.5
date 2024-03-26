Return-Path: <linux-kernel+bounces-119747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B141F88CCA7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB00BB278C3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2385214265;
	Tue, 26 Mar 2024 19:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+T4LvRl"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A312013CC67
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479881; cv=none; b=t0p9kewK1FmtKZXSLJRdnDfW+hSALLb+/PZBcCa0z30fdKiAZMCmcJlO/pgiQhieBjS1NJ9vorveVCL+w8wxUiOerCuigcc0FZDCCDYizuKeXcMwKZ9Zy58zVkZ9WYs2kpWJcCUFHBSOCOzeJdhkRXUDifeH0EKYj8meBvn/hkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479881; c=relaxed/simple;
	bh=BhNSRTRGFLZQR9q1mLGd37SZqvsgnnuAv8LnFnESSus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9UzgOyLGzgj3E+OUKEggPYXJd7GutTQ7aK805agNEtrgQu+57T+AKXv9utOgSzk83A8fDEaPk85s1b4j6hYeVRiVNU9fAE4lThUPwS/wXzU28XSyR7zH0f0cvvZTF0Z8Wk/IgJRt8ibF2sEMSM0A3oz8PptOhNORTFrlPKpLcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+T4LvRl; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so2795379a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711479879; x=1712084679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QbZCOjluZtqwe+IJf5t2wPcomK28PDyLWYCalJheOPc=;
        b=c+T4LvRlxNKyDu9GePa4TD/uptUmovAfahxSsKUHHOfiUu7LZi/9jAA7Brhr8QMoYy
         UVXnNf0tc9HLg4Ew7r26uLWsuYCl8Kbz6+KV7T00fvUHbor+FenowYXTixxKkMPva+Nq
         uf+fqfJ+IkDYn0yLnnTbERaBSYyGTwkK3SYou6GOi6Yq6Y4SPkxAzmPmNs8ZKnjmkHZs
         wkyrsE3cyZ1xYqu/jQXrXPEI+/VoR3h/CYgYB9Nx1Zkh1I/yXwErzS299w3fiffnwxvK
         gA1JKMm7bC4HKFXX03BBLPtskvl42mpOEfp0Hf361P8RAgiRtgLQtqDh9XBxv2lrD3TF
         ji8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711479879; x=1712084679;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QbZCOjluZtqwe+IJf5t2wPcomK28PDyLWYCalJheOPc=;
        b=lfp5kLPoTxV8e3z3in4TH3ahk4wMgmi2zyu5GaX67gETyLwXs4PLo3gM1i1U06Mkz9
         Sb2ABqQMMHi9uVxLNs6AG6jQrUTj1jxS6iWtKYLl3IUnkjCoEtx7EJirWxuQCsr155C4
         voazUBZqJUVJZqu9xbHWheshxr4I4cO4PDwIrtiUeEsb6X7pOPqTa5R2KSDns0dAl2mI
         2tClOA4tZonKs7MHFQwJqNzUERIHPhwMWjE16fLmBsVgNuLZT2wHUd9w1/12Vm3RwrUk
         s+Y3eca8vDyTMwiCJwNLHHMP1RcnIcBY0eMvPgJxNOpZJW6srIU/gU22DnmP+OoXPSKF
         uC1w==
X-Forwarded-Encrypted: i=1; AJvYcCXWLTG6Fv1ysrWkU3kya8OhCdeweN4utZIPzFZ4NzwRodTL2oX7CdacqHxIMon0/seqWDTk6AOptmChJDNrJ42gwSYQr0luJeouwK4f
X-Gm-Message-State: AOJu0Yy92OHomcEp7Cc2mzaoCI5t20oWmsiMecWu7BZ83MVn/OmHB6w7
	wRn6BCTchCymrIph6MnyLEDUT7ODLXhmIrBdNDdm271Qf/OwpSXQ
X-Google-Smtp-Source: AGHT+IHPrVL9xajG03QLF+CldgXO1e+DdNsfAc6WD2CDV/JcM0VHVNqqhHe8QUEsP8IyBUI6ApCsOQ==
X-Received: by 2002:a05:6a20:9187:b0:1a3:c113:f441 with SMTP id v7-20020a056a20918700b001a3c113f441mr8667699pzd.15.1711479878748;
        Tue, 26 Mar 2024 12:04:38 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([115.171.40.106])
        by smtp.gmail.com with ESMTPSA id j14-20020aa783ce000000b006ea790c2232sm6298350pfn.79.2024.03.26.12.04.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Mar 2024 12:04:38 -0700 (PDT)
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
Subject: [RFC PATCH 05/10] mm/swap: clean shadow only in unmap path
Date: Wed, 27 Mar 2024 02:50:27 +0800
Message-ID: <20240326185032.72159-6-ryncsn@gmail.com>
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

After removing the cache bypass swapin, the first thing could be
gone is all the clear_shadow_from_swap_cache calls. Currently
clear_shadow_from_swap_cache is being called in many paths.
It's currently being called by swap_range_free which has two
direct callers:

- swap_free_cluster, which is only called by put_swap_folio to free up
  the shadow of a slot cluster.
- swap_entry_free, which is only called by swapcache_free_entries to
  free up shadow of a slot.

And these two are very commonly used everywhere in SWAP codes.

Notice the shadow is only written by __delete_from_swap_cache after
after a successful SWAP out, so clearly we only want to clear shadow
after SWAP in (the shadow is used and no longer needed) or Unmap/MADV_FREE.

After all swapin is using cached swapin path, clear_shadow_from_swap_cache
is not needed for swapin anymore, because we have to insert the folio
first, and this already removed the shadow. So we only need to clear the
shadow for Unmap/MADV_FREE.

All direct/indirect caller of swap_free_cluster and swap_entry_free
are listed below:

- swap_free_cluster:
  -> put_swap_folio (Clean the cache flag and try delete shadow, after
                     removing the cache or error handling)
    -> delete_from_swap_cache
    -> __remove_mapping
    -> shmem_writepage
    -> folio_alloc_swap
    -> add_to_swap
    -> __read_swap_cache_async
- swap_entry_free
  -> swapcache_free_entries
    -> drain_slots_cache_cpu
    -> free_swap_slot
      -> put_swap_folio (Already covered above)
      -> __swap_entry_free / swap_free
        -> free_swap_and_cache (Called by Unmap/Zap/MADV_FREE)
          -> madvise_free_single_vma
          -> unmap_page_range
          -> shmem_undo_range
        -> swap_free (Called by swapin path)
          -> do_swap_page (Swapin path)
          -> alloc_swapdev_block/free_all_swap_pages ()
          -> try_to_unmap_one (Error handling, no shadow)
          -> shmem_set_folio_swapin_error (Shadow just gone)
          -> shmem_swapin_folio (Shmem's do_swap_page)
          -> unuse_pte (Swapoff, which always use swapcache)

So now we only need to call clear_shadow_from_swap_cache in
free_swap_and_cache because all swapin/out will went through swap cache
now. Previously all above functions could invoke
clear_shadow_from_swap_cache in case a cache bypass swapin left a entry
with uncleared shadow.

Also make clear_shadow_from_swap_cache only clear one entry for
simplicity.

Test result of sequential swapin/out:

               Before (us)        After (us)
Swapout:       33624641           33648529
Swapin:        41614858           40667696 (+2.3%)
Swapout (THP): 7795530            7658664
Swapin (THP) : 41708471           40602278 (+2.7%)

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap.h       |  6 ++----
 mm/swap_state.c | 33 ++++++++-------------------------
 mm/swapfile.c   |  6 ++++--
 3 files changed, 14 insertions(+), 31 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index ac9573b03432..7721ddb3bdbc 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -39,8 +39,7 @@ int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
 void __delete_from_swap_cache(struct folio *folio,
 			      swp_entry_t entry, void *shadow);
 void delete_from_swap_cache(struct folio *folio);
-void clear_shadow_from_swap_cache(int type, unsigned long begin,
-				  unsigned long end);
+void clear_shadow_from_swap_cache(swp_entry_t entry);
 struct folio *swap_cache_get_folio(swp_entry_t entry,
 		struct vm_area_struct *vma, unsigned long addr);
 struct folio *filemap_get_incore_folio(struct address_space *mapping,
@@ -148,8 +147,7 @@ static inline void delete_from_swap_cache(struct folio *folio)
 {
 }
 
-static inline void clear_shadow_from_swap_cache(int type, unsigned long begin,
-				unsigned long end)
+static inline void clear_shadow_from_swap_cache(swp_entry_t entry)
 {
 }
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 49ef6250f676..b84e7b0ea4a5 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -245,34 +245,17 @@ void delete_from_swap_cache(struct folio *folio)
 	folio_ref_sub(folio, folio_nr_pages(folio));
 }
 
-void clear_shadow_from_swap_cache(int type, unsigned long begin,
-				unsigned long end)
+void clear_shadow_from_swap_cache(swp_entry_t entry)
 {
-	unsigned long curr = begin;
-	void *old;
-
-	for (;;) {
-		swp_entry_t entry = swp_entry(type, curr);
-		struct address_space *address_space = swap_address_space(entry);
-		XA_STATE(xas, &address_space->i_pages, curr);
-
-		xas_set_update(&xas, workingset_update_node);
+	struct address_space *address_space = swap_address_space(entry);
+	XA_STATE(xas, &address_space->i_pages, swp_offset(entry));
 
-		xa_lock_irq(&address_space->i_pages);
-		xas_for_each(&xas, old, end) {
-			if (!xa_is_value(old))
-				continue;
-			xas_store(&xas, NULL);
-		}
-		xa_unlock_irq(&address_space->i_pages);
+	xas_set_update(&xas, workingset_update_node);
 
-		/* search the next swapcache until we meet end */
-		curr >>= SWAP_ADDRESS_SPACE_SHIFT;
-		curr++;
-		curr <<= SWAP_ADDRESS_SPACE_SHIFT;
-		if (curr > end)
-			break;
-	}
+	xa_lock_irq(&address_space->i_pages);
+	if (xa_is_value(xas_load(&xas)))
+		xas_store(&xas, NULL);
+	xa_unlock_irq(&address_space->i_pages);
 }
 
 /*
diff --git a/mm/swapfile.c b/mm/swapfile.c
index ae8d3aa05df7..bafae23c0f26 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -724,7 +724,6 @@ static void add_to_avail_list(struct swap_info_struct *p)
 static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 			    unsigned int nr_entries)
 {
-	unsigned long begin = offset;
 	unsigned long end = offset + nr_entries - 1;
 	void (*swap_slot_free_notify)(struct block_device *, unsigned long);
 
@@ -748,7 +747,6 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 			swap_slot_free_notify(si->bdev, offset);
 		offset++;
 	}
-	clear_shadow_from_swap_cache(si->type, begin, end);
 
 	/*
 	 * Make sure that try_to_unuse() observes si->inuse_pages reaching 0
@@ -1605,6 +1603,8 @@ bool folio_free_swap(struct folio *folio)
 /*
  * Free the swap entry like above, but also try to
  * free the page cache entry if it is the last user.
+ * Useful when clearing the swap map and swap cache
+ * without reading swap content (eg. unmap, MADV_FREE)
  */
 int free_swap_and_cache(swp_entry_t entry)
 {
@@ -1626,6 +1626,8 @@ int free_swap_and_cache(swp_entry_t entry)
 		    !swap_page_trans_huge_swapped(p, entry))
 			__try_to_reclaim_swap(p, swp_offset(entry),
 					      TTRS_UNMAPPED | TTRS_FULL);
+		if (!count)
+			clear_shadow_from_swap_cache(entry);
 		put_swap_device(p);
 	}
 	return p != NULL;
-- 
2.43.0


