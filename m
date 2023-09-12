Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD70979D0FA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbjILM0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbjILM0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:26:21 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6358710DD;
        Tue, 12 Sep 2023 05:26:17 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-500760b296aso6720038e87.0;
        Tue, 12 Sep 2023 05:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694521575; x=1695126375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6NoKTCy0IbxGA7jVCegaBv/J4Mi6TgsKKw+LWcG++I=;
        b=S0Ug+ly6FrLWqhWLn0gPnLiXvLWbyigKx4c3o4TEUEwvuGd3/RW3jfwYN4Tp15R9xP
         zxuOpQ9YKCWyPVc6CfpTglkkNmRFKfGc86ViXHoCA10N2jafu9xFSQa5Bk2c5Qy8QLJI
         Ab3wfoJPztYuCdR7XqfMm1WB5SsV0ndkfA1kr3cTuh8daXtLU1fDzU3+e4SPtrcbeMNr
         YBbbWFqxJAJW2ohIHzZEMlObcFDz4+6kjshdHjf0MRr9JMJMWF149CJ6IJfkGPeXyAdL
         6AVe5BdzAS2I4RoQqyIJNhetGyugmKHVnnvJqywWnMdg/ujEINAusrekfGKF7GPoqHyH
         qBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694521575; x=1695126375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6NoKTCy0IbxGA7jVCegaBv/J4Mi6TgsKKw+LWcG++I=;
        b=lVlKzi8Q95/CUdBSYnoTS+Xz/8OKJpnex8ALkSdCIi7ohYxyVzIdoTJwITc9oI3aKt
         cdPikllnyFiktRKS471JdDHH3Fl0xzT5jlFzQbeXki4Z+GngqnNed9BecibFBH1ADHSu
         3VCQ7BFD+HZPL+mqBQQRsSlGqwuSt0Ww78MEj6aPUyDRreReRSV241SMyZuZr9269Rt7
         eeP8/umiMFB8VO3wZBhOiKX/vZ+0hqc/ug+Rn3mETADp+NEEfJDW+r/QTwzsu+ApTX80
         tDP/hUtRf/GeDG0KnwHMH0e1p1bksiBKg08cIYdG360LxItMytBmuhafmlLZ9qHVq0xi
         ZQAQ==
X-Gm-Message-State: AOJu0Yy8drrgOVlDHVH6q3pHRg5y+oCuq7N75JQl4l6UeEO0F4iX3zof
        KXYWeKIxNH3i4Np8FlplFaJ3bjHsyF7sHw==
X-Google-Smtp-Source: AGHT+IHCdQ6hKVd8ZMchntMXJk4D2got7iQmzY3uAVROJ/pCe2lVq1EFhCU8G+olnx8RO+bmtLsWeA==
X-Received: by 2002:ac2:4c41:0:b0:500:a1e4:fc45 with SMTP id o1-20020ac24c41000000b00500a1e4fc45mr907081lfk.21.1694521575091;
        Tue, 12 Sep 2023 05:26:15 -0700 (PDT)
Received: from WBEC325.dom.local ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id g21-20020ac25395000000b004fe333128c0sm1737327lfh.242.2023.09.12.05.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 05:26:14 -0700 (PDT)
From:   Pawel Dembicki <paweldembicki@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        Pawel Dembicki <paweldembicki@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/8] net: dsa: vsc73xx: convert to PHYLINK
Date:   Tue, 12 Sep 2023 14:21:56 +0200
Message-Id: <20230912122201.3752918-3-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912122201.3752918-1-paweldembicki@gmail.com>
References: <20230912122201.3752918-1-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces the adjust_link api with the phylink apis that provide
equivalent functionality.

The remaining functionality from the adjust_link is now covered in the
phylink_mac_link_* and phylink_mac_config.

Removes:
.adjust_link
Adds:
.phylink_get_caps
.phylink_mac_link_down
.phylink_mac_link_up
.phylink_mac_link_down

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v3:
  - remove legacy_pre_march2020 after rebase
v2:
  - replace switch to if and get rid of macros in
    vsc73xx_phylink_mac_link_up function

 drivers/net/dsa/vitesse-vsc73xx-core.c | 190 +++++++++++++------------
 1 file changed, 96 insertions(+), 94 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index b117c0c18e36..39d3d78f4bc3 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -714,8 +714,7 @@ static void vsc73xx_init_port(struct vsc73xx *vsc, int port)
 }
 
 static void vsc73xx_adjust_enable_port(struct vsc73xx *vsc,
-				       int port, struct phy_device *phydev,
-				       u32 initval)
+				       int port, u32 initval)
 {
 	u32 val = initval;
 	u8 seed;
@@ -753,12 +752,34 @@ static void vsc73xx_adjust_enable_port(struct vsc73xx *vsc,
 			    VSC73XX_MAC_CFG_TX_EN | VSC73XX_MAC_CFG_RX_EN);
 }
 
