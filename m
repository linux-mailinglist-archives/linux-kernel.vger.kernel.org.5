Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F53765D94
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 22:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjG0UrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 16:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjG0Uq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 16:46:56 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6597271D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 13:46:33 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b701e1ca63so21959291fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 13:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690490792; x=1691095592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaqNw2Hm1guEkvjK0qvKkO1TrGxzTe44nwo0h0OS4xY=;
        b=Qh4G5pkJ2CklC1dn5cBz4RJXwctIF25YGEWE2oQ3ZrOzxnKalFKae/8pznmb31lV7C
         WTzPyronTTWL8g0r5I8lSbz/AdU7gvJCGq8K2Qd4vWzRvFiQ/FfCwXl6dsQ9CmNizTh+
         m0AH/lVmLiMfUecg6qsdvv9XMrT/D7wOGOTWcG9Zt50oRSe1Bavo9Ko7yaB4wjJ+Qnnr
         BNWwV0vvSuj9U4WuwZrl1x2sIhyQwELI33CtL1QqIzp+Rtzz205zsveFrvcH9XBhLeZX
         G7lPHvXhJp/f1c2Jmw7kl1BPg6BGcbtzSnM+LE3IJIaKxCmCB8OfQyprqC6Rh3SHBpsg
         Wpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690490792; x=1691095592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oaqNw2Hm1guEkvjK0qvKkO1TrGxzTe44nwo0h0OS4xY=;
        b=cIWRrNJAxXNGf/cCZhI/WhleJ19H1lVTspF1KEz1+LkNa+BpyAJ+m7YXZSFRX8KH8d
         pneT9TvEiEmnUN16gKM9HWiLhanRdxidkvdlBx83NWaPgWc7MHxjiNinmoXPLKkoH6fB
         vzWqrEoM4yFn/SvLONJh7akI9MvWdrNPRS1PNOrGiimjXAJ2F/sWASw2/7LTPI7dnEwF
         ucIZ/UfvzsJQzMCnPHlc9B4/CNQJA19qkYKkZgHwELSTZ0F8vBGofPZxVfybIitiO6SH
         IfmZh99jDUMozxHvz5OpiwSAuTAW6R2XGEZ2GUspB2NvXC2BhFijze1zaKQarx1M7mNO
         VwSA==
X-Gm-Message-State: ABy/qLZgHUZWAldkarwnuXffsAWSX4T5nA+KGPwAlHXFCiUCjrncRqVT
        zta/RDF8HM2Gb6VMjtJo1WXDyg==
X-Google-Smtp-Source: APBJJlEpvm0P4NAPU6V060zctU8cT38iuWapH30/cDkVR/gUSQA0rrC4oV9wP9Dr8ocbwFl306QznA==
X-Received: by 2002:a05:651c:1042:b0:2b6:da64:321 with SMTP id x2-20020a05651c104200b002b6da640321mr95486ljm.45.1690490792019;
        Thu, 27 Jul 2023 13:46:32 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b465:0:7e3e:db9e:70fa:9ccb])
        by smtp.gmail.com with ESMTPSA id k1-20020a7bc401000000b003fc06169abdsm2701400wmi.2.2023.07.27.13.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 13:46:31 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [v1 1/6] mm: hugetlb: Skip prep of tail pages when HVO is enabled
Date:   Thu, 27 Jul 2023 21:46:19 +0100
Message-Id: <20230727204624.1942372-2-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230727204624.1942372-1-usama.arif@bytedance.com>
References: <20230727204624.1942372-1-usama.arif@bytedance.com>
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

When vmemmap is optimizable, it will free all the
duplicated tail pages in hugetlb_vmemmap_optimize while
preparing the new hugepage. Hence, there is no need to
prepare them.

