Return-Path: <linux-kernel+bounces-43246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD15841163
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D3E28D39F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D407602A;
	Mon, 29 Jan 2024 17:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZIBEBZi"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5DA7602D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550924; cv=none; b=CdFvrhq1NmRufxDRlT0pEbUmdtpEBldMIQABFQUCRfzJB00FPx/q5uiXp7Lk+6C5gomcfpr8+qG2gQ67ThNepf/7ZxHYrvxn+DhDtN8MTvJkjzEV/cUpY1FV1Kg15p05u3RyZYw/ebXOCZqODhuKjF+jDnTMfzsRGcm2lk1UEdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550924; c=relaxed/simple;
	bh=mdzgPDJES3q5PRzJ9kl+n1xwdr8hP3wcxpGiZK8b3Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+B8w379mtdYj7xKeWo0CFaR2/FC62dnn3yvdSeO9YMAtYB7BUk/BDXJIpz5rpBM4T6FWLQiIK/fYvqLY1KVtcFOYxpTa3o2lTkp8m2te9jl/5lsAqsJIjalLF6l71J+si7MIwaaXwgRzcolGchwYmX5pNn47ye5GhjAPK60KZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZIBEBZi; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bd5c4cffefso3559276b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706550921; x=1707155721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y3NzQYMmpvHTXBLoyc702W5Zl5rwxoKujBWnFPZfTzI=;
        b=TZIBEBZi7mI1/SlQXSCDtaDNPd/s21Fu43WUtynVKvgOm/TVCfsyVumjya8EQyBG+5
         kjLlAj5jSZFXWfNQ80F2+GpdxFlRSP7DcTKWA6Q5rMn+IbZ28OIwdhU/omalObNX+kd2
         2gFHUgIOINttkHdrdjhyL/cd31/UGQo6Fh139lrhi0zhnhc4I7RzwQMAeg78nnryOBEc
         Shw+vuHTH8DAEN+Ya5NkYTFx7ePQ6AYSFwBfM8HBAc6VIZU/Ar7SziFMoNI55Qe6RCiT
         cOJ84kyzpuSG2vDqjHsF/kbY0S35QQ6rKiQtuo9ggJSgs/C/VIN++4421v5eyyk/Mc2L
         dNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706550921; x=1707155721;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y3NzQYMmpvHTXBLoyc702W5Zl5rwxoKujBWnFPZfTzI=;
        b=s5X0Ql4yEpasHi3B/sTF8KmpkUGFinUcwHnAmEmgK9Nnyg/92fVp+c+OGkmSBeqdmV
         6jxCZMOveZr6vci2eJUy7btzxNjooCbDbA4Gj7RYnDLqpDGxy0opz1Yh4uZwmGLkdxCK
         /xPmyM6PhuTehhtDg/hFBklt8VHl8zbiw1IB/r8FKpWKU3mzNeKYafXQisPu09ApHQIv
         ZMMVKsuK6CuBiv1mAKFtOzlogk7/utP57zAhMF1gJ4Yp99C/zHY4o2V5/qM1QjcGA0Qs
         TvMRLoatRFrN6IT0elmW+oxqOX5XTaoLipmEyStOCmjXX3/lyG0JDoQNEdkTehBCniWW
         SQsA==
X-Gm-Message-State: AOJu0Yx6io+5R7tuTccLP3FJy+Q8g43zoOX9/1dytCaOWrOogk5T3uxP
	i0NkchL7HngS4BdFfCRf4un4olm+ANTivUE6Vy7H5E0lMCLbtYTwN/lBOborfJR3hQ==
X-Google-Smtp-Source: AGHT+IHKBzL9b+ijQ48IAq8a2mBY5ABGwlr8jPlejfJOdScwkjPjpxglTY+jaaywvyWnKFqMNfV0Xg==
X-Received: by 2002:a05:6808:13cf:b0:3be:5998:2cd4 with SMTP id d15-20020a05680813cf00b003be59982cd4mr2884547oiw.54.1706550921256;
        Mon, 29 Jan 2024 09:55:21 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([1.203.117.98])
        by smtp.gmail.com with ESMTPSA id h8-20020aa79f48000000b006ddcadb1e2csm6116676pfr.29.2024.01.29.09.55.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Jan 2024 09:55:20 -0800 (PST)
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
Subject: [PATCH v3 5/7] mm/swap: avoid a duplicated swap cache lookup for SWP_SYNCHRONOUS_IO
Date: Tue, 30 Jan 2024 01:54:20 +0800
Message-ID: <20240129175423.1987-6-ryncsn@gmail.com>
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

