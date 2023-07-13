Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C2075175E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbjGMEWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbjGMEVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:21:47 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C6319BE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:23 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6687446eaccso311460b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689222083; x=1691814083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItG8ksrwK8WHStX9MB/fUTZvwyuLsvIlM15e1efhXFY=;
        b=J0aXa+ktFUJkOdgZrLc2eH6P3UkQshHs83zm1+lxcabnZXxw2S3zbeIJMrU5IqnQpz
         9OWtyPzFeDJ4eBoHQ5EtdlGXLMuCMCuJ8hWmDjHw3Uq+mwo18ozEHn2PrQm1PwV3zKQQ
         oewcfr0RJEamddaDOUGXzRu7FE+s2Eos0q//ZjWC5KNiJlFWWdXzJuhRR8/St6pZAkdK
         XLqCjS/iraG+Go+7sFNvQk18yZkdFi53LwyuJns0hwEG6WlIUi7gf2eN/K3k1WI9sz+x
         YYH3R2RtRgQq6xMHMd9aTAiq4LdFyBW1/+DSz99YmQKagn19cx4MSPATRiNhSbI/I0ag
         2gRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689222083; x=1691814083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItG8ksrwK8WHStX9MB/fUTZvwyuLsvIlM15e1efhXFY=;
        b=U/iqP5ihtRRpoViBHNKFFaI4rhBl5kIWwRngIdTfFcBzmT3pXxJVGzqsIgPY1rRdOd
         pQ+13zIBSzEzZ6R4our4k+LPoMQWtmu93LgBcNufcsZ8l6yTMQhbraD2b61xG9TRiKi2
         2Hf5ALAQQn0q+aqkxsx2f+L1e1j83+bhCGYXXPHqSxgtBYnRGuix2aE+YhpIpdBjJBaF
         p+sVrpqpKA/F6tjAGZpj3n2KBbtYAceIMVouRPtQsYuplR2muqhZptrvev85+XGC5bbB
         C2s4RpQNP74+rk0lkGRtXKSiv9LZB20BlSlHLySWkhtOWB98Rm0XY/vo1d/7bEksifc9
         cr0A==
X-Gm-Message-State: ABy/qLaG7Y6qLPgvYlgYxY0FVO+WUAHt6J1HXn3TZf228g8JdIeFrgVE
        Vxcr4PSOkJhMlVRdzp7P9Vo=
X-Google-Smtp-Source: APBJJlHv1tRh9q0qQqBjcFbXSS+jcB852joeQND+bRafSNcpiomPGfwhEemort4fhA+14tH0PTb7cA==
X-Received: by 2002:a05:6a00:ac7:b0:674:6dd4:8337 with SMTP id c7-20020a056a000ac700b006746dd48337mr934769pfl.12.1689222082858;
        Wed, 12 Jul 2023 21:21:22 -0700 (PDT)
Received: from fedora.. ([1.245.179.104])
        by smtp.gmail.com with ESMTPSA id u18-20020aa78392000000b006827c26f147sm4346601pfm.138.2023.07.12.21.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 21:21:22 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [RFC PATCH v2 10/21] mm/zsmalloc: convert obj_allocated() and related helpers to use zsdesc
Date:   Thu, 13 Jul 2023 13:20:25 +0900
Message-ID: <20230713042037.980211-11-42.hyeyoo@gmail.com>
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

Convert obj_allocated(), and related helpers to take zsdesc. Also make
its callers to cast (struct page *) to (struct zsdesc *) when calling them.
The users will be converted gradually as there are many.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/zsmalloc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 48bfdbbe3b1e..efd7a0f78962 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -942,15 +942,15 @@ static unsigned long handle_to_obj(unsigned long handle)
 	return *(unsigned long *)handle;
 }
 
-static inline bool obj_allocated(struct page *page, void *obj,
+static inline bool obj_allocated(struct zsdesc *zsdesc, void *obj,
 				 unsigned long *phandle)
 {
 	unsigned long handle;
-	struct zspage *zspage = get_zspage(page);
+	struct zspage *zspage = get_zspage(zsdesc_page(zsdesc));
 
 	if (unlikely(ZsHugePage(zspage))) {
-		VM_BUG_ON_PAGE(!is_first_page(page), page);
-		handle = page->index;
+		VM_BUG_ON_PAGE(!is_first_zsdesc(zsdesc), zsdesc_page(zsdesc));
+		handle = zsdesc->handle;
 	} else
 		handle = *(unsigned long *)obj;
 
@@ -1698,18 +1698,18 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
  * return handle.
  */
 static unsigned long find_alloced_obj(struct size_class *class,
-				      struct page *page, int *obj_idx)
+				      struct zsdesc *zsdesc, int *obj_idx)
 {
 	unsigned int offset;
 	int index = *obj_idx;
 	unsigned long handle = 0;
-	void *addr = kmap_atomic(page);
+	void *addr = zsdesc_kmap_atomic(zsdesc);
 
-	offset = get_first_obj_offset(page);
+	offset = get_first_obj_offset(zsdesc_page(zsdesc));
 	offset += class->size * index;
 
 	while (offset < PAGE_SIZE) {
-		if (obj_allocated(page, addr + offset, &handle))
+		if (obj_allocated(zsdesc, addr + offset, &handle))
 			break;
 
 		offset += class->size;
@@ -1733,7 +1733,7 @@ static void migrate_zspage(struct zs_pool *pool, struct zspage *src_zspage,
 	struct size_class *class = pool->size_class[src_zspage->class];
 
 	while (1) {
-		handle = find_alloced_obj(class, s_page, &obj_idx);
+		handle = find_alloced_obj(class, page_zsdesc(s_page), &obj_idx);
 		if (!handle) {
 			s_page = get_next_page(s_page);
 			if (!s_page)
@@ -1990,7 +1990,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 
 	for (addr = s_addr + offset; addr < s_addr + PAGE_SIZE;
 					addr += class->size) {
-		if (obj_allocated(page, addr, &handle)) {
+		if (obj_allocated(page_zsdesc(page), addr, &handle)) {
 
 			old_obj = handle_to_obj(handle);
 			obj_to_location(old_obj, &dummy, &obj_idx);
-- 
2.41.0

