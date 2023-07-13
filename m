Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6A7751764
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjGMEXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbjGMEWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:22:31 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9DD2D7E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:41 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a3373211a1so274252b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689222100; x=1691814100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gkqWMyo7b2B7ewPiOnxxOYIhM7JQ5HFP6zR7XlZTck=;
        b=X3NbDx3D8zqD9lwl2kii6f0ZcuwskOzE291MA+sqwvMG8ec0/+DCydE9arTynZ/hFV
         llNcsSyZINjLssmVLJhR57Gb9x7UOqBRh1WCnSKjNaGY/3+T1C4weTBTwLITapuddIWQ
         w/vZUGgdpa57Dotq9AB4QF2tiXUq+VjAJfzEOkNe8FxdJPM0yHkxP/8v9NSltQj6Uzgk
         Y0zydf1delIbaOOERiR33rUXICwirbWlvPSRGV3fxy8pYZuod/K46pv+voF0EYvcEB2J
         DFyIOGSSKXOkWmUQq5m3V5W1DxAHFb/KZdTzT/6VfC8EOkBljvhCX7zIpQF60wEnzop7
         UlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689222100; x=1691814100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gkqWMyo7b2B7ewPiOnxxOYIhM7JQ5HFP6zR7XlZTck=;
        b=RaotN3yVm3rBv05KYw02aNFMNXeaIMzz2aCj2SHsQbhNJY/zmLUzD69ZTosHoD746g
         wffbKn9fgVvEP7bECUD3MVelr5Wezy+3PmnquUnHiFGkDOwrNhev1wnZ1jy/0T9UerPe
         ec846YMPeBl9QpjzQbT4Mzmd7tsIizHPZUQm52LhrnbqO0m23+n6tJ++hNG/eyB4kocK
         HFLui6a2AcHwYztSgl5lhApdjm7j/1RTCKH3ZQiPvFIEAes4rCFF0J6lhE7WATBMYoWD
         35Q5Ki+letWA1TAgTz7z0eH8ePstOW02l9aNS5hwAYecMcVrKqAFiuGty8Qto9yAtzeG
         GhhQ==
X-Gm-Message-State: ABy/qLbPvb7Y92uM0P5LdEmwXhLAa/Q2UAHq4XO8A6DDeDqQnxV+b6hd
        O5vAPPzwh8o/ADa0egnyQUY=
X-Google-Smtp-Source: APBJJlGiX7tftXPlnlj0r6WSZjzexhUUuLF83JtQLTrkv37u7pJOZ2k5ZiTxPcckOR51/J4NcCaw/A==
X-Received: by 2002:a05:6808:1719:b0:3a3:bf6a:ba55 with SMTP id bc25-20020a056808171900b003a3bf6aba55mr682088oib.3.1689222100219;
        Wed, 12 Jul 2023 21:21:40 -0700 (PDT)
Received: from fedora.. ([1.245.179.104])
        by smtp.gmail.com with ESMTPSA id u18-20020aa78392000000b006827c26f147sm4346601pfm.138.2023.07.12.21.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 21:21:39 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [RFC PATCH v2 16/21] mm/zsmalloc: convert location_to_obj() to use zsdesc
Date:   Thu, 13 Jul 2023 13:20:31 +0900
Message-ID: <20230713042037.980211-17-42.hyeyoo@gmail.com>
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

As all users of location_to_obj() now use zsdesc, convert
location_to_obj() to use zsdesc.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/zsmalloc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 69bd497de35e..fd920b659b1d 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -948,15 +948,15 @@ static void obj_to_zsdesc(unsigned long obj, struct zsdesc **zsdesc)
 }
 
 /**
- * location_to_obj - get obj value encoded from (<page>, <obj_idx>)
- * @page: page object resides in zspage
+ * location_to_obj - get obj value encoded from (<zsdesc>, <obj_idx>)
+ * @zsdesc object resides in zspage
  * @obj_idx: object index
  */
-static unsigned long location_to_obj(struct page *page, unsigned int obj_idx)
+static unsigned long location_to_obj(struct zsdesc *zsdesc, unsigned int obj_idx)
 {
 	unsigned long obj;
 
-	obj = page_to_pfn(page) << OBJ_INDEX_BITS;
+	obj = zsdesc_pfn(zsdesc) << OBJ_INDEX_BITS;
 	obj |= obj_idx & OBJ_INDEX_MASK;
 	obj <<= OBJ_TAG_BITS;
 
@@ -1505,7 +1505,7 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 	kunmap_atomic(vaddr);
 	mod_zspage_inuse(zspage, 1);
 
-	obj = location_to_obj(zsdesc_page(m_zsdesc), obj);
+	obj = location_to_obj(m_zsdesc, obj);
 
 	return obj;
 }
@@ -2014,7 +2014,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 
 			old_obj = handle_to_obj(handle);
 			obj_to_location(old_obj, &dummy, &obj_idx);
-			new_obj = (unsigned long)location_to_obj(zsdesc_page(new_zsdesc),
+			new_obj = (unsigned long)location_to_obj(new_zsdesc,
 								obj_idx);
 			record_obj(handle, new_obj);
 		}
-- 
2.41.0

