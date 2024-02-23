Return-Path: <linux-kernel+bounces-79161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC34861E5C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF781F256EC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075741493A8;
	Fri, 23 Feb 2024 21:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MImA3q6T"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F12146E8C;
	Fri, 23 Feb 2024 21:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722114; cv=none; b=Tt0XwH4fo8qyUkNJEw0J1MrMhs/lz4rv2Yjq3BBlDErhQVE6AxgZQPaX907hRpoT8eermMXIfubXxMSx6eKy3Ezh8b26VyNS5HIVEyjhceYjkjUXQukqucDwmqmh6tVEJfRyb9rNb1QN1ipcFAN3FwR8pBPWAIchCc2/i9gnFyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722114; c=relaxed/simple;
	bh=2IGaelDIgCYR4RgiqKcmwo0tHaiSsj2BS1E8ORjmnkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zn+O5rAXQibYBDLqzu+jSPdX1jyTSegFPp0/6jplq2P/5/u00bmOuvl/GxGRtdp+YLuPxmgm9/TNHM2IlHSwx6Pe3QBGutG91o54Gg3Rq1U30tsQAn2foyHg6D5Rtazrf1cO38dRQ7PZwJiZNddFEKEW4ldysQver+agUgp/1oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MImA3q6T; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-564647bcdbfso1238403a12.2;
        Fri, 23 Feb 2024 13:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708722110; x=1709326910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5w6OYQ2wklfdPvhp1HMp63z3R/jBQE2KyU5Swu+vJNw=;
        b=MImA3q6TALZmrX0v1mirw1ApSJGvXp3R6WWAIun9+Rx7VKwrWHZnfW6PZ81AY3yyGF
         L0Mhvy/4axHD4BTTXkQ0cJIYuDvrPjHCb/0Ali0S4rk9L9CBZyUh0qa/S5Q0cr42pb4l
         J91KTzipckIv5mvjUHcTk6jEivp1Ebd5HI2bju+HLuOTdeN/A1FDEGiIsfEX+WjnL+OI
         UHvHmtquvb2cUf9SrH49y3j3hWGYT6WEdJMWk9ul4qhV7uvnmw6UOEjHCE+cm48uVWSc
         nPQovRZBhHftTLj0PKRiSmnLFHVzDtPMglR21l4INXZi31Iqw8Tyw0/oC0LL65CE0MFJ
         fIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708722110; x=1709326910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5w6OYQ2wklfdPvhp1HMp63z3R/jBQE2KyU5Swu+vJNw=;
        b=puXZEhU7FoTfkbQ+D6RZkgj0K77weaYcQw6Vb0/1wPVPmKtNCHtiQW8qelafR3Ad0l
         q8DDtq8NnMmtS8IOQ4E4IXhWIlpNPdeu3FvPc8TkWoFVvlN7ErYqJ6sMbPf390ECDrZA
         B+PDZYErpICXNUyIyEJssTPQLM0rcy2KklWu6Ggwt4R0gvfB66KGVJGf/O5CaCPhgXdM
         4qi+TNfmffUH/MzHBlPJgFBVzFgLGIuJAEnqHVdkgc2+D4rKS5QdBxruRH4VTmJqG3nI
         Ghs9sP/nh+/Hg6RsD8XwmvX9u/vq+kn1LnFZMteqMGbSgV4UO8asuBDaxFoVozPjAKxc
         FnNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEr7j5r8Rd7Zw03vrB1MzVIEOi/SZKMSvIX/XJ8Rj/huhAl+cH/qH4VpI/btd0dMWUmbn6JclKjmjv8PAOmoFfndu6yl6ONy2ZdZqM
X-Gm-Message-State: AOJu0Yx6VMYcdUvxOxSDBysTdG3gqZqurU/flWVprQv7OOClq5VqLFKd
	e/nl14wKGftzJcHzI6k9hdXjCMbjdvHlY/9AJbsmPE8XhMnY5G80/jXMF2pA7OU=
X-Google-Smtp-Source: AGHT+IEtd+hfrVnCC4fnjGCN3lhF25TkchqQ/1pf/DH4YLm5ynXY0A0tYCFO6rDOjh4Qy6H+6jrvQA==
X-Received: by 2002:a17:906:d04e:b0:a3e:63bd:3ae1 with SMTP id bo14-20020a170906d04e00b00a3e63bd3ae1mr547419ejb.9.1708722110351;
        Fri, 23 Feb 2024 13:01:50 -0800 (PST)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id st11-20020a170907c08b00b00a3e559aaff9sm6185424ejc.29.2024.02.23.13.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 13:01:49 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 02/16] net: dsa: vsc73xx: convert to PHYLINK
