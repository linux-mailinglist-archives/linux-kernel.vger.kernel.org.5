Return-Path: <linux-kernel+bounces-89177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 751B686EBA5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287F0283589
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B3B5A118;
	Fri,  1 Mar 2024 22:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHd4K+lk"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BC55A0F7;
	Fri,  1 Mar 2024 22:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709331458; cv=none; b=LVSBenjhE/FV2Sb8iTAU7v8G9xzHHidnEOb7HhBZKdCWKqkm+pdDtCWFuJ5FV36hpYOp9+5ubS+jtNbUwC7SHBj/y3Fko2ymcmLohZfwOw0K43fj6/UEUtmOrruJdDnqJYzJ4OlYr6noFhuGgX4kL+Zp9/A6LXxUaq4ZcCOqhsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709331458; c=relaxed/simple;
	bh=AUT3d98BN36iVpQBCLQndItQ97wTCDJ9Sn2fjVqS50g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X0Xxvfbnzaa5ahd4M7Ec8JgpqW1bIPC0DI7HnLz7njfW8lXPkcHmu8VNTqzWLoPJKVJmWUaDv7azllDA2aOZcfJ6MqJKQvpGYVpBsy1f5HtBduTbKNI+xKM1/iTw5xTcoAHqsZ7EtLSW+L/GaO3WXyA5CRdn+ask5ljcOyz6lcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHd4K+lk; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4429c556efso428709366b.0;
        Fri, 01 Mar 2024 14:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709331454; x=1709936254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esyWdk7pK43NcDbXyKWe3ASdlab0DBbFS/CLGYhdRr8=;
        b=EHd4K+lkNWpx//aWqrEoTK17EeX7E4iZYK0A7UZM8crD5gn9AAT5hD+lJeeAxPBgNn
         xDAp2yg9dWRoQ7tcxPJTtoKghtF+3PpLRrnLrZN7PMMmjC2XC+7pGLJp899VQ5fbtvG+
         iZrJFllIlXbE8NJhqI6EhX6GEo0OmrdB18DgN07Anrf5jYOBQxe/fydIYCDhQgCUhzzY
         QlOtHLyU2sWKWH58inKoIAUL96pfwPQjx63NXVnwY0OiteMwtmfBuwh29YI4d+EMxZ73
         yUKszIR5Wb+r2XLgT2Fhg/jPzJHF3M/BI+NHTLazvisTooYEu4BTxiNSjgVs5oXpgnrB
         XKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709331454; x=1709936254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=esyWdk7pK43NcDbXyKWe3ASdlab0DBbFS/CLGYhdRr8=;
        b=tChzVK3N41IKVpavz3AyiBeuUFDl18PmP6N9bqOgEdTmvSYllG6Nvo0zdf/L32MtDU
         1rX8D/jkppuAdISzQj5wY0d/zPoGDqAP2ktC0U/jNseD2jykXVerIbC73cddfjR/NMl1
         Jiw9L2pDhl63Ru900cXYs8zNBn0rcEQsxK26/ZhLe+tfw7GycRh6s9Sk4fLa6DfykVgj
         1q5A5nZlGSEvEYDd6kcxwNYgxwoQKxHFb9K0bwK0hWCGsTIDfP82qUGdiNpVJ7nXVH6f
         gCMb2imJRSkxMS/w5j3kPoCyOV0+FEYSiLAuWJIeZokv0I8lQWuzfmjvBiabO3K4v680
         38+w==
X-Forwarded-Encrypted: i=1; AJvYcCWzFIHIavS80VmCqnwOfU6BSlJkt4ctXAIisRNlNbVz10qyR3/ona1TvSyR2cz+4mnJo8asCwAFvC3gDufnh1RAU4+/OwGt//YenWbk
X-Gm-Message-State: AOJu0YyzZjmYboQ3R0HXVRjLzytf4eQlsuniM5lSiKvcTE5CERpUcyh9
	6sEl6fR4KTBnBT2PIb/7z/ZMG0N8R5xIBRca80JdOLUNOiP/Iz70rgftP4FCvCo=
X-Google-Smtp-Source: AGHT+IFEtiEaj4F2XtsFcvblk6meeuhvaK2BYHBM+8ysOI5KMEA9AgGzcvGMs+BC9qecxLqrsq4Xhw==
X-Received: by 2002:a17:906:b85a:b0:a43:de54:c02b with SMTP id ga26-20020a170906b85a00b00a43de54c02bmr2268488ejb.17.1709331454469;
        Fri, 01 Mar 2024 14:17:34 -0800 (PST)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id g16-20020a17090613d000b00a3f480154a3sm2091122ejc.65.2024.03.01.14.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 14:17:34 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
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
Subject: [PATCH net-next v6 02/16] net: dsa: vsc73xx: convert to PHYLINK
Date: Fri,  1 Mar 2024 23:16:24 +0100
Message-Id: <20240301221641.159542-3-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301221641.159542-1-paweldembicki@gmail.com>
References: <20240301221641.159542-1-paweldembicki@gmail.com>
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
v6:
  - resend only
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


