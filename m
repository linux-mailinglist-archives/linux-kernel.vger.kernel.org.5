Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB827F5508
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344448AbjKVXvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344340AbjKVXva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:51:30 -0500
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A381B6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:51:26 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700697085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c+NluGMH3ACG9C4v9tyqVQmooH2gf0OtbH4WLDdZuu0=;
        b=BJsnfUsB9ZLj8D6Kc7ijV5SCXDed20HLPXGuLTFxO8HCXbfj4PZyhQtvTG7tbFUx8tPTOF
        rTLXP125eU5rcyA+YdX/EbKGzKIozsWvGKwF5gD6mq4y0PelGref6XbkacJM0MZJlRTy2m
        CZJaVNKT/DluYq8juvZ9fNIjz/meEqE=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        peterz@infradead.org
Cc:     boqun.feng@gmail.com, longman@redhat.com, will@kernel.org,
        mingo@redhat.com, Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 4/6] bcachefs: Use lock_class_is_held() for btree locking asserts
Date:   Wed, 22 Nov 2023 18:51:11 -0500
Message-ID: <20231122235113.180132-5-kent.overstreet@linux.dev>
In-Reply-To: <20231122235113.180132-1-kent.overstreet@linux.dev>
References: <20231122235113.180132-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/btree_locking.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/bcachefs/btree_locking.c b/fs/bcachefs/btree_locking.c
index 308c891ad3ca..ef84b0423deb 100644
--- a/fs/bcachefs/btree_locking.c
+++ b/fs/bcachefs/btree_locking.c
@@ -16,10 +16,7 @@ void bch2_btree_lock_init(struct btree_bkey_cached_common *b,
 #ifdef CONFIG_LOCKDEP
 void bch2_assert_btree_nodes_not_locked(void)
 {
-#if 0
-	//Re-enable when lock_class_is_held() is merged:
 	BUG_ON(lock_class_is_held(&bch2_btree_node_lock_key));
-#endif
 }
 #endif
 
-- 
2.42.0

