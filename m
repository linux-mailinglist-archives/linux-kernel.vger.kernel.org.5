Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2777FC8A5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346634AbjK1VHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346614AbjK1VGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:06:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DE219BA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:06:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B61C433C9;
        Tue, 28 Nov 2023 21:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205599;
        bh=ldiK7KuLUTDjHoUTrRv5GR28hpJAs7FlnaeFLTHn/uM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AD2hPT5xx2Bwf6lZlp/c+fcO5NUxuvSWifwH71NTsvBXV8SGI3QF+ZVIw385tN+WI
         aJBy643deBaLZKcsBB8o5z/1Qld5TCdV9KdYiHndaa8HPcNqhKfUVM5BoM79TqFeke
         cUqcs8SqO0AS4Z5Sn4tMduwljRaEXw359x24BzPDu7EM1k6QnX9dygDV8FTvwDWDKD
         USrFSp2YzQNcQ6f8D6Qmd+foMCJ6YZN1cans8E1I5IcC6qVkpZDFJ0qQM/xRu4UBvP
         jEvUTdjJX4aJKLlP1k5dfi8+XNYu/RTnOTzWxOJgPsQqzeQEcWv9whGuZE4U+WLeQ1
         +KCLRkhHlVoUg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Li Nan <linan122@huawei.com>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: [PATCH AUTOSEL 6.6 12/40] nbd: factor out a helper to get nbd_config without holding 'config_lock'
Date:   Tue, 28 Nov 2023 16:05:18 -0500
Message-ID: <20231128210615.875085-12-sashal@kernel.org>
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

[ Upstream commit 3123ac77923341774ca3ad1196ad20bb0732bf70 ]

There are no functional changes, just to make code cleaner and prepare
to fix null-ptr-dereference while accessing 'nbd->config'.

Signed-off-by: Li Nan <linan122@huawei.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Link: https://lore.kernel.org/r/20231116162316.1740402-3-linan666@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 02f844832d912..daaf8805e876c 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -395,6 +395,14 @@ static u32 req_to_nbd_cmd_type(struct request *req)
 	}
 }
 
+static struct nbd_config *nbd_get_config_unlocked(struct nbd_device *nbd)
+{
+	if (refcount_inc_not_zero(&nbd->config_refs))
+		return nbd->config;
+
+	return NULL;
+}
+
 static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req)
 {
 	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(req);
@@ -409,13 +417,13 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req)
 		return BLK_EH_DONE;
 	}
 
-	if (!refcount_inc_not_zero(&nbd->config_refs)) {
+	config = nbd_get_config_unlocked(nbd);
+	if (!config) {
 		cmd->status = BLK_STS_TIMEOUT;
 		__clear_bit(NBD_CMD_INFLIGHT, &cmd->flags);
 		mutex_unlock(&cmd->lock);
 		goto done;
 	}
-	config = nbd->config;
 
 	if (config->num_connections > 1 ||
 	    (config->num_connections == 1 && nbd->tag_set.timeout)) {
@@ -977,12 +985,12 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 	struct nbd_sock *nsock;
 	int ret;
 
-	if (!refcount_inc_not_zero(&nbd->config_refs)) {
+	config = nbd_get_config_unlocked(nbd);
+	if (!config) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Socks array is empty\n");
 		return -EINVAL;
 	}
-	config = nbd->config;
 
 	if (index >= config->num_connections) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
@@ -1560,6 +1568,7 @@ static int nbd_alloc_and_init_config(struct nbd_device *nbd)
 static int nbd_open(struct gendisk *disk, blk_mode_t mode)
 {
 	struct nbd_device *nbd;
+	struct nbd_config *config;
 	int ret = 0;
 
 	mutex_lock(&nbd_index_mutex);
@@ -1572,7 +1581,9 @@ static int nbd_open(struct gendisk *disk, blk_mode_t mode)
 		ret = -ENXIO;
 		goto out;
 	}
-	if (!refcount_inc_not_zero(&nbd->config_refs)) {
+
+	config = nbd_get_config_unlocked(nbd);
+	if (!config) {
 		mutex_lock(&nbd->config_lock);
 		if (refcount_inc_not_zero(&nbd->config_refs)) {
 			mutex_unlock(&nbd->config_lock);
@@ -1588,7 +1599,7 @@ static int nbd_open(struct gendisk *disk, blk_mode_t mode)
 		mutex_unlock(&nbd->config_lock);
 		if (max_part)
 			set_bit(GD_NEED_PART_SCAN, &disk->state);
-	} else if (nbd_disconnected(nbd->config)) {
+	} else if (nbd_disconnected(config)) {
 		if (max_part)
 			set_bit(GD_NEED_PART_SCAN, &disk->state);
 	}
@@ -2205,7 +2216,8 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 	}
 	mutex_unlock(&nbd_index_mutex);
 
-	if (!refcount_inc_not_zero(&nbd->config_refs)) {
+	config = nbd_get_config_unlocked(nbd);
+	if (!config) {
 		dev_err(nbd_to_dev(nbd),
 			"not configured, cannot reconfigure\n");
 		nbd_put(nbd);
@@ -2213,7 +2225,6 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	mutex_lock(&nbd->config_lock);
-	config = nbd->config;
 	if (!test_bit(NBD_RT_BOUND, &config->runtime_flags) ||
 	    !nbd->pid) {
 		dev_err(nbd_to_dev(nbd),
-- 
2.42.0

