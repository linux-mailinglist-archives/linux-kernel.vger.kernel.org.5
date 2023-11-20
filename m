Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCE77F1CB1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 19:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjKTSfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 13:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjKTSe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 13:34:56 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCB9110;
        Mon, 20 Nov 2023 10:34:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 150A71F8AB;
        Mon, 20 Nov 2023 18:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1700505284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=66Fcft8CxLuyGHKa/ns5P/AtbVP/SvETjQ6dsoMJ/dY=;
        b=lMWFwPyefenNyh7/clvx/qk+stHQQ5N7hb9zBmCMeupxTPI+D6dGU/TADQ1u5M32UH+IBC
        fbQGY+u8lJJ8xR7VIM1PukvUBJEbUUw6tEAIWsnx+w1U5RfwCcRoqU/FIRxofF8z90UkRm
        3dW6SMf1sSFeVNgXgr0JhhA3Fozsnbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1700505284;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=66Fcft8CxLuyGHKa/ns5P/AtbVP/SvETjQ6dsoMJ/dY=;
        b=2WYXGethB6aGSlwwFVtp6ZCxtnU8BDR7TlSKHnTc/eY0M0e5JG5Si0/T6HS0tBqTGGaxCU
        vUR3uQ9DA9xC1JCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8DFC13912;
        Mon, 20 Nov 2023 18:34:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ULBvMMOmW2UUMgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 20 Nov 2023 18:34:43 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
Date:   Mon, 20 Nov 2023 19:34:30 +0100
Subject: [PATCH v2 19/21] mm/slub: remove slab_alloc() and
 __kmem_cache_alloc_lru() wrappers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231120-slab-remove-slab-v2-19-9c9c70177183@suse.cz>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
In-Reply-To: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
To:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
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
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org, linux-hardening@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.12.4
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Score: 1.30
X-Spamd-Result: default: False [1.30 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         RCVD_TLS_ALL(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         R_RATELIMIT(0.00)[to_ip_from(RL563rtnmcmc9sawm86hmgtctc)];
         BAYES_SPAM(5.10)[100.00%];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[24];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,linux.dev,google.com,arm.com,cmpxchg.org,kernel.org,chromium.org,kvack.org,vger.kernel.org,googlegroups.com,suse.cz];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[]
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

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index d6bc15929d22..5683f1d02e4f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3821,33 +3821,26 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
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
 

-- 
2.42.1

