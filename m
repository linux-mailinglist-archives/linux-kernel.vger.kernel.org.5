Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711A8773EC3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbjHHQfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbjHHQeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:34:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E62090AE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:52:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5CA9E2248A;
        Tue,  8 Aug 2023 09:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691488433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i6TQwXZ4v9nk5j9z/G1P0QjfrlA/rpwYdzHk2PVBTRo=;
        b=sMK735vGrxWU1VYbx6RUmceJoQbzNocoGXJWDnHnQMuYYl5OwU3eFj+3qgZ8Ba0mFBaNLq
        Oq7pXw3+pm/6X820956mlj1IpRt+1zQo128JYQOLdIXM+09UMZwOMLvmaDtJEvC7VeLAxw
        oWjOyz1mC/TZfMdOelpD4y7kBG9k37Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691488433;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i6TQwXZ4v9nk5j9z/G1P0QjfrlA/rpwYdzHk2PVBTRo=;
        b=qySqY3LEh48iTLSTZF1kLGV3kFsl/U5DLBfmwlVvoTvtGqeP3Z4gT7neP5svnR3Q21mOnH
        hlN2F/r3TLQ+AODw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2649513451;
        Tue,  8 Aug 2023 09:53:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AFq7CLEQ0mSBJQAAMHmgww
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
Subject: [RFC v1 4/5] maple_tree: avoid bulk alloc/free to use percpu array more
Date:   Tue,  8 Aug 2023 11:53:47 +0200
Message-ID: <20230808095342.12637-11-vbabka@suse.cz>
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

Using bulk alloc/free on a cache with percpu array should not be
necessary and the bulk alloc actually bypasses the array (the prefill
functionality currently relies on this).

The simplest change is just to convert the respective maple tree
wrappers to do a loop of normal alloc/free.
---
 lib/maple_tree.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 1196d0a17f03..7a8e7c467d7c 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -161,12 +161,19 @@ static inline struct maple_node *mt_alloc_one(gfp_t gfp)
 
 static inline int mt_alloc_bulk(gfp_t gfp, size_t size, void **nodes)
 {
-	return kmem_cache_alloc_bulk(maple_node_cache, gfp, size, nodes);
+	int allocated = 0;
+	for (size_t i = 0; i < size; i++) {
+		nodes[i] = kmem_cache_alloc(maple_node_cache, gfp);
+		if (nodes[i])
+			allocated++;
+	}
+	return allocated;
 }
 
 static inline void mt_free_bulk(size_t size, void __rcu **nodes)
 {
-	kmem_cache_free_bulk(maple_node_cache, size, (void **)nodes);
+	for (size_t i = 0; i < size; i++)
+		kmem_cache_free(maple_node_cache, nodes[i]);
 }
 
 static void mt_free_rcu(struct rcu_head *head)
-- 
2.41.0

