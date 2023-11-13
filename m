Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AA97EA39B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjKMTPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbjKMTO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:14:27 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F661739;
        Mon, 13 Nov 2023 11:14:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 237611F88F;
        Mon, 13 Nov 2023 19:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1699902856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HPRL/KrzqhhRv//jIzaBEKs7IEvhqlXTEPf11LGvT+E=;
        b=MCduxZYmVuQsqxVK7yN6VRgd6oRH1+OX+bZLl8Vq/FjOKSCiK1k9AbIeXyymmv5FFiChqN
        BrILdcy4pVskHuPR1IM6wOan8Zd7bZZfAX9X8kZte2Wtwcm+KZ7P4HFKM5WjJe/L4pdaPg
        C72FBd07XRG9KFPVqy66V6Gvg2vePOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1699902856;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HPRL/KrzqhhRv//jIzaBEKs7IEvhqlXTEPf11LGvT+E=;
        b=V8jBNiQRZxe6eGxYJtbNWf/MQPc4nz18AGu/sDaheaWDiPfd7VFSosfgTjsJi1S0XqFTQK
        D7rYRLY+Nl5VtdBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C7F5313398;
        Mon, 13 Nov 2023 19:14:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aLpDMId1UmVFOgAAMHmgww
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
Subject: [PATCH 20/20] mm/slub: optimize free fast path code layout
Date:   Mon, 13 Nov 2023 20:14:01 +0100
Message-ID: <20231113191340.17482-42-vbabka@suse.cz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231113191340.17482-22-vbabka@suse.cz>
References: <20231113191340.17482-22-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inspection of kmem_cache_free() disassembly showed we could make the
fast path smaller by providing few more hints to the compiler, and
splitting the memcg_slab_free_hook() into an inline part that only
checks if there's work to do, and an out of line part doing the actual
uncharge.

bloat-o-meter results:
add/remove: 2/0 grow/shrink: 0/3 up/down: 286/-554 (-268)
Function                                     old     new   delta
__memcg_slab_free_hook                         -     270    +270
__pfx___memcg_slab_free_hook                   -      16     +16
kfree                                        828     665    -163
kmem_cache_free                             1116     948    -168
kmem_cache_free_bulk.part                   1701    1478    -223

Checking kmem_cache_free() disassembly now shows the non-fastpath
cases are handled out of line, which should reduce instruction cache
usage.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 7a40132b717a..ae1e6e635253 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1959,20 +1959,11 @@ void memcg_slab_post_alloc_hook(struct kmem_cache *s, struct obj_cgroup *objcg,
 	return __memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
 }
 
-static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
-					void **p, int objects)
+static void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
+				   void **p, int objects,
+				   struct obj_cgroup **objcgs)
 {
-	struct obj_cgroup **objcgs;
-	int i;
-
-	if (!memcg_kmem_online())
-		return;
-
-	objcgs = slab_objcgs(slab);
-	if (!objcgs)
-		return;
-
-	for (i = 0; i < objects; i++) {
+	for (int i = 0; i < objects; i++) {
 		struct obj_cgroup *objcg;
 		unsigned int off;
 
@@ -1988,6 +1979,22 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 		obj_cgroup_put(objcg);
 	}
 }
+
+static __fastpath_inline
+void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
+			  int objects)
+{
+	struct obj_cgroup **objcgs;
+
+	if (!memcg_kmem_online())
+		return;
+
+	objcgs = slab_objcgs(slab);
+	if (likely(!objcgs))
+		return;
+
+	__memcg_slab_free_hook(s, slab, p, objects, objcgs);
+}
 #else /* CONFIG_MEMCG_KMEM */
 static inline struct mem_cgroup *memcg_from_slab_obj(void *ptr)
 {
@@ -2047,7 +2054,7 @@ static __always_inline bool slab_free_hook(struct kmem_cache *s,
 	 * The initialization memset's clear the object and the metadata,
 	 * but don't touch the SLAB redzone.
 	 */
-	if (init) {
+	if (unlikely(init)) {
 		int rsize;
 
 		if (!kasan_has_integrated_init())
@@ -2083,7 +2090,8 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
 		next = get_freepointer(s, object);
 
 		/* If object's reuse doesn't have to be delayed */
-		if (!slab_free_hook(s, object, slab_want_init_on_free(s))) {
+		if (likely(!slab_free_hook(s, object,
+					   slab_want_init_on_free(s)))) {
 			/* Move object to the new freelist */
 			set_freepointer(s, object, *head);
 			*head = object;
@@ -4270,7 +4278,7 @@ static __fastpath_inline void slab_free(struct kmem_cache *s, struct slab *slab,
 	 * With KASAN enabled slab_free_freelist_hook modifies the freelist
 	 * to remove objects, whose reuse must be delayed.
 	 */
-	if (slab_free_freelist_hook(s, &head, &tail, &cnt))
+	if (likely(slab_free_freelist_hook(s, &head, &tail, &cnt)))
 		do_slab_free(s, slab, head, tail, cnt, addr);
 }
 
-- 
2.42.1

