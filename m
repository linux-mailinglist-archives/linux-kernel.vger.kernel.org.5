Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5F47D15DC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 20:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjJTSd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 14:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJTSds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 14:33:48 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62806D63
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 11:33:47 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5859a7d6556so882222a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 11:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697826827; x=1698431627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xk5ybvp+SNZIaZ3pEA3Be7vi8BfZn75lCz2iohEvZyM=;
        b=l9B4cEmI+le35OCk8zv59oEfyblRpzTvTu3zdY9zOhtmFxbCbrDz8gO/iH5Ehn/Q1R
         bEjFLT2zrM+hHEsYApgYvqMXneg+GS56muHYvOKqV8iWbcsyfjPo6pAuwbnGZT1suaHk
         oSg6img7hjkxNYelXR+gTDsE1yWYl6EDzkvV/ssqAE9tQPzzh2wW7+rqCmbyTydJiwdj
         gTozqh7o9714pFs9ix5oBrTK6W4FHRXyl1v3vEAW6BQULdfNbHrVTytYWNkKfxclwggW
         RN6seG/fm9+WzhgSTgMsdJ6SXxBTbyNaX3Wgf6UcR7g8MSi1o4gSm6PY68N8+e0HCViL
         7JFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697826827; x=1698431627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xk5ybvp+SNZIaZ3pEA3Be7vi8BfZn75lCz2iohEvZyM=;
        b=vZUZeqYfAClUWzZJOSo9ugk3fcEzNFPzcL+7++DW8sJjuK3rE3v1qS/s5Hvds+4eKg
         cPTpKi0nSvgKKEPGv0fPUu6m3BorhvuHMlM0baAapODMiGCNvAUUCYoz5r2aI8u4WRzI
         vdNcrsGHT8Pz5V0tZ3YoRrr7I7iL6E/oGgTefWY8igjVH5fv/cE0qdGZJ0uBWIfbs+3j
         JY+LeV+jpN+wc5zHoPLM1qQAG2OoppZKtP4GAhdOZThp4IN77BouOWkCuWxRDVXqgPqh
         k4Sw3E57MNyBZ8HwQhF4NGPAg+WTwCcq0L1Oj5CcgN/rIETDGK7t2rlcsM4Xi9+fp8Ok
         r62g==
X-Gm-Message-State: AOJu0Yzqgyy5Vmzh0gCjG0jzG+AdD5Vo68O2BocuXecfoIUCiLXy+NoL
        oOfi8lAgcFPTMwJrR4VQvZc=
X-Google-Smtp-Source: AGHT+IHGxs5mKwV0SIfJTy/1PmcUSW12rF0lShgSZsg2OVE3kvZusMC/81y+OW2KnKIPoi+leXoxBg==
X-Received: by 2002:a05:6a21:78aa:b0:141:69d:8041 with SMTP id bf42-20020a056a2178aa00b00141069d8041mr3176731pzc.48.1697826826732;
        Fri, 20 Oct 2023 11:33:46 -0700 (PDT)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id z14-20020aa7990e000000b006b4ac8885b4sm1911345pff.14.2023.10.20.11.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 11:33:46 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 4/5] mm/khugepaged: Convert alloc_charge_hpage() to use folios
Date:   Fri, 20 Oct 2023 11:33:30 -0700
Message-Id: <20231020183331.10770-5-vishal.moola@gmail.com>
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

Also remove count_memcg_page_event now that its last caller no longer uses
it and reword hpage_collapse_alloc_page() to hpage_collapse_alloc_folio().

This removes 1 call to compound_head() and helps convert khugepaged to
use folios throughout.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/memcontrol.h | 14 --------------
 mm/khugepaged.c            | 17 ++++++++++-------
 2 files changed, 10 insertions(+), 21 deletions(-)

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
index 9efd8ff68f06..6a7184cd291b 100644
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
@@ -1064,17 +1064,20 @@ static int alloc_charge_hpage(struct page **hpage, struct mm_struct *mm,
 	int node = hpage_collapse_find_target_node(cc);
 	struct folio *folio;
 
-	if (!hpage_collapse_alloc_page(hpage, gfp, node, &cc->alloc_nmask))
+	if (!hpage_collapse_alloc_folio(&folio, gfp, node, &cc->alloc_nmask)) {
+		*hpage = NULL;
 		return SCAN_ALLOC_HUGE_PAGE_FAIL;
+	}
 
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

