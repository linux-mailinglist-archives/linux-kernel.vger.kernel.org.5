Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FED7F08A2
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 20:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjKSTuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 14:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjKSTuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 14:50:02 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9513710C0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:49:16 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b709048f32so3117372b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700423356; x=1701028156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VWrBT21AdvUolArI+Vamx/Z+QXIBnOosXdhjX6fE5gQ=;
        b=llCCsuesSJyPuyRFTLv8zFEmg274BkyFCpdLGpGF3QZ/aVnQaB+b6VShm6BQkURq0r
         0yZIb1FpJ6Vd5DSIo+ipxGVOQ7j5r4vTauzyN0Kkmzt8Ex0ited9OJ9b3Wf5IzmgxJ8Q
         nmRE88aq5dMmiOLORI01TSSnszaSgN7HKmSX9UQrfB8GvMLuhIckKTVUgwllptiawseb
         omx+/XZX5dzi0b+dmJjTDxnUqr6TNyKCggrpovEC09puWo54Ce6cjptMVeOded2FrN/k
         iXlXAKtRy2SqCCpVpIT+TvpHzO6Qa+ARpxdNyo1IuKaZVUzpuRVII0X5eOZm0I9WxCw9
         J8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700423356; x=1701028156;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VWrBT21AdvUolArI+Vamx/Z+QXIBnOosXdhjX6fE5gQ=;
        b=j98dgkOL6X7iHe1yf52yqm8iId3Z/rp+zwTfhHlo6/J19UdTH0/pq3Jkhbp73znLV/
         KrTgnsCRhN9lZRqjImmp0ezkik7jS/Zv5RDWya6lFkOaPoceGQaQDx4PTPzEgY1QgWT7
         2zCkx95YWa/LMngZjpG8CvT7JCgnLPj2CvmYeKwWVyHSuU5smZW4kB3Bvnel0wiDXsxS
         cU/VXKZ4BKlZNRtfN1VRS0fqBS+ngvVcXaar3CtwU3+ySxmZT01GktH4RIkGi6Sjtx6c
         v/Kic7uLFxwA7WkSzSBJxbEPNMzH64P0DLOi2j4NJW+f5giKCN4IuPBn4xKe7O59SfD4
         GlnA==
X-Gm-Message-State: AOJu0Ywbu2at4Pgg60ZhDwbMUJzq7gRqV7LbXVsFXPQLJpiqZplpvTQ2
        Q0gLE++NEAOo74EY5ECSwOc=
X-Google-Smtp-Source: AGHT+IGWIkDwN2GaIA67iopevmfTqkLtEBcX4Ge5hWNRIHGYUTrFSZBXVCdyc6Dj2MoCIbUQoxa2mw==
X-Received: by 2002:a05:6a00:3492:b0:6cb:a0dc:3d56 with SMTP id cp18-20020a056a00349200b006cba0dc3d56mr660136pfb.0.1700423355969;
        Sun, 19 Nov 2023 11:49:15 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.40.79])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b006cb7feae74fsm1237140pfo.164.2023.11.19.11.49.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Nov 2023 11:49:15 -0800 (PST)
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
Subject: [PATCH 23/24] swap: fix multiple swap leak when after cgroup migrate
Date:   Mon, 20 Nov 2023 03:47:39 +0800
Message-ID: <20231119194740.94101-24-ryncsn@gmail.com>
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

When a process which previously swapped some memory was moved to
another cgroup, and the cgroup it previous in is dead, then swapped in
pages will be leaked into rootcg. Previous commits fixed the bug for
no readahead path, this commit fix the same issue for readahead path.

This can be easily reproduced by:
- Setup a SSD or HDD swap.
- Create memory cgroup A, B and C.
- Spawn process P1 in cgroup A and make it swap out some pages.
- Move process P1 to memory cgroup B.
- Destroy cgroup A.
- Do a swapoff in cgroup C
- Swapped in pages is accounted into cgroup C.

This patch will fix it make the swapped in pages accounted in cgroup B.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap.h       |  2 +-
 mm/swap_state.c | 19 ++++++++++---------
 mm/zswap.c      |  2 +-
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index 795a25df87da..4374bf11ca41 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -55,7 +55,7 @@ struct page *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 				   struct swap_iocb **plug);
 struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 				     struct mempolicy *mpol, pgoff_t ilx,
