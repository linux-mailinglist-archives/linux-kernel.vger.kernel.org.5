Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC8F7C5740
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbjJKOqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjJKOqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:46:25 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B9092
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 07:46:03 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32615eaa312so6292211f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 07:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697035562; x=1697640362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWuo5MYDWY4yl3Knf+HCHs3vxzl9QgLecjVM+nxtF3Y=;
        b=LrX+qsrJmqKz568myPlKTOwa9liIyUW84FAbZkbSXhgyBJmM/2RZYRFtZ4P2t3nvDu
         nCfFEXre5bhw20lXYGH2oXmhkfRgqt/HfoznTeM9zw4KNrKkk5xKmFrdoiU1pzLWmqHX
         x1EUgjLUTanFsiVDXWrhl6ADq9B9YL9ovdpEqlI6mL+LZAjUFUBKEcpWU6tHcsVkYZzg
         YSKW5Thnoxpi4semsDddZnS5HPLvaUOCxxe7t2ee025F6xQ8bv9ty+Gaoem2RAy9pqC8
         xsfWiMOnSiQN0bpicCY9bsN55FlHBblUiBy15MYcUbVHJX08pH3wXXeC/qKHPrSKPCdA
         Wq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697035562; x=1697640362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWuo5MYDWY4yl3Knf+HCHs3vxzl9QgLecjVM+nxtF3Y=;
        b=gxm+C8gVS96Xph9TIzFLERsm45yspDRMcHsuNMORh4kuLJybTdX9jKk6W5IYD9ZGmQ
         k//oXUru/o+mmfJFlLku6HQY1bQ5SkvhRRYmonFjmCWN4ZEz1ZLy5wKHD5N/AiZbuCNY
         k3b8+tWo5esAcAmDOpOAdYZqjMOn2gjAWiSrE5HD5mXXyrfBhCVIeKS/cdu/BSFZPT9m
         NnM3/nGYNUzwDZwRL0c/gWtVGg6/dSfvh9Zp/UNCrxKja1dIsbaSfHGAqU3+e9WSVTGx
         BD/NSsRHIeMtTDoVRvxpJfCjCw/bIhTi2gFfq2zYsQwqtiaeD7QdoDSB51X86zttgHCL
         RlwQ==
X-Gm-Message-State: AOJu0YwmO4cLjuz3Pe8Zg+GfE7Z4OdAJ/xyHbd3lArH7zegObuNMH8kk
        68TE6bo1N9Lim7scXOzugea4yw==
X-Google-Smtp-Source: AGHT+IE73N7mYxOnVUht0PvqrFPtjE8lneCecYcXP/fRLk1cXxykxF3Bx7bSd8DjxDk7F5D4iCjJSg==
X-Received: by 2002:a05:6000:1d89:b0:32d:1258:dc98 with SMTP id bk9-20020a0560001d8900b0032d1258dc98mr4463178wrb.11.1697035561710;
        Wed, 11 Oct 2023 07:46:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b5c7:0:2cc4:b980:5314:b759])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d6904000000b0032710f5584fsm15580267wru.25.2023.10.11.07.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 07:46:01 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, mike.kravetz@oracle.com,
        songmuchun@bytedance.com, fam.zheng@bytedance.com,
        liangma@liangbit.com, punit.agrawal@bytedance.com,
        Usama Arif <usama.arif@bytedance.com>
Subject: [v2 1/1] hugetlb_vmemmap: use folio argument for hugetlb_vmemmap_* functions
Date:   Wed, 11 Oct 2023 15:45:57 +0100
Message-Id: <20231011144557.1720481-2-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231011144557.1720481-1-usama.arif@bytedance.com>
References: <20231011144557.1720481-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most function calls in hugetlb.c are made with folio arguments.
This brings hugetlb_vmemmap calls inline with them by using folio
instead of head struct page. Head struct page is still needed
within these functions.

The set/clear/test functions for hugepages are also changed to
folio versions.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c         | 14 ++++++-------
 mm/hugetlb_vmemmap.c | 50 +++++++++++++++++++++++---------------------
 mm/hugetlb_vmemmap.h |  8 +++----
 3 files changed, 37 insertions(+), 35 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 29231f1c49a8..f5fc039c7342 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1603,10 +1603,10 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 
 	/*
 	 * If folio is not vmemmap optimized (!clear_dtor), then the folio
-	 * is no longer identified as a hugetlb page.  hugetlb_vmemmap_restore
+	 * is no longer identified as a hugetlb page.  hugetlb_vmemmap_restore_folio
 	 * can only be passed hugetlb pages and will BUG otherwise.
 	 */
