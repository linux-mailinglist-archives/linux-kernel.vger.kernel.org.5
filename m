Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF7E7CB771
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 02:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjJQAf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 20:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbjJQAfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 20:35:24 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA93D92
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 17:35:22 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-57f0f81b2aeso2846269eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 17:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697502922; x=1698107722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3aXq8VH/Bzp0yHca9sQcxKTmb8CT7p/vnr3DuJfLn4=;
        b=g2XSbQlZuzSVjz6DkBq4ZQTbhM0RzKS58PMpcHtZhSUvL1rMQ1yD5asfMaBQrjjAUP
         a1mgVDWXhg6RuXl/AlF0xWzld9dSadEdoU5SfT3yS/9l9IycJAMwGHdeJumsLk0xgWFW
         E0f4n9/li89wecTtfBv9vVHSS5cy0OJsZbgUWJZoWJNh8fKpBxPSlWJNJKyg7dqMUINv
         KHu/90H6/xWK1oSC8Bv3LCCsmdnT2j6hpVdrwZcxehZxMimS7h8q7st5XTqmneyr9KtF
         2slzUM/8LHoZGRbI57AIyogLmPx2+5cAtbklD8ViLwvLDWzlolXmW66y+lG0+9QAl39i
         56lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697502922; x=1698107722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3aXq8VH/Bzp0yHca9sQcxKTmb8CT7p/vnr3DuJfLn4=;
        b=dauSIz9DvaquJiIUUR0gxgKnT0fJx8u5iU2DZQ9P3onXKSw/woYkBdSLy6jTSJO6CX
         14TiAYIMfeYv4ensWtwgt1TgxZlpheJSDvIkaDbJEKeSl4xQ8qUtQOr7CzE3zx1tg07H
         Q5f0Y/OzlkZmDttW1hBoXZ9GKfBYgJQ2gpis/grjp1uminB+ichuQlvIbK+pY4qgHHnW
         EpBLkJWu+JqMxtf2eTKZJtKsQV7bxna6GoG888GBxUruQXdkiIPynG4vY9vxw2sL+7RD
         16x24LLLdte9vEMOTlMsoUgxX57in2OaZrRW1OyayOlATqtJwfxRsktuKTYTymvbNf9x
         eoZw==
X-Gm-Message-State: AOJu0YxtYf4+MGCHwXNnC3kTCfpO5QEc5rOb/E7Y70AZCMaJ43/vhY/g
        J0ZrMBuCMxnQGIPRKUp/Q6Q=
X-Google-Smtp-Source: AGHT+IFFT4a1HqMInXLkTxCxEdrwYD+on0yB5b7MmegJ8fvbhPx0zC2Bva9YyeHxZ1JjI5ENbjyh4w==
X-Received: by 2002:a05:6359:2c45:b0:139:d5f0:c027 with SMTP id qv5-20020a0563592c4500b00139d5f0c027mr862671rwb.30.1697502921618;
        Mon, 16 Oct 2023 17:35:21 -0700 (PDT)
