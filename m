Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AC77F1B95
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbjKTRvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbjKTRvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:51:24 -0500
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C69D5F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:50:45 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700502644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qc2DDhk7eSddbt2Q3kjJLSbCNGbLZWOl9JsGZF81sG4=;
        b=SjlBdcCRByh5PrG2MOhc8aFxhKI3iaDpNaxTHUEIaJyLo5jT4ZNFXt6Bt3sd9u50OfOKSg
        CaLcy9JTN+VHkT3VWRZiUR5iYfkV9u6uxcxdsNTqWTVW/b0iVcXorrCGAHL4XcSBww8rJU
        PD/hyomJcMBAWfjY4j+0VCD4sMN1M4g=
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
Subject: [PATCH v4 20/22] kasan: use stack_depot_put for tag-based modes
Date:   Mon, 20 Nov 2023 18:47:18 +0100
Message-Id: <b4773e5c1b0b9df6826ec0b65c1923feadfa78e5.1700502145.git.andreyknvl@google.com>
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

Make tag-based KASAN modes evict stack traces from the stack depot once
they are evicted from the stack ring.

Internally, pass STACK_DEPOT_FLAG_GET to stack_depot_save_flags (via
kasan_save_stack) to increment the refcount when saving a new entry
to stack ring and call stack_depot_put when removing an entry from
stack ring.

Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v1->v2:
- Adapt to the stack depot API change.
- Drop READ_ONCE when reading entry->stack.
---
 mm/kasan/tags.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index b6c017e670d8..739ae997463d 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -97,12 +97,13 @@ static void save_stack_info(struct kmem_cache *cache, void *object,
 			gfp_t gfp_flags, bool is_free)
 {
 	unsigned long flags;
-	depot_stack_handle_t stack;
+	depot_stack_handle_t stack, old_stack;
 	u64 pos;
 	struct kasan_stack_ring_entry *entry;
 	void *old_ptr;
 
-	stack = kasan_save_stack(gfp_flags, STACK_DEPOT_FLAG_CAN_ALLOC);
+	stack = kasan_save_stack(gfp_flags,
+			STACK_DEPOT_FLAG_CAN_ALLOC | STACK_DEPOT_FLAG_GET);
 
 	/*
 	 * Prevent save_stack_info() from modifying stack ring
@@ -121,6 +122,8 @@ static void save_stack_info(struct kmem_cache *cache, void *object,
 	if (!try_cmpxchg(&entry->ptr, &old_ptr, STACK_RING_BUSY_PTR))
 		goto next; /* Busy slot. */
 
+	old_stack = entry->stack;
+
 	entry->size = cache->object_size;
 	entry->pid = current->pid;
 	entry->stack = stack;
@@ -129,6 +132,9 @@ static void save_stack_info(struct kmem_cache *cache, void *object,
 	entry->ptr = object;
 
 	read_unlock_irqrestore(&stack_ring.lock, flags);
+
+	if (old_stack)
+		stack_depot_put(old_stack);
 }
 
 void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
-- 
2.25.1

