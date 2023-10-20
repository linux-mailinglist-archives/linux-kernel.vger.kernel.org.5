Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89A17D15DA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 20:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjJTSdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 14:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjJTSds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 14:33:48 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEFA1A8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 11:33:46 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6b5cac99cfdso1054410b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 11:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697826826; x=1698431626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/rAUjlYbudj5wnw8lHkufWutUwYDRgsClPJWjawwgo=;
        b=VH+0CnjMk9UQe/XogDr4e3WlaCk4NdyH46es8n3wMSx1EKeVd1oygRkYQV1ou956FI
         PSjOBcNMMYmIIIJIg1gNFUIlUxK1Mr5/drJnX2c+he51Fy0nZXajkRwpKSYuO6kIAWdG
         o3lihQaC7FRsnPtmCMf0sXUyxn1mfPbByh450gEqi7SuAXsRt1OxFEpZAfh6ZbYbNldS
         O//lADm9/p2bAtqRo/0J5eZTyaIT1asGObyvR7Wi/U4tvFP6poDs3PePyrE0qXagmPtm
         LS2VJRqa5k7S/udB61F/KY2ljLhHubwzDXh/W0BG0JszY+xDp0yPM3fc1WDlbj4e8dgk
         WnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697826826; x=1698431626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/rAUjlYbudj5wnw8lHkufWutUwYDRgsClPJWjawwgo=;
        b=M+wN21SnBMo2Wi//noFdAa6m4uRC0lkbVwVIkQRQ2zlekN8JQKPeBLqSgBFyQ1ecev
         VxtfJVjz+kc729qFnuSlDl3fHIKh3RZMZLPRBu2u1Zml14pCYU3uP7sSE6m5WReayWKw
         hp+bNzeSzegmkeOP/XuqCOr+wS0Ex2V2VLYx9ankpAj7s/she1toVN3lLSarHuLaaFaM
         aTU9neCa5h1tdF5KobUYCDFJAwEyO8cWn+guK3oWtJLSecTyfX3/y+9m1npxVJuc/c/T
         y5Ug4Z0f6jiWOmbwuoYFDcng85RUjEW9L4OJEPHtEtLmsX08HHnhlLAjMcO7bALn2pk8
         HW6Q==
X-Gm-Message-State: AOJu0YyqAGBOAmWT5fYiKtp2KZ5pLghXiwSjIn9jwXO0iavHiPg2GlIb
        0hTW1WHviSixs9HJ6XVg6WcxJvlaqpA=
X-Google-Smtp-Source: AGHT+IHyGeFVYpw0wd/VaSvhNfJGFkjxPCXQo0amteeNn2H2xRJuWdIEmOzTNv8bZATyXXNSf6XFFg==
X-Received: by 2002:a05:6a00:2341:b0:6b3:2106:94b0 with SMTP id j1-20020a056a00234100b006b3210694b0mr2956504pfj.23.1697826825800;
        Fri, 20 Oct 2023 11:33:45 -0700 (PDT)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id z14-20020aa7990e000000b006b4ac8885b4sm1911345pff.14.2023.10.20.11.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 11:33:45 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 3/5] mm/khugepaged: Convert is_refcount_suitable() to use folios
Date:   Fri, 20 Oct 2023 11:33:29 -0700
Message-Id: <20231020183331.10770-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231020183331.10770-1-vishal.moola@gmail.com>
References: <20231020183331.10770-1-vishal.moola@gmail.com>
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
index 6c4b5af43371..9efd8ff68f06 100644
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
@@ -625,7 +625,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		 * but not from this process. The other process cannot write to
 		 * the page, only trigger CoW.
 		 */
-		if (!is_refcount_suitable(&folio->page)) {
+		if (!is_refcount_suitable(folio)) {
 			folio_unlock(folio);
 			result = SCAN_PAGE_COUNT;
 			goto out;
@@ -1371,7 +1371,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
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

