Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD6378CA77
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237757AbjH2RNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237723AbjH2RM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:12:56 -0400
Received: from out-243.mta1.migadu.com (out-243.mta1.migadu.com [IPv6:2001:41d0:203:375::f3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD261CDF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:12:42 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693329161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MjxW8cEdQiVOI1Uv8f/KLmoitLM15XxpvrzjQCh/NXc=;
        b=tY6t+d+vBtGNax4kT5p4Y7yBgtMWSnu/QUCRoJmsSpGYGi+JfvAHktxIuYT65MqPmBkvxp
        8RKOWRZXFpn759z55PlIk/UrGpleF+qwN8UTuRs6xh3eea3xHUbqZVYdzJbVmPrc/bwhgG
        rJ4DhJcJpXlAotO4gn30Fc2AmkPTb4c=
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
Subject: [PATCH 09/15] stackdepot: store next pool pointer in new_pool
Date:   Tue, 29 Aug 2023 19:11:19 +0200
Message-Id: <f612aaa765d653e0f2c64fdb39adb1190b10a762.1693328501.git.andreyknvl@google.com>
In-Reply-To: <cover.1693328501.git.andreyknvl@google.com>
References: <cover.1693328501.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 11934ea3b1c2..5982ea79939d 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -86,6 +86,8 @@ static unsigned int stack_hash_mask;
 
 /* Array of memory regions that store stack traces. */
 static void *stack_pools[DEPOT_MAX_POOLS];
+/* Newly allocated pool that is not yet added to stack_pools. */
+static void *new_pool;
 /* Currently used pool in stack_pools. */
 static int pool_index;
 /* Offset to the unused space in the currently used pool. */
@@ -236,7 +238,7 @@ static void depot_keep_new_pool(void **prealloc)
 	 * as long as we do not exceed the maximum number of pools.
 	 */
 	if (pool_index + 1 < DEPOT_MAX_POOLS) {
-		stack_pools[pool_index + 1] = *prealloc;
+		new_pool = *prealloc;
 		*prealloc = NULL;
 	}
 
@@ -266,6 +268,8 @@ static bool depot_update_pools(size_t required_size, void **prealloc)
 		 * stack_depot_fetch.
 		 */
 		WRITE_ONCE(pool_index, pool_index + 1);
+		stack_pools[pool_index] = new_pool;
+		new_pool = NULL;
 		pool_offset = 0;
 
 		/*
-- 
2.25.1

