Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AC478CA7E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237745AbjH2ROx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237767AbjH2ROh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:14:37 -0400
Received: from out-250.mta1.migadu.com (out-250.mta1.migadu.com [IPv6:2001:41d0:203:375::fa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4F81BD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:14:00 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693329225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nl/mi/sJhm8d2IDMyyx9SK432XHk6oEEQ1PTooRDAe8=;
        b=GlaqijiJCNuxG7rw/crBXwYIu+bsbRgtfNjI15SsNv8t1sbXPGyc+8Qf9Y8QvqLJiZuTi7
        ZNtWdGIvQFFzknC6Cszo4DXXBT6fdVhnEoWLc28FUoQtxU/76o7hIYC2gdCczCKWh6/THq
        P/TGvd/MEaLMkz+3R7oGxuH+BvdITeQ=
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
Subject: [PATCH 15/15] kasan: use stack_depot_evict for tag-based modes
Date:   Tue, 29 Aug 2023 19:11:25 +0200
Message-Id: <f7ab7ad4013669f25808bb0e39b3613b98189063.1693328501.git.andreyknvl@google.com>
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

Evict stack traces from the stack depot for the tag-based KASAN modes
once they are evicted from the stack ring.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/tags.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index 7dcfe341d48e..fa6b0f77a7dd 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -96,7 +96,7 @@ static void save_stack_info(struct kmem_cache *cache, void *object,
 			gfp_t gfp_flags, bool is_free)
 {
 	unsigned long flags;
-	depot_stack_handle_t stack;
+	depot_stack_handle_t stack, old_stack;
 	u64 pos;
 	struct kasan_stack_ring_entry *entry;
 	void *old_ptr;
@@ -120,6 +120,8 @@ static void save_stack_info(struct kmem_cache *cache, void *object,
 	if (!try_cmpxchg(&entry->ptr, &old_ptr, STACK_RING_BUSY_PTR))
 		goto next; /* Busy slot. */
 
+	old_stack = READ_ONCE(entry->stack);
+
 	WRITE_ONCE(entry->size, cache->object_size);
 	WRITE_ONCE(entry->pid, current->pid);
 	WRITE_ONCE(entry->stack, stack);
@@ -131,6 +133,9 @@ static void save_stack_info(struct kmem_cache *cache, void *object,
 	smp_store_release(&entry->ptr, (s64)object);
 
 	read_unlock_irqrestore(&stack_ring.lock, flags);
+
+	if (old_stack)
+		stack_depot_evict(old_stack);
 }
 
 void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
-- 
2.25.1

