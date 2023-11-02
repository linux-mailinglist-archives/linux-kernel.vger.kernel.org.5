Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8417DEB4E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 04:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348406AbjKBDZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 23:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348366AbjKBDZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 23:25:00 -0400
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [IPv6:2001:41d0:203:375::ad])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF8A128
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 20:24:54 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698895493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f6Me2hDPNAg0QwflvoQbBjNc8QPP2obW8dtDV2OvsdM=;
        b=BPwts8cCYtipUTdyFWricBp8OGyxnWzOEVZlgGagJ9J46S70yP6mdX0Zikc3F0F2DBJvXT
        /yMeu2ntPNaXcbiqN3TobVLGvOh9MDaYMJyNpEP8dSexDMJlp27RoUaeceT+iumgN10Z/7
        Sn3Ry4EaMJKSfkAaTC3ksH7jqeLcYEc=
From:   chengming.zhou@linux.dev
To:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v5 4/9] slub: Prepare __slab_free() for unfrozen partial slab out of node partial list
Date:   Thu,  2 Nov 2023 03:23:25 +0000
Message-Id: <20231102032330.1036151-5-chengming.zhou@linux.dev>
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

Now the partially empty slub will be frozen when taken out of node partial
list, so the __slab_free() will know from "was_frozen" that the partially
empty slab is not on node partial list and is a cpu or cpu partial slab
of some cpu.

But we will change this, make partial slabs leave the node partial list
with unfrozen state, so we need to change __slab_free() to use the new
slab_test_node_partial() we just introduced.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slub.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index eed8ae0dbaf9..1880b483350e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3631,6 +3631,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 	unsigned long counters;
 	struct kmem_cache_node *n = NULL;
 	unsigned long flags;
+	bool on_node_partial;
 
 	stat(s, FREE_SLOWPATH);
 
@@ -3678,6 +3679,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 				 */
 				spin_lock_irqsave(&n->list_lock, flags);
 
+				on_node_partial = slab_test_node_partial(slab);
 			}
 		}
 
@@ -3706,6 +3708,15 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 		return;
 	}
 
+	/*
+	 * This slab was partially empty but not on the per-node partial list,
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
2.20.1

