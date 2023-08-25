Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29A6788582
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 13:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241562AbjHYLTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 07:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243123AbjHYLTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:19:20 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6817E1FDE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:18:53 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31c79850df5so657777f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692962332; x=1693567132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6ewY66oYf3vDH9aPoj7pb9ZlWRxktJaiCYaiSDx5Sk=;
        b=KyUsO0r4rRvScvgaql7Mq5sBM59AgdiLlku31XVLehfo/OyOKwTeyZBHqhENtKIEl9
         P3ymLBkS3If/LAKRNANtlRWYrskCp2K3RSSWfZcBfwGiK9kYFXjQDHz7qE2ymRYfFUMn
         uUbWss9XFgzITSidEKkZUWaJh7avtNC9lP7769KoK82tO41UWCXcLCs+4Xm8A5SkBzXK
         RYBbCFiYgMht2pLOGOKshr6GOT8+pWg3D47dUqEho1eTmsge1mAirZ0LvqexlT/0jC5M
         TYPbzcJPLn+3vaif0HDBwx0dC08rv+ZWDWMU5TML4/SojKT5VJpBFSDMRI3vpn/dt11/
         wBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692962332; x=1693567132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6ewY66oYf3vDH9aPoj7pb9ZlWRxktJaiCYaiSDx5Sk=;
        b=QTthRpqfQprC+8HObVMngMV6VLH8JOlTSwpTynXdg+4CA0zeU6QYY3N4/77VG4irWG
         ctFot6IUcClDyfSUOyo2PfGfeX2IiU/2llgSxZB9QwjkTrr3gD3B7CQlvFl3F0yYzgzc
         xX+g8YJqDqBhy2Df6Hb1/bQSBiqBON0feIheup+s2vuhkpN7wjmHJLvR058Eim5f/OYo
         O2w3/vbhfo5kCxukaTfaaHVNg+27Dp6MhTlF9ssVZpMHj7TD309zlVqrYt61JHzT6Dul
         RfWC5LzspDRhoWAuP1ZNc81nHxGrCgwUFtsYbvrs97ja6UVlnXiOwMaxyE4C8am6+nZk
         TnbA==
X-Gm-Message-State: AOJu0YxaBWTAm9iQDXHCMtSauu7y2+SNvL10gbq7GuGESiJBIDbV0nSh
        vhtoLAFQ2GbzH7Sy1xsdpeHjwA==
X-Google-Smtp-Source: AGHT+IGJuVnbgEdL7B1yqcNDta9SW8PrCZLooH6K+4U6WsXn8SKs1tWicPmF0cFJa/KnOnpJGZAshw==
X-Received: by 2002:adf:f08b:0:b0:315:a32d:311f with SMTP id n11-20020adff08b000000b00315a32d311fmr14949179wro.14.1692962331890;
        Fri, 25 Aug 2023 04:18:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b5c7:0:9000:8d13:d0bb:ba7d])
        by smtp.gmail.com with ESMTPSA id g9-20020a056000118900b0031ad5fb5a0fsm1939502wrx.58.2023.08.25.04.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 04:18:51 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [v3 4/4] mm: hugetlb: Skip initialization of gigantic tail struct pages if freed by HVO
Date:   Fri, 25 Aug 2023 12:18:36 +0100
Message-Id: <20230825111836.1715308-5-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230825111836.1715308-1-usama.arif@bytedance.com>
References: <20230825111836.1715308-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new boot flow when it comes to initialization of gigantic pages
is as follows:
- At boot time, for a gigantic page during __alloc_bootmem_hugepage,
the region after the first struct page is marked as noinit.
- This results in only the first struct page to be
initialized in reserve_bootmem_region. As the tail struct pages are
not initialized at this point, there can be a significant saving
in boot time if HVO succeeds later on.
- Later on in the boot, HVO is attempted. If its successful, only the first
HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page) - 1 tail struct pages
after the head struct page are initialized. If it is not successful,
then all of the tail struct pages are initialized.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 mm/hugetlb.c         | 52 +++++++++++++++++++++++++++++++++++---------
 mm/hugetlb_vmemmap.h |  8 +++----
 mm/internal.h        |  3 +++
 mm/mm_init.c         |  2 +-
 4 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6da626bfb52e..964f7a2b693e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1953,7 +1953,6 @@ static void __prep_account_new_huge_page(struct hstate *h, int nid)
 
 static void __prep_new_hugetlb_folio(struct hstate *h, struct folio *folio)
 {
-	hugetlb_vmemmap_optimize(h, &folio->page);
 	INIT_LIST_HEAD(&folio->lru);
 	folio_set_compound_dtor(folio, HUGETLB_PAGE_DTOR);
 	hugetlb_set_folio_subpool(folio, NULL);
@@ -2225,6 +2224,7 @@ static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
 			return NULL;
 		}
 	}
+	hugetlb_vmemmap_optimize(h, &folio->page);
 	prep_new_hugetlb_folio(h, folio, folio_nid(folio));
 
 	return folio;
@@ -2943,6 +2943,7 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
 	new_folio = alloc_buddy_hugetlb_folio(h, gfp_mask, nid, NULL, NULL);
 	if (!new_folio)
 		return -ENOMEM;
+	hugetlb_vmemmap_optimize(h, &new_folio->page);
 	__prep_new_hugetlb_folio(h, new_folio);
 
 retry:
