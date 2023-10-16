Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F877CB3AF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbjJPUHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjJPUHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:07:03 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E8D101
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:06:59 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-27d1a03f540so3655732a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697486818; x=1698091618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjFYTTptetyjp2cWLw2h5u7A70TW4Bkl9MqEU9zvv1g=;
        b=RAElPC84O1IzaJtthHCnuhBPzH6pbi9XT9ZC8lp8Az361wv/rfbfiLh6ftiE1Xv3lr
         VLXbibwaRidhp5PDxrHRvCs5t18/ZyS52BA2xhzx0Ki+wjjObjWydsI265Spyv51Whrv
         xxoPeZ55koA8ygP6n0zXX6DbXUYoUc2DH0kQ/5UIk/DhywmKaT6jL7/e/LwBtta5hHcK
         thasI3Cg9OBZsuRrfG4BN4bMlISO7kz1UtvND2Mu+2iOrZkWLs6InBM+Ua8fcjPYsm21
         yq3g5B7oDs1OZDCTiN8mgN4xNUhjOTwyryhiYCKfGe5q7DV64yWHdzAPf25LHZtB0Vmv
         jL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697486818; x=1698091618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjFYTTptetyjp2cWLw2h5u7A70TW4Bkl9MqEU9zvv1g=;
        b=kMqjt5uz1im3lnfwEcHk/8sY2HtE9VOU3slx9voqWU8SARG+pOhOYi/pEq6Nf8H1KS
         UXB7yxZtTAh99spLR/BOdAxBs7tiYMSpvIk5YCHlObyJlOhIBBQZ8mwIadW/Qc9btHqv
         YiCQDRpfVg0z0g5Iy1hDdjSCSjekMh3QsOd5E3V0VDb6969vqeNg7UVqFSenjKSu85fq
         rZOqc4/ZP+0pTOrtszlcgES/3iHhge7eoLBx0YjsD6ziQOtqnKEFB05NKbLj+D3weVxr
         rAQP1gNAuuLytGK9yaXTHYhchL7OzAVh6HaM4mD0aBJ30DV7HooAcTYRFi1OgsX6ug6W
         S61Q==
X-Gm-Message-State: AOJu0Yyd5W5LCTz5YdNJShTGgHa8aJdGLEguXmqgdN61NWQ0bjsnRpQV
        RygkqOyP66QAKypC37KZsCvmJg9N2H4=
X-Google-Smtp-Source: AGHT+IGtbGzgcQz/00iryQWZ82rvlGPg9aar7vEHyd9Xs5MULzqeh3bW4EbQYfV2V5h2DPzj6QHTog==
X-Received: by 2002:a17:90a:eb09:b0:27c:fc09:401d with SMTP id j9-20020a17090aeb0900b0027cfc09401dmr179801pjz.38.1697486818298;
        Mon, 16 Oct 2023 13:06:58 -0700 (PDT)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id t16-20020a17090b019000b002772faee740sm5162367pjs.5.2023.10.16.13.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 13:06:58 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shy828301@gmail.com,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 3/5] mm/khugepaged: Convert is_refcount_suitable() to use folios
Date:   Mon, 16 Oct 2023 13:05:08 -0700
Message-Id: <20231016200510.7387-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231016200510.7387-1-vishal.moola@gmail.com>
References: <20231016200510.7387-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both callers of is_refcount_suitable() have been converted to use
folios, so convert it to take in a folio. Both callers only operate on
head pages of folios so mapcount/refcount conversions here are trivial.

Removes 3 calls to compound head, and removes 315 bytes of kernel text.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/khugepaged.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 67aac53b31c8..fa21a53ce0c0 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -524,15 +524,15 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
 	}
 }
 
-static bool is_refcount_suitable(struct page *page)
+static bool is_refcount_suitable(struct folio *folio)
 {
 	int expected_refcount;
 
-	expected_refcount = total_mapcount(page);
-	if (PageSwapCache(page))
-		expected_refcount += compound_nr(page);
+	expected_refcount = folio_mapcount(folio);
+	if (folio_test_swapcache(folio))
+		expected_refcount += folio_nr_pages(folio);
 
-	return page_count(page) == expected_refcount;
+	return folio_ref_count(folio) == expected_refcount;
 }
 
 static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
@@ -623,7 +623,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		 * but not from this process. The other process cannot write to
 		 * the page, only trigger CoW.
 		 */
-		if (!is_refcount_suitable(&folio->page)) {
+		if (!is_refcount_suitable(folio)) {
 			folio_unlock(folio);
 			result = SCAN_PAGE_COUNT;
 			goto out;
@@ -1367,7 +1367,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 		 * has excessive GUP pins (i.e. 512).  Anyway the same check
 		 * will be done again later the risk seems low.
 		 */
-		if (!is_refcount_suitable(&folio->page)) {
+		if (!is_refcount_suitable(folio)) {
 			result = SCAN_PAGE_COUNT;
 			goto out_unmap;
 		}
-- 
2.40.1

