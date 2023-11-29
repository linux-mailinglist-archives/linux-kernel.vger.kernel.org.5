Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78DE7FD350
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjK2JyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjK2Jxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:53:53 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9700A19BF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:53:39 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EEF061F8BD;
        Wed, 29 Nov 2023 09:53:37 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 911A113AA0;
        Wed, 29 Nov 2023 09:53:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id YPESIyEKZ2UrfQAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Wed, 29 Nov 2023 09:53:37 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
Date:   Wed, 29 Nov 2023 10:53:33 +0100
Subject: [PATCH RFC v3 8/9] maple_tree: Remove MA_STATE_PREALLOC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-slub-percpu-caches-v3-8-6bcf536772bc@suse.cz>
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
X-Spam-Level: 
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de;
        none
X-Rspamd-Queue-Id: EEF061F8BD
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
         TAGGED_RCPT(0.00)[];
         REPLY(-4.00)[]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@oracle.com>

MA_SATE_PREALLOC was added to catch any writes that try to allocate when
the maple state is being used in preallocation mode.  This can safely be
removed in favour of the percpu array of nodes.

Note that mas_expected_entries() still expects no allocations during
operation and so MA_STATE_BULK can be used in place of preallocations
for this case, which is primarily used for forking.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 lib/maple_tree.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index d9e7088fd9a7..f5c0bca2c5d7 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -68,11 +68,9 @@
  * Maple state flags
  * * MA_STATE_BULK		- Bulk insert mode
  * * MA_STATE_REBALANCE		- Indicate a rebalance during bulk insert
- * * MA_STATE_PREALLOC		- Preallocated nodes, WARN_ON allocation
  */
 #define MA_STATE_BULK		1
 #define MA_STATE_REBALANCE	2
-#define MA_STATE_PREALLOC	4
 
 #define ma_parent_ptr(x) ((struct maple_pnode *)(x))
 #define mas_tree_parent(x) ((unsigned long)(x->tree) | MA_ROOT_PARENT)
@@ -1255,11 +1253,8 @@ static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
 		return;
 
 	mas_set_alloc_req(mas, 0);
-	if (mas->mas_flags & MA_STATE_PREALLOC) {
-		if (allocated)
-			return;
-		WARN_ON(!allocated);
-	}
+	if (mas->mas_flags & MA_STATE_BULK)
+		return;
 
 	if (!allocated || mas->alloc->node_count == MAPLE_ALLOC_SLOTS) {
 		node = (struct maple_alloc *)mt_alloc_one(gfp);
@@ -5518,7 +5513,6 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 	/* node store, slot store needs one node */
 ask_now:
 	mas_node_count_gfp(mas, request, gfp);
-	mas->mas_flags |= MA_STATE_PREALLOC;
 	if (likely(!mas_is_err(mas)))
 		return 0;
 
@@ -5561,7 +5555,7 @@ void mas_destroy(struct ma_state *mas)
 
 		mas->mas_flags &= ~MA_STATE_REBALANCE;
 	}
-	mas->mas_flags &= ~(MA_STATE_BULK|MA_STATE_PREALLOC);
+	mas->mas_flags &= ~MA_STATE_BULK;
 
 	total = mas_allocated(mas);
 	while (total) {
@@ -5610,9 +5604,6 @@ int mas_expected_entries(struct ma_state *mas, unsigned long nr_entries)
 	 * of nodes during the operation.
 	 */
 
-	/* Optimize splitting for bulk insert in-order */
-	mas->mas_flags |= MA_STATE_BULK;
-
 	/*
 	 * Avoid overflow, assume a gap between each entry and a trailing null.
 	 * If this is wrong, it just means allocation can happen during
@@ -5629,8 +5620,9 @@ int mas_expected_entries(struct ma_state *mas, unsigned long nr_entries)
 	/* Add working room for split (2 nodes) + new parents */
 	mas_node_count_gfp(mas, nr_nodes + 3, GFP_KERNEL);
 
-	/* Detect if allocations run out */
-	mas->mas_flags |= MA_STATE_PREALLOC;
+	/* Optimize splitting for bulk insert in-order */
+	mas->mas_flags |= MA_STATE_BULK;
+
 
 	if (!mas_is_err(mas))
 		return 0;

-- 
2.43.0

