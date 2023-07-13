Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99418751761
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbjGMEWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbjGMEVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:21:53 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D165D26A0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:32 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666ecb21f86so296546b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689222091; x=1691814091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AkKYYKmxj7TQUeJqlTJNcjNKZ3qt8jEQhquu79OlOQ=;
        b=SOG/K/XbNRTO8yeNVcrdEC9e85SmT5W+OelcxVnc+JYMVci8hbXGxUYc9gd4vbQ2aL
         xOYh108uhhE78bp3NscDM2bw1DQiku+bU2BJUvJwhf/cLuc89t2LiJ99VfukWcEdbUUM
         Dxx22mtv8Q6wYTu9gryeEOpcL2K8Ed+Wysz6APUHSMO/AfNgDP49TuqaGCDDqcNvngN0
         aCs+TpmkeOONH2ObDHcVHT7ixWldKRp5t9CINzRwaO5RxB7E2aRhf0+ndlCQXbbT1iqP
         79ze97f7s33kR3eBFqX4rM5CpMfOgksc2n2rzkSLzFC2wlYkLTUZ7OTkxbkFZoS3qWDr
         RlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689222091; x=1691814091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/AkKYYKmxj7TQUeJqlTJNcjNKZ3qt8jEQhquu79OlOQ=;
        b=dAymqUITB/V0kma8mVO3b+IGmgVKVDXqM1sP1vgKZ6wGW2rGHk3Ks+ff5LkV+FdVux
         zSE9KGm0uu0ZZKP4iUvDwbmQQuLLSo5oFNdvKVC/Rmwwcdy4+BcDjzG8nSeba0457swE
         gfM3xWlYihtNsmLkbpXI+NE36hZp7vCqfos8C/HSxUvKY71CIZSdKwx37SD8UFqpI9FI
         ualM8+F3BYHYYymepttOT86oeJzplnOK7o4/JUuey6DoOO0xlTF2OmjDddhh1JayU3US
         i0Jtp7BRkzVp7NO6hLZVmDnzCN7urklS3uHWIslZc7Yb0EYvL4qQeZeEQYilh2Hu/ZVE
         iLnA==
X-Gm-Message-State: ABy/qLaghq3BRYva5x9bOmjkJmz+3igM/ahl2qI1tdphU5LDRu83GvJC
        XTj+qtLnOCDMAKGiuYBsmtY=
X-Google-Smtp-Source: APBJJlEjl5B7pAx+psP3HeXUMoWINVPRy39+miBs80ttFtJlPDOsP+1gCYRlrL/q07+KyucCY6JJCQ==
X-Received: by 2002:a05:6a00:2d8d:b0:680:98c:c595 with SMTP id fb13-20020a056a002d8d00b00680098cc595mr731083pfb.13.1689222091506;
        Wed, 12 Jul 2023 21:21:31 -0700 (PDT)
Received: from fedora.. ([1.245.179.104])
        by smtp.gmail.com with ESMTPSA id u18-20020aa78392000000b006827c26f147sm4346601pfm.138.2023.07.12.21.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 21:21:31 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [RFC PATCH v2 13/21] mm/zsmalloc: convert reset_page() to reset_zsdesc()
Date:   Thu, 13 Jul 2023 13:20:28 +0900
Message-ID: <20230713042037.980211-14-42.hyeyoo@gmail.com>
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

reset_page() is called prior to freeing base pages of a zspage.
As it's closely associated with details of struct page, rename it to
reset_zsdesc() and move closer to newly added zsdesc helper functions.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/zsmalloc.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 5141a0c72c61..085f5c791a03 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -388,6 +388,17 @@ static inline void free_zsdesc(struct zsdesc *zsdesc)
 	__free_page(page);
 }
 
+static void reset_zsdesc(struct zsdesc *zsdesc)
+{
+	struct page *page = zsdesc_page(zsdesc);
+
+	__ClearPageMovable(page);
+	ClearPagePrivate(page);
+	set_page_private(page, 0);
+	page_mapcount_reset(page);
+	page->index = 0;
+}
+
 /* huge object: pages_per_zspage == 1 && maxobj_per_zspage == 1 */
 static void SetZsHugePage(struct zspage *zspage)
 {
@@ -962,15 +973,6 @@ static inline bool obj_allocated(struct zsdesc *zsdesc, void *obj,
 	return true;
 }
 
-static void reset_page(struct page *page)
-{
-	__ClearPageMovable(page);
-	ClearPagePrivate(page);
-	set_page_private(page, 0);
-	page_mapcount_reset(page);
-	page->index = 0;
-}
-
 static int trylock_zspage(struct zspage *zspage)
 {
 	struct zsdesc *cursor, *fail;
@@ -1010,7 +1012,7 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 	do {
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
 		next = get_next_page(page);
-		reset_page(page);
+		reset_zsdesc(page_zsdesc(page));
 		unlock_page(page);
 		dec_zone_page_state(page, NR_ZSPAGES);
 		put_page(page);
@@ -2016,7 +2018,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 		inc_zone_page_state(newpage, NR_ZSPAGES);
 	}
 
-	reset_page(page);
+	reset_zsdesc(page_zsdesc(page));
 	put_page(page);
 
 	return MIGRATEPAGE_SUCCESS;
-- 
2.41.0