-				     bool *new_page_allocated);
+				     struct mm_struct *mm, bool *new_page_allocated);
 struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
 			      struct vm_fault *vmf, enum swap_cache_result *result);
 struct page *swapin_page_non_fault(swp_entry_t entry, gfp_t gfp_mask,
diff --git a/mm/swap_state.c b/mm/swap_state.c
index b377e55cb850..362a6f674b36 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -416,7 +416,7 @@ struct folio *filemap_get_incore_folio(struct address_space *mapping,
 
 struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 				     struct mempolicy *mpol, pgoff_t ilx,
-				     bool *new_page_allocated)
+				     struct mm_struct *mm, bool *new_page_allocated)
 {
 	struct swap_info_struct *si;
 	struct folio *folio;
@@ -462,7 +462,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 						mpol, ilx, numa_node_id());
 		if (!folio)
                         goto fail_put_swap;
-		if (mem_cgroup_swapin_charge_folio(folio, NULL, gfp_mask, entry))
+		if (mem_cgroup_swapin_charge_folio(folio, mm, gfp_mask, entry))
 			goto fail_put_folio;
 
 		/*
@@ -540,7 +540,7 @@ struct page *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 
 	mpol = get_vma_policy(vma, addr, 0, &ilx);
 	page = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
-					&page_allocated);
+				       vma->vm_mm, &page_allocated);
 	mpol_cond_put(mpol);
 
 	if (page_allocated)
@@ -628,7 +628,8 @@ static unsigned long swapin_nr_pages(unsigned long offset)
  * are fairly likely to have been swapped out from the same node.
  */
 static struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
-					   struct mempolicy *mpol, pgoff_t ilx)
+					   struct mempolicy *mpol, pgoff_t ilx,
+					   struct mm_struct *mm)
 {
 	struct page *page;
 	unsigned long entry_offset = swp_offset(entry);
@@ -657,7 +658,7 @@ static struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 		/* Ok, do the async read-ahead now */
 		page = __read_swap_cache_async(
 				swp_entry(swp_type(entry), offset),
-				gfp_mask, mpol, ilx, &page_allocated);
+				gfp_mask, mpol, ilx, mm, &page_allocated);
 		if (!page)
 			continue;
 		if (page_allocated) {
@@ -675,7 +676,7 @@ static struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 skip:
 	/* The page was likely read above, so no need for plugging here */
 	page = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
-					&page_allocated);
+				       mm, &page_allocated);
 	if (unlikely(page_allocated))
 		swap_readpage(page, false, NULL);
 	return page;
@@ -830,7 +831,7 @@ static struct page *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 		pte_unmap(pte);
 		pte = NULL;
 		page = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
-						&page_allocated);
+					       vmf->vma->vm_mm, &page_allocated);
 		if (!page)
 			continue;
 		if (page_allocated) {
@@ -850,7 +851,7 @@ static struct page *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 skip:
 	/* The page was likely read above, so no need for plugging here */
 	page = __read_swap_cache_async(targ_entry, gfp_mask, mpol, targ_ilx,
-					&page_allocated);
+				       vmf->vma->vm_mm, &page_allocated);
 	if (unlikely(page_allocated))
 		swap_readpage(page, false, NULL);
 	return page;
@@ -980,7 +981,7 @@ struct page *swapin_page_non_fault(swp_entry_t entry, gfp_t gfp_mask,
 			workingset_refault(page_folio(page), shadow);
 		cache_result = SWAP_CACHE_BYPASS;
 	} else {
-		page = swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
+		page = swap_cluster_readahead(entry, gfp_mask, mpol, ilx, mm);
 		cache_result = SWAP_CACHE_MISS;
 	}
 done:
diff --git a/mm/zswap.c b/mm/zswap.c
index 030cc137138f..e2712ff169b1 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1081,7 +1081,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	/* try to allocate swap cache page */
 	mpol = get_task_policy(current);
 	page = __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
-				NO_INTERLEAVE_INDEX, &page_was_allocated);
+				NO_INTERLEAVE_INDEX, NULL, &page_was_allocated);
 	if (!page) {
 		ret = -ENOMEM;
 		goto fail;
-- 
2.42.0