Received: from localhost (fwdproxy-prn-119.fbsv.net. [2a03:2880:ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id p15-20020aa7860f000000b00690cd981652sm157411pfn.61.2023.10.16.17.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 17:35:21 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, hughd@google.com, corbet@lwn.net,
        konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, david@ixit.cz
Subject: [PATCH 2/2] zswap: store uncompressed pages when compression algorithm fails
Date:   Mon, 16 Oct 2023 17:35:19 -0700
Message-Id: <20231017003519.1426574-3-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017003519.1426574-1-nphamcs@gmail.com>
References: <20231017003519.1426574-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a zswap store, the compression step could fail, leaving the pages
out of the zswap pool. This could happen, for instance, when the pages
hold random data (such as /dev/urandom). This behavior can potentially
create unnecessary LRU inversion: warm but incompressible pages are
swapped out, whereas cold compressible pages reside in the zswap pool.
This could incur IO later when the warmer pages are indeed required
again.

We can instead just store the original page in the zswap pool. Storing
PAGE_SIZE objects is already supported by zsmalloc, zswap's default
backend allocator. When these pages are needed (either for a zswap load
or for writeback), we can simply copy the original content into the
desired buffer.

This patch allows zswap to store uncompressed pages. The feature can be
enabled at runtime via a new parameter. In addition, we add a counter to
track the number of times the compression step fails for diagnostics.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 Documentation/admin-guide/mm/zswap.rst |  7 +++
 mm/zswap.c                             | 60 +++++++++++++++++++++++---
 2 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin-guide/mm/zswap.rst
index 82fa8148a65a..ac1018cb5373 100644
--- a/Documentation/admin-guide/mm/zswap.rst
+++ b/Documentation/admin-guide/mm/zswap.rst
@@ -162,6 +162,13 @@ in memory) as follows:
 
 Note that swapping due to writeback is not disabled with this option.
 
+Compression could also fail during a zswap store attempt. In many cases, it is
+nevertheless beneficial to store the page in the zswap pool (in its
+uncompressed form) for the sake of maintaining the LRU ordering, which will
+be useful for reclaim. This can be enabled as follows:
+
+	echo Y > /sys/module/zswap/parameters/uncompressed_pages_enabled
+
 When there is a sizable amount of cold memory residing in the zswap pool, it
 can be advantageous to proactively write these cold pages to swap and reclaim
 the memory for other use cases. By default, the zswap shrinker is disabled.
diff --git a/mm/zswap.c b/mm/zswap.c
index db2674548670..096266d35602 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -62,6 +62,8 @@ static u64 zswap_pool_limit_hit;
 static u64 zswap_written_back_pages;
 /* Store failed due to a reclaim failure after pool limit was reached */
 static u64 zswap_reject_reclaim_fail;
+/* Compression step fails during store attempt */
+static u64 zswap_reject_compress_fail;
 /* Compressed page was too big for the allocator to (optimally) store */
 static u64 zswap_reject_compress_poor;
 /* Store failed because underlying allocator could not get memory */
@@ -142,6 +144,10 @@ bool zswap_bypass_swap_when_store_fail_enabled;
 module_param_named(bypass_swap_when_store_fail_enabled,
 		   zswap_bypass_swap_when_store_fail_enabled, bool, 0644);
 
+static bool zswap_uncompressed_pages_enabled;
+module_param_named(uncompressed_pages_enabled,
+		   zswap_uncompressed_pages_enabled, bool, 0644);
+
 static bool zswap_exclusive_loads_enabled = IS_ENABLED(
 		CONFIG_ZSWAP_EXCLUSIVE_LOADS_DEFAULT_ON);
 module_param_named(exclusive_loads, zswap_exclusive_loads_enabled, bool, 0644);
@@ -224,6 +230,7 @@ struct zswap_pool {
  * value - value of the same-value filled pages which have same content
  * objcg - the obj_cgroup that the compressed memory is charged to
  * lru - handle to the pool's lru used to evict pages.
+ * is_uncompressed - whether the page is stored in its uncompressed form.
  */
 struct zswap_entry {
 	struct rb_node rbnode;
@@ -238,6 +245,7 @@ struct zswap_entry {
 	struct obj_cgroup *objcg;
 	int nid;
 	struct list_head lru;
+	bool is_uncompressed;
 };
 
 /*
@@ -1307,7 +1315,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	struct crypto_acomp_ctx *acomp_ctx;
 	struct zpool *pool = zswap_find_zpool(entry);
 	bool page_was_allocated;
-	u8 *src, *tmp = NULL;
+	u8 *src, *dst, *tmp = NULL;
 	unsigned int dlen;
 	int ret;
 	struct writeback_control wbc = {
@@ -1356,6 +1364,19 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	dlen = PAGE_SIZE;
 
 	src = zpool_map_handle(pool, entry->handle, ZPOOL_MM_RO);
+	if (entry->is_uncompressed) {
+		if (!zpool_can_sleep_mapped(pool))
+			kfree(tmp);
+
+		dst = kmap_local_page(page);
+		copy_page(dst, src);
+		kunmap_local(dst);
+		zpool_unmap_handle(pool, entry->handle);
+
+		ret = 0;
+		goto success;
+	}
+
 	if (!zpool_can_sleep_mapped(pool)) {
 		memcpy(tmp, src, entry->length);
 		src = tmp;
@@ -1376,6 +1397,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	else
 		zpool_unmap_handle(pool, entry->handle);
 
+success:
 	BUG_ON(ret);
 	BUG_ON(dlen != PAGE_SIZE);
 
@@ -1454,7 +1476,7 @@ bool zswap_store(struct folio *folio)
 	char *buf;
 	u8 *src, *dst;
 	gfp_t gfp;
-	int ret;
+	int ret, compress_ret;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
@@ -1569,11 +1591,15 @@ bool zswap_store(struct folio *folio)
 	 * but in different threads running on different cpu, we have different
 	 * acomp instance, so multiple threads can do (de)compression in parallel.
 	 */
-	ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
+	compress_ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req),
+						&acomp_ctx->wait);
 	dlen = acomp_ctx->req->dlen;
 
-	if (ret)
-		goto put_dstmem;
+	if (compress_ret) {
+		zswap_reject_compress_fail++;
+		if (!zswap_uncompressed_pages_enabled)
+			goto put_dstmem;
+	}
 
 	/* store */
 	zpool = zswap_find_zpool(entry);
@@ -1590,7 +1616,15 @@ bool zswap_store(struct folio *folio)
 		goto put_dstmem;
 	}
 	buf = zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
