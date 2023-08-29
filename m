Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D9C78CA7B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237686AbjH2ROu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237703AbjH2ROV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:14:21 -0400
Received: from out-244.mta1.migadu.com (out-244.mta1.migadu.com [IPv6:2001:41d0:203:375::f4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C31FCEE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:13:49 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693329223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SXcX5gR3dSvkxNFtne9AIJ3MreGstDXokl9zt3D1S94=;
        b=h6llS9CHe5RoqXvZREMQb8iyAp/Kb6KqjJZ0snmlmlR4rFM6dED6F0JcGGQU+5vqbXo8HX
        elNoG7XJ6jnDUln2rKKJ4l8c8KxNHcrBz76e+Dr/1x/lSC9m6R4ZN8FJDGgM6G/w4Breap
        7U2QWpyTEl7oegpOYYamAOWgDo9QJW0=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 12/15] stackdepot: add refcount for records
Date:   Tue, 29 Aug 2023 19:11:22 +0200
Message-Id: <306aeddcd3c01f432d308043c382669e5f63b395.1693328501.git.andreyknvl@google.com>
In-Reply-To: <cover.1693328501.git.andreyknvl@google.com>
References: <cover.1693328501.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Add a reference counter for how many times a stack records has been added
to stack depot.

Do no yet decrement the refcount, this is implemented in one of the
following patches.

This is preparatory patch for implementing the eviction of stack records
from the stack depot.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/stackdepot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 5ad454367379..a84c0debbb9e 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -22,6 +22,7 @@
 #include <linux/mutex.h>
 #include <linux/percpu.h>
 #include <linux/printk.h>
+#include <linux/refcount.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/stacktrace.h>
@@ -60,6 +61,7 @@ struct stack_record {
 	u32 hash;			/* Hash in hash table */
 	u32 size;			/* Number of stored frames */
 	union handle_parts handle;
+	refcount_t count;
 	unsigned long entries[DEPOT_STACK_MAX_FRAMES];	/* Frames */
 };
 
@@ -348,6 +350,7 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 	stack->hash = hash;
 	stack->size = size;
 	/* stack->handle is already filled in by depot_init_pool. */
+	refcount_set(&stack->count, 1);
 	memcpy(stack->entries, entries, flex_array_size(stack, entries, size));
 
 	/*
@@ -452,6 +455,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 	/* Fast path: look the stack trace up without full locking. */
 	found = find_stack(*bucket, entries, nr_entries, hash);
 	if (found) {
+		refcount_inc(&found->count);
 		read_unlock_irqrestore(&pool_rwlock, flags);
 		goto exit;
 	}
-- 
2.25.1

