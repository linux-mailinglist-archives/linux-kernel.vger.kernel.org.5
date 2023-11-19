Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0307F0899
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 20:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjKSTtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 14:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjKSTtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 14:49:19 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4722AD56
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:54 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-3574297c79eso14110605ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700423333; x=1701028133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9XjpTi/p1jP45iq6KrQ/NXIY9Wo9hQ4YnGSNNoLyAOA=;
        b=OV7vKBtM8QcyzCdAPX2k3P2b3HevaAp9wu9iHRuPa4/0gMJrOxaOgeg65Tr1JJe1az
         6BwJEQF+1Af6fYV3TsevmGa7AH1ExN4MdYI31HH5+ab0NH+IkFs1c7pLpU9XZ9pX3oH3
         rpkZ8mxpfjHMDLoBM6FMz2uBdiOjmJyWRkYw1aoCarjmAIVDTvh6z4+0ju77seNKv5YG
         vV5faKNmy6+it8DLlGQLOVFDPo366HXhDSM9+z1FqOcmluCS116AAO8YpiJ72+Co/pVX
         Yib44qDni3Y9lU6gKm0XMhBsjCQex8HvlnBJvejLCKAD3g5NdTgJVPGG6f8lSRm0fuXX
         oxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700423333; x=1701028133;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9XjpTi/p1jP45iq6KrQ/NXIY9Wo9hQ4YnGSNNoLyAOA=;
        b=w4wKDOuyZVN8Aj4Yv6ZQNVsiuosFV+IQgxpljsh6psSPUU6TzRBYhKDU07+Z9u6+0t
         URQzsnwB0Mg4hGwbBICrZXAjgAwJDl7S5owrSqrkdKvWgCfEE5htUQn/0BLwKCmc7s/+
         A/EmIYJQhkTiCNeX6U/lrckFcwo3vsPS3a23szzhe0gGoAH7rpxhbzpIwNdKeoNSIxQA
         l0pvzAzHanw2YxfN3DKWkP/v62mAuDu5AhklBD+Md1mJHBX5efnu5QPKi1+HFf5a7TiZ
         hJo2H4jFJJxIVcuRtvrmgsH6V6xtPEX9q3VsfYUWlfMGK9KkF2wt0+i4NOK7ldklE6fw
         IHIg==
X-Gm-Message-State: AOJu0YyAZ23s7N/L4ATLeQE0e4DHZ1iN8Lt5mshtLWZIsCt7wRtSNefy
        +QCdFF2SO1bHJ17c5oPD/ng=
X-Google-Smtp-Source: AGHT+IFar6VHQuFklPrfy7vOCI8aqHj+K8WskagViLl4BbbPZwTP7uc43B3VnuoR6l/B/N6mqJ6dzw==
X-Received: by 2002:a92:7a06:0:b0:359:5389:c0dc with SMTP id v6-20020a927a06000000b003595389c0dcmr6674915ilc.7.1700423333536;
        Sun, 19 Nov 2023 11:48:53 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.40.79])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b006cb7feae74fsm1237140pfo.164.2023.11.19.11.48.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Nov 2023 11:48:52 -0800 (PST)
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
Subject: [PATCH 16/24] mm/swap: reduce scope of get_swap_device in swapin path
Date:   Mon, 20 Nov 2023 03:47:32 +0800
Message-ID: <20231119194740.94101-17-ryncsn@gmail.com>
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

Move get_swap_device into swapin_readahead, simplify the code
and prepare for follow up commits.

For the later part in do_swap_page, using swp_swap_info directly is fine
since in that context, the swap device is pinned by swapcache reference.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/memory.c     | 16 ++++------------
 mm/swap_state.c |  8 ++++++--
 mm/swapfile.c   |  4 +++-
 3 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 22af9f3e8c75..e399b37ef395 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3789,7 +3789,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	struct folio *swapcache = NULL, *folio = NULL;
 	enum swap_cache_result cache_result;
 	struct page *page;
-	struct swap_info_struct *si = NULL;
 	rmap_t rmap_flags = RMAP_NONE;
 	bool exclusive = false;
 	swp_entry_t entry;
@@ -3845,14 +3844,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out;
 	}
 
-	/* Prevent swapoff from happening to us. */
-	si = get_swap_device(entry);
-	if (unlikely(!si))
-		goto out;
-
 	page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
 				vmf, &cache_result);
-	if (page) {
+	if (PTR_ERR(page) == -EBUSY) {
+		goto out;
+	} else if (page) {
 		folio = page_folio(page);
 		if (cache_result != SWAP_CACHE_HIT) {
 			/* Had to read the page from swap area: Major fault */
@@ -3964,7 +3960,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			 */
 			exclusive = true;
 		} else if (exclusive && folio_test_writeback(folio) &&
-			  data_race(si->flags & SWP_STABLE_WRITES)) {
+			   (swp_swap_info(entry)->flags & SWP_STABLE_WRITES)) {
 			/*
 			 * This is tricky: not all swap backends support
 			 * concurrent page modifications while under writeback.
@@ -4068,8 +4064,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (vmf->pte)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 out:
-	if (si)
-		put_swap_device(si);
 	return ret;
 out_nomap:
 	if (vmf->pte)
@@ -4082,8 +4076,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		folio_unlock(swapcache);
 		folio_put(swapcache);
 	}
-	if (si)
-		put_swap_device(si);
 	return ret;
 }
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 51de2a0412df..ff8a166603d0 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -922,6 +922,11 @@ struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	struct page *page;
 	pgoff_t ilx;
 
+	/* Prevent swapoff from happening to us */
+	si = get_swap_device(entry);
+	if (unlikely(!si))
+		return ERR_PTR(-EBUSY);
+
 	folio = swap_cache_get_folio(entry, vmf, &shadow);
 	if (folio) {
 		page = folio_file_page(folio, swp_offset(entry));
@@ -929,7 +934,6 @@ struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
 		goto done;
 	}
 
-	si = swp_swap_info(entry);
 	mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
 	if (swap_use_no_readahead(si, swp_offset(entry))) {
 		page = swapin_no_readahead(entry, gfp_mask, mpol, ilx, vmf->vma->vm_mm);
@@ -944,8 +948,8 @@ struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
 		cache_result = SWAP_CACHE_MISS;
 	}
 	mpol_cond_put(mpol);
-
 done:
+	put_swap_device(si);
 	if (result)
 		*result = cache_result;
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index b6d57fff5e21..925ad92486a4 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1857,7 +1857,9 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		pte = NULL;
 		page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
 					&vmf, NULL);
-		if (page)
+		if (IS_ERR(page))
+			return PTR_ERR(page);
+		else if (page)
 			folio = page_folio(page);
 		if (!folio) {
 			/*
-- 
2.42.0

