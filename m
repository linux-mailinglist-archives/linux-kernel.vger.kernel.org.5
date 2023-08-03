Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36D676E201
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbjHCHjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjHCHgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:36:49 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 69FE4359A;
        Thu,  3 Aug 2023 00:35:45 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 15A5E609158A6;
        Thu,  3 Aug 2023 15:35:42 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Wu Yunchuan <yunchuan@nfschina.com>
To:     kvalo@kernel.org
Cc:     simon.horman@corigine.com, marex@denx.de,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Wu Yunchuan <yunchuan@nfschina.com>
Subject: [PATCH net-next v2 6/9] wifi: rsi: rsi_91x_sdio: Remove unnecessary (void*) conversions
Date:   Thu,  3 Aug 2023 15:35:39 +0800
Message-Id: <20230803073539.3666735-1-yunchuan@nfschina.com>
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

No need cast (void*) to (struct rsi_91x_sdiodev *).

Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
---
 drivers/net/wireless/rsi/rsi_91x_sdio.c | 39 +++++++++----------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_sdio.c b/drivers/net/wireless/rsi/rsi_91x_sdio.c
index 1911fef3bbad..8e7b757475d2 100644
--- a/drivers/net/wireless/rsi/rsi_91x_sdio.c
+++ b/drivers/net/wireless/rsi/rsi_91x_sdio.c
@@ -144,8 +144,7 @@ static int rsi_issue_sdiocommand(struct sdio_func *func,
 static void rsi_handle_interrupt(struct sdio_func *function)
 {
 	struct rsi_hw *adapter = sdio_get_drvdata(function);
-	struct rsi_91x_sdiodev *dev =
-		(struct rsi_91x_sdiodev *)adapter->rsi_dev;
+	struct rsi_91x_sdiodev *dev = adapter->rsi_dev;
 
 	if (adapter->priv->fsm_state == FSM_FW_NOT_LOADED)
 		return;
@@ -337,8 +336,7 @@ static void rsi_reset_card(struct sdio_func *pfunction)
  */
 static void rsi_setclock(struct rsi_hw *adapter, u32 freq)
 {
-	struct rsi_91x_sdiodev *dev =
-		(struct rsi_91x_sdiodev *)adapter->rsi_dev;
+	struct rsi_91x_sdiodev *dev = adapter->rsi_dev;
 	struct mmc_host *host = dev->pfunction->card->host;
 	u32 clock;
 
@@ -358,8 +356,7 @@ static void rsi_setclock(struct rsi_hw *adapter, u32 freq)
  */
 static int rsi_setblocklength(struct rsi_hw *adapter, u32 length)
 {
-	struct rsi_91x_sdiodev *dev =
-		(struct rsi_91x_sdiodev *)adapter->rsi_dev;
+	struct rsi_91x_sdiodev *dev = adapter->rsi_dev;
 	int status;
 	rsi_dbg(INIT_ZONE, "%s: Setting the block length\n", __func__);
 
@@ -380,8 +377,7 @@ static int rsi_setblocklength(struct rsi_hw *adapter, u32 length)
  */
 static int rsi_setupcard(struct rsi_hw *adapter)
 {
-	struct rsi_91x_sdiodev *dev =
-		(struct rsi_91x_sdiodev *)adapter->rsi_dev;
+	struct rsi_91x_sdiodev *dev = adapter->rsi_dev;
 	int status = 0;
 
 	rsi_setclock(adapter, 50000);
@@ -407,8 +403,7 @@ int rsi_sdio_read_register(struct rsi_hw *adapter,
 			   u32 addr,
 			   u8 *data)
 {
-	struct rsi_91x_sdiodev *dev =
-		(struct rsi_91x_sdiodev *)adapter->rsi_dev;
+	struct rsi_91x_sdiodev *dev = adapter->rsi_dev;
 	u8 fun_num = 0;
 	int status;
 
@@ -441,8 +436,7 @@ int rsi_sdio_write_register(struct rsi_hw *adapter,
 			    u32 addr,
 			    u8 *data)
 {
-	struct rsi_91x_sdiodev *dev =
-		(struct rsi_91x_sdiodev *)adapter->rsi_dev;
+	struct rsi_91x_sdiodev *dev = adapter->rsi_dev;
 	int status = 0;
 
 	if (likely(dev->sdio_irq_task != current))
@@ -495,8 +489,7 @@ static int rsi_sdio_read_register_multiple(struct rsi_hw *adapter,
 					   u8 *data,
 					   u16 count)
 {
-	struct rsi_91x_sdiodev *dev =
-		(struct rsi_91x_sdiodev *)adapter->rsi_dev;
+	struct rsi_91x_sdiodev *dev = adapter->rsi_dev;
 	u32 status;
 
 	if (likely(dev->sdio_irq_task != current))
@@ -527,8 +520,7 @@ int rsi_sdio_write_register_multiple(struct rsi_hw *adapter,
 				     u8 *data,
 				     u16 count)
 {
-	struct rsi_91x_sdiodev *dev =
-		(struct rsi_91x_sdiodev *)adapter->rsi_dev;
+	struct rsi_91x_sdiodev *dev = adapter->rsi_dev;
 	int status;
 
 	if (dev->write_fail > 1) {
@@ -762,8 +754,7 @@ static int rsi_sdio_host_intf_write_pkt(struct rsi_hw *adapter,
 					u8 *pkt,
 					u32 len)
 {
-	struct rsi_91x_sdiodev *dev =
-		(struct rsi_91x_sdiodev *)adapter->rsi_dev;
+	struct rsi_91x_sdiodev *dev = adapter->rsi_dev;
 	u32 block_size = dev->tx_blk_size;
 	u32 num_blocks, address, length;
 	u32 queueno;
@@ -1045,7 +1036,7 @@ static int rsi_probe(struct sdio_func *pfunction,
 		goto fail_free_adapter;
 	}
 
-	sdev = (struct rsi_91x_sdiodev *)adapter->rsi_dev;
+	sdev = adapter->rsi_dev;
 	rsi_init_event(&sdev->rx_thread.event);
 	status = rsi_create_kthread(adapter->priv, &sdev->rx_thread,
 				    rsi_sdio_rx_thread, "SDIO-RX-Thread");
@@ -1221,7 +1212,7 @@ static void rsi_disconnect(struct sdio_func *pfunction)
 	if (!adapter)
 		return;
 
-	dev = (struct rsi_91x_sdiodev *)adapter->rsi_dev;
+	dev = adapter->rsi_dev;
 
 	rsi_kill_thread(&dev->rx_thread);
 	sdio_claim_host(pfunction);
@@ -1255,8 +1246,7 @@ static void rsi_disconnect(struct sdio_func *pfunction)
 #ifdef CONFIG_PM
 static int rsi_set_sdio_pm_caps(struct rsi_hw *adapter)
 {
-	struct rsi_91x_sdiodev *dev =
-		(struct rsi_91x_sdiodev *)adapter->rsi_dev;
+	struct rsi_91x_sdiodev *dev = adapter->rsi_dev;
 	struct sdio_func *func = dev->pfunction;
 	int ret;
 
@@ -1407,7 +1397,7 @@ static int rsi_freeze(struct device *dev)
 		return -ENODEV;
 	}
 	common = adapter->priv;
-	sdev = (struct rsi_91x_sdiodev *)adapter->rsi_dev;
+	sdev = adapter->rsi_dev;
 
 	if ((common->wow_flags & RSI_WOW_ENABLED) &&
 	    (common->wow_flags & RSI_WOW_NO_CONNECTION))
@@ -1457,8 +1447,7 @@ static void rsi_shutdown(struct device *dev)
 {
 	struct sdio_func *pfunction = dev_to_sdio_func(dev);
 	struct rsi_hw *adapter = sdio_get_drvdata(pfunction);
-	struct rsi_91x_sdiodev *sdev =
-		(struct rsi_91x_sdiodev *)adapter->rsi_dev;
+	struct rsi_91x_sdiodev *sdev = adapter->rsi_dev;
 	struct ieee80211_hw *hw = adapter->hw;
 
 	rsi_dbg(ERR_ZONE, "SDIO Bus shutdown =====>\n");
-- 
2.30.2

