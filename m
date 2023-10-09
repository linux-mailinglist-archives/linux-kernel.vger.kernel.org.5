Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846817BE482
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376488AbjJIPTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376335AbjJIPTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:19:31 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DEDA3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 08:19:13 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-405524e6769so28011015e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 08:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696864752; x=1697469552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEViuWF/QhMtAn6zDhENFWi+HKxgrVT/QGI1gB+0GRQ=;
        b=ers/Edgi2OxUYMwBcu8IFkO0eRQn7ftqHFfGA9+hCGJGArz/VJDORiUqqpJJuiM1La
         fb/Rmnc4MjCy6l4WT7/GOp9uGv15qMeXHbsOOQ0Rw+atlNhdwKq0EU6b0Tjc94i+HkgL
         RdwH79bb3d4HcWjTQ+JAgMg/VUpVXOJFPnuhLTL+nrAPF5oZoaub3SzvnzWoEGpBf9hp
         voXK6PPc0KlcjQhq2hAC2AIeEINP+GmdnF/PSuLRqTQ/MfrpNwPFsSzJBheWbnYtL0QN
         z3XvnESTlU2csoixeBd9Jy5tHE43gyfl/Zuch6TwKdE8otzLqnFy0+MKGfe+DHX4i/oH
         n4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696864752; x=1697469552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEViuWF/QhMtAn6zDhENFWi+HKxgrVT/QGI1gB+0GRQ=;
        b=ls7YAdI/FXD4VWDdozF45WdHKQg/ORoEhsLybDr2bYTG900hW7DPRm5srPv+s5uOmQ
         jDbOerRTq8LTXY2WhCMNBMwbZqEud8Cnc+XkPFytNenura7C8llY9ZLzXRWyVzRADuCJ
         Xu4U4si4uaEwX4guIE3eXShdXKAuzOX58Wvk//YWRhytJWXdvnL+M6epjh7z+cscfHqi
         Ae6p31+w2UlaaxbxTxWCdVLJO64LTpmHI4oi8ZM8AQTlPuiWLlSt7yzB7SmWqsux7PS6
         t7GLYYciD8XhiTDrfiX4FwsQ6mEgdQjt6LgabRpxCZXb0w9HB1yZrrJ1PMB4NBuxXcTz
         jHwQ==
X-Gm-Message-State: AOJu0Yzh2DqwIuxFJS1Tl192ZKurPYa+285OSII54vFPOzIJ9tTC0F2o
        TL0z0USZD+QgSUZacOu29ncP2Q==
X-Google-Smtp-Source: AGHT+IHI7PFMZNOa3RxMFsQks2ktjm8AOtNoVtfhv8G2DShsq9TsPpUNhU+TN3KPpAar2zRhbyCKjw==
X-Received: by 2002:a05:600c:5010:b0:407:4126:f71c with SMTP id n16-20020a05600c501000b004074126f71cmr5828847wmr.6.1696864751989;
        Mon, 09 Oct 2023 08:19:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b5c7:0:c1b1:1479:6449:a1ff])
        by smtp.gmail.com with ESMTPSA id r2-20020a05600c320200b0040641ce36a8sm7075008wmp.1.2023.10.09.08.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 08:19:11 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, mike.kravetz@oracle.com,
        songmuchun@bytedance.com, fam.zheng@bytedance.com,
        liangma@liangbit.com, punit.agrawal@bytedance.com,
        Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH 1/1] hugetlb_vmemmap: use folio argument for hugetlb_vmemmap_* functions
Date:   Mon,  9 Oct 2023 16:18:30 +0100
Message-Id: <20231009151830.2248885-2-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231009151830.2248885-1-usama.arif@bytedance.com>
References: <20231009151830.2248885-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
---
 mm/hugetlb.c         | 10 +++++-----
 mm/hugetlb_vmemmap.c | 42 ++++++++++++++++++++++--------------------
 mm/hugetlb_vmemmap.h |  8 ++++----
 3 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b12f5fd295bb..73803d62066a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1606,7 +1606,7 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 	 * is no longer identified as a hugetlb page.  hugetlb_vmemmap_restore
 	 * can only be passed hugetlb pages and will BUG otherwise.
 	 */
