Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E30F777E6B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbjHJQgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbjHJQgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:36:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1496690
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:36:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8DD541F855;
        Thu, 10 Aug 2023 16:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691685393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0YgBKGsaXsGLSxrzXPhBkvZQSAlAP3ciKJFIHzEnvRY=;
        b=ahOAhspPOh9gWRokiULaPvSVlO7+FXuxKO4tvOHBGWkFdq68YuUC556iHKh4f3O7IPBUEb
        9+o7trNIK7n0OsSei8wrjxwksDOg4QP9utkyO1S6+9mIqAA9POXLcynrS+eRBvJDWA5e2u
        SJ68T9v+Br03Qj02Wz/h3oGxsa+KMn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691685393;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0YgBKGsaXsGLSxrzXPhBkvZQSAlAP3ciKJFIHzEnvRY=;
        b=Cj3pdlbc0C8qo51lQJTDCKqNdKlP6jg3SiLPuDNcG94XPwf5LjRYss+oyxhSePhcqfnwz9
        44KQ/fhVgwG1ijAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 63EF5138E0;
        Thu, 10 Aug 2023 16:36:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SEF4FxES1WSEPQAAMHmgww
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
Subject: [RFC v2 6/7] maple_tree: replace preallocation with slub percpu array prefill
Date:   Thu, 10 Aug 2023 18:36:34 +0200
Message-ID: <20230810163627.6206-15-vbabka@suse.cz>
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

With the percpu array we can try not doing the preallocations in maple
tree, and instead make sure the percpu array is prefilled, and using
GFP_ATOMIC in places that relied on the preallocation (in case we miss
or fail trylock on the array), i.e. mas_store_prealloc(). For now simply
add __GFP_NOFAIL there as well.
---
 lib/maple_tree.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 8bd4a79537d8..304f2453fac9 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5530,7 +5530,12 @@ void mas_store_prealloc(struct ma_state *mas, void *entry)
 
 	mas_wr_store_setup(&wr_mas);
 	trace_ma_write(__func__, mas, 0, entry);
+
+retry:
 	mas_wr_store_entry(&wr_mas);
+	if (unlikely(mas_nomem(mas, GFP_ATOMIC | __GFP_NOFAIL)))
+		goto retry;
+
 	MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
 	mas_destroy(mas);
 }
@@ -5545,19 +5550,12 @@ EXPORT_SYMBOL_GPL(mas_store_prealloc);
  */
 int mas_preallocate(struct ma_state *mas, gfp_t gfp)
 {
-	int ret;
+	int count = 1 + mas_mt_height(mas) * 3;
 
-	mas_node_count_gfp(mas, 1 + mas_mt_height(mas) * 3, gfp);
-	mas->mas_flags |= MA_STATE_PREALLOC;
-	if (likely(!mas_is_err(mas)))
-		return 0;
+	// TODO: should probably indicate if it failed the prefill?
+	kmem_cache_prefill_percpu_array(maple_node_cache, count, gfp);
 
-	mas_set_alloc_req(mas, 0);
-	ret = xa_err(mas->node);
-	mas_reset(mas);
-	mas_destroy(mas);
-	mas_reset(mas);
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(mas_preallocate);
 
-- 
2.41.0

