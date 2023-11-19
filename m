Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290E27F08A4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 20:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjKSTuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 14:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjKSTuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 14:50:05 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB17E171E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:49:19 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b2e4107f47so2778864b6e.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700423359; x=1701028159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ujyhaBmVKqUCILaG0//cQCFqqP/+VsPiP59qcIbNEbE=;
        b=fX0Qw+daECB1rjTwNoau70a5cC0VHEPhHZPMPF3Y4iA51CSDOJ/i8EPffWP3fHqtDR
         Ws803bFEgujnXb4Qcmmc5kvfCykRnh8s9YfTLjenNd0xIUC6p3tMyTOIB4NEbu8VvBiM
         XQk08s+K22SPV6bSTWAry3AhQhVhBtjIPBy5hO0/1z/ixGYD5icy0PoTl73jNlU4bO94
         wkwhj5UmkiGuyTlq5UcYnWF745ih4oBi7GRSNfHJ3xDJEbBBbcrttCmlFUx4jTV1mYDU
         rHDpRgtYBZ634H2Bq3IbzKPAC7yq6uvjIaMNUbl0S3tn1X3O2JEAO4aukOQ+52j++IGC
         8xAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700423359; x=1701028159;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ujyhaBmVKqUCILaG0//cQCFqqP/+VsPiP59qcIbNEbE=;
        b=cxqKx6FtQlbcby+UVIL0PKP9YTvmaAQnrq6zO6ICJ7SST9tOMhFfKl//Mn1H7y0opW
         Lg6neE4lG80XVbhXOXTPbXmn0RVAvbiM3NAl5uE6IfecXMxoN6DVC6Vq97RibBjuv90k
         vmR5kGPa8YTkspP2z/jsZevegXmh1K7iqS/8wgqHB8vdR2uXuVH4YdGYJAFRjk0JAx0A
         LFfC/gkd10oeBMKhVGepO22P5ZfMaE50csm08ETgFq/DcuJJ7m3ydtYTrHyJOA8OX6lY
         eMWScE2lJyEK1c6OW7gc+iUF7iJ3KvsZIr/Xlt1IA7ZGOfuRKo3LCN0BnlqTINZRv2Sp
         HciQ==
X-Gm-Message-State: AOJu0YzH1pIthriCU/JeyE2uX5r0YOGCCOMVj6yxv065ncJakHz1zZou
        ebZkGmVjz6gjY8FoU2NQuLpSl7WClKC2+01u
X-Google-Smtp-Source: AGHT+IG9ZMvtFIPRmfdYGQxFIrUp0PVcy1icQvi67iQPNdmmyu8YtKZdvx7dJGBXf+Hyuvvv17Q3Eg==
X-Received: by 2002:a05:6808:2389:b0:3b5:75d3:14aa with SMTP id bp9-20020a056808238900b003b575d314aamr9092741oib.25.1700423359201;
        Sun, 19 Nov 2023 11:49:19 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.40.79])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b006cb7feae74fsm1237140pfo.164.2023.11.19.11.49.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Nov 2023 11:49:18 -0800 (PST)
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
Subject: [PATCH 24/24] mm/swap: change swapin_readahead to swapin_page_fault
Date:   Mon, 20 Nov 2023 03:47:40 +0800
Message-ID: <20231119194740.94101-25-ryncsn@gmail.com>
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

Now swapin_readahead is only called from direct page fault path, so
rename it and drop the gfp argument, since there is only one caller
always using the same flag for userspace page fault.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/memory.c     |  4 ++--
 mm/swap.h       |  6 +++---
 mm/swap_state.c | 15 +++++++++------
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 620fa87557fd..4907a5b1b75b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3844,8 +3844,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out;
 	}
 
-	page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
-				vmf, &cache_result);
+	page = swapin_page_fault(entry, GFP_HIGHUSER_MOVABLE,
+				 vmf, &cache_result);
 	if (IS_ERR_OR_NULL(page)) {
 		/*
 		 * Back out if somebody else faulted in this pte
diff --git a/mm/swap.h b/mm/swap.h
index 4374bf11ca41..2f8f8befff89 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -56,8 +56,8 @@ struct page *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 				     struct mempolicy *mpol, pgoff_t ilx,
 				     struct mm_struct *mm, bool *new_page_allocated);
-struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
-			      struct vm_fault *vmf, enum swap_cache_result *result);
+struct page *swapin_page_fault(swp_entry_t entry, gfp_t flag,
+			       struct vm_fault *vmf, enum swap_cache_result *result);
 struct page *swapin_page_non_fault(swp_entry_t entry, gfp_t gfp_mask,
 				   struct mempolicy *mpol, pgoff_t ilx,
 				   struct mm_struct *mm,
@@ -91,7 +91,7 @@ static inline void show_swap_cache_info(void)
 {
 }
 
-static inline struct page *swapin_readahead(swp_entry_t swp, gfp_t gfp_mask,
+static inline struct page *swapin_page_fault(swp_entry_t swp, gfp_t gfp_mask,
 			struct vm_fault *vmf, enum swap_cache_result *result)
 {
 	return NULL;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 362a6f674b36..2f51d2e64e59 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -899,7 +899,7 @@ static struct page *swapin_no_readahead(swp_entry_t entry, gfp_t gfp_mask,
 }
 
 /**
- * swapin_readahead - swap in pages in hope we need them soon
+ * swapin_page_fault - swap in a page from page fault context
  * @entry: swap entry of this memory
  * @gfp_mask: memory allocation flags
  * @vmf: fault information
@@ -911,8 +911,8 @@ static struct page *swapin_no_readahead(swp_entry_t entry, gfp_t gfp_mask,
  * it will read ahead blocks by cluster-based(ie, physical disk based)
  * or vma-based(ie, virtual address based on faulty address) readahead.
  */
-struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
-			      struct vm_fault *vmf, enum swap_cache_result *result)
+struct page *swapin_page_fault(swp_entry_t entry, gfp_t gfp_mask,
+			       struct vm_fault *vmf, enum swap_cache_result *result)
 {
 	struct swap_info_struct *si;
 	struct mempolicy *mpol;
@@ -936,15 +936,18 @@ struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
 	if (swap_use_no_readahead(si, swp_offset(entry))) {
 		*result = SWAP_CACHE_BYPASS;
-		page = swapin_no_readahead(entry, gfp_mask, mpol, ilx, vmf->vma->vm_mm);
+		page = swapin_no_readahead(entry, GFP_HIGHUSER_MOVABLE,
+					   mpol, ilx, vmf->vma->vm_mm);
 		if (shadow)
 			workingset_refault(page_folio(page), shadow);
 	} else {
 		*result = SWAP_CACHE_MISS;
 		if (swap_use_vma_readahead(si))
-			page = swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf);
+			page = swap_vma_readahead(entry, GFP_HIGHUSER_MOVABLE,
+						  mpol, ilx, vmf);
 		else
-			page = swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
+			page = swap_cluster_readahead(entry, GFP_HIGHUSER_MOVABLE,
+						      mpol, ilx, vmf->vma->vm_mm);
 	}
 	mpol_cond_put(mpol);
 done:
-- 
2.42.0

