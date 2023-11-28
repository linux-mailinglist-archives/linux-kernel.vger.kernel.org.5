Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425587FB4D4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344247AbjK1Ivm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjK1Ivl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:51:41 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72773E4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:51:46 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6cc02e77a9cso2801978b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701161506; x=1701766306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=94o0KeTip+rCuWEfzJrNX+wyBtGRxjUM9HxWnyozCLQ=;
        b=EdDDejVkitTTn3TNYxlOyxzk+/prfGd9Tcn/blxm0vuFnAZiEVgpqtXKNvgxjiPzmD
         lFpmubm7s7hGjTiWFVUlDyx2kalCLHc1yeO6PNI27eoKjGQXy5PYR4Dk1QgoOxzlhGfy
         Mcqj1b+L/WFUgLiqTp7Bbl8+xRXNrdjUw1xOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701161506; x=1701766306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94o0KeTip+rCuWEfzJrNX+wyBtGRxjUM9HxWnyozCLQ=;
        b=YJTcxeLdceYbwoetPgh64I9uFK+kXm7G18ViXPP+hKNoD6l2EqcGRWfCnWQ2r9BqSs
         toZbw/UnxIU87vaPV9bhoaVv1xgbAMyE8MX1GKsP0XMJptutBVN7Mc5I+/aYMEFXpxgm
         6TQxcGJ0cjkkJjmdeSHEJ8n5SescZEjrE45EqyeYZmWS7hubUoUKJelIE6IApkPtUas2
         xp+VNljOPDjHshNgW8+5qKQRZUsGvQMXRDJ3ktWtuf0KQSpdWSVDC3h8cWy2wrQHJHYb
         Z5l1hQ3dWRP7ffqMxGy+PYGlQQVIC3hzMvkLde24dBuBT4VrNHCLpmLFydyBUxlL2Hhu
         OJKA==
X-Gm-Message-State: AOJu0YwO/P0/9X8uxIUDRNTOUAMtA9x270lqJ5W9czSY+mztMohpkxhE
        /3yT9XeHBsWYXCABkaY+a4eyv4VboXZcTWfUfKU=
X-Google-Smtp-Source: AGHT+IHMKshrmRNnMzzg4/8dNzoZKqap30uAvyxMhlZKsne9AVXAU18u328Z/i26C5Jup7cgG+5V8w==
X-Received: by 2002:a05:6a21:3392:b0:18c:ba47:74ea with SMTP id yy18-20020a056a21339200b0018cba4774eamr4337244pzb.31.1701161505865;
        Tue, 28 Nov 2023 00:51:45 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:3bea:3548:1aab:8181])
        by smtp.gmail.com with ESMTPSA id f7-20020aa782c7000000b006cb537b09f0sm8447794pfn.199.2023.11.28.00.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:51:45 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] zram: Use kmap_local_page()
Date:   Tue, 28 Nov 2023 17:22:07 +0900
Message-ID: <20231128083845.848008-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kmap_local_page() instead of kmap_atomic() which has been
deprecated.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index f6b286e7f310..2b1d82473be8 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1321,9 +1321,9 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
 		void *mem;
 
 		value = handle ? zram_get_element(zram, index) : 0;
-		mem = kmap_atomic(page);
+		mem = kmap_local_page(page);
 		zram_fill_page(mem, PAGE_SIZE, value);
-		kunmap_atomic(mem);
+		kunmap_local(mem);
 		return 0;
 	}
 
@@ -1336,14 +1336,14 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
 
 	src = zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
 	if (size == PAGE_SIZE) {
-		dst = kmap_atomic(page);
+		dst = kmap_local_page(page);
 		memcpy(dst, src, PAGE_SIZE);
-		kunmap_atomic(dst);
+		kunmap_local(dst);
 		ret = 0;
 	} else {
-		dst = kmap_atomic(page);
+		dst = kmap_local_page(page);
 		ret = zcomp_decompress(zstrm, src, size, dst);
-		kunmap_atomic(dst);
+		kunmap_local(dst);
 		zcomp_stream_put(zram->comps[prio]);
 	}
 	zs_unmap_object(zram->mem_pool, handle);
@@ -1416,21 +1416,21 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	unsigned long element = 0;
 	enum zram_pageflags flags = 0;
 
-	mem = kmap_atomic(page);
+	mem = kmap_local_page(page);
 	if (page_same_filled(mem, &element)) {
-		kunmap_atomic(mem);
+		kunmap_local(mem);
 		/* Free memory associated with this sector now. */
 		flags = ZRAM_SAME;
 		atomic64_inc(&zram->stats.same_pages);
 		goto out;
 	}
-	kunmap_atomic(mem);
+	kunmap_local(mem);
 
 compress_again:
 	zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_COMP]);
-	src = kmap_atomic(page);
+	src = kmap_local_page(page);
 	ret = zcomp_compress(zstrm, src, &comp_len);
-	kunmap_atomic(src);
+	kunmap_local(src);
 
 	if (unlikely(ret)) {
 		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
@@ -1494,10 +1494,10 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 
 	src = zstrm->buffer;
 	if (comp_len == PAGE_SIZE)
-		src = kmap_atomic(page);
+		src = kmap_local_page(page);
 	memcpy(dst, src, comp_len);
 	if (comp_len == PAGE_SIZE)
-		kunmap_atomic(src);
+		kunmap_local(src);
 
 	zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
 	zs_unmap_object(zram->mem_pool, handle);
@@ -1614,9 +1614,9 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 
 		num_recomps++;
 		zstrm = zcomp_stream_get(zram->comps[prio]);
-		src = kmap_atomic(page);
+		src = kmap_local_page(page);
 		ret = zcomp_compress(zstrm, src, &comp_len_new);
-		kunmap_atomic(src);
+		kunmap_local(src);
 
 		if (ret) {
 			zcomp_stream_put(zram->comps[prio]);
-- 
2.43.0.rc1.413.gea7ed67945-goog

