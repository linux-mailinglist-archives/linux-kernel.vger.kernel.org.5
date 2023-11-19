Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3787E7F0892
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 20:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjKSTtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 14:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjKSTs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 14:48:58 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBCBD7F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:38 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7a93b7fedc8so175626939f.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700423317; x=1701028117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vy77DasHH4iZw3fxXV06AQqlBWBp94UgYk7CDc75jBU=;
        b=jmI9Qr/YCZXj/KwbpX3E7Cms6SpwqzungcU2z0+6qyeldu6v/wBxEalqyKFDN5PYIk
         FFmB3z+erBwNko1TXY+0rHl277kJYbHPxn0GlsnkhBkxj93F5i60QZJNTy47Fb7kU+zR
         0UyLC9wlR8pHX8o7kfEpGC7KKrwSLneu4PMriwcWZSSOd30Ib5MXo7kaCbyKDEaOsP3u
         x8jIf2arU/JqbxIYsAzCEW6c1paImgaHXM/itra9VtgHq4rt2Zcs9KLFqbiDdqafT/1H
         o+oi6hlqhGxPH7tCXBkRpu+HN5q1se2JOa/WCd9ZKs6XWa4xH54ujElKbKZ6nqG8TIDw
         DUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700423317; x=1701028117;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vy77DasHH4iZw3fxXV06AQqlBWBp94UgYk7CDc75jBU=;
        b=IqBH1MemFrg7sB8fpU0GgP1DFuUjwu69KfuXM0NEHUNGVCj2qWX/PtJBACYfH3bEB8
         VBD2Oeuhf+19kMWLONrUKDajP1AW0VCzzVgFgpBJO8uBaIchKIdL6oxttoOty2nMqdVm
         6Pop5HAQABvbq2jm9j3e38u1VvSFX/wi7ofM762EI1o3CgE/KJSSYV4jckpORSMo4955
         oGcuTbsGPfzKutEpBStS2UdBum6pb9E0rcsVZc1gGRCk4wrcBPrs8xOsOYwBA58JZ+Qc
         L2mN9UprzOplDSEMgvx8T9bYTlvrHu+EI5mpNXCuHd+aZ9+LYLlbkokNDOH9inRht8rv
         /91w==
X-Gm-Message-State: AOJu0YzOc544/ZnCCQrsjI2ErhGhKT7+0pi+9tkLs6wbFfE8o/ern/5o
        n/ilic4q9GOZaGQhTG0zfto=
X-Google-Smtp-Source: AGHT+IECybsdgtqaEHEB6jhiCW9wgMllnD9l2cqLKV8BEgk8bfpyCeOF7+1eRGrvZhfSvcvWoreVgg==
X-Received: by 2002:a92:cbc2:0:b0:35a:f493:5667 with SMTP id s2-20020a92cbc2000000b0035af4935667mr5462158ilq.20.1700423317470;
        Sun, 19 Nov 2023 11:48:37 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.40.79])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b006cb7feae74fsm1237140pfo.164.2023.11.19.11.48.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Nov 2023 11:48:36 -0800 (PST)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Kairui Song <kasong@tencent.com>
Subject: [PATCH 11/24] mm/swap: also handle swapcache lookup in swapin_readahead
Date:   Mon, 20 Nov 2023 03:47:27 +0800
Message-ID: <20231119194740.94101-12-ryncsn@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231119194740.94101-1-ryncsn@gmail.com>
References: <20231119194740.94101-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kairui Song <kasong@tencent.com>

No feature change, just prepare for later commits.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/memory.c     | 61 +++++++++++++++++++++++--------------------------
 mm/swap.h       | 10 ++++++--
 mm/swap_state.c | 26 +++++++++++++--------
 mm/swapfile.c   | 30 +++++++++++-------------
 4 files changed, 66 insertions(+), 61 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index f4237a2e3b93..22af9f3e8c75 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3786,13 +3786,13 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 vm_fault_t do_swap_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	struct folio *swapcache, *folio = NULL;
+	struct folio *swapcache = NULL, *folio = NULL;
+	enum swap_cache_result cache_result;
 	struct page *page;
 	struct swap_info_struct *si = NULL;
 	rmap_t rmap_flags = RMAP_NONE;
 	bool exclusive = false;
 	swp_entry_t entry;
-	bool swapcached;
 	pte_t pte;
 	vm_fault_t ret = 0;
 
@@ -3850,42 +3850,37 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (unlikely(!si))
 		goto out;
 
