Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E59751759
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbjGMEVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbjGMEVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:21:23 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0200D26B9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:14 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68336d06620so307344b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689222074; x=1691814074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5CtvWZNM/arT1DeaLF8JN33bJjE1wRpWQ+2TM1opec=;
        b=i+W/NFohhvOCvKpcJMP9qgQqqgnP2EXS+qk6DRkcwUUbYvBlyO+0QzIrnCeCsGQzeG
         cYvSyZ09QP9qbQQXIlMXW8GJC9lCe0pdff6yWizEWhJGTSkLi4FfqcLNSlrIhbSp8wXZ
         h0fGuGyJO0H/0xTNTKH5YJCZnp3LI+99cDo9UlXjpTtxpQq0Q7rVV340Iv1F+/Q8nHSh
         aOTaBulsJzrhGj0kdl84YslsnY5LBVi0yVEhoS5Yq9IlgP8hnE79x8MaMNWqPTBDzDR3
         70+Pn244J5aXK8AMhsA4BKwrtQ+ItypDMjw2JTBzWvaf7nbZi/QZhOpx9etOSHV+dYxI
         Tr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689222074; x=1691814074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5CtvWZNM/arT1DeaLF8JN33bJjE1wRpWQ+2TM1opec=;
        b=VmrPwYjimUPz4NZYcbbX1V14pDoNxPd7Hh+JCorHUKOIe2bJagyac/CJlfCs5sMAOq
         65mtoxP9xrM7jNbMDg+kcPg+bbs1JlYacFYhhZ7Id2D6wzwYSvTHNqqJ08t91eWxqq7q
         40DdiqUgOULJaBDjK9UTdLsPw31URMqjGqqzrbhDioJYKbfVaoeIPRY1mDo8XTYY0B9P
         MKhwosEIxdQzmdSL0LsXaxdBSdWUItX39WrtaUSQqSqSnatBk/UGBVlI+4HaKnUiOSh8
         XIWU9kbH3fhYlQJTEdexpvOh9B2YdDfiw5LBD3VAgk3Z6WA9HoQvlYrrQ1MffZczN8pM
         3faA==
X-Gm-Message-State: ABy/qLZMOZGfW4RlAt1uuTxMw9PnyFD3ttRwaXPjV2OFXDt5wHzyx+zu
        UZSBNUkguaH3lSXaM+mkDcY=
X-Google-Smtp-Source: APBJJlHjxNeh9XNM9Xg49rVHdiHhgRhHwEZjBVTmC7d2ywHYqshe0HtbWG6bkIYM6hqzf+06oaFONQ==
X-Received: by 2002:a05:6a00:851:b0:668:9fb6:b311 with SMTP id q17-20020a056a00085100b006689fb6b311mr723443pfk.32.1689222074040;
        Wed, 12 Jul 2023 21:21:14 -0700 (PDT)
Received: from fedora.. ([1.245.179.104])
        by smtp.gmail.com with ESMTPSA id u18-20020aa78392000000b006827c26f147sm4346601pfm.138.2023.07.12.21.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 21:21:13 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [RFC PATCH v2 07/21] mm/zsmalloc: convert obj_to_location() and its users to use zsdesc
Date:   Thu, 13 Jul 2023 13:20:22 +0900
Message-ID: <20230713042037.980211-8-42.hyeyoo@gmail.com>
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

Convert obj_to_location() to take zsdesc and also convert its users
to use zsdesc.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/zsmalloc.c | 75 ++++++++++++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 4c0563fce3d0..be9762a49237 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -860,16 +860,16 @@ static __maybe_unused struct zsdesc *get_next_zsdesc(struct zsdesc *zsdesc)
 }
 
 /**
- * obj_to_location - get (<page>, <obj_idx>) from encoded object value
+ * obj_to_location - get (<zsdesc>, <obj_idx>) from encoded object value
  * @obj: the encoded object value
- * @page: page object resides in zspage
+ * @zsdesc: zsdesc object resides in zspage
  * @obj_idx: object index
  */
