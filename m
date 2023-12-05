Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8D5805EEE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 20:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbjLET51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 14:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjLET50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 14:57:26 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C582E1A3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 11:57:31 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 19C301FBB0;
        Tue,  5 Dec 2023 19:57:30 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA5051386E;
        Tue,  5 Dec 2023 19:57:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id MMEmOKmAb2UkRwAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Tue, 05 Dec 2023 19:57:29 +0000
Message-ID: <25eb93ee-e71a-c257-ef4b-9fbb3b694faf@suse.cz>
Date:   Tue, 5 Dec 2023 20:57:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/4] mm/slub: introduce __kmem_cache_free_bulk() without
 free hooks
Content-Language: en-US
To:     Chengming Zhou <chengming.zhou@linux.dev>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
References: <20231204-slub-cleanup-hooks-v1-0-88b65f7cd9d5@suse.cz>
 <20231204-slub-cleanup-hooks-v1-2-88b65f7cd9d5@suse.cz>
 <30f88452-740b-441f-bb4f-a2d946e35cf5@linux.dev>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <30f88452-740b-441f-bb4f-a2d946e35cf5@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: +++++++++
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=none;
        spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of vbabka@suse.cz) smtp.mailfrom=vbabka@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [9.41 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(1.20)[suse.cz];
         R_SPF_SOFTFAIL(4.60)[~all];
         BAYES_HAM(-2.85)[99.35%];
         RCVD_COUNT_THREE(0.00)[3];
         NEURAL_SPAM_SHORT(2.86)[0.955];
         MX_GOOD(-0.01)[];
         RCPT_COUNT_TWELVE(0.00)[14];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[linux-foundation.org,linux.dev,gmail.com,google.com,kvack.org,vger.kernel.org,googlegroups.com];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 9.41
X-Rspamd-Queue-Id: 19C301FBB0
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/23 09:19, Chengming Zhou wrote:
> On 2023/12/5 03:34, Vlastimil Babka wrote:
>> Currently, when __kmem_cache_alloc_bulk() fails, it frees back the
>> objects that were allocated before the failure, using
>> kmem_cache_free_bulk(). Because kmem_cache_free_bulk() calls the free
>> hooks (KASAN etc.) and those expect objects that were processed by the
>> post alloc hooks, slab_post_alloc_hook() is called before
>> kmem_cache_free_bulk().
>> 
>> This is wasteful, although not a big concern in practice for the rare
>> error path. But in order to efficiently handle percpu array batch refill
>> and free in the near future, we will also need a variant of
>> kmem_cache_free_bulk() that avoids the free hooks. So introduce it now
>> and use it for the failure path.
>> 
>> As a consequence, __kmem_cache_alloc_bulk() no longer needs the objcg
>> parameter, remove it.
> 
> The objects may have been charged before, but it seems __kmem_cache_alloc_bulk()
> forget to uncharge them? I can't find "uncharge" in do_slab_free(), or maybe
> the bulk interface won't be used on chargeable slab?

You're right! I missed that the memcg_pre_alloc_hook() already does the
charging, so we need to uncharge. How does this look? Thanks for noticing!

----8<----
From 52f8e77fdfeabffffdce6b761ba5508e940df3be Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 2 Nov 2023 16:34:39 +0100
Subject: [PATCH 2/4] mm/slub: introduce __kmem_cache_free_bulk() without free
 hooks

Currently, when __kmem_cache_alloc_bulk() fails, it frees back the
objects that were allocated before the failure, using
kmem_cache_free_bulk(). Because kmem_cache_free_bulk() calls the free
hooks (KASAN etc.) and those expect objects that were processed by the
post alloc hooks, slab_post_alloc_hook() is called before
kmem_cache_free_bulk().

This is wasteful, although not a big concern in practice for the rare
error path. But in order to efficiently handle percpu array batch refill
and free in the near future, we will also need a variant of
kmem_cache_free_bulk() that avoids the free hooks. So introduce it now
and use it for the failure path.

In case of failure we however still need to perform memcg uncharge so
handle that in a new memcg_slab_alloc_error_hook(). Thanks to Chengming
Zhou for noticing the missing uncharge.

As a consequence, __kmem_cache_alloc_bulk() no longer needs the objcg
parameter, remove it.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 9 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index d7b0ca6012e0..0a9e4bd0dd68 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2003,6 +2003,14 @@ void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 
 	__memcg_slab_free_hook(s, slab, p, objects, objcgs);
 }
