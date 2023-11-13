Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E3C7E9AAC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 12:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjKMLHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 06:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjKMLH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 06:07:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D89210F0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 03:07:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF6AC433C7;
        Mon, 13 Nov 2023 11:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699873646;
        bh=ZR/DMZiyPsFy+qz8rEgRfcpH4vlRg6uq7If8iaVqgDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fFTOq4h4BIeRZgABsCAYrICCROmZWg0yTLFR3qD5fmh+i5iCyUQPRjfQQGloe+CVs
         lbKAIqSv4CnJYPudxvm8kyBTs91R49XO6RJ6A2xp5He0htSmV9aVPldmxwsGB8rwrZ
         Ng8UTO3zR9LsV/fzOKooOF7ko/kbkiFsvfyj7jMGh0DDWKpUhwwuaLNF4zO8uCl6mk
         7mkAxj25in57JrKMZ1+nhdbOpPMNwNOH3pkhgAqZbg/8E2U7YhD6qVQ/Xkna2IHyOZ
         UIiwbsQI2ssUJURO2STSw9ZqQUUHJSBYnoN4h68JvpsNEGGhTmEknEc0p1n/tGDMMo
         rSYeDRj26szDg==
From:   Roger Quadros <rogerq@kernel.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     vladimir.oltean@nxp.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
        srk@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH net-next 3/3] net: ethernet: am65-cpsw: Error out if Enable TX/RX channel fails
Date:   Mon, 13 Nov 2023 13:07:08 +0200
Message-Id: <20231113110708.137379-4-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113110708.137379-1-rogerq@kernel.org>
References: <20231113110708.137379-1-rogerq@kernel.org>
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

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 33 +++++++++++++++++++-----
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 7c440899c93c..340f25bf33b1 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -372,7 +372,7 @@ static void am65_cpsw_init_port_emac_ale(struct am65_cpsw_port *port);
 static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
 {
 	struct am65_cpsw_host *host_p = am65_common_get_host(common);
-	int port_idx, i, ret;
+	int port_idx, i, ret, tx;
 	struct sk_buff *skb;
 	u32 val, port_mask;
 
@@ -453,13 +453,22 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
 		}
 		kmemleak_not_leak(skb);
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
+		return ret;
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
@@ -470,6 +479,16 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
 
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
+	return ret;
 }
 
 static void am65_cpsw_nuss_tx_cleanup(void *data, dma_addr_t desc_dma);
-- 
2.34.1

