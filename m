Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DD7765892
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbjG0QYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbjG0QXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:23:52 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C93B30ED
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:23:51 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1bb5ce75e43so808470fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1690475030; x=1691079830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xKvUZAC/PcwLq4Mn3vj+fKTV8KIinkTpyaNVs2EYco=;
        b=ZM6siFmcEpT22TCKTBC20dzc2m3blvxe+fV7xBWQ5V/W+B8u2sR51MOrUVn0oe9H9r
         p3SLhh1gZWJjZ41HzedjMK816QkKQbpYiYtUKKn82b4C9atpUvnedHQf+0jDaBf3j77Q
         tJOmmfcGqfxttLoXBrJCFjVGF8sW0Q572CZ16Ht4fa8chGgIb2Jw6/K1cT/xLpr/JkM5
         r3iilsyakH1SBZfuqYO5hwJQP1WMnOayvcj1j6HQ6bVFu643j76ZwjEXMY25LUTF4q1y
         UHe6Ly/6TR285I3CJYLC6dr76PLwRPjFwQFb634smNKQW1NJjIxSKuDdZhMfZRorHggK
         kV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690475030; x=1691079830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xKvUZAC/PcwLq4Mn3vj+fKTV8KIinkTpyaNVs2EYco=;
        b=Fjn64tsHhutAsxaz4eOb9uixzUsGm48tj1b4kdBW3Xs9cjs1AtDU/yTwJ9eXQB/DWr
         k59sdv2klcfHXPQguigtBbHdpRuE65X2Q9LtUr+QIq0VBYKSk9JeMpyKGRUQ94BOOUTh
         xxOMJ3JDNtqLCwpn9BWH2IGSCweO+IsV3Sbb0N85AQ3ApPaR2ar5CQhj0NR72M2H+MJP
         Iz5z26J2Lv2E86qfsjYLom+zrrzTWfZzqngco5CXswWX/4VHzK9oP+wONHO4XpU52f4K
         puk9z3+WKWQxlqYKvHXmDoITBgNThkNK0Y3C/6QCCYZFSJblPbQZbRm/W1AUqG6y340m
         nOlQ==
X-Gm-Message-State: ABy/qLb6qqEYzYjNjk+GWzyjPuw1TQW4WGGn/3hP91wi/9kAil+RaTKJ
        6z18JA+XkN1eIwIFkL8yp7uzAQ==
X-Google-Smtp-Source: APBJJlGe/1LwJSfSBsFM0E1SehZPQyy8thiIa1GfuOSx8pATP8cfV6nW9jnsPOBTG2/9/yJ+wCDfCQ==
X-Received: by 2002:a05:6871:593:b0:1bb:5ef8:d606 with SMTP id u19-20020a056871059300b001bb5ef8d606mr3430099oan.41.1690475029900;
        Thu, 27 Jul 2023 09:23:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ad06])
        by smtp.gmail.com with ESMTPSA id x19-20020ac87ed3000000b004055106ee80sm519047qtj.44.2023.07.27.09.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 09:23:49 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mm: zswap: kill zswap_get_swap_cache_page()
