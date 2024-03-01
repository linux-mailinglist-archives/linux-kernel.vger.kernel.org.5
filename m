Return-Path: <linux-kernel+bounces-88273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA3186DF87
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CECCE1F238B9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F806F086;
	Fri,  1 Mar 2024 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8bHXvF3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A006BFA4;
	Fri,  1 Mar 2024 10:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709289779; cv=none; b=CnfCrW6SXm1V4V8ew1qUzDpwlm6ponqvT+g0sQ/pdB9gBMmoBxp2Hs3K1TVRH7OJ4rP1ROkuvWBul9AqoHiLYzp7UIoarp43izUcaVIchhTz4Oq2H35WqpR6P9olvw1dDD+/kPPcUvnhajtmTgvBv/8uvNrqE/1twARsy1N/TM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709289779; c=relaxed/simple;
	bh=DR53Fwp6HNZjxK1JVF84xhxkGcyxADr/AxiABLJCtN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HsDbkQyvjQK78nIFi47WgxgmUEPoLLDeJjB6P92H+tV76iUzDMNH9beVtsntERjkqN898ITrZpGTCpe428En/UdJWGh30P0Y2rR0KA/liIlBI5wHXJBbRNZzOUaoWVuv4bSjS+8TIZgWK9gtlyq5NTTFxaPy7NqcZTyKBqfcTRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8bHXvF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF1A7C433B1;
	Fri,  1 Mar 2024 10:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709289779;
	bh=DR53Fwp6HNZjxK1JVF84xhxkGcyxADr/AxiABLJCtN8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=I8bHXvF3o7elVJA8BKugGEBG9vcZROdGoj3r1naAd9HleeL7O6SbjJUmzOBLE/QgE
	 e7SxM7A5ZidFlnePB2b1j5R/lAfR++SFINXOmenRyRSa2Tgesehstqj5Vyse4mFIu2
	 PXFFM9XvTYGIr2Zk2MI5EJ9AZIfeqkw9Um9ibpO3q34oJMPA5fwEUopkQXWnbESxnU
	 wnDSYHDrAipfy8xQcus0BTG5syuWyAnMR5qrURc3KZcHQHrW6aaJvkNimLAt1PHaLY
	 YjmkT3TDmK/4Bm1b56LPZitqi4O8fP8eaONr01sbgpK3W3ob4vtqVNXNZ2Um0NlWOe
	 MslhUHQTPVu6Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC232C5478C;
	Fri,  1 Mar 2024 10:42:58 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Fri, 01 Mar 2024 12:43:01 +0200
Subject: [PATCH net-next v3 5/9] net: dsa: mt7530: get rid of
 priv->info->cpu_port_config()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id:
 <20240301-for-netnext-mt7530-improvements-3-v3-5-449f4f166454@arinc9.com>
References:
 <20240301-for-netnext-mt7530-improvements-3-v3-0-449f4f166454@arinc9.com>
In-Reply-To:
 <20240301-for-netnext-mt7530-improvements-3-v3-0-449f4f166454@arinc9.com>
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
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709289776; l=10123;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=Y1TCfcdqvG7M9i52Rn8kNxeSZjlmBTTpQoxELLR7z1I=;
 b=urv+2TWJiwr6/poCf0c7I1eYy8HybNgPMsKXd6ydEaiPkVeGLvtPSD9Q+yEe3+X2jfxizX3zB
 XoCFRjgdNvxBockuvSY19J+iad7K+se9fkEC4w3P3dkiGjx/wIqRw7t
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront with auth_id=137
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

From: Arınç ÜNAL <arinc.unal@arinc9.com>

priv->info->cpu_port_config() is used for MT7531 and the switch on the
MT7988 SoC. It sets up the ports described as a CPU port earlier than the
phylink code path would do.

This function is useless as:
- Configuring the MACs can be done from the phylink_mac_config code path
  instead.
- All the link configuration it does on the CPU ports are later undone with
  the port_enable, phylink_mac_config, and then phylink_mac_link_up code
  path [1].

priv->p5_interface and priv->p6_interface were being used to prevent
configuring the MACs from the phylink_mac_config code path. Remove them now
that they hold no purpose.

