Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387537D15DB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 20:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjJTSdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 14:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjJTSds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 14:33:48 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F57112
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 11:33:45 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6ba172c5f3dso1070394b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 11:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697826825; x=1698431625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOxvYaksrDFINgvTHvg7i3BLH6nikNi8tBwFFhT4+xI=;
        b=IiZSR70ybdNI3AWQ9+UGfUte2FcmKSqDQ31Ilhg4Z/kpgKRYeh3Geibq7t//IRFKyP
         4jGhFcLhrfz0e4CnsrX4jM5Yhg1gohG0E0XQH4r1uqOcWrajeDMW93kQZBCkARxVcAjz
         tHrvw0MADRUkU/x1oe3NaVTTUIkGvqfEpVg1CXf+dH7GR2kquYD2lVj45r9djTdV0gT+
         CoBcIm3l3n9z9bygs9VLZiaUHXA/fGRHK1fTjrhroUEhUQVrGmcZOzYb9IclutCGBmVx
         X0ugtJZM5V2y/Qq1PPI1Jm7Cpnxs5sejIjjGVHzBNDybDpu9IZvV49mlmG3U18fvxOAO
         Gj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697826825; x=1698431625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOxvYaksrDFINgvTHvg7i3BLH6nikNi8tBwFFhT4+xI=;
        b=nIXgwvgv2MMUee001NekUieiDMzkwFOKzgduuNUaz9XFDw4XO2dQbhCZ/XUN7Ugg7G
         Fsrz5Pb9iijAQBSuHgzu+jxEGVV5zVCLvYNfnIS9RQ9PYuTPEAsll1LXgRg5e3scxfQz
         WiN9007jb5agOBLIWRng3u0GIXrN1DiophtzvS1/xGgEu55lSNMlqWC59/a57nEmibU4
         clq2zheuVh7yTBz/7uMPXoQnjXrIXSl5J2lcYl84+DRWcrDCXSrwOVJOMNpIAykkN06s
         I+I7I1SC9/d9r4/rkD7AR98tr+1w6htk4HXDC4gKzIBXd9R2cfTIpoJSUQOOfR5sFxLP
         WU6w==
X-Gm-Message-State: AOJu0YxU7mbuRtGkv7xFgUXJqtmQeFzpGr20Gq+zO1poKer3UWhEq9dc
        /TSf7fZ8NeJeStqCsxmsncg=
X-Google-Smtp-Source: AGHT+IGjvWBVIPvS8d/Tp9SPsRWhqao+5hgFvjwUvgPczwPUlTiLiRzRdGbqQM/sCIzdkV5OmPNgVQ==
X-Received: by 2002:a05:6a00:1393:b0:6bc:62d0:fffd with SMTP id t19-20020a056a00139300b006bc62d0fffdmr2943268pfg.15.1697826824857;
        Fri, 20 Oct 2023 11:33:44 -0700 (PDT)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id z14-20020aa7990e000000b006b4ac8885b4sm1911345pff.14.2023.10.20.11.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 11:33:44 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 2/5] mm/khugepaged: Convert hpage_collapse_scan_pmd() to use folios
Date:   Fri, 20 Oct 2023 11:33:28 -0700
Message-Id: <20231020183331.10770-3-vishal.moola@gmail.com>
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

