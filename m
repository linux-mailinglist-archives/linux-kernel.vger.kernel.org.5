Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B097DCF26
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbjJaOJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbjJaOJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:09:16 -0400
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BA0125
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:09:13 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698761352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DSV2hJzhN1EMBaKNKe5GTqHBigf8Oik9SH9kDO4tfhs=;
        b=WHMjfXAw75r95lcc5nFUiMN89Tof/YlZMyVPqZKNOdvO1yteE6uHCrbGBMOqY7xCBTII+D
        bv4O0JIZHkzqYTy9jSpAEEAubWuuo1+LX71TrqtSTlbNRuljW0aerBJZZx3KeiAGfHntFE
        9WQV2XL6SGskdWaTT/AwR5nu7UHQO8I=
From:   chengming.zhou@linux.dev
To:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        willy@infradead.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [RFC PATCH v4 5/9] slub: Introduce freeze_slab()
Date:   Tue, 31 Oct 2023 14:07:37 +0000
Message-Id: <20231031140741.79387-6-chengming.zhou@linux.dev>
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

We will have unfrozen slabs out of the node partial list later, so we
need a freeze_slab() function to freeze the partial slab and get its
freelist.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index 1880b483350e..edf567971679 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3098,6 +3098,33 @@ static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
 	return freelist;
 }
 
+/*
+ * Freeze the partial slab and return the pointer to the freelist.
+ */
+static inline void *freeze_slab(struct kmem_cache *s, struct slab *slab)
+{
+	struct slab new;
+	unsigned long counters;
+	void *freelist;
+
+	do {
+		freelist = slab->freelist;
+		counters = slab->counters;
+
+		new.counters = counters;
+		VM_BUG_ON(new.frozen);
+
+		new.inuse = slab->objects;
+		new.frozen = 1;
+
+	} while (!slab_update_freelist(s, slab,
+		freelist, counters,
+		NULL, new.counters,
+		"freeze_slab"));
+
+	return freelist;
+}
+
 /*
  * Slow path. The lockless freelist is empty or we need to perform
  * debugging duties.
-- 
2.20.1