Remove priv->info->cpu_port_config(). On mt753x_phylink_mac_config, switch
to if statements to simplify the code.

Remove the overwriting of the speed and duplex interfaces for certain
interface modes. Phylink already provides the speed and duplex variables
with proper values. Phylink already sets the max speed of TRGMII to
SPEED_1000. Add SPEED_2500 for PHY_INTERFACE_MODE_2500BASEX to where the
speed and EEE bits are set instead.

On the switch on the MT7988 SoC, PHY_INTERFACE_MODE_INTERNAL is being used
to describe the interface mode of the 10G MAC, which is of port 6. On
mt7988_cpu_port_config() PMCR_FORCE_SPEED_1000 was set via the
PMCR_CPU_PORT_SETTING() mask. Add SPEED_10000 case to where the speed bits
are set to cover this. No need to add it to where the EEE bits are set as
the "MT7988A Wi-Fi 7 Generation Router Platform: Datasheet (Open Version)
v0.1" document shows that these bits don't exist on the MT7530_PMCR_P(6)
register.

Remove the definition of PMCR_CPU_PORT_SETTING() now that it holds no
purpose.

Change mt753x_cpu_port_enable() to void now that there're no error cases
left.

Link: https://lore.kernel.org/netdev/ZHy2jQLesdYFMQtO@shell.armlinux.org.uk/ [1]
Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 114 +++--------------------------------------------
 drivers/net/dsa/mt7530.h |  11 -----
 2 files changed, 7 insertions(+), 118 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index c069bf273733..80b65f064310 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -966,18 +966,10 @@ mt753x_trap_frames(struct mt7530_priv *priv)
 		   MT753X_R0E_PORT_FW(MT753X_BPDU_CPU_ONLY));
 }
 
