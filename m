Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215F4793B30
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239757AbjIFL2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239706AbjIFL2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:28:07 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8974310F5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 04:27:00 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-307d20548adso2980003f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 04:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693999577; x=1694604377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FStpXjXfy05Wptcs5VKtJaC3uUKwiP44RVFSTPHctoE=;
        b=j4V4MPpSoQrIIgsQD//FSkHEWpctmbGNg/rtFfRFnG7VF2+qsrMVsAxi0ktwBvD+r5
         x4VUPBQKgSOrbpWWAJrVFnDn4X4A0as+dIiYZHTuhGaphyObcBOF4BK5dk/mIBClVfax
         31eniDb+S3wViupq85JNB5Tw4eCna/X1szqnJBpcXvFvXE0FPg0a7ihNtG0g6mUy0qDB
         5pv+epAq0KTUqcu+nrJ+iUhyet9/hSSt+WfV5X2BVFddNPi431whGnUaZt8OR4uq70ka
         a0soVN6aveQk8n1peKaxxzMTiwtTqa4Zfma17zrXQDYQuSLYOVmeB+5Rkr9aNY7AZkdh
         KCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693999577; x=1694604377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FStpXjXfy05Wptcs5VKtJaC3uUKwiP44RVFSTPHctoE=;
        b=MWw81iydJ7KuJPciKBOIk3Mgc8+wj2hC7KUJGyRjp3I9GyKjzbmH27/xJs+gXix7Od
         03GMcb4ct//yvvCfqpnamckmbxzJAYIgKEYACXvGKQbvNXEyPGbdxWA0n8TmzJdIz/k8
         f/iag0xW5tSi9cDl4zTkoAIVQwyXfM1Vs5HS3jhtIw70+g47gh3HdNPbrOJaUAtVn+vj
         qocUtwG810LxjSzifj8BxuU+j+5DAnS7IA8sq1xyhKVmxWb7bnAYTEe11VH0oEYegKrc
         OYZ3xiqxdkfnNS7nm6PAYbMgNIafgdAziMTtH+FnT9LFhSARC0Cc4bwmgLns6YsQ08b0
         0gOQ==
X-Gm-Message-State: AOJu0YxMCYCGSotOfcqdOY7TLN0qx5IAStd4rqB3RJ9kXXCZ84LHAKZF
        brCsb6WoNScjLEPjA5ErgrzfGQ==
X-Google-Smtp-Source: AGHT+IG3C1Ltp43a9GTFE7tcAw7+FslSjp6rOutSzsw4cYuJWx+ebBM3Lt3tEbnjyOzPbJs8SSeFmw==
X-Received: by 2002:a05:6000:11ca:b0:306:46c4:d313 with SMTP id i10-20020a05600011ca00b0030646c4d313mr1851070wrx.28.1693999577038;
        Wed, 06 Sep 2023 04:26:17 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b5c7:0:6dce:31d8:efb1:5d81])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c294900b003feff926fc5sm19517038wmd.17.2023.09.06.04.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 04:26:16 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [v4 4/4] mm: hugetlb: Skip initialization of gigantic tail struct pages if freed by HVO
Date:   Wed,  6 Sep 2023 12:26:05 +0100
Message-Id: <20230906112605.2286994-5-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230906112605.2286994-1-usama.arif@bytedance.com>
References: <20230906112605.2286994-1-usama.arif@bytedance.com>
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
- Later on in the boot, the head page is prepped and the first
HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page) - 1 tail struct pages
are initialized.
- HVO is attempted. If it is not successful, then the rest of the
tail struct pages are initialized. If it is successful, no more
tail struct pages need to be initialized saving significant boot time.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 mm/hugetlb.c         | 61 +++++++++++++++++++++++++++++++++++++-------
 mm/hugetlb_vmemmap.c |  2 +-
 mm/hugetlb_vmemmap.h |  9 ++++---
 mm/internal.h        |  3 +++
 mm/mm_init.c         |  2 +-
 5 files changed, 62 insertions(+), 15 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c32ca241df4b..540e0386514e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3169,6 +3169,15 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 	}
 
 found:
+
+	/*
+	 * Only initialize the head struct page in memmap_init_reserved_pages,
+	 * rest of the struct pages will be initialized by the HugeTLB subsystem itself.
+	 * The head struct page is used to get folio information by the HugeTLB
+	 * subsystem like zone id and node id.
+	 */
+	memblock_reserved_mark_noinit(virt_to_phys((void *)m + PAGE_SIZE),
+		huge_page_size(h) - PAGE_SIZE);
 	/* Put them into a private list first because mem_map is not up yet */
 	INIT_LIST_HEAD(&m->list);
 	list_add(&m->list, &huge_boot_pages);
@@ -3176,6 +3185,40 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 	return 1;
 }
 