For 1G x86 hugepages, it avoids preparing
262144 - 64 = 262080 struct pages per hugepage.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 mm/hugetlb.c         | 32 +++++++++++++++++++++++---------
 mm/hugetlb_vmemmap.c |  2 +-
 mm/hugetlb_vmemmap.h |  7 +++++++
 3 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 64a3239b6407..58cf5978bee1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1943,13 +1943,24 @@ static void prep_new_hugetlb_folio(struct hstate *h, struct folio *folio, int ni
 }
 
 static bool __prep_compound_gigantic_folio(struct folio *folio,
-					unsigned int order, bool demote)
+					unsigned int order, bool demote,
+					bool hvo)
 {
 	int i, j;
 	int nr_pages = 1 << order;
 	struct page *p;
 
 	__folio_clear_reserved(folio);
+
+#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+	/*
+	 * No need to prep pages that will be freed later by hugetlb_vmemmap_optimize
+	 * in prep_new_huge_page. Hence, reduce nr_pages to the pages that will be kept.
+	 */
+	if (hvo)
+		nr_pages = HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page);
+#endif
+
 	for (i = 0; i < nr_pages; i++) {
 		p = folio_page(folio, i);
 
@@ -2020,15 +2031,15 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
 }
 
 static bool prep_compound_gigantic_folio(struct folio *folio,
-							unsigned int order)
+							unsigned int order, bool hvo)
 {
-	return __prep_compound_gigantic_folio(folio, order, false);
+	return __prep_compound_gigantic_folio(folio, order, false, hvo);
 }
 
 static bool prep_compound_gigantic_folio_for_demote(struct folio *folio,
-							unsigned int order)
+							unsigned int order, bool hvo)
 {
-	return __prep_compound_gigantic_folio(folio, order, true);
+	return __prep_compound_gigantic_folio(folio, order, true, hvo);
 }
 
 /*
@@ -2185,7 +2196,8 @@ static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
 	if (!folio)
 		return NULL;
 	if (hstate_is_gigantic(h)) {
-		if (!prep_compound_gigantic_folio(folio, huge_page_order(h))) {
+		if (!prep_compound_gigantic_folio(folio, huge_page_order(h),
+						  vmemmap_should_optimize(h, &folio->page))) {
 			/*
 			 * Rare failure to convert pages to compound page.
 			 * Free pages and try again - ONCE!
@@ -3201,7 +3213,8 @@ static void __init gather_bootmem_prealloc(void)
 
 		VM_BUG_ON(!hstate_is_gigantic(h));
 		WARN_ON(folio_ref_count(folio) != 1);
-		if (prep_compound_gigantic_folio(folio, huge_page_order(h))) {
+		if (prep_compound_gigantic_folio(folio, huge_page_order(h),
+						vmemmap_should_optimize(h, page))) {
 			WARN_ON(folio_test_reserved(folio));
 			prep_new_hugetlb_folio(h, folio, folio_nid(folio));
 			free_huge_page(page); /* add to the hugepage allocator */
@@ -3624,8 +3637,9 @@ static int demote_free_hugetlb_folio(struct hstate *h, struct folio *folio)
 		subpage = folio_page(folio, i);
 		inner_folio = page_folio(subpage);
 		if (hstate_is_gigantic(target_hstate))
-			prep_compound_gigantic_folio_for_demote(inner_folio,
-							target_hstate->order);
+			prep_compound_gigantic_folio_for_demote(folio,
+						target_hstate->order,
+						vmemmap_should_optimize(target_hstate, subpage));
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
index 25bd0e002431..07555d2dc0cb 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -13,6 +13,7 @@
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
 void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
+bool vmemmap_should_optimize(const struct hstate *h, const struct page *head);
 
 /*
  * Reserve one vmemmap page, all vmemmap addresses are mapped to it. See
@@ -51,6 +52,12 @@ static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate
 {
 	return 0;
 }
+
+bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
+{
+	return false;
+}
+
 #endif /* CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP */
 
 static inline bool hugetlb_vmemmap_optimizable(const struct hstate *h)
-- 
2.25.1

