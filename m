Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BAD7E2DE6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjKFUND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbjKFUMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:12:48 -0500
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [IPv6:2001:41d0:203:375::ba])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9D0D7D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:12:45 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699301564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y7WYl7BvMbHXvuo0GG2Dw3ttgTpXyQGpBAxBpCO6Yug=;
        b=Se8wvGtj/WVgiMvB7sZyg/heScqMLOAwYAwTo7zIDTlOs7/E4MpQ3WkYM5OZWwaEklWfOa
        6LljcHgyM247RHb2O+0uPsJYfuEgHjfHFdFXD7jDjGFaAlpmIDR4Qn3spNLTA9EIg7y9u6
        nCPJ9UBSsabPf9Y6+LauRsZG7NRpK20=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH RFC 13/20] mempool: use new mempool KASAN hooks
Date:   Mon,  6 Nov 2023 21:10:22 +0100
Message-Id: <35771e9e5fc0fe2169c59f190fbd6bfc901b7c09.1699297309.git.andreyknvl@google.com>
In-Reply-To: <cover.1699297309.git.andreyknvl@google.com>
References: <cover.1699297309.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Update the mempool code to use the new mempool KASAN hooks.

Rely on the return value of kasan_mempool_poison_object and
kasan_mempool_poison_pages to prevent double-free and invalid-free bugs.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/mempool.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/mempool.c b/mm/mempool.c
index 768cb39dc5e2..f67ca6753332 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -104,32 +104,34 @@ static inline void poison_element(mempool_t *pool, void *element)
 }
 #endif /* CONFIG_DEBUG_SLAB || CONFIG_SLUB_DEBUG_ON */
 
-static __always_inline void kasan_poison_element(mempool_t *pool, void *element)
+static __always_inline bool kasan_poison_element(mempool_t *pool, void *element)
 {
 	if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc)
-		kasan_mempool_poison_object(element);
+		return kasan_mempool_poison_object(element);
 	else if (pool->alloc == mempool_alloc_pages)
-		kasan_poison_pages(element, (unsigned long)pool->pool_data,
-				   false);
+		return kasan_mempool_poison_pages(element,
+						(unsigned long)pool->pool_data);
+	return true;
 }
 
 static void kasan_unpoison_element(mempool_t *pool, void *element)
 {
 	if (pool->alloc == mempool_kmalloc)
-		kasan_unpoison_range(element, (size_t)pool->pool_data);
+		kasan_mempool_unpoison_object(element, (size_t)pool->pool_data);
 	else if (pool->alloc == mempool_alloc_slab)
-		kasan_unpoison_range(element, kmem_cache_size(pool->pool_data));
+		kasan_mempool_unpoison_object(element,
+					      kmem_cache_size(pool->pool_data));
 	else if (pool->alloc == mempool_alloc_pages)
-		kasan_unpoison_pages(element, (unsigned long)pool->pool_data,
-				     false);
+		kasan_mempool_unpoison_pages(element,
+					     (unsigned long)pool->pool_data);
 }
 
 static __always_inline void add_element(mempool_t *pool, void *element)
 {
 	BUG_ON(pool->curr_nr >= pool->min_nr);
 	poison_element(pool, element);
-	kasan_poison_element(pool, element);
-	pool->elements[pool->curr_nr++] = element;
+	if (kasan_poison_element(pool, element))
+		pool->elements[pool->curr_nr++] = element;
 }
 
 static void *remove_element(mempool_t *pool)
-- 
2.25.1

