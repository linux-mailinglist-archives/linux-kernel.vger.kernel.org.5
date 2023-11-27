Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EE67F9C09
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjK0Ir3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbjK0Ir1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:47:27 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C118110A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:47:33 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b8382b8f5aso2527252b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701074853; x=1701679653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDwCfd7tNwbLPqndee0T3tycLaDjfbEI5ZluCSMX2aI=;
        b=Zo8JzX3QIvF7cZUN/IgQLWMdmTy0dvJYt8dFAonuPDXO4tOrKowwU4tuAoqrKcFWyn
         1AvSBhdcfv09Qim9z0HmAHDG1F+YsKOOzz+jxuTsyEMRmbI9Ye2jJeJ2byapoGRSqNUl
         yHyYd3Kpk8mTFlZEIOgLwtZ86MBExZyog5vhjGvCd/lWDCkOBYz57gqRGBifaq0PMbxP
         s0Y5OaA2m34PvfX4eCNJZvZs5IQhsLcbujdwUkQk0cBg3C41ktew9paAS/4sfhS5ygmR
         6f70GMq5mwi39SCCp4EgqyeFLARCu41NcybmTUkp/M05jzJUnW8Crp9XXmNuAssTbeWC
         4HmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701074853; x=1701679653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDwCfd7tNwbLPqndee0T3tycLaDjfbEI5ZluCSMX2aI=;
        b=sX2RerqNUNT51+Z31bPsIXxeqPjFs/3zguIQ21jBSnNEHMKZ60OGWrMelo6OwBlVgR
         MdenBdw5QYmE3KUh/mVhIiy+UtXM2TIyuo/ZL6+YGssjxlMfD6AAPNpXgj1iOxlCNk96
         TERhAQlK2cPdif3g9aml3CIvcQBTGjXH278uCLrkFHXpmA1OJy9KAbyayNwlRhprmzSM
         4jIC7q6RilV7VWsBteXSZz03ZRqHsrD23xACIBcLi2zPUDOaB7lQK10fV6IqnrYvBFje
         i4FqV4+miH7rBf5cHpz6uoqOxhyCUGWuFrxEnDh/OWlYOqkWvaZjQ3+hVLUMtGkm9AKz
         3kBQ==
X-Gm-Message-State: AOJu0YxpFmmbewvS4hHgPdAQ2IfoDE4YWzpjiwMOgaX+OBVzQOrewTma
        bA0NuC6+qd4F/djSOM/dd7Nuyw==
X-Google-Smtp-Source: AGHT+IGjtsE1BR2K2VhxfkYoA/VOTcyqYgi8MEBB3p+kUcn0pG5OAgrvWgbA1djFn9WP71UH2Rx0sg==
X-Received: by 2002:aca:1c02:0:b0:3ae:156f:d325 with SMTP id c2-20020aca1c02000000b003ae156fd325mr12357984oic.58.1701074853042;
        Mon, 27 Nov 2023 00:47:33 -0800 (PST)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id e22-20020aa78c56000000b006c875abecbcsm6686932pfd.121.2023.11.27.00.47.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Nov 2023 00:47:32 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, muchun.song@linux.dev,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 4/4] mm: hugetlb_vmemmap: convert page to folio
