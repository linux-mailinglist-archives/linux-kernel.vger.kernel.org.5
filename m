Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897A279F00A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjIMRPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjIMRO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:14:59 -0400
Received: from out-218.mta0.migadu.com (out-218.mta0.migadu.com [91.218.175.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFE3DD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:14:53 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694625290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eQriSK20/8KwwHOVdQKhz9C/zLOim8sff0QLVit0F7g=;
        b=XFAMKTE8wAgngJGqU3Ho9bfesOIML66PlRFcmLlbqUwEjvPJBgA62jyh52QZkOwLjDPuzU
        AyQx3wfOttMTFmpwW6FPSwPLuzweuqHN5H2L0Pdvtlpy0XaMKleBiTQWXdXoBao5TkmHyv
        tHA54Ka/Rk4e/x6SqQ17ainnSJdFZLQ=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 03/19] lib/stackdepot: drop valid bit from handles
Date:   Wed, 13 Sep 2023 19:14:28 +0200
Message-Id: <5cbb8235fe6418f970fd0012450defdce598abcf.1694625260.git.andreyknvl@google.com>
In-Reply-To: <cover.1694625260.git.andreyknvl@google.com>
References: <cover.1694625260.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Stack depot doesn't use the valid bit in handles in any way, so drop it.

Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/stackdepot.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 0772125efe8a..482eac40791e 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -32,13 +32,12 @@
 
 #define DEPOT_HANDLE_BITS (sizeof(depot_stack_handle_t) * 8)
 
-#define DEPOT_VALID_BITS 1
 #define DEPOT_POOL_ORDER 2 /* Pool size order, 4 pages */
 #define DEPOT_POOL_SIZE (1LL << (PAGE_SHIFT + DEPOT_POOL_ORDER))
 #define DEPOT_STACK_ALIGN 4
 #define DEPOT_OFFSET_BITS (DEPOT_POOL_ORDER + PAGE_SHIFT - DEPOT_STACK_ALIGN)
-#define DEPOT_POOL_INDEX_BITS (DEPOT_HANDLE_BITS - DEPOT_VALID_BITS - \
-			       DEPOT_OFFSET_BITS - STACK_DEPOT_EXTRA_BITS)
+#define DEPOT_POOL_INDEX_BITS (DEPOT_HANDLE_BITS - DEPOT_OFFSET_BITS - \
+			       STACK_DEPOT_EXTRA_BITS)
 #define DEPOT_POOLS_CAP 8192
 #define DEPOT_MAX_POOLS \
 	(((1LL << (DEPOT_POOL_INDEX_BITS)) < DEPOT_POOLS_CAP) ? \
@@ -50,7 +49,6 @@ union handle_parts {
 	struct {
 		u32 pool_index	: DEPOT_POOL_INDEX_BITS;
 		u32 offset	: DEPOT_OFFSET_BITS;
-		u32 valid	: DEPOT_VALID_BITS;
 		u32 extra	: STACK_DEPOT_EXTRA_BITS;
 	};
 };
@@ -303,7 +301,6 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 	stack->size = size;
 	stack->handle.pool_index = pool_index;
 	stack->handle.offset = pool_offset >> DEPOT_STACK_ALIGN;
-	stack->handle.valid = 1;
 	stack->handle.extra = 0;
 	memcpy(stack->entries, entries, flex_array_size(stack, entries, size));
 	pool_offset += required_size;
-- 
2.25.1

