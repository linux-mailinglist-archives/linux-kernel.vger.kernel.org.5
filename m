Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF4B7D1D8C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 16:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjJUOoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 10:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjJUOo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 10:44:28 -0400
Received: from out-191.mta1.migadu.com (out-191.mta1.migadu.com [95.215.58.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA1610D1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:44:20 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697899458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nWmtXPvIlob45jfvRK/RuModS0a7G4PIYKuavHC2hOU=;
        b=PRz3bzrmS8EEMlbH+t4XO9cRe385YlpMQbBC+PJkV+mYGBOQDvOobTnnsiBIQwzbWk3dGH
        53MwwtqQ/0FHj6idagxgeusX/wx+o/QH+LERI272V7ONmJtNIhQsZj5RYWyxmNgUWef9WU
        zq8+O024g84F8rDMjvJ1FPttWXr+WJw=
From:   chengming.zhou@linux.dev
To:     cl@linux.com, penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, willy@infradead.org,
        pcc@google.com, tytso@mit.edu, maz@kernel.org,
        ruansy.fnst@fujitsu.com, vishal.moola@gmail.com,
        lrh2000@pku.edu.cn, hughd@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [RFC PATCH v2 4/6] slub: Simplify acquire_slab()
Date:   Sat, 21 Oct 2023 14:43:15 +0000
Message-Id: <20231021144317.3400916-5-chengming.zhou@linux.dev>
In-Reply-To: <20231021144317.3400916-1-chengming.zhou@linux.dev>
References: <20231021144317.3400916-1-chengming.zhou@linux.dev>
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

Now the object == NULL is always true, simplify acquire_slab().

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/slub.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 61ee82ea21b6..9f0b80fefc70 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2222,8 +2222,7 @@ static void *alloc_single_from_new_slab(struct kmem_cache *s,
  * Returns a list of objects or NULL if it fails.
  */
 static inline void *acquire_slab(struct kmem_cache *s,
-		struct kmem_cache_node *n, struct slab *slab,
-		int mode)
+		struct kmem_cache_node *n, struct slab *slab)
 {
 	void *freelist;
 	unsigned long counters;
@@ -2239,12 +2238,8 @@ static inline void *acquire_slab(struct kmem_cache *s,
 	freelist = slab->freelist;
 	counters = slab->counters;
 	new.counters = counters;
-	if (mode) {
-		new.inuse = slab->objects;
-		new.freelist = NULL;
-	} else {
-		new.freelist = freelist;
-	}
+	new.inuse = slab->objects;
+	new.freelist = NULL;
 
 	VM_BUG_ON(new.frozen);
 	new.frozen = 1;
@@ -2306,7 +2301,7 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 		}
 
 		if (!object) {
-			t = acquire_slab(s, n, slab, object == NULL);
+			t = acquire_slab(s, n, slab);
 			if (t) {
 				*pc->slab = slab;
 				stat(s, ALLOC_FROM_PARTIAL);
-- 
2.20.1

