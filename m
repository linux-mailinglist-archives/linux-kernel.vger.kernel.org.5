Return-Path: <linux-kernel+bounces-57480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2964E84D9A7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8AFE1F23643
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 05:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD410692F7;
	Thu,  8 Feb 2024 05:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktp8QU2S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6BC67C61;
	Thu,  8 Feb 2024 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707371493; cv=none; b=tyzH1vSx2pnJCU+lclJfcQET4O0G0IUyxvO60r/yzsfBZfdrGd/ZB1bC4CHzV9e1WtnZZ5MAywbBC71tXCspukce5rEcPG//MBlW1hdqeRvjGMZxOJc9GEpDoj57/HfU8v3WAiz3OyJYW/H0XMPxg4Ek+/jNkeoB7k307D2vstg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707371493; c=relaxed/simple;
	bh=04/0rCcowbZ6LhgeozKI78kK1WE+TDUCuzqyX4cOs54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B4oy6yjJPi92T/pYtMH25ABFzgNVVuaIB8YiqGF09DePsMX5G0El/qMA/PV9UiS4kN04PU4zekCyb+LWTZsVcppyenWsZO+nzoEfCZ91mOXGcsE8mJfrmZHcCbZWiRnaI671ehOfJv5FA01OZ6NsBgbzFxWIY5RLCWeQwA5wGno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktp8QU2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A04AC433B2;
	Thu,  8 Feb 2024 05:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707371493;
	bh=04/0rCcowbZ6LhgeozKI78kK1WE+TDUCuzqyX4cOs54=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ktp8QU2SJWaNdSdhiyyGTYaFIAx5aMSsTwpoCaQmN6hd4KTti1gD2TYtyfXkr538b
	 XLlBOBeIlTOeQp0R7vR3cdgrrkjs+6OzebQ7hW6YKUFYEpuv1ZfQ8NzIARJNouX4eA
	 SrICo0TBoF9p4kJNP0BjxezVa1t+mR+5krNr3A5XJ8WwuhKCaioUzHXfl8JeXben5c
	 HEt/iqBKEgjVLJXt3njvJfes/Y1wAH6K453uCMky6d2JLIpp4SdYI7wSnKSoQEwAkU
	 VWvWHzouNPvsB3rJ8+i3OJpVFy8BfHoJAvSpyFloa85Md2uH6W9ajbJPrl/5TGyT36
	 Hr4JKMKAnpCnQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CABC4829C;
	Thu,  8 Feb 2024 05:51:33 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Thu, 08 Feb 2024 08:51:32 +0300
Subject: [PATCH netnext 4/8] net: dsa: mt7530: get rid of useless error
 returns on phylink code path
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id:
 <20240208-for-netnext-mt7530-improvements-3-v1-4-d7c1cfd502ca@arinc9.com>
References:
 <20240208-for-netnext-mt7530-improvements-3-v1-0-d7c1cfd502ca@arinc9.com>
In-Reply-To:
 <20240208-for-netnext-mt7530-improvements-3-v1-0-d7c1cfd502ca@arinc9.com>
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: mithat.guner@xeront.com, erkin.bozoglu@xeront.com, 
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707371489; l=6745;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=EL1vGonmNpBImZU3uthb96aDLRU2riphSBzoDbxXdI8=;
 b=+ZfTF2PzXOAXJWhWYzvsWUbt3wlj8uFvX0J+2ylIt9WHjutCGTQCJj+dufi/SMtYZ8uWHmuSv
 gpM4l26s9iXBD7yzQC6105Z1XYp1dzZHcHSWaXqh0fWyy0EpWa8PSZN
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Remove error returns on the cases where they are already handled with the
function the mac_port_get_caps member in mt753x_table points to.

mt7531_mac_config() is also called from mt7531_cpu_port_config() outside of
phylink but the port and interface modes are already handled there.

Change the functions and the mac_port_config function pointer to void now
that there're no error returns anymore.

Remove mt753x_is_mac_port() that used to help the said error returns.

On mt7531_mac_config(), switch to if statements to simplify the code.

Remove internal phy cases from mt753x_phylink_mac_config(), there is no
need to check the interface mode as that's already handled with the
function the mac_port_get_caps member in mt753x_table points to.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Tested-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 81 ++++++++++--------------------------------------
 drivers/net/dsa/mt7530.h |  6 ++--
 2 files changed, 19 insertions(+), 68 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 296711fd5c43..c069bf273733 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2587,7 +2587,7 @@ static void mt7988_mac_port_get_caps(struct dsa_switch *ds, int port,
 	}
 }
 
-static int
+static void
 mt7530_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 		  phy_interface_t interface)
 {
@@ -2597,22 +2597,14 @@ mt7530_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 		mt7530_setup_port5(priv->ds, interface);
 	else if (port == 6)
 		mt7530_setup_port6(priv->ds, interface);
-
-	return 0;
 }
 
-static int mt7531_rgmii_setup(struct mt7530_priv *priv, u32 port,
-			      phy_interface_t interface,
-			      struct phy_device *phydev)
+static void mt7531_rgmii_setup(struct mt7530_priv *priv, u32 port,
+			       phy_interface_t interface,
+			       struct phy_device *phydev)
 {
 	u32 val;
 
-	if (priv->p5_sgmii) {
-		dev_err(priv->dev, "RGMII mode is not available for port %d\n",
-			port);
-		return -EINVAL;
-	}
-
 	val = mt7530_read(priv, MT7531_CLKGEN_CTRL);
 	val |= GP_CLK_EN;
 	val &= ~GP_MODE_MASK;
@@ -2640,20 +2632,14 @@ static int mt7531_rgmii_setup(struct mt7530_priv *priv, u32 port,
 		case PHY_INTERFACE_MODE_RGMII_ID:
 			break;
 		default:
-			return -EINVAL;
+			break;
 		}
 	}
