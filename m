Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A0B7F088C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 20:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjKSTse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 14:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjKSTs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 14:48:26 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A59FD4C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:19 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6b87c1edfd5so2937275b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700423298; x=1701028098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZPY5phyUcHn1HYB2k83NkwocYwAsatgYc16U9qxXR/Y=;
        b=ThMc3rQjeBc3YRBPY3lazI6ZtrlWg6OFwSUsgJ98uViolM4G9UyMkniVR0nipcv976
         jpksn9aq2OMWEsUIgW2yl+CLwRVRxrQY3aHDnL+IyOAFATJRTvmKKNCcnHJk/Iwu8Lnc
         GwILHIAPriFqtgjEMkhyV8Je9zTxiSBqJemUSDYfrYuHbOZBWNrkJfU+pNC4G27o9Jkh
         oq187xX7M4l7kjHkEKatUul8NPsbCtPlYqo8Lv1OJpebh31lAt0PJrh2RTh5lTcaE2Ia
         XCWQiNDJK3GOOL9S2pusKxL8g7qPCpZ0sXvBPYA40puwG+u7BLzvn5hbp5Q0Sj8SuL+k
         eVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700423298; x=1701028098;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZPY5phyUcHn1HYB2k83NkwocYwAsatgYc16U9qxXR/Y=;
        b=b/TlLi+Clipcox/wIVm4zXDqlhdPf/YQCZza8Gv/8vCLSfsL9O23s/t9Winyoa8wjC
         kpxtmyMbrJF56tPHEldCfKrIoUgnd7r7cGiOwRFp0IGpGoMjwCDp8w+J2zP+nYAbVg99
         UndSfCIaHUH9pDG+BxDR4k/zrP9eE2I9mvdyS8SJgEpFkkYLgBxydgc2zbzhdkf7cddU
         JVaol55SOrImIHp1flHNqpWL6ylRVe9nJtPNMN2u4F3UG79pPSG4zqC3tGIocIKKJBvv
         JqviRmldK2PpB9unYKiyWSpn1Z93xvQN3d/M9J3rA6G1LT82wNPjEjhbayBllZNfzwM3
         jt7Q==
X-Gm-Message-State: AOJu0Yy1cq9vhTUMcAsxELBL8sXZgT+obonFotBxgxrizh9zwMtI7CYX
        417NIpT/DEuVTv2AyZweBk8=
X-Google-Smtp-Source: AGHT+IFSrhZjCOK5OLW/ySLi0SEQSRf2Ywf78h0lYs0h5fiCtYrCKswNp0hMG0Figvjc/xBHlwsMUw==
X-Received: by 2002:aa7:9ddd:0:b0:6c4:dc5b:5b2b with SMTP id g29-20020aa79ddd000000b006c4dc5b5b2bmr3806580pfq.20.1700423298129;
        Sun, 19 Nov 2023 11:48:18 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.40.79])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b006cb7feae74fsm1237140pfo.164.2023.11.19.11.48.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Nov 2023 11:48:17 -0800 (PST)
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
Subject: [PATCH 05/24] mm/swap: move readahead policy checking into swapin_readahead
Date:   Mon, 20 Nov 2023 03:47:21 +0800
Message-ID: <20231119194740.94101-6-ryncsn@gmail.com>
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

This makes swapin_readahead a main entry for swapin pages,
prepare for optimizations in later commits.

This also makes swapoff able to make use of readahead checking
based on entry. Swapping off a 10G ZRAM (lzo-rle) is faster:

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

And what's more, because now swapoff will also make use of no-readahead
swapin helper, this also fixed a bug for no-readahead case (eg. ZRAM):
when a process that swapped out some memory previously was moved to a new
cgroup, and the original cgroup is dead, swapoff the swap device will
make the swapped in pages accounted into the process doing the swapoff
instead of the new cgroup the process was moved to.

This can be easily reproduced by:
- Setup a ramdisk (eg. ZRAM) swap.
- Create memory cgroup A, B and C.
- Spawn process P1 in cgroup A and make it swap out some pages.
- Move process P1 to memory cgroup B.
- Destroy cgroup A.
- Do a swapoff in cgroup C.
- Swapped in pages is accounted into cgroup C.

This patch will fix it make the swapped in pages accounted in cgroup B.

The same bug exists for readahead path too, we'll fix it in later
commits.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/memory.c     | 22 +++++++---------------
 mm/swap.h       |  6 ++----
 mm/swap_state.c | 33 ++++++++++++++++++++++++++-------
 mm/swapfile.c   |  2 +-
 4 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index fba4a5229163..f4237a2e3b93 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3792,6 +3792,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	rmap_t rmap_flags = RMAP_NONE;
 	bool exclusive = false;
 	swp_entry_t entry;
