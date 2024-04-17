Return-Path: <linux-kernel+bounces-149219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C4A8A8D4B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D029BB24EBF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E285A115;
	Wed, 17 Apr 2024 20:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzSnsSgC"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B4C482C2;
	Wed, 17 Apr 2024 20:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713387104; cv=none; b=kFlRbpGuGEp7wLlXDcnNBUKfFBqNd19mvGQgV3mqplRH8eRO03ApR9OgAerwlSNvBOJ2xUxKh+NcvncVqVU5jtjHJBB7VviH+4XC8vYnr5NJo4b6Pg1J7XfWtXi2kLWpultP4X682c6OSHVpalCJfz4MJGMBCjcFLKhboL+uVo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713387104; c=relaxed/simple;
	bh=li6gxELG7YoAR3RtFRzXo2T1OsGHaI82BhYM0ZR77ZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rUme2ObkyY//F7ADrNQ6Y/st6f0L8PNrFizZ2kSrJBcP9ngNX3ZJMWNvB2UrpQQqL9J+iDDQIG1BfYaZD8gO812T+AGdeimlvqV9cOMtkNsk/u1lNhmTzbQTD5MClpgT6tSApP3rtmMsnUt5JDZnYfpPOJkIY9bRAiGbbIxqc3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzSnsSgC; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a51a1c8d931so7632366b.0;
        Wed, 17 Apr 2024 13:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713387101; x=1713991901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LndIqiYxYEBtJvQLkqHP82CdF7FlUA9QfP6zNgEm7/A=;
        b=ZzSnsSgCTnL9VwdLdJmYIYhvCtdN1XNjzpYm+eFdakJTvLJNun6Tr9uQnvWWmM0MsU
         6Aht51O+Do2PlZRDJakusOzNfp5gtgmYes8qqulHXNAK8tE1Gr8K0qoAkc4+ggPmBdrq
         xn4OZ4as7oRCo28mmr2YCx94IkfoX6EO3lXkPkP1wop1bDl0yNPL4SmKyvK3xH9ZlGX4
         O8qRu/4mg863ALyqxz9HCUytxbV27vp9I7K0LtXyk4InVNenarNFlGqs6FkCOOA5Nn+d
         3Dx0EkJpJj9ETKK8w1S7xCExn6IwVfNXtHkybo9G7xQvJMZ/TFSblMPKmk8TG+Lp4D5n
         djFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713387101; x=1713991901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LndIqiYxYEBtJvQLkqHP82CdF7FlUA9QfP6zNgEm7/A=;
        b=SbGqB/OWoE5WfmtWROzLw4Gx/2wTW6fExBY3j84aW4D/BAJyq/YC8KfdSDjM59n2+K
         hbIk7udA8sDgTLZVGNFEhHa5Jxy5wCqJCEbeYP1yrFCf3jCCx1Cuyie/B5pLRh9iuU5d
         X7Ot1bd3i2SsmaC3aCcocPqszzfGGMMh4UqVlPE2yHithyjWbAzMwFGUPBkczcdKoMME
         2Qj+8/d00zJKDQ4x+cH0zx02mS8OIT96kr04ukLIE2q/DQzvs+UwCzhcW8cladiSamTl
         JOa/T8kVhOYAO0AMz4ycKx78CHcQu9H1a6N7r5M1OB49Fd2UaAjzjESYPFRGmxabyTKn
         Gu/g==
X-Forwarded-Encrypted: i=1; AJvYcCUi5aczcr7HpEFW8P32rKCG8UYJecaY8d5+ytR+bi0aYxZqCP9geLeLwRkUmsVjklHMYOeR2LBYEKgBrp8VFPXqXeQa1gk/UIyOYrzw
X-Gm-Message-State: AOJu0YwkevudjUDbE8C8lSU94cCLt0Aj7RJ+rtIbQI7c98Qq6ZSg6HyS
	gHy0/7DFcYKivRP0RZlMg2sgdlAzwR5eBNe9PJVrndoOnF5QIH7ro8WouZ0/
