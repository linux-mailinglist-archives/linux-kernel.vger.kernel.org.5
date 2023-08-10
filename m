Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2D1777E6A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbjHJQgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbjHJQgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:36:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF5E103
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:36:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 614A21F750;
        Thu, 10 Aug 2023 16:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691685393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=81VWuf1Jqzz86k9wDN7LrYfBK2s1ZDCqD4SXLtwC3uA=;
        b=vGJ6/1WteLNGdLHhKpW6hrMYCuWBe6WzoYcWBYsk/0kPZb7z0w1EKu7Caou9OwoQqM0QPD
        hTllK+yJdN9fv7kLVpgI2tCN5xKxsmExHBA4r/mVMBQaMFAfb4YFTFCu538cEnR6H1DKSn
        dLBkK+T1U+VHRemqTiutB021iD242/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691685393;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=81VWuf1Jqzz86k9wDN7LrYfBK2s1ZDCqD4SXLtwC3uA=;
        b=9x9XyqLN8gJpEQKeJMyMY/R1t7RGpoiajCpyEbPmS092cPUZLAJeo+as7qvBiBUDFncs97
        rZ5jw5kHYfhuUuBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 329D1139D1;
        Thu, 10 Aug 2023 16:36:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GPC5CxES1WSEPQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 10 Aug 2023 16:36:33 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC v2 5/7] maple_tree: Remove MA_STATE_PREALLOC
Date:   Thu, 10 Aug 2023 18:36:33 +0200
Message-ID: <20230810163627.6206-14-vbabka@suse.cz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810163627.6206-9-vbabka@suse.cz>
References: <20230810163627.6206-9-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
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
 lib/maple_tree.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 926bee7a274a..8bd4a79537d8 100644
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
 #define ma_mnode_ptr(x) ((struct maple_node *)(x))
@@ -1280,11 +1278,8 @@ static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
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
@@ -5596,7 +5591,7 @@ void mas_destroy(struct ma_state *mas)
 
 		mas->mas_flags &= ~MA_STATE_REBALANCE;
 	}
-	mas->mas_flags &= ~(MA_STATE_BULK|MA_STATE_PREALLOC);
+	mas->mas_flags &= ~MA_STATE_BULK;
 
 	total = mas_allocated(mas);
 	while (total) {
@@ -5645,9 +5640,6 @@ int mas_expected_entries(struct ma_state *mas, unsigned long nr_entries)
 	 * of nodes during the operation.
 	 */
 
-	/* Optimize splitting for bulk insert in-order */
-	mas->mas_flags |= MA_STATE_BULK;
-
 	/*
 	 * Avoid overflow, assume a gap between each entry and a trailing null.
 	 * If this is wrong, it just means allocation can happen during
@@ -5664,8 +5656,9 @@ int mas_expected_entries(struct ma_state *mas, unsigned long nr_entries)
 	/* Add working room for split (2 nodes) + new parents */
 	mas_node_count(mas, nr_nodes + 3);
 
-	/* Detect if allocations run out */
-	mas->mas_flags |= MA_STATE_PREALLOC;
+	/* Optimize splitting for bulk insert in-order */
+	mas->mas_flags |= MA_STATE_BULK;
+
 
 	if (!mas_is_err(mas))
 		return 0;
-- 
2.41.0

