Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA06778FEA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 14:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbjHKMwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 08:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjHKMwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:52:10 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F902696;
        Fri, 11 Aug 2023 05:52:09 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6877eb31261so1412452b3a.1;
        Fri, 11 Aug 2023 05:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691758328; x=1692363128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KbKJe2tEe/lB5NizJfxNPF+lCmWbaQQ8/etXP32dMGg=;
        b=JZQY58hTx7UZ43EjBbTuSgw/ldGdUuDETy35lBvfcATVxUP/7MMSOchj7/cYCMZtdl
         JJlmZcWDclNWZ2jhAGQXMRrMifXeJLpZIIahMNHiY+GeIObRzuSLii9UMypJhjB5MNli
         a1yp7l4ydf1Wk1oJmA/ROiFJLxN0leVH62Tqp6O/kcDtG32451Qoc6ZHN5Sy71MUiQ/K
         1IyZESCqfUG9C0W+Q5VV9u/vDlTSiebeM076DfgkMNBGOLv5A1113/3l58Yx8A1u2Hsh
         bRQN/eOKEYOCjRkw4LrfTdSbOoahFcIjA12X5d3ochHm+FRtsH9ynrzlGqKlev4YD7uM
         +2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691758328; x=1692363128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KbKJe2tEe/lB5NizJfxNPF+lCmWbaQQ8/etXP32dMGg=;
        b=Dmz7ZmatFVGNZZ6o4CG9sS09A4/htKURaCgWEBQC9Vok2CBHSYyGaJSAxnRY6O0gHf
         N46JZQyMPC1uHH3kDzeeBO5+H0Ig8RkxOsGbedMJ+WSU9TxgobvQc7KB5J1vW0w22mfQ
         lwpGZd2UNECGhKAqnMnNnBvnXoRG9whdJJs/3moccilHUp28v7jJd5tgsniiK9MlrlB3
         NB06vQPU9+lNnLR3RcAd4EJWcZ24xS2DZcqnL+9LIgJkqNRkrkUaVWFzU0ow5yY9ZpDX
         Rfh475UDsdTzRoittqbmEXyLy8eK/ni84pZSjhzMljRzva8+TPbwHLeHcOAeVu7oVrei
         sfrQ==
X-Gm-Message-State: AOJu0Yw0u0zLppOrfLXJ3iWGbQSEkmzLIjs7b6gD86LZ5DRxp5cnSTdO
        QP+UrZEykzCVMfaN95VaC1Q=
X-Google-Smtp-Source: AGHT+IEYLAU/icss22mnR69KwGu2yTOnUC8KZ+3hUTw336+X0NC7us98dUOT1vIwuGYtu5MnQtEQag==
X-Received: by 2002:a05:6a20:1595:b0:13d:7aa3:aa72 with SMTP id h21-20020a056a20159500b0013d7aa3aa72mr1993967pzj.5.1691758328438;
        Fri, 11 Aug 2023 05:52:08 -0700 (PDT)
Received: from localhost.localdomain ([198.211.45.220])
        by smtp.googlemail.com with ESMTPSA id t12-20020a1709028c8c00b001b9d88a4d1asm3796694plo.289.2023.08.11.05.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 05:52:07 -0700 (PDT)
