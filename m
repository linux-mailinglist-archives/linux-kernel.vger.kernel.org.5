Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDA47DCF00
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjJaOJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbjJaOJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:09:14 -0400
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D9D115
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:09:11 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698761349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v/W13f1yvwrCHZgH+TSl+cdWReIuGoRVTB5psVe8An4=;
        b=wNIpzakvsd93W80vtkHwQf555uZ1X7UCHSu5UZdhAwR+WInzzIHY0wg3MqdVqIXyuFrveg
        zfUzHrnr02/YVCm2lpOuVKjDOu31IpZFnrJaagZexEAqG5577/evBuPT6k6264Mc9xVBB2
        K4yu/KTcypElGi304xzyFujmguhhPdg=
From:   chengming.zhou@linux.dev
To:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        willy@infradead.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [RFC PATCH v4 4/9] slub: Prepare __slab_free() for unfrozen partial slab out of node partial list
Date:   Tue, 31 Oct 2023 14:07:36 +0000
Message-Id: <20231031140741.79387-5-chengming.zhou@linux.dev>
In-Reply-To: <20231031140741.79387-1-chengming.zhou@linux.dev>
References: <20231031140741.79387-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

