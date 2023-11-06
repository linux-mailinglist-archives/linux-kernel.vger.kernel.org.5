Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7CE7E2DC5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjKFUKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjKFUKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:10:41 -0500
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C7210C2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:10:38 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699301436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VrpDyLzZeYtu1H7+z0aR/HPyxv+dwo0N2+jHNRcNovg=;
        b=IRiR9duyySKTYMlcSCduunnoFku2ROSf7vVls3D3d5l3t64Tp6PJw5Tzev1W2QXnSS/iWi
        scQl4qOULKDYkIq8kuBLwHryMfjiAPS/Y+ufLRnA9LEHL20nZi55MDGuAm5yVuXtUNIc/i
        InULrYEGV1Mdxdx3Gw/YrKrgNHW65dM=
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
Subject: [PATCH RFC 05/20] kasan: introduce kasan_mempool_unpoison_object
Date:   Mon,  6 Nov 2023 21:10:14 +0100
Message-Id: <6b096bcf531f457b13959ea99b1e270b96d5ca34.1699297309.git.andreyknvl@google.com>
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
index 087f93629132..033c860afe51 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -441,6 +441,11 @@ bool __kasan_mempool_poison_object(void *ptr, unsigned long ip)
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

