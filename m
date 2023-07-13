Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9BE751768
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbjGMEXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbjGMEXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:23:16 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B674210A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:22:11 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a04e5baffcso281967b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689222112; x=1691814112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hVswznnlp2brrsm/2WMROw2zFXU8NWv1b1UdYi0jsE=;
        b=nSXeqS1vrLvki3hjRv3NHB0p0a6UYVrNvFV2Ii6YiscGVqtFX14ZQ7AlPeB7kVWfuT
         Ge3ZUTVOIbie5qSVnUIDRYK5ZuZRUShCVLtmwACUe12u+/VK0t8Wp7Wyie//lJZ6R3P3
         ATBNfotR8SP0Km7iZBgdEp7E4T3Q/MMP79/aoXMAyAaawvkpdXL9NDHFTJv4mWqtWThH
         OXQNsrsDF8u9uBkZ6MjB8IRe64HCUUOxL1HZfUNT4M+aL4cre5gN9Lnsazz5jvXtXeIq
         rnP3AWKopqiW/8n5yl4b6sivZEy7PdI4jDL8+0SxDcQChTGYh9PyxFfUWVcjO8flw1zE
         QaPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689222112; x=1691814112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hVswznnlp2brrsm/2WMROw2zFXU8NWv1b1UdYi0jsE=;
        b=F+ppXGrkBFp2KHsPtOHa6T1MUjBIZ26D660Kv3EgmmcunQZ08Bwz9ViLABngswUgVU
         TYX3kUekxvak7Gb9y5MX6Pdu0w6q8M7TrtwvIgO8iHUD4T0i/qdqtY2bLtM/ZiqvRyhL
         8Ceb3RtrQbLUD8i/8dfpYYmz7QCPwtJBCbX9L6GIm5y+gVvwTjP8YFyj05a8IZVwuXCN
         f/pZDHkU3CnSVEAATr4y05czDko1GSJPHUphCYYw+tZeLyTKcKUhIK6iqYxHNWSAkFu5
         fBmTrYwgxR3C8kCP50uVbrzTrjtzVIUpwC+3cIcoTTMLEJ2WuKTYuivm6yZCsiSNO/p6
         BbEQ==
X-Gm-Message-State: ABy/qLYVZaIwHmc7uOYSXZd5+9yCtQ8yYGkvapkHvSgU7aT2mOQh+/Ti
        t0ob7oQDkm7S1ME7eaon1GA=
X-Google-Smtp-Source: APBJJlEsoCbaP98J11wpcHR6OQ0qKz+6eqfKR+c0anBTnosUkA3m/LCnjzPgDTpVgsvmVh0LYSoiSQ==
X-Received: by 2002:a05:6808:1802:b0:3a2:ee9b:4262 with SMTP id bh2-20020a056808180200b003a2ee9b4262mr595232oib.52.1689222111920;
        Wed, 12 Jul 2023 21:21:51 -0700 (PDT)
Received: from fedora.. ([1.245.179.104])
        by smtp.gmail.com with ESMTPSA id u18-20020aa78392000000b006827c26f147sm4346601pfm.138.2023.07.12.21.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 21:21:51 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [RFC PATCH v2 20/21] mm/zsmalloc: remove now unused helper functions
Date:   Thu, 13 Jul 2023 13:20:35 +0900
Message-ID: <20230713042037.980211-21-42.hyeyoo@gmail.com>
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

All users of is_first_page(), get_first_page(), get_next_page()
are now converted to use new helper functions that takes zsdesc.

Remove now unused helper functions.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/zsmalloc.c | 29 +++--------------------------
 1 file changed, 3 insertions(+), 26 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 5f07e3d92a99..3933c023c3c9 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -581,12 +581,7 @@ static DEFINE_PER_CPU(struct mapping_area, zs_map_area) = {
 	.lock	= INIT_LOCAL_LOCK(lock),
 };
 
-static __maybe_unused int is_first_page(struct page *page)
-{
-	return PagePrivate(page);
-}
-
-static __maybe_unused int is_first_zsdesc(struct zsdesc *zsdesc)
+static int is_first_zsdesc(struct zsdesc *zsdesc)
 {
 	return PagePrivate(zsdesc_page(zsdesc));
 }
@@ -603,15 +598,7 @@ static inline void mod_zspage_inuse(struct zspage *zspage, int val)
 	zspage->inuse += val;
 }
 
-static __maybe_unused inline struct page *get_first_page(struct zspage *zspage)
-{
-	struct page *first_page = zsdesc_page(zspage->first_zsdesc);
-
-	VM_BUG_ON_PAGE(!is_first_page(first_page), first_page);
-	return first_page;
-}
-
-static __maybe_unused struct zsdesc *get_first_zsdesc(struct zspage *zspage)
+static struct zsdesc *get_first_zsdesc(struct zspage *zspage)
 {
 	struct zsdesc *first_zsdesc = zspage->first_zsdesc;
 
@@ -907,17 +894,7 @@ static struct zspage *get_zspage(struct zsdesc *zsdesc)
 	return zspage;
 }
 
-static __maybe_unused struct page *get_next_page(struct page *page)
-{
-	struct zspage *zspage = get_zspage(page_zsdesc(page));
-
-	if (unlikely(ZsHugePage(zspage)))
-		return NULL;
-
-	return (struct page *)page->index;
-}
-
-static __maybe_unused struct zsdesc *get_next_zsdesc(struct zsdesc *zsdesc)
+static struct zsdesc *get_next_zsdesc(struct zsdesc *zsdesc)
 {
 	struct zspage *zspage = get_zspage(zsdesc);
 
-- 
2.41.0

