Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FE77D4CCD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbjJXJoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbjJXJeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:34:09 -0400
Received: from out-190.mta0.migadu.com (out-190.mta0.migadu.com [91.218.175.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A57E1FC6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:34:01 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698140039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h11SacZ+d1SZT9G0QAPU/rLkN5EaAt8R9Llcg4aahcg=;
        b=XdLQFwKjBt2izoxJqBOj93psrMaXNRty4xClGHCDT9p4T6juuhYWB/eoSnFrU+EPl/QvmP
        6gAcQ3g4yVWbXa8UyMXIbOBPExVeP2TXXqyMEawXzbGshHntMsONmYh2xHZQ0ydgsgepOq
        WH5zAaZdRSTxxEDvvW3W5dkYKS7D57s=
From:   chengming.zhou@linux.dev
To:     cl@linux.com, penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [RFC PATCH v3 2/7] slub: Prepare __slab_free() for unfrozen partial slab out of node partial list
Date:   Tue, 24 Oct 2023 09:33:40 +0000
Message-Id: <20231024093345.3676493-3-chengming.zhou@linux.dev>
In-Reply-To: <20231024093345.3676493-1-chengming.zhou@linux.dev>
References: <20231024093345.3676493-1-chengming.zhou@linux.dev>
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

Now the partial slub will be frozen when taken out of node partial list,
so the __slab_free() will know from "was_frozen" that the partial slab
is not on node partial list and is used by one kmem_cache_cpu.

But we will change this, make partial slabs leave the node partial list
with unfrozen state, so we need to change __slab_free() to use the new
slab_test_node_partial() we just introduced.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/slub.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index 3fad4edca34b..f568a32d7332 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3610,6 +3610,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 	unsigned long counters;
 	struct kmem_cache_node *n = NULL;
 	unsigned long flags;
+	bool on_node_partial;
 
 	stat(s, FREE_SLOWPATH);
 
@@ -3657,6 +3658,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 				 */
 				spin_lock_irqsave(&n->list_lock, flags);
 
+				on_node_partial = slab_test_node_partial(slab);
 			}
 		}
 
@@ -3685,6 +3687,15 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 		return;
 	}
 
+	/*
+	 * This slab was partial but not on the per-node partial list,
+	 * in which case we shouldn't manipulate its list, just return.
+	 */
+	if (prior && !on_node_partial) {
+		spin_unlock_irqrestore(&n->list_lock, flags);
+		return;
+	}
+
 	if (unlikely(!new.inuse && n->nr_partial >= s->min_partial))
 		goto slab_empty;
 
-- 
2.40.1

