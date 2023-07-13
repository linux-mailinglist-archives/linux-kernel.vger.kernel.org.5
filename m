Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB36675175B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbjGMEWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjGMEVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:21:30 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6519212D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:20 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666eb03457cso177677b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689222080; x=1691814080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LP5xQ6efjwHS47Oxl1IdTrKCp1PjMTJw03NOJIq6Awg=;
        b=lf7AZa8eID+bpbDGYm/7QEvzwEHh6v4zg3kNCWj8c5QyXrfMVbJVNMyjrKhdjmIr6t
         n+bP+RtxPOH6barvlyqo1EADq8+88sVBaIXeOtY8d4CbOu4dvt5MEfQrfWMNcwou+DGu
         BXBA5OPPHaMvCSejIv4nOX2PVYomkk7yshU0mCGwH8csmbEDebanQEvkyDqaTeKh7PmL
         WB1wJ275RzFYYecOIfu9U+tkcobqAn9P1hmhpJT+SsJQ0oOKgsbBJwoL5Ar6zPV5RJYh
         9iaCciIY2AOdQZIpIVAH1JrqhDPoAjY80UBAmlXDDID8R4efwMaF9T5xCpseUc46O13L
         rxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689222080; x=1691814080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LP5xQ6efjwHS47Oxl1IdTrKCp1PjMTJw03NOJIq6Awg=;
        b=F5S1T2HZd2DoE5kFYgYJjnis0BR6yHdUt///BtNYKOi1qKxBBj/fj4nbZGu6c9Amsi
         dhYa6UemmtElfDLK4jungKMxkaAVoA7qdv16biXoKNXy0sEBki5mM93oR11nowjWUKbG
         RLHkx8r16tIc3WBPjZpYcRlGJfY5qndmFTrX1Sp8LO/jymJeucA1HaSgb9E9IxfrL/wu
         kyKr0oPnGTdug0bRwT/17YxcrHAIlG/yhF+wA2Qse0YzPohh2nLgCO1TF9d1SBZshM5J
         4CLcmnCm79wY39WBe59em1PPZ4ioAJkvJ3CeVz5walnvWKlF5GtIcDcgKmDeSawIx2jJ
         XkNQ==
X-Gm-Message-State: ABy/qLa8D+6YlHXFb/DWwa40/y4bAwQecBhbUEYFe1LSTFsgl+klvQsF
        pbRO2mJEhGjZeYSA3Xq6eDI=
X-Google-Smtp-Source: APBJJlE3EDMrVhGu2+w99ghcjkXTfEgbRvc6vMguhTPtHAU43UkedDKKOy9zY8oR+2dKf2q4n7r4QQ==
X-Received: by 2002:a05:6a00:2401:b0:666:ba76:eef5 with SMTP id z1-20020a056a00240100b00666ba76eef5mr364274pfh.8.1689222079876;
        Wed, 12 Jul 2023 21:21:19 -0700 (PDT)
Received: from fedora.. ([1.245.179.104])
        by smtp.gmail.com with ESMTPSA id u18-20020aa78392000000b006827c26f147sm4346601pfm.138.2023.07.12.21.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 21:21:19 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [RFC PATCH v2 09/21] mm/zsmalloc: convert create_page_chain() and its user to use zsdesc
Date:   Thu, 13 Jul 2023 13:20:24 +0900
Message-ID: <20230713042037.980211-10-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713042037.980211-1-42.hyeyoo@gmail.com>
References: <20230713042037.980211-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a few helper functions for conversion.
Convert create_page_chain() and its user replace_sub_page() to use zsdesc.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/zsmalloc.c | 120 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 81 insertions(+), 39 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 06227da86afc..48bfdbbe3b1e 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -346,6 +346,48 @@ static inline void *zsdesc_kmap_atomic(struct zsdesc *zsdesc)
 	return kmap_atomic(zsdesc_page(zsdesc));
 }
 