Date:   Thu, 27 Jul 2023 12:22:25 -0400
Message-ID: <20230727162343.1415598-4-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727162343.1415598-1-hannes@cmpxchg.org>
References: <20230727162343.1415598-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __read_swap_cache_async() interface isn't more difficult to
understand than what the helper abstracts. Save the indirection and a
level of indentation for the primary work of the writeback func.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 142 ++++++++++++++++++++---------------------------------
 1 file changed, 53 insertions(+), 89 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index e34ac89e6098..bba4ead672be 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1016,43 +1016,6 @@ static int zswap_enabled_param_set(const char *val,
 /*********************************
 * writeback code
 **********************************/
-/* return enum for zswap_get_swap_cache_page */
-enum zswap_get_swap_ret {
-	ZSWAP_SWAPCACHE_NEW,
-	ZSWAP_SWAPCACHE_EXIST,
-	ZSWAP_SWAPCACHE_FAIL,
-};
-
-/*
- * zswap_get_swap_cache_page
- *
- * This is an adaption of read_swap_cache_async()
- *
- * This function tries to find a page with the given swap entry
- * in the swapper_space address space (the swap cache).  If the page
- * is found, it is returned in retpage.  Otherwise, a page is allocated,
- * added to the swap cache, and returned in retpage.
- *
- * If success, the swap cache page is returned in retpage
- * Returns ZSWAP_SWAPCACHE_EXIST if page was already in the swap cache
- * Returns ZSWAP_SWAPCACHE_NEW if the new page needs to be populated,
- *     the new page is added to swapcache and locked
- * Returns ZSWAP_SWAPCACHE_FAIL on error
- */
-static int zswap_get_swap_cache_page(swp_entry_t entry,
-				struct page **retpage)
-{
-	bool page_was_allocated;
-
-	*retpage = __read_swap_cache_async(entry, GFP_KERNEL,
-			NULL, 0, &page_was_allocated);
-	if (page_was_allocated)
-		return ZSWAP_SWAPCACHE_NEW;
-	if (!*retpage)
-		return ZSWAP_SWAPCACHE_FAIL;
-	return ZSWAP_SWAPCACHE_EXIST;
-}
-
 /*
  * Attempts to free an entry by adding a page to the swap cache,
  * decompressing the entry data into the page, and issuing a
@@ -1073,7 +1036,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
 	struct zpool *pool = entry->pool->zpool;
-
+	bool page_was_allocated;
 	u8 *src, *tmp = NULL;
 	unsigned int dlen;
 	int ret;
@@ -1088,65 +1051,66 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	}
 
 	/* try to allocate swap cache page */
-	switch (zswap_get_swap_cache_page(swpentry, &page)) {
-	case ZSWAP_SWAPCACHE_FAIL: /* no memory or invalidate happened */
+	page = __read_swap_cache_async(swpentry, GFP_KERNEL, NULL, 0,
+				       &page_was_allocated);
+	if (!page) {
 		ret = -ENOMEM;
 		goto fail;
+	}
 
-	case ZSWAP_SWAPCACHE_EXIST:
-		/* page is already in the swap cache, ignore for now */
+	/* Found an existing page, we raced with load/swapin */
+	if (!page_was_allocated) {
 		put_page(page);
 		ret = -EEXIST;
 		goto fail;
+	}
 
-	case ZSWAP_SWAPCACHE_NEW: /* page is locked */
-		/*
-		 * Having a local reference to the zswap entry doesn't exclude
-		 * swapping from invalidating and recycling the swap slot. Once
-		 * the swapcache is secured against concurrent swapping to and
-		 * from the slot, recheck that the entry is still current before
-		 * writing.
-		 */
-		spin_lock(&tree->lock);
-		if (zswap_rb_search(&tree->rbroot, swp_offset(entry->swpentry)) != entry) {
-			spin_unlock(&tree->lock);
-			delete_from_swap_cache(page_folio(page));
-			ret = -ENOMEM;
-			goto fail;
-		}
+	/*
+	 * Page is locked, and the swapcache is now secured against
+	 * concurrent swapping to and from the slot. Verify that the
+	 * swap entry hasn't been invalidated and recycled behind our
+	 * backs (our zswap_entry reference doesn't prevent that), to
+	 * avoid overwriting a new swap page with old compressed data.
+	 */
+	spin_lock(&tree->lock);
+	if (zswap_rb_search(&tree->rbroot, swp_offset(entry->swpentry)) != entry) {
 		spin_unlock(&tree->lock);
+		delete_from_swap_cache(page_folio(page));
+		ret = -ENOMEM;
+		goto fail;
+	}
+	spin_unlock(&tree->lock);
 
-		/* decompress */
-		acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
-		dlen = PAGE_SIZE;
+	/* decompress */
+	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
+	dlen = PAGE_SIZE;
 
-		src = zpool_map_handle(pool, entry->handle, ZPOOL_MM_RO);
-		if (!zpool_can_sleep_mapped(pool)) {
-			memcpy(tmp, src, entry->length);
-			src = tmp;
-			zpool_unmap_handle(pool, entry->handle);
-		}
+	src = zpool_map_handle(pool, entry->handle, ZPOOL_MM_RO);
+	if (!zpool_can_sleep_mapped(pool)) {
+		memcpy(tmp, src, entry->length);
+		src = tmp;
+		zpool_unmap_handle(pool, entry->handle);
+	}
 
-		mutex_lock(acomp_ctx->mutex);
-		sg_init_one(&input, src, entry->length);
-		sg_init_table(&output, 1);
-		sg_set_page(&output, page, PAGE_SIZE, 0);
-		acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, dlen);
-		ret = crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait);
-		dlen = acomp_ctx->req->dlen;
-		mutex_unlock(acomp_ctx->mutex);
-
-		if (!zpool_can_sleep_mapped(pool))
-			kfree(tmp);
-		else
-			zpool_unmap_handle(pool, entry->handle);
+	mutex_lock(acomp_ctx->mutex);
+	sg_init_one(&input, src, entry->length);
+	sg_init_table(&output, 1);
+	sg_set_page(&output, page, PAGE_SIZE, 0);
+	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, dlen);
+	ret = crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait);
+	dlen = acomp_ctx->req->dlen;
+	mutex_unlock(acomp_ctx->mutex);
+
+	if (!zpool_can_sleep_mapped(pool))
+		kfree(tmp);
+	else
+		zpool_unmap_handle(pool, entry->handle);
 
-		BUG_ON(ret);
-		BUG_ON(dlen != PAGE_SIZE);
+	BUG_ON(ret);
+	BUG_ON(dlen != PAGE_SIZE);
 
-		/* page is up to date */
-		SetPageUptodate(page);
-	}
+	/* page is up to date */
+	SetPageUptodate(page);
 
 	/* move it to the tail of the inactive list after end_writeback */
 	SetPageReclaim(page);
@@ -1157,16 +1121,16 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	zswap_written_back_pages++;
 
 	return ret;
+
 fail:
 	if (!zpool_can_sleep_mapped(pool))
 		kfree(tmp);
 
 	/*
-	* if we get here due to ZSWAP_SWAPCACHE_EXIST
-	* a load may be happening concurrently.
-	* it is safe and okay to not free the entry.
-	* it is also okay to return !0
-	*/
+	 * If we get here because the page is already in swapcache, a
+	 * load may be happening concurrently. It is safe and okay to
+	 * not free the entry. It is also okay to return !0.
+	 */
 	return ret;
 }
 
-- 
2.41.0