Date: Fri, 23 Feb 2024 22:00:32 +0100
Message-Id: <20240223210049.3197486-3-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223210049.3197486-1-paweldembicki@gmail.com>
References: <20240223210049.3197486-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch replaces the adjust_link api with the phylink apis that provide
equivalent functionality.

The remaining functionality from the adjust_link is now covered in the
phylink_mac_link_* and phylink_mac_config.

Removes:
adjust_link
Adds:
phylink_mac_config
phylink_mac_link_up
phylink_mac_link_down

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v5:
  - introduce MAC reset function with procedure described in datasheet
  - reorganise routines
  - move 'Accept packets again' routine to 'phylink_mac_link_up'
  - fix one FIXME
v4:
  - update commit descripion
  - remove phylink_get_caps after rebase to current net-next/main
v3:
  - remove legacy_pre_march2020 after rebase
v2:
  - replace switch to if and get rid of macros in
    vsc73xx_phylink_mac_link_up function

 drivers/net/dsa/vitesse-vsc73xx-core.c | 235 ++++++++++++-------------
 1 file changed, 109 insertions(+), 126 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index ab5771d4d828..cb2e7e256279 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -717,52 +717,43 @@ static void vsc73xx_init_port(struct vsc73xx *vsc, int port)
 		      port, VSC73XX_C_RX0, 0);
 }
 
-static void vsc73xx_adjust_enable_port(struct vsc73xx *vsc,
-				       int port, struct phy_device *phydev,
-				       u32 initval)
+static void vsc73xx_reset_port(struct vsc73xx *vsc, int port, u32 initval)
 {
-	u32 val = initval;
-	u8 seed;
-
-	/* Reset this port FIXME: break out subroutine */
-	val |= VSC73XX_MAC_CFG_RESET;
-	vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MAC_CFG, val);
-
-	/* Seed the port randomness with randomness */
-	get_random_bytes(&seed, 1);
-	val |= seed << VSC73XX_MAC_CFG_SEED_OFFSET;
-	val |= VSC73XX_MAC_CFG_SEED_LOAD;
-	val |= VSC73XX_MAC_CFG_WEXC_DIS;
-	vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MAC_CFG, val);
+	int ret, err;
+	u32 val;
 
-	/* Flow control for the PHY facing ports:
-	 * Use a zero delay pause frame when pause condition is left
-	 * Obey pause control frames
-	 * When generating pause frames, use 0xff as pause value
-	 */
-	vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_FCCONF,
-		      VSC73XX_FCCONF_ZERO_PAUSE_EN |
-		      VSC73XX_FCCONF_FLOW_CTRL_OBEY |
-		      0xff);
+	/* Disable RX on this port */
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+			    VSC73XX_MAC_CFG,
+			    VSC73XX_MAC_CFG_RX_EN, 0);
 
-	/* Disallow backward dropping of frames from this port */
+	/* Discard packets */
 	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
-			    VSC73XX_SBACKWDROP, BIT(port), 0);
+			    VSC73XX_ARBDISC, BIT(port), BIT(port));
+
+	/* Wait until queue is empty */
+	ret = read_poll_timeout(vsc73xx_read, err,
+				err < 0 || (val & BIT(port)),
+				VSC73XX_POLL_SLEEP_US,
+				VSC73XX_POLL_TIMEOUT_US, false,
+				vsc, VSC73XX_BLOCK_ARBITER, 0,
+				VSC73XX_ARBEMPTY, &val);
+	if (ret)
+		dev_err(vsc->dev,
+			"timeout waiting for block arbiter\n");
+	else if (err < 0)
+		dev_err(vsc->dev, "error reading arbiter\n");
 
-	/* Enable TX, RX, deassert reset, stop loading seed */
-	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
-			    VSC73XX_MAC_CFG,
-			    VSC73XX_MAC_CFG_RESET | VSC73XX_MAC_CFG_SEED_LOAD |
-			    VSC73XX_MAC_CFG_TX_EN | VSC73XX_MAC_CFG_RX_EN,
-			    VSC73XX_MAC_CFG_TX_EN | VSC73XX_MAC_CFG_RX_EN);
+	/* Put this port into reset */
+	vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MAC_CFG,
+		      VSC73XX_MAC_CFG_RESET | initval);
 }
 
