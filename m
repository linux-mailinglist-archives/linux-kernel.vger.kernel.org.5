Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137BF7F1B99
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbjKTRwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbjKTRv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:51:26 -0500
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919A4D70
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:50:46 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700502644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RvoTVlNH/9QJKGjG7ts3ES/7xJIaYyT0JIUdEPtk5OM=;
        b=DNgy9uYyYrfck71UIDDMmeBlP2Bik/eXdRS59wwnt2UBuC9bsjPHLcrxPmB7E98KHzUlfS
        OnFiyTSIdvZJFlR6bvb819vsoHa3zDRv09EFK0vHzurXdv2QeiuJeuOu21i9cfXyy/okM9
        r0Wi2UF4LVMIbr0H8VW9kEyPJyGdVBE=
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
Subject: [PATCH v4 21/22] kasan: use stack_depot_put for Generic mode
Date:   Mon, 20 Nov 2023 18:47:19 +0100
Message-Id: <5cef104d9b842899489b4054fe8d1339a71acee0.1700502145.git.andreyknvl@google.com>
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

Evict alloc/free stack traces from the stack depot for Generic KASAN
once they are evicted from the quaratine.

For auxiliary stack traces, evict the oldest stack trace once a new one
is saved (KASAN only keeps references to the last two).

Also evict all saved stack traces on krealloc.

To avoid double-evicting and mis-evicting stack traces (in case KASAN's
metadata was corrupted), reset KASAN's per-object metadata that stores
stack depot handles when the object is initialized and when it's evicted
from the quarantine.

Note that stack_depot_put is no-op if the handle is 0.

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c     |  3 ++-
 mm/kasan/generic.c    | 22 ++++++++++++++++++----
 mm/kasan/quarantine.c | 26 ++++++++++++++++++++------
 3 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 825a0240ec02..b5d8bd26fced 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -50,7 +50,8 @@ depot_stack_handle_t kasan_save_stack(gfp_t flags, depot_flags_t depot_flags)
 void kasan_set_track(struct kasan_track *track, gfp_t flags)
 {
 	track->pid = current->pid;
-	track->stack = kasan_save_stack(flags, STACK_DEPOT_FLAG_CAN_ALLOC);
+	track->stack = kasan_save_stack(flags,
+			STACK_DEPOT_FLAG_CAN_ALLOC | STACK_DEPOT_FLAG_GET);
 }
 
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 5d168c9afb32..50cc519e23f4 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -449,10 +449,14 @@ struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
 void kasan_init_object_meta(struct kmem_cache *cache, const void *object)
 {
 	struct kasan_alloc_meta *alloc_meta;
+	struct kasan_free_meta *free_meta;
 
 	alloc_meta = kasan_get_alloc_meta(cache, object);
 	if (alloc_meta)
 		__memset(alloc_meta, 0, sizeof(*alloc_meta));
+	free_meta = kasan_get_free_meta(cache, object);
+	if (free_meta)
+		__memset(free_meta, 0, sizeof(*free_meta));
 }
 
 size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object)
@@ -489,18 +493,20 @@ static void __kasan_record_aux_stack(void *addr, depot_flags_t depot_flags)
 	if (!alloc_meta)
 		return;
 
+	stack_depot_put(alloc_meta->aux_stack[1]);
 	alloc_meta->aux_stack[1] = alloc_meta->aux_stack[0];
 	alloc_meta->aux_stack[0] = kasan_save_stack(0, depot_flags);
 }
 
 void kasan_record_aux_stack(void *addr)
 {
-	return __kasan_record_aux_stack(addr, STACK_DEPOT_FLAG_CAN_ALLOC);
+	return __kasan_record_aux_stack(addr,
+			STACK_DEPOT_FLAG_CAN_ALLOC | STACK_DEPOT_FLAG_GET);
 }
 
 void kasan_record_aux_stack_noalloc(void *addr)
 {
-	return __kasan_record_aux_stack(addr, 0);
+	return __kasan_record_aux_stack(addr, STACK_DEPOT_FLAG_GET);
 }
 
 void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
@@ -508,8 +514,16 @@ void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
 	struct kasan_alloc_meta *alloc_meta;
 
 	alloc_meta = kasan_get_alloc_meta(cache, object);
-	if (alloc_meta)
-		kasan_set_track(&alloc_meta->alloc_track, flags);
+	if (!alloc_meta)
+		return;
+
+	/* Evict previous stack traces (might exist for krealloc). */
+	stack_depot_put(alloc_meta->alloc_track.stack);
+	stack_depot_put(alloc_meta->aux_stack[0]);
+	stack_depot_put(alloc_meta->aux_stack[1]);
+	__memset(alloc_meta, 0, sizeof(*alloc_meta));
+
+	kasan_set_track(&alloc_meta->alloc_track, flags);
 }
 
 void kasan_save_free_info(struct kmem_cache *cache, void *object)
diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index ca4529156735..265ca2bbe2dd 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -143,11 +143,22 @@ static void *qlink_to_object(struct qlist_node *qlink, struct kmem_cache *cache)
 static void qlink_free(struct qlist_node *qlink, struct kmem_cache *cache)
 {
 	void *object = qlink_to_object(qlink, cache);
-	struct kasan_free_meta *meta = kasan_get_free_meta(cache, object);
+	struct kasan_alloc_meta *alloc_meta = kasan_get_alloc_meta(cache, object);
+	struct kasan_free_meta *free_meta = kasan_get_free_meta(cache, object);
 	unsigned long flags;
 
-	if (IS_ENABLED(CONFIG_SLAB))
-		local_irq_save(flags);
+	if (alloc_meta) {
+		stack_depot_put(alloc_meta->alloc_track.stack);
+		stack_depot_put(alloc_meta->aux_stack[0]);
+		stack_depot_put(alloc_meta->aux_stack[1]);
+		__memset(alloc_meta, 0, sizeof(*alloc_meta));
+	}
+
+	if (free_meta &&
+	    *(u8 *)kasan_mem_to_shadow(object) == KASAN_SLAB_FREETRACK) {
+		stack_depot_put(free_meta->free_track.stack);
+		free_meta->free_track.stack = 0;
+	}
 
 	/*
 	 * If init_on_free is enabled and KASAN's free metadata is stored in
@@ -157,14 +168,17 @@ static void qlink_free(struct qlist_node *qlink, struct kmem_cache *cache)
 	 */
 	if (slab_want_init_on_free(cache) &&
 	    cache->kasan_info.free_meta_offset == 0)
-		memzero_explicit(meta, sizeof(*meta));
+		memzero_explicit(free_meta, sizeof(*free_meta));
 
 	/*
-	 * As the object now gets freed from the quarantine, assume that its
-	 * free track is no longer valid.
+	 * As the object now gets freed from the quarantine,
+	 * take note that its free track is no longer exists.
 	 */
 	*(u8 *)kasan_mem_to_shadow(object) = KASAN_SLAB_FREE;
 
+	if (IS_ENABLED(CONFIG_SLAB))
+		local_irq_save(flags);
+
 	___cache_free(cache, object, _THIS_IP_);
 
 	if (IS_ENABLED(CONFIG_SLAB))
-- 
2.25.1

