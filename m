Return-Path: <linux-kernel+bounces-6046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDEC81938E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5CF1F24167
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514E241234;
	Tue, 19 Dec 2023 22:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F86/EPhH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A073D0C1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 22:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703024954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DO8tjmS9YVd+JQvWum2ppGekXJiIG6c57s1H7fN9b9c=;
	b=F86/EPhH4w6/WbWrDENKsFnnUYgyTxWsWcPGWpBY23pYkD6fHfvr174y/cag/gCnwWPUSr
	5v6xLH4KEmbEYh1Enf/9T6dx3MnCR1H0deL92bZhphAwsZ5re8vi40q1doi4AozQsFx4SP
	8eXPaY9dqKTzvnqybENGUX0YdLOqPQA=
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
Subject: [PATCH mm 05/21] kasan: introduce kasan_mempool_unpoison_object
Date: Tue, 19 Dec 2023 23:28:49 +0100
Message-Id: <dae25f0e18ed8fd50efe509c5b71a0592de5c18d.1703024586.git.andreyknvl@google.com>
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

Introduce and document a kasan_mempool_unpoison_object hook.

This hook serves as a replacement for the generic kasan_unpoison_range
that the mempool code relies on right now. mempool will be updated to use
the new hook in one of the following patches.

For now, define the new hook to be identical to kasan_unpoison_range.
One of the following patches will update it to add stack trace
collection.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h | 31 +++++++++++++++++++++++++++++++
 mm/kasan/common.c     |  5 +++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 33387e254caa..c5fe303bc1c2 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -228,6 +228,9 @@ bool __kasan_mempool_poison_object(void *ptr, unsigned long ip);
  * bugs and reports them. The caller can use the return value of this function
  * to find out if the allocation is buggy.
  *
+ * Before the poisoned allocation can be reused, it must be unpoisoned via
+ * kasan_mempool_unpoison_object().
+ *
  * This function operates on all slab allocations including large kmalloc
  * allocations (the ones returned by kmalloc_large() or by kmalloc() with the
  * size > KMALLOC_MAX_SIZE).
@@ -241,6 +244,32 @@ static __always_inline bool kasan_mempool_poison_object(void *ptr)
 	return true;
 }
 
+void __kasan_mempool_unpoison_object(void *ptr, size_t size, unsigned long ip);
+/**
+ * kasan_mempool_unpoison_object - Unpoison a mempool slab allocation.
+ * @ptr: Pointer to the slab allocation.
+ * @size: Size to be unpoisoned.
+ *
+ * This function is intended for kernel subsystems that cache slab allocations
+ * to reuse them instead of freeing them back to the slab allocator (e.g.
+ * mempool).
+ *
+ * This function unpoisons a slab allocation that was previously poisoned via
+ * kasan_mempool_poison_object() without initializing its memory. For the
+ * tag-based modes, this function does not assign a new tag to the allocation
+ * and instead restores the original tags based on the pointer value.
+ *
+ * This function operates on all slab allocations including large kmalloc
+ * allocations (the ones returned by kmalloc_large() or by kmalloc() with the
+ * size > KMALLOC_MAX_SIZE).
+ */
+static __always_inline void kasan_mempool_unpoison_object(void *ptr,
+							  size_t size)
+{
+	if (kasan_enabled())
+		__kasan_mempool_unpoison_object(ptr, size, _RET_IP_);
+}
+
 /*
  * Unlike kasan_check_read/write(), kasan_check_byte() is performed even for
  * the hardware tag-based mode that doesn't rely on compiler instrumentation.
@@ -301,6 +330,8 @@ static inline bool kasan_mempool_poison_object(void *ptr)
 {
 	return true;
 }
+static inline void kasan_mempool_unpoison_object(void *ptr, size_t size) {}
+
 static inline bool kasan_check_byte(const void *address)
 {
 	return true;
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 2b4869de4985..4b85d35bb8ab 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -451,6 +451,11 @@ bool __kasan_mempool_poison_object(void *ptr, unsigned long ip)
 	}
 }
 
+void __kasan_mempool_unpoison_object(void *ptr, size_t size, unsigned long ip)
+{
+	kasan_unpoison(ptr, size, false);
+}
+
 bool __kasan_check_byte(const void *address, unsigned long ip)
 {
 	if (!kasan_byte_accessible(address)) {
-- 
2.25.1


