Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCE67B6570
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjJCJZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjJCJZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:25:40 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BC190
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 02:25:37 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a2379a8b69so8559957b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 02:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696325136; x=1696929936; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nzmHY2Ka5cz6XnAsRZastGfanbfs6f5GjSGMfdpW808=;
        b=WXsA2qJJtXn2/tmENv4uwUdk8kLVDDTTuWfJM2B8fR3nZJ+m58iZSZxbZ/sHM3EopG
         9quWmhrQ2bK1Xv1bB7bvkKqCHgO3vc3AgDXjq9AlP7X0YC6R1664KeURqOdrp6wdWaCW
         mVGpb8Xshp4psTbbNZyBqMGmY9oTVoMssaOhrfo8qcJckELjB3WoWlAxF3TWFxC7+OxF
         Ns+0gQaVGQeB1xNfoufGbG3LzdT834qI4uRDurJRBfx56coda41z53eaQjDwRuTfa6xW
         Zis5wRpMg75jTEm4kRVBoR2eBVRsAgxoIHayBpwsCPdYxxnyy76222EeYSRQxH6y+7PV
         Tlyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696325136; x=1696929936;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzmHY2Ka5cz6XnAsRZastGfanbfs6f5GjSGMfdpW808=;
        b=kRijiKOmJbgtVC79sBQ8BnPPfaNiJmaC8s1+0y1ng3ERZItwsHjslGF2acNdMiWb4M
         qW/WmMzMvRTCsX4RrS/m53MzbiRQ59lGROaGdrthDKJvOU5BugXsBXCpyhb+2X43vCht
         WfKM0zRp/IvCTpaYlyUoJgy4rwosApuTqCFrBU+Y0T9waa3s5Rg8z15JVhoHNGxIb26N
         7JJg/7Ua3wTJ9uA3bx7oCBFXlmwSFRXmEc5BMrZWMiom0K3npTowBYIVExMCWPsQ6cW7
         xLONAlEFi2uHessNCPT7xTMNMVzKLoIpo6MpSRln7T1eLxamoaRq0bRjNx+hRA6Wwsfo
         TiIg==
X-Gm-Message-State: AOJu0Yy9wgLV6Mr093BhguBDv9TahB83voSsxRUNYYv8MHweTdDuG0DD
        7Ez5c3i1rpwkYVKiY9s4mA6mJQ==
X-Google-Smtp-Source: AGHT+IGmeBMAQui7nSclUIqDA2Y4gv+lO5peTi3URjoKJb2fITfIn+IGiCa25QjXZ2e92Ix5/drY/A==
X-Received: by 2002:a81:4f52:0:b0:599:da80:e1eb with SMTP id d79-20020a814f52000000b00599da80e1ebmr14242966ywb.24.1696325136488;
        Tue, 03 Oct 2023 02:25:36 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o19-20020a81de53000000b005925765aa30sm245713ywl.135.2023.10.03.02.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 02:25:35 -0700 (PDT)
Date:   Tue, 3 Oct 2023 02:25:33 -0700 (PDT)
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
        Michal Hocko <mhocko@suse.com>,
        "Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 09/12] mm: add page_rmappable_folio() wrapper
In-Reply-To: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com>
Message-ID: <8d92c6cf-eebe-748-e29c-c8ab224c741@google.com>
References: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com>
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
 mm/internal.h   |  9 +++++++++
 mm/mempolicy.c  | 17 +++--------------
 mm/page_alloc.c |  8 ++------
 3 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index d7916f1e9e98..b2b3716d1df6 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -415,6 +415,15 @@ static inline void folio_set_order(struct folio *folio, unsigned int order)
 
 void folio_undo_large_rmappable(struct folio *folio);
 
+static inline struct folio *page_rmappable_folio(struct page *page)
+{
+	struct folio *folio = (struct folio *)page;
+
+	if (folio && folio_order(folio) > 1)
+		folio_prep_large_rmappable(folio);
+	return folio;
+}
+
 static inline void prep_compound_head(struct page *page, unsigned int order)
 {
 	struct folio *folio = (struct folio *)page;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index f3224a8b0f6c..bfcc523a2860 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2142,10 +2142,7 @@ struct folio *vma_alloc_folio(gfp_t gfp, int order, struct vm_area_struct *vma,
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
@@ -2155,10 +2152,7 @@ struct folio *vma_alloc_folio(gfp_t gfp, int order, struct vm_area_struct *vma,
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
@@ -2252,12 +2246,7 @@ EXPORT_SYMBOL(alloc_pages);
 
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
index 7df77b58a961..00f94dd88355 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4619,12 +4619,8 @@ struct folio *__folio_alloc(gfp_t gfp, unsigned int order, int preferred_nid,
 		nodemask_t *nodemask)
 {
 	struct page *page = __alloc_pages(gfp | __GFP_COMP, order,
-			preferred_nid, nodemask);
-	struct folio *folio = (struct folio *)page;
-
-	if (folio && order > 1)
-		folio_prep_large_rmappable(folio);
-	return folio;
+					preferred_nid, nodemask);
+	return page_rmappable_folio(page);
 }
 EXPORT_SYMBOL(__folio_alloc);
 
-- 
2.35.3

