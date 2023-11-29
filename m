Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C4D7FD354
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjK2Jyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjK2Jxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:53:55 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC042682
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:53:39 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2B8351F8B3;
        Wed, 29 Nov 2023 09:53:37 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08AC613A98;
        Wed, 29 Nov 2023 09:53:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id qLDSASEKZ2UrfQAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Wed, 29 Nov 2023 09:53:37 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
Date:   Wed, 29 Nov 2023 10:53:28 +0100
Subject: [PATCH RFC v3 3/9] mm/slub: handle bulk and single object freeing
 separately
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-slub-percpu-caches-v3-3-6bcf536772bc@suse.cz>
References: <20231129-slub-percpu-caches-v3-0-6bcf536772bc@suse.cz>
In-Reply-To: <20231129-slub-percpu-caches-v3-0-6bcf536772bc@suse.cz>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        kasan-dev@googlegroups.com, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.12.4
X-Spamd-Bar: +++++++++
X-Spam-Score: 9.03
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of vbabka@suse.cz) smtp.mailfrom=vbabka@suse.cz;
        dmarc=none
X-Rspamd-Queue-Id: 2B8351F8B3
X-Spamd-Result: default: False [9.03 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
         TO_DN_SOME(0.00)[];
         R_SPF_SOFTFAIL(4.60)[~all];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(1.20)[suse.cz];
         NEURAL_SPAM_LONG(2.84)[0.810];
         RCPT_COUNT_TWELVE(0.00)[17];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FREEMAIL_CC(0.00)[linux-foundation.org,linux.dev,gmail.com,google.com,kvack.org,vger.kernel.org,lists.infradead.org,googlegroups.com,suse.cz];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now we have a single function slab_free() handling both single
object freeing and bulk freeing with neccessary hooks, the latter case
requiring slab_free_freelist_hook(). It should be however better to
distinguish the two scenarios for the following reasons:

- code simpler to follow for the single object case

- better code generation - although inlining should eliminate the
  slab_free_freelist_hook() in case no debugging options are enabled, it
  seems it's not perfect. When e.g. KASAN is enabled, we're imposing
  additional unnecessary overhead for single object freeing.

- preparation to add percpu array caches in later patches

Therefore, simplify slab_free() for the single object case by dropping
unnecessary parameters and calling only slab_free_hook() instead of
slab_free_freelist_hook(). Rename the bulk variant to slab_free_bulk()
and adjust callers accordingly.

While at it, flip (and document) slab_free_hook() return value so that
it returns true when the freeing can proceed, which matches the logic of
slab_free_freelist_hook() and is not confusingly the opposite.

Additionally we can simplify a bit by changing the tail parameter of
do_slab_free() when freeing a single object - instead of NULL we can set
equal to head.

bloat-o-meter shows small code reduction with a .config that has KASAN
etc disabled:

add/remove: 0/0 grow/shrink: 0/4 up/down: 0/-118 (-118)
Function                                     old     new   delta
kmem_cache_alloc_bulk                       1203    1196      -7
kmem_cache_free                              861     835     -26
__kmem_cache_free                            741     704     -37
kmem_cache_free_bulk                         911     863     -48

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 57 ++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 16748aeada8f..7d23f10d42e6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1770,9 +1770,12 @@ static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
 /*
  * Hooks for other subsystems that check memory allocations. In a typical
  * production configuration these hooks all should produce no code at all.
+ *
+ * Returns true if freeing of the object can proceed, false if its reuse
+ * was delayed by KASAN quarantine.
  */
-static __always_inline bool slab_free_hook(struct kmem_cache *s,
-						void *x, bool init)
+static __always_inline
+bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
 {
 	kmemleak_free_recursive(x, s->flags);
 	kmsan_slab_free(s, x);
@@ -1805,7 +1808,7 @@ static __always_inline bool slab_free_hook(struct kmem_cache *s,
 		       s->size - s->inuse - rsize);
 	}
 	/* KASAN might put x into memory quarantine, delaying its reuse. */
-	return kasan_slab_free(s, x, init);
+	return !kasan_slab_free(s, x, init);
 }
 
 static inline bool slab_free_freelist_hook(struct kmem_cache *s,
@@ -1815,7 +1818,7 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
 
 	void *object;
 	void *next = *head;
-	void *old_tail = *tail ? *tail : *head;
+	void *old_tail = *tail;
 
 	if (is_kfence_address(next)) {
 		slab_free_hook(s, next, false);
@@ -1831,7 +1834,7 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
 		next = get_freepointer(s, object);
 
 		/* If object's reuse doesn't have to be delayed */
-		if (!slab_free_hook(s, object, slab_want_init_on_free(s))) {
+		if (slab_free_hook(s, object, slab_want_init_on_free(s))) {
 			/* Move object to the new freelist */
 			set_freepointer(s, object, *head);
 			*head = object;
@@ -1846,9 +1849,6 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
 		}
 	} while (object != old_tail);
 
-	if (*head == *tail)
-		*tail = NULL;
-
 	return *head != NULL;
 }
 
@@ -3743,7 +3743,6 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 				struct slab *slab, void *head, void *tail,
 				int cnt, unsigned long addr)
 {
-	void *tail_obj = tail ? : head;
 	struct kmem_cache_cpu *c;
 	unsigned long tid;
 	void **freelist;
@@ -3762,14 +3761,14 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 	barrier();
 
 	if (unlikely(slab != c->slab)) {
-		__slab_free(s, slab, head, tail_obj, cnt, addr);
+		__slab_free(s, slab, head, tail, cnt, addr);
 		return;
 	}
 
 	if (USE_LOCKLESS_FAST_PATH()) {
 		freelist = READ_ONCE(c->freelist);
 
-		set_freepointer(s, tail_obj, freelist);
+		set_freepointer(s, tail, freelist);
 
 		if (unlikely(!__update_cpu_freelist_fast(s, freelist, head, tid))) {
 			note_cmpxchg_failure("slab_free", s, tid);
@@ -3786,7 +3785,7 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 		tid = c->tid;
 		freelist = c->freelist;
 
-		set_freepointer(s, tail_obj, freelist);
+		set_freepointer(s, tail, freelist);
 		c->freelist = head;
 		c->tid = next_tid(tid);
 
@@ -3799,15 +3798,27 @@ static void do_slab_free(struct kmem_cache *s,
 				struct slab *slab, void *head, void *tail,
 				int cnt, unsigned long addr)
 {
-	void *tail_obj = tail ? : head;
-
-	__slab_free(s, slab, head, tail_obj, cnt, addr);
+	__slab_free(s, slab, head, tail, cnt, addr);
 }
 #endif /* CONFIG_SLUB_TINY */
 
-static __fastpath_inline void slab_free(struct kmem_cache *s, struct slab *slab,
-				      void *head, void *tail, void **p, int cnt,
-				      unsigned long addr)
+static __fastpath_inline
+void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
+	       unsigned long addr)
+{
+	bool init;
+
+	memcg_slab_free_hook(s, slab, &object, 1);
+
+	init = !is_kfence_address(object) && slab_want_init_on_free(s);
+
+	if (likely(slab_free_hook(s, object, init)))
+		do_slab_free(s, slab, object, object, 1, addr);
+}
+
+static __fastpath_inline
+void slab_free_bulk(struct kmem_cache *s, struct slab *slab, void *head,
+		    void *tail, void **p, int cnt, unsigned long addr)
 {
 	memcg_slab_free_hook(s, slab, p, cnt);
 	/*
@@ -3821,13 +3832,13 @@ static __fastpath_inline void slab_free(struct kmem_cache *s, struct slab *slab,
 #ifdef CONFIG_KASAN_GENERIC
 void ___cache_free(struct kmem_cache *cache, void *x, unsigned long addr)
 {
-	do_slab_free(cache, virt_to_slab(x), x, NULL, 1, addr);
+	do_slab_free(cache, virt_to_slab(x), x, x, 1, addr);
 }
 #endif
 
 void __kmem_cache_free(struct kmem_cache *s, void *x, unsigned long caller)
 {
-	slab_free(s, virt_to_slab(x), x, NULL, &x, 1, caller);
+	slab_free(s, virt_to_slab(x), x, caller);
 }
 
 void kmem_cache_free(struct kmem_cache *s, void *x)
@@ -3836,7 +3847,7 @@ void kmem_cache_free(struct kmem_cache *s, void *x)
 	if (!s)
 		return;
 	trace_kmem_cache_free(_RET_IP_, x, s);
-	slab_free(s, virt_to_slab(x), x, NULL, &x, 1, _RET_IP_);
+	slab_free(s, virt_to_slab(x), x, _RET_IP_);
 }
 EXPORT_SYMBOL(kmem_cache_free);
 
@@ -3953,8 +3964,8 @@ void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
 		if (!df.slab)
 			continue;
 
-		slab_free(df.s, df.slab, df.freelist, df.tail, &p[size], df.cnt,
-			  _RET_IP_);
+		slab_free_bulk(df.s, df.slab, df.freelist, df.tail, &p[size],
+				df.cnt, _RET_IP_);
 	} while (likely(size));
 }
 EXPORT_SYMBOL(kmem_cache_free_bulk);

-- 
2.43.0

