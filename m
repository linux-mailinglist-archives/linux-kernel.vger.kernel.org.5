Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D7376E1F2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjHCHii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbjHCHgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:36:36 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id AA24630D5;
        Thu,  3 Aug 2023 00:34:48 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id C6FC16090B390;
        Thu,  3 Aug 2023 15:34:45 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Wu Yunchuan <yunchuan@nfschina.com>
To:     kvalo@kernel.org
Cc:     yuancan@huawei.com, simon.horman@corigine.com,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Wu Yunchuan <yunchuan@nfschina.com>
Subject: [PATCH net-next v2 1/9] wifi: rsi: rsi_91x_coex: Remove unnecessary (void*) conversions
Date:   Thu,  3 Aug 2023 15:34:40 +0800
Message-Id: <20230803073440.3666204-1-yunchuan@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need cast (void*) to (struct rsi_coex_ctrl_block *) or
(struct rsi_common *).

Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
---
 drivers/net/wireless/rsi/rsi_91x_coex.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_coex.c b/drivers/net/wireless/rsi/rsi_91x_coex.c
index 45ac9371f262..372eaaa2b9ef 100644
--- a/drivers/net/wireless/rsi/rsi_91x_coex.c
+++ b/drivers/net/wireless/rsi/rsi_91x_coex.c
@@ -52,8 +52,7 @@ static void rsi_coex_sched_tx_pkts(struct rsi_coex_ctrl_block *coex_cb)
 
 static void rsi_coex_scheduler_thread(struct rsi_common *common)
 {
-	struct rsi_coex_ctrl_block *coex_cb =
-		(struct rsi_coex_ctrl_block *)common->coex_cb;
+	struct rsi_coex_ctrl_block *coex_cb = common->coex_cb;
 	u32 timeout = EVENT_WAIT_FOREVER;
 
 	do {
@@ -100,9 +99,8 @@ static inline int rsi_map_coex_q(u8 hal_queue)
 
 int rsi_coex_send_pkt(void *priv, struct sk_buff *skb, u8 hal_queue)
 {
-	struct rsi_common *common = (struct rsi_common *)priv;
-	struct rsi_coex_ctrl_block *coex_cb =
-		(struct rsi_coex_ctrl_block *)common->coex_cb;
+	struct rsi_common *common = priv;
+	struct rsi_coex_ctrl_block *coex_cb = common->coex_cb;
 	struct skb_info *tx_params = NULL;
 	enum rsi_coex_queues coex_q;
 	int status;
@@ -168,8 +166,7 @@ int rsi_coex_attach(struct rsi_common *common)
 
 void rsi_coex_detach(struct rsi_common *common)
 {
-	struct rsi_coex_ctrl_block *coex_cb =
-		(struct rsi_coex_ctrl_block *)common->coex_cb;
+	struct rsi_coex_ctrl_block *coex_cb = common->coex_cb;
 	int cnt;
 
 	rsi_kill_thread(&coex_cb->coex_tx_thread);
-- 
2.30.2

