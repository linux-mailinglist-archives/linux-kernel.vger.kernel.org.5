Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C3F7CC7C0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344124AbjJQPp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235075AbjJQPp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:45:26 -0400
Received: from out-208.mta1.migadu.com (out-208.mta1.migadu.com [95.215.58.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59D9FA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:45:23 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697557522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uepMlN8KtJ2YuJ4CH70+gbxhj8qnD/tT1k7NrYZtVVI=;
        b=DaAtiZgQCtDa1rxPzHIgjJc4DIjqm3myRMfLOwX9HUwVK+3r/TPToUXQkLJLfTM7KtEz6X
        P6rFQUmudCXJ4U+y638uzl0+mFMh4ihgvECPrJJA2ZQUJxMrCtLFiczP96D5Kt+GJmG0g9
        TeH5WidQi5s+QCvlDqd5nD8QeqE0pNc=
From:   chengming.zhou@linux.dev
To:     cl@linux.com, penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [RFC PATCH 2/5] slub: Don't manipulate slab list when used by cpu
Date:   Tue, 17 Oct 2023 15:44:36 +0000
Message-Id: <20231017154439.3036608-3-chengming.zhou@linux.dev>
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

We will change to don't freeze slab when moving it out of node partial
list in the following patch, so we can't rely on the frozen bit to
indicate if we should manipulate the slab list or not.

This patch use the introduced on_partial() helper, which check the
slab->flags that protected by node list_lock, so we can know if the
slab is on the node partial list.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/slub.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index e5356ad14951..27eac93baa13 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3636,6 +3636,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 	unsigned long counters;
 	struct kmem_cache_node *n = NULL;
 	unsigned long flags;
+	bool on_node_partial;
 
 	stat(s, FREE_SLOWPATH);
 
@@ -3683,6 +3684,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 				 */
 				spin_lock_irqsave(&n->list_lock, flags);
 
+				on_node_partial = on_partial(n, slab);
 			}
 		}
 
@@ -3711,6 +3713,15 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 		return;
 	}
 
+	/*
+	 * This slab was not on node partial list and not full either,
+	 * in which case we shouldn't manipulate its list, early return.
+	 */
+	if (!on_node_partial && prior) {
+		spin_unlock_irqrestore(&n->list_lock, flags);
+		return;
+	}
+
 	if (unlikely(!new.inuse && n->nr_partial >= s->min_partial))
 		goto slab_empty;
 
-- 
2.40.1

