Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918127FC83A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376266AbjK1VG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346652AbjK1VGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:06:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FD219A4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:06:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06180C433CC;
        Tue, 28 Nov 2023 21:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205598;
        bh=6+S+VtCUCXVyhj8zoX/JSLLVuCBHCn/YurDvOyWjeYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E9yyCiXofmX76IC6WzDmNOlquO5sz25NOzcAdGHGgOYu330jaHF7i5kl9T9bfHWb/
         SE2kjNvN9i2ka+yDykO5hZyhtUv8uOlvmKk3L6BwPJSJWChyQqnDuKcE7K5WtVo9uA
         ORv5u6yB/fJps1xBMSgxeFhOgRjvWvEmUkcu7eMK+xcM2zWQ+1M0VAjJDhN1yTG0X1
         4OLRqlJpIQHRItujcveGqvR23+/H3O4pIS/MoyiUlLFv2l82OnHns+7vITAxLGoAAW
         a8/3CJ1iBPMkUhNAZoPEmuZAlb64pPRbBW+fWdq6AV3VYC30+g3UuaF+5DQk82TJRu
         wpH1nnUJ0kA7Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Li Nan <linan122@huawei.com>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: [PATCH AUTOSEL 6.6 11/40] nbd: fold nbd config initialization into nbd_alloc_config()
Date:   Tue, 28 Nov 2023 16:05:17 -0500
Message-ID: <20231128210615.875085-11-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
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

From: Li Nan <linan122@huawei.com>

[ Upstream commit 1b59860540a4018e8071dc18d4893ec389506b7d ]

There are no functional changes, make the code cleaner and prepare to
fix null-ptr-dereference while accessing 'nbd->config'.

Signed-off-by: Li Nan <linan122@huawei.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Link: https://lore.kernel.org/r/20231116162316.1740402-2-linan666@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 855fdf5c3b4ea..02f844832d912 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1530,17 +1530,20 @@ static int nbd_ioctl(struct block_device *bdev, blk_mode_t mode,
 	return error;
 }
 
-static struct nbd_config *nbd_alloc_config(void)
+static int nbd_alloc_and_init_config(struct nbd_device *nbd)
 {
 	struct nbd_config *config;
 
+	if (WARN_ON(nbd->config))
+		return -EINVAL;
+
 	if (!try_module_get(THIS_MODULE))
-		return ERR_PTR(-ENODEV);
+		return -ENODEV;
 
 	config = kzalloc(sizeof(struct nbd_config), GFP_NOFS);
 	if (!config) {
 		module_put(THIS_MODULE);
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 	}
 
 	atomic_set(&config->recv_threads, 0);
@@ -1548,7 +1551,10 @@ static struct nbd_config *nbd_alloc_config(void)
 	init_waitqueue_head(&config->conn_wait);
 	config->blksize_bits = NBD_DEF_BLKSIZE_BITS;
 	atomic_set(&config->live_connections, 0);
-	return config;
+	nbd->config = config;
+	refcount_set(&nbd->config_refs, 1);
+
+	return 0;
 }
 
 static int nbd_open(struct gendisk *disk, blk_mode_t mode)
@@ -1567,21 +1573,17 @@ static int nbd_open(struct gendisk *disk, blk_mode_t mode)
 		goto out;
 	}
 	if (!refcount_inc_not_zero(&nbd->config_refs)) {
-		struct nbd_config *config;
-
 		mutex_lock(&nbd->config_lock);
 		if (refcount_inc_not_zero(&nbd->config_refs)) {
 			mutex_unlock(&nbd->config_lock);
 			goto out;
 		}
-		config = nbd_alloc_config();
-		if (IS_ERR(config)) {
-			ret = PTR_ERR(config);
+		ret = nbd_alloc_and_init_config(nbd);
+		if (ret) {
 			mutex_unlock(&nbd->config_lock);
 			goto out;
 		}
-		nbd->config = config;
-		refcount_set(&nbd->config_refs, 1);
+
 		refcount_inc(&nbd->refs);
 		mutex_unlock(&nbd->config_lock);
 		if (max_part)
@@ -1990,22 +1992,17 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 		pr_err("nbd%d already in use\n", index);
 		return -EBUSY;
 	}
-	if (WARN_ON(nbd->config)) {
-		mutex_unlock(&nbd->config_lock);
-		nbd_put(nbd);
-		return -EINVAL;
-	}
-	config = nbd_alloc_config();
-	if (IS_ERR(config)) {
+
+	ret = nbd_alloc_and_init_config(nbd);
+	if (ret) {
 		mutex_unlock(&nbd->config_lock);
 		nbd_put(nbd);
 		pr_err("couldn't allocate config\n");
-		return PTR_ERR(config);
+		return ret;
 	}
-	nbd->config = config;
-	refcount_set(&nbd->config_refs, 1);
-	set_bit(NBD_RT_BOUND, &config->runtime_flags);
 
+	config = nbd->config;
+	set_bit(NBD_RT_BOUND, &config->runtime_flags);
 	ret = nbd_genl_size_set(info, nbd);
 	if (ret)
 		goto out;
-- 
2.42.0