-	memcpy(buf, dst, dlen);
+
+	/* Compressor failed. Store the page in its uncompressed form. */
+	if (compress_ret) {
+		dlen = PAGE_SIZE;
+		src = kmap_local_page(page);
+		copy_page(buf, src);
+		kunmap_local(src);
+	} else
+		memcpy(buf, dst, dlen);
 	zpool_unmap_handle(zpool, handle);
 	mutex_unlock(acomp_ctx->mutex);
 
@@ -1598,6 +1632,7 @@ bool zswap_store(struct folio *folio)
 	entry->swpentry = swp_entry(type, offset);
 	entry->handle = handle;
 	entry->length = dlen;
+	entry->is_uncompressed = compress_ret;
 
 insert_entry:
 	entry->objcg = objcg;
@@ -1687,6 +1722,17 @@ bool zswap_load(struct folio *folio)
 	}
 
 	zpool = zswap_find_zpool(entry);
+
+	if (entry->is_uncompressed) {
+		src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
+		dst = kmap_local_page(page);
+		copy_page(dst, src);
+		kunmap_local(dst);
+		zpool_unmap_handle(zpool, entry->handle);
+		ret = true;
+		goto stats;
+	}
+
 	if (!zpool_can_sleep_mapped(zpool)) {
 		tmp = kmalloc(entry->length, GFP_KERNEL);
 		if (!tmp) {
@@ -1855,6 +1901,8 @@ static int zswap_debugfs_init(void)
 			   zswap_debugfs_root, &zswap_reject_alloc_fail);
 	debugfs_create_u64("reject_kmemcache_fail", 0444,
 			   zswap_debugfs_root, &zswap_reject_kmemcache_fail);
+	debugfs_create_u64("reject_compress_fail", 0444,
+			   zswap_debugfs_root, &zswap_reject_compress_fail);
 	debugfs_create_u64("reject_compress_poor", 0444,
 			   zswap_debugfs_root, &zswap_reject_compress_poor);
 	debugfs_create_u64("written_back_pages", 0444,
-- 
2.34.1

