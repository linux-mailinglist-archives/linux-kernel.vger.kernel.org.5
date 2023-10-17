Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C137CC7C1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344141AbjJQPph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbjJQPp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:45:28 -0400
Received: from out-191.mta1.migadu.com (out-191.mta1.migadu.com [95.215.58.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E37F7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:45:26 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697557525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tb71WTBIRi+Tnmk2GZg+a0sbcsGECWTHjBVZ/Kgj+ow=;
        b=FTuhEnndbqSCtiqr1O7e+RaC5Xz6OtTHQQeyiMhRejvTs1gPYpLuqXRStCw16NBr7Q3k3+
        O4RYPhHqfkT5J7H1e8VhHiBdbBs0AckyoX/neMpbkg24WHjGGLBQOELIyx+/BM31Uj3GT8
        t6UbHf9+/jBpU1VLbPxe5Kb/sPbBt9o=
From:   chengming.zhou@linux.dev
To:     cl@linux.com, penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [RFC PATCH 3/5] slub: Optimize deactivate_slab()
Date:   Tue, 17 Oct 2023 15:44:37 +0000
Message-Id: <20231017154439.3036608-4-chengming.zhou@linux.dev>
In-Reply-To: <20231017154439.3036608-1-chengming.zhou@linux.dev>
References: <20231017154439.3036608-1-chengming.zhou@linux.dev>
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

From: Chengming Zhou <zhouchengming@bytedance.com>

Since the introduce of unfrozen slabs on cpu partial list, we don't
need to synchronize the slab frozen state under the node list_lock.

The caller of deactivate_slab() and the caller of __slab_free() won't
manipulate the slab list concurrently.

So we can get node list_lock in the stage three if we need to manipulate
the slab list in this path.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/slub.c | 70 ++++++++++++++++++++-----------------------------------
 1 file changed, 25 insertions(+), 45 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 27eac93baa13..5a9711b35c74 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2520,10 +2520,8 @@ static void init_kmem_cache_cpus(struct kmem_cache *s)
 static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
 			    void *freelist)
 {
-	enum slab_modes { M_NONE, M_PARTIAL, M_FREE, M_FULL_NOLIST };
 	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
 	int free_delta = 0;
-	enum slab_modes mode = M_NONE;
 	void *nextfree, *freelist_iter, *freelist_tail;
 	int tail = DEACTIVATE_TO_HEAD;
 	unsigned long flags = 0;
@@ -2570,58 +2568,40 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
 	 * unfrozen and number of objects in the slab may have changed.
 	 * Then release lock and retry cmpxchg again.
 	 */
-redo:
-
-	old.freelist = READ_ONCE(slab->freelist);
-	old.counters = READ_ONCE(slab->counters);
-	VM_BUG_ON(!old.frozen);
-
-	/* Determine target state of the slab */
-	new.counters = old.counters;
-	if (freelist_tail) {
-		new.inuse -= free_delta;
-		set_freepointer(s, freelist_tail, old.freelist);
-		new.freelist = freelist;
-	} else
-		new.freelist = old.freelist;
+	do {
+		old.freelist = READ_ONCE(slab->freelist);
+		old.counters = READ_ONCE(slab->counters);
+		VM_BUG_ON(!old.frozen);
+
+		/* Determine target state of the slab */
+		new.counters = old.counters;
+		new.frozen = 0;
+		if (freelist_tail) {
+			new.inuse -= free_delta;
+			set_freepointer(s, freelist_tail, old.freelist);
+			new.freelist = freelist;
+		} else
+			new.freelist = old.freelist;
 
-	new.frozen = 0;
+	} while (!slab_update_freelist(s, slab,
+		old.freelist, old.counters,
+		new.freelist, new.counters,
+		"unfreezing slab"));
 
+	/*
+	 * Stage three: Manipulate the slab list based on the updated state.
+	 */
 	if (!new.inuse && n->nr_partial >= s->min_partial) {
-		mode = M_FREE;
+		stat(s, DEACTIVATE_EMPTY);
+		discard_slab(s, slab);
+		stat(s, FREE_SLAB);
 	} else if (new.freelist) {
-		mode = M_PARTIAL;
-		/*
-		 * Taking the spinlock removes the possibility that
-		 * acquire_slab() will see a slab that is frozen
-		 */
 		spin_lock_irqsave(&n->list_lock, flags);
-	} else {
-		mode = M_FULL_NOLIST;
-	}
-
-
-	if (!slab_update_freelist(s, slab,
-				old.freelist, old.counters,
-				new.freelist, new.counters,
-				"unfreezing slab")) {
-		if (mode == M_PARTIAL)
-			spin_unlock_irqrestore(&n->list_lock, flags);
-		goto redo;
-	}
-
-
-	if (mode == M_PARTIAL) {
 		add_partial(n, slab, tail);
 		spin_unlock_irqrestore(&n->list_lock, flags);
 		stat(s, tail);
-	} else if (mode == M_FREE) {
-		stat(s, DEACTIVATE_EMPTY);
-		discard_slab(s, slab);
-		stat(s, FREE_SLAB);
-	} else if (mode == M_FULL_NOLIST) {
+	} else
 		stat(s, DEACTIVATE_FULL);
-	}
 }
 
 #ifdef CONFIG_SLUB_CPU_PARTIAL
-- 
2.40.1