When a xa_value is returned by the cache lookup, keep it to be used
later for workingset refault check instead of doing the looking up again
in swapin_no_readahead.

Shadow look up and workingset check is skipped for swapoff to reduce
overhead, workingset checking for anon pages upon swapoff is not
helpful, simply consider all pages as inactive make more sense since
swapoff doesn't mean pages is being accessed.

After this commit, swappin is about 4% faster for ZRAM, micro benchmark
result which use madvise to swap out 10G zero-filled data to ZRAM then
read them in:

Before: 11143285 us
After:  10692644 us (+4.1%)

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/memory.c     |  5 +++--
 mm/shmem.c      |  2 +-
 mm/swap.h       | 11 ++++++-----
 mm/swap_state.c | 23 +++++++++++++----------
 mm/swapfile.c   |  4 ++--
 5 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 8711f8a07039..349946899f8d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3800,6 +3800,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	struct swap_info_struct *si = NULL;
 	rmap_t rmap_flags = RMAP_NONE;
 	bool exclusive = false;
+	void *shadow = NULL;
 	swp_entry_t entry;
 	pte_t pte;
 	vm_fault_t ret = 0;
@@ -3858,14 +3859,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (unlikely(!si))
 		goto out;
 
-	folio = swap_cache_get_folio(entry, vma, vmf->address);
+	folio = swap_cache_get_folio(entry, vma, vmf->address, &shadow);
 	if (folio)
 		page = folio_file_page(folio, swp_offset(entry));
 	swapcache = folio;
 
 	if (!folio) {
 		folio = swapin_entry(entry, GFP_HIGHUSER_MOVABLE,
-				     vmf, &swapcache);
+				     vmf, &swapcache, shadow);
 		if (!folio) {
 			/*
 			 * Back out if somebody else faulted in this pte
diff --git a/mm/shmem.c b/mm/shmem.c
index d7c84ff62186..698a31bf7baa 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1873,7 +1873,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	}
 
 	/* Look it up and read it in.. */
-	folio = swap_cache_get_folio(swap, NULL, 0);
+	folio = swap_cache_get_folio(swap, NULL, 0, NULL);
 	if (!folio) {
 		/* Or update major stats only when swapin succeeds?? */
 		if (fault_type) {
diff --git a/mm/swap.h b/mm/swap.h
index 8f8185d3865c..ca9cb472a263 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -42,7 +42,8 @@ void delete_from_swap_cache(struct folio *folio);
 void clear_shadow_from_swap_cache(int type, unsigned long begin,
 				  unsigned long end);
 struct folio *swap_cache_get_folio(swp_entry_t entry,
-		struct vm_area_struct *vma, unsigned long addr);
+		struct vm_area_struct *vma, unsigned long addr,
+		void **shadowp);
 struct folio *filemap_get_incore_folio(struct address_space *mapping,
 		pgoff_t index);
 
@@ -54,8 +55,8 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_flags,
 		bool skip_if_exists);
 struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
 		struct mempolicy *mpol, pgoff_t ilx);
-struct folio *swapin_entry(swp_entry_t entry, gfp_t flag,
-			   struct vm_fault *vmf, struct folio **swapcached);
+struct folio *swapin_entry(swp_entry_t entry, gfp_t flag, struct vm_fault *vmf,
+		struct folio **swapcached, void *shadow);
 
 static inline unsigned int folio_swap_flags(struct folio *folio)
 {
@@ -87,7 +88,7 @@ static inline struct folio *swap_cluster_readahead(swp_entry_t entry,
 }
 
 static inline struct folio *swapin_entry(swp_entry_t swp, gfp_t gfp_mask,
-			struct vm_fault *vmf, struct folio **swapcached)
+			struct vm_fault *vmf, struct folio **swapcached, void *shadow)
 {
 	return NULL;
 }
