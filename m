Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1527D3C4E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbjJWQXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbjJWQXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:23:10 -0400
Received: from out-197.mta0.migadu.com (out-197.mta0.migadu.com [91.218.175.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267C6FF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:23:07 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698078180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bMe0IukHdtXUzp2BGVWle8stWPjWZ8/o4+6QYAoowVk=;
        b=rkq81ZIHIptQkPMqAJh4zbGsz6Tf/Km8HtCA+J1L5FmEVUWRXZFPtR3mYiLwbXzLU1ve+m
        ipP9E4g9fFYH2AhD85YBltaGTWSFkAJKRvJkJTSAujCAdfb7pv+ffb4OXZf2EtpweYEmBM
        QWsHiUJVDHj2Hr+JhC9QlyMPSRnLRJ0=
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
Subject: [PATCH v3 05/19] lib/stackdepot: use fixed-sized slots for stack records
Date:   Mon, 23 Oct 2023 18:22:36 +0200
Message-Id: <4340f57fa82fde81e00f64f98d69ee4a5d5ed9a8.1698077459.git.andreyknvl@google.com>
In-Reply-To: <cover.1698077459.git.andreyknvl@google.com>
References: <cover.1698077459.git.andreyknvl@google.com>
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

Instead of storing stack records in stack depot pools one right after
another, use fixed-sized slots.

Add a new Kconfig option STACKDEPOT_MAX_FRAMES that allows to select
the size of the slot in frames. Use 64 as the default value, which is
the maximum stack trace size both KASAN and KMSAN use right now.

Also add descriptions for other stack depot Kconfig options.

This is preparatory patch for implementing the eviction of stack records
from the stack depot.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v2->v3:
- Keep previously existing Kconfig options not configurable by users.

Changes v1->v2:
- Add and use STACKDEPOT_MAX_FRAMES Kconfig option.
---
 lib/Kconfig      | 10 ++++++++++
 lib/stackdepot.c | 13 +++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index c686f4adc124..5f3fa3659fa9 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -710,10 +710,20 @@ config ARCH_STACKWALK
 config STACKDEPOT
 	bool
 	select STACKTRACE
+	help
+	  Stack depot: stack trace storage that avoids duplication
 
 config STACKDEPOT_ALWAYS_INIT
 	bool
 	select STACKDEPOT
+	help
+	  Always initialize stack depot during early boot
+
+config STACKDEPOT_MAX_FRAMES
+	int "Maximum number of frames in trace saved in stack depot"
+	range 1 256
+	default 64
+	depends on STACKDEPOT
 
 config REF_TRACKER
 	bool
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 9a004f15f59d..128ece21afe9 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -58,9 +58,12 @@ struct stack_record {
 	u32 hash;			/* Hash in the hash table */
 	u32 size;			/* Number of stored frames */
 	union handle_parts handle;
-	unsigned long entries[];	/* Variable-sized array of frames */
+	unsigned long entries[CONFIG_STACKDEPOT_MAX_FRAMES];	/* Frames */
 };
 
+#define DEPOT_STACK_RECORD_SIZE \
+	ALIGN(sizeof(struct stack_record), 1 << DEPOT_STACK_ALIGN)
+
 static bool stack_depot_disabled;
 static bool __stack_depot_early_init_requested __initdata = IS_ENABLED(CONFIG_STACKDEPOT_ALWAYS_INIT);
 static bool __stack_depot_early_init_passed __initdata;
@@ -258,9 +261,7 @@ static struct stack_record *
 depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 {
 	struct stack_record *stack;
-	size_t required_size = struct_size(stack, entries, size);
-
-	required_size = ALIGN(required_size, 1 << DEPOT_STACK_ALIGN);
+	size_t required_size = DEPOT_STACK_RECORD_SIZE;
 
 	/* Check if there is not enough space in the current pool. */
 	if (unlikely(pool_offset + required_size > DEPOT_POOL_SIZE)) {
@@ -295,6 +296,10 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 	if (stack_pools[pool_index] == NULL)
 		return NULL;
 
+	/* Limit number of saved frames to CONFIG_STACKDEPOT_MAX_FRAMES. */
+	if (size > CONFIG_STACKDEPOT_MAX_FRAMES)
+		size = CONFIG_STACKDEPOT_MAX_FRAMES;
+
 	/* Save the stack trace. */
 	stack = stack_pools[pool_index] + pool_offset;
 	stack->hash = hash;
-- 
2.25.1

