Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D41751757
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjGMEVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbjGMEVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:21:20 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC3A26A2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:12 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a1ebb85f99so321256b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689222071; x=1691814071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngawLjUhlg0gVz5P0h4QP2p0Jiq//HK+SFvWsbVxntw=;
        b=miEYIZPddB/Lztm+8sp7zafciwuYzQBUl4vbQGbauqTEcHNn1gEDiWgi3y0NgODIfO
         KRfT+s1Unu3fijwGFRA6MVzyG+GUTrtnozO/iijdLuLlverMdvhbbTy4KwFmhEM5G9I5
         6H4sT2yoo+nLtShyHPAgT2TLEkXkcqjkOYo5zSs8l+iYRqrwf6iFewKlwX+tu7MIZZUj
         uKbOvKvpFprsduIHAWTp/zGNXtqmvpQcnFs8GoLU8Q5hhYMS/VT3SNJrpvkAwpLFA2l4
         hZJN2f5WCfZZdlO9fOSko+tMYv92fmCpNUo+GPxTMo2dQXPG6ljyZ6MIxVd4qMqUDoys
         U4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689222071; x=1691814071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ngawLjUhlg0gVz5P0h4QP2p0Jiq//HK+SFvWsbVxntw=;
        b=JBQhIF7P5Yy8NTovYIxAOMsGRjSwQgttVPH9UPpekzctp30mamhaw/fDvJDKMWPlgr
         jmQfqkeC1F/ltGe89D9rlWsImOATjjl0No0fJ0bG+aDGwq+PRJxnP5xfAMMsamcHXvlS
         ppmLRVYYhca2HJFAehUReXCYUji2wNjHDWQAn4FQHnP7337g3jHH5MQAZAQF2XbPO+AE
         vy7e1BwJaxSxjgnpxbnuFiKhBIo/r6Y5B5/oGDRU7L1myUVQFtDrFgI+UuXuaepLGJ9B
         zW3DcAjwjsEy8QnCh+Jw8esM8yRXR2C6u/g7uMBzpNYfFB1dzCFABxkX3fruie+NpwGT
         ag+w==
X-Gm-Message-State: ABy/qLbEZGYjBdVslq+khel3AfymRVo975Cr4A935wpMRbgtJyLlm3Hu
        ql+5wuwfRyTntLZ0SlEI/HQ=
X-Google-Smtp-Source: APBJJlGDVBDJqg7HpEytgDXKLoXjRZHg1FxttzevCADnVlsFukqWkseGrbnLv60ArIu2kkBe91QxcQ==
X-Received: by 2002:a54:4d85:0:b0:39e:940c:2a58 with SMTP id y5-20020a544d85000000b0039e940c2a58mr682388oix.5.1689222071167;
        Wed, 12 Jul 2023 21:21:11 -0700 (PDT)
Received: from fedora.. ([1.245.179.104])
        by smtp.gmail.com with ESMTPSA id u18-20020aa78392000000b006827c26f147sm4346601pfm.138.2023.07.12.21.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 21:21:10 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [RFC PATCH v2 06/21] mm/zsmalloc: convert __zs_{map,unmap}_object() to use zsdesc
Date:   Thu, 13 Jul 2023 13:20:21 +0900
Message-ID: <20230713042037.980211-7-42.hyeyoo@gmail.com>
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

These two functions take array of pointer to struct page. Introduce
zsdesc_kmap_atomic() and make them take array of pointer to zsdesc
instead of page.

Add silly type casting when calling them which. Casting will be removed
in the next patch.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/zsmalloc.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 2cce76a19a1e..4c0563fce3d0 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -341,6 +341,11 @@ static inline void wait_on_zsdesc_locked(struct zsdesc *zsdesc)
 	wait_on_page_locked(zsdesc_page(zsdesc));
 }
 
+static inline void *zsdesc_kmap_atomic(struct zsdesc *zsdesc)
+{
+	return kmap_atomic(zsdesc_page(zsdesc));
+}
+
 /* huge object: pages_per_zspage == 1 && maxobj_per_zspage == 1 */
 static void SetZsHugePage(struct zspage *zspage)
 {
@@ -1151,7 +1156,7 @@ static inline void __zs_cpu_down(struct mapping_area *area)
 }
 
 static void *__zs_map_object(struct mapping_area *area,
-			struct page *pages[2], int off, int size)
+			struct zsdesc *zsdescs[2], int off, int size)
 {
 	int sizes[2];
 	void *addr;
@@ -1168,10 +1173,10 @@ static void *__zs_map_object(struct mapping_area *area,
 	sizes[1] = size - sizes[0];
 
 	/* copy object to per-cpu buffer */
-	addr = kmap_atomic(pages[0]);
+	addr = zsdesc_kmap_atomic(zsdescs[0]);
 	memcpy(buf, addr + off, sizes[0]);
 	kunmap_atomic(addr);
-	addr = kmap_atomic(pages[1]);
+	addr = zsdesc_kmap_atomic(zsdescs[1]);
 	memcpy(buf + sizes[0], addr, sizes[1]);
 	kunmap_atomic(addr);
 out:
@@ -1179,7 +1184,7 @@ static void *__zs_map_object(struct mapping_area *area,
 }
 
 static void __zs_unmap_object(struct mapping_area *area,
-			struct page *pages[2], int off, int size)
+			struct zsdesc *zsdescs[2], int off, int size)
 {
 	int sizes[2];
 	void *addr;
@@ -1198,10 +1203,10 @@ static void __zs_unmap_object(struct mapping_area *area,
 	sizes[1] = size - sizes[0];
 
 	/* copy per-cpu buffer to object */
-	addr = kmap_atomic(pages[0]);
+	addr = zsdesc_kmap_atomic(zsdescs[0]);
 	memcpy(addr + off, buf, sizes[0]);
 	kunmap_atomic(addr);
-	addr = kmap_atomic(pages[1]);
+	addr = zsdesc_kmap_atomic(zsdescs[1]);
 	memcpy(addr, buf + sizes[0], sizes[1]);
 	kunmap_atomic(addr);
 
@@ -1342,7 +1347,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	pages[1] = get_next_page(page);
 	BUG_ON(!pages[1]);
 
-	ret = __zs_map_object(area, pages, off, class->size);
+	ret = __zs_map_object(area, (struct zsdesc **)pages, off, class->size);
 out:
 	if (likely(!ZsHugePage(zspage)))
 		ret += ZS_HANDLE_SIZE;
@@ -1377,7 +1382,7 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 		pages[1] = get_next_page(page);
 		BUG_ON(!pages[1]);
 
-		__zs_unmap_object(area, pages, off, class->size);
+		__zs_unmap_object(area, (struct zsdesc **)pages, off, class->size);
 	}
 	local_unlock(&zs_map_area.lock);
 
-- 
2.41.0

