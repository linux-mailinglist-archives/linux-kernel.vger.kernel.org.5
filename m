Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EDA7EA38C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjKMTOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjKMTOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:14:19 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1592172C;
        Mon, 13 Nov 2023 11:14:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 43E4121921;
        Mon, 13 Nov 2023 19:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1699902854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uxDKJC7EaSr87DEKt16Pu1EQtaytOZJplZCJuXCflPQ=;
        b=RpQWn4sNOjvxQkBfvziEPCXxoX0JJgRJTkNkPNoDx/u5y33ryL9WYixguPSuIwJapxRSFp
        AnfCHIeUs+kc3EO/R4GuVNcDzoOC4rSh0NBIXZNFQwxvjDZLRjFCum/optDZuilffC474u
        tee5JYU2/7OLrEmYmcRFK7UVMMWoqUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1699902854;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uxDKJC7EaSr87DEKt16Pu1EQtaytOZJplZCJuXCflPQ=;
        b=J0Xb8K74DAapEo1JughDOaWB/XF9aekqQd4Wz+eKRt3buDbcskFeZhJrmp1eaLQ4qLv7NQ
        4nRKvtRZ93s5I0Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E25AE13398;
        Mon, 13 Nov 2023 19:14:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QNKnNoV1UmVFOgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 13 Nov 2023 19:14:13 +0000
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
Subject: [PATCH 14/20] mm/slab: move struct kmem_cache_node from slab.h to slub.c
Date:   Mon, 13 Nov 2023 20:13:55 +0100
Message-ID: <20231113191340.17482-36-vbabka@suse.cz>
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

The declaration and associated helpers are not used anywhere else
anymore.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.h | 29 -----------------------------
 mm/slub.c | 27 +++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 8de9780d345a..1b09fd1b4b04 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -587,35 +587,6 @@ static inline size_t slab_ksize(const struct kmem_cache *s)
 	return s->size;
 }
 
-
-/*
- * The slab lists for all objects.
- */
-struct kmem_cache_node {
-	spinlock_t list_lock;
-	unsigned long nr_partial;
-	struct list_head partial;
-#ifdef CONFIG_SLUB_DEBUG
-	atomic_long_t nr_slabs;
-	atomic_long_t total_objects;
-	struct list_head full;
-#endif
-};
-
-static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
-{
-	return s->node[node];
-}
-
-/*
- * Iterator over all nodes. The body will be executed for each node that has
- * a kmem_cache_node structure allocated (which is true for all online nodes)
- */
-#define for_each_kmem_cache_node(__s, __node, __n) \
-	for (__node = 0; __node < nr_node_ids; __node++) \
-		 if ((__n = get_node(__s, __node)))
-
-
 #ifdef CONFIG_SLUB_DEBUG
 void dump_unreclaimable_slab(void);
 #else
diff --git a/mm/slub.c b/mm/slub.c
index 25ff9d2d44a8..0dbb966e28a7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -396,6 +396,33 @@ static inline void stat(const struct kmem_cache *s, enum stat_item si)
 #endif
 }
 
+/*
+ * The slab lists for all objects.
+ */
+struct kmem_cache_node {
+	spinlock_t list_lock;
+	unsigned long nr_partial;
+	struct list_head partial;
+#ifdef CONFIG_SLUB_DEBUG
+	atomic_long_t nr_slabs;
+	atomic_long_t total_objects;
+	struct list_head full;
+#endif
+};
+
+static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
+{
+	return s->node[node];
+}
+
+/*
+ * Iterator over all nodes. The body will be executed for each node that has
+ * a kmem_cache_node structure allocated (which is true for all online nodes)
+ */
+#define for_each_kmem_cache_node(__s, __node, __n) \
+	for (__node = 0; __node < nr_node_ids; __node++) \
+		 if ((__n = get_node(__s, __node)))
+
 /*
  * Tracks for which NUMA nodes we have kmem_cache_nodes allocated.
  * Corresponds to node_state[N_NORMAL_MEMORY], but can temporarily
-- 
2.42.1

