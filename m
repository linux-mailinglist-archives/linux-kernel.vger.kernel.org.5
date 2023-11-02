Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FF87DEB53
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 04:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348422AbjKBDZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 23:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348419AbjKBDZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 23:25:40 -0400
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB87119
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 20:25:33 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698895532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gJd616cEH+YooKkPi26MjXWgnIGEXuyIPk1hxd0FhTk=;
        b=nDjeGraaC0yMn15FP6J1O98CFrfWFi/efFlDQyWlgTKRBWcIkb3Bueh3V63chVaCnBjh/z
        aT+DJ4liAnoOXN6AjPz5ujQz9YSWQl2pq1MhhIZ8NmN0T3o3AMQcWG/ZORLSwwjhMGbr7d
        UKvLJzRg/tomBOgosqWMv4T+MnQQ2Cg=
From:   chengming.zhou@linux.dev
To:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v5 9/9] slub: Update frozen slabs documentations in the source
Date:   Thu,  2 Nov 2023 03:23:30 +0000
Message-Id: <20231102032330.1036151-10-chengming.zhou@linux.dev>
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
Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slub.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index c20bdf5dab0f..a307d319e82c 100644
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
+ *   These slabs are not frozen, but are also exempt from list management,
+ *   by clearing the PG_workingset flag when moving out of the node
+ *   partial list. Please see __slab_free() for more details.
+ *
  *   list_lock
  *
  *   The list_lock protects the partial and full list on each node and
@@ -2617,8 +2626,7 @@ static void put_partials_cpu(struct kmem_cache *s,
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

