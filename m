Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793577E8CC8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 22:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjKKVCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 16:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjKKVCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 16:02:17 -0500
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0BA30EB
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 13:02:12 -0800 (PST)
Date:   Sat, 11 Nov 2023 16:02:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699736531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h71eiJiYUIXKHjvWV8U3pwxJhAF67oyh2afFpTVLWW0=;
        b=fr2LCtM8LEhD4XJvWckMcGz6FY2ao00sQvcv5uKfFpg/wxbsNiJ7g5gOZYJMmAj3sGjuLh
        v3Cq82PrIfIVVOu48vT8x1IEA78x5DWSkzJti2KgISQwPBLUxgcyOUj4gKMdrBH4yqs1+N
        MGdZwZn5Jag7ALyObef45KLiuFPmU98=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] bcachefs: remove redundant initialization of
 variable level
Message-ID: <20231111210208.qra7xhf2nd4pqvst@moria.home.lan>
References: <20231111204528.339603-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231111204528.339603-1-colin.i.king@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2023 at 08:45:28PM +0000, Colin Ian King wrote:
> Variable level is being initialized a value that is never read, the
> variable is being re-assigned another value several statements later
> on. The initialization is redundant and can be removed. Cleans up
> clang scan build warning:
> 
> fs/bcachefs/btree_iter.c:1217:11: warning: Value stored to 'level'
> during its initialization is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

since we're no longer gnu89, we can simply declare the variable when
it's first used, like so:

diff --git a/fs/bcachefs/btree_iter.c b/fs/bcachefs/btree_iter.c
index 96bdf0c6051c..104172f6822b 100644
--- a/fs/bcachefs/btree_iter.c
+++ b/fs/bcachefs/btree_iter.c
@@ -1214,8 +1214,6 @@ __bch2_btree_path_set_pos(struct btree_trans *trans,
 		   struct btree_path *path, struct bpos new_pos,
 		   bool intent, unsigned long ip, int cmp)
 {
-	unsigned level = path->level;
-
 	bch2_trans_verify_not_in_restart(trans);
 	EBUG_ON(!path->ref);
 
@@ -1231,7 +1229,7 @@ __bch2_btree_path_set_pos(struct btree_trans *trans,
 		goto out;
 	}
 
-	level = btree_path_up_until_good_node(trans, path, cmp);
+	unsigned level = btree_path_up_until_good_node(trans, path, cmp);
 
 	if (btree_path_node(path, level)) {
 		struct btree_path_level *l = &path->l[level];
