Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC897DCF11
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236135AbjJaOJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbjJaOJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:09:31 -0400
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [IPv6:2001:41d0:203:375::b5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E4019E
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:09:25 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698761363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1rWlR4h5g4eDWf2XTzUlOrJLNxfEOq6mT+00ilTz0G0=;
        b=Y0fRMVJblxItnO7fa29gryhY0OuDSuYpX3u9Ss3dhqwRf1OZ/GJBzbFxGqASfXa3ZkcDEd
        llhl/Boestl6/Pzbcckw30/f5cm8ZIVtqAPveVEahzHWy0Mm0D45/0Br2r/TLM+w+opTst
        LbLFwmWZyebAWLmuYs8XzdN4+enFRJY=
From:   chengming.zhou@linux.dev
To:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        willy@infradead.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [RFC PATCH v4 9/9] slub: Update frozen slabs documentations in the source
Date:   Tue, 31 Oct 2023 14:07:41 +0000
Message-Id: <20231031140741.79387-10-chengming.zhou@linux.dev>
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

The current updated scheme (which this series implemented) is:
 - node partial slabs: PG_Workingset && !frozen
 - cpu partial slabs: !PG_Workingset && !frozen
 - cpu slabs: !PG_Workingset && frozen
 - full slabs: !PG_Workingset && !frozen

The most important change is that "frozen" bit is not set for the
cpu partial slabs anymore, __slab_free() will grab node list_lock
then check by !PG_Workingset that it's not on a node partial list.

And the "frozen" bit is still kept for the cpu slabs for performance,
since we don't need to grab node list_lock to check whether the
PG_Workingset is set or not if the "frozen" bit is set in __slab_free().

Update related documentations and comments in the source.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/slub.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index bb7368047103..89d3f7a18a73 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -76,13 +76,22 @@
  *
  *   Frozen slabs
  *
- *   If a slab is frozen then it is exempt from list management. It is not
- *   on any list except per cpu partial list. The processor that froze the
+ *   If a slab is frozen then it is exempt from list management. It is
+ *   the cpu slab which is actively allocated from by the processor that
+ *   froze it and it is not on any list. The processor that froze the
  *   slab is the one who can perform list operations on the slab. Other
  *   processors may put objects onto the freelist but the processor that
  *   froze the slab is the only one that can retrieve the objects from the
  *   slab's freelist.
  *
+ *   CPU partial slabs
+ *
+ *   The partially empty slabs cached on the CPU partial list are used
+ *   for performance reasons, which speeds up the allocation process.
+ *   These slabs are not frozen, but also exempt from list management,
+ *   by clearing the PG_workingset flag when moving out of the node
+ *   partial list. Please see __slab_free() for more details.
+ *
  *   list_lock
  *
  *   The list_lock protects the partial and full list on each node and
@@ -2620,8 +2629,7 @@ static void put_partials_cpu(struct kmem_cache *s,
 }
 
 /*
- * Put a slab that was just frozen (in __slab_free|get_partial_node) into a
- * partial slab slot if available.
+ * Put a slab into a partial slab slot if available.
  *
  * If we did not find a slot then simply move all the partials to the
  * per node partial list.
-- 
2.20.1

