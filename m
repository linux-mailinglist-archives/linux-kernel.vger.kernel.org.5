Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A99B7AD364
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbjIYIcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjIYIcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:32:13 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18FABC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:32:06 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-59c07cf02ebso70286667b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695630726; x=1696235526; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ESRqX1PlrIchswbjY6F5gY3I+wvwb2kVpQ+ph7N3oWo=;
        b=YE4gVrE5UL3QWSJeaJ9+SqhEvadjQ/UUiak38YJh+2A9pLX7wZzVsi9aHGiMb016GF
         HlobMBNghSGPFjKkEaNDAevbtJm0qXJ4cK37tYR6nvMlGOkIgTPNlrYHa6bbomG5EMHu
         t+cPaCGIPOE8961bC5sw5/bOdB5361HMj0UJfZbj4RKKYgSj+9PnMU1M38qV/SQzOZbW
         M13g6E1MhUumfqBexsINmPKFI9tftuGgc0E56/rFOOXZwUFeKw5Nym9UsRU+f6Eio/4F
         9P8NyUxY0PvSVjzGahoALL+o+6pKQkMAkDewE59zN5VGavTCUrfJZBr50bxIYvOcV6tw
         BDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695630726; x=1696235526;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ESRqX1PlrIchswbjY6F5gY3I+wvwb2kVpQ+ph7N3oWo=;
        b=YJe5QZdOi0128JeJUqMWV1+kQnm1hcxyFHi6rC50g+I6ECm6muUccQ8GxfjCvH7ihN
         F4Fwsoln/XES18aIfLhORWs0NIs/oYzGmQRlyuri55v9UEaF8+2EudGMq1BfR/Ej3ItH
         PkMFdrtqZB8tiCSLKH1LW/wfNpbm3hmzHv9L2WTNmbBwgGgTkglNXNELX4I6KjDW/i7m
         Ht6qkrhQCdDmT32+8h4htmtxRJTybB1F0f4zM2Azxj+cGXOIlVgS5uWQBYHprom4R07D
         8gR/hd+fiY/MvUaVcBY7Uf1c9LWJoC1qBrVbcQK9dQx2OGR46G9erXvipETEuVN6qBkG
         MkDw==
X-Gm-Message-State: AOJu0YyMb/fCyWWzjcnwqHkgEsfgptHKgx6EBT22GHGMNiVFHEMhraZu
        GHY8lnEC4xCEt6gk8+T/ibWX5A==
X-Google-Smtp-Source: AGHT+IFI7sWdT9SaX/WaLFmLycQV1E3ZHD2waCsU6dSHFKECPifOP+qkTIKONo5XkYDTZbJNeNdwNw==
X-Received: by 2002:a25:744b:0:b0:d84:da24:96de with SMTP id p72-20020a25744b000000b00d84da2496demr5304926ybc.33.1695630725781;
        Mon, 25 Sep 2023 01:32:05 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t3-20020a056902018300b00d1b86efc0ffsm2024884ybh.6.2023.09.25.01.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 01:32:05 -0700 (PDT)
Date:   Mon, 25 Sep 2023 01:32:02 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Andi Kleen <ak@linux.intel.com>, Christoph Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 09/12] mm: add page_rmappable_folio() wrapper
In-Reply-To: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com>
Message-ID: <f4dc7bb6-be3a-c1b-c30-37c4e0c16e4d@google.com>
References: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

folio_prep_large_rmappable() is being used repeatedly along with a
conversion from page to folio, a check non-NULL, a check order > 1:
wrap it all up into struct folio *page_rmappable_folio(struct page *).

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/huge_mm.h | 13 +++++++++++++
 mm/mempolicy.c          | 17 +++--------------
 mm/page_alloc.c         |  8 ++------
 3 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index fa0350b0812a..58e7662a8a62 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -141,6 +141,15 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags);
 
 void folio_prep_large_rmappable(struct folio *folio);
+static inline struct folio *page_rmappable_folio(struct page *page)
+{
+	struct folio *folio = (struct folio *)page;
+
+	if (folio && folio_order(folio) > 1)
+		folio_prep_large_rmappable(folio);
+	return folio;
+}
+
 bool can_split_folio(struct folio *folio, int *pextra_pins);
 int split_huge_page_to_list(struct page *page, struct list_head *list);
 static inline int split_huge_page(struct page *page)
@@ -281,6 +290,10 @@ static inline bool hugepage_vma_check(struct vm_area_struct *vma,
 }
 
 static inline void folio_prep_large_rmappable(struct folio *folio) {}
+static inline struct folio *page_rmappable_folio(struct page *page)
+{
+	return (struct folio *)page;
+}
 
 #define transparent_hugepage_flags 0UL
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 7ab6102d7da4..4c3b3f535630 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2137,10 +2137,7 @@ struct folio *vma_alloc_folio(gfp_t gfp, int order, struct vm_area_struct *vma,
 		mpol_cond_put(pol);
 		gfp |= __GFP_COMP;
 		page = alloc_page_interleave(gfp, order, nid);
-		folio = (struct folio *)page;
-		if (folio && order > 1)
-			folio_prep_large_rmappable(folio);
-		goto out;
+		return page_rmappable_folio(page);
 	}
 
 	if (pol->mode == MPOL_PREFERRED_MANY) {
@@ -2150,10 +2147,7 @@ struct folio *vma_alloc_folio(gfp_t gfp, int order, struct vm_area_struct *vma,
 		gfp |= __GFP_COMP;
 		page = alloc_pages_preferred_many(gfp, order, node, pol);
 		mpol_cond_put(pol);
-		folio = (struct folio *)page;
-		if (folio && order > 1)
-			folio_prep_large_rmappable(folio);
-		goto out;
+		return page_rmappable_folio(page);
 	}
 
 	if (unlikely(IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && hugepage)) {
@@ -2247,12 +2241,7 @@ EXPORT_SYMBOL(alloc_pages);
 
 struct folio *folio_alloc(gfp_t gfp, unsigned order)
 {
-	struct page *page = alloc_pages(gfp | __GFP_COMP, order);
-	struct folio *folio = (struct folio *)page;
-
-	if (folio && order > 1)
-		folio_prep_large_rmappable(folio);
-	return folio;
+	return page_rmappable_folio(alloc_pages(gfp | __GFP_COMP, order));
 }
 EXPORT_SYMBOL(folio_alloc);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 95546f376302..5b1707d9025a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4456,12 +4456,8 @@ struct folio *__folio_alloc(gfp_t gfp, unsigned int order, int preferred_nid,
 		nodemask_t *nodemask)
 {
 	struct page *page = __alloc_pages(gfp | __GFP_COMP, order,
-			preferred_nid, nodemask);
-	struct folio *folio = (struct folio *)page;
-
-	if (folio && order > 1)
-		folio_prep_large_rmappable(folio);
-	return folio;
+					  preferred_nid, nodemask);
+	return page_rmappable_folio(page);
 }
 EXPORT_SYMBOL(__folio_alloc);
 
-- 
2.35.3

