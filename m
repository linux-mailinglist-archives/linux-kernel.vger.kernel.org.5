Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887837CE905
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjJRUdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjJRUdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:33:11 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C8EA4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:33:08 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5aa7172bafdso3794617a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697661188; x=1698265988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOxvYaksrDFINgvTHvg7i3BLH6nikNi8tBwFFhT4+xI=;
        b=eBS8PwTi2rwkAWHvhPW6qyWd7RE9bHyK24SfVJiOPrfr1Y+JvtZuNEBh/A1hcPgIoR
         ZNUkfUu6kItbXORyqGHr+2BjIFQSMleNRHlF1kAPWDBCoZAju7t5bd0q9g/gPMfuDYQj
         UXIj5PW58mXwMzZmZrUr04LgiDOAjR0daaNjjwyX0Xpivht7iPDnEKN0T75+mEKKfgfo
         81dNZwvBSKT8pvOvoDue6Ne/Jb890BG0KK17BU6V43p5ibS2Wc5QUBVi7BTrc2HJXm6e
         83BFNXUsZsLecdMy6wW0ceiaUqAE1iuCOuWsLbvVzbbb+Zr9yoLNy959Femp/B+zCgf4
         Hd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697661188; x=1698265988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOxvYaksrDFINgvTHvg7i3BLH6nikNi8tBwFFhT4+xI=;
        b=VTUaEsUeH0QNhfvy9JwBhbTSbgmvnqTM9VNyvbI7pOnJw8RNmngG26SpP3Q1nRGt4u
         HlEWCI2hJ7Utj6sOP5D1TM37OwJjl9scGzX+7sakP2dEFq7Qk3uVpELUFxi18xjnLJ4C
         Mj9TIQKSa4zw2wu5n9HBrp/69m20OK5pVVRLOr9JqdHiKm5cL0j6bfn6rmZB0nOeo4zV
         BInvD130IHLvLWXPjg6YY2MNqrrgDTma6nvLlqJvOmEQXmL7audYs6GyovOEZ7lMFuro
         w/sf8kIWLG7wSei9NgQBo93iGaTgU7bHoXVmjr0H5JRgVqwNt8KA5SkPTxdm47DA9SY/
         0VyQ==
X-Gm-Message-State: AOJu0YzTQdRZ06GjvRF74FY5OyTDPlBy1b4EeUfo1XVILffm/h6oyBp9
        cjXdFlQ2MPOWUzisWnJZQFI=
X-Google-Smtp-Source: AGHT+IGSy+gf+h7WIcfgpR19k4aoWiTB0tv72CZNC2cmYBpamwb6VVIlhQcsy15b27bnd2RjKzzbdg==
X-Received: by 2002:a05:6a21:6d99:b0:14c:d494:77d1 with SMTP id wl25-20020a056a216d9900b0014cd49477d1mr327396pzb.10.1697661188209;
        Wed, 18 Oct 2023 13:33:08 -0700 (PDT)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id w12-20020a170902d3cc00b001c61e628e9dsm354412plb.77.2023.10.18.13.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 13:33:07 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shy828301@gmail.com,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 2/5] mm/khugepaged: Convert hpage_collapse_scan_pmd() to use folios
Date:   Wed, 18 Oct 2023 13:32:10 -0700
Message-Id: <20231018203213.50224-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018203213.50224-1-vishal.moola@gmail.com>
References: <20231018203213.50224-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaces 5 calls to compound_head(), and removes 1385 bytes of kernel
text.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/khugepaged.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 500756604488..6c4b5af43371 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1248,6 +1248,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 	int result = SCAN_FAIL, referenced = 0;
 	int none_or_zero = 0, shared = 0;
 	struct page *page = NULL;
+	struct folio *folio = NULL;
 	unsigned long _address;
 	spinlock_t *ptl;
 	int node = NUMA_NO_NODE, unmapped = 0;
@@ -1334,29 +1335,28 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 			}
 		}
 
-		page = compound_head(page);
-
+		folio = page_folio(page);
 		/*
 		 * Record which node the original page is from and save this
 		 * information to cc->node_load[].
 		 * Khugepaged will allocate hugepage from the node has the max
 		 * hit record.
 		 */
-		node = page_to_nid(page);
+		node = folio_nid(folio);
 		if (hpage_collapse_scan_abort(node, cc)) {
 			result = SCAN_SCAN_ABORT;
 			goto out_unmap;
 		}
 		cc->node_load[node]++;
-		if (!PageLRU(page)) {
+		if (!folio_test_lru(folio)) {
 			result = SCAN_PAGE_LRU;
 			goto out_unmap;
 		}
-		if (PageLocked(page)) {
+		if (folio_test_locked(folio)) {
 			result = SCAN_PAGE_LOCK;
 			goto out_unmap;
 		}
-		if (!PageAnon(page)) {
+		if (!folio_test_anon(folio)) {
 			result = SCAN_PAGE_ANON;
 			goto out_unmap;
 		}
@@ -1371,7 +1371,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 		 * has excessive GUP pins (i.e. 512).  Anyway the same check
 		 * will be done again later the risk seems low.
 		 */
-		if (!is_refcount_suitable(page)) {
+		if (!is_refcount_suitable(&folio->page)) {
 			result = SCAN_PAGE_COUNT;
 			goto out_unmap;
 		}
@@ -1381,8 +1381,8 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 		 * enough young pte to justify collapsing the page
 		 */
 		if (cc->is_khugepaged &&
-		    (pte_young(pteval) || page_is_young(page) ||
-		     PageReferenced(page) || mmu_notifier_test_young(vma->vm_mm,
+		    (pte_young(pteval) || folio_test_young(folio) ||
+		     folio_test_referenced(folio) || mmu_notifier_test_young(vma->vm_mm,
 								     address)))
 			referenced++;
 	}
@@ -1404,7 +1404,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 		*mmap_locked = false;
 	}
 out:
-	trace_mm_khugepaged_scan_pmd(mm, page, writable, referenced,
+	trace_mm_khugepaged_scan_pmd(mm, &folio->page, writable, referenced,
 				     none_or_zero, result, unmapped);
 	return result;
 }
-- 
2.40.1