-static void vsc73xx_adjust_link(struct dsa_switch *ds, int port,
-				struct phy_device *phydev)
+static void vsc73xx_phylink_get_caps(struct dsa_switch *ds, int port,
+				     struct phylink_config *config)
 {
-	struct vsc73xx *vsc = ds->priv;
-	u32 val;
+	/* This switch only supports full-duplex at 1Gbps */
+	config->mac_capabilities = MAC_10 | MAC_100 | MAC_1000FD |
+				   MAC_ASYM_PAUSE | MAC_SYM_PAUSE;
 
+	if (port == CPU_PORT) {
+		__set_bit(PHY_INTERFACE_MODE_RGMII,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_GMII,
+			  config->supported_interfaces);
+	} else {
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  config->supported_interfaces);
+		/* Compatibility for phylib's default interface type when the
+		 * phy-mode property is absent
+		 */
+		__set_bit(PHY_INTERFACE_MODE_GMII,
+			  config->supported_interfaces);
+	}
+}
+
+static void vsc73xx_phylink_mac_config(struct dsa_switch *ds, int port,
+				       unsigned int mode,
+				       const struct phylink_link_state *state)
+{
+	struct vsc73xx *vsc = ds->priv;
 	/* Special handling of the CPU-facing port */
 	if (port == CPU_PORT) {
 		/* Other ports are already initialized but not this one */
@@ -774,101 +795,79 @@ static void vsc73xx_adjust_link(struct dsa_switch *ds, int port,
 			      VSC73XX_ADVPORTM_ENA_GTX |
 			      VSC73XX_ADVPORTM_DDR_MODE);
 	}
+}
 
-	/* This is the MAC confiuration that always need to happen
-	 * after a PHY or the CPU port comes up or down.
-	 */
-	if (!phydev->link) {
-		int ret, err;
-
-		dev_dbg(vsc->dev, "port %d: went down\n",
-			port);
-
-		/* Disable RX on this port */
-		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
-				    VSC73XX_MAC_CFG,
-				    VSC73XX_MAC_CFG_RX_EN, 0);
-
-		/* Discard packets */
-		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
-				    VSC73XX_ARBDISC, BIT(port), BIT(port));
-
-		/* Wait until queue is empty */
-		ret = read_poll_timeout(vsc73xx_read, err,
-					err < 0 || (val & BIT(port)),
-					1000, 10000, false,
-					vsc, VSC73XX_BLOCK_ARBITER, 0,
-					VSC73XX_ARBEMPTY, &val);
-		if (ret)
-			dev_err(vsc->dev,
-				"timeout waiting for block arbiter\n");
-		else if (err < 0)
-			dev_err(vsc->dev, "error reading arbiter\n");
-
-		/* Put this port into reset */
-		vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MAC_CFG,
-			      VSC73XX_MAC_CFG_RESET);
-
-		/* Accept packets again */
-		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
-				    VSC73XX_ARBDISC, BIT(port), 0);
-
-		/* Allow backward dropping of frames from this port */
-		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
-				    VSC73XX_SBACKWDROP, BIT(port), BIT(port));
-
-		/* Receive mask (disable forwarding) */
-		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
-				    VSC73XX_RECVMASK, BIT(port), 0);
+static void vsc73xx_phylink_mac_link_down(struct dsa_switch *ds, int port,
+					  unsigned int mode,
+					  phy_interface_t interface)
+{
+	struct vsc73xx *vsc = ds->priv;
+	int ret, err;
+	u32 val;
 
-		return;
-	}
+	/* Disable RX on this port */
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+			    VSC73XX_MAC_CFG,
+			    VSC73XX_MAC_CFG_RX_EN, 0);
 
