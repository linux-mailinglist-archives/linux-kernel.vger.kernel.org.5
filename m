Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C2D7DEB51
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 04:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348382AbjKBDZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 23:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348397AbjKBDZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 23:25:17 -0400
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [IPv6:2001:41d0:203:375::ba])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BB0127
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 20:25:11 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698895509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bbgfkr34Ut5bOat3PkSebFKZ4A5Cv7UHaj4yNDSPhuU=;
        b=gHbx+MfkKMaXjWLoeHR6R2/oAAyFc9gfvo3ohtd4K4S4h0A6KE0hMrTwtFkBS0N7jtWhrk
        xt6ezAgfua8IzYH47q+ur2/jbneBGFE275j69jA9HgOkeQ4CEUTLkH6FIThRIPBcrygeuj
        fPAujlzG9ChYjmdwj+8gHQRxUvZnQVo=
From:   chengming.zhou@linux.dev
To:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v5 7/9] slub: Optimize deactivate_slab()
Date:   Thu,  2 Nov 2023 03:23:28 +0000
Message-Id: <20231102032330.1036151-8-chengming.zhou@linux.dev>
In-Reply-To: <20231102032330.1036151-1-chengming.zhou@linux.dev>
References: <20231102032330.1036151-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

So we can get node list_lock in the last stage if we really need to
manipulate the slab list in this path.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slub.c | 79 ++++++++++++++++++-------------------------------------
 1 file changed, 26 insertions(+), 53 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index bcb5b2c4e213..d137468fe4b9 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2468,10 +2468,8 @@ static void init_kmem_cache_cpus(struct kmem_cache *s)
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
@@ -2509,65 +2507,40 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
 	/*
 	 * Stage two: Unfreeze the slab while splicing the per-cpu
 	 * freelist to the head of slab's freelist.
-	 *
-	 * Ensure that the slab is unfrozen while the list presence
-	 * reflects the actual number of objects during unfreeze.
-	 *
-	 * We first perform cmpxchg holding lock and insert to list
-	 * when it succeed. If there is mismatch then the slab is not
-	 * unfrozen and number of objects in the slab may have changed.
-	 * Then release lock and retry cmpxchg again.
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
-
-	new.frozen = 0;
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
+		} else {
+			new.freelist = old.freelist;
+		}
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
+	} else {
 		stat(s, DEACTIVATE_FULL);
 	}
 }
-- 
2.20.1