-	mt7530_write(priv, MT7531_CLKGEN_CTRL, val);
-
-	return 0;
-}
 
-static bool mt753x_is_mac_port(u32 port)
-{
-	return (port == 5 || port == 6);
+	mt7530_write(priv, MT7531_CLKGEN_CTRL, val);
 }
 
-static int
+static void
 mt7531_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 		  phy_interface_t interface)
 {
@@ -2661,42 +2647,21 @@ mt7531_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 	struct phy_device *phydev;
 	struct dsa_port *dp;
 
-	if (!mt753x_is_mac_port(port)) {
-		dev_err(priv->dev, "port %d is not a MAC port\n", port);
-		return -EINVAL;
-	}
-
-	switch (interface) {
-	case PHY_INTERFACE_MODE_RGMII:
-	case PHY_INTERFACE_MODE_RGMII_ID:
-	case PHY_INTERFACE_MODE_RGMII_RXID:
-	case PHY_INTERFACE_MODE_RGMII_TXID:
+	if (phy_interface_mode_is_rgmii(interface)) {
 		dp = dsa_to_port(ds, port);
 		phydev = dp->user->phydev;
-		return mt7531_rgmii_setup(priv, port, interface, phydev);
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_NA:
-	case PHY_INTERFACE_MODE_1000BASEX:
-	case PHY_INTERFACE_MODE_2500BASEX:
-		/* handled in SGMII PCS driver */
-		return 0;
-	default:
-		return -EINVAL;
+		mt7531_rgmii_setup(priv, port, interface, phydev);
 	}
-
-	return -EINVAL;
 }
 
-static int
+static void
 mt753x_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 		  const struct phylink_link_state *state)
 {
 	struct mt7530_priv *priv = ds->priv;
 
-	if (!priv->info->mac_port_config)
-		return 0;
-
-	return priv->info->mac_port_config(ds, port, mode, state->interface);
+	if (priv->info->mac_port_config)
+		priv->info->mac_port_config(ds, port, mode, state->interface);
 }
 
 static struct phylink_pcs *
@@ -2725,17 +2690,11 @@ mt753x_phylink_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 	u32 mcr_cur, mcr_new;
 
 	switch (port) {
-	case 0 ... 4:
-		if (state->interface != PHY_INTERFACE_MODE_GMII &&
-		    state->interface != PHY_INTERFACE_MODE_INTERNAL)
-			goto unsupported;
-		break;
 	case 5:
 		if (priv->p5_interface == state->interface)
 			break;
 
-		if (mt753x_mac_config(ds, port, mode, state) < 0)
-			goto unsupported;
+		mt753x_mac_config(ds, port, mode, state);
 
 		if (priv->p5_intf_sel != P5_DISABLED)
 			priv->p5_interface = state->interface;
@@ -2744,16 +2703,10 @@ mt753x_phylink_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 		if (priv->p6_interface == state->interface)
 			break;
 
-		if (mt753x_mac_config(ds, port, mode, state) < 0)
-			goto unsupported;
+		mt753x_mac_config(ds, port, mode, state);
 
 		priv->p6_interface = state->interface;
 		break;
-	default:
-unsupported:
-		dev_err(ds->dev, "%s: unsupported %s port: %i\n",
-			__func__, phy_modes(state->interface), port);
-		return;
 	}
 
 	mcr_cur = mt7530_read(priv, MT7530_PMCR_P(port));
@@ -2836,7 +2789,6 @@ mt7531_cpu_port_config(struct dsa_switch *ds, int port)
 	struct mt7530_priv *priv = ds->priv;
 	phy_interface_t interface;
 	int speed;
-	int ret;
 
 	switch (port) {
 	case 5:
@@ -2861,9 +2813,8 @@ mt7531_cpu_port_config(struct dsa_switch *ds, int port)
 	else
 		speed = SPEED_1000;
 
-	ret = mt7531_mac_config(ds, port, MLO_AN_FIXED, interface);
-	if (ret)
-		return ret;
+	mt7531_mac_config(ds, port, MLO_AN_FIXED, interface);
+
 	mt7530_write(priv, MT7530_PMCR_P(port),
 		     PMCR_CPU_PORT_SETTING(priv->id));
 	mt753x_phylink_mac_link_up(ds, port, MLO_AN_FIXED, interface, NULL,
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 26a6d2160c08..b1665de7f640 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -730,9 +730,9 @@ struct mt753x_info {
 	void (*mac_port_validate)(struct dsa_switch *ds, int port,
 				  phy_interface_t interface,
 				  unsigned long *supported);
-	int (*mac_port_config)(struct dsa_switch *ds, int port,
-			       unsigned int mode,
-			       phy_interface_t interface);
+	void (*mac_port_config)(struct dsa_switch *ds, int port,
+				unsigned int mode,
+				phy_interface_t interface);
 };
 
 /* struct mt7530_priv -	This is the main data structure for holding the state

-- 
2.40.1


