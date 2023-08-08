Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11328773DBD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjHHQV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjHHQT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:19:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A219001
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:49:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 244E520319;
        Tue,  8 Aug 2023 09:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691488433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a3DtkVdLGQHDYk90N/OXEPjHa8PNLxLzj/qp7wDJMuQ=;
        b=TM63PQDL1/kV/0eRyfhNJd9mTnr0x7YZSgjc8gu+OShasFlpsvfTd29e6XuZUTzyIuOzKh
        epAVCCvXUWmkzTZ+F27l6Dqs/VEedrJReg+43nUQbnAOrW9MhnfDcJEo+daT4fyDfyI7+2
        tuJoCLZ60xeq+ygkOsdBQLf9xHRywQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691488433;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a3DtkVdLGQHDYk90N/OXEPjHa8PNLxLzj/qp7wDJMuQ=;
        b=PMYk4+pst66z0H1Ard3n4p3Ej4MlqgpLiQdaPFhRHz+PTuyTYA3lk/x+G2Bsq/DLk5blTG
        bJlASInXsVjsuJBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED5F6139E9;
        Tue,  8 Aug 2023 09:53:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IP9CObAQ0mSBJQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 08 Aug 2023 09:53:52 +0000
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
Subject: [RFC v1 3/5] maple_tree: use slub percpu array
Date:   Tue,  8 Aug 2023 11:53:46 +0200
Message-ID: <20230808095342.12637-10-vbabka@suse.cz>
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

Just make sure the maple_node_cache has a percpu array of size 32.

Will break with CONFIG_SLAB.
---
 lib/maple_tree.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 4dd73cf936a6..1196d0a17f03 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6180,9 +6180,16 @@ bool mas_nomem(struct ma_state *mas, gfp_t gfp)
 
 void __init maple_tree_init(void)
 {
+	int ret;
+
 	maple_node_cache = kmem_cache_create("maple_node",
 			sizeof(struct maple_node), sizeof(struct maple_node),
-			SLAB_PANIC, NULL);
+			SLAB_PANIC | SLAB_NO_MERGE, NULL);
+
+	ret = kmem_cache_setup_percpu_array(maple_node_cache, 32);
+
+	if (ret)
+		pr_warn("error %d creating percpu_array for maple_node_cache\n", ret);
 }
 
 /**
-- 
2.41.0