@@ -3206,6 +3207,15 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 	}
 
 found:
+
+	/*
+	 * Only initialize the head struct page in memmap_init_reserved_pages,
+	 * rest of the struct pages will be initialized by the HugeTLB subsystem itself.
+	 * The head struct page is used to get folio information by the HugeTLB
+	 * subsystem like zone id and node id.
+	 */
+	memblock_reserved_mark_noinit_vmemmap(virt_to_phys((void *)m + PAGE_SIZE),
+		huge_page_size(h) - PAGE_SIZE);
 	/* Put them into a private list first because mem_map is not up yet */
 	INIT_LIST_HEAD(&m->list);
 	list_add(&m->list, &huge_boot_pages);
@@ -3213,6 +3223,27 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 	return 1;
 }
 
+static void __init hugetlb_folio_init_vmemmap(struct hstate *h, struct folio *folio,
+					       unsigned long nr_pages)
+{
+	enum zone_type zone = zone_idx(folio_zone(folio));
+	int nid = folio_nid(folio);
+	unsigned long head_pfn = folio_pfn(folio);
+	unsigned long pfn, end_pfn = head_pfn + nr_pages;
+
+	__folio_clear_reserved(folio);
+	__folio_set_head(folio);
+
+	for (pfn = head_pfn + 1; pfn < end_pfn; pfn++) {
+		struct page *page = pfn_to_page(pfn);
+
+		__init_single_page(page, pfn, zone, nid);
+		prep_compound_tail((struct page *)folio, pfn - head_pfn);
+		set_page_count(page, 0);
+	}
+	prep_compound_head((struct page *)folio, huge_page_order(h));
+}
+
 /*
  * Put bootmem huge pages into the standard lists after mem_map is up.
  * Note: This only applies to gigantic (order > MAX_ORDER) pages.
@@ -3223,19 +3254,19 @@ static void __init gather_bootmem_prealloc(void)
 
 	list_for_each_entry(m, &huge_boot_pages, list) {
 		struct page *page = virt_to_page(m);
-		struct folio *folio = page_folio(page);
+		struct folio *folio = (void *)page;
 		struct hstate *h = m->hstate;
+		unsigned long nr_pages = pages_per_huge_page(h);
 
 		VM_BUG_ON(!hstate_is_gigantic(h));
 		WARN_ON(folio_ref_count(folio) != 1);
-		if (prep_compound_gigantic_folio(folio, huge_page_order(h))) {
-			WARN_ON(folio_test_reserved(folio));
-			prep_new_hugetlb_folio(h, folio, folio_nid(folio));
-			free_huge_page(page); /* add to the hugepage allocator */
-		} else {
-			/* VERY unlikely inflated ref count on a tail page */
-			free_gigantic_folio(folio, huge_page_order(h));
-		}
+
+		hugetlb_vmemmap_optimize(h, &folio->page);
+		if (HPageVmemmapOptimized(&folio->page))
+			nr_pages = HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page);
+		hugetlb_folio_init_vmemmap(h, folio, nr_pages);
+		prep_new_hugetlb_folio(h, folio, folio_nid(folio));
+		free_huge_page(page); /* add to the hugepage allocator */
 
 		/*
 		 * We need to restore the 'stolen' pages to totalram_pages
@@ -3656,6 +3687,7 @@ static int demote_free_hugetlb_folio(struct hstate *h, struct folio *folio)
 		else
 			prep_compound_page(subpage, target_hstate->order);
 		folio_change_private(inner_folio, NULL);
+		hugetlb_vmemmap_optimize(h, &folio->page);
 		prep_new_hugetlb_folio(target_hstate, inner_folio, nid);
 		free_huge_page(subpage);
 	}
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 25bd0e002431..d30aff8f3573 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -10,16 +10,16 @@
 #define _LINUX_HUGETLB_VMEMMAP_H
 #include <linux/hugetlb.h>
 
-#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
-int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
-void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
-
 /*
  * Reserve one vmemmap page, all vmemmap addresses are mapped to it. See
  * Documentation/vm/vmemmap_dedup.rst.
  */
 #define HUGETLB_VMEMMAP_RESERVE_SIZE	PAGE_SIZE
 
+#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
+void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
+
 static inline unsigned int hugetlb_vmemmap_size(const struct hstate *h)
 {
 	return pages_per_huge_page(h) * sizeof(struct page);
diff --git a/mm/internal.h b/mm/internal.h
index a7d9e980429a..31b3d45f4609 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1102,4 +1102,7 @@ struct vma_prepare {
 	struct vm_area_struct *remove;
 	struct vm_area_struct *remove2;
 };
+
+void __meminit __init_single_page(struct page *page, unsigned long pfn,
+				unsigned long zone, int nid);
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mm_init.c b/mm/mm_init.c
index a1963c3322af..3d4ab595ca7d 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -551,7 +551,7 @@ static void __init find_zone_movable_pfns_for_nodes(void)
 	node_states[N_MEMORY] = saved_node_state;
 }
 
-static void __meminit __init_single_page(struct page *page, unsigned long pfn,
+void __meminit __init_single_page(struct page *page, unsigned long pfn,
 				unsigned long zone, int nid)
 {
 	mm_zero_struct_page(page);
-- 
2.25.1