@@ -98,7 +99,7 @@ static inline int swap_writepage(struct page *p, struct writeback_control *wbc)
 }
 
 static inline struct folio *swap_cache_get_folio(swp_entry_t entry,
-		struct vm_area_struct *vma, unsigned long addr)
+		struct vm_area_struct *vma, unsigned long addr, void **shadowp)
 {
 	return NULL;
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 5e06b2e140d4..e41a137a6123 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -330,12 +330,18 @@ static inline bool swap_use_vma_readahead(void)
  * Caller must lock the swap device or hold a reference to keep it valid.
  */
 struct folio *swap_cache_get_folio(swp_entry_t entry,
-		struct vm_area_struct *vma, unsigned long addr)
+		struct vm_area_struct *vma, unsigned long addr, void **shadowp)
 {
 	struct folio *folio;
 
-	folio = filemap_get_folio(swap_address_space(entry), swp_offset(entry));
-	if (!IS_ERR(folio)) {
+	folio = filemap_get_entry(swap_address_space(entry), swp_offset(entry));
+	if (xa_is_value(folio)) {
+		if (shadowp)
+			*shadowp = folio;
+		return NULL;
+	}
+
+	if (folio) {
 		bool vma_ra = swap_use_vma_readahead();
 		bool readahead;
 
@@ -365,8 +371,6 @@ struct folio *swap_cache_get_folio(swp_entry_t entry,
 			if (!vma || !vma_ra)
 				atomic_inc(&swapin_readahead_hits);
 		}
-	} else {
-		folio = NULL;
 	}
 
 	return folio;
@@ -866,16 +870,16 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
  * @entry: swap entry of this memory
  * @gfp_mask: memory allocation flags
  * @vmf: fault information
+ * @shadow: workingset shadow corresponding to entry
  *
  * Returns the struct folio for entry and addr after the swap entry is read
  * in.
  */
 static struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
-				  struct vm_fault *vmf)
+				  struct vm_fault *vmf, void *shadow)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct folio *folio;
-	void *shadow = NULL;
 
 	/* skip swapcache */
 	folio = vma_alloc_folio(gfp_mask, 0,
@@ -892,7 +896,6 @@ static struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
 		}
 		mem_cgroup_swapin_uncharge_swap(entry);
 
-		shadow = get_shadow_from_swap_cache(entry);
 		if (shadow)
 			workingset_refault(folio, shadow);
 
@@ -922,7 +925,7 @@ static struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
  * or skip the readahead(ie, ramdisk based swap device).
  */
 struct folio *swapin_entry(swp_entry_t entry, gfp_t gfp_mask,
-			   struct vm_fault *vmf, struct folio **swapcache)
+			   struct vm_fault *vmf, struct folio **swapcache, void *shadow)
 {
 	struct mempolicy *mpol;
 	struct folio *folio;
@@ -930,7 +933,7 @@ struct folio *swapin_entry(swp_entry_t entry, gfp_t gfp_mask,
 
 	if (data_race(swp_swap_info(entry)->flags & SWP_SYNCHRONOUS_IO) &&
 	    __swap_count(entry) == 1) {
-		folio = swapin_direct(entry, gfp_mask, vmf);
+		folio = swapin_direct(entry, gfp_mask, vmf, shadow);
 	} else {
 		mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
 		if (swap_use_vma_readahead())
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 1cf7e72e19e3..aac26f5a6cec 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1865,7 +1865,7 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		pte_unmap(pte);
 		pte = NULL;
 
-		folio = swap_cache_get_folio(entry, vma, addr);
+		folio = swap_cache_get_folio(entry, vma, addr, NULL);
 		if (!folio) {
 			struct vm_fault vmf = {
 				.vma = vma,
@@ -1875,7 +1875,7 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			};
 
 			folio = swapin_entry(entry, GFP_HIGHUSER_MOVABLE,
-					    &vmf, NULL);
+					    &vmf, NULL, NULL);
 		}
 		if (!folio) {
 			/*
-- 
2.43.0


