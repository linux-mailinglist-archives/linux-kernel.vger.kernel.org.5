Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD057F089B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 20:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjKSTuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 14:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjKSTtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 14:49:36 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A90D78
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:49:00 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6c396ef9a3dso3070117b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700423340; x=1701028140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ogKmBoCop4FjzMsXxzq+m99gJioFg3IUepp9Cnvtmi4=;
        b=NT0k2DETo/JYhGoZQ4D+JumGWDBfOY/56XsePUpsVAtRJmYdQk5TTXqqAJ1s9666nv
         sinsGxqPSBJrDP2+9F+KHJa1JXBrgXoqEe9VBaSDupZgufHG9KOIqIMISmIp3uQLO0RC
         AZVh+0Y0gkXcn/oaDGpZU4DRnbptL88CNGcb+Jmku6wCPRJgX4O9a4HRLuo52rR6vQwg
         Ez+BTVheKCadcnoUPjfqacuJ9BDnhknie24MJp6TPHjAmplsNhHazcPd/B9Z0UsSG5yT
         z2Tu2pBqFZjZSLjeDEr50AxaIfSVjoUHaC42f/Y9OALZJ1EiktzwAlAyH7ktbeS6N7Ju
         dQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700423340; x=1701028140;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ogKmBoCop4FjzMsXxzq+m99gJioFg3IUepp9Cnvtmi4=;
        b=d2A6+cxVQoy7DZF/jLhRZ0CHramW+Xe3wMpRDQMCWKmpPmut80IEf9E4Poti5nC9/R
         svmdQPpCjpg6ZOvisJnklNXyFD254STt5XQ7BggF47VZjTJstda2NbBI2OyRv/DIpFSO
         jOHnbhq5G0RVtGuB8IXmiw+1DNrbueZQKkVaTKQEnkh6+Q/57X7DtGb80t3+q5Bvjl88
         71dCdLZP83Hhk2XfM87LrVjd/A3ulYB2zOIxFitnLLP0B7YjGSF3orO8cDX3p/r7vTOA
         gICsEpGdN3mt13Yvs8OM/CWFTfl42HtWk3TnktcEzZBUER1zk7Py61CvsrXqg6rGl3kY
         IBMA==
X-Gm-Message-State: AOJu0YzJc0c6hdbX0b6qOoeuwF9u5xpOrPQy2l0cccFq+MDNzJ3CtqCx
        gyeKeXxMzztncaPsgHeaISo=
X-Google-Smtp-Source: AGHT+IEtFX0YlsrOdaCPyUWZ1WjriHhJN7FSpvj0uTb3jwG62CN+QG7TWo6/q5IUmUrNJVLup3+uwA==
X-Received: by 2002:a05:6a00:301d:b0:693:3c11:4293 with SMTP id ay29-20020a056a00301d00b006933c114293mr4840721pfb.14.1700423339887;
        Sun, 19 Nov 2023 11:48:59 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.40.79])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b006cb7feae74fsm1237140pfo.164.2023.11.19.11.48.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Nov 2023 11:48:59 -0800 (PST)
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
Subject: [PATCH 18/24] mm/swap: introduce a helper non fault swapin
Date:   Mon, 20 Nov 2023 03:47:34 +0800
Message-ID: <20231119194740.94101-19-ryncsn@gmail.com>
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

There are two places where swapin is not direct caused by page fault:
shmem swapin is invoked through shmem mapping, swapoff cause swapin by
walking the page table. They used to construct a pseudo vmfault struct
for swapin function.

Shmem has dropped the pseudo vmfault recently in commit ddc1a5cbc05d
("mempolicy: alloc_pages_mpol() for NUMA policy without vma"). Swapoff
path is still using a pseudo vmfault.

Introduce a helper for them both, this help save stack usage for swapoff
path, and help apply a unified swapin cache and readahead policy check.

