Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B80079F027
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjIMRQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjIMRQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:16:02 -0400
Received: from out-221.mta1.migadu.com (out-221.mta1.migadu.com [95.215.58.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FB498
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:15:57 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694625356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iF8d5PIu0hiypd5p1X1vzHkKz0HhegtzJ4nwY5HqH4s=;
        b=wHA2oEp9M2Png7tDBErdFmtaGLdMmLLdtrI6Au1BGNIa11sMWCsUSSkjE5ssXZQMsf89kF
        /ktIdpIwNBEW+HewSCwtqwLFJguCHnjOmSkrdVpWer6wxYm1qnbAq12KYjmRjrBs1FoPap
        FFJ3/1H7E9nEL5HyfuXogMs6GDWTN4w=
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
Subject: [PATCH v2 09/19] lib/stackdepot: store next pool pointer in new_pool
Date:   Wed, 13 Sep 2023 19:14:34 +0200
Message-Id: <3a7056408e391ff0c66b5f50c460a7b9f796228f.1694625260.git.andreyknvl@google.com>
In-Reply-To: <cover.1694625260.git.andreyknvl@google.com>
References: <cover.1694625260.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Instead of using the last pointer in stack_pools for storing the pointer
to a new pool (which does not yet store any stack records), use a new
new_pool variable.

This a purely code readability change: it seems more logical to store
the pointer to a pool with a special meaning in a dedicated variable.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/stackdepot.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index e428f470faf6..81d8733cdbed 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -85,6 +85,8 @@ static unsigned int stack_hash_mask;
 
 /* Array of memory regions that store stack traces. */
 static void *stack_pools[DEPOT_MAX_POOLS];
+/* Newly allocated pool that is not yet added to stack_pools. */
+static void *new_pool;
 /* Currently used pool in stack_pools. */
 static int pool_index;
 /* Offset to the unused space in the currently used pool. */
@@ -233,7 +235,7 @@ static void depot_keep_new_pool(void **prealloc)
 	 * as long as we do not exceed the maximum number of pools.
 	 */
 	if (pool_index + 1 < DEPOT_MAX_POOLS) {
-		stack_pools[pool_index + 1] = *prealloc;
+		new_pool = *prealloc;
 		*prealloc = NULL;
 	}
 
@@ -263,6 +265,8 @@ static bool depot_update_pools(size_t required_size, void **prealloc)
 		 * stack_depot_fetch.
 		 */
 		WRITE_ONCE(pool_index, pool_index + 1);
+		stack_pools[pool_index] = new_pool;
+		new_pool = NULL;
 		pool_offset = 0;
 
 		/*
-- 
2.25.1

