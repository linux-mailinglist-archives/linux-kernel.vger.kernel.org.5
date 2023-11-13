Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3FA7EA392
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjKMTOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjKMTOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:14:19 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B6B172D;
        Mon, 13 Nov 2023 11:14:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9EC4921923;
        Mon, 13 Nov 2023 19:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1699902854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DXDFbKsOpifG8/vsvvlxkFBAPHyr1llZIqV93eRLOYA=;
        b=olZFTzZ/5Ps8QKyaocdiK69NiScVYAFfLitfcf3tciIng8f/eJUsk+7TdiSTEjSKOipVkV
        OMx8ieBdAUEwkOr1HjfTmuuDP4C1MsjfY0h10/LQHxmibB+io9RuxuTZ+OPZZBwcpY+Jz+
        3AXm3III4/0hk2ePVwyVCcJBkF/hrG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1699902854;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DXDFbKsOpifG8/vsvvlxkFBAPHyr1llZIqV93eRLOYA=;
        b=zDLN/9n/veB8vAzvY657LXWB2WULYF78tgVtB/1Im/Vy/330Jw/E161reEqQ4eBR0ap3o/
        QXfAFQftD8MjuPAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4424113907;
        Mon, 13 Nov 2023 19:14:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EGvoD4Z1UmVFOgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 13 Nov 2023 19:14:14 +0000
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
Subject: [PATCH 15/20] mm/slab: move kfree() from slab_common.c to slub.c
Date:   Mon, 13 Nov 2023 20:13:56 +0100
Message-ID: <20231113191340.17482-37-vbabka@suse.cz>
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

This should result in better code. Currently kfree() makes a function
call between compilation units to __kmem_cache_free() which does its own
virt_to_slab(), throwing away the struct slab pointer we already had in
kfree(). Now it can be reused. Additionally kfree() can now inline the
whole SLUB freeing fastpath.

Also move over free_large_kmalloc() as the only callsites are now in
slub.c, and make it static.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.h        |  4 ----
 mm/slab_common.c | 45 ------------------------------------------
 mm/slub.c        | 51 +++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 46 insertions(+), 54 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 1b09fd1b4b04..179467e8aacc 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -394,8 +394,6 @@ struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags, unsigned long caller);
 void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
 			      int node, size_t orig_size,
 			      unsigned long caller);
-void __kmem_cache_free(struct kmem_cache *s, void *x, unsigned long caller);
-
 gfp_t kmalloc_fix_flags(gfp_t flags);
 
 /* Functions provided by the slab allocators */
@@ -558,8 +556,6 @@ static inline int memcg_alloc_slab_cgroups(struct slab *slab,
 }
 #endif /* CONFIG_MEMCG_KMEM */
 
-void free_large_kmalloc(struct folio *folio, void *object);
-
 size_t __ksize(const void *objp);
 
 static inline size_t slab_ksize(const struct kmem_cache *s)
diff --git a/mm/slab_common.c b/mm/slab_common.c
index bbc2e3f061f1..f4f275613d2a 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -963,22 +963,6 @@ void __init create_kmalloc_caches(slab_flags_t flags)
 	slab_state = UP;
 }
 
-void free_large_kmalloc(struct folio *folio, void *object)
-{
-	unsigned int order = folio_order(folio);
-
-	if (WARN_ON_ONCE(order == 0))
-		pr_warn_once("object pointer: 0x%p\n", object);
-
-	kmemleak_free(object);
-	kasan_kfree_large(object);
-	kmsan_kfree_large(object);
-
-	mod_lruvec_page_state(folio_page(folio, 0), NR_SLAB_UNRECLAIMABLE_B,
-			      -(PAGE_SIZE << order));
-	__free_pages(folio_page(folio, 0), order);
-}
-
 static void *__kmalloc_large_node(size_t size, gfp_t flags, int node);
 static __always_inline
 void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
@@ -1023,35 +1007,6 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t flags,
 }
 EXPORT_SYMBOL(__kmalloc_node_track_caller);
 
-/**
- * kfree - free previously allocated memory
- * @object: pointer returned by kmalloc() or kmem_cache_alloc()
- *
- * If @object is NULL, no operation is performed.
- */
-void kfree(const void *object)
-{
-	struct folio *folio;
-	struct slab *slab;
-	struct kmem_cache *s;
-
-	trace_kfree(_RET_IP_, object);
-
-	if (unlikely(ZERO_OR_NULL_PTR(object)))
-		return;
-
-	folio = virt_to_folio(object);
-	if (unlikely(!folio_test_slab(folio))) {
-		free_large_kmalloc(folio, (void *)object);
-		return;
-	}
-
-	slab = folio_slab(folio);
-	s = slab->slab_cache;
-	__kmem_cache_free(s, (void *)object, _RET_IP_);
-}
-EXPORT_SYMBOL(kfree);
-
 /**
  * __ksize -- Report full size of underlying allocation
  * @object: pointer to the object
diff --git a/mm/slub.c b/mm/slub.c
index 0dbb966e28a7..52e2a65b1b11 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4184,11 +4184,6 @@ static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
 	return cachep;
 }
 
-void __kmem_cache_free(struct kmem_cache *s, void *x, unsigned long caller)
-{
-	slab_free(s, virt_to_slab(x), x, NULL, &x, 1, caller);
-}
-
 void kmem_cache_free(struct kmem_cache *s, void *x)
 {
 	s = cache_from_obj(s, x);
@@ -4199,6 +4194,52 @@ void kmem_cache_free(struct kmem_cache *s, void *x)
 }
 EXPORT_SYMBOL(kmem_cache_free);
 
+static void free_large_kmalloc(struct folio *folio, void *object)
+{
+	unsigned int order = folio_order(folio);
+
+	if (WARN_ON_ONCE(order == 0))
+		pr_warn_once("object pointer: 0x%p\n", object);
+
+	kmemleak_free(object);
+	kasan_kfree_large(object);
+	kmsan_kfree_large(object);
+
+	mod_lruvec_page_state(folio_page(folio, 0), NR_SLAB_UNRECLAIMABLE_B,
+			      -(PAGE_SIZE << order));
+	__free_pages(folio_page(folio, 0), order);
+}
+
+/**
+ * kfree - free previously allocated memory
+ * @object: pointer returned by kmalloc() or kmem_cache_alloc()
+ *
+ * If @object is NULL, no operation is performed.
+ */
+void kfree(const void *object)
+{
+	struct folio *folio;
+	struct slab *slab;
+	struct kmem_cache *s;
+	void *x = (void *)object;
+
+	trace_kfree(_RET_IP_, object);
+
+	if (unlikely(ZERO_OR_NULL_PTR(object)))
+		return;
+
+	folio = virt_to_folio(object);
+	if (unlikely(!folio_test_slab(folio))) {
+		free_large_kmalloc(folio, (void *)object);
+		return;
+	}
+
+	slab = folio_slab(folio);
+	s = slab->slab_cache;
+	slab_free(s, slab, x, NULL, &x, 1, _RET_IP_);
+}
+EXPORT_SYMBOL(kfree);
+
 struct detached_freelist {
 	struct slab *slab;
 	void *tail;
-- 
2.42.1