Also prepare for follow up commits.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/shmem.c      | 51 ++++++++++++++++---------------------------------
 mm/swap.h       | 11 +++++++++++
 mm/swap_state.c | 38 ++++++++++++++++++++++++++++++++++++
 mm/swapfile.c   | 23 +++++++++++-----------
 4 files changed, 76 insertions(+), 47 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index f9ce4067c742..81d129aa66d1 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1565,22 +1565,6 @@ static inline struct mempolicy *shmem_get_sbmpol(struct shmem_sb_info *sbinfo)
 static struct mempolicy *shmem_get_pgoff_policy(struct shmem_inode_info *info,
 			pgoff_t index, unsigned int order, pgoff_t *ilx);
 
-static struct folio *shmem_swapin_cluster(swp_entry_t swap, gfp_t gfp,
-			struct shmem_inode_info *info, pgoff_t index)
-{
-	struct mempolicy *mpol;
-	pgoff_t ilx;
-	struct page *page;
-
-	mpol = shmem_get_pgoff_policy(info, index, 0, &ilx);
-	page = swap_cluster_readahead(swap, gfp, mpol, ilx);
-	mpol_cond_put(mpol);
-
-	if (!page)
-		return NULL;
-	return page_folio(page);
-}
-
 /*
  * Make sure huge_gfp is always more limited than limit_gfp.
  * Some of the flags set permissions, while others set limitations.
@@ -1854,9 +1838,12 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct shmem_inode_info *info = SHMEM_I(inode);
-	struct swap_info_struct *si;
+	enum swap_cache_result result;
 	struct folio *folio = NULL;
+	struct mempolicy *mpol;
+	struct page *page;
 	swp_entry_t swap;
+	pgoff_t ilx;
 	int error;
 
 	VM_BUG_ON(!*foliop || !xa_is_value(*foliop));
@@ -1866,34 +1853,30 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	if (is_poisoned_swp_entry(swap))
 		return -EIO;
 
-	si = get_swap_device(swap);
-	if (!si) {
+	mpol = shmem_get_pgoff_policy(info, index, 0, &ilx);
+	page = swapin_page_non_fault(swap, gfp, mpol, ilx, fault_mm, &result);
+	mpol_cond_put(mpol);
+
+	if (PTR_ERR(page) == -EBUSY) {
 		if (!shmem_confirm_swap(mapping, index, swap))
 			return -EEXIST;
 		else
 			return -EINVAL;
-	}
-
-	/* Look it up and read it in.. */
-	folio = swap_cache_get_folio(swap, NULL, NULL);
-	if (!folio) {
-		/* Or update major stats only when swapin succeeds?? */
-		if (fault_type) {
+	} else if (!page) {
+		error = -ENOMEM;
+		goto failed;
+	} else {
+		folio = page_folio(page);
+		if (fault_type && result != SWAP_CACHE_HIT) {
 			*fault_type |= VM_FAULT_MAJOR;
 			count_vm_event(PGMAJFAULT);
 			count_memcg_event_mm(fault_mm, PGMAJFAULT);
 		}
-		/* Here we actually start the io */
-		folio = shmem_swapin_cluster(swap, gfp, info, index);
-		if (!folio) {
-			error = -ENOMEM;
-			goto failed;
-		}
 	}
 
 	/* We have to do this with folio locked to prevent races */
 	folio_lock(folio);
-	if (!folio_test_swapcache(folio) ||
+	if ((result != SWAP_CACHE_BYPASS && !folio_test_swapcache(folio)) ||
 	    folio->swap.val != swap.val ||
 	    !shmem_confirm_swap(mapping, index, swap)) {
 		error = -EEXIST;
@@ -1930,7 +1913,6 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	delete_from_swap_cache(folio);
 	folio_mark_dirty(folio);
 	swap_free(swap);
-	put_swap_device(si);
 
 	*foliop = folio;
 	return 0;
@@ -1944,7 +1926,6 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 		folio_unlock(folio);
 		folio_put(folio);
 	}
-	put_swap_device(si);
 
 	return error;
 }
diff --git a/mm/swap.h b/mm/swap.h
index da9deb5ba37d..b073c29c9790 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -62,6 +62,10 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
 				    struct mempolicy *mpol, pgoff_t ilx);
 struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
 			      struct vm_fault *vmf, enum swap_cache_result *result);
