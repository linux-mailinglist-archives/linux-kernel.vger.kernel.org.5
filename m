Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E00D7F5506
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344591AbjKVXvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344371AbjKVXvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:51:32 -0500
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E491BD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:51:28 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700697086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mEe01vZuhBVMx1XKVOUDl8ZkWzcchWHj6fYWExZ3dxw=;
        b=V6veXK29OF4QzImU3qPeNiZFjp8cdDseuoLawYjpHYCdoJYo7Ez+Yvnu/MgU14yaARHHzC
        yRRj5USqShi96DsHsjjQcaBwAK0Qgxx8uIL3Nu/l9tmExmUbt4qUVdhcdxaPOWDvm0YARv
        1907QwNn4icUGogbi1AF03BUxR5jYqc=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        peterz@infradead.org
Cc:     boqun.feng@gmail.com, longman@redhat.com, will@kernel.org,
        mingo@redhat.com, Kent Overstreet <kent.overstreet@gmail.com>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 5/6] bcachefs: Check for btree locks held on transaction init
Date:   Wed, 22 Nov 2023 18:51:12 -0500
Message-ID: <20231122235113.180132-6-kent.overstreet@linux.dev>
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

From: Kent Overstreet <kent.overstreet@gmail.com>

Ideally we would disallow multiple btree_trans being initialized within
the same process - and hopefully we will at some point, the stack usage
is excessive - but for now there are a couple places where we do this:

 - transaction commit error path -> journal reclaim - btree key cache
   flush
 - move data path -> do_pending_writes -> write path -> bucket
   allocation (in the near future when bucket allocation switches to
   using a freespace btree)

In order to avoid deadlocking the first btree_trans must have been
unlocked with bch2_trans_unlock() before using the second btree_trans -
this patch adds an assertion to bch2_trans_init() that verifies that
this has been done when lockdep is enabled.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/btree_iter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/bcachefs/btree_iter.c b/fs/bcachefs/btree_iter.c
index 1d734e297eb4..a52fd206f822 100644
--- a/fs/bcachefs/btree_iter.c
+++ b/fs/bcachefs/btree_iter.c
@@ -2854,6 +2854,8 @@ struct btree_trans *__bch2_trans_get(struct bch_fs *c, unsigned fn_idx)
 	struct btree_trans *trans;
 	struct btree_transaction_stats *s;
 
+	bch2_assert_btree_nodes_not_locked();
+
 	trans = bch2_trans_alloc(c);
 
 	memset(trans, 0, sizeof(*trans));
-- 
2.42.0

