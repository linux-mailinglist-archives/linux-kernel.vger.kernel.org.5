Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF3D7E2DD3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjKFUL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbjKFULq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:11:46 -0500
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFAED77
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:11:43 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699301501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CJgfMj/P7YPw/LlXCqtrAgQfJMC0kIuIB9F1taTDejA=;
        b=RItIssP+VxjIXsAX7VSo3+5Kc1Se3hq8f7f/cbQzFTUM6RKLnsGl4CAP/yG2vvcChay10m
        sSL9QfjTxiEsvbgUXV80kI0/hG2Tid6pbZndkQAOOqmBYC5P+q26F0bUqJ3gTSejNUH0wQ
        8h5rzVebWZwZH9+D6V1P/RwTQQDBARw=
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
Subject: [PATCH RFC 11/20] kasan: introduce poison_kmalloc_large_redzone
Date:   Mon,  6 Nov 2023 21:10:20 +0100
Message-Id: <79f306b7713aa06876975bbc782c392087652383.1699297309.git.andreyknvl@google.com>
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

Split out a poison_kmalloc_large_redzone helper from
__kasan_kmalloc_large and use it in the caller's code.

This is a preparatory change for the following patches in this series.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index ceb06d5f169f..b50e4fbaf238 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -353,23 +353,12 @@ void * __must_check __kasan_kmalloc(struct kmem_cache *cache, const void *object
 }
 EXPORT_SYMBOL(__kasan_kmalloc);
 
-void * __must_check __kasan_kmalloc_large(const void *ptr, size_t size,
+static inline void poison_kmalloc_large_redzone(const void *ptr, size_t size,
 						gfp_t flags)
 {
 	unsigned long redzone_start;
 	unsigned long redzone_end;
 
-	if (gfpflags_allow_blocking(flags))
-		kasan_quarantine_reduce();
-
-	if (unlikely(ptr == NULL))
-		return NULL;
-
-	/*
-	 * The object has already been unpoisoned by kasan_unpoison_pages() for
-	 * alloc_pages() or by kasan_krealloc() for krealloc().
-	 */
-
 	/*
 	 * The redzone has byte-level precision for the generic mode.
 	 * Partially poison the last object granule to cover the unaligned
@@ -379,12 +368,25 @@ void * __must_check __kasan_kmalloc_large(const void *ptr, size_t size,
 		kasan_poison_last_granule(ptr, size);
 
 	/* Poison the aligned part of the redzone. */
-	redzone_start = round_up((unsigned long)(ptr + size),
-				KASAN_GRANULE_SIZE);
+	redzone_start = round_up((unsigned long)(ptr + size), KASAN_GRANULE_SIZE);
 	redzone_end = (unsigned long)ptr + page_size(virt_to_page(ptr));
 	kasan_poison((void *)redzone_start, redzone_end - redzone_start,
 		     KASAN_PAGE_REDZONE, false);
+}
 
+void * __must_check __kasan_kmalloc_large(const void *ptr, size_t size,
+						gfp_t flags)
+{
+	if (gfpflags_allow_blocking(flags))
+		kasan_quarantine_reduce();
+
+	if (unlikely(ptr == NULL))
+		return NULL;
+
+	/* The object has already been unpoisoned by kasan_unpoison_pages(). */
+	poison_kmalloc_large_redzone(ptr, size, flags);
+
+	/* Keep the tag that was set by alloc_pages(). */
 	return (void *)ptr;
 }
 
@@ -392,6 +394,9 @@ void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flag
 {
 	struct slab *slab;
 
+	if (gfpflags_allow_blocking(flags))
+		kasan_quarantine_reduce();
+
 	if (unlikely(object == ZERO_SIZE_PTR))
 		return (void *)object;
 
@@ -409,11 +414,11 @@ void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flag
 
 	/* Piggy-back on kmalloc() instrumentation to poison the redzone. */
 	if (unlikely(!slab))
-		return __kasan_kmalloc_large(object, size, flags);
-	else {
+		poison_kmalloc_large_redzone(object, size, flags);
+	else
 		poison_kmalloc_redzone(slab->slab_cache, object, size, flags);
-		return (void *)object;
-	}
+
+	return (void *)object;
 }
 
 bool __kasan_mempool_poison_pages(struct page *page, unsigned int order,
-- 
2.25.1