+struct page *swapin_page_non_fault(swp_entry_t entry, gfp_t gfp_mask,
+				   struct mempolicy *mpol, pgoff_t ilx,
+				   struct mm_struct *mm,
+				   enum swap_cache_result *result);
 
 static inline unsigned int folio_swap_flags(struct folio *folio)
 {
@@ -103,6 +107,13 @@ static inline struct page *swapin_readahead(swp_entry_t swp, gfp_t gfp_mask,
 	return NULL;
 }
 
+static inline struct page *swapin_page_non_fault(swp_entry_t entry, gfp_t gfp_mask,
+		struct mempolicy *mpol, pgoff_t ilx, struct mm_struct *mm,
+		enum swap_cache_result *result)
+{
+	return NULL;
+}
+
 static inline int swap_writepage(struct page *p, struct writeback_control *wbc)
 {
 	return 0;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index ff8a166603d0..eef66757c615 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -956,6 +956,44 @@ struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	return page;
 }
 
+struct page *swapin_page_non_fault(swp_entry_t entry, gfp_t gfp_mask,
+				   struct mempolicy *mpol, pgoff_t ilx,
+				   struct mm_struct *mm, enum swap_cache_result *result)
+{
+	enum swap_cache_result cache_result;
+	struct swap_info_struct *si;
+	void *shadow = NULL;
+	struct folio *folio;
+	struct page *page;
+
+	/* Prevent swapoff from happening to us */
+	si = get_swap_device(entry);
+	if (unlikely(!si))
+		return ERR_PTR(-EBUSY);
+
+	folio = swap_cache_get_folio(entry, NULL, &shadow);
+	if (folio) {
+		page = folio_file_page(folio, swp_offset(entry));
+		cache_result = SWAP_CACHE_HIT;
+		goto done;
+	}
+
+	if (swap_use_no_readahead(si, swp_offset(entry))) {
+		page = swapin_no_readahead(entry, gfp_mask, mpol, ilx, mm);
+		if (shadow)
+			workingset_refault(page_folio(page), shadow);
+		cache_result = SWAP_CACHE_BYPASS;
+	} else {
+		page = swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
+		cache_result = SWAP_CACHE_MISS;
+	}
+done:
+	put_swap_device(si);
+	if (result)
+		*result = cache_result;
+	return page;
+}
+
 #ifdef CONFIG_SYSFS
 static ssize_t vma_ra_enabled_show(struct kobject *kobj,
 				     struct kobj_attribute *attr, char *buf)
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 925ad92486a4..f8c5096fe0f0 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1822,20 +1822,15 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 
 	si = swap_info[type];
 	do {
+		int ret;
+		pte_t ptent;
+		pgoff_t ilx;
+		swp_entry_t entry;
 		struct page *page;
 		unsigned long offset;
+		struct mempolicy *mpol;
 		unsigned char swp_count;
 		struct folio *folio = NULL;
-		swp_entry_t entry;
-		int ret;
-		pte_t ptent;
-
-		struct vm_fault vmf = {
-			.vma = vma,
-			.address = addr,
-			.real_address = addr,
-			.pmd = pmd,
-		};
 
 		if (!pte++) {
 			pte = pte_offset_map(pmd, addr);
@@ -1855,8 +1850,12 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		offset = swp_offset(entry);
 		pte_unmap(pte);
 		pte = NULL;
-		page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
-					&vmf, NULL);
+
+		mpol = get_vma_policy(vma, addr, 0, &ilx);
+		page = swapin_page_non_fault(entry, GFP_HIGHUSER_MOVABLE,
+					     mpol, ilx, vma->vm_mm, NULL);
+		mpol_cond_put(mpol);
+
 		if (IS_ERR(page))
 			return PTR_ERR(page);
 		else if (page)
-- 
2.42.0

