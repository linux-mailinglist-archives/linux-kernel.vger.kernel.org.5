Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98F7751762
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbjGMEWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbjGMEV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:21:56 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E860D2D43
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:35 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666e6541c98so297352b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689222094; x=1691814094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/by1wk+lV1+/9owJgKTgxMHTJboWG5CTUy71o+eRxGw=;
        b=ZwLsHKCMGtSfeOwsjPa0Ht517nH/Y0IoWXfzkMMAR8zYkK/vu4HdAF46+mxiWe/roe
         8EelYNkbLmFMwUTu8yqR6eqjQQEZELmkL0j5hPFs2j/dvv04mhUiCuF4GqCCxNQOvHJM
         15lB1o6EhTt8eXMOEcjpqczfk/daeZabPbwWkIh/3bBXdpM3MSLYmmp/G+F4XIechk3c
         igz9mrzUUga5BdUJq8NrakVnxKm5sOPFoBF1tD+fv/XrIHaelaFD8r2jMn2tpTxX8icj
         QP5KDdfRxq+vtvLqAVuOREzSHDU9V/n8VLkX1DfcInOK7adg45jBcWmgh22ac8mHhHZI
         qZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689222094; x=1691814094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/by1wk+lV1+/9owJgKTgxMHTJboWG5CTUy71o+eRxGw=;
        b=cGnIBf/V3EMmMEUg0Uns2XU8BQepT8bDT3oqXWVkHsNZcneie2RmUUXKagrdZlmVv0
         vjtw2OFtxgee0oSa9x3TwwsMj6f4dH3t3un7k8vm7atozK8yobAxzqWKeJczmX7D8uNN
         YP/MlF/VJkAZHKoyEwsfFo/9C80DrhNgWgdSk4AFkSzpl6DTSYAGxv+KHFxeT72n5rju
         ckOAms64QGDFUH8Usp21CAofOx6g6rZvHAWRZ9NMx+85J0nQZTtztlz2HrYqlxiKHLsI
         MyIFmbgiA/iT1DGHqtHdRs74e+iPGv1kJw/a5x/trh8Iurh7S0/IDD+HWSbuK/ipXddu
         tYsw==
X-Gm-Message-State: ABy/qLbm9I/UV1NOq6t96xjLFi1xrtJ+ceYHnTP2Y1zVcmAI2Dlk88PZ
        EmF5MYdmJaKREGpXBkuqxYU=
X-Google-Smtp-Source: APBJJlHQXaD+zIgZjEwNmV8ncpgx7dFNmq4wW4mHfF3i/lYKQg9jn3S5Evn9lGjxsR9uHDQqJZv4fA==
X-Received: by 2002:a05:6a00:14c5:b0:668:83b6:bfe8 with SMTP id w5-20020a056a0014c500b0066883b6bfe8mr621472pfu.9.1689222094431;
        Wed, 12 Jul 2023 21:21:34 -0700 (PDT)
Received: from fedora.. ([1.245.179.104])
        by smtp.gmail.com with ESMTPSA id u18-20020aa78392000000b006827c26f147sm4346601pfm.138.2023.07.12.21.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 21:21:33 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [RFC PATCH v2 14/21] mm/zsmalloc: convert zs_page_{isolate,migrate,putback} to use zsdesc
Date:   Thu, 13 Jul 2023 13:20:29 +0900
Message-ID: <20230713042037.980211-15-42.hyeyoo@gmail.com>
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

Convert the functions for movable operations of zsmalloc to use zsdesc.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/zsmalloc.c | 50 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 085f5c791a03..9e4ced14e1eb 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -399,6 +399,16 @@ static void reset_zsdesc(struct zsdesc *zsdesc)
 	page->index = 0;
 }
 
