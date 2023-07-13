Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B8D751755
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbjGMEV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbjGMEVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:21:09 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653512683
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:06 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a425ef874dso297862b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689222065; x=1691814065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcE2YmIW31bFO7IyE1TbOouyqUx4815Ufga9qggKlmE=;
        b=mYhOCoF5+AgtodxdPh9hQADQfzcGGFdPKxTugVcu2Qs0e1yVg+0UkvCcRf/X3w/74s
         Kyz6ifXK6zTs2BFM00E8ADWIYlLRhhPSNmHbMUUZlBj8VJNziwCjHk5q1W5JoGbozIkM
         qI8cO56rtKm63AxeFVfIB07C8I5KBI7+H5+WeFGDdYzbEUHEYPgAoPksrpjWn3Ox9zJz
         BMPH5pv3QTN4UVgD9QNi87H5RnXLR/nsxOoAuPs2SRz6Ey0ejYmkLYeUBccuiFTR0Oqh
         q7//HZplNbzxfarT1/+PAPdpS1Cq6urRz8/Ed7OiPdOVBDo5/1Ub5DlQn/PxPVvuBZ4M
         +pKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689222065; x=1691814065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jcE2YmIW31bFO7IyE1TbOouyqUx4815Ufga9qggKlmE=;
        b=HPJfEIsoD4pf9fW+JwjfBNB5tzd/b0JqD8/MGXEEn5ozwNcb9fEKasdaNyogN58CZh
         45qOqWCGjsvvbN92+o/79KwNLYrtPfaCGyLwdKy+IUYP2V7MSq9N1Fmn3jcKYVXMVKSD
         9Yzj1k60MnAAAQ+TafM/6AAT51+XY9mRdgypfU0U5CtiyJOJMJ7URbSUvWDtI9M+yIlI
         /YwHhageQnP6IX4nEwm7atGz7XeTose3LF/EPWfgt3Tanuj6wp6UWfgv4R9CwMmDppF+
         +eMyh4EPkdXT4Xt6NZ4fps5w9eg674VhvOA/gNTIXq3zlTASVLO9YlhQ83RFcXET7R+h
         D3sQ==
X-Gm-Message-State: ABy/qLYubrYZ9r8l7nLeBLBBe8+E/rjYN0OJoQgYnFjALpId1P2kQsBc
        S1qgs0c7IKAcHuuqUfqDm/4=
X-Google-Smtp-Source: APBJJlHn+GjEfwkeFf3et/qnGrOvXvkqgNMp79oM2A97NPAz4SPID9PPqYp6PTsedEbPVJXbuLD/Bg==
X-Received: by 2002:a05:6808:1286:b0:3a3:baf8:5b8a with SMTP id a6-20020a056808128600b003a3baf85b8amr908456oiw.13.1689222065353;
        Wed, 12 Jul 2023 21:21:05 -0700 (PDT)
Received: from fedora.. ([1.245.179.104])
        by smtp.gmail.com with ESMTPSA id u18-20020aa78392000000b006827c26f147sm4346601pfm.138.2023.07.12.21.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 21:21:04 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [RFC PATCH v2 04/21] mm/zsmalloc: add alternatives of frequently used helper functions
Date:   Thu, 13 Jul 2023 13:20:19 +0900
Message-ID: <20230713042037.980211-5-42.hyeyoo@gmail.com>
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

get_first_page(), get_next_page(), is_first_page() are frequently used
throughout zsmalloc code. As replacing them all at once would be hard to
review, add alternative helpers and gradually replace its users to
use new functions.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/zsmalloc.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 8f7d9b79d849..f44a2d8a36b5 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -498,6 +498,11 @@ static __maybe_unused int is_first_page(struct page *page)
 	return PagePrivate(page);
 }
 
+static __maybe_unused int is_first_zsdesc(struct zsdesc *zsdesc)
+{
+	return PagePrivate(zsdesc_page(zsdesc));
+}
+
 /* Protected by pool->lock */
 static inline int get_zspage_inuse(struct zspage *zspage)
 {
@@ -510,7 +515,7 @@ static inline void mod_zspage_inuse(struct zspage *zspage, int val)
 	zspage->inuse += val;
 }
 
-static inline struct page *get_first_page(struct zspage *zspage)
+static __maybe_unused inline struct page *get_first_page(struct zspage *zspage)
 {
 	struct page *first_page = zsdesc_page(zspage->first_zsdesc);
 
@@ -518,6 +523,14 @@ static inline struct page *get_first_page(struct zspage *zspage)
 	return first_page;
 }
 
+static __maybe_unused struct zsdesc *get_first_zsdesc(struct zspage *zspage)
+{
+	struct zsdesc *first_zsdesc = zspage->first_zsdesc;
+
+	VM_BUG_ON_PAGE(!is_first_zsdesc(first_zsdesc), zsdesc_page(first_zsdesc));
+	return first_zsdesc;
+}
+
 static inline unsigned int get_first_obj_offset(struct page *page)
 {
 	return page->page_type;
@@ -806,7 +819,7 @@ static struct zspage *get_zspage(struct page *page)
 	return zspage;
 }
 
-static struct page *get_next_page(struct page *page)
+static __maybe_unused struct page *get_next_page(struct page *page)
 {
 	struct zspage *zspage = get_zspage(page);
 
@@ -816,6 +829,16 @@ static struct page *get_next_page(struct page *page)
 	return (struct page *)page->index;
 }
 
+static __maybe_unused struct zsdesc *get_next_zsdesc(struct zsdesc *zsdesc)
+{
+	struct zspage *zspage = get_zspage(zsdesc_page(zsdesc));
+
+	if (unlikely(ZsHugePage(zspage)))
+		return NULL;
+
+	return zsdesc->next;
+}
+
 /**
  * obj_to_location - get (<page>, <obj_idx>) from encoded object value
  * @obj: the encoded object value
-- 
2.41.0