-	/* Figure out what speed was negotiated */
-	if (phydev->speed == SPEED_1000) {
-		dev_dbg(vsc->dev, "port %d: 1000 Mbit mode full duplex\n",
-			port);
-
-		/* Set up default for internal port or external RGMII */
-		if (phydev->interface == PHY_INTERFACE_MODE_RGMII)
-			val = VSC73XX_MAC_CFG_1000M_F_RGMII;
-		else
-			val = VSC73XX_MAC_CFG_1000M_F_PHY;
-		vsc73xx_adjust_enable_port(vsc, port, phydev, val);
-	} else if (phydev->speed == SPEED_100) {
-		if (phydev->duplex == DUPLEX_FULL) {
-			val = VSC73XX_MAC_CFG_100_10M_F_PHY;
-			dev_dbg(vsc->dev,
-				"port %d: 100 Mbit full duplex mode\n",
-				port);
-		} else {
-			val = VSC73XX_MAC_CFG_100_10M_H_PHY;
-			dev_dbg(vsc->dev,
-				"port %d: 100 Mbit half duplex mode\n",
-				port);
-		}
-		vsc73xx_adjust_enable_port(vsc, port, phydev, val);
-	} else if (phydev->speed == SPEED_10) {
-		if (phydev->duplex == DUPLEX_FULL) {
-			val = VSC73XX_MAC_CFG_100_10M_F_PHY;
-			dev_dbg(vsc->dev,
-				"port %d: 10 Mbit full duplex mode\n",
-				port);
-		} else {
-			val = VSC73XX_MAC_CFG_100_10M_H_PHY;
-			dev_dbg(vsc->dev,
-				"port %d: 10 Mbit half duplex mode\n",
-				port);
-		}
-		vsc73xx_adjust_enable_port(vsc, port, phydev, val);
-	} else {
+	/* Discard packets */
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
+			    VSC73XX_ARBDISC, BIT(port), BIT(port));
+
+	/* Wait until queue is empty */
+	ret = read_poll_timeout(vsc73xx_read, err, err < 0 || (val & BIT(port)),
+				1000, 10000, false, vsc, VSC73XX_BLOCK_ARBITER,
+				0, VSC73XX_ARBEMPTY, &val);
+	if (ret)
 		dev_err(vsc->dev,
-			"could not adjust link: unknown speed\n");
-	}
+			"timeout waiting for block arbiter\n");
+	else if (err < 0)
+		dev_err(vsc->dev, "error reading arbiter\n");
+
+	/* Put this port into reset */
+	vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MAC_CFG,
+		      VSC73XX_MAC_CFG_RESET);
+
+	/* Accept packets again */
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
+			    VSC73XX_ARBDISC, BIT(port), 0);
+
+	/* Allow backward dropping of frames from this port */
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
+			    VSC73XX_SBACKWDROP, BIT(port), BIT(port));
+
+	/* Receive mask (disable forwarding) */
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+			    VSC73XX_RECVMASK, BIT(port), 0);
+}
+
+static void vsc73xx_phylink_mac_link_up(struct dsa_switch *ds, int port,
+					unsigned int mode,
+					phy_interface_t interface,
+					struct phy_device *phydev,
+					int speed, int duplex,
+					bool tx_pause, bool rx_pause)
+{
+	struct vsc73xx *vsc = ds->priv;
+	u32 val;
+
+	if (speed == SPEED_1000)
+		val = VSC73XX_MAC_CFG_GIGA_MODE | VSC73XX_MAC_CFG_TX_IPG_1000M;
+	else
+		val = VSC73XX_MAC_CFG_TX_IPG_100_10M;
+
+	if (interface == PHY_INTERFACE_MODE_RGMII)
+		val |= VSC73XX_MAC_CFG_CLK_SEL_1000M;
+	else
+		val |= VSC73XX_MAC_CFG_CLK_SEL_EXT;
+
+	if (duplex == DUPLEX_FULL)
+		val |= VSC73XX_MAC_CFG_FDX;
 
 	/* Enable port (forwarding) in the receieve mask */
 	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
 			    VSC73XX_RECVMASK, BIT(port), BIT(port));
+	vsc73xx_adjust_enable_port(vsc, port, val);
 }
 
 static int vsc73xx_port_enable(struct dsa_switch *ds, int port,
@@ -1039,7 +1038,10 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.setup = vsc73xx_setup,
 	.phy_read = vsc73xx_phy_read,
 	.phy_write = vsc73xx_phy_write,
-	.adjust_link = vsc73xx_adjust_link,
+	.phylink_get_caps = vsc73xx_phylink_get_caps,
+	.phylink_mac_config = vsc73xx_phylink_mac_config,
+	.phylink_mac_link_down = vsc73xx_phylink_mac_link_down,
+	.phylink_mac_link_up = vsc73xx_phylink_mac_link_up,
 	.get_strings = vsc73xx_get_strings,
 	.get_ethtool_stats = vsc73xx_get_ethtool_stats,
 	.get_sset_count = vsc73xx_get_sset_count,
-- 
2.34.1

