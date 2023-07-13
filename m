Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B77175175F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbjGMEWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjGMEVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:21:49 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617F92693
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:26 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666eec46206so311195b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689222086; x=1691814086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KN/0UQ5A23ju1GQxKe5y1Dsl+buU4Kky6wfdVIYQXVw=;
        b=QaglxJ5/4DXjaQRW99wAX/gu3nfKdLqbbfoLZYjSPiZByNoZNuaSdKjd3TkB7SCXyb
         9ehVOxCsLkwO4vuHp5ToaaXKVIGUzxQ0Xc9BVAejByY2cbduYp7MEgSHy3QXB14VaKJu
         /dQ0TVVhsehk0MF70CW/lmLy+DXRf72UlGYPhjyvFIavnPXAU9WS1TRF/1K5Tegr+t0I
         qYRZaVa02qwoX7CwbvkyUENFWVyK/X4roOk9f3PKyKmrpS0lq1ImDkXWV+rL6BZWGEta
         hyb+fgRMQ//JMKjUB80tVxa0Ad7ciBFGNKOG/gFD0rBbAhL4VGHGMzWqsWVYi0c10LpV
         wOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689222086; x=1691814086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KN/0UQ5A23ju1GQxKe5y1Dsl+buU4Kky6wfdVIYQXVw=;
        b=bo9BdbxYqn30GWAvDzdqWUfAxJEFB383lbzaPUBXfls3EK+OPv2qT33AZLphRhVCaB
         +yLPADfUWRV2FGBZYfskDkF6ySNZsJL1+CkFyoBo+RZjAQ5klvrCeEuHefrmOLFHLmfy
         PEZULKxXrLtlvw9XUbth4GYiRfXhZCU6PL+YRbv5488Fbr0pHvneCdU/Gdg6fGBF+LnL
         Pi5UQmG30kbcpd8wZmWG7rZvp/PNgzao9QpNp/3bqqj3EO1ZbxSjV551tYaNSF2fHGKb
         AW+HJTTWH05yrsJDT4BkvVTwGrTZcpP5PwSx65hCfsXG45UHE5eUaAgj1gIAf8WHKsjg
         QkzQ==
X-Gm-Message-State: ABy/qLYvYJO62QflB1qaowuEOT+dmm9BIG7r0AUQ68Vu7u2RfyP28MLX
        OfRw5uKi6qI6mW06pnCA3K5eYGAZ8/QAhQBL75qkKg==
X-Google-Smtp-Source: APBJJlG8kddUlSs/CeJcZNRjhBskayUfvYWIuJ8jWcHhX3qWsCgb/Vp6nYOC/llo4VEovjRzZW4bzw==
X-Received: by 2002:a05:6a00:b51:b0:641:3bf8:6514 with SMTP id p17-20020a056a000b5100b006413bf86514mr775304pfo.10.1689222085708;
        Wed, 12 Jul 2023 21:21:25 -0700 (PDT)
Received: from fedora.. ([1.245.179.104])
        by smtp.gmail.com with ESMTPSA id u18-20020aa78392000000b006827c26f147sm4346601pfm.138.2023.07.12.21.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 21:21:25 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [RFC PATCH v2 11/21] mm/zsmalloc: convert init_zspage() to use zsdesc
Date:   Thu, 13 Jul 2023 13:20:26 +0900
Message-ID: <20230713042037.980211-12-42.hyeyoo@gmail.com>
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

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/zsmalloc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index efd7a0f78962..c8c3039a751a 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1048,16 +1048,16 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 {
 	unsigned int freeobj = 1;
 	unsigned long off = 0;
-	struct page *page = get_first_page(zspage);
+	struct zsdesc *zsdesc = get_first_zsdesc(zspage);
 
-	while (page) {
-		struct page *next_page;
+	while (zsdesc) {
+		struct zsdesc *next_zsdesc;
 		struct link_free *link;
 		void *vaddr;
 
-		set_first_obj_offset(page, off);
+		set_first_obj_offset(zsdesc_page(zsdesc), off);
 
-		vaddr = kmap_atomic(page);
+		vaddr = zsdesc_kmap_atomic(zsdesc);
 		link = (struct link_free *)vaddr + off / sizeof(*link);
 
 		while ((off += class->size) < PAGE_SIZE) {
@@ -1070,8 +1070,8 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 		 * page, which must point to the first object on the next
 		 * page (if present)
 		 */
-		next_page = get_next_page(page);
-		if (next_page) {
+		next_zsdesc = get_next_zsdesc(zsdesc);
+		if (next_zsdesc) {
 			link->next = freeobj++ << OBJ_TAG_BITS;
 		} else {
 			/*
@@ -1081,7 +1081,7 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 			link->next = -1UL << OBJ_TAG_BITS;
 		}
 		kunmap_atomic(vaddr);
-		page = next_page;
+		zsdesc = next_zsdesc;
 		off %= PAGE_SIZE;
 	}
 
-- 
2.41.0