+/* Initialize [start_page:end_page_number] tail struct pages of a hugepage */
+static void __init hugetlb_folio_init_tail_vmemmap(struct folio *folio,
+						    unsigned long start_page_number,
+						    unsigned long end_page_number)
+{
+	enum zone_type zone = zone_idx(folio_zone(folio));
+	int nid = folio_nid(folio);
+	unsigned long head_pfn = folio_pfn(folio);
+	unsigned long pfn, end_pfn = head_pfn + end_page_number;
+
+	for (pfn = head_pfn + start_page_number; pfn < end_pfn; pfn++) {
+		struct page *page = pfn_to_page(pfn);
+
+		__init_single_page(page, pfn, zone, nid);
+		prep_compound_tail((struct page *)folio, pfn - head_pfn);
+		set_page_count(page, 0);
+	}
+}
+
+static void __init hugetlb_folio_init_vmemmap(struct folio *folio, struct hstate *h,
+					       unsigned long nr_pages)
+{
+	int ret;
+
+	/* Prepare folio head */
+	__folio_clear_reserved(folio);
+	__folio_set_head(folio);
+	ret = page_ref_freeze(&folio->page, 1);
+	VM_BUG_ON(!ret);
+	/* Initialize the necessary tail struct pages */
+	hugetlb_folio_init_tail_vmemmap(folio, 1, nr_pages);
+	prep_compound_head((struct page *)folio, huge_page_order(h));
+}
+
 /*
  * Put bootmem huge pages into the standard lists after mem_map is up.
  * Note: This only applies to gigantic (order > MAX_ORDER) pages.
@@ -3186,19 +3229,19 @@ static void __init gather_bootmem_prealloc(void)
 
 	list_for_each_entry(m, &huge_boot_pages, list) {
 		struct page *page = virt_to_page(m);
-		struct folio *folio = page_folio(page);
+		struct folio *folio = (void *)page;
 		struct hstate *h = m->hstate;
 
 		VM_BUG_ON(!hstate_is_gigantic(h));
 		WARN_ON(folio_ref_count(folio) != 1);
-		if (prep_compound_gigantic_folio(folio, huge_page_order(h))) {
-			WARN_ON(folio_test_reserved(folio));
-			prep_new_hugetlb_folio(h, folio, folio_nid(folio));
-			free_huge_folio(folio); /* add to the hugepage allocator */
-		} else {
-			/* VERY unlikely inflated ref count on a tail page */
-			free_gigantic_folio(folio, huge_page_order(h));
-		}
+
+		hugetlb_folio_init_vmemmap(folio, h, HUGETLB_VMEMMAP_RESERVE_PAGES);
+		prep_new_hugetlb_folio(h, folio, folio_nid(folio));
+		/* If HVO fails, initialize all tail struct pages */
+		if (!HPageVmemmapOptimized(&folio->page))
+			hugetlb_folio_init_tail_vmemmap(folio, HUGETLB_VMEMMAP_RESERVE_PAGES,
+							pages_per_huge_page(h));
+		free_huge_folio(folio); /* add to the hugepage allocator */
 
 		/*
 		 * We need to restore the 'stolen' pages to totalram_pages
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 3cdb38d87a95..772a877918d7 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -589,7 +589,7 @@ static int __init hugetlb_vmemmap_init(void)
 	const struct hstate *h;
 
 	/* HUGETLB_VMEMMAP_RESERVE_SIZE should cover all used struct pages */
-	BUILD_BUG_ON(__NR_USED_SUBPAGE * sizeof(struct page) > HUGETLB_VMEMMAP_RESERVE_SIZE);
+	BUILD_BUG_ON(__NR_USED_SUBPAGE > HUGETLB_VMEMMAP_RESERVE_PAGES);
 
 	for_each_hstate(h) {
 		if (hugetlb_vmemmap_optimizable(h)) {
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 25bd0e002431..4573899855d7 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -10,15 +10,16 @@
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
+#define HUGETLB_VMEMMAP_RESERVE_PAGES	(HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page))
+
+#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
+void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
 
 static inline unsigned int hugetlb_vmemmap_size(const struct hstate *h)
 {
diff --git a/mm/internal.h b/mm/internal.h
index d1d4bf4e63c0..d74061aa6de7 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1154,4 +1154,7 @@ struct vma_prepare {
 	struct vm_area_struct *remove;
 	struct vm_area_struct *remove2;
 };
+
+void __meminit __init_single_page(struct page *page, unsigned long pfn,
+				unsigned long zone, int nid);
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 50f2f34745af..fed4370b02e1 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -555,7 +555,7 @@ static void __init find_zone_movable_pfns_for_nodes(void)
 	node_states[N_MEMORY] = saved_node_state;
 }
 
-static void __meminit __init_single_page(struct page *page, unsigned long pfn,
+void __meminit __init_single_page(struct page *page, unsigned long pfn,
 				unsigned long zone, int nid)
 {
 	mm_zero_struct_page(page);
-- 
2.25.1

