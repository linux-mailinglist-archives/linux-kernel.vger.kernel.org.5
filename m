Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589A57CE907
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjJRUdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjJRUdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:33:13 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D019B114
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:33:10 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c9e06f058bso748365ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697661190; x=1698265990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvpcd99NjN7SPkeCiS8fl8F++V5hN5b5iiRnzQcVK8o=;
        b=IMT0+xS+0a1edNRwkCunB/DGo3L+bp0M6E520xrCHt9ukaYNX2uhFxEk0tc4KfBrOu
         VB9SnoTKUdNCqAosjLG21O3eG3Mg1150x1b2iE5GkUlFVe8hXT3HoOMDvx8jnAVBOdG9
         oG01SAIK7O9scM+GJXXUestISQTwZWc/R0VKnjjsIvFTjRx1NrLfG8LwNf/b4RfXPPsm
         27U8qoQOjGZfFhxoY+mhLjBnztBtwoss2N12Ol5bnPFLlucY5yO+ww+14yoeO8Bt3GzA
         KBjlGgH3uwsM3PRui9q61yBiD6SUg1CzgWkW2ydzOxBrFknBcFRLdH1tV4zynBJDzBQv
         52RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697661190; x=1698265990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvpcd99NjN7SPkeCiS8fl8F++V5hN5b5iiRnzQcVK8o=;
        b=APZK6Ds4PbJl3qhNNexjHN3KkVpt1WPhxyH01Uzj91rvobP6xIbCcjf4dZZ5+u79vk
         OGWbtxFw0N3tZrk+fAyLcVTZbu4bJcWq1xBQi83R+iFzvZuMILm35cLIFr02nSgdhSDB
         fekqss09LvGrvP8v6CbzjtjHGrpfQhHavLDxzOAcrw/2ykOzSWZiLSwhol7UKCLBl+Op
         V4c8lfbhp3YR7AkHSMgsdh4VOe3xnidjWMBD7RyLOT6Qw+RyEss9lCE9QALigCKuI2NV
         MF6Jq4GvtFgkfiOvPgZvLBKOSf8QQUiTmLZKdFQnaJc+C8VofAsmin2fagMryfTHam1u
         IldA==
X-Gm-Message-State: AOJu0Yyi3FCFyBBl7VRMVPIs2pfZ06TnisNSFcI4hwQWu989DOq8CJjL
        0yCS/5yr0Hj0i/lBJCmdRWyy7p7PyfE=
X-Google-Smtp-Source: AGHT+IEX5D/uPbXU1tWc0zw0n/3MIN2cV8mRj2GKuowCEB+zQiYHmm8zVTMDrPAIhqcUNoWkYM/oPw==
X-Received: by 2002:a17:902:d2ca:b0:1c5:7d49:570e with SMTP id n10-20020a170902d2ca00b001c57d49570emr615553plc.29.1697661190159;
        Wed, 18 Oct 2023 13:33:10 -0700 (PDT)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id w12-20020a170902d3cc00b001c61e628e9dsm354412plb.77.2023.10.18.13.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 13:33:09 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shy828301@gmail.com,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 4/5] mm/khugepaged: Convert alloc_charge_hpage() to use folios
Date:   Wed, 18 Oct 2023 13:32:12 -0700
Message-Id: <20231018203213.50224-5-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018203213.50224-1-vishal.moola@gmail.com>
References: <20231018203213.50224-1-vishal.moola@gmail.com>
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

Also remove count_memcg_page_event now that its last caller no longer uses it,
and convert hpage_collapse_alloc_page() to hpage_collapse_alloc_folio(),

This removes 1 call to compound_head() and helps convert khugepaged to
use folios throughout.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/memcontrol.h | 14 --------------
 mm/khugepaged.c            | 15 ++++++++-------
 2 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index ab94ad4597d0..3126bde982e8 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1080,15 +1080,6 @@ static inline void count_memcg_events(struct mem_cgroup *memcg,
 	local_irq_restore(flags);
 }
 
-static inline void count_memcg_page_event(struct page *page,
-					  enum vm_event_item idx)
-{
-	struct mem_cgroup *memcg = page_memcg(page);
-
-	if (memcg)
-		count_memcg_events(memcg, idx, 1);
-}
-
 static inline void count_memcg_folio_events(struct folio *folio,
 		enum vm_event_item idx, unsigned long nr)
 {
@@ -1565,11 +1556,6 @@ static inline void __count_memcg_events(struct mem_cgroup *memcg,
 {
 }
 
-static inline void count_memcg_page_event(struct page *page,
-					  int idx)
-{
-}
-
 static inline void count_memcg_folio_events(struct folio *folio,
 		enum vm_event_item idx, unsigned long nr)
 {
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 9efd8ff68f06..d49aa22d99c9 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -888,16 +888,16 @@ static int hpage_collapse_find_target_node(struct collapse_control *cc)
 }
 #endif
 
-static bool hpage_collapse_alloc_page(struct page **hpage, gfp_t gfp, int node,
+static bool hpage_collapse_alloc_folio(struct folio **folio, gfp_t gfp, int node,
 				      nodemask_t *nmask)
 {
-	*hpage = __alloc_pages(gfp, HPAGE_PMD_ORDER, node, nmask);
-	if (unlikely(!*hpage)) {
+	*folio = __folio_alloc(gfp, HPAGE_PMD_ORDER, node, nmask);
+
+	if (unlikely(!*folio)) {
 		count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
 		return false;
 	}
 
-	folio_prep_large_rmappable((struct folio *)*hpage);
 	count_vm_event(THP_COLLAPSE_ALLOC);
 	return true;
 }
@@ -1064,17 +1064,18 @@ static int alloc_charge_hpage(struct page **hpage, struct mm_struct *mm,
 	int node = hpage_collapse_find_target_node(cc);
 	struct folio *folio;
 
-	if (!hpage_collapse_alloc_page(hpage, gfp, node, &cc->alloc_nmask))
+	if (!hpage_collapse_alloc_folio(&folio, gfp, node, &cc->alloc_nmask))
 		return SCAN_ALLOC_HUGE_PAGE_FAIL;
 
-	folio = page_folio(*hpage);
 	if (unlikely(mem_cgroup_charge(folio, mm, gfp))) {
 		folio_put(folio);
 		*hpage = NULL;
 		return SCAN_CGROUP_CHARGE_FAIL;
 	}
-	count_memcg_page_event(*hpage, THP_COLLAPSE_ALLOC);
 
+	count_memcg_folio_events(folio, THP_COLLAPSE_ALLOC, 1);
+
+	*hpage = folio_page(folio, 0);
 	return SCAN_SUCCEED;
 }
 
-- 
2.40.1

