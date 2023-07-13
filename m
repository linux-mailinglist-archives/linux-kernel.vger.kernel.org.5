Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C366C751754
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbjGMEVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbjGMEVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:21:04 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179AE210A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:03 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-66c729f5618so324046b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689222062; x=1691814062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fp6PZAIRFvwp6nXKJbH8kpHOkBbqGND+2E3aTyuENRc=;
        b=beHvFnUzX8qISZCLCnJid1ohVYLhkgcwmfXqTrvDAtYU+uy5Ztlr+SfvlDI6cKoJtE
         iskvrecQA0bZlZDRwbgVQ/g0J8Ut1SML5FIOq+0eqy2Ai4g2gpA5Ox886og6Bj8JqBFi
         sjI/ULVjLyBzR4xJcQL4vrDSQDjpBAQYJ4PhWsz/JEJdXAkSZMREN/u8JelZdypkyQyP
         4GH04a4CugoAB2zIdF8O/gijVzuTdNJit+bFzqRN5hyYOdK9hIryfuvUludPF6xLzVrV
         nGDS9XIWOlCAvE5/ZdkX/fU2CE9ooGRBeoqkeqU/LhoRvMHmj81pl+Q1+6Hl9v4bRPFW
         WFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689222062; x=1691814062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fp6PZAIRFvwp6nXKJbH8kpHOkBbqGND+2E3aTyuENRc=;
        b=JYY8QvCw6Bce4+WMKTw+1YHaTpKdnIOc2Sp+UDcFeUSnjqkGeSz2W7J7oCSL9AukiA
         AWk5nv/GJPcbx3KI0vSPngWXZWdwBTH89I+GQ9Kut6WI34/PRPTPWP/dNXRFjr9uAtUT
         2+9EG6bfLOqpe+tn3XjOHVYqJry35uAuMfcnxVthfokKFWGilIjzjOoCrHMMZckQU7bH
         rVe9BRcBQyfDU6zUwEX2dEPIgQ0vJNthOIuVtFN7OAqYQvCDtQzLg2Y/2G+Fc7eUIFTd
         AcqvTRXybBL08dB6aXFxf+qXIy+hzHeAg/iGcytMyEvFBANdgb1C440FSe+2IPn+WU19
         YZuA==
X-Gm-Message-State: ABy/qLYq99XTeRx4JbvqE6Eci+/MZAseKye88KtSWXbooGTbe4dQlTl7
        5N7Tx7u+3/B8q7JfNlAcz0U=
X-Google-Smtp-Source: APBJJlEdRUxFFFRpu7uJbEt4B2QPnF0T3XjBRUtDhiNmPbHRgO1w2Gtj/dHOyvp3B96gwDB8K4OapQ==
X-Received: by 2002:a05:6a00:150a:b0:680:2b80:8479 with SMTP id q10-20020a056a00150a00b006802b808479mr876923pfu.19.1689222062432;
        Wed, 12 Jul 2023 21:21:02 -0700 (PDT)
Received: from fedora.. ([1.245.179.104])
        by smtp.gmail.com with ESMTPSA id u18-20020aa78392000000b006827c26f147sm4346601pfm.138.2023.07.12.21.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 21:21:01 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [RFC PATCH v2 03/21] mm/zsmalloc: replace first_page to first_zsdesc in struct zspage
Date:   Thu, 13 Jul 2023 13:20:18 +0900
Message-ID: <20230713042037.980211-4-42.hyeyoo@gmail.com>
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

Replace first_page to first_zsdesc in struct zspage for further
conversion.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/zsmalloc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 11c203e79c39..8f7d9b79d849 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -234,7 +234,7 @@ struct zspage {
 	};
 	unsigned int inuse;
 	unsigned int freeobj;
-	struct page *first_page;
+	struct zsdesc *first_zsdesc;
 	struct list_head list; /* fullness list */
 	struct zs_pool *pool;
 	rwlock_t lock;
@@ -512,7 +512,7 @@ static inline void mod_zspage_inuse(struct zspage *zspage, int val)
 
 static inline struct page *get_first_page(struct zspage *zspage)
 {
-	struct page *first_page = zspage->first_page;
+	struct page *first_page = zsdesc_page(zspage->first_zsdesc);
 
 	VM_BUG_ON_PAGE(!is_first_page(first_page), first_page);
 	return first_page;
@@ -1024,7 +1024,7 @@ static void create_page_chain(struct size_class *class, struct zspage *zspage,
 		set_page_private(page, (unsigned long)zspage);
 		page->index = 0;
 		if (i == 0) {
-			zspage->first_page = page;
+			zspage->first_zsdesc = page_zsdesc(page);
 			SetPagePrivate(page);
 			if (unlikely(class->objs_per_zspage == 1 &&
 					class->pages_per_zspage == 1))
@@ -1398,7 +1398,7 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 		link->handle = handle;
 	else
 		/* record handle to page->index */
-		zspage->first_page->index = handle;
+		zspage->first_zsdesc->handle = handle;
 
 	kunmap_atomic(vaddr);
 	mod_zspage_inuse(zspage, 1);
-- 
2.41.0

