Return-Path: <linux-kernel+bounces-43245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322CD84115F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 275E3B243CB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C868D6F080;
	Mon, 29 Jan 2024 17:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9rOb35P"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D83A6F09E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550919; cv=none; b=E42tgCK2P+obr0sA1jBKE7HLH9eX7PNES5TH8wkcPXbpJaiaSCFJ6m/oYVCRpxBM6IqT62aJ06vrbsGG+vy8xgaRv/Z/SaPP1dOpsrr01EwzoW3Iu9X/PodZ5Os3K5EGILcY3gy0uy9PMNcO8VxEIgjW6TiLyPH4UNZJPeu1sBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550919; c=relaxed/simple;
	bh=Pi+pXUZ+yCZ7h2m4QYK94D2QN9IBmxdngdrHeNLfSNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvY8UQCWHRAgFv5rqVSSi0WkAj9CSiusbOFPaj0qZm91hhr2yz+P6e5rJk64zgRVQ7xSbMLXsyd5DwsVwKvhWNLIV15er/ZZizZZddx6Emq33HkyyhzLcU8/vpAeVSFAzH9y4iWKo0PZzw1TSPeGiabtoPEfEoAXLRlZtjxC64E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9rOb35P; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6dddc5e34e2so2065588b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706550918; x=1707155718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZEaJsg6FaNgmWF+uyO/aaFj/erl/Uc0eXE/63t3Htcg=;
        b=f9rOb35PLFCS9TLYFERee38VkB6L7BI5apOztBfhGbBCGCN7aqqD38+As8+tQB+3jI
         jX+PaA+HElDnuPD5F+aEbe7Y5+yHrgSuj1uf1y/UP2/TJZs+LYUAGkQLtUwTJHgXXoCJ
         GXnXpNiejx5yKtdmExvXY9AhFUim4ZYBJxrR7PEyUxNgzCkDvfIYP5m80VvXt643l63u
         MX7+JM9NEdRBG9Pql04yW93N0P73zb0Btpi56qFLheYAlmcLRVCHM6Gq3fXggg90fRwH
         uKOVP9u3mi3UqN+YV9HEaJ1MpMBJA+TPhgp6N/wpw+ZNVCsSNa0TTPH6vaMjKNY0CR+B
         H+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706550918; x=1707155718;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZEaJsg6FaNgmWF+uyO/aaFj/erl/Uc0eXE/63t3Htcg=;
        b=iJ7fCbhuKdXGUrX8bcMO5776a6GaCfHOEgGLvTabeDPlm/+V99U/Ehb/cr+MlaiWND
         IwlGmwWqLoRxx1oI5IoYaFA29I/SUmB5tVRanXvFs+k8DG9iBnDJapQLTjDxQ7HXxsf8
         Qa3I5nGG447bumgP9vmBQRPBzzWMa+FpmZZwoS+XVJkgtZQvmv89IYcVtLaPRLHK+7T/
         /N9HXp49U2P+8U2rDMkryspTZpoJAAsA5cvNpASzQhTtbtkVZt4kTNR4D29adaSHi+uP
         xGKJATdtdbbZ4nYqlautkkTtuhW4rtA7rHVR91ug1GOzXQP1U2oiuIupdPLuHfb/qL31
         pYVQ==
X-Gm-Message-State: AOJu0Yxxumt41S9QGpdgTIP87uUqHR1WS8wMwJqt7wZLmHmef7e08Bid
	GUjSi+AMrd4WtOXQ/XWnxytqs3xjm75PFqoCqpvKv2bkEkTE83bd
X-Google-Smtp-Source: AGHT+IHYv2LHBpglkk4ViPSn6YlurzgUjDbn2zS3N+K1h38tw1crAQqtxAPY8gv9wn+50sarKhsTLA==
X-Received: by 2002:a05:6a00:2d96:b0:6de:2470:92e1 with SMTP id fb22-20020a056a002d9600b006de247092e1mr3531769pfb.15.1706550917544;
        Mon, 29 Jan 2024 09:55:17 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([1.203.117.98])
        by smtp.gmail.com with ESMTPSA id h8-20020aa79f48000000b006ddcadb1e2csm6116676pfr.29.2024.01.29.09.55.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Jan 2024 09:55:16 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	David Hildenbrand <david@redhat.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v3 4/7] mm/swap: introduce swapin_entry for unified readahead policy
Date: Tue, 30 Jan 2024 01:54:19 +0800
Message-ID: <20240129175423.1987-5-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129175423.1987-1-ryncsn@gmail.com>
References: <20240129175423.1987-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Introduce swapin_entry which merges swapin_readahead and swapin_direct
making it the main entry for swapin pages, and use a unified swapin
readahead policy.

This commit makes swapoff make use of this new helper and skip readahead
for SYNCHRONOUS_IO device since it's not helpful here. Now swapping
off a 10G ZRAM (lzo-rle) after same workload is faster since readahead
is skipped and overhead is reduced.

Before:
time swapoff /dev/zram0
real    0m12.337s
user    0m0.001s
sys     0m12.329s