X-Google-Smtp-Source: AGHT+IHSBFWo3Lt0g+SpfJGwcuxvmS7r/nFih5dfdU1pfj91GTjNk68GNbDgB7R5Kh3mPVdd3s/y1g==
X-Received: by 2002:a17:906:d8d2:b0:a52:56e8:2252 with SMTP id re18-20020a170906d8d200b00a5256e82252mr415553ejb.51.1713387100432;
        Wed, 17 Apr 2024 13:51:40 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id tx24-20020a1709078e9800b00a554177a2cdsm31752ejc.85.2024.04.17.13.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 13:51:40 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/5] net: dsa: vsc73xx: convert to PHYLINK
Date: Wed, 17 Apr 2024 22:50:45 +0200
Message-Id: <20240417205048.3542839-3-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417205048.3542839-1-paweldembicki@gmail.com>
References: <20240417205048.3542839-1-paweldembicki@gmail.com>
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
mac_link_* and mac_config from phylink_mac_ops structure.

Removes:
adjust_link
Adds phylink_mac_ops structure:
mac_config
mac_link_up
mac_link_down

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v2:
  - use 'phylink_mac_ops' structure instead '.phylink_mac*'

 drivers/net/dsa/vitesse-vsc73xx-core.c | 242 ++++++++++++-------------
 1 file changed, 116 insertions(+), 126 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index ab5771d4d828..3f8edac9aa5c 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -717,51 +717,44 @@ static void vsc73xx_init_port(struct vsc73xx *vsc, int port)
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
+static void vsc73xx_mac_config(struct phylink_config *config, unsigned int mode,
+			       const struct phylink_link_state *state)
 {
-	struct vsc73xx *vsc = ds->priv;
-	u32 val;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct vsc73xx *vsc = dp->ds->priv;
+	int port = dp->index;
 
 	/* Special handling of the CPU-facing port */
 	if (port == CPU_PORT) {
@@ -778,102 +771,93 @@ static void vsc73xx_adjust_link(struct dsa_switch *ds, int port,
 			      VSC73XX_ADVPORTM_ENA_GTX |
 			      VSC73XX_ADVPORTM_DDR_MODE);
 	}
+}
+
+static void vsc73xx_mac_link_down(struct phylink_config *config,
+				  unsigned int mode, phy_interface_t interface)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct vsc73xx *vsc = dp->ds->priv;
+	int port = dp->index;
 
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
+static void vsc73xx_mac_link_up(struct phylink_config *config,
+				struct phy_device *phy, unsigned int mode,
+				phy_interface_t interface, int speed,
+				int duplex, bool tx_pause, bool rx_pause)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct vsc73xx *vsc = dp->ds->priv;
+	int port = dp->index;
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
@@ -1055,12 +1039,17 @@ static void vsc73xx_phylink_get_caps(struct dsa_switch *dsa, int port,
 	config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100 | MAC_1000;
 }
 
+static const struct phylink_mac_ops vsc73xx_phylink_mac_ops = {
+	.mac_config = vsc73xx_mac_config,
+	.mac_link_down = vsc73xx_mac_link_down,
+	.mac_link_up = vsc73xx_mac_link_up,
+};
+
 static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.get_tag_protocol = vsc73xx_get_tag_protocol,
 	.setup = vsc73xx_setup,
 	.phy_read = vsc73xx_phy_read,
 	.phy_write = vsc73xx_phy_write,
-	.adjust_link = vsc73xx_adjust_link,
 	.get_strings = vsc73xx_get_strings,
 	.get_ethtool_stats = vsc73xx_get_ethtool_stats,
 	.get_sset_count = vsc73xx_get_sset_count,
@@ -1217,6 +1206,7 @@ int vsc73xx_probe(struct vsc73xx *vsc)
 	vsc->ds->priv = vsc;
 
 	vsc->ds->ops = &vsc73xx_ds_ops;
+	vsc->ds->phylink_mac_ops = &vsc73xx_phylink_mac_ops;
 	ret = dsa_register_switch(vsc->ds);
 	if (ret) {
 		dev_err(dev, "unable to register switch (%d)\n", ret);
-- 
2.34.1


