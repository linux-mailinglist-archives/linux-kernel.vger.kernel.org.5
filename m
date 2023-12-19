Return-Path: <linux-kernel+bounces-6051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD47681939A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C30F1C251D2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88184405CA;
	Tue, 19 Dec 2023 22:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TbFrSJjR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6DA3D0D9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 22:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703025019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hXURpFT5cXmxHd6E+IlRMk2ARDz23DTQrTWld5qdG1E=;
	b=TbFrSJjRFEHr11m9ihb+YpF44WT4zDOU6SR/gpiWxNk2O2ewimYty9RDE8JeT2bHHQsmaJ
	7iHSxvOfzi3HpU9gwdbmyAE7I1nnRqLM1ejSraTyzN977wLeS1qdGvxzBLEl1QotjPd3vl
	vMCPpPc3Z0zUFBC41bC95eXG8vcuwiQ=
From: andrey.konovalov@linux.dev
To: Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	Evgenii Stepanov <eugenis@google.com>,
	Breno Leitao <leitao@debian.org>,
	Alexander Lobakin <alobakin@pm.me>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm 09/21] kasan: save free stack traces for slab mempools
Date: Tue, 19 Dec 2023 23:28:53 +0100
Message-Id: <413a7c7c3344fb56809853339ffaabc9e4905e94.1703024586.git.andreyknvl@google.com>
In-Reply-To: <cover.1703024586.git.andreyknvl@google.com>
References: <cover.1703024586.git.andreyknvl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

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
index 3f4a1ed69e03..59146886e57d 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -207,8 +207,8 @@ void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
 	return (void *)object;
 }
 
-static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
-				unsigned long ip, bool quarantine, bool init)
+static inline bool poison_slab_object(struct kmem_cache *cache, void *object,
+				      unsigned long ip, bool init)
 {
 	void *tagged_object;
 
@@ -221,13 +221,12 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
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
 
@@ -239,19 +238,18 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
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
@@ -472,7 +470,7 @@ bool __kasan_mempool_poison_object(void *ptr, unsigned long ip)
 	}
 
 	slab = folio_slab(folio);
-	return !____kasan_slab_free(slab->slab_cache, ptr, ip, false, false);
+	return !poison_slab_object(slab->slab_cache, ptr, ip, false);
 }
 
 void __kasan_mempool_unpoison_object(void *ptr, size_t size, unsigned long ip)
-- 
2.25.1


