Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89567E2DC1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbjKFUKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjKFUKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:10:40 -0500
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AA310C1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:10:37 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699301436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hi9wxEG5hyOM24yVF5pvgyGm+UDfsaiMZW2KqzysWxs=;
        b=mSKMvKXcLKjjTcyMkClrC36gOqKSe1PvNKyag40bJ4xtUzbPDJFYH5kFaBHKeVRgaBbWYV
        GIZXX51aID/GYcIpaL4fQ+N0sAMZRrmnx9/AYcnXe7Vz4JkkXEyYOmwLRJOMKQdsT311zO
        FHVzZWec6HA/wWLZY3SvOuHIPVsbkv8=
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
Subject: [PATCH RFC 04/20] kasan: add return value for kasan_mempool_poison_object
Date:   Mon,  6 Nov 2023 21:10:13 +0100
Message-Id: <673406599a04fc9ea0111dac01ae9c84f9a01524.1699297309.git.andreyknvl@google.com>
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

Add a return value for kasan_mempool_poison_object that lets the caller
know whether the allocation is affected by a double-free or an
invalid-free bug. The caller can use this return value to stop operating
on the object.

Also introduce a check_page_allocation helper function to improve the
code readability.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h | 17 ++++++++++++-----
 mm/kasan/common.c     | 21 ++++++++++-----------
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index bbf6e2fa4ffd..33387e254caa 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -212,7 +212,7 @@ static __always_inline void * __must_check kasan_krealloc(const void *object,
 	return (void *)object;
 }
 
-void __kasan_mempool_poison_object(void *ptr, unsigned long ip);
+bool __kasan_mempool_poison_object(void *ptr, unsigned long ip);
 /**
  * kasan_mempool_poison_object - Check and poison a mempool slab allocation.
  * @ptr: Pointer to the slab allocation.
@@ -225,16 +225,20 @@ void __kasan_mempool_poison_object(void *ptr, unsigned long ip);
  * without putting it into the quarantine (for the Generic mode).
  *
  * This function also performs checks to detect double-free and invalid-free
- * bugs and reports them.
+ * bugs and reports them. The caller can use the return value of this function
+ * to find out if the allocation is buggy.
  *
  * This function operates on all slab allocations including large kmalloc
  * allocations (the ones returned by kmalloc_large() or by kmalloc() with the
  * size > KMALLOC_MAX_SIZE).
+ *
+ * Return: true if the allocation can be safely reused; false otherwise.
  */
-static __always_inline void kasan_mempool_poison_object(void *ptr)
+static __always_inline bool kasan_mempool_poison_object(void *ptr)
 {
 	if (kasan_enabled())
-		__kasan_mempool_poison_object(ptr, _RET_IP_);
+		return __kasan_mempool_poison_object(ptr, _RET_IP_);
+	return true;
 }
 
 /*
@@ -293,7 +297,10 @@ static inline void *kasan_krealloc(const void *object, size_t new_size,
 {
 	return (void *)object;
 }
-static inline void kasan_mempool_poison_object(void *ptr) {}
+static inline bool kasan_mempool_poison_object(void *ptr)
+{
+	return true;
+}
 static inline bool kasan_check_byte(const void *address)
 {
 	return true;
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 69f4c66f0da3..087f93629132 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -244,7 +244,7 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 	return ____kasan_slab_free(cache, object, ip, true, init);
 }
 
-static inline bool ____kasan_kfree_large(void *ptr, unsigned long ip)
+static inline bool check_page_allocation(void *ptr, unsigned long ip)
 {
 	if (!kasan_arch_is_ready())
 		return false;
@@ -259,17 +259,14 @@ static inline bool ____kasan_kfree_large(void *ptr, unsigned long ip)
 		return true;
 	}
 
-	/*
-	 * The object will be poisoned by kasan_poison_pages() or
-	 * kasan_mempool_poison_object().
-	 */
-
 	return false;
 }
 
 void __kasan_kfree_large(void *ptr, unsigned long ip)
 {
-	____kasan_kfree_large(ptr, ip);
+	check_page_allocation(ptr, ip);
+
+	/* The object will be poisoned by kasan_poison_pages(). */
 }
 
 void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
@@ -419,7 +416,7 @@ void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flag
 		return ____kasan_kmalloc(slab->slab_cache, object, size, flags);
 }
 
-void __kasan_mempool_poison_object(void *ptr, unsigned long ip)
+bool __kasan_mempool_poison_object(void *ptr, unsigned long ip)
 {
 	struct folio *folio;
 
@@ -432,13 +429,15 @@ void __kasan_mempool_poison_object(void *ptr, unsigned long ip)
 	 * KMALLOC_MAX_SIZE, and kmalloc falls back onto page_alloc.
 	 */
 	if (unlikely(!folio_test_slab(folio))) {
-		if (____kasan_kfree_large(ptr, ip))
-			return;
+		if (check_page_allocation(ptr, ip))
+			return false;
 		kasan_poison(ptr, folio_size(folio), KASAN_PAGE_FREE, false);
+		return true;
 	} else {
 		struct slab *slab = folio_slab(folio);
 
-		____kasan_slab_free(slab->slab_cache, ptr, ip, false, false);
+		return !____kasan_slab_free(slab->slab_cache, ptr, ip,
+						false, false);
 	}
 }
 
-- 
2.25.1

