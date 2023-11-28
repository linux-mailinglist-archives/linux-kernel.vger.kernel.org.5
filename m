Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7237FC88C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376545AbjK1VNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346816AbjK1VMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:12:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1801FFE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:09:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1719C433B8;
        Tue, 28 Nov 2023 21:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205764;
        bh=OK76i06rqZHu7OVaftPcgvmDgd5Tpkk1MQpp8bUEU0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ALWzZdCzDrX8W/XYI3ki1n5ovazvM0pdhom7bFyraduamslm+AemjMlWXPejNs+Na
         6QO0NM51LCCv15jKLe5x1jaYnE1n1MDVWcZt0wh6L504X/hOQjZ7+iSXSCM4y2Aw6l
         xRy6fBCRMrEI0k37CF1T/iI8s6fCDmKJZBsap97hr0BjXcotL3RmStK4kANZtAI/PM
         35DFsGIo44yGTdRQhRaKgb2bQZk2zUto0Av2eS7XdQDr8XZHvJoQVRzesvxaGXHJ23
         kimqQll2J9u7/QcX0Pwi4fZidHd9Ceg/RkAQ/3+DQvEf5hXeU8s/d23d5ThXDJUbsX
         LK+7ujHt/59qA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, kent.overstreet@gmail.com,
        linux-bcache@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 06/13] bcache: avoid NULL checking to c->root in run_cache_set()
Date:   Tue, 28 Nov 2023 16:09:00 -0500
Message-ID: <20231128210914.876813-6-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210914.876813-1-sashal@kernel.org>
References: <20231128210914.876813-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.202
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Coly Li <colyli@suse.de>

[ Upstream commit 3eba5e0b2422aec3c9e79822029599961fdcab97 ]

In run_cache_set() after c->root returned from bch_btree_node_get(), it
is checked by IS_ERR_OR_NULL(). Indeed it is unncessary to check NULL
because bch_btree_node_get() will not return NULL pointer to caller.

This patch replaces IS_ERR_OR_NULL() by IS_ERR() for the above reason.

Signed-off-by: Coly Li <colyli@suse.de>
Link: https://lore.kernel.org/r/20231120052503.6122-11-colyli@suse.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 9c3e1632568c3..04ddaa4bbd77f 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2043,7 +2043,7 @@ static int run_cache_set(struct cache_set *c)
 		c->root = bch_btree_node_get(c, NULL, k,
 					     j->btree_level,
 					     true, NULL);
-		if (IS_ERR_OR_NULL(c->root))
+		if (IS_ERR(c->root))
 			goto err;
 
 		list_del_init(&c->root->list);
-- 
2.42.0

