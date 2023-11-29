Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332777FD353
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjK2Jyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjK2Jxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:53:55 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF3D2683
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:53:40 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 44CA81F8B9;
        Wed, 29 Nov 2023 09:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1701251617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z/MdY/rw/HJ2oq6eayRQ1jISyVijjFBbUkDkU5iKbc8=;
        b=JSaWHQ5ngHNR9h0BjZPRO9pLV15+bY/sEiVQLXEtaalvdmi6pmxe9eubOmuCdSSXeNh/Sb
        Nh4DIf+6GCzwc4Z9cmo4/0h6AQF8+HTMP/IskJTEjbgBOYzfWDDmc9KEj599VKQ98q9w7M
        A6yjwcRMpx9Ot6/k9lkxkNg8+uMSuPs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1701251617;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z/MdY/rw/HJ2oq6eayRQ1jISyVijjFBbUkDkU5iKbc8=;
        b=F3IPQ3NkAI4OgYj5R6JdEz852oBdNpOhcIfg0KleOLz7BA8tL0iO7eyPul69JqVGKjb/Zt
        uYSShywwUe5LzyAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 240B213A9A;
        Wed, 29 Nov 2023 09:53:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id +GmBCCEKZ2UrfQAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Wed, 29 Nov 2023 09:53:37 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
Date:   Wed, 29 Nov 2023 10:53:29 +0100
Subject: [PATCH RFC v3 4/9] mm/slub: free KFENCE objects in
 slab_free_hook()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-slub-percpu-caches-v3-4-6bcf536772bc@suse.cz>
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
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         BAYES_HAM(-3.00)[100.00%];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[17];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[linux-foundation.org,linux.dev,gmail.com,google.com,kvack.org,vger.kernel.org,lists.infradead.org,googlegroups.com,suse.cz];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -2.80
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When freeing an object that was allocated from KFENCE, we do that in the
slowpath __slab_free(), relying on the fact that KFENCE "slab" cannot be
the cpu slab, so the fastpath has to fallback to the slowpath.

This optimization doesn't help much though, because is_kfence_address()
is checked earlier anyway during the free hook processing or detached
freelist building. Thus we can simplify the code by making the
slab_free_hook() free the KFENCE object immediately, similarly to KASAN
quarantine.

In slab_free_hook() we can place kfence_free() above init processing, as
callers have been making sure to set init to false for KFENCE objects.
This simplifies slab_free(). This places it also above kasan_slab_free()
which is ok as that skips KFENCE objects anyway.

While at it also determine the init value in slab_free_freelist_hook()
outside of the loop.

This change will also make introducing per cpu array caches easier.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 7d23f10d42e6..59912a376c6d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1772,7 +1772,7 @@ static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
  * production configuration these hooks all should produce no code at all.
  *
  * Returns true if freeing of the object can proceed, false if its reuse
- * was delayed by KASAN quarantine.
+ * was delayed by KASAN quarantine, or it was returned to KFENCE.
  */
 static __always_inline
 bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
@@ -1790,6 +1790,9 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
 		__kcsan_check_access(x, s->object_size,
 				     KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT);
 
+	if (kfence_free(kasan_reset_tag(x)))
+		return false;
+
 	/*
 	 * As memory initialization might be integrated into KASAN,
 	 * kasan_slab_free and initialization memset's must be
@@ -1819,22 +1822,25 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
 	void *object;
 	void *next = *head;
 	void *old_tail = *tail;
+	bool init;
 
 	if (is_kfence_address(next)) {
 		slab_free_hook(s, next, false);
-		return true;
+		return false;
 	}
 
 	/* Head and tail of the reconstructed freelist */
 	*head = NULL;
 	*tail = NULL;
 
+	init = slab_want_init_on_free(s);
+
 	do {
 		object = next;
 		next = get_freepointer(s, object);
 
 		/* If object's reuse doesn't have to be delayed */
-		if (slab_free_hook(s, object, slab_want_init_on_free(s))) {
+		if (slab_free_hook(s, object, init)) {
 			/* Move object to the new freelist */
 			set_freepointer(s, object, *head);
 			*head = object;
@@ -3619,9 +3625,6 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 
 	stat(s, FREE_SLOWPATH);
 
-	if (kfence_free(head))
-		return;
-
 	if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
 		free_to_partial_list(s, slab, head, tail, cnt, addr);
 		return;
@@ -3806,13 +3809,9 @@ static __fastpath_inline
 void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
 	       unsigned long addr)
 {
-	bool init;
-
 	memcg_slab_free_hook(s, slab, &object, 1);
 
-	init = !is_kfence_address(object) && slab_want_init_on_free(s);
-
-	if (likely(slab_free_hook(s, object, init)))
+	if (likely(slab_free_hook(s, object, slab_want_init_on_free(s))))
 		do_slab_free(s, slab, object, object, 1, addr);
 }
 

-- 
2.43.0