-	if (clear_dtor && hugetlb_vmemmap_restore(h, &folio->page)) {
+	if (clear_dtor && hugetlb_vmemmap_restore(h, folio)) {
 		spin_lock_irq(&hugetlb_lock);
 		/*
 		 * If we cannot allocate vmemmap pages, just refuse to free the
@@ -1749,7 +1749,7 @@ static void bulk_vmemmap_restore_error(struct hstate *h,
 		 * quit processing the list to retry the bulk operation.
 		 */
 		list_for_each_entry_safe(folio, t_folio, folio_list, lru)
-			if (hugetlb_vmemmap_restore(h, &folio->page)) {
+			if (hugetlb_vmemmap_restore(h, folio)) {
 				list_del(&folio->lru);
 				spin_lock_irq(&hugetlb_lock);
 				add_hugetlb_folio(h, folio, true);
@@ -1907,7 +1907,7 @@ static void init_new_hugetlb_folio(struct hstate *h, struct folio *folio)
 static void __prep_new_hugetlb_folio(struct hstate *h, struct folio *folio)
 {
 	init_new_hugetlb_folio(h, folio);
-	hugetlb_vmemmap_optimize(h, &folio->page);
+	hugetlb_vmemmap_optimize(h, folio);
 }
 
 static void prep_new_hugetlb_folio(struct hstate *h, struct folio *folio, int nid)
@@ -2312,7 +2312,7 @@ int dissolve_free_huge_page(struct page *page)
 		 * Attempt to allocate vmemmmap here so that we can take
 		 * appropriate action on failure.
 		 */
-		rc = hugetlb_vmemmap_restore(h, &folio->page);
+		rc = hugetlb_vmemmap_restore(h, folio);
 		if (!rc) {
 			update_and_free_hugetlb_folio(h, folio, false);
 		} else {
@@ -3721,7 +3721,7 @@ static int demote_free_hugetlb_folio(struct hstate *h, struct folio *folio)
 	 * passed hugetlb folios and will BUG otherwise.
 	 */
 	if (folio_test_hugetlb(folio)) {
-		rc = hugetlb_vmemmap_restore(h, &folio->page);
+		rc = hugetlb_vmemmap_restore(h, folio);
 		if (rc) {
 			/* Allocation of vmemmmap failed, we can not demote folio */
 			spin_lock_irq(&hugetlb_lock);
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index d2999c303031..84b5ac93b9e5 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -495,14 +495,15 @@ EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
 static bool vmemmap_optimize_enabled = IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON);
 core_param(hugetlb_free_vmemmap, vmemmap_optimize_enabled, bool, 0);
 
-static int __hugetlb_vmemmap_restore(const struct hstate *h, struct page *head, unsigned long flags)
+static int __hugetlb_vmemmap_restore(const struct hstate *h, struct folio *folio, unsigned long flags)
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
 
@@ -530,14 +531,14 @@ static int __hugetlb_vmemmap_restore(const struct hstate *h, struct page *head,
  *				hugetlb_vmemmap_optimize()) vmemmap pages which
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
+int hugetlb_vmemmap_restore(const struct hstate *h, struct folio *folio)
 {
-	return __hugetlb_vmemmap_restore(h, head, 0);
+	return __hugetlb_vmemmap_restore(h, folio, 0);
 }
 
 /**
@@ -563,7 +564,7 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 
 	list_for_each_entry_safe(folio, t_folio, folio_list, lru) {
 		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
-			ret = __hugetlb_vmemmap_restore(h, &folio->page,
+			ret = __hugetlb_vmemmap_restore(h, folio,
 						VMEMMAP_REMAP_NO_TLB_FLUSH);
 			if (ret)
 				break;
@@ -641,11 +642,12 @@ static bool vmemmap_should_optimize(const struct hstate *h, const struct page *h
 }
 
 static int __hugetlb_vmemmap_optimize(const struct hstate *h,
-					struct page *head,
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
+ * hugetlb_vmemmap_optimize - optimize @folio's vmemmap pages.
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
+void hugetlb_vmemmap_optimize(const struct hstate *h, struct folio *folio)
 {
 	LIST_HEAD(vmemmap_pages);
 
-	__hugetlb_vmemmap_optimize(h, head, &vmemmap_pages, 0);
+	__hugetlb_vmemmap_optimize(h, folio, &vmemmap_pages, 0);
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
@@ -745,7 +747,7 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 	flush_tlb_all();
 
 	list_for_each_entry(folio, folio_list, lru) {
-		int ret = __hugetlb_vmemmap_optimize(h, &folio->page,
+		int ret = __hugetlb_vmemmap_optimize(h, folio,
 						&vmemmap_pages,
 						VMEMMAP_REMAP_NO_TLB_FLUSH);
 
@@ -761,7 +763,7 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 			flush_tlb_all();
 			free_vmemmap_page_list(&vmemmap_pages);
 			INIT_LIST_HEAD(&vmemmap_pages);
-			__hugetlb_vmemmap_optimize(h, &folio->page,
+			__hugetlb_vmemmap_optimize(h, folio,
 						&vmemmap_pages,
 						VMEMMAP_REMAP_NO_TLB_FLUSH);
 		}
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index a0dcf49f46ba..6a06dccd7ffa 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -18,11 +18,11 @@
 #define HUGETLB_VMEMMAP_RESERVE_PAGES	(HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page))
 
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
-int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
+int hugetlb_vmemmap_restore(const struct hstate *h, struct folio *folio);
 long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 					struct list_head *folio_list,
 					struct list_head *non_hvo_folios);
-void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
+void hugetlb_vmemmap_optimize(const struct hstate *h, struct folio *folio);
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
 
 static inline unsigned int hugetlb_vmemmap_size(const struct hstate *h)
@@ -43,7 +43,7 @@ static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate
 	return size > 0 ? size : 0;
 }
 #else
-static inline int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
+static inline int hugetlb_vmemmap_restore(const struct hstate *h, struct folio *folio)
 {
 	return 0;
 }
@@ -56,7 +56,7 @@ static long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 	return 0;
 }
 
-static inline void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
+static inline void hugetlb_vmemmap_optimize(const struct hstate *h, struct folio *folio)
 {
 }
 
-- 
2.25.1

