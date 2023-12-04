Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C97803E7A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjLDTey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjLDTes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:34:48 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDE1E6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:34:54 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A51611FE6E;
        Mon,  4 Dec 2023 19:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1701718492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4fSahCwhPLa3fIglvL1TRmtTOqYm3xhkbDoawZHdw9A=;
        b=cYuegURdK6TarNJSSo68uWkNBOrhbmxZDmoXF/uS7znw/iEtrWLpnV32Dfv5L/PQtD6jMV
        QULfAq7/mAGtPm9Cbv6R2L7cGyXMaX4ps56QutuI/yGpFkZL7SUzA/8QS4L54o79rRjq4f
        NWPBKnLkVzZDYQTjYHbbwLf2ZFVPFKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1701718492;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4fSahCwhPLa3fIglvL1TRmtTOqYm3xhkbDoawZHdw9A=;
        b=z8JNsCGQ0Xr3e3YcoHYBA6JiZnYEPfBf9mIKjtgLx1BoQFMrFN0F1iTKMetguIwoGikLxp
        evtQCq2pw+erbpCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8875313AC2;
        Mon,  4 Dec 2023 19:34:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id OCn7INwpbmUPMwAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Mon, 04 Dec 2023 19:34:52 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
Date:   Mon, 04 Dec 2023 20:34:41 +0100
Subject: [PATCH 2/4] mm/slub: introduce __kmem_cache_free_bulk() without
 free hooks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231204-slub-cleanup-hooks-v1-2-88b65f7cd9d5@suse.cz>
References: <20231204-slub-cleanup-hooks-v1-0-88b65f7cd9d5@suse.cz>
In-Reply-To: <20231204-slub-cleanup-hooks-v1-0-88b65f7cd9d5@suse.cz>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.12.4
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Score: 3.33
X-Spamd-Result: default: False [3.33 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_SPAM(2.93)[93.30%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         R_RATELIMIT(0.00)[to_ip_from(RLtz7ce9b89hw8xzamye9qeynd)];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         RCPT_COUNT_TWELVE(0.00)[14];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[linux-foundation.org,linux.dev,gmail.com,google.com,kvack.org,vger.kernel.org,googlegroups.com,suse.cz];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

As a consequence, __kmem_cache_alloc_bulk() no longer needs the objcg
parameter, remove it.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index d7b0ca6012e0..0742564c4538 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4478,6 +4478,27 @@ int build_detached_freelist(struct kmem_cache *s, size_t size,
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
@@ -4499,7 +4520,7 @@ EXPORT_SYMBOL(kmem_cache_free_bulk);
 
 #ifndef CONFIG_SLUB_TINY
 static inline int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
-			size_t size, void **p, struct obj_cgroup *objcg)
+					  size_t size, void **p)
 {
 	struct kmem_cache_cpu *c;
 	unsigned long irqflags;
@@ -4563,14 +4584,13 @@ static inline int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
 
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
 
@@ -4593,8 +4613,7 @@ static int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
 	return i;
 
 error:
-	slab_post_alloc_hook(s, objcg, flags, i, p, false, s->object_size);
-	kmem_cache_free_bulk(s, i, p);
+	__kmem_cache_free_bulk(s, i, p);
 	return 0;
 }
 #endif /* CONFIG_SLUB_TINY */
@@ -4614,7 +4633,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	if (unlikely(!s))
 		return 0;
 
-	i = __kmem_cache_alloc_bulk(s, flags, size, p, objcg);
+	i = __kmem_cache_alloc_bulk(s, flags, size, p);
 
 	/*
 	 * memcg and kmem_cache debug support and memory initialization.

-- 
2.43.0

