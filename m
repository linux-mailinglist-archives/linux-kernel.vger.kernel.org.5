Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA0B751766
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbjGMEX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbjGMEW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:22:57 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E892709
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:55 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a425ef874dso298220b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689222106; x=1691814106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXM4L6ATnQ4xrg8tTfTjz4QRtMoQblLyPPhiA9zDD8E=;
        b=M64LK05+hua14coRfSAzgdWbmeWOfjeIcnMe8zHhEEq6QZfU+wicBwfhOlbx7f712p
         MCCVAAWPzNo3Qc49xeRW05dxjBSHHqRcqunGvYK0pYS6L+gPbY9eAfRpW+PEVWOnMgwm
         mRuybE0qcPvJWT52YiqJU/z4k9UphElNmJ66v6/+Wy2VTIZ/VE+ED1zF44gtWuANKLX7
         OL+nN4m5Z7XRCwbQQdqcMQ3ph1yGrn7MUeyQDVo0XCnzFnLf/zSV9e5SxA0vBgl5vXB/
         j/SOEuJk4oFEFhmM39sbUj2Sk4Ip6WU0A4Fa6blAp1QbYef/HX06f5QtVIbQ9YsoBg8G
         /gVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689222106; x=1691814106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXM4L6ATnQ4xrg8tTfTjz4QRtMoQblLyPPhiA9zDD8E=;
        b=Y9nT3K9xqSRKLQ++PdcYLtUsSz0LW7bllz6KQMTQRa/JVqJuHSFatGAIzi8XpjXYvV
         MKoWLqKiCJ8T+Rhd1gfb3oJrUUA0GdubOQR1F+gcaZnJVyrHGv9s/t7E1U2EjIIRfPAv
         r5PY2TshHKBEZz77qlomTO9nHS1ctyBsxv2BXNfX4TPcx3ALQhN23EcG+kWYbmA0puXQ
         ZFhzEhXPAhFuds2eXM2lNBF5pk5kSWuudBqLw4R+wOZ6lYfN/k72hGA8qDs8gehZkgsT
         60ug57+lgRWyWtxPB8McAdftrfJV2kJvGfKI4H5NYE8eVvwGrsDTrvYwTFDJ09+gtQf7
         Wifw==
X-Gm-Message-State: ABy/qLb7y8R9OuVqO4BKBnAPhbH4xGLyes2vafnC1Z+R4EpUSTySeTfa
        vLSeNA+f4vN7AIIq/EMV/VI=
X-Google-Smtp-Source: APBJJlG+h4Yqni22gjogscFoMXfmzoSDOy/WAo/NSF0NWCEAbsC70HXke8WrSb7H557DGFEUsgq9Pg==
X-Received: by 2002:a05:6808:1246:b0:3a4:17b0:2b12 with SMTP id o6-20020a056808124600b003a417b02b12mr628547oiv.11.1689222106137;
        Wed, 12 Jul 2023 21:21:46 -0700 (PDT)
Received: from fedora.. ([1.245.179.104])
        by smtp.gmail.com with ESMTPSA id u18-20020aa78392000000b006827c26f147sm4346601pfm.138.2023.07.12.21.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 21:21:45 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [RFC PATCH v2 18/21] mm/zsmalloc: convert get_zspage() to take zsdesc
Date:   Thu, 13 Jul 2023 13:20:33 +0900
Message-ID: <20230713042037.980211-19-42.hyeyoo@gmail.com>
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

Now that all users except get_next_page() (which will be removed in
later patch) use zsdesc, convert get_zspage() to take zsdesc instead
of page.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/zsmalloc.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index db43a5d05233..6cb216b8564a 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -899,9 +899,9 @@ static int fix_fullness_group(struct size_class *class, struct zspage *zspage)
 	return newfg;
 }
 