Date:   Mon, 27 Nov 2023 16:46:45 +0800
Message-Id: <20231127084645.27017-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231127084645.27017-1-songmuchun@bytedance.com>
References: <20231127084645.27017-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is still some places where it does not be converted to folio,
this patch convert all of them to folio. And this patch also does
some trival cleanup to fix the code style problems.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 51 ++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index ce920ca6c90ee..54f388aa361fb 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -280,7 +280,7 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
  * Return: %0 on success, negative error code otherwise.
  */
 static int vmemmap_remap_split(unsigned long start, unsigned long end,
-				unsigned long reuse)
+			       unsigned long reuse)
 {
 	int ret;
 	struct vmemmap_remap_walk walk = {
@@ -447,14 +447,14 @@ EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
 static bool vmemmap_optimize_enabled = IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON);
 core_param(hugetlb_free_vmemmap, vmemmap_optimize_enabled, bool, 0);
 
-static int __hugetlb_vmemmap_restore_folio(const struct hstate *h, struct folio *folio, unsigned long flags)
+static int __hugetlb_vmemmap_restore_folio(const struct hstate *h,
+					   struct folio *folio, unsigned long flags)
 {
 	int ret;
-	struct page *head = &folio->page;
-	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
+	unsigned long vmemmap_start = (unsigned long)&folio->page, vmemmap_end;
 	unsigned long vmemmap_reuse;
 
-	VM_WARN_ON_ONCE(!PageHuge(head));
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_hugetlb(folio), folio);
 	if (!folio_test_hugetlb_vmemmap_optimized(folio))
 		return 0;
 
@@ -517,7 +517,7 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 	list_for_each_entry_safe(folio, t_folio, folio_list, lru) {
 		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
 			ret = __hugetlb_vmemmap_restore_folio(h, folio,
-						VMEMMAP_REMAP_NO_TLB_FLUSH);
+							      VMEMMAP_REMAP_NO_TLB_FLUSH);
 			if (ret)
 				break;
 			restored++;
@@ -535,9 +535,9 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 }
 
 /* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
-static bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
+static bool vmemmap_should_optimize_folio(const struct hstate *h, struct folio *folio)
 {
-	if (HPageVmemmapOptimized((struct page *)head))
+	if (folio_test_hugetlb_vmemmap_optimized(folio))
 		return false;
 
 	if (!READ_ONCE(vmemmap_optimize_enabled))
@@ -550,17 +550,16 @@ static bool vmemmap_should_optimize(const struct hstate *h, const struct page *h
 }
 
 static int __hugetlb_vmemmap_optimize_folio(const struct hstate *h,
-					struct folio *folio,
-					struct list_head *vmemmap_pages,
-					unsigned long flags)
+					    struct folio *folio,
+					    struct list_head *vmemmap_pages,
+					    unsigned long flags)
 {
 	int ret = 0;
-	struct page *head = &folio->page;
-	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
+	unsigned long vmemmap_start = (unsigned long)&folio->page, vmemmap_end;
 	unsigned long vmemmap_reuse;
 
-	VM_WARN_ON_ONCE(!PageHuge(head));
-	if (!vmemmap_should_optimize(h, head))
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_hugetlb(folio), folio);
+	if (!vmemmap_should_optimize_folio(h, folio))
 		return ret;
 
 	static_branch_inc(&hugetlb_optimize_vmemmap_key);
@@ -588,7 +587,7 @@ static int __hugetlb_vmemmap_optimize_folio(const struct hstate *h,
 	 * the caller.
 	 */
 	ret = vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse,
-							vmemmap_pages, flags);
+				 vmemmap_pages, flags);
 	if (ret) {
 		static_branch_dec(&hugetlb_optimize_vmemmap_key);
 		folio_clear_hugetlb_vmemmap_optimized(folio);
@@ -615,12 +614,12 @@ void hugetlb_vmemmap_optimize_folio(const struct hstate *h, struct folio *folio)
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
-static int hugetlb_vmemmap_split(const struct hstate *h, struct page *head)
+static int hugetlb_vmemmap_split_folio(const struct hstate *h, struct folio *folio)
 {
-	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
+	unsigned long vmemmap_start = (unsigned long)&folio->page, vmemmap_end;
 	unsigned long vmemmap_reuse;
 
-	if (!vmemmap_should_optimize(h, head))
+	if (!vmemmap_should_optimize_folio(h, folio))
 		return 0;
 
 	vmemmap_end	= vmemmap_start + hugetlb_vmemmap_size(h);
@@ -640,7 +639,7 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 	LIST_HEAD(vmemmap_pages);
 
 	list_for_each_entry(folio, folio_list, lru) {
-		int ret = hugetlb_vmemmap_split(h, &folio->page);
+		int ret = hugetlb_vmemmap_split_folio(h, folio);
 
 		/*
 		 * Spliting the PMD requires allocating a page, thus lets fail
@@ -655,9 +654,10 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 	flush_tlb_all();
 
 	list_for_each_entry(folio, folio_list, lru) {
-		int ret = __hugetlb_vmemmap_optimize_folio(h, folio,
-						&vmemmap_pages,
-						VMEMMAP_REMAP_NO_TLB_FLUSH);
+		int ret;
+
+		ret = __hugetlb_vmemmap_optimize_folio(h, folio, &vmemmap_pages,
+						       VMEMMAP_REMAP_NO_TLB_FLUSH);
 
 		/*
 		 * Pages to be freed may have been accumulated.  If we
@@ -671,9 +671,8 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 			flush_tlb_all();
 			free_vmemmap_page_list(&vmemmap_pages);
 			INIT_LIST_HEAD(&vmemmap_pages);
-			__hugetlb_vmemmap_optimize_folio(h, folio,
-						&vmemmap_pages,
-						VMEMMAP_REMAP_NO_TLB_FLUSH);
+			__hugetlb_vmemmap_optimize_folio(h, folio, &vmemmap_pages,
+							 VMEMMAP_REMAP_NO_TLB_FLUSH);
 		}
 	}
 
-- 
2.20.1

