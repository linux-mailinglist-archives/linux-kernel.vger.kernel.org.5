Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74464751760
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbjGMEWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbjGMEVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:21:51 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCFA2721
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:29 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6726d5d92afso981654b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689222089; x=1691814089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yfQ6zPraH8dHZa8YhEhQL1VMOJgNkmLyTsm8Haifgs=;
        b=g8WMZWqHXrrpccZO8HYjWcBBVZeWLTjyD+nWNKQw7fp7VGvy2h/d70QzcUDIj9R2oe
         YxbhuQWUUag7c5ql2Sz6xOTRQZRl6Wz83EWdeACFTpfUfy6BfevLWPPqBhpvw+maXfJK
         PwN+uXTrb/UMYeLk+dWQmZT+oq7QBI+afN4uG7iVW4Cuw7ui+Gc79QHpz5qp3l9zaRiw
         XO2sKqyRNO9V2MtCOpV6ufDEugUXje//Fdy4QBNoMUqMtJHeQgZQjj0pxT1kje47syCr
         K98RIjHW4oPOlzDbyBqfzS4pdfh+DCmURNBmMNVzuGCRP2Qbf+hL33XqBpmYnvNvHm7x
         yxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689222089; x=1691814089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5yfQ6zPraH8dHZa8YhEhQL1VMOJgNkmLyTsm8Haifgs=;
        b=jldJYvSfTjIBZD8Moh+Uq6zpz3g6Y3HC1d1R+GxszZsNqWNpdd+BGLIOHY915ujzAc
         eA3DwZX3zSpA+1tdLwcXI/hzl1n7TuSK4RJEwkz3/S/NqSx1/Qt0MzWb9rhhQAmxQATW
         BYFuNxC4rwc4LCPn9hgWa5FEYJqRd2AtySC4IMQTjiFG3XEYAGTpEK9hYhRfiRAQPWHY
         RaTQKwo3GAaC7a+AQICl5J2mOooVf8jrLnmQS/ZBb8Q6AZ+fagPyXxUMK/VoIqaSFOe5
         1qAslIYC/O0t29m0gy6XjFj9LUEfcIBMQ53g39pPtqb9Q0TJTfbxcxRmKBNXDA7MIwSr
         Fw1w==
X-Gm-Message-State: ABy/qLaDy2OFhG7w/QhVuJGHJMaWDjp61cScCAahIDx2+/FLOR9yfna5
        uBpyBmfQ7esUOOZ7flJnB2U=
X-Google-Smtp-Source: APBJJlELtoG4ukoHskrnQbnp45zXdh/TsnPNc0u5P7Tty60WCDZQyFeDcrQPIszYmTm474hUPBaeQg==
X-Received: by 2002:a05:6a20:5496:b0:133:5ed9:f00b with SMTP id i22-20020a056a20549600b001335ed9f00bmr69251pzk.13.1689222088604;
        Wed, 12 Jul 2023 21:21:28 -0700 (PDT)
Received: from fedora.. ([1.245.179.104])
        by smtp.gmail.com with ESMTPSA id u18-20020aa78392000000b006827c26f147sm4346601pfm.138.2023.07.12.21.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 21:21:28 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [RFC PATCH v2 12/21] mm/zsmalloc: convert obj_to_page() and zs_free() to use zsdesc
Date:   Thu, 13 Jul 2023 13:20:27 +0900
Message-ID: <20230713042037.980211-13-42.hyeyoo@gmail.com>
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

Convert obj_to_page() to obj_to_zsdesc() and also convert its user
zs_free() to use zsdesc.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/zsmalloc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index c8c3039a751a..5141a0c72c61 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -915,10 +915,10 @@ static void obj_to_location(unsigned long obj, struct zsdesc **zsdesc,
 	*obj_idx = (obj & OBJ_INDEX_MASK);
 }
 
-static void obj_to_page(unsigned long obj, struct page **page)
+static void obj_to_zsdesc(unsigned long obj, struct zsdesc **zsdesc)
 {
 	obj >>= OBJ_TAG_BITS;
-	*page = pfn_to_page(obj >> OBJ_INDEX_BITS);
+	*zsdesc = pfn_zsdesc(obj >> OBJ_INDEX_BITS);
 }
 
 /**
@@ -1593,7 +1593,7 @@ static void obj_free(int class_size, unsigned long obj)
 void zs_free(struct zs_pool *pool, unsigned long handle)
 {
 	struct zspage *zspage;
-	struct page *f_page;
+	struct zsdesc *f_zsdesc;
 	unsigned long obj;
 	struct size_class *class;
 	int fullness;
@@ -1607,8 +1607,8 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	 */
 	spin_lock(&pool->lock);
 	obj = handle_to_obj(handle);
-	obj_to_page(obj, &f_page);
-	zspage = get_zspage(f_page);
+	obj_to_zsdesc(obj, &f_zsdesc);
+	zspage = get_zspage(zsdesc_page(f_zsdesc));
 	class = zspage_class(pool, zspage);
 
 	class_stat_dec(class, ZS_OBJS_INUSE, 1);
-- 
2.41.0