-static struct zspage *get_zspage(struct page *page)
+static struct zspage *get_zspage(struct zsdesc *zsdesc)
 {
-	struct zspage *zspage = (struct zspage *)page_private(page);
+	struct zspage *zspage = zsdesc->zspage;
 
 	BUG_ON(zspage->magic != ZSPAGE_MAGIC);
 	return zspage;
@@ -909,7 +909,7 @@ static struct zspage *get_zspage(struct page *page)
 
 static __maybe_unused struct page *get_next_page(struct page *page)
 {
-	struct zspage *zspage = get_zspage(page);
+	struct zspage *zspage = get_zspage(page_zsdesc(page));
 
 	if (unlikely(ZsHugePage(zspage)))
 		return NULL;
@@ -919,7 +919,7 @@ static __maybe_unused struct page *get_next_page(struct page *page)
 
 static __maybe_unused struct zsdesc *get_next_zsdesc(struct zsdesc *zsdesc)
 {
-	struct zspage *zspage = get_zspage(zsdesc_page(zsdesc));
+	struct zspage *zspage = get_zspage(zsdesc);
 
 	if (unlikely(ZsHugePage(zspage)))
 		return NULL;
@@ -972,7 +972,7 @@ static inline bool obj_allocated(struct zsdesc *zsdesc, void *obj,
 				 unsigned long *phandle)
 {
 	unsigned long handle;
-	struct zspage *zspage = get_zspage(zsdesc_page(zsdesc));
+	struct zspage *zspage = get_zspage(zsdesc);
 
 	if (unlikely(ZsHugePage(zspage))) {
 		VM_BUG_ON_PAGE(!is_first_zsdesc(zsdesc), zsdesc_page(zsdesc));
@@ -1377,7 +1377,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	spin_lock(&pool->lock);
 	obj = handle_to_obj(handle);
 	obj_to_location(obj, &zsdesc, &obj_idx);
-	zspage = get_zspage(zsdesc_page(zsdesc));
+	zspage = get_zspage(zsdesc);
 
 	/*
 	 * migration cannot move any zpages in this zspage. Here, pool->lock
@@ -1427,7 +1427,7 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 
 	obj = handle_to_obj(handle);
 	obj_to_location(obj, &zsdesc, &obj_idx);
-	zspage = get_zspage(zsdesc_page(zsdesc));
+	zspage = get_zspage(zsdesc);
 	class = zspage_class(pool, zspage);
 	off = offset_in_page(class->size * obj_idx);
 
@@ -1591,7 +1591,7 @@ static void obj_free(int class_size, unsigned long obj)
 
 	obj_to_location(obj, &f_zsdesc, &f_objidx);
 	f_offset = offset_in_page(class_size * f_objidx);
-	zspage = get_zspage(zsdesc_page(f_zsdesc));
+	zspage = get_zspage(f_zsdesc);
 
 	vaddr = zsdesc_kmap_atomic(f_zsdesc);
 	link = (struct link_free *)(vaddr + f_offset);
@@ -1625,7 +1625,7 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	spin_lock(&pool->lock);
 	obj = handle_to_obj(handle);
 	obj_to_zsdesc(obj, &f_zsdesc);
-	zspage = get_zspage(zsdesc_page(f_zsdesc));
+	zspage = get_zspage(f_zsdesc);
 	class = zspage_class(pool, zspage);
 
 	class_stat_dec(class, ZS_OBJS_INUSE, 1);
@@ -1951,7 +1951,7 @@ static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 	 */
 	VM_BUG_ON_PAGE(zsdesc_is_isolated(zsdesc), zsdesc_page(zsdesc));
 
-	zspage = get_zspage(zsdesc_page(zsdesc));
+	zspage = get_zspage(zsdesc);
 	migrate_write_lock(zspage);
 	inc_zspage_isolation(zspage);
 	migrate_write_unlock(zspage);
@@ -1985,7 +1985,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	VM_BUG_ON_PAGE(!zsdesc_is_isolated(zsdesc), zsdesc_page(zsdesc));
 
 	/* The page is locked, so this pointer must remain valid */
-	zspage = get_zspage(zsdesc_page(zsdesc));
+	zspage = get_zspage(zsdesc);
 	pool = zspage->pool;
 
 	/*
@@ -2049,7 +2049,7 @@ static void zs_page_putback(struct page *page)
 
 	VM_BUG_ON_PAGE(!zsdesc_is_isolated(zsdesc), zsdesc_page(zsdesc));
 
-	zspage = get_zspage(zsdesc_page(zsdesc));
+	zspage = get_zspage(zsdesc);
 	migrate_write_lock(zspage);
 	dec_zspage_isolation(zspage);
 	migrate_write_unlock(zspage);
-- 
2.41.0

