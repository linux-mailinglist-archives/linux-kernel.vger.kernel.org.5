Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D7F7A5E2D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjISJgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjISJgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:36:32 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00C8134;
        Tue, 19 Sep 2023 02:36:10 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-502984f5018so9094480e87.3;
        Tue, 19 Sep 2023 02:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695116168; x=1695720968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7m2efdLB8ktZfybi/MVWKqgiRo/osg2GKKQiDbaXOWg=;
        b=APqNDH+1IFPvXFqatQ1sCnNv2C8dmUtRJ9RQIDrY+HAS2WS8dbfZ7LLlCh5lttn5vr
         9tFrYw25N94/iiyJbYR9q84FOl4y0wZ/yyQF6mcX7Qs+0IxoJmsTIqXQ63uN2ddLskwn
         J9rQtJZ6W7/2odzUpOadvRTNoROkUmpMNdqgF+Qu5b4rUBEgiIKfPovFICI2h6V+e/6j
         vZ/JPPbJO/HxUofrWmu6AXcNx9oLu/NtyG0NoPhRm1PpOhkmPuWprm9H3jTwqLpgmLo9
         uYYbtXVQfoTY0Y2nXWctVXatNwAr8n8Pvbk72rGkPYkp6yI9d6s+mrKkuyaR+vUOIHy9
         DWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695116168; x=1695720968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7m2efdLB8ktZfybi/MVWKqgiRo/osg2GKKQiDbaXOWg=;
        b=YcM6kGfrP5ComCPHYcz0CjEqpxkqmf8ehVZWyc7YamgN7GkE41ZfEvjgGd90LC8Wyj
         lpRdPcT0zpzx2mHNv8FPBRPXnraeEHZTNjrGVMOmThYB7mbBkP22g59+rRkgmTjxI2gM
         n983MDBPxw2UEhwMapcOmxGG+jttlTbTelL2gWSEL88vkEMR13D9vqzQpzNaIjWILx1q
         OjveDE71Jxyz3ai2ThSHsfkm7BmD3CvYz9dpUT+7S0p1DjyCVqHQUS0ZkR4hF8XDV8Y8
         0Nn866QxBwPrB1DvvDqUHOYWvHzWNmRWi1htZTxYEELKNrNnB2aIshxlU8zLCY2lJCLj
         hBhw==
X-Gm-Message-State: AOJu0YzEM578F63x8q2pUPCRV5mEAoUB7gCMvfgxQJ4qYX7D5xeOZWDl
        ZfMqnVNLEmu4wkWQQjDPMCg=
X-Google-Smtp-Source: AGHT+IHMbnTqsO0VDrNi2QZqkPFxshm2jbSMpD30w1QcJe4V3yS2zdB2k7/2TwtPX8XbWKDEpgs2RA==
X-Received: by 2002:a19:4f1a:0:b0:4ff:95c:e158 with SMTP id d26-20020a194f1a000000b004ff095ce158mr9499408lfb.64.1695116167893;
        Tue, 19 Sep 2023 02:36:07 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n7-20020a7bcbc7000000b003fef3180e7asm17560133wmi.44.2023.09.19.02.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 02:36:07 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH][next] net: dsa: sja1105: make read-only const arrays static
Date:   Tue, 19 Sep 2023 10:36:06 +0100
Message-Id: <20230919093606.24446-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate read-only const arrays on the stack, instead make them
static.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/dsa/sja1105/sja1105_clocking.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_clocking.c b/drivers/net/dsa/sja1105/sja1105_clocking.c
index e3699f76f6d7..08a3e7b96254 100644
--- a/drivers/net/dsa/sja1105/sja1105_clocking.c
+++ b/drivers/net/dsa/sja1105/sja1105_clocking.c
@@ -153,14 +153,14 @@ static int sja1105_cgu_mii_tx_clk_config(struct sja1105_private *priv,
 {
 	const struct sja1105_regs *regs = priv->info->regs;
 	struct sja1105_cgu_mii_ctrl mii_tx_clk;
-	const int mac_clk_sources[] = {
+	static const int mac_clk_sources[] = {
 		CLKSRC_MII0_TX_CLK,
 		CLKSRC_MII1_TX_CLK,
 		CLKSRC_MII2_TX_CLK,
 		CLKSRC_MII3_TX_CLK,
 		CLKSRC_MII4_TX_CLK,
 	};
-	const int phy_clk_sources[] = {
+	static const int phy_clk_sources[] = {
 		CLKSRC_IDIV0,
 		CLKSRC_IDIV1,
 		CLKSRC_IDIV2,
@@ -194,7 +194,7 @@ sja1105_cgu_mii_rx_clk_config(struct sja1105_private *priv, int port)
 	const struct sja1105_regs *regs = priv->info->regs;
 	struct sja1105_cgu_mii_ctrl mii_rx_clk;
 	u8 packed_buf[SJA1105_SIZE_CGU_CMD] = {0};
-	const int clk_sources[] = {
+	static const int clk_sources[] = {
 		CLKSRC_MII0_RX_CLK,
 		CLKSRC_MII1_RX_CLK,
 		CLKSRC_MII2_RX_CLK,
@@ -221,7 +221,7 @@ sja1105_cgu_mii_ext_tx_clk_config(struct sja1105_private *priv, int port)
 	const struct sja1105_regs *regs = priv->info->regs;
 	struct sja1105_cgu_mii_ctrl mii_ext_tx_clk;
 	u8 packed_buf[SJA1105_SIZE_CGU_CMD] = {0};
-	const int clk_sources[] = {
+	static const int clk_sources[] = {
 		CLKSRC_IDIV0,
 		CLKSRC_IDIV1,
 		CLKSRC_IDIV2,
@@ -248,7 +248,7 @@ sja1105_cgu_mii_ext_rx_clk_config(struct sja1105_private *priv, int port)
 	const struct sja1105_regs *regs = priv->info->regs;
 	struct sja1105_cgu_mii_ctrl mii_ext_rx_clk;
 	u8 packed_buf[SJA1105_SIZE_CGU_CMD] = {0};
-	const int clk_sources[] = {
+	static const int clk_sources[] = {
 		CLKSRC_IDIV0,
 		CLKSRC_IDIV1,
 		CLKSRC_IDIV2,
@@ -349,8 +349,13 @@ static int sja1105_cgu_rgmii_tx_clk_config(struct sja1105_private *priv,
 	if (speed == priv->info->port_speed[SJA1105_SPEED_1000MBPS]) {
 		clksrc = CLKSRC_PLL0;
 	} else {
-		int clk_sources[] = {CLKSRC_IDIV0, CLKSRC_IDIV1, CLKSRC_IDIV2,
-				     CLKSRC_IDIV3, CLKSRC_IDIV4};
+		static const int clk_sources[] = {
+			CLKSRC_IDIV0,
+			CLKSRC_IDIV1,
+			CLKSRC_IDIV2,
+			CLKSRC_IDIV3,
+			CLKSRC_IDIV4,
+		};
 		clksrc = clk_sources[port];
 	}
 
@@ -638,7 +643,7 @@ static int sja1105_cgu_rmii_ref_clk_config(struct sja1105_private *priv,
 	const struct sja1105_regs *regs = priv->info->regs;
 	struct sja1105_cgu_mii_ctrl ref_clk;
 	u8 packed_buf[SJA1105_SIZE_CGU_CMD] = {0};
-	const int clk_sources[] = {
+	static const int clk_sources[] = {
 		CLKSRC_MII0_TX_CLK,
 		CLKSRC_MII1_TX_CLK,
 		CLKSRC_MII2_TX_CLK,
-- 
2.39.2

