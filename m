Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A1F7F1B60
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbjKTRrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjKTRre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:47:34 -0500
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5D5BA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:47:30 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700502449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lmg5zTuKt1w9oWZyNpXv7HY69NJCp78Dr+tP0crczmk=;
        b=sig9IVvlHqVaQ7yAjHcKyEBZSXKZVvVyW0FFm1WUvwt3/VhlR8ohBHYAlXrR7cabYtXtPi
        1x7T5BIS3RF5oH+C0wW4PoHF0fJj3mAq0pXEuDuyXI6LIJomNt8wyDqJivUeLox2pQT6re
        fzBBmv3FWure1h0tN/rWvxM6gmS3lDg=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v4 04/22] lib/stackdepot: drop valid bit from handles
Date:   Mon, 20 Nov 2023 18:47:02 +0100
Message-Id: <34969bba2ca6e012c6ad071767197dee64dc5723.1700502145.git.andreyknvl@google.com>
In-Reply-To: <cover.1700502145.git.andreyknvl@google.com>
References: <cover.1700502145.git.andreyknvl@google.com>
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

Stack depot doesn't use the valid bit in handles in any way, so drop it.

Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/stackdepot.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 3e71c8f61c7d..46a422d31c1f 100644
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
@@ -309,7 +307,6 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 	stack->size = size;
 	stack->handle.pool_index = pool_index;
 	stack->handle.offset = pool_offset >> DEPOT_STACK_ALIGN;
-	stack->handle.valid = 1;
 	stack->handle.extra = 0;
 	memcpy(stack->entries, entries, flex_array_size(stack, entries, size));
 	pool_offset += required_size;
-- 
2.25.1

