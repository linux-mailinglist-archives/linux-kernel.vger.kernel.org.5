Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA447FC870
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376568AbjK1VOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346869AbjK1VNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:13:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9571BEC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:09:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D40AC4339A;
        Tue, 28 Nov 2023 21:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205789;
        bh=ahGNTsFYwxPZbgh4s2bRoFZfNzzeT6Wil67EYkmih1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jT/1X10Rh0Ga4dLXYBndQ2X0fBvX67Ye37ZR83fqeGoM3mXSudyPjjQSA5w4E0yig
         9igSdOWDiONor1LWgOcm5mARXnXlByFWdZiY+FR8r+VhDUETzwApoij3R8+KwZE7U+
         OPH7hawCPJQP9FimCSY7HDzjn2obl4yPmDCb+g7+B9kmVAbO38N4T3Zu2CB0Az4i9I
         RpHaCMVFYcJqKHGec/cUpA9CXph6HL6QZ15XzYhPAuEGFrPh9RcOwykcxs/Uo5s3qN
         JcK15pR53PcqVVHJ6nbgOcj6EqWZoqOl6Px6TuBZlrT9bdS8WpYI522XxEo2LwYPyn
         CiQnazHTNoDAw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, kent.overstreet@gmail.com,
        linux-bcache@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 04/11] bcache: add code comments for bch_btree_node_get() and __bch_btree_node_alloc()
Date:   Tue, 28 Nov 2023 16:09:28 -0500
Message-ID: <20231128210941.877094-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210941.877094-1-sashal@kernel.org>
References: <20231128210941.877094-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.262
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

[ Upstream commit 31f5b956a197d4ec25c8a07cb3a2ab69d0c0b82f ]

This patch adds code comments to bch_btree_node_get() and
__bch_btree_node_alloc() that NULL pointer will not be returned and it
is unnecessary to check NULL pointer by the callers of these routines.

Signed-off-by: Coly Li <colyli@suse.de>
Link: https://lore.kernel.org/r/20231120052503.6122-10-colyli@suse.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/btree.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index cc0c1f2bba45c..26b4ff6be3723 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -1020,6 +1020,9 @@ static struct btree *mca_alloc(struct cache_set *c, struct btree_op *op,
  *
  * The btree node will have either a read or a write lock held, depending on
  * level and op->lock.
+ *
+ * Note: Only error code or btree pointer will be returned, it is unncessary
+ *       for callers to check NULL pointer.
  */
 struct btree *bch_btree_node_get(struct cache_set *c, struct btree_op *op,
 				 struct bkey *k, int level, bool write,
@@ -1132,6 +1135,10 @@ static void btree_node_free(struct btree *b)
 	mutex_unlock(&b->c->bucket_lock);
 }
 
+/*
+ * Only error code or btree pointer will be returned, it is unncessary for
+ * callers to check NULL pointer.
+ */
 struct btree *__bch_btree_node_alloc(struct cache_set *c, struct btree_op *op,
 				     int level, bool wait,
 				     struct btree *parent)
-- 
2.42.0

