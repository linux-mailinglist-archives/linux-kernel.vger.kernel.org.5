Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575A97EA399
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjKMTPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjKMTO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:14:26 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AFB1735;
        Mon, 13 Nov 2023 11:14:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 893D52193C;
        Mon, 13 Nov 2023 19:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1699902855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yc0ydpEKadjGMZmR6AOilRcjjCaikOgVLMhJfLa5KNY=;
        b=Cb9azOi+79RTNG1eEAaRK2qKO08RdjEozYg5VQaWSgjm9ZtEhKXDtBAnNZSXPOGfqbZ5Yx
        zjyoWUbZWmftG6lgXdDLymTg9Eq0TbgJJoTL9ePBdM+V3LwH5TQf8gQMZUYvaz7iGhzAtV
        Qnmt4KB+99CZs9Oky9jRP7dc8P9XkBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1699902855;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yc0ydpEKadjGMZmR6AOilRcjjCaikOgVLMhJfLa5KNY=;
        b=YZzAxb8QZCafpYhSWsUv7cmsWbx/IMh0AC7UrukpeAEDxfHnpnbLPFz7TSL4WQSuD7NdVi
        vwsIBz9/OyMbwQCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3EDFC13398;
        Mon, 13 Nov 2023 19:14:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eOW7Dod1UmVFOgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 13 Nov 2023 19:14:15 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marco Elver <elver@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Kees Cook <keescook@chromium.org>, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 18/20] mm/slub: remove slab_alloc() and __kmem_cache_alloc_lru() wrappers
Date:   Mon, 13 Nov 2023 20:13:59 +0100
Message-ID: <20231113191340.17482-40-vbabka@suse.cz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231113191340.17482-22-vbabka@suse.cz>
References: <20231113191340.17482-22-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

slab_alloc() is a thin wrapper around slab_alloc_node() with only one
caller.  Replace with direct call of slab_alloc_node().
__kmem_cache_alloc_lru() itself is a thin wrapper with two callers,
so replace it with direct calls of slab_alloc_node() and
trace_kmem_cache_alloc().

This also makes sure _RET_IP_ has always the expected value and not
depending on inlining decisions.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index b44243e7cc5e..d2363b91d55c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3821,39 +3821,33 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
 	return object;
 }
 
-static __fastpath_inline void *slab_alloc(struct kmem_cache *s, struct list_lru *lru,
-		gfp_t gfpflags, unsigned long addr, size_t orig_size)
-{
-	return slab_alloc_node(s, lru, gfpflags, NUMA_NO_NODE, addr, orig_size);
-}
-
-static __fastpath_inline
-void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
-			     gfp_t gfpflags)
+void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflags)
 {
-	void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
+	void *ret = slab_alloc_node(s, NULL, gfpflags, NUMA_NO_NODE, _RET_IP_,
+				    s->object_size);
 
 	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, NUMA_NO_NODE);
 
 	return ret;
 }
-
-void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflags)
-{
-	return __kmem_cache_alloc_lru(s, NULL, gfpflags);
-}
 EXPORT_SYMBOL(kmem_cache_alloc);
 
 void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
 			   gfp_t gfpflags)
 {
-	return __kmem_cache_alloc_lru(s, lru, gfpflags);
+	void *ret = slab_alloc_node(s, lru, gfpflags, NUMA_NO_NODE, _RET_IP_,
+				    s->object_size);
+
+	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, NUMA_NO_NODE);
+
+	return ret;
 }
 EXPORT_SYMBOL(kmem_cache_alloc_lru);
 
 void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
 {
-	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, s->object_size);
+	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_,
+				    s->object_size);
 
 	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, node);
 
-- 
2.42.1