-	folio = swap_cache_get_folio(entry, vma, vmf->address);
-	if (folio)
-		page = folio_file_page(folio, swp_offset(entry));
-	swapcache = folio;
-
-	if (!folio) {
-		page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
-					vmf, &swapcached);
-		if (page) {
-			folio = page_folio(page);
-			if (swapcached)
-				swapcache = folio;
-		} else {
+	page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
+				vmf, &cache_result);
+	if (page) {
+		folio = page_folio(page);
+		if (cache_result != SWAP_CACHE_HIT) {
+			/* Had to read the page from swap area: Major fault */
+			ret = VM_FAULT_MAJOR;
+			count_vm_event(PGMAJFAULT);
+			count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
+		}
+		if (cache_result != SWAP_CACHE_BYPASS)
+			swapcache = folio;
+		if (PageHWPoison(page)) {
 			/*
-			 * Back out if somebody else faulted in this pte
-			 * while we released the pte lock.
+			 * hwpoisoned dirty swapcache pages are kept for killing
+			 * owner processes (which may be unknown at hwpoison time)
 			 */
-			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
-					vmf->address, &vmf->ptl);
-			if (likely(vmf->pte &&
-				   pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
-				ret = VM_FAULT_OOM;
-			goto unlock;
+			ret = VM_FAULT_HWPOISON;
+			goto out_release;
 		}
-
-		/* Had to read the page from swap area: Major fault */
-		ret = VM_FAULT_MAJOR;
-		count_vm_event(PGMAJFAULT);
-		count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
-	} else if (PageHWPoison(page)) {
+	} else {
 		/*
-		 * hwpoisoned dirty swapcache pages are kept for killing
-		 * owner processes (which may be unknown at hwpoison time)
+		 * Back out if somebody else faulted in this pte
+		 * while we released the pte lock.
 		 */
-		ret = VM_FAULT_HWPOISON;
-		goto out_release;
+		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
+				vmf->address, &vmf->ptl);
+		if (likely(vmf->pte &&
+			   pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
+			ret = VM_FAULT_OOM;
+		goto unlock;
 	}
 
 	ret |= folio_lock_or_retry(folio, vmf);
diff --git a/mm/swap.h b/mm/swap.h
index a9a654af791e..ac9136eee690 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -30,6 +30,12 @@ extern struct address_space *swapper_spaces[];
 	(&swapper_spaces[swp_type(entry)][swp_offset(entry) \
 		>> SWAP_ADDRESS_SPACE_SHIFT])
 
+enum swap_cache_result {
+	SWAP_CACHE_HIT,
+	SWAP_CACHE_MISS,
+	SWAP_CACHE_BYPASS,
+};
+
 void show_swap_cache_info(void);
 bool add_to_swap(struct folio *folio);
 void *get_shadow_from_swap_cache(swp_entry_t entry);
@@ -55,7 +61,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
 				    struct mempolicy *mpol, pgoff_t ilx);
 struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
-			      struct vm_fault *vmf, bool *swapcached);
+			      struct vm_fault *vmf, enum swap_cache_result *result);
 
 static inline unsigned int folio_swap_flags(struct folio *folio)
 {
@@ -92,7 +98,7 @@ static inline struct page *swap_cluster_readahead(swp_entry_t entry,
 }
 
 static inline struct page *swapin_readahead(swp_entry_t swp, gfp_t gfp_mask,
-			struct vm_fault *vmf, bool *swapcached)
+			struct vm_fault *vmf, enum swap_cache_result *result)
 {
 	return NULL;
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index d87c20f9f7ec..e96d63bf8a22 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -908,8 +908,7 @@ static struct page *swapin_no_readahead(swp_entry_t entry, gfp_t gfp_mask,
  * @entry: swap entry of this memory
  * @gfp_mask: memory allocation flags
  * @vmf: fault information
- * @swapcached: pointer to a bool used as indicator if the
- *              page is swapped in through swapcache.
+ * @result: a return value to indicate swap cache usage.
  *
  * Returns the struct page for entry and addr, after queueing swapin.
  *
@@ -918,30 +917,39 @@ static struct page *swapin_no_readahead(swp_entry_t entry, gfp_t gfp_mask,
  * or vma-based(ie, virtual address based on faulty address) readahead.
  */
 struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
-			      struct vm_fault *vmf, bool *swapcached)
+			      struct vm_fault *vmf, enum swap_cache_result *result)
 {
+	enum swap_cache_result cache_result;
 	struct swap_info_struct *si;
 	struct mempolicy *mpol;
+	struct folio *folio;
 	struct page *page;
 	pgoff_t ilx;
-	bool cached;
+
+	folio = swap_cache_get_folio(entry, vmf->vma, vmf->address);
+	if (folio) {
+		page = folio_file_page(folio, swp_offset(entry));
+		cache_result = SWAP_CACHE_HIT;
+		goto done;
+	}
 
 	si = swp_swap_info(entry);
 	mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
 	if (swap_use_no_readahead(si, swp_offset(entry))) {
 		page = swapin_no_readahead(entry, gfp_mask, mpol, ilx, vmf->vma->vm_mm);
-		cached = false;
+		cache_result = SWAP_CACHE_BYPASS;
 	} else if (swap_use_vma_readahead(si)) {
 		page = swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf);
-		cached = true;
+		cache_result = SWAP_CACHE_MISS;
 	} else {
 		page = swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
-		cached = true;
+		cache_result = SWAP_CACHE_MISS;
 	}
 	mpol_cond_put(mpol);
 
-	if (swapcached)
-		*swapcached = cached;
+done:
+	if (result)
+		*result = cache_result;
 
 	return page;
 }
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 01c3f53b6521..b6d57fff5e21 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1822,13 +1822,21 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 
 	si = swap_info[type];
 	do {
-		struct folio *folio;
+		struct page *page;
 		unsigned long offset;
 		unsigned char swp_count;
+		struct folio *folio = NULL;
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
@@ -1847,22 +1855,10 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		offset = swp_offset(entry);
 		pte_unmap(pte);
 		pte = NULL;
-
-		folio = swap_cache_get_folio(entry, vma, addr);
-		if (!folio) {
-			struct page *page;
-			struct vm_fault vmf = {
-				.vma = vma,
-				.address = addr,
-				.real_address = addr,
-				.pmd = pmd,
-			};
-
-			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
-						&vmf, NULL);
-			if (page)
-				folio = page_folio(page);
-		}
+		page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
+					&vmf, NULL);
+		if (page)
+			folio = page_folio(page);
 		if (!folio) {
 			/*
 			 * The entry could have been freed, and will not
-- 
2.42.0

