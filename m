Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EAC803E77
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbjLDTet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjLDTes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:34:48 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD56C1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:34:53 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8DF80220FD;
        Mon,  4 Dec 2023 19:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1701718492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EqcJTAjZFB8lQHDKYDjIZchVKot1dBAP9whijzHZRBs=;
        b=3aoiT3paks0mcXiEeezN/xPw9jv7Di3tra3+7n/QDct0IcBebFNeztkLnzZNR1eA+r+5P7
        5HTYlXZjd6w/d/4hPiYwAl8U4a6RDNwPAenVha70NBnhh7hjIhw5Mnrb5mEfP6x/vm7DcI
        RvtCEN+PAXA5BPRclQuH0Zu5ugFOvzQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1701718492;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EqcJTAjZFB8lQHDKYDjIZchVKot1dBAP9whijzHZRBs=;
        b=LJvwh73CRk0ogt5DyHZYk9KKPNPbooLArhcWhOV7Z8vEi3KnNjT7llf/nkqXmRF2A2S/E1
        I9N7BuX+zof3jCDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70C1D13AC1;
        Mon,  4 Dec 2023 19:34:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id KHI2G9wpbmUPMwAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Mon, 04 Dec 2023 19:34:52 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
Date:   Mon, 04 Dec 2023 20:34:40 +0100
Subject: [PATCH 1/4] mm/slub: fix bulk alloc and free stats
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231204-slub-cleanup-hooks-v1-1-88b65f7cd9d5@suse.cz>
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
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spamd-Result: default: False [0.20 / 50.00];
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
         BAYES_HAM(-0.00)[15.64%];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[14];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[linux-foundation.org,linux.dev,gmail.com,google.com,kvack.org,vger.kernel.org,googlegroups.com,suse.cz];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 0.20
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SLUB sysfs stats enabled CONFIG_SLUB_STATS have two deficiencies
identified wrt bulk alloc/free operations:

- Bulk allocations from cpu freelist are not counted. Add the
  ALLOC_FASTPATH counter there.

- Bulk fastpath freeing will count a list of multiple objects with a
  single FREE_FASTPATH inc. Add a stat_add() variant to count them all.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 3f8b95757106..d7b0ca6012e0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -396,6 +396,14 @@ static inline void stat(const struct kmem_cache *s, enum stat_item si)
 #endif
 }
 
+static inline
+void stat_add(const struct kmem_cache *s, enum stat_item si, int v)
+{
+#ifdef CONFIG_SLUB_STATS
+	raw_cpu_add(s->cpu_slab->stat[si], v);
+#endif
+}
+
 /*
  * The slab lists for all objects.
  */
@@ -4268,7 +4276,7 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 
 		local_unlock(&s->cpu_slab->lock);
 	}
-	stat(s, FREE_FASTPATH);
+	stat_add(s, FREE_FASTPATH, cnt);
 }
 #else /* CONFIG_SLUB_TINY */
 static void do_slab_free(struct kmem_cache *s,
@@ -4545,6 +4553,7 @@ static inline int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
 		c->freelist = get_freepointer(s, object);
 		p[i] = object;
 		maybe_wipe_obj_freeptr(s, p[i]);
+		stat(s, ALLOC_FASTPATH);
 	}
 	c->tid = next_tid(c->tid);
 	local_unlock_irqrestore(&s->cpu_slab->lock, irqflags);

-- 
2.43.0

