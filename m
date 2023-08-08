Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCC4773EC2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbjHHQfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbjHHQea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:34:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01B990AD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:52:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7C5062248B;
        Tue,  8 Aug 2023 09:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691488433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=19m9+YAryd9zQqOJKLPS0ScJg55yhuc9Zn7O2SmAkY8=;
        b=0ypz/M4hFEYVg3RIkyKTZpGOtO0OELdvePk4KsvNp0QXKtSQ1NTkwvJ6x9bkVpsk5ACEo+
        VdhEFCaw7TRHrCXiaOhP4fR0hWTfeBY2vexIA+Fg3uiY/xr+RGb+kCzEL8ZCXD6x0fD/My
        6dCsKBwvmBeEB1+gOW5PonTGZTXEndk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691488433;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=19m9+YAryd9zQqOJKLPS0ScJg55yhuc9Zn7O2SmAkY8=;
        b=gHwsy0hibpgfl2awLPIMsMc4dKqncic8vqqIN/UioyCepHOo4bgnZRyoxdFoRXKIOTGPXa
        oVyI5GXsppN4AdBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53972139E9;
        Tue,  8 Aug 2023 09:53:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eKi8E7EQ0mSBJQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 08 Aug 2023 09:53:53 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC v1 5/5] maple_tree: replace preallocation with slub percpu array prefill
Date:   Tue,  8 Aug 2023 11:53:48 +0200
Message-ID: <20230808095342.12637-12-vbabka@suse.cz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808095342.12637-7-vbabka@suse.cz>
References: <20230808095342.12637-7-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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

First I tried to change mas_node_count_gfp() to not preallocate anything
anywhere, but that lead to warns and panics, even though the other
caller mas_node_count() uses GFP_NOWAIT | __GFP_NOWARN so it has no
guarantees... So I changed just mas_preallocate(). I let it still to
truly preallocate a single node, but maybe it's not necessary?
---
 lib/maple_tree.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 7a8e7c467d7c..5a209d88c318 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5534,7 +5534,12 @@ void mas_store_prealloc(struct ma_state *mas, void *entry)
 
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
@@ -5550,9 +5555,10 @@ EXPORT_SYMBOL_GPL(mas_store_prealloc);
 int mas_preallocate(struct ma_state *mas, gfp_t gfp)
 {
 	int ret;
+	int count = 1 + mas_mt_height(mas) * 3;
 
-	mas_node_count_gfp(mas, 1 + mas_mt_height(mas) * 3, gfp);
-	mas->mas_flags |= MA_STATE_PREALLOC;
+	mas_node_count_gfp(mas, 1, gfp);
+	kmem_cache_prefill_percpu_array(maple_node_cache, count, gfp);
 	if (likely(!mas_is_err(mas)))
 		return 0;
 
-- 
2.41.0

