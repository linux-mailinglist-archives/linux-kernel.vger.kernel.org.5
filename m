Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4517CB3B3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjJPUHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbjJPUHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:07:03 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2172C103
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:07:00 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so3676691a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697486819; x=1698091619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwAjlmpq6KKWWorM+tiqR60ij8VY2bcU8cxZ+UqJifo=;
        b=DIDrAM59k6y4oW+uDak6ZadlF9PGYiZzi1Pk22E1PYPAhi9/VcS6qJa3aW9tRdPHbc
         DEGgOfxXfJIWEWUtYF3hfigUYpsL/MVoHQm4rIf/VihJ1iuvkk668hKTIL60dwj4nhDl
         B6fD+Sn2NKaXZpgJ7YPviLXgWQ4vQ3QLbyPnZgvVJsH2zbl6e18Hm1fv/2Q/UjKGLcmf
         KlN0aovvejO4cZy7smeAV/3brDh1ts2MYsRl4V8mRPI5oP0zYpC0y7eNfwhk/l5/GpZg
         pgA9Lyx2ZYCaFCQytF6bLj6WCiU1XNvlBbHT45/9ylGZ05Ha7JJBBH7HXlmLWTY8TdML
         1dMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697486819; x=1698091619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwAjlmpq6KKWWorM+tiqR60ij8VY2bcU8cxZ+UqJifo=;
        b=DnWIHCCJKPyYRTVBqTtqWgL6PeDZyGAPnL3MTVpCjY86ijvcGuhgmncVBE8p/FkSH0
         LNcikHrROZHQYeDR1OdpmxVQFRodZPT2rU5e4XeXfEiESJIonlUDb20i4k/I6uuAM5k0
         M5EmN4IFEY1n9yWCNwt7Gy1PMEastmhrLxME8+YTX8YHCvYAy2c0h2dCg3qenNkNplJ9
         1ft4MtcjdjvGbfyrrUfakdWZZude1FHK7jySc2/66lThSGGvxsdUMDWlGroWs3mg14ne
         /2q/I1TLpTPnGU3wv+fZM6yVQ5DhcSbp645wPsdalzc90RO7ap8o6v7c9+XiTCp7U60S
         ee5A==
X-Gm-Message-State: AOJu0Yy3wmT3zGUFJ/SzEYGgCNnSNGnem1cXLeJgH0CwXcShIbmDjfKm
        wQN2vQ8pGvTAIGppHwFKdvaoF4QKw2U=
X-Google-Smtp-Source: AGHT+IG2u33OIftxV+vG+uCRE0PArlnIRhFf/JTq4llkJ/7L4qH2959ZYqq3PoHzeqWuyBIqSdin2A==
X-Received: by 2002:a17:90b:245:b0:27d:4259:b7ef with SMTP id fz5-20020a17090b024500b0027d4259b7efmr190516pjb.23.1697486819203;
        Mon, 16 Oct 2023 13:06:59 -0700 (PDT)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id t16-20020a17090b019000b002772faee740sm5162367pjs.5.2023.10.16.13.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 13:06:58 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shy828301@gmail.com,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 4/5] mm/khugepaged: Convert alloc_charge_hpage() to use folios
Date:   Mon, 16 Oct 2023 13:05:09 -0700
Message-Id: <20231016200510.7387-5-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231016200510.7387-1-vishal.moola@gmail.com>
References: <20231016200510.7387-1-vishal.moola@gmail.com>
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

Also convert hpage_collapse_alloc_page() to
hpage_collapse_alloc_folio().

This removes 1 call to compound_head() and helps convert khugepaged to
use folios throughout.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/khugepaged.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index fa21a53ce0c0..70bba8ddea13 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -886,16 +886,16 @@ static int hpage_collapse_find_target_node(struct collapse_control *cc)
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
@@ -1062,15 +1062,16 @@ static int alloc_charge_hpage(struct page **hpage, struct mm_struct *mm,
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
+
+	*hpage = folio_page(folio, 0);
 	count_memcg_page_event(*hpage, THP_COLLAPSE_ALLOC);
 
 	return SCAN_SUCCEED;
-- 
2.40.1