-static void obj_to_location(unsigned long obj, struct page **page,
+static void obj_to_location(unsigned long obj, struct zsdesc **zsdesc,
 				unsigned int *obj_idx)
 {
 	obj >>= OBJ_TAG_BITS;
-	*page = pfn_to_page(obj >> OBJ_INDEX_BITS);
+	*zsdesc = pfn_zsdesc(obj >> OBJ_INDEX_BITS);
 	*obj_idx = (obj & OBJ_INDEX_MASK);
 }
 
@@ -1298,13 +1298,13 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 			enum zs_mapmode mm)
 {
 	struct zspage *zspage;
-	struct page *page;
+	struct zsdesc *zsdesc;
 	unsigned long obj, off;
 	unsigned int obj_idx;
 
 	struct size_class *class;
 	struct mapping_area *area;
-	struct page *pages[2];
+	struct zsdesc *zsdescs[2];
 	void *ret;
 
 	/*
@@ -1317,8 +1317,8 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	/* It guarantees it can get zspage from handle safely */
 	spin_lock(&pool->lock);
 	obj = handle_to_obj(handle);
-	obj_to_location(obj, &page, &obj_idx);
-	zspage = get_zspage(page);
+	obj_to_location(obj, &zsdesc, &obj_idx);
+	zspage = get_zspage(zsdesc_page(zsdesc));
 
 	/*
 	 * migration cannot move any zpages in this zspage. Here, pool->lock
@@ -1337,17 +1337,17 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	area->vm_mm = mm;
 	if (off + class->size <= PAGE_SIZE) {
 		/* this object is contained entirely within a page */
-		area->vm_addr = kmap_atomic(page);
+		area->vm_addr = zsdesc_kmap_atomic(zsdesc);
 		ret = area->vm_addr + off;
 		goto out;
 	}
 
 	/* this object spans two pages */
-	pages[0] = page;
-	pages[1] = get_next_page(page);
-	BUG_ON(!pages[1]);
+	zsdescs[0] = zsdesc;
+	zsdescs[1] = get_next_zsdesc(zsdesc);
+	BUG_ON(!zsdescs[1]);
 
-	ret = __zs_map_object(area, (struct zsdesc **)pages, off, class->size);
+	ret = __zs_map_object(area, zsdescs, off, class->size);
 out:
 	if (likely(!ZsHugePage(zspage)))
 		ret += ZS_HANDLE_SIZE;