From:   Furong Xu <0x1207@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Simon Horman <horms@kernel.org>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xfr@outlook.com, rock.xu@nio.com, Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v1 1/1] net: stmmac: xgmac: show more MAC HW features in debugfs
Date:   Fri, 11 Aug 2023 20:51:39 +0800
Message-Id: <20230811125139.284272-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Show TSSTSSEL(Timestamp System Time Source),
ADDMACADRSEL(additional MAC addresses), SMASEL(SMA/MDIO Interface),
HDSEL(Half-duplex Support) in debugfs.
2. Show exact number of additional MAC address registers for XGMAC2 core.
3. XGMAC2 core does not have different IP checksum offload types, so just
show rx_coe instead of rx_coe_type1 or rx_coe_type2.
4. XGMAC2 core does not have rxfifo_over_2048 definition, skip it.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h  |  2 ++
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  4 +++
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  6 ++++-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 25 +++++++++++++++----
 4 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 16e67c18b6f7..b37f2f6b2229 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -434,6 +434,8 @@ struct dma_features {
 	unsigned int tbssel;
 	/* Numbers of Auxiliary Snapshot Inputs */
 	unsigned int aux_snapshot_n;
+	/* Timestamp System Time Source */
+	unsigned int tssrc;
 };
 
 /* RX Buffer size must be multiple of 4/8/16 bytes */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 1913385df685..a00398674015 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -111,6 +111,8 @@
 #define XGMAC_LPI_TIMER_CTRL		0x000000d4
 #define XGMAC_HW_FEATURE0		0x0000011c
 #define XGMAC_HWFEAT_SAVLANINS		BIT(27)
+#define XGMAC_HWFEAT_TSSTSSEL		GENMASK(26, 25)
+#define XGMAC_HWFEAT_ADDMACADRSEL	GENMASK(22, 18)
 #define XGMAC_HWFEAT_RXCOESEL		BIT(16)
 #define XGMAC_HWFEAT_TXCOESEL		BIT(14)
 #define XGMAC_HWFEAT_EEESEL		BIT(13)
@@ -121,7 +123,9 @@
 #define XGMAC_HWFEAT_MMCSEL		BIT(8)
 #define XGMAC_HWFEAT_MGKSEL		BIT(7)
 #define XGMAC_HWFEAT_RWKSEL		BIT(6)
+#define XGMAC_HWFEAT_SMASEL		BIT(5)
 #define XGMAC_HWFEAT_VLHASH		BIT(4)