+static inline bool zsdesc_is_isolated(struct zsdesc *zsdesc)
+{
+	return PageIsolated(zsdesc_page(zsdesc));
+}
+
+struct zone *zsdesc_zone(struct zsdesc *zsdesc)
+{
+	return page_zone(zsdesc_page(zsdesc));
+}
+
 /* huge object: pages_per_zspage == 1 && maxobj_per_zspage == 1 */
 static void SetZsHugePage(struct zspage *zspage)
 {
@@ -1928,14 +1938,15 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 {
 	struct zspage *zspage;
+	struct zsdesc *zsdesc = page_zsdesc(page);
 
 	/*
 	 * Page is locked so zspage couldn't be destroyed. For detail, look at
 	 * lock_zspage in free_zspage.
 	 */
-	VM_BUG_ON_PAGE(PageIsolated(page), page);
+	VM_BUG_ON_PAGE(zsdesc_is_isolated(zsdesc), zsdesc_page(zsdesc));
 
-	zspage = get_zspage(page);
+	zspage = get_zspage(zsdesc_page(zsdesc));
 	migrate_write_lock(zspage);
 	inc_zspage_isolation(zspage);
 	migrate_write_unlock(zspage);
@@ -1950,6 +1961,8 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	struct size_class *class;
 	struct zspage *zspage;
 	struct zsdesc *dummy;
+	struct zsdesc *new_zsdesc = page_zsdesc(newpage);
+	struct zsdesc *zsdesc = page_zsdesc(page);
 	void *s_addr, *d_addr, *addr;
 	unsigned int offset;
 	unsigned long handle;
@@ -1964,10 +1977,10 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	if (mode == MIGRATE_SYNC_NO_COPY)
 		return -EINVAL;
 
-	VM_BUG_ON_PAGE(!PageIsolated(page), page);
+	VM_BUG_ON_PAGE(!zsdesc_is_isolated(zsdesc), zsdesc_page(zsdesc));
 
 	/* The page is locked, so this pointer must remain valid */
-	zspage = get_zspage(page);
+	zspage = get_zspage(zsdesc_page(zsdesc));
 	pool = zspage->pool;
 
 	/*
@@ -1980,30 +1993,30 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	/* the migrate_write_lock protects zpage access via zs_map_object */
 	migrate_write_lock(zspage);
 
-	offset = get_first_obj_offset(page);
-	s_addr = kmap_atomic(page);
+	offset = get_first_obj_offset(zsdesc_page(zsdesc));
+	s_addr = zsdesc_kmap_atomic(zsdesc);
 
 	/*
 	 * Here, any user cannot access all objects in the zspage so let's move.
 	 */
-	d_addr = kmap_atomic(newpage);
+	d_addr = zsdesc_kmap_atomic(new_zsdesc);
 	memcpy(d_addr, s_addr, PAGE_SIZE);
 	kunmap_atomic(d_addr);
 
 	for (addr = s_addr + offset; addr < s_addr + PAGE_SIZE;
 					addr += class->size) {
-		if (obj_allocated(page_zsdesc(page), addr, &handle)) {
+		if (obj_allocated(zsdesc, addr, &handle)) {
 
 			old_obj = handle_to_obj(handle);
 			obj_to_location(old_obj, &dummy, &obj_idx);
-			new_obj = (unsigned long)location_to_obj(newpage,
+			new_obj = (unsigned long)location_to_obj(zsdesc_page(new_zsdesc),
 								obj_idx);
 			record_obj(handle, new_obj);
 		}
 	}
 	kunmap_atomic(s_addr);
 
-	replace_sub_page(class, zspage, page_zsdesc(newpage), page_zsdesc(page));
+	replace_sub_page(class, zspage, new_zsdesc, zsdesc);
 	/*
 	 * Since we complete the data copy and set up new zspage structure,
 	 * it's okay to release the pool's lock.
@@ -2012,14 +2025,14 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	dec_zspage_isolation(zspage);
 	migrate_write_unlock(zspage);
 
-	get_page(newpage);
-	if (page_zone(newpage) != page_zone(page)) {
-		dec_zone_page_state(page, NR_ZSPAGES);
-		inc_zone_page_state(newpage, NR_ZSPAGES);
+	zsdesc_get(new_zsdesc);
+	if (zsdesc_zone(new_zsdesc) != zsdesc_zone(zsdesc)) {
+		zsdesc_dec_zone_page_state(zsdesc);
+		zsdesc_inc_zone_page_state(new_zsdesc);
 	}
 
-	reset_zsdesc(page_zsdesc(page));
-	put_page(page);
+	reset_zsdesc(zsdesc);
+	zsdesc_put(zsdesc);
 
 	return MIGRATEPAGE_SUCCESS;
 }
@@ -2027,10 +2040,11 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 static void zs_page_putback(struct page *page)
 {
 	struct zspage *zspage;
+	struct zsdesc *zsdesc = page_zsdesc(page);
 
-	VM_BUG_ON_PAGE(!PageIsolated(page), page);
+	VM_BUG_ON_PAGE(!zsdesc_is_isolated(zsdesc), zsdesc_page(zsdesc));
 
-	zspage = get_zspage(page);
+	zspage = get_zspage(zsdesc_page(zsdesc));
 	migrate_write_lock(zspage);
 	dec_zspage_isolation(zspage);
 	migrate_write_unlock(zspage);
-- 
2.41.0