+static inline void zsdesc_set_zspage(struct zsdesc *zsdesc,
+				     struct zspage *zspage)
+{
+	zsdesc->zspage = zspage;
+}
+
+static inline void zsdesc_set_first(struct zsdesc *zsdesc)
+{
+	SetPagePrivate(zsdesc_page(zsdesc));
+}
+
+static const struct movable_operations zsmalloc_mops;
+
+static inline void zsdesc_set_movable(struct zsdesc *zsdesc)
+{
+	__SetPageMovable(zsdesc_page(zsdesc), &zsmalloc_mops);
+}
+
+static inline void zsdesc_inc_zone_page_state(struct zsdesc *zsdesc)
+{
+	inc_zone_page_state(zsdesc_page(zsdesc), NR_ZSPAGES);
+}
+
+static inline void zsdesc_dec_zone_page_state(struct zsdesc *zsdesc)
+{
+	dec_zone_page_state(zsdesc_page(zsdesc), NR_ZSPAGES);
+}
+
+static inline struct zsdesc *alloc_zsdesc(gfp_t gfp)
+{
+	struct page *page = alloc_page(gfp);
+
+	return page_zsdesc(page);
+}
+
+static inline void free_zsdesc(struct zsdesc *zsdesc)
+{
+	struct page *page = zsdesc_page(zsdesc);
+
+	__free_page(page);
+}
+
 /* huge object: pages_per_zspage == 1 && maxobj_per_zspage == 1 */
 static void SetZsHugePage(struct zspage *zspage)
 {
@@ -1047,35 +1089,35 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 }
 
 static void create_page_chain(struct size_class *class, struct zspage *zspage,
-				struct page *pages[])
+				struct zsdesc *zsdescs[])
 {
 	int i;
-	struct page *page;
-	struct page *prev_page = NULL;
-	int nr_pages = class->pages_per_zspage;
+	struct zsdesc *zsdesc;
+	struct zsdesc *prev_zsdesc = NULL;
+	int nr_zsdescs = class->pages_per_zspage;
 
 	/*
 	 * Allocate individual pages and link them together as:
-	 * 1. all pages are linked together using page->index
-	 * 2. each sub-page point to zspage using page->private
+	 * 1. all pages are linked together using zsdesc->next
+	 * 2. each sub-page point to zspage using zsdesc->zspage
 	 *
-	 * we set PG_private to identify the first page (i.e. no other sub-page
+	 * we set PG_private to identify the first zsdesc (i.e. no other zsdesc
 	 * has this flag set).
 	 */
-	for (i = 0; i < nr_pages; i++) {
-		page = pages[i];
-		set_page_private(page, (unsigned long)zspage);
-		page->index = 0;
+	for (i = 0; i < nr_zsdescs; i++) {
+		zsdesc = zsdescs[i];
+		zsdesc_set_zspage(zsdesc, zspage);
+		zsdesc->next = NULL;
 		if (i == 0) {
-			zspage->first_zsdesc = page_zsdesc(page);
-			SetPagePrivate(page);
+			zspage->first_zsdesc = zsdesc;
+			zsdesc_set_first(zsdesc);
 			if (unlikely(class->objs_per_zspage == 1 &&
 					class->pages_per_zspage == 1))
 				SetZsHugePage(zspage);
 		} else {
-			prev_page->index = (unsigned long)page;
+			prev_zsdesc->next = zsdesc;
 		}
-		prev_page = page;
+		prev_zsdesc = zsdesc;
 	}
 }
 
@@ -1087,7 +1129,7 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 					gfp_t gfp)
 {
 	int i;
-	struct page *pages[ZS_MAX_PAGES_PER_ZSPAGE];
+	struct zsdesc *zsdescs[ZS_MAX_PAGES_PER_ZSPAGE];
 	struct zspage *zspage = cache_alloc_zspage(pool, gfp);
 
 	if (!zspage)
@@ -1097,23 +1139,23 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 	migrate_lock_init(zspage);
 
 	for (i = 0; i < class->pages_per_zspage; i++) {
-		struct page *page;
+		struct zsdesc *zsdesc;
 
-		page = alloc_page(gfp);
-		if (!page) {
+		zsdesc = alloc_zsdesc(gfp);
+		if (!zsdesc) {
 			while (--i >= 0) {
-				dec_zone_page_state(pages[i], NR_ZSPAGES);
-				__free_page(pages[i]);
+				zsdesc_dec_zone_page_state(zsdescs[i]);
+				free_zsdesc(zsdescs[i]);
 			}
 			cache_free_zspage(pool, zspage);
 			return NULL;
 		}
 
-		inc_zone_page_state(page, NR_ZSPAGES);
-		pages[i] = page;
+		zsdesc_inc_zone_page_state(zsdesc);
+		zsdescs[i] = zsdesc;
 	}
 
-	create_page_chain(class, zspage, pages);
+	create_page_chain(class, zspage, zsdescs);
 	init_zspage(class, zspage);
 	zspage->pool = pool;
 
@@ -1856,29 +1898,29 @@ static void dec_zspage_isolation(struct zspage *zspage)
 	zspage->isolated--;
 }
 
-static const struct movable_operations zsmalloc_mops;
-
 static void replace_sub_page(struct size_class *class, struct zspage *zspage,
-				struct page *newpage, struct page *oldpage)
+				struct zsdesc *new_zsdesc, struct zsdesc *old_zsdesc)
 {
-	struct page *page;
-	struct page *pages[ZS_MAX_PAGES_PER_ZSPAGE] = {NULL, };
+	struct zsdesc *zsdesc;
+	struct zsdesc *zsdescs[ZS_MAX_PAGES_PER_ZSPAGE] = {NULL, };
+	unsigned int first_obj_offset;
 	int idx = 0;
 
-	page = get_first_page(zspage);
+	zsdesc = get_first_zsdesc(zspage);
 	do {
-		if (page == oldpage)
-			pages[idx] = newpage;
+		if (zsdesc == old_zsdesc)
+			zsdescs[idx] = new_zsdesc;
 		else
-			pages[idx] = page;
+			zsdescs[idx] = zsdesc;
 		idx++;
-	} while ((page = get_next_page(page)) != NULL);
+	} while ((zsdesc = get_next_zsdesc(zsdesc)) != NULL);
 
-	create_page_chain(class, zspage, pages);
-	set_first_obj_offset(newpage, get_first_obj_offset(oldpage));
+	create_page_chain(class, zspage, zsdescs);
+	first_obj_offset = get_first_obj_offset(zsdesc_page(old_zsdesc));
+	set_first_obj_offset(zsdesc_page(new_zsdesc), first_obj_offset);
 	if (unlikely(ZsHugePage(zspage)))
-		newpage->index = oldpage->index;
-	__SetPageMovable(newpage, &zsmalloc_mops);
+		new_zsdesc->handle = old_zsdesc->handle;
+	zsdesc_set_movable(new_zsdesc);
 }
 
 static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
@@ -1959,7 +2001,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	}
 	kunmap_atomic(s_addr);
 
-	replace_sub_page(class, zspage, newpage, page);
+	replace_sub_page(class, zspage, page_zsdesc(newpage), page_zsdesc(page));
 	/*
 	 * Since we complete the data copy and set up new zspage structure,
 	 * it's okay to release the pool's lock.
-- 
2.41.0