+#define XGMAC_HWFEAT_HDSEL		BIT(3)
 #define XGMAC_HWFEAT_GMIISEL		BIT(1)
 #define XGMAC_HW_FEATURE1		0x00000120
 #define XGMAC_HWFEAT_L3L4FNUM		GENMASK(30, 27)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 070bd912580b..6d6abc3ddb53 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -389,9 +389,11 @@ static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
 {
 	u32 hw_cap;
 
-	/*  MAC HW feature 0 */
+	/* MAC HW feature 0 */
 	hw_cap = readl(ioaddr + XGMAC_HW_FEATURE0);
 	dma_cap->vlins = (hw_cap & XGMAC_HWFEAT_SAVLANINS) >> 27;
+	dma_cap->tssrc = (hw_cap & XGMAC_HWFEAT_TSSTSSEL) >> 25;
+	dma_cap->multi_addr = (hw_cap & XGMAC_HWFEAT_ADDMACADRSEL) >> 18;
 	dma_cap->rx_coe = (hw_cap & XGMAC_HWFEAT_RXCOESEL) >> 16;
 	dma_cap->tx_coe = (hw_cap & XGMAC_HWFEAT_TXCOESEL) >> 14;
 	dma_cap->eee = (hw_cap & XGMAC_HWFEAT_EEESEL) >> 13;
@@ -402,7 +404,9 @@ static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
 	dma_cap->rmon = (hw_cap & XGMAC_HWFEAT_MMCSEL) >> 8;
 	dma_cap->pmt_magic_frame = (hw_cap & XGMAC_HWFEAT_MGKSEL) >> 7;
 	dma_cap->pmt_remote_wake_up = (hw_cap & XGMAC_HWFEAT_RWKSEL) >> 6;
+	dma_cap->sma_mdio = (hw_cap & XGMAC_HWFEAT_SMASEL) >> 5;
 	dma_cap->vlhash = (hw_cap & XGMAC_HWFEAT_VLHASH) >> 4;
+	dma_cap->half_duplex = (hw_cap & XGMAC_HWFEAT_HDSEL) >> 3;
 	dma_cap->mbps_1000 = (hw_cap & XGMAC_HWFEAT_GMIISEL) >> 1;
 
 	/* MAC HW feature 1 */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 4727f7be4f86..2d627640cc60 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6174,6 +6174,12 @@ DEFINE_SHOW_ATTRIBUTE(stmmac_rings_status);
 
 static int stmmac_dma_cap_show(struct seq_file *seq, void *v)
 {
+	static const char * const dwxgmac_timestamp_source[] = {
+		"None",
+		"Internal",
+		"External",
+		"Both",
+	};
 	struct net_device *dev = seq->private;
 	struct stmmac_priv *priv = netdev_priv(dev);
 
@@ -6194,8 +6200,13 @@ static int stmmac_dma_cap_show(struct seq_file *seq, void *v)
 		   (priv->dma_cap.half_duplex) ? "Y" : "N");
 	seq_printf(seq, "\tHash Filter: %s\n",
 		   (priv->dma_cap.hash_filter) ? "Y" : "N");
-	seq_printf(seq, "\tMultiple MAC address registers: %s\n",
-		   (priv->dma_cap.multi_addr) ? "Y" : "N");
+	if (priv->plat->has_xgmac)
+		seq_printf(seq,
+			   "\tNumber of Additional MAC address registers: %d\n",
+			   priv->dma_cap.multi_addr);
+	else
+		seq_printf(seq, "\tMultiple MAC address registers: %s\n",
+			   (priv->dma_cap.multi_addr) ? "Y" : "N");
 	seq_printf(seq, "\tPCS (TBI/SGMII/RTBI PHY interfaces): %s\n",
 		   (priv->dma_cap.pcs) ? "Y" : "N");
 	seq_printf(seq, "\tSMA (MDIO) Interface: %s\n",
@@ -6210,12 +6221,16 @@ static int stmmac_dma_cap_show(struct seq_file *seq, void *v)
 		   (priv->dma_cap.time_stamp) ? "Y" : "N");
 	seq_printf(seq, "\tIEEE 1588-2008 Advanced Time Stamp: %s\n",
 		   (priv->dma_cap.atime_stamp) ? "Y" : "N");
+	if (priv->plat->has_xgmac)
+		seq_printf(seq, "\tTimestamp System Time Source: %s\n",
+			   dwxgmac_timestamp_source[priv->dma_cap.tssrc]);
 	seq_printf(seq, "\t802.3az - Energy-Efficient Ethernet (EEE): %s\n",
 		   (priv->dma_cap.eee) ? "Y" : "N");
 	seq_printf(seq, "\tAV features: %s\n", (priv->dma_cap.av) ? "Y" : "N");
 	seq_printf(seq, "\tChecksum Offload in TX: %s\n",
 		   (priv->dma_cap.tx_coe) ? "Y" : "N");
-	if (priv->synopsys_id >= DWMAC_CORE_4_00) {
+	if (priv->synopsys_id >= DWMAC_CORE_4_00 ||
+	    priv->plat->has_xgmac) {
 		seq_printf(seq, "\tIP Checksum Offload in RX: %s\n",
 			   (priv->dma_cap.rx_coe) ? "Y" : "N");
 	} else {
@@ -6223,9 +6238,9 @@ static int stmmac_dma_cap_show(struct seq_file *seq, void *v)
 			   (priv->dma_cap.rx_coe_type1) ? "Y" : "N");
 		seq_printf(seq, "\tIP Checksum Offload (type2) in RX: %s\n",
 			   (priv->dma_cap.rx_coe_type2) ? "Y" : "N");
+		seq_printf(seq, "\tRXFIFO > 2048bytes: %s\n",
+			   (priv->dma_cap.rxfifo_over_2048) ? "Y" : "N");
 	}
-	seq_printf(seq, "\tRXFIFO > 2048bytes: %s\n",
-		   (priv->dma_cap.rxfifo_over_2048) ? "Y" : "N");
 	seq_printf(seq, "\tNumber of Additional RX channel: %d\n",
 		   priv->dma_cap.number_rx_channel);
 	seq_printf(seq, "\tNumber of Additional TX channel: %d\n",
-- 
2.34.1