After:
time swapoff /dev/zram0
real    0m9.728s
user    0m0.001s
sys     0m9.719s

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/memory.c     | 18 +++---------------
 mm/swap.h       | 16 ++++------------
 mm/swap_state.c | 40 ++++++++++++++++++++++++----------------
 mm/swapfile.c   |  7 ++-----
 4 files changed, 33 insertions(+), 48 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 81dc9d467f4e..8711f8a07039 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3864,20 +3864,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	swapcache = folio;
 
 	if (!folio) {
-		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
-		    __swap_count(entry) == 1) {
-			/* skip swapcache and readahead */
-			folio = swapin_direct(entry, GFP_HIGHUSER_MOVABLE, vmf);
-			if (folio)
-				page = &folio->page;
-		} else {
-			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
-						vmf);
-			if (page)
-				folio = page_folio(page);
-			swapcache = folio;
-		}
-
+		folio = swapin_entry(entry, GFP_HIGHUSER_MOVABLE,
+				     vmf, &swapcache);
 		if (!folio) {
 			/*
 			 * Back out if somebody else faulted in this pte
@@ -3890,11 +3878,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 				ret = VM_FAULT_OOM;
 			goto unlock;
 		}
-
 		/* Had to read the page from swap area: Major fault */
 		ret = VM_FAULT_MAJOR;
 		count_vm_event(PGMAJFAULT);
 		count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
+		page = folio_file_page(folio, swp_offset(entry));
 	} else if (PageHWPoison(page)) {
 		/*
 		 * hwpoisoned dirty swapcache pages are kept for killing
diff --git a/mm/swap.h b/mm/swap.h
index 83eab7b67e77..8f8185d3865c 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -54,10 +54,8 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_flags,
 		bool skip_if_exists);
 struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
 		struct mempolicy *mpol, pgoff_t ilx);
-struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
-			      struct vm_fault *vmf);
-struct folio *swapin_direct(swp_entry_t entry, gfp_t flag,
-			    struct vm_fault *vmf);
+struct folio *swapin_entry(swp_entry_t entry, gfp_t flag,
+			   struct vm_fault *vmf, struct folio **swapcached);
 
 static inline unsigned int folio_swap_flags(struct folio *folio)
 {
@@ -88,14 +86,8 @@ static inline struct folio *swap_cluster_readahead(swp_entry_t entry,
 	return NULL;
 }
 
-struct folio *swapin_direct(swp_entry_t entry, gfp_t flag,
-			struct vm_fault *vmf)
-{
-	return NULL;
-}
-
-static inline struct page *swapin_readahead(swp_entry_t swp, gfp_t gfp_mask,
-			struct vm_fault *vmf)
+static inline struct folio *swapin_entry(swp_entry_t swp, gfp_t gfp_mask,
+			struct vm_fault *vmf, struct folio **swapcached)
 {
 	return NULL;
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index a450d09fc0db..5e06b2e140d4 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -870,8 +870,8 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
  * Returns the struct folio for entry and addr after the swap entry is read
  * in.
  */
-struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
-			    struct vm_fault *vmf)
+static struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
+				  struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct folio *folio;
@@ -908,33 +908,41 @@ struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
 }
 
 /**
- * swapin_readahead - swap in pages in hope we need them soon
+ * swapin_entry - swap in a folio from swap entry
  * @entry: swap entry of this memory
  * @gfp_mask: memory allocation flags
  * @vmf: fault information
+ * @swapcache: set to the swapcache folio if swapcache is used
  *
  * Returns the struct page for entry and addr, after queueing swapin.
  *
- * It's a main entry function for swap readahead. By the configuration,
+ * It's the main entry function for swap in. By the configuration,
  * it will read ahead blocks by cluster-based(ie, physical disk based)
- * or vma-based(ie, virtual address based on faulty address) readahead.
+ * or vma-based(ie, virtual address based on faulty address) readahead,
+ * or skip the readahead(ie, ramdisk based swap device).
  */
-struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
-				struct vm_fault *vmf)
+struct folio *swapin_entry(swp_entry_t entry, gfp_t gfp_mask,
+			   struct vm_fault *vmf, struct folio **swapcache)
 {
 	struct mempolicy *mpol;
-	pgoff_t ilx;
 	struct folio *folio;
+	pgoff_t ilx;
 
-	mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
-	folio = swap_use_vma_readahead() ?
-		swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf) :
-		swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
-	mpol_cond_put(mpol);
+	if (data_race(swp_swap_info(entry)->flags & SWP_SYNCHRONOUS_IO) &&
+	    __swap_count(entry) == 1) {
+		folio = swapin_direct(entry, gfp_mask, vmf);
+	} else {
+		mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
+		if (swap_use_vma_readahead())
+			folio = swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf);
+		else
+			folio = swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
+		mpol_cond_put(mpol);
+		if (swapcache)
+			*swapcache = folio;
+	}
 
-	if (!folio)
-		return NULL;
-	return folio_file_page(folio, swp_offset(entry));
+	return folio;
 }
 
 #ifdef CONFIG_SYSFS
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 606d95b56304..1cf7e72e19e3 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1867,7 +1867,6 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 
 		folio = swap_cache_get_folio(entry, vma, addr);
 		if (!folio) {
-			struct page *page;
 			struct vm_fault vmf = {
 				.vma = vma,
 				.address = addr,
@@ -1875,10 +1874,8 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				.pmd = pmd,
 			};
 
-			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
-						&vmf);
-			if (page)
-				folio = page_folio(page);
+			folio = swapin_entry(entry, GFP_HIGHUSER_MOVABLE,
+					    &vmf, NULL);
 		}
 		if (!folio) {
 			/*
-- 
2.43.0