-	if (clear_dtor && hugetlb_vmemmap_restore(h, &folio->page)) {
+	if (clear_dtor && hugetlb_vmemmap_restore_folio(h, folio)) {
 		spin_lock_irq(&hugetlb_lock);
 		/*
 		 * If we cannot allocate vmemmap pages, just refuse to free the
@@ -1749,7 +1749,7 @@ static void bulk_vmemmap_restore_error(struct hstate *h,
 		 * quit processing the list to retry the bulk operation.
 		 */
 		list_for_each_entry_safe(folio, t_folio, folio_list, lru)
-			if (hugetlb_vmemmap_restore(h, &folio->page)) {
+			if (hugetlb_vmemmap_restore_folio(h, folio)) {
 				list_del(&folio->lru);
 				spin_lock_irq(&hugetlb_lock);
 				add_hugetlb_folio(h, folio, true);
@@ -1906,7 +1906,7 @@ static void init_new_hugetlb_folio(struct hstate *h, struct folio *folio)
 static void __prep_new_hugetlb_folio(struct hstate *h, struct folio *folio)
 {
 	init_new_hugetlb_folio(h, folio);
-	hugetlb_vmemmap_optimize(h, &folio->page);
+	hugetlb_vmemmap_optimize_folio(h, folio);
 }
 
 static void prep_new_hugetlb_folio(struct hstate *h, struct folio *folio, int nid)
@@ -2312,7 +2312,7 @@ int dissolve_free_huge_page(struct page *page)
 		 * Attempt to allocate vmemmmap here so that we can take
 		 * appropriate action on failure.
 		 */
-		rc = hugetlb_vmemmap_restore(h, &folio->page);
+		rc = hugetlb_vmemmap_restore_folio(h, folio);
 		if (!rc) {
 			update_and_free_hugetlb_folio(h, folio, false);
 		} else {
@@ -3697,11 +3697,11 @@ static int demote_free_hugetlb_folio(struct hstate *h, struct folio *folio)
 	/*
 	 * If vmemmap already existed for folio, the remove routine above would
 	 * have cleared the hugetlb folio flag.  Hence the folio is technically
-	 * no longer a hugetlb folio.  hugetlb_vmemmap_restore can only be
+	 * no longer a hugetlb folio.  hugetlb_vmemmap_restore_folio can only be
 	 * passed hugetlb folios and will BUG otherwise.
 	 */
 	if (folio_test_hugetlb(folio)) {
-		rc = hugetlb_vmemmap_restore(h, &folio->page);
+		rc = hugetlb_vmemmap_restore_folio(h, folio);
 		if (rc) {
 			/* Allocation of vmemmmap failed, we can not demote folio */
 			spin_lock_irq(&hugetlb_lock);
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index d2999c303031..87818ee7f01d 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -495,14 +495,15 @@ EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
 static bool vmemmap_optimize_enabled = IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON);
 core_param(hugetlb_free_vmemmap, vmemmap_optimize_enabled, bool, 0);
 
-static int __hugetlb_vmemmap_restore(const struct hstate *h, struct page *head, unsigned long flags)
+static int __hugetlb_vmemmap_restore_folio(const struct hstate *h, struct folio *folio, unsigned long flags)
 {
 	int ret;
+	struct page *head = &folio->page;
 	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
 	unsigned long vmemmap_reuse;
 
 	VM_WARN_ON_ONCE(!PageHuge(head));
-	if (!HPageVmemmapOptimized(head))
+	if (!folio_test_hugetlb_vmemmap_optimized(folio))
 		return 0;
 
 	vmemmap_end	= vmemmap_start + hugetlb_vmemmap_size(h);
@@ -518,7 +519,7 @@ static int __hugetlb_vmemmap_restore(const struct hstate *h, struct page *head,
 	 */
 	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse, flags);
 	if (!ret) {
-		ClearHPageVmemmapOptimized(head);
+		folio_clear_hugetlb_vmemmap_optimized(folio);
 		static_branch_dec(&hugetlb_optimize_vmemmap_key);
 	}
 
@@ -526,18 +527,18 @@ static int __hugetlb_vmemmap_restore(const struct hstate *h, struct page *head,
 }
 
 /**
- * hugetlb_vmemmap_restore - restore previously optimized (by
- *				hugetlb_vmemmap_optimize()) vmemmap pages which
+ * hugetlb_vmemmap_restore_folio - restore previously optimized (by
+ *				hugetlb_vmemmap_optimize_folio()) vmemmap pages which
  *				will be reallocated and remapped.
  * @h:		struct hstate.
- * @head:	the head page whose vmemmap pages will be restored.
+ * @folio:     the folio whose vmemmap pages will be restored.
  *
- * Return: %0 if @head's vmemmap pages have been reallocated and remapped,
+ * Return: %0 if @folio's vmemmap pages have been reallocated and remapped,
  * negative error code otherwise.
  */
-int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
+int hugetlb_vmemmap_restore_folio(const struct hstate *h, struct folio *folio)
 {
-	return __hugetlb_vmemmap_restore(h, head, 0);
+	return __hugetlb_vmemmap_restore_folio(h, folio, 0);
 }
 
 /**
@@ -563,7 +564,7 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 
 	list_for_each_entry_safe(folio, t_folio, folio_list, lru) {
 		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
-			ret = __hugetlb_vmemmap_restore(h, &folio->page,
+			ret = __hugetlb_vmemmap_restore_folio(h, folio,
 						VMEMMAP_REMAP_NO_TLB_FLUSH);
 			if (ret)
 				break;
@@ -640,12 +641,13 @@ static bool vmemmap_should_optimize(const struct hstate *h, const struct page *h
 	return true;
 }
 
-static int __hugetlb_vmemmap_optimize(const struct hstate *h,
-					struct page *head,
+static int __hugetlb_vmemmap_optimize_folio(const struct hstate *h,
+					struct folio *folio,
 					struct list_head *vmemmap_pages,
 					unsigned long flags)
 {
 	int ret = 0;
+	struct page *head = &folio->page;
 	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
 	unsigned long vmemmap_reuse;
 
@@ -665,7 +667,7 @@ static int __hugetlb_vmemmap_optimize(const struct hstate *h,
 	 * If there is an error during optimization, we will immediately FLUSH
 	 * the TLB and clear the flag below.
 	 */
-	SetHPageVmemmapOptimized(head);
+	folio_set_hugetlb_vmemmap_optimized(folio);
 
 	vmemmap_end	= vmemmap_start + hugetlb_vmemmap_size(h);
 	vmemmap_reuse	= vmemmap_start;
@@ -681,27 +683,27 @@ static int __hugetlb_vmemmap_optimize(const struct hstate *h,
 							vmemmap_pages, flags);
 	if (ret) {
 		static_branch_dec(&hugetlb_optimize_vmemmap_key);
-		ClearHPageVmemmapOptimized(head);
+		folio_clear_hugetlb_vmemmap_optimized(folio);
 	}
 
 	return ret;
 }
 
 /**
- * hugetlb_vmemmap_optimize - optimize @head page's vmemmap pages.
+ * hugetlb_vmemmap_optimize_folio - optimize @folio's vmemmap pages.
  * @h:		struct hstate.
- * @head:	the head page whose vmemmap pages will be optimized.
+ * @folio:     the folio whose vmemmap pages will be optimized.
  *
- * This function only tries to optimize @head's vmemmap pages and does not
+ * This function only tries to optimize @folio's vmemmap pages and does not
  * guarantee that the optimization will succeed after it returns. The caller
- * can use HPageVmemmapOptimized(@head) to detect if @head's vmemmap pages
- * have been optimized.
+ * can use folio_test_hugetlb_vmemmap_optimized(@folio) to detect if @folio's
+ * vmemmap pages have been optimized.
  */
-void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
+void hugetlb_vmemmap_optimize_folio(const struct hstate *h, struct folio *folio)
 {
 	LIST_HEAD(vmemmap_pages);
 
-	__hugetlb_vmemmap_optimize(h, head, &vmemmap_pages, 0);
+	__hugetlb_vmemmap_optimize_folio(h, folio, &vmemmap_pages, 0);
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
@@ -745,7 +747,7 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 	flush_tlb_all();
 
 	list_for_each_entry(folio, folio_list, lru) {
-		int ret = __hugetlb_vmemmap_optimize(h, &folio->page,
+		int ret = __hugetlb_vmemmap_optimize_folio(h, folio,
 						&vmemmap_pages,
 						VMEMMAP_REMAP_NO_TLB_FLUSH);
 
@@ -754,14 +756,14 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 		 * encounter an ENOMEM,  free what we have and try again.
 		 * This can occur in the case that both spliting fails
 		 * halfway and head page allocation also failed. In this
-		 * case __hugetlb_vmemmap_optimize() would free memory
+		 * case __hugetlb_vmemmap_optimize_folio() would free memory
 		 * allowing more vmemmap remaps to occur.
 		 */
 		if (ret == -ENOMEM && !list_empty(&vmemmap_pages)) {
 			flush_tlb_all();
 			free_vmemmap_page_list(&vmemmap_pages);
 			INIT_LIST_HEAD(&vmemmap_pages);
-			__hugetlb_vmemmap_optimize(h, &folio->page,
+			__hugetlb_vmemmap_optimize_folio(h, folio,
 						&vmemmap_pages,
 						VMEMMAP_REMAP_NO_TLB_FLUSH);
 		}
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index a0dcf49f46ba..9fd0cb270502 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -18,11 +18,11 @@
 #define HUGETLB_VMEMMAP_RESERVE_PAGES	(HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page))
 
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
-int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
+int hugetlb_vmemmap_restore_folio(const struct hstate *h, struct folio *folio);
 long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 					struct list_head *folio_list,
 					struct list_head *non_hvo_folios);
-void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
+void hugetlb_vmemmap_optimize_folio(const struct hstate *h, struct folio *folio);
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
 
 static inline unsigned int hugetlb_vmemmap_size(const struct hstate *h)
@@ -43,7 +43,7 @@ static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate
 	return size > 0 ? size : 0;
 }
 #else
-static inline int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
+static inline int hugetlb_vmemmap_restore_folio(const struct hstate *h, struct folio *folio)
 {
 	return 0;
 }
@@ -56,7 +56,7 @@ static long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 	return 0;
 }
 
-static inline void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
+static inline void hugetlb_vmemmap_optimize_folio(const struct hstate *h, struct folio *folio)
 {
 }
 
-- 
2.25.1