+	bool swapcached;
 	pte_t pte;
 	vm_fault_t ret = 0;
 
@@ -3855,22 +3856,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	swapcache = folio;
 
 	if (!folio) {
-		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
-		    __swap_count(entry) == 1) {
-			/* skip swapcache and readahead */
-			page = swapin_no_readahead(entry, GFP_HIGHUSER_MOVABLE,
-						vmf);
-			if (page)
-				folio = page_folio(page);
+		page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
+					vmf, &swapcached);
+		if (page) {
+			folio = page_folio(page);
+			if (swapcached)
+				swapcache = folio;
 		} else {
-			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
-						vmf);
-			if (page)
-				folio = page_folio(page);
-			swapcache = folio;
-		}
-
-		if (!folio) {
 			/*
 			 * Back out if somebody else faulted in this pte
 			 * while we released the pte lock.
diff --git a/mm/swap.h b/mm/swap.h
index ea4be4791394..f82d43d7b52a 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -55,9 +55,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
 				    struct mempolicy *mpol, pgoff_t ilx);
 struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
-			      struct vm_fault *vmf);
-struct page *swapin_no_readahead(swp_entry_t entry, gfp_t flag,
-				 struct vm_fault *vmf);
+			      struct vm_fault *vmf, bool *swapcached);
 
 static inline unsigned int folio_swap_flags(struct folio *folio)
 {
@@ -89,7 +87,7 @@ static inline struct page *swap_cluster_readahead(swp_entry_t entry,
 }
 
 static inline struct page *swapin_readahead(swp_entry_t swp, gfp_t gfp_mask,
-			struct vm_fault *vmf)
+			struct vm_fault *vmf, bool *swapcached)
 {
 	return NULL;
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 45dd8b7c195d..fd0047ae324e 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -316,6 +316,11 @@ void free_pages_and_swap_cache(struct encoded_page **pages, int nr)
 	release_pages(pages, nr);
 }
 
+static inline bool swap_use_no_readahead(struct swap_info_struct *si, swp_entry_t entry)
+{
+	return data_race(si->flags & SWP_SYNCHRONOUS_IO) && __swap_count(entry) == 1;
+}
+
 static inline bool swap_use_vma_readahead(void)
 {
 	return READ_ONCE(enable_vma_readahead) && !atomic_read(&nr_rotate_swap);
@@ -861,8 +866,8 @@ static struct page *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
  * Returns the struct page for entry and addr after the swap entry is read
  * in.
  */
-struct page *swapin_no_readahead(swp_entry_t entry, gfp_t gfp_mask,
-				 struct vm_fault *vmf)
+static struct page *swapin_no_readahead(swp_entry_t entry, gfp_t gfp_mask,
+					struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct page *page = NULL;
@@ -904,6 +909,8 @@ struct page *swapin_no_readahead(swp_entry_t entry, gfp_t gfp_mask,
  * @entry: swap entry of this memory
  * @gfp_mask: memory allocation flags
  * @vmf: fault information
+ * @swapcached: pointer to a bool used as indicator if the
+ *              page is swapped in through swapcache.
  *
  * Returns the struct page for entry and addr, after queueing swapin.
  *
@@ -912,17 +919,29 @@ struct page *swapin_no_readahead(swp_entry_t entry, gfp_t gfp_mask,
  * or vma-based(ie, virtual address based on faulty address) readahead.
  */
 struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
-				struct vm_fault *vmf)
+			      struct vm_fault *vmf, bool *swapcached)
 {
 	struct mempolicy *mpol;
-	pgoff_t ilx;
 	struct page *page;
+	pgoff_t ilx;
+	bool cached;
 
 	mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
-	page = swap_use_vma_readahead() ?
-		swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf) :
-		swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
+	if (swap_use_no_readahead(swp_swap_info(entry), entry)) {
+		page = swapin_no_readahead(entry, gfp_mask, vmf);
+		cached = false;
+	} else if (swap_use_vma_readahead()) {
+		page = swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf);
+		cached = true;
+	} else {
+		page = swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
+		cached = true;
+	}
 	mpol_cond_put(mpol);
+
+	if (swapcached)
+		*swapcached = cached;
+
 	return page;
 }
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 756104ebd585..0142bfc71b81 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1874,7 +1874,7 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			};
 
 			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
-						&vmf);
+						&vmf, NULL);
 			if (page)
 				folio = page_folio(page);
 		}
-- 
2.42.0

