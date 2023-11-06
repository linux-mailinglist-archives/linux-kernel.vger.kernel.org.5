Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FBC7E2DCE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjKFULs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbjKFULp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:11:45 -0500
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A84E10CC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:11:42 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699301500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=22d9hHWXVi8zazHV61QMl0VMY5WvMEtggwgAvi4OURE=;
        b=uCxP18KqioH8DesdZGPrQhB9iAWKsetIiyp+iZWAll3HfZniU6A5CfSfVvg/YBXwUWgOgp
        g7au6m059IPietJorP9ETACRyTK+wluf8gUh/M/fKwcPWO9JGxfNf9EdEiOA8l56yCB+on
        SoSVmK/iZ+6LRI96vDxmC3Xr0mWe7BI=
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
Subject: [PATCH RFC 09/20] kasan: save free stack traces for slab mempools
Date:   Mon,  6 Nov 2023 21:10:18 +0100
Message-Id: <52d80b4c1d42b10b6c2c3cba57b628a88cb58e03.1699297309.git.andreyknvl@google.com>
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

Make kasan_mempool_poison_object save free stack traces for slab and
kmalloc mempools when the object is freed into the mempool.

Also simplify and rename ____kasan_slab_free to poison_slab_object and
do a few other reability changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h |  5 +++--
 mm/kasan/common.c     | 20 +++++++++-----------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index f8ebde384bd7..e636a00e26ba 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -268,8 +268,9 @@ bool __kasan_mempool_poison_object(void *ptr, unsigned long ip);
  * to reuse them instead of freeing them back to the slab allocator (e.g.
  * mempool).
  *
- * This function poisons a slab allocation without initializing its memory and
- * without putting it into the quarantine (for the Generic mode).
+ * This function poisons a slab allocation and saves a free stack trace for it
+ * without initializing the allocation's memory and without putting it into the
+ * quarantine (for the Generic mode).
  *
  * This function also performs checks to detect double-free and invalid-free
  * bugs and reports them. The caller can use the return value of this function
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 7c28d0a5af2c..683d0dad32f2 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -197,8 +197,8 @@ void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
 	return (void *)object;
 }
 
-static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
-				unsigned long ip, bool quarantine, bool init)
+static inline bool poison_slab_object(struct kmem_cache *cache, void *object,
+				      unsigned long ip, bool init)
 {
 	void *tagged_object;
 
@@ -211,13 +211,12 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
 	if (is_kfence_address(object))
 		return false;
 
-	if (unlikely(nearest_obj(cache, virt_to_slab(object), object) !=
-	    object)) {
+	if (unlikely(nearest_obj(cache, virt_to_slab(object), object) != object)) {
 		kasan_report_invalid_free(tagged_object, ip, KASAN_REPORT_INVALID_FREE);
 		return true;
 	}
 
-	/* RCU slabs could be legally used after free within the RCU period */
+	/* RCU slabs could be legally used after free within the RCU period. */
 	if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU))
 		return false;
 
@@ -229,19 +228,18 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
 	kasan_poison(object, round_up(cache->object_size, KASAN_GRANULE_SIZE),
 			KASAN_SLAB_FREE, init);
 
-	if ((IS_ENABLED(CONFIG_KASAN_GENERIC) && !quarantine))
-		return false;
-
 	if (kasan_stack_collection_enabled())
 		kasan_save_free_info(cache, tagged_object);
 
-	return kasan_quarantine_put(cache, object);
+	return false;
 }
 
 bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 				unsigned long ip, bool init)
 {
-	return ____kasan_slab_free(cache, object, ip, true, init);
+	bool buggy_object = poison_slab_object(cache, object, ip, init);
+
+	return buggy_object ? true : kasan_quarantine_put(cache, object);
 }
 
 static inline bool check_page_allocation(void *ptr, unsigned long ip)
@@ -462,7 +460,7 @@ bool __kasan_mempool_poison_object(void *ptr, unsigned long ip)
 	}
 
 	slab = folio_slab(folio);
-	return !____kasan_slab_free(slab->slab_cache, ptr, ip, false, false);
+	return !poison_slab_object(slab->slab_cache, ptr, ip, false);
 }
 
 void __kasan_mempool_unpoison_object(void *ptr, size_t size, unsigned long ip)
-- 
2.25.1

