Return-Path: <linux-kernel+bounces-119749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C54C88CCC6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B51C1307F04
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D4413CA98;
	Tue, 26 Mar 2024 19:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="notoxR69"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE9613D260
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479890; cv=none; b=VKkoeEK5NyEacsXawTwYy+TcL5+dib8meritDzZtuWnUIyuNLP8o+VFeHCUvTy6995BQPW3PjfB80NnnNl9XGUWsyGPflXN8fnmmg39PE/6GZrGitYWInL0oiNxJFPfYZI5JRgirlVqI4O+IQEEj+5ErcJDfFkPjQXxq+qnlCSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479890; c=relaxed/simple;
	bh=5RKfb4K9zIQp1j7CbzQvEcOddDeo1gEI51gwpTbqHAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAgDVloXs6sJWjCZSvF9CjOq7p9ljiJbQceft63c+P64TZb5ROnrdH+msXw3u9VMFUG6Usq7y4pdNS61mKDOwisFwKAbdYnaEntsY0SFuZEwu8BflECkiERu17CdQsBghZ9vEFXBq5osoyzhpaqG8HJwCvax7PgueJRI+s2HZtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=notoxR69; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e6b6f86975so3800273b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711479888; x=1712084688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+ERJb6WoHkZLLvZFbb96DVZc9OxyF4ifaYeM2AyqivE=;
        b=notoxR699wnemiT8w9x8zYWr7cbaJjzwQLXvxPNGV7lCc6LV8DVysddhy9ztKnbQOf
         9dMRPMrqM8UU7vLaNzgKXA7tzV0kUx7Re8RYEr/M/yBEGWOuiS2FcU8i4aw3U61yE/hR
         ihFQMBWNrRR8TZwlrPWQNIZLt932BeQrNoIFjxM1cst1Ty1WldPP5E9+silP3z7E9qJv
         ntalgLMClty6LPfb52gKGzJ/IO5gvNlO6fVyk+M7rUdnAOEGAzFkaUfMO+CYEPjO0Nzj
         M5Ijc/zhdtwFGjOtKISsvTGtKgrjSyQxzNH38mA4UT2sEN9Fa5feCerdpDXcNwSHYNTA
         +VSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711479888; x=1712084688;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ERJb6WoHkZLLvZFbb96DVZc9OxyF4ifaYeM2AyqivE=;
        b=TuMXl7+UrWlNXx83NMSsKqhV/yHUmuZ35g4Pbp/HLsMkUyqJmbt/t/TnOMgbYmHg27
         wz3V6WNx60ic5vjqU2b5byh/rY+a4dVcvxsD1DP/OLBJdLvMQ+dpg/rzimpUo23RUAXn
         rhjed5OYMQaseM9sHcQgYjXSCoiyMUlTboa0JqNbOXoZCZzFCQSsSPy6R34JFBaVtWRX
         N5RZMNGo3Pwrg8f3U2WoanUZFhOEiBts9A9cFOkIheMFki4dpYWZP+HnUxfWJeqxb2r/
         foiZ7uNx+9JNYbIrCCkw7kmHHqNm1D7+cGiL2AsdaGCr36cB+E3ZwMqJhFDseNE57AN7
         W25Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmWEyKnJUIKBwWCcQ3hNMYnlfexe3s9Zc5ydx50srajqpOqJj5FeZ2yNjD8tsX7EdVahJx9GeiKEqWVfQ0IofscVHQdlo7JYCyllcv
X-Gm-Message-State: AOJu0Yy4+4Q0UgNy3worMUF99vRKBQ5jFySJVBZ2zZyZkY+dxl400exC
	bRfPF53K2WFgLaR+oFh/slX5W/skvxaLKmKQuQwgLlptko6AXlYy
X-Google-Smtp-Source: AGHT+IFI5c1XPfK9gSzn3T3e+978jVi9idobPChm0l6H2mPesS3FLokLOM//jRLMf4TOY19ha0SPPg==
X-Received: by 2002:a05:6a00:701e:b0:6ea:c04c:71cb with SMTP id lf30-20020a056a00701e00b006eac04c71cbmr1408795pfb.3.1711479888011;
        Tue, 26 Mar 2024 12:04:48 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([115.171.40.106])
        by smtp.gmail.com with ESMTPSA id j14-20020aa783ce000000b006ea790c2232sm6298350pfn.79.2024.03.26.12.04.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Mar 2024 12:04:47 -0700 (PDT)
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
Subject: [RFC PATCH 07/10] mm/swap: rename __read_swap_cache_async to swap_cache_alloc_or_get
Date: Wed, 27 Mar 2024 02:50:29 +0800
Message-ID: <20240326185032.72159-8-ryncsn@gmail.com>
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

__read_swap_cache_async is widely used to allocate and ensure a folio is
in swapcache, or get the folio if a folio is already there. Rename it to
better present the usage.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap.h       |  2 +-
 mm/swap_state.c | 22 +++++++++++-----------
 mm/swapfile.c   |  2 +-
 mm/zswap.c      |  2 +-
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index 7721ddb3bdbc..5fbbc4a42787 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -48,7 +48,7 @@ struct folio *filemap_get_incore_folio(struct address_space *mapping,
 struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		struct vm_area_struct *vma, unsigned long addr,
 		struct swap_iocb **plug);
-struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_flags,
+struct folio *swap_cache_alloc_or_get(swp_entry_t entry, gfp_t gfp_flags,
 		struct mempolicy *mpol, pgoff_t ilx, bool *new_page_allocated,
 		bool skip_if_exists);
 struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
diff --git a/mm/swap_state.c b/mm/swap_state.c
index caf69696f47c..cd1a16afcd9f 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -385,7 +385,7 @@ struct folio *filemap_get_incore_folio(struct address_space *mapping,
 	return folio;
 }
 
-struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
+struct folio *swap_cache_alloc_or_get(swp_entry_t entry, gfp_t gfp_mask,
 		struct mempolicy *mpol, pgoff_t ilx, bool *new_page_allocated,
 		bool skip_if_exists)
 {
@@ -443,12 +443,12 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 			goto fail_put_swap;
 
 		/*
-		 * Protect against a recursive call to __read_swap_cache_async()
+		 * Protect against a recursive call to swap_cache_alloc_or_get()
 		 * on the same entry waiting forever here because SWAP_HAS_CACHE
 		 * is set but the folio is not the swap cache yet. This can
 		 * happen today if mem_cgroup_swapin_charge_folio() below
 		 * triggers reclaim through zswap, which may call
-		 * __read_swap_cache_async() in the writeback path.
+		 * swap_cache_alloc_or_get() in the writeback path.
 		 */
 		if (skip_if_exists)
 			goto fail_put_swap;
@@ -457,7 +457,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		 * We might race against __delete_from_swap_cache(), and
 		 * stumble across a swap_map entry whose SWAP_HAS_CACHE
 		 * has not yet been cleared.  Or race against another
-		 * __read_swap_cache_async(), which has set SWAP_HAS_CACHE
+		 * swap_cache_alloc_or_get(), which has set SWAP_HAS_CACHE
 		 * in swap_map, but not yet added its folio to swap cache.
 		 */
 		schedule_timeout_uninterruptible(1);
@@ -505,7 +505,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
  * the swap entry is no longer in use.
  *
  * get/put_swap_device() aren't needed to call this function, because
- * __read_swap_cache_async() call them and swap_read_folio() holds the
+ * swap_cache_alloc_or_get() call them and swap_read_folio() holds the
  * swap cache folio lock.
  */
 struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
@@ -518,7 +518,7 @@ struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	struct folio *folio;
 
 	mpol = get_vma_policy(vma, addr, 0, &ilx);
-	folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
+	folio = swap_cache_alloc_or_get(entry, gfp_mask, mpol, ilx,
 					&page_allocated, false);
 	mpol_cond_put(mpol);
 
@@ -634,7 +634,7 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	blk_start_plug(&plug);
 	for (offset = start_offset; offset <= end_offset ; offset++) {
 		/* Ok, do the async read-ahead now */
-		folio = __read_swap_cache_async(
+		folio = swap_cache_alloc_or_get(
 				swp_entry(swp_type(entry), offset),
 				gfp_mask, mpol, ilx, &page_allocated, false);
 		if (!folio)
@@ -653,7 +653,7 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	lru_add_drain();	/* Push any new pages onto the LRU now */
 skip:
 	/* The page was likely read above, so no need for plugging here */
-	folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
+	folio = swap_cache_alloc_or_get(entry, gfp_mask, mpol, ilx,
 					&page_allocated, false);
 	if (unlikely(page_allocated)) {
 		zswap_folio_swapin(folio);
@@ -809,7 +809,7 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 			continue;
 		pte_unmap(pte);
 		pte = NULL;
-		folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
+		folio = swap_cache_alloc_or_get(entry, gfp_mask, mpol, ilx,
 						&page_allocated, false);
 		if (!folio)
 			continue;
@@ -829,7 +829,7 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 	lru_add_drain();
 skip:
 	/* The folio was likely read above, so no need for plugging here */
-	folio = __read_swap_cache_async(targ_entry, gfp_mask, mpol, targ_ilx,
+	folio = swap_cache_alloc_or_get(targ_entry, gfp_mask, mpol, targ_ilx,
 					&page_allocated, false);
 	if (unlikely(page_allocated)) {
 		zswap_folio_swapin(folio);
@@ -855,7 +855,7 @@ struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
 	pgoff_t ilx;
 
 	mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
-	folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
+	folio = swap_cache_alloc_or_get(entry, gfp_mask, mpol, ilx,
 					&page_allocated, false);
 	mpol_cond_put(mpol);
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index bafae23c0f26..332ce4e578e8 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1249,7 +1249,7 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
  *   CPU1				CPU2
  *   do_swap_page()
  *     ...				swapoff+swapon
- *     __read_swap_cache_async()
+ *     swap_cache_alloc_or_get()
  *       swapcache_prepare()
  *         __swap_duplicate()
  *           // check swap_map
diff --git a/mm/zswap.c b/mm/zswap.c
index 9dec853647c8..e4d96816be70 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1126,7 +1126,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 
 	/* try to allocate swap cache folio */
 	mpol = get_task_policy(current);
-	folio = __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
+	folio = swap_cache_alloc_or_get(swpentry, GFP_KERNEL, mpol,
 				NO_INTERLEAVE_INDEX, &folio_was_allocated, true);
 	if (!folio)
 		return -ENOMEM;
-- 
2.43.0


