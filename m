Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5157E2DCF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjKFULv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjKFULp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:11:45 -0500
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [IPv6:2001:41d0:203:375::b4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D8210C2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:11:40 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699301498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wOW8bM5LUt0/83cpSlqfBj0DKQkCrWZjISfEAI+z8F8=;
        b=whzKutAZQjowRwHa43pazOIwGIr0bQTB71FOqN2VXFxSHeCtofhsbtvlLPo7irVUIhiyw6
        pancxW7Jzm82f5iCk4fHMKj/CtH9ujxzi66CbOwDe/5jAaY5Ge9UJvVHW0GX5ta8Tzklfq
        sce+wX6Wcualha3H+6sfIg6SEBbZJSo=
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
Subject: [PATCH RFC 06/20] kasan: introduce kasan_mempool_poison_pages
Date:   Mon,  6 Nov 2023 21:10:15 +0100
Message-Id: <3a377ec3223f9c98f3ac471845e084abe7fd6fe0.1699297309.git.andreyknvl@google.com>
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

Introduce and document a kasan_mempool_poison_pages hook to be used
by the mempool code instead of kasan_poison_pages.

Compated to kasan_poison_pages, the new hook:

1. For the tag-based modes, skips checking and poisoning allocations that
   were not tagged due to sampling.

2. Checks for double-free and invalid-free bugs.

In the future, kasan_poison_pages can also be updated to handle #2, but
this is out-of-scope of this series.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h | 27 +++++++++++++++++++++++++++
 mm/kasan/common.c     | 23 +++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index c5fe303bc1c2..de2a695ad34d 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -212,6 +212,29 @@ static __always_inline void * __must_check kasan_krealloc(const void *object,
 	return (void *)object;
 }
 
+bool __kasan_mempool_poison_pages(struct page *page, unsigned int order,
+				  unsigned long ip);
+/**
+ * kasan_mempool_poison_pages - Check and poison a mempool page allocation.
+ * @page: Pointer to the page allocation.
+ * @order: Order of the allocation.
+ *
+ * This function is intended for kernel subsystems that cache page allocations
+ * to reuse them instead of freeing them back to page_alloc (e.g. mempool).
+ *
+ * This function is similar to kasan_mempool_poison_object() but operates on
+ * page allocations.
+ *
+ * Return: true if the allocation can be safely reused; false otherwise.
+ */
+static __always_inline bool kasan_mempool_poison_pages(struct page *page,
+						       unsigned int order)
+{
+	if (kasan_enabled())
+		return __kasan_mempool_poison_pages(page, order, _RET_IP_);
+	return true;
+}
+
 bool __kasan_mempool_poison_object(void *ptr, unsigned long ip);
 /**
  * kasan_mempool_poison_object - Check and poison a mempool slab allocation.
@@ -326,6 +349,10 @@ static inline void *kasan_krealloc(const void *object, size_t new_size,
 {
 	return (void *)object;
 }
+static inline bool kasan_mempool_poison_pages(struct page *page, unsigned int order)
+{
+	return true;
+}
 static inline bool kasan_mempool_poison_object(void *ptr)
 {
 	return true;
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 033c860afe51..9ccc78b20cf2 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -416,6 +416,29 @@ void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flag
 		return ____kasan_kmalloc(slab->slab_cache, object, size, flags);
 }
 
+bool __kasan_mempool_poison_pages(struct page *page, unsigned int order,
+				  unsigned long ip)
+{
+	unsigned long *ptr;
+
+	if (unlikely(PageHighMem(page)))
+		return true;
+
+	/* Bail out if allocation was excluded due to sampling. */
+	if (!IS_ENABLED(CONFIG_KASAN_GENERIC) &&
+	    page_kasan_tag(page) == KASAN_TAG_KERNEL)
+		return true;
+
+	ptr = page_address(page);
+
+	if (check_page_allocation(ptr, ip))
+		return false;
+
+	kasan_poison(ptr, PAGE_SIZE << order, KASAN_PAGE_FREE, false);
+
+	return true;
+}
+
 bool __kasan_mempool_poison_object(void *ptr, unsigned long ip)
 {
 	struct folio *folio;
-- 
2.25.1

