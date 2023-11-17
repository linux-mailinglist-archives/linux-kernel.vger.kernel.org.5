Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039F47EF282
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 13:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345959AbjKQMSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 07:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbjKQMS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 07:18:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7EB10D5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 04:18:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECC3C433CD;
        Fri, 17 Nov 2023 12:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700223498;
        bh=ogHEVS0KdHVrAhNQwbidAE1xp2vQIyfTD9jS7RacS6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MjI20mqXCAD2eu6auElRXo9UWp5ocdcuS4mj3YNn4PGu07QBGHSu+XEV6A10MpWoQ
         0FPT4bIo40YXf+huKwR8bKsdXtm6QHjQxiDL/IcxX9hU09QtS92PEEl8Mzpi/jTd/W
         8lIx4zBiLTIgoZFAWXI2OsGeWdpJ7E4ND8iZb8DkDfFYenccvzqUJpQ/YxdOlZ4Ey9
         28UmzyiiABqSb/LEiHfw+mdRm7YiaFJk3hGJAEUnTt6hswQuURv0hPIpFlY9LPFgN2
         DsZsgJUCFUeRXJdx7FXLExYg1hV7uod62qMzF+kyV/wYJNwQIsBajAzQc840vfjEpX
         eoUqT73Qu14fw==
From:   Roger Quadros <rogerq@kernel.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     vladimir.oltean@nxp.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
        vigneshr@ti.com, srk@ti.com, andrew@lunn.ch,
        u.kleine-koenig@pengutronix.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 net-next 4/4] net: ethernet: ti: am65-cpsw: Fix error handling in am65_cpsw_nuss_common_open()
Date:   Fri, 17 Nov 2023 14:17:55 +0200
Message-Id: <20231117121755.104547-5-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117121755.104547-1-rogerq@kernel.org>
References: <20231117121755.104547-1-rogerq@kernel.org>
MIME-Version: 1.0
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

k3_udma_glue_enable_rx/tx_chn returns error code on failure.
Bail out on error while enabling TX/RX channel.

In the error path, clean up the RX descriptors and SKBs.
Get rid of kmemleak_not_leak() as it seems unnecessary now.

Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver")
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 48 +++++++++++++++++++-----
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 78b3e69fbccb..7992a76ed4d8 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -443,7 +443,7 @@ static void am65_cpsw_nuss_tx_cleanup(void *data, dma_addr_t desc_dma)
 static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
 {
 	struct am65_cpsw_host *host_p = am65_common_get_host(common);
-	int port_idx, i, ret;
+	int port_idx, i, ret, tx;
 	struct sk_buff *skb;
 	u32 val, port_mask;
 
@@ -510,8 +510,12 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
 						  AM65_CPSW_MAX_PACKET_SIZE,
 						  GFP_KERNEL);
 		if (!skb) {
+			ret = -ENOMEM;
 			dev_err(common->dev, "cannot allocate skb\n");
-			return -ENOMEM;
+			if (i)
+				goto fail_rx;
+
+			return ret;
 		}
 
 		ret = am65_cpsw_nuss_rx_push(common, skb);
@@ -520,17 +524,28 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
 				"cannot submit skb to channel rx, error %d\n",
 				ret);
 			kfree_skb(skb);
+			if (i)
+				goto fail_rx;
+
 			return ret;
 		}
-		kmemleak_not_leak(skb);
 	}
-	k3_udma_glue_enable_rx_chn(common->rx_chns.rx_chn);
 
-	for (i = 0; i < common->tx_ch_num; i++) {
-		ret = k3_udma_glue_enable_tx_chn(common->tx_chns[i].tx_chn);
-		if (ret)
-			return ret;
-		napi_enable(&common->tx_chns[i].napi_tx);
+	ret = k3_udma_glue_enable_rx_chn(common->rx_chns.rx_chn);
+	if (ret) {
+		dev_err(common->dev, "couldn't enable rx chn: %d\n", ret);
+		goto fail_rx;
+	}
+
+	for (tx = 0; tx < common->tx_ch_num; tx++) {
+		ret = k3_udma_glue_enable_tx_chn(common->tx_chns[tx].tx_chn);
+		if (ret) {
+			dev_err(common->dev, "couldn't enable tx chn %d: %d\n",
+				tx, ret);
+			tx--;
+			goto fail_tx;
+		}
+		napi_enable(&common->tx_chns[tx].napi_tx);
 	}
 
 	napi_enable(&common->napi_rx);
@@ -541,6 +556,21 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
 
 	dev_dbg(common->dev, "cpsw_nuss started\n");
 	return 0;
+
+fail_tx:
+	while (tx >= 0) {
+		napi_disable(&common->tx_chns[tx].napi_tx);
+		k3_udma_glue_disable_tx_chn(common->tx_chns[tx].tx_chn);
+		tx--;
+	}
+
+	k3_udma_glue_disable_rx_chn(common->rx_chns.rx_chn);
+
+fail_rx:
+	k3_udma_glue_reset_rx_chn(common->rx_chns.rx_chn, 0,
+				  &common->rx_chns,
+				  am65_cpsw_nuss_rx_cleanup, 0);
+	return ret;
 }
 
 static int am65_cpsw_nuss_common_stop(struct am65_cpsw_common *common)
-- 
2.34.1

