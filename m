Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5874D7F0889
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 20:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjKSTsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 14:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjKSTsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 14:48:18 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB84196
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:12 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6bd32d1a040so3864878b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700423292; x=1701028092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NgugyapInVThiGa6OPAw9VMpbPbUYFH6tRNCt397cNY=;
        b=GObJgcqdCADqRZUeGgzpzML598kfsRjsx1/ApIwBRkwyRZfv4JTJNzzVMRhEGnYOus
         AZIRet3CKOI5UCSlWU96VblTv2eoDprSaflA2IPFtEpQBS907win5ArQrJ2GtII08ELF
         8Tf7VnsLtZNTyUJo4U0mYdFaQA7K11AgoSzwUjRIo6dq8XcT4Ny9Hn/E1IfhswM0AZ/y
         d5QLcXh8DgXNbdepUWhVDW+pNPyVPkVn3pYZdS4vySb6TYSwD1kN3nvKoTALAl3UT0fR
         Nf2IVyLuNlYmS33XSWQCC2cAr9yIrEPYBfB8dejDBsOqsSePzR6Js7Gk/KgfE4dJ6lvw
         qbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700423292; x=1701028092;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NgugyapInVThiGa6OPAw9VMpbPbUYFH6tRNCt397cNY=;
        b=ns/c3LVNwQPPucnVHnC5CZD5Ik3PBZEoAfA/LI7JONYthWx9wmeQGmOLCI6D/0Ke0P
         yRvbURQuiWteqxuKROTOdsXMCIXWyba8YYjSaiQitW/UUvdTLEknMKib1QpSnSfcpZsn
         +kUObfviycudohqu881n9YXMTJIQChyXCIOfZVP2yrC0LOllPNYZhoTOAKEh0NYcsTTs
         shPTNW0KqUnyHpLoDS6p/tIk+9cPm13eYWpM4jzfUlbmk8wq93RyGR+6uGbvf9aC4ubv
         GfHrfailACG3KyDJdQt4+M/z60rPjxfknj1viPMOgyUr40E11oBKH0OBjSJJXMnn8Bq7
         r9vA==
X-Gm-Message-State: AOJu0YyCmEi39P8k0/lAmouc+Tr2deMjjpDWh4yXeGMDolWRjdJND91n
        JGdMP3aQkeq6gjIWfxTqFHgsFreWPs1kb56R
X-Google-Smtp-Source: AGHT+IEheipTHeYRZdBVyN0mV2ARTS7XP+zRN1OT8UJpXXSOat4LuPJfFp26youNgVdlUjeMC3A1hA==
X-Received: by 2002:a05:6a20:e104:b0:18a:181b:146b with SMTP id kr4-20020a056a20e10400b0018a181b146bmr5052162pzb.29.1700423291675;
        Sun, 19 Nov 2023 11:48:11 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.40.79])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b006cb7feae74fsm1237140pfo.164.2023.11.19.11.48.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Nov 2023 11:48:11 -0800 (PST)
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
Subject: [PATCH 03/24] mm/swap: move no readahead swapin code to a stand alone helper
Date:   Mon, 20 Nov 2023 03:47:19 +0800
Message-ID: <20231119194740.94101-4-ryncsn@gmail.com>
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

No feature change, simply move the routine to a standalone function to
be used later. The error path handling is copied from the "out_page"
label, to make the code change minimized for easier reviewing.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/memory.c     | 33 +++++----------------------------
 mm/swap.h       |  2 ++
 mm/swap_state.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 28 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 70ffa867b1be..fba4a5229163 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3794,7 +3794,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	swp_entry_t entry;
 	pte_t pte;
 	vm_fault_t ret = 0;
-	void *shadow = NULL;
 
 	if (!pte_unmap_same(vmf))
 		goto out;
@@ -3858,33 +3857,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (!folio) {
 		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
 		    __swap_count(entry) == 1) {
-			/* skip swapcache */
-			folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
-						vma, vmf->address, false);
-			if (folio) {
-				__folio_set_locked(folio);
-				__folio_set_swapbacked(folio);
-
-				if (mem_cgroup_swapin_charge_folio(folio,
-							vma->vm_mm, GFP_KERNEL,
-							entry)) {
-					ret = VM_FAULT_OOM;
-					goto out_page;
-				}
-				mem_cgroup_swapin_uncharge_swap(entry);
-
-				shadow = get_shadow_from_swap_cache(entry);
-				if (shadow)
-					workingset_refault(folio, shadow);
-
-				folio_add_lru(folio);
-				page = &folio->page;
-
-				/* To provide entry to swap_readpage() */
-				folio->swap = entry;
-				swap_readpage(page, true, NULL);
-				folio->private = NULL;
-			}
+			/* skip swapcache and readahead */
+			page = swapin_no_readahead(entry, GFP_HIGHUSER_MOVABLE,
+						vmf);
+			if (page)
+				folio = page_folio(page);
 		} else {
 			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
 						vmf);
diff --git a/mm/swap.h b/mm/swap.h
index 73c332ee4d91..ea4be4791394 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -56,6 +56,8 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
 				    struct mempolicy *mpol, pgoff_t ilx);
 struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
 			      struct vm_fault *vmf);
+struct page *swapin_no_readahead(swp_entry_t entry, gfp_t flag,
+				 struct vm_fault *vmf);
 
 static inline unsigned int folio_swap_flags(struct folio *folio)
 {
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 85d9e5806a6a..ac4fa404eaa7 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -853,6 +853,54 @@ static struct page *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 	return page;
 }
 
+/**
+ * swapin_no_readahead - swap in pages skipping swap cache and readahead
+ * @entry: swap entry of this memory
+ * @gfp_mask: memory allocation flags
+ * @vmf: fault information
+ *
+ * Returns the struct page for entry and addr after the swap entry is read
+ * in.
+ */
+struct page *swapin_no_readahead(swp_entry_t entry, gfp_t gfp_mask,
+				 struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct page *page = NULL;
+	struct folio *folio;
+	void *shadow = NULL;
+
+	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
+				vma, vmf->address, false);
+	if (folio) {
+		__folio_set_locked(folio);
+		__folio_set_swapbacked(folio);
+
+		if (mem_cgroup_swapin_charge_folio(folio,
+					vma->vm_mm, GFP_KERNEL,
+					entry)) {
+			folio_unlock(folio);
+			folio_put(folio);
+			return NULL;
+		}
+		mem_cgroup_swapin_uncharge_swap(entry);
+
+		shadow = get_shadow_from_swap_cache(entry);
+		if (shadow)
+			workingset_refault(folio, shadow);
+
+		folio_add_lru(folio);
+
+		/* To provide entry to swap_readpage() */
+		folio->swap = entry;
+		page = &folio->page;
+		swap_readpage(page, true, NULL);
+		folio->private = NULL;
+	}
+
+	return page;
+}
+
 /**
  * swapin_readahead - swap in pages in hope we need them soon
  * @entry: swap entry of this memory
-- 
2.42.0

