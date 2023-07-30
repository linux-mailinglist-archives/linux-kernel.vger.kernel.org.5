Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB9D76862A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 17:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjG3PQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 11:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjG3PQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 11:16:38 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5AA1713
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 08:16:12 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc59de0e2so34772095e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 08:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690730170; x=1691334970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5VE1b09XGrn3hjFzsE3qaVui4TN6DlsvAzQ6XWShV0=;
        b=LhfXuIzeZE5fNFxToBAlvDQA5EoZbK+3WEM+AjQQxsQ0JxOdwHbtoU7CSVU9Y3ua/I
         YUpJ5p9ziGSrXpohlrNQkGF+742Gm7k1GzsA5f33b42pcc1fc/iAwrWonfQ7MYbv1q7h
         YVGa2uWWvFfRDEkTBXC8BuX87YIa3rtNxtLUF7dmSJ7zSlON6lGYhX3vs8+xJgQ7inEi
         v2WUTfER2YUR5IubnbmBUcgeUw1db17u0y+MPFkcMPvVpO4iH/iea96utluPPBbXOwxl
         JtX5YfmoepWtGVwANwedcUUAaZIqjKeijQsq21YfiLsa2xpb4FFh20dY0yu/BPDgxfy1
         opbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690730170; x=1691334970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5VE1b09XGrn3hjFzsE3qaVui4TN6DlsvAzQ6XWShV0=;
        b=eBSOQhRwN3F3x+//9i/Nz3GBC5czXB1M4mGu8iHcUhxx+eIcIIs5XP12E7ScoVc1HQ
         UIYqYvJD8kRyjfwxOrmeFO68IRMesRqCFreSh6JixMmRPV3ajP1L7LopY/gmme5c3u9c
         WJzQ2Rd1FOLh5RuWBhRMEvC+Pxf2FcPVZd+ij//+2m+y9+Q3FA6aRB7iCfcqWQBU+E7A
         26RV5XsNC8HC+Gktqd3w8dicV+JeaYfGl4P8o4QH+ceLDv5WmFO9Yu6XBA9LiWK5rk4B
         FAP/hUyMhWpKKo3+N3YgWb4PDvpl5hvUUgnKx/DCGlxXjqR0H7s8D6wXmituWBpYUy5q
         f7CA==
X-Gm-Message-State: ABy/qLYoAHD4N70d/lLBTBbpfhcNZGD/rcKzZQb6P9N5RWnkbVtb94iX
        R+NrQM8RNExTlMdI+aOqZUdXpA==
X-Google-Smtp-Source: APBJJlGPOGrrpNvuwalf5EOZlDbgmbBWoE71UsgklAK9FFQ8DCMd6wl0g32vEm3QO8b2B4WvXFrH5A==
X-Received: by 2002:a7b:cc8c:0:b0:3fc:175:ade7 with SMTP id p12-20020a7bcc8c000000b003fc0175ade7mr5638740wma.38.1690730170432;
        Sun, 30 Jul 2023 08:16:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b465:0:eda5:aa63:ce24:dac2])
        by smtp.gmail.com with ESMTPSA id f17-20020a7bcc11000000b003fd2d33ea53sm9123027wmh.14.2023.07.30.08.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 08:16:09 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [v2 1/6] mm: hugetlb: Skip prep of tail pages when HVO is enabled
Date:   Sun, 30 Jul 2023 16:16:01 +0100
Message-Id: <20230730151606.2871391-2-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230730151606.2871391-1-usama.arif@bytedance.com>
References: <20230730151606.2871391-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When vmemmap is optimizable, it will free all the duplicated tail
pages in hugetlb_vmemmap_optimize while preparing the new hugepage.
Hence, there is no need to prepare them.

For 1G x86 hugepages, it avoids preparing
262144 - 64 = 262080 struct pages per hugepage.

