Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0944C75F8E1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjGXNuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjGXNtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:49:52 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556FB100
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:46:50 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc244d307so41942555e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690206408; x=1690811208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+5f3AgE150Mh6cYaW30LczJjyIbsUmp9ItlqNwo9Gs=;
        b=ikYTxmvNKkByuJlR0NutAuZwBS+HffntLHXBTOm8ABSvwCfWL2fKqLXT+iOY+era+y
         0f+kQ2586uXX6d82nfLBSpOQr1gqnMFjKQ47G8ZLbVTI8NSLejjGc+kDPEvl1HVxnBUF
         jCpEFBNwQAA+XsldO7xDMXzVVhi5WukMODB/6kuUFR9VRoS+9pioBp657mkjAf4PNZ/i
         F4wa0/ndwm2yPUB7BijO2XndG4yNOsOBIbw8Z0pGdeoakBDEl8/5c+TqIcujNE6fR8ZQ
         FpFK7b0NO5bBOQMrm+8GlX2hKWNa2zqyvycuRIQfoA56RG/Cn9fc7U79QcopUi7lSSGW
         lQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690206408; x=1690811208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+5f3AgE150Mh6cYaW30LczJjyIbsUmp9ItlqNwo9Gs=;
        b=iMLyZHJf6jEXtbxwDDAos85BMzdy8NNfzcJ10mey5YSkwmYR8b7Jsj2xd2eaoU6scJ
         y5j3dyZeD0/a/kXOptt1NXnN38Y/SAyJUd+WcaD5L2rBTFz/mJv92AEoi+i/e0VZgxcz
         w09ZZyhueHjiblw0pRjr9hybFOKMoTy/MqFg5TNTkyHyqruwNLta33WCxy+KUh/iDL53
         ag2dQQxHN0FuxcOAjjXtgez/AUT5CqkW6tpu1rnKkYU0fNVu5cKcM2Pe5Ym/6orXm3+T
         WbzbGO8+MDq4uezjOquvOZrjwcqqS9ek2Lm3dRw5FdlFJqG+YSSXICshGLp4BVf1CSyT
         MxPg==
X-Gm-Message-State: ABy/qLbGeto0GKGPKAG5dsVAIgo3zjevd1AqopZ+fXRLYVhMJgLk8tqs
        h2PXpXyPYlnLf3FQ2YLFqdP3qw==
X-Google-Smtp-Source: APBJJlG2oRr8ivYhrN6NtzN8nuU0+P+lfubBc/YogasGIn8tgMOZpf/GJE4V1pfPjhr20IzDbaEKIw==
X-Received: by 2002:a1c:750a:0:b0:3fd:ad65:ea8b with SMTP id o10-20020a1c750a000000b003fdad65ea8bmr3233762wmc.12.1690206408483;
        Mon, 24 Jul 2023 06:46:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b465:0:d7c4:7f46:8fed:f874])
        by smtp.gmail.com with ESMTPSA id e19-20020a05600c219300b003fbe791a0e8sm10209354wme.0.2023.07.24.06.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 06:46:48 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [RFC 1/4] mm/hugetlb: Skip prep of tail pages when HVO is enabled
Date:   Mon, 24 Jul 2023 14:46:41 +0100
Message-Id: <20230724134644.1299963-2-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230724134644.1299963-1-usama.arif@bytedance.com>
References: <20230724134644.1299963-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 mm/hugetlb.c         | 30 +++++++++++++++++++++---------
 mm/hugetlb_vmemmap.c |  2 +-
 mm/hugetlb_vmemmap.h |  1 +
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 64a3239b6407..24352abbb9e5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1943,13 +1943,22 @@ static void prep_new_hugetlb_folio(struct hstate *h, struct folio *folio, int ni
 }
 
 static bool __prep_compound_gigantic_folio(struct folio *folio,
-					unsigned int order, bool demote)
+					unsigned int order, bool demote,
+					bool hugetlb_vmemmap_optimizable)
 {
 	int i, j;
 	int nr_pages = 1 << order;
 	struct page *p;
 
 	__folio_clear_reserved(folio);
+
+	/*
+	 * No need to prep pages that will be freed later by hugetlb_vmemmap_optimize
+	 * in prep_new_huge_page. Hence, reduce nr_pages to the pages that will be kept.
+	 */
+	if (hugetlb_vmemmap_optimizable)
+		nr_pages = HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page);
+
 	for (i = 0; i < nr_pages; i++) {
 		p = folio_page(folio, i);
 
@@ -2020,15 +2029,15 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
 }
 
 static bool prep_compound_gigantic_folio(struct folio *folio,
-							unsigned int order)
+							unsigned int order, bool hugetlb_vmemmap_optimizable)
 {
-	return __prep_compound_gigantic_folio(folio, order, false);
+	return __prep_compound_gigantic_folio(folio, order, false, hugetlb_vmemmap_optimizable);
 }
 
 static bool prep_compound_gigantic_folio_for_demote(struct folio *folio,
-							unsigned int order)
+							unsigned int order, bool hugetlb_vmemmap_optimizable)
 {
-	return __prep_compound_gigantic_folio(folio, order, true);
+	return __prep_compound_gigantic_folio(folio, order, true, hugetlb_vmemmap_optimizable);
 }
 
 /*
@@ -2185,7 +2194,8 @@ static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
 	if (!folio)
 		return NULL;
 	if (hstate_is_gigantic(h)) {
-		if (!prep_compound_gigantic_folio(folio, huge_page_order(h))) {
+		if (!prep_compound_gigantic_folio(folio, huge_page_order(h),
+							 vmemmap_should_optimize(h, &folio->page))) {
 			/*
 			 * Rare failure to convert pages to compound page.
 			 * Free pages and try again - ONCE!
@@ -3201,7 +3211,8 @@ static void __init gather_bootmem_prealloc(void)
 
 		VM_BUG_ON(!hstate_is_gigantic(h));
 		WARN_ON(folio_ref_count(folio) != 1);
-		if (prep_compound_gigantic_folio(folio, huge_page_order(h))) {
+		if (prep_compound_gigantic_folio(folio, huge_page_order(h),
+						vmemmap_should_optimize(h, page))) {
 			WARN_ON(folio_test_reserved(folio));
 			prep_new_hugetlb_folio(h, folio, folio_nid(folio));
 			free_huge_page(page); /* add to the hugepage allocator */
@@ -3624,8 +3635,9 @@ static int demote_free_hugetlb_folio(struct hstate *h, struct folio *folio)
 		subpage = folio_page(folio, i);
 		inner_folio = page_folio(subpage);
 		if (hstate_is_gigantic(target_hstate))
-			prep_compound_gigantic_folio_for_demote(inner_folio,
-							target_hstate->order);
+			prep_compound_gigantic_folio_for_demote(folio,
+							target_hstate->order,
+							vmemmap_should_optimize(target_hstate, subpage));
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
index 25bd0e002431..3525c514c061 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -57,4 +57,5 @@ static inline bool hugetlb_vmemmap_optimizable(const struct hstate *h)
 {
 	return hugetlb_vmemmap_optimizable_size(h) != 0;
 }
+bool vmemmap_should_optimize(const struct hstate *h, const struct page *head);
 #endif /* _LINUX_HUGETLB_VMEMMAP_H */
-- 
2.25.1