-static int
+static void
 mt753x_cpu_port_enable(struct dsa_switch *ds, int port)
 {
 	struct mt7530_priv *priv = ds->priv;
-	int ret;
-
-	/* Setup max capability of CPU port at first */
-	if (priv->info->cpu_port_config) {
-		ret = priv->info->cpu_port_config(ds, port);
-		if (ret)
-			return ret;
-	}
 
 	/* Enable Mediatek header mode on the cpu port */
 	mt7530_write(priv, MT7530_PVC_P(port),
@@ -1003,8 +995,6 @@ mt753x_cpu_port_enable(struct dsa_switch *ds, int port)
 	/* Set to fallback mode for independent VLAN learning */
 	mt7530_rmw(priv, MT7530_PCR_P(port), PCR_PORT_VLAN_MASK,
 		   MT7530_PORT_FALLBACK_MODE);
-
-	return 0;
 }
 
 static int
@@ -2261,8 +2251,6 @@ mt7530_setup(struct dsa_switch *ds)
 	val |= MHWTRAP_MANUAL;
 	mt7530_write(priv, MT7530_MHWTRAP, val);
 
-	priv->p6_interface = PHY_INTERFACE_MODE_NA;
-
 	mt753x_trap_frames(priv);
 
 	/* Enable and reset MIB counters */
@@ -2277,9 +2265,7 @@ mt7530_setup(struct dsa_switch *ds)
 		mt7530_set(priv, MT7530_PSC_P(i), SA_DIS);
 
 		if (dsa_is_cpu_port(ds, i)) {
-			ret = mt753x_cpu_port_enable(ds, i);
-			if (ret)
-				return ret;
+			mt753x_cpu_port_enable(ds, i);
 		} else {
 			mt7530_port_disable(ds, i);
 
@@ -2383,9 +2369,7 @@ mt7531_setup_common(struct dsa_switch *ds)
 		mt7530_set(priv, MT7531_DBG_CNT(i), MT7531_DIS_CLR);
 
 		if (dsa_is_cpu_port(ds, i)) {
-			ret = mt753x_cpu_port_enable(ds, i);
-			if (ret)
-				return ret;
+			mt753x_cpu_port_enable(ds, i);
 		} else {
 			mt7530_port_disable(ds, i);
 
@@ -2474,10 +2458,6 @@ mt7531_setup(struct dsa_switch *ds)
 	mt7530_rmw(priv, MT7531_GPIO_MODE0, MT7531_GPIO0_MASK,
 		   MT7531_GPIO0_INTERRUPT);
 
-	/* Let phylink decide the interface later. */
-	priv->p5_interface = PHY_INTERFACE_MODE_NA;
-	priv->p6_interface = PHY_INTERFACE_MODE_NA;
-
 	/* Enable PHY core PLL, since phy_device has not yet been created
 	 * provided for phy_[read,write]_mmd_indirect is called, we provide
 	 * our own mt7531_ind_mmd_phy_[read,write] to complete this
@@ -2689,26 +2669,9 @@ mt753x_phylink_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 	struct mt7530_priv *priv = ds->priv;
 	u32 mcr_cur, mcr_new;
 
-	switch (port) {
-	case 5:
-		if (priv->p5_interface == state->interface)
-			break;
-
+	if (port == 5 || port == 6)
 		mt753x_mac_config(ds, port, mode, state);
 
-		if (priv->p5_intf_sel != P5_DISABLED)
-			priv->p5_interface = state->interface;
-		break;
-	case 6:
-		if (priv->p6_interface == state->interface)
-			break;
-
-		mt753x_mac_config(ds, port, mode, state);
-
-		priv->p6_interface = state->interface;
-		break;
-	}
-
 	mcr_cur = mt7530_read(priv, MT7530_PMCR_P(port));
 	mcr_new = mcr_cur;
 	mcr_new &= ~PMCR_LINK_SETTINGS_MASK;
@@ -2744,17 +2707,10 @@ static void mt753x_phylink_mac_link_up(struct dsa_switch *ds, int port,
 
 	mcr = PMCR_RX_EN | PMCR_TX_EN | PMCR_FORCE_LNK;
 
-	/* MT753x MAC works in 1G full duplex mode for all up-clocked
-	 * variants.
-	 */
-	if (interface == PHY_INTERFACE_MODE_TRGMII ||
-	    (phy_interface_mode_is_8023z(interface))) {
-		speed = SPEED_1000;
-		duplex = DUPLEX_FULL;
-	}
-
 	switch (speed) {
 	case SPEED_1000:
+	case SPEED_2500:
+	case SPEED_10000:
 		mcr |= PMCR_FORCE_SPEED_1000;
 		break;
 	case SPEED_100:
@@ -2772,6 +2728,7 @@ static void mt753x_phylink_mac_link_up(struct dsa_switch *ds, int port,
 	if (mode == MLO_AN_PHY && phydev && phy_init_eee(phydev, false) >= 0) {
 		switch (speed) {
 		case SPEED_1000:
+		case SPEED_2500:
 			mcr |= PMCR_FORCE_EEE1G;
 			break;
 		case SPEED_100:
@@ -2783,61 +2740,6 @@ static void mt753x_phylink_mac_link_up(struct dsa_switch *ds, int port,
 	mt7530_set(priv, MT7530_PMCR_P(port), mcr);
 }
 
-static int
-mt7531_cpu_port_config(struct dsa_switch *ds, int port)
-{
-	struct mt7530_priv *priv = ds->priv;
-	phy_interface_t interface;
-	int speed;
-
-	switch (port) {
-	case 5:
-		if (!priv->p5_sgmii)
-			interface = PHY_INTERFACE_MODE_RGMII;
-		else
-			interface = PHY_INTERFACE_MODE_2500BASEX;
-
-		priv->p5_interface = interface;
-		break;
-	case 6:
-		interface = PHY_INTERFACE_MODE_2500BASEX;
-
-		priv->p6_interface = interface;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	if (interface == PHY_INTERFACE_MODE_2500BASEX)
-		speed = SPEED_2500;
-	else
-		speed = SPEED_1000;
-
-	mt7531_mac_config(ds, port, MLO_AN_FIXED, interface);
-
-	mt7530_write(priv, MT7530_PMCR_P(port),
-		     PMCR_CPU_PORT_SETTING(priv->id));
-	mt753x_phylink_mac_link_up(ds, port, MLO_AN_FIXED, interface, NULL,
-				   speed, DUPLEX_FULL, true, true);
-
-	return 0;
-}
-
-static int
-mt7988_cpu_port_config(struct dsa_switch *ds, int port)
-{
-	struct mt7530_priv *priv = ds->priv;
-
-	mt7530_write(priv, MT7530_PMCR_P(port),
-		     PMCR_CPU_PORT_SETTING(priv->id));
-
-	mt753x_phylink_mac_link_up(ds, port, MLO_AN_FIXED,
-				   PHY_INTERFACE_MODE_INTERNAL, NULL,
-				   SPEED_10000, DUPLEX_FULL, true, true);
-
-	return 0;
-}
-
 static void mt753x_phylink_get_caps(struct dsa_switch *ds, int port,
 				    struct phylink_config *config)
 {
@@ -3096,7 +2998,6 @@ const struct mt753x_info mt753x_table[] = {
 		.phy_write_c22 = mt7531_ind_c22_phy_write,
 		.phy_read_c45 = mt7531_ind_c45_phy_read,
 		.phy_write_c45 = mt7531_ind_c45_phy_write,
-		.cpu_port_config = mt7531_cpu_port_config,
 		.mac_port_get_caps = mt7531_mac_port_get_caps,
 		.mac_port_config = mt7531_mac_config,
 	},
@@ -3108,7 +3009,6 @@ const struct mt753x_info mt753x_table[] = {
 		.phy_write_c22 = mt7531_ind_c22_phy_write,
 		.phy_read_c45 = mt7531_ind_c45_phy_read,
 		.phy_write_c45 = mt7531_ind_c45_phy_write,
-		.cpu_port_config = mt7988_cpu_port_config,
 		.mac_port_get_caps = mt7988_mac_port_get_caps,
 	},
 };
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index b1665de7f640..8a8144868eaa 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -311,13 +311,6 @@ enum mt7530_vlan_port_acc_frm {
 					 PMCR_TX_FC_EN | PMCR_RX_FC_EN | \
 					 PMCR_FORCE_FDX | PMCR_FORCE_LNK | \
 					 PMCR_FORCE_EEE1G | PMCR_FORCE_EEE100)
-#define  PMCR_CPU_PORT_SETTING(id)	(PMCR_FORCE_MODE_ID((id)) | \
-					 PMCR_IFG_XMIT(1) | PMCR_MAC_MODE | \
-					 PMCR_BACKOFF_EN | PMCR_BACKPR_EN | \
-					 PMCR_TX_EN | PMCR_RX_EN | \
-					 PMCR_TX_FC_EN | PMCR_RX_FC_EN | \
-					 PMCR_FORCE_SPEED_1000 | \
-					 PMCR_FORCE_FDX | PMCR_FORCE_LNK)
 
 #define MT7530_PMEEECR_P(x)		(0x3004 + (x) * 0x100)
 #define  WAKEUP_TIME_1000(x)		(((x) & 0xFF) << 24)
@@ -724,7 +717,6 @@ struct mt753x_info {
 			    int regnum);
 	int (*phy_write_c45)(struct mt7530_priv *priv, int port, int devad,
 			     int regnum, u16 val);
-	int (*cpu_port_config)(struct dsa_switch *ds, int port);
 	void (*mac_port_get_caps)(struct dsa_switch *ds, int port,
 				  struct phylink_config *config);
 	void (*mac_port_validate)(struct dsa_switch *ds, int port,
@@ -750,7 +742,6 @@ struct mt753x_info {
  * @ports:		Holding the state among ports
  * @reg_mutex:		The lock for protecting among process accessing
  *			registers
- * @p6_interface	Holding the current port 6 interface
  * @p5_intf_sel:	Holding the current port 5 interface select
  * @p5_sgmii:		Flag for distinguishing if port 5 of the MT7531 switch
  *			has got SGMII
@@ -772,8 +763,6 @@ struct mt7530_priv {
 	const struct mt753x_info *info;
 	unsigned int		id;
 	bool			mcm;
-	phy_interface_t		p6_interface;
-	phy_interface_t		p5_interface;
 	enum p5_interface_select p5_intf_sel;
 	bool			p5_sgmii;
 	u8			mirror_rx;

-- 
2.40.1


