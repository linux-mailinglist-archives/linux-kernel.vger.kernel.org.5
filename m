Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C20B751752
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbjGMEVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjGMEU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:20:58 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFAD19BE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:20:57 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a337ddff16so286301b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689222056; x=1691814056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDYdNA9lDVtoD8B2uXnOlmCKBsx14i431NGid1vWIJk=;
        b=OmNB2v7cPzjVbjCrPHesJGkG5OJ1x1rIpPnLFGkHy+8vUnmdOeiKvfhZnn6H9NJFu7
         tjvfzbEKpbhx4EHl53IwQ9rpc1UZNnL1xzNCh5xu44eiS8/Xq+kyQUF0+xh6PU2Zg7Ej
         KwQhjbRoGatW4uiCRRA6RjICwcrolxwLBciT9JtjbWh/Z8HecM2mRJKFjspy2Q7x0oES
         PpLTX6U/XS/x2THUtSOszV9RZo0XzKKz+KoLi/FH7+fIwzNjLslWgoiBStNeNMKUYQ1U
         od21C3PGMosTsyePKwlzjYtOXcv5nFXdISwYjt7DfWwxEnq31xqijLaDKuRDUeC8kiBA
         GjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689222056; x=1691814056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDYdNA9lDVtoD8B2uXnOlmCKBsx14i431NGid1vWIJk=;
        b=M4pWwkICICfJyogg8NPHTmO2etNtOiKsjhay7IKuiWOLQ08vvVuLIaI/EoPUEntx2D
         Mw0MgiUMBiXDrDU4WzhzvnY0VVlvOGcGDuBy1quFSXSsMFIAm6Ia/EyvfskLOF7ANiN5
         vkn3IRyxEV2FvztbBjSc9sWlxdatHG83h6L5yHvQi9tRMnB7b2FMLJ71zVdo6yV31Hz8
         bIIw4eiuRYAlwBuBs5fj66XSFvEE1C2qw0mH9z11Nkq96uKZnEGZTeS1DS1Dx/tAnis3
         Sldd3GaKvrrUUpFSZnfeMG8HoOx4HCu0aRzTGBuUmYwfab42BihirqDKiVuOCZkC6xJh
         MKeA==
X-Gm-Message-State: ABy/qLYteyhUg556pVx+TqaCs75ZKHVejroU0diDqG14N+d/ZiC8QWvk
        rfyD3U58RB1NU+xCEaUZxH8=
X-Google-Smtp-Source: APBJJlHQxzKWeFUb/2UkMXGmNGKuylqY/krdL/0xjSDkichAxJjhqdaXBt4aeDVvXdaDtSe6XlZmbw==
X-Received: by 2002:a05:6808:1b1e:b0:3a1:c841:f026 with SMTP id bx30-20020a0568081b1e00b003a1c841f026mr675089oib.27.1689222056477;
        Wed, 12 Jul 2023 21:20:56 -0700 (PDT)
Received: from fedora.. ([1.245.179.104])
        by smtp.gmail.com with ESMTPSA id u18-20020aa78392000000b006827c26f147sm4346601pfm.138.2023.07.12.21.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 21:20:55 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [RFC PATCH v2 01/21] mm/zsmalloc: create new struct zsdesc
Date:   Thu, 13 Jul 2023 13:20:16 +0900
Message-ID: <20230713042037.980211-2-42.hyeyoo@gmail.com>
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

Currently zsmalloc reuses fields of struct page. As part of simplifying
struct page, create own type for zsmalloc called zsdesc.

Remove comments about how zsmalloc reuses fields of struct page, because
zsdesc uses more intuitive names.

Note that zsmalloc does not use PG_owner_priv_v1 after commit a41ec880aa7b
("zsmalloc: move huge compressed obj from page to zspage"). Thus only
document how zsmalloc uses PG_private flag.

It is very tempting to rearrange zsdesc, but the three words after flags
field are not available for zsmalloc. Add comments about that.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/zsmalloc.c | 63 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 17 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 32f5bc4074df..2204bea4f289 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -11,23 +11,6 @@
  * Released under the terms of GNU General Public License Version 2.0
  */
 
-/*
- * Following is how we use various fields and flags of underlying
- * struct page(s) to form a zspage.
- *
- * Usage of struct page fields:
- *	page->private: points to zspage
- *	page->index: links together all component pages of a zspage
- *		For the huge page, this is always 0, so we use this field
- *		to store handle.
- *	page->page_type: first object offset in a subpage of zspage
- *
- * Usage of struct page flags:
- *	PG_private: identifies the first component page
- *	PG_owner_priv_1: identifies the huge component page
- *
- */
-
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 /*
@@ -264,6 +247,52 @@ struct mapping_area {
 	enum zs_mapmode vm_mm; /* mapping mode */
 };
 
+/*
+ * struct zsdesc - memory descriptor for zsmalloc memory
+ *
+ * This struct overlays struct page for now. Do not modify without a
+ * good understanding of the issues.
+ *
+ * Usage of struct page flags on zsdesc:
+ *	PG_private: identifies the first component zsdesc
+ */
+struct zsdesc {
+	unsigned long flags;
+
+	/*
+	 * Although not used by zsmalloc, this field is used by non-LRU page migration
+	 * code. Leave it unused.
+	 */
+	struct list_head lru;
+
+	/* Always points to zsmalloc_mops with PAGE_MAPPING_MOVABLE set */
+	struct movable_operations *mops;
+
+	union {
+		/* linked list of all zsdescs in a zspage */
+		struct zsdesc *next;
+		/* for huge zspages */
+		unsigned long handle;
+	};
+	struct zspage *zspage;
+	unsigned int first_obj_offset;
+	unsigned int _refcount;
+};
+
+#define ZSDESC_MATCH(pg, zs) \
+	static_assert(offsetof(struct page, pg) == offsetof(struct zsdesc, zs))
+
+ZSDESC_MATCH(flags, flags);
+ZSDESC_MATCH(lru, lru);
+ZSDESC_MATCH(mapping, mops);
+ZSDESC_MATCH(index, next);
+ZSDESC_MATCH(index, handle);
+ZSDESC_MATCH(private, zspage);
+ZSDESC_MATCH(page_type, first_obj_offset);
+ZSDESC_MATCH(_refcount, _refcount);
+#undef ZSDESC_MATCH
+static_assert(sizeof(struct zsdesc) <= sizeof(struct page));
+
 /* huge object: pages_per_zspage == 1 && maxobj_per_zspage == 1 */
 static void SetZsHugePage(struct zspage *zspage)
 {
-- 
2.41.0