-static void vsc73xx_adjust_link(struct dsa_switch *ds, int port,
-				struct phy_device *phydev)
+static void vsc73xx_phylink_mac_config(struct dsa_switch *ds, int port,
+				       unsigned int mode,
+				       const struct phylink_link_state *state)
 {
 	struct vsc73xx *vsc = ds->priv;
-	u32 val;
-
 	/* Special handling of the CPU-facing port */
 	if (port == CPU_PORT) {
 		/* Other ports are already initialized but not this one */
@@ -778,102 +769,92 @@ static void vsc73xx_adjust_link(struct dsa_switch *ds, int port,
 			      VSC73XX_ADVPORTM_ENA_GTX |
 			      VSC73XX_ADVPORTM_DDR_MODE);
 	}
+}
+
+static void vsc73xx_phylink_mac_link_down(struct dsa_switch *ds, int port,
+					  unsigned int mode,
+					  phy_interface_t interface)
+{
+	struct vsc73xx *vsc = ds->priv;
 
-	/* This is the MAC confiuration that always need to happen
-	 * after a PHY or the CPU port comes up or down.
+	/* This routine is described in the datasheet (below ARBDISC register
+	 * description)
 	 */
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
-					VSC73XX_POLL_SLEEP_US,
-					VSC73XX_POLL_TIMEOUT_US, false,
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
+	vsc73xx_reset_port(vsc, port, 0);
 
-		return;
-	}
+	/* Allow backward dropping of frames from this port */
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
+			    VSC73XX_SBACKWDROP, BIT(port), BIT(port));
 
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
-		dev_err(vsc->dev,
-			"could not adjust link: unknown speed\n");
-	}
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
+	u8 seed;
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
+
+	/* This routine is described in the datasheet (below ARBDISC register
+	 * description)
+	 */
+	vsc73xx_reset_port(vsc, port, val);
+
+	/* Seed the port randomness with randomness */
+	get_random_bytes(&seed, 1);
+	val |= seed << VSC73XX_MAC_CFG_SEED_OFFSET;
+	val |= VSC73XX_MAC_CFG_SEED_LOAD;
+	val |= VSC73XX_MAC_CFG_WEXC_DIS;
+	vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MAC_CFG, val);
+
+	/* Flow control for the PHY facing ports:
+	 * Use a zero delay pause frame when pause condition is left
+	 * Obey pause control frames
+	 * When generating pause frames, use 0xff as pause value
+	 */
+	vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_FCCONF,
+		      VSC73XX_FCCONF_ZERO_PAUSE_EN |
+		      VSC73XX_FCCONF_FLOW_CTRL_OBEY |
+		      0xff);
+
+	/* Accept packets again */
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
+			    VSC73XX_ARBDISC, BIT(port), 0);
 
 	/* Enable port (forwarding) in the receieve mask */
 	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
 			    VSC73XX_RECVMASK, BIT(port), BIT(port));
+
+	/* Disallow backward dropping of frames from this port */
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
+			    VSC73XX_SBACKWDROP, BIT(port), 0);
+
+	/* Enable TX, RX, deassert reset, stop loading seed */
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+			    VSC73XX_MAC_CFG,
+			    VSC73XX_MAC_CFG_RESET | VSC73XX_MAC_CFG_SEED_LOAD |
+			    VSC73XX_MAC_CFG_TX_EN | VSC73XX_MAC_CFG_RX_EN,
+			    VSC73XX_MAC_CFG_TX_EN | VSC73XX_MAC_CFG_RX_EN);
 }
 
 static int vsc73xx_port_enable(struct dsa_switch *ds, int port,
@@ -1060,7 +1041,9 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.setup = vsc73xx_setup,
 	.phy_read = vsc73xx_phy_read,
 	.phy_write = vsc73xx_phy_write,
-	.adjust_link = vsc73xx_adjust_link,
+	.phylink_mac_config = vsc73xx_phylink_mac_config,
+	.phylink_mac_link_down = vsc73xx_phylink_mac_link_down,
+	.phylink_mac_link_up = vsc73xx_phylink_mac_link_up,
 	.get_strings = vsc73xx_get_strings,
 	.get_ethtool_stats = vsc73xx_get_ethtool_stats,
 	.get_sset_count = vsc73xx_get_sset_count,
-- 
2.34.1