The indirection of using __prep_compound_gigantic_folio is also removed,
as it just creates extra functions to indicate demote which can be done
with the argument.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 mm/hugetlb.c         | 32 ++++++++++++++------------------
 mm/hugetlb_vmemmap.c |  2 +-
 mm/hugetlb_vmemmap.h | 15 +++++++++++----
 3 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 64a3239b6407..541c07b6d60f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1942,14 +1942,23 @@ static void prep_new_hugetlb_folio(struct hstate *h, struct folio *folio, int ni
 	spin_unlock_irq(&hugetlb_lock);
 }
 
-static bool __prep_compound_gigantic_folio(struct folio *folio,
-					unsigned int order, bool demote)
+static bool prep_compound_gigantic_folio(struct folio *folio, struct hstate *h, bool demote)
 {
 	int i, j;
+	int order = huge_page_order(h);
 	int nr_pages = 1 << order;
 	struct page *p;
 
 	__folio_clear_reserved(folio);
+
+	/*
+	 * No need to prep pages that will be freed later by hugetlb_vmemmap_optimize.
+	 * Hence, reduce nr_pages to the pages that will be kept.
+	 */
+	if (IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP) &&
+			vmemmap_should_optimize(h, &folio->page))
+		nr_pages = HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page);
+
 	for (i = 0; i < nr_pages; i++) {
 		p = folio_page(folio, i);
 
@@ -2019,18 +2028,6 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
 	return false;
 }
 
-static bool prep_compound_gigantic_folio(struct folio *folio,
-							unsigned int order)
-{
-	return __prep_compound_gigantic_folio(folio, order, false);
-}
-
-static bool prep_compound_gigantic_folio_for_demote(struct folio *folio,
-							unsigned int order)
-{
-	return __prep_compound_gigantic_folio(folio, order, true);
-}
-
 /*
  * PageHuge() only returns true for hugetlbfs pages, but not for normal or
  * transparent huge pages.  See the PageTransHuge() documentation for more
@@ -2185,7 +2182,7 @@ static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
 	if (!folio)
 		return NULL;
 	if (hstate_is_gigantic(h)) {
-		if (!prep_compound_gigantic_folio(folio, huge_page_order(h))) {
+		if (!prep_compound_gigantic_folio(folio, h, false)) {
 			/*
 			 * Rare failure to convert pages to compound page.
 			 * Free pages and try again - ONCE!
@@ -3201,7 +3198,7 @@ static void __init gather_bootmem_prealloc(void)
 
 		VM_BUG_ON(!hstate_is_gigantic(h));
 		WARN_ON(folio_ref_count(folio) != 1);
-		if (prep_compound_gigantic_folio(folio, huge_page_order(h))) {
+		if (prep_compound_gigantic_folio(folio, h, false)) {
 			WARN_ON(folio_test_reserved(folio));
 			prep_new_hugetlb_folio(h, folio, folio_nid(folio));
 			free_huge_page(page); /* add to the hugepage allocator */
@@ -3624,8 +3621,7 @@ static int demote_free_hugetlb_folio(struct hstate *h, struct folio *folio)
 		subpage = folio_page(folio, i);
 		inner_folio = page_folio(subpage);
 		if (hstate_is_gigantic(target_hstate))
-			prep_compound_gigantic_folio_for_demote(inner_folio,
-							target_hstate->order);
+			prep_compound_gigantic_folio(inner_folio, target_hstate, true);
 		else
 			prep_compound_page(subpage, target_hstate->order);
 		folio_change_private(inner_folio, NULL);
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index c2007ef5e9b0..b721e87de2b3 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -486,7 +486,7 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 }
 
 /* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
-static bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
+bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
 {
 	if (!READ_ONCE(vmemmap_optimize_enabled))
 		return false;
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 25bd0e002431..3e7978a9af73 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -10,16 +10,17 @@
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
+bool vmemmap_should_optimize(const struct hstate *h, const struct page *head);
+
 static inline unsigned int hugetlb_vmemmap_size(const struct hstate *h)
 {
 	return pages_per_huge_page(h) * sizeof(struct page);
@@ -51,6 +52,12 @@ static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate
 {
 	return 0;
 }
+
+static inline bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
+{
+	return false;
+}
+
 #endif /* CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP */
 
 static inline bool hugetlb_vmemmap_optimizable(const struct hstate *h)
-- 
2.25.1

