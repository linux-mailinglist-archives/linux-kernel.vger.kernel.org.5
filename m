Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0253B751769
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbjGMEXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbjGMEXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:23:17 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414BE268A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:22:13 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a1ebb85f99so321655b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689222115; x=1691814115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MetfO9mrNUCPlQ/wlpQAjWG2Omnt/Jwf7TCm8Zb+zM=;
        b=jiG6Jx8vCgsZyWAXe3kUGl5Upako6/0pIT2NiUYxygtCnwxrcoeYsPV3i5Gcl5cn2t
         Bzlf8SSWF8qrdn0f6obQVsRY5ZP7XeiJBPkpH3tvqKSyZPX+hgjuIywu9/nb0UHxSlrM
         +t5R51ZUMPBPupiQEifFHmBUsv7jqUbvokHGWc8YSWLZ/w8v6wzdSugebG2dLgAC2fTR
         gztdBFEUkKIoFlpMBPGExShJppDw7+m4z8MBK9yJKnpWGCzRKA2L+50cEp801RXqbY7O
         ze9c6SdR/EdhnVbqyTexU4Xl8Iqju0TNwJhDPsExbp0wBwSXAFj9+GgZHHn/67yFKj0Q
         YajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689222115; x=1691814115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9MetfO9mrNUCPlQ/wlpQAjWG2Omnt/Jwf7TCm8Zb+zM=;
        b=W7RtGG3w3O/Ah2mRF+H3U033JR5yjAsjeev1gWD4ZOelxqb9s7PJx2O0I3LIsStzYX
         WijG6KkjKsZ9notZwk2uez5sBWTHTkp+eGaJAriYXI5eEyzlTCuANM7x19ZYbDUB86qx
         1lA9RnBesoJl+mkoBLcva/7SaDg6joFYz1vZGvxCTJo/8nDEOy5b5EDWx5FmpuFXnUJ2
         GiIH1YgXpXT/PFwLLCB9j0SKOmHt/zZA0249qbFuiCYn+Up1UfTfS9EYqYX6YvfLJ0J0
         WzXdHQ33TO0h+ucIEU/0z5EKqVoIoPCqw/UIiyU3B+DTCNBL8RxPrZ/jlZaDAZH2g4Tu
         qD9Q==
X-Gm-Message-State: ABy/qLYfb0x59HAs/0BNcNMWnbivTAeUXDKcU9OIpou7DhzaQifqmAXX
        U3ykvSkzfVsUlUK7MHsmb9s=
X-Google-Smtp-Source: APBJJlHRPVrgCMfgSTQjztNxsY5F6JRQM00POfBtGVR98CC+mRl/WjJQjXMYh+PyKxa4hTDWDnelOQ==
X-Received: by 2002:a05:6808:118c:b0:3a3:7248:252a with SMTP id j12-20020a056808118c00b003a37248252amr904978oil.0.1689222114767;
        Wed, 12 Jul 2023 21:21:54 -0700 (PDT)
Received: from fedora.. ([1.245.179.104])
        by smtp.gmail.com with ESMTPSA id u18-20020aa78392000000b006827c26f147sm4346601pfm.138.2023.07.12.21.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 21:21:54 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [RFC PATCH v2 21/21] mm/zsmalloc: convert {get,set}_first_obj_offset() to use zsdesc
Date:   Thu, 13 Jul 2023 13:20:36 +0900
Message-ID: <20230713042037.980211-22-42.hyeyoo@gmail.com>
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

Now that all users of {get,set}_first_obj_offset() are converted
to use zsdesc, convert them to use zsdesc.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/zsmalloc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 3933c023c3c9..7ac5d63e10a5 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -606,14 +606,14 @@ static struct zsdesc *get_first_zsdesc(struct zspage *zspage)
 	return first_zsdesc;
 }
 
-static inline unsigned int get_first_obj_offset(struct page *page)
+static inline unsigned int get_first_obj_offset(struct zsdesc *zsdesc)
 {
-	return page->page_type;
+	return zsdesc->first_obj_offset;
 }
 
-static inline void set_first_obj_offset(struct page *page, unsigned int offset)
+static inline void set_first_obj_offset(struct zsdesc *zsdesc, unsigned int offset)
 {
-	page->page_type = offset;
+	zsdesc->first_obj_offset = offset;
 }
 
 static inline unsigned int get_freeobj(struct zspage *zspage)
@@ -1049,7 +1049,7 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 		struct link_free *link;
 		void *vaddr;
 
-		set_first_obj_offset(zsdesc_page(zsdesc), off);
+		set_first_obj_offset(zsdesc, off);
 
 		vaddr = zsdesc_kmap_atomic(zsdesc);
 		link = (struct link_free *)vaddr + off / sizeof(*link);
@@ -1699,7 +1699,7 @@ static unsigned long find_alloced_obj(struct size_class *class,
 	unsigned long handle = 0;
 	void *addr = zsdesc_kmap_atomic(zsdesc);
 
-	offset = get_first_obj_offset(zsdesc_page(zsdesc));
+	offset = get_first_obj_offset(zsdesc);
 	offset += class->size * index;
 
 	while (offset < PAGE_SIZE) {
@@ -1910,8 +1910,8 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 	} while ((zsdesc = get_next_zsdesc(zsdesc)) != NULL);
 
 	create_page_chain(class, zspage, zsdescs);
-	first_obj_offset = get_first_obj_offset(zsdesc_page(old_zsdesc));
-	set_first_obj_offset(zsdesc_page(new_zsdesc), first_obj_offset);
+	first_obj_offset = get_first_obj_offset(old_zsdesc);
+	set_first_obj_offset(new_zsdesc, first_obj_offset);
 	if (unlikely(ZsHugePage(zspage)))
 		new_zsdesc->handle = old_zsdesc->handle;
 	zsdesc_set_movable(new_zsdesc);
@@ -1975,7 +1975,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	/* the migrate_write_lock protects zpage access via zs_map_object */
 	migrate_write_lock(zspage);
 
-	offset = get_first_obj_offset(zsdesc_page(zsdesc));
+	offset = get_first_obj_offset(zsdesc);
 	s_addr = zsdesc_kmap_atomic(zsdesc);
 
 	/*
-- 
2.41.0

