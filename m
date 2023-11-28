Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366FF7FC867
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376563AbjK1VPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346847AbjK1VOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:14:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E593A8E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:10:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7EBC43140;
        Tue, 28 Nov 2023 21:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205808;
        bh=8sWl0VD40rNw244o7yO5xqupCAKOvu6uNQWiQMcF3Vk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wit8FhkbnEyeLFkJIWQ6si2yAOOayXdelaZWgK37tw0w/r7lr7qDDv9WFbDRxCX6G
         IwVpY4xDWjGQnfQwOFF5M9lKGwwUTPaRvCeDLot3+Wwgn4JXbthm2lqrMdYME3nm7M
         kHp8nBTKFAeaefaurabtnFHp4P6EdMONwdNmifwAFmbnCb+2QkTjFDt44Io54WwLpx
         Zd3GCCdtCbWHTDPnJNaLIBbN4zbq1WuVuweRM5YHN6JYPTWEzNn+z16CKpfmzwNZby
         eTPTx7j7DKF6BFWCSY331PRBqGD+NapniuutC+2lvZD8kwqJV9EH0lVVxjyNPbAqpY
         hrFCqoUiATArg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, kent.overstreet@gmail.com,
        linux-bcache@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 04/10] bcache: avoid NULL checking to c->root in run_cache_set()
Date:   Tue, 28 Nov 2023 16:09:53 -0500
Message-ID: <20231128211001.877333-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128211001.877333-1-sashal@kernel.org>
References: <20231128211001.877333-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.300
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
index 8b4a2bd6b57c9..70f0f3096beea 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1846,7 +1846,7 @@ static int run_cache_set(struct cache_set *c)
 		c->root = bch_btree_node_get(c, NULL, k,
 					     j->btree_level,
 					     true, NULL);
-		if (IS_ERR_OR_NULL(c->root))
+		if (IS_ERR(c->root))
 			goto err;
 
 		list_del_init(&c->root->list);
-- 
2.42.0

