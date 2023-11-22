Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85267F5507
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344340AbjKVXvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344503AbjKVXve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:51:34 -0500
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7931B9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:51:28 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700697087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Myq1bmeGBQIlDgNEhC6NfEwTgajaz4KUdFS8x/+ovE0=;
        b=A6re6fRtOjUFuLPZzy5AdlBTwdRPq7aLxjX6JGSBeKgnLzPIC/GD5yVCd0FuncsK/NGqOp
        7tuaaJJEUaw9FtVUiLOsADzufm1rX2U9EunUFQgJ1EW5LuRubvAKm9IXTo+TkZIcY5CZWA
        IiqZmoHO5PULFkkEhUpY6ZlHc4YKmEY=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        peterz@infradead.org
Cc:     boqun.feng@gmail.com, longman@redhat.com, will@kernel.org,
        mingo@redhat.com, Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 6/6] bcachefs: Switch to lockdep_set_no_check_recursion()
Date:   Wed, 22 Nov 2023 18:51:13 -0500
Message-ID: <20231122235113.180132-7-kent.overstreet@linux.dev>
In-Reply-To: <20231122235113.180132-1-kent.overstreet@linux.dev>
References: <20231122235113.180132-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/btree_locking.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/bcachefs/btree_locking.c b/fs/bcachefs/btree_locking.c
index ef84b0423deb..59c57c585a4c 100644
--- a/fs/bcachefs/btree_locking.c
+++ b/fs/bcachefs/btree_locking.c
@@ -10,7 +10,9 @@ void bch2_btree_lock_init(struct btree_bkey_cached_common *b,
 			  enum six_lock_init_flags flags)
 {
 	__six_lock_init(&b->lock, "b->c.lock", &bch2_btree_node_lock_key, flags);
-	lockdep_set_novalidate_class(&b->lock);
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	lockdep_set_no_check_recursion(&b->lock.dep_map);
+#endif
 }
 
 #ifdef CONFIG_LOCKDEP
-- 
2.42.0

