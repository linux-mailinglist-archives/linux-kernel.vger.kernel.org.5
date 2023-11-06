Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF7C7E2DC2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbjKFUKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjKFUKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:10:40 -0500
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D5A10C0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:10:37 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699301435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nDVhwjjwJnVTlqgIL3b0i6xOOMbmQ8bjgeF5HzBvdls=;
        b=Z07E7O2SjDMyBRw/gSN9ci3NIZpunAPyyaCA7cmKpuMNMpB9/xhAR5qE7hyZk1t7jX+DKx
        14Ptj42a2mWVBNIixSLaxs56Zs4E+ThuwbFOTv55BULKHRjR18asj8U8MJh/Z0FNeXZws6
        6EI38tuAtGntOeBhrd01a+m6ax6bdrc=
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
Subject: [PATCH RFC 03/20] kasan: document kasan_mempool_poison_object
Date:   Mon,  6 Nov 2023 21:10:12 +0100
Message-Id: <e0c319c2033685fc25765af45d5b75224c15721e.1699297309.git.andreyknvl@google.com>
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

Add documentation comment for kasan_mempool_poison_object.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 0d1f925c136d..bbf6e2fa4ffd 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -213,6 +213,24 @@ static __always_inline void * __must_check kasan_krealloc(const void *object,
 }
 
 void __kasan_mempool_poison_object(void *ptr, unsigned long ip);
+/**
+ * kasan_mempool_poison_object - Check and poison a mempool slab allocation.
+ * @ptr: Pointer to the slab allocation.
+ *
+ * This function is intended for kernel subsystems that cache slab allocations
+ * to reuse them instead of freeing them back to the slab allocator (e.g.
+ * mempool).
+ *
+ * This function poisons a slab allocation without initializing its memory and
+ * without putting it into the quarantine (for the Generic mode).
+ *
+ * This function also performs checks to detect double-free and invalid-free
+ * bugs and reports them.
+ *
+ * This function operates on all slab allocations including large kmalloc
+ * allocations (the ones returned by kmalloc_large() or by kmalloc() with the
+ * size > KMALLOC_MAX_SIZE).
+ */
 static __always_inline void kasan_mempool_poison_object(void *ptr)
 {
 	if (kasan_enabled())
-- 
2.25.1