@@ -1359,7 +1359,7 @@ EXPORT_SYMBOL_GPL(zs_map_object);
 void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 {
 	struct zspage *zspage;
-	struct page *page;
+	struct zsdesc *zsdesc;
 	unsigned long obj, off;
 	unsigned int obj_idx;
 
@@ -1367,8 +1367,8 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 	struct mapping_area *area;
 
 	obj = handle_to_obj(handle);
-	obj_to_location(obj, &page, &obj_idx);
-	zspage = get_zspage(page);
+	obj_to_location(obj, &zsdesc, &obj_idx);
+	zspage = get_zspage(zsdesc_page(zsdesc));
 	class = zspage_class(pool, zspage);
 	off = offset_in_page(class->size * obj_idx);
 
@@ -1376,13 +1376,13 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 	if (off + class->size <= PAGE_SIZE)
 		kunmap_atomic(area->vm_addr);
 	else {
-		struct page *pages[2];
+		struct zsdesc *zsdescs[2];
 
-		pages[0] = page;
-		pages[1] = get_next_page(page);
-		BUG_ON(!pages[1]);
+		zsdescs[0] = zsdesc;
+		zsdescs[1] = get_next_zsdesc(zsdesc);
+		BUG_ON(!zsdescs[1]);
 
-		__zs_unmap_object(area, (struct zsdesc **)pages, off, class->size);
+		__zs_unmap_object(area, zsdescs, off, class->size);
 	}
 	local_unlock(&zs_map_area.lock);
 
@@ -1524,23 +1524,24 @@ static void obj_free(int class_size, unsigned long obj)
 {
 	struct link_free *link;
 	struct zspage *zspage;
-	struct page *f_page;
+	struct zsdesc *f_zsdesc;
 	unsigned long f_offset;
 	unsigned int f_objidx;
 	void *vaddr;
 
-	obj_to_location(obj, &f_page, &f_objidx);
+
+	obj_to_location(obj, &f_zsdesc, &f_objidx);
 	f_offset = offset_in_page(class_size * f_objidx);
-	zspage = get_zspage(f_page);
+	zspage = get_zspage(zsdesc_page(f_zsdesc));
 
-	vaddr = kmap_atomic(f_page);
+	vaddr = zsdesc_kmap_atomic(f_zsdesc);
 	link = (struct link_free *)(vaddr + f_offset);
 
 	/* Insert this object in containing zspage's freelist */
 	if (likely(!ZsHugePage(zspage)))
 		link->next = get_freeobj(zspage) << OBJ_TAG_BITS;
 	else
-		f_page->index = 0;
+		f_zsdesc->next = NULL;
 	set_freeobj(zspage, f_objidx);
 
 	kunmap_atomic(vaddr);
@@ -1583,7 +1584,7 @@ EXPORT_SYMBOL_GPL(zs_free);
 static void zs_object_copy(struct size_class *class, unsigned long dst,
 				unsigned long src)
 {
-	struct page *s_page, *d_page;
+	struct zsdesc *s_zsdesc, *d_zsdesc;
 	unsigned int s_objidx, d_objidx;
 	unsigned long s_off, d_off;
 	void *s_addr, *d_addr;
@@ -1592,8 +1593,8 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
 
 	s_size = d_size = class->size;
 
-	obj_to_location(src, &s_page, &s_objidx);
-	obj_to_location(dst, &d_page, &d_objidx);
+	obj_to_location(src, &s_zsdesc, &s_objidx);
+	obj_to_location(dst, &d_zsdesc, &d_objidx);
 
 	s_off = offset_in_page(class->size * s_objidx);
 	d_off = offset_in_page(class->size * d_objidx);
@@ -1604,8 +1605,8 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
 	if (d_off + class->size > PAGE_SIZE)
 		d_size = PAGE_SIZE - d_off;
 
-	s_addr = kmap_atomic(s_page);
-	d_addr = kmap_atomic(d_page);
+	s_addr = zsdesc_kmap_atomic(s_zsdesc);
+	d_addr = zsdesc_kmap_atomic(d_zsdesc);
 
 	while (1) {
 		size = min(s_size, d_size);
@@ -1630,17 +1631,17 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
 		if (s_off >= PAGE_SIZE) {
 			kunmap_atomic(d_addr);
 			kunmap_atomic(s_addr);
-			s_page = get_next_page(s_page);
-			s_addr = kmap_atomic(s_page);
-			d_addr = kmap_atomic(d_page);
+			s_zsdesc = get_next_zsdesc(s_zsdesc);
+			s_addr = zsdesc_kmap_atomic(s_zsdesc);
+			d_addr = zsdesc_kmap_atomic(d_zsdesc);
 			s_size = class->size - written;
 			s_off = 0;
 		}
 
 		if (d_off >= PAGE_SIZE) {
 			kunmap_atomic(d_addr);
-			d_page = get_next_page(d_page);
-			d_addr = kmap_atomic(d_page);
+			d_zsdesc = get_next_zsdesc(d_zsdesc);
+			d_addr = zsdesc_kmap_atomic(d_zsdesc);
 			d_size = class->size - written;
 			d_off = 0;
 		}
@@ -1904,7 +1905,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	struct zs_pool *pool;
 	struct size_class *class;
 	struct zspage *zspage;
-	struct page *dummy;
+	struct zsdesc *dummy;
 	void *s_addr, *d_addr, *addr;
 	unsigned int offset;
 	unsigned long handle;
-- 
2.41.0