+
+static inline
+void memcg_slab_alloc_error_hook(struct kmem_cache *s, int objects,
+			   struct obj_cgroup *objcg)
+{
+	if (objcg)
+		obj_cgroup_uncharge(objcg, objects * obj_full_size(s));
+}
 #else /* CONFIG_MEMCG_KMEM */
 static inline struct mem_cgroup *memcg_from_slab_obj(void *ptr)
 {
@@ -2032,6 +2040,12 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 					void **p, int objects)
 {
 }
+
+static inline
+void memcg_slab_alloc_error_hook(struct kmem_cache *s, int objects,
+				 struct obj_cgroup *objcg)
+{
+}
 #endif /* CONFIG_MEMCG_KMEM */
 
 /*
@@ -4478,6 +4492,27 @@ int build_detached_freelist(struct kmem_cache *s, size_t size,
 	return same;
 }
 
+/*
+ * Internal bulk free of objects that were not initialised by the post alloc
+ * hooks and thus should not be processed by the free hooks
+ */
+static void __kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
+{
+	if (!size)
+		return;
+
+	do {
+		struct detached_freelist df;
+
+		size = build_detached_freelist(s, size, p, &df);
+		if (!df.slab)
+			continue;
+
+		do_slab_free(df.s, df.slab, df.freelist, df.tail, df.cnt,
+			     _RET_IP_);
+	} while (likely(size));
+}
+
 /* Note that interrupts must be enabled when calling this function. */
 void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
 {
@@ -4498,8 +4533,9 @@ void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
 EXPORT_SYMBOL(kmem_cache_free_bulk);
 
 #ifndef CONFIG_SLUB_TINY
-static inline int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
-			size_t size, void **p, struct obj_cgroup *objcg)
+static inline
+int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
+			    void **p)
 {
 	struct kmem_cache_cpu *c;
 	unsigned long irqflags;
@@ -4563,14 +4599,13 @@ static inline int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
 
 error:
 	slub_put_cpu_ptr(s->cpu_slab);
-	slab_post_alloc_hook(s, objcg, flags, i, p, false, s->object_size);
-	kmem_cache_free_bulk(s, i, p);
+	__kmem_cache_free_bulk(s, i, p);
 	return 0;
 
 }
 #else /* CONFIG_SLUB_TINY */
 static int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
-			size_t size, void **p, struct obj_cgroup *objcg)
+				   size_t size, void **p)
 {
 	int i;
 
@@ -4593,8 +4628,7 @@ static int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
 	return i;
 
 error:
-	slab_post_alloc_hook(s, objcg, flags, i, p, false, s->object_size);
-	kmem_cache_free_bulk(s, i, p);
+	__kmem_cache_free_bulk(s, i, p);
 	return 0;
 }
 #endif /* CONFIG_SLUB_TINY */
@@ -4614,15 +4648,19 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	if (unlikely(!s))
 		return 0;
 
-	i = __kmem_cache_alloc_bulk(s, flags, size, p, objcg);
+	i = __kmem_cache_alloc_bulk(s, flags, size, p);
 
 	/*
 	 * memcg and kmem_cache debug support and memory initialization.
 	 * Done outside of the IRQ disabled fastpath loop.
 	 */
-	if (i != 0)
+	if (likely(i != 0)) {
 		slab_post_alloc_hook(s, objcg, flags, size, p,
 			slab_want_init_on_alloc(flags, s), s->object_size);
+	} else {
+		memcg_slab_alloc_error_hook(s, size, objcg);
+	}
+
 	return i;
 }
 EXPORT_SYMBOL(kmem_cache_alloc_bulk);
-- 
2.43.0


