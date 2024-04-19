Return-Path: <linux-kernel+bounces-151293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD538AAC85
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB1F1C21336
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EC780619;
	Fri, 19 Apr 2024 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jo7XJ5an"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD0D7EF1C;
	Fri, 19 Apr 2024 10:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713521378; cv=none; b=WohozNMrWDaVVDhQ2g+1gWNYzAlS7iHOPLvyE1lWfe/QSi2u6Qj8rLkv+V+ghUowX2ooAa+QAx+dMQOWE+WkCajEyEGcEvHM2NMB1cCAdjt/HqYhkwiUL7eNRchJ5XYg/lm+XJTLlJHcPrMHTmbPA9WBd9cbM5oA3LHzGvbLTUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713521378; c=relaxed/simple;
	bh=JpDxd3crHAkNzCfUszuShdFULlH95GB99lMPCw4DDgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gkUXKEufJ9lJXeQlztfNJ8uFT4AKBxbRSkjWpXf9132k8b4ZiEidNJH16JBv5FNfv8oQ2gdW8+Vk94AEoiBRd6VvXkighIS+o95iVtxLytpQyUQlkXDwZCu19rkpF69yoECdaWi3rj6zJBV8SPA9N1VHcC9HmCfyJSUy1+NB+kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jo7XJ5an; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C32CAC4AF0C;
	Fri, 19 Apr 2024 10:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713521377;
	bh=JpDxd3crHAkNzCfUszuShdFULlH95GB99lMPCw4DDgU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jo7XJ5an8aOX8NagmuX4qELvGd62v2I1gDbNdRfp0g/qozQ2Y7IxEKQCM1DrU/TIY
	 Pdbzu6SyTBCLFgoh3N9rDoCPt0PUkGxDis4K33GAGNB1XAblwh16tEk3uRo30SqI9P
	 KOoqkbEey6p7lJrIV2+gQrJUMY27j6Ev+6g0OkUtJjtAwaQSiYHFj3dLsbyIY1EZWl
	 NDxjomXG9XsIjtoWQELZjK0f+72NoNkC4PPeke6FOFCxTYOvrHTAVvwxzCy6UCWxvP
	 XSbL2+sEbH/f3RBRcLHjLyjExMMbuJxJpiTF0srD48eQW2EumhW85GexROsa3INaBK
	 pc+aEd867fH0A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E11C4345F;
	Fri, 19 Apr 2024 10:09:37 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Fri, 19 Apr 2024 13:09:29 +0300
Subject: [PATCH net-next 06/13] net: dsa: mt7530: refactor MT7530_HWTRAP
 and MT7530_MHWTRAP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240419-for-netnext-mt7530-improvements-4-v1-6-6d852ca79b1d@arinc9.com>
References: <20240419-for-netnext-mt7530-improvements-4-v1-0-6d852ca79b1d@arinc9.com>
In-Reply-To: <20240419-for-netnext-mt7530-improvements-4-v1-0-6d852ca79b1d@arinc9.com>
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Bartel Eerdekens <bartel.eerdekens@constell8.be>, 
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713521374; l=8925;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=FPSpZup53zPjkFOg+U7o3cVfgrTHkOJAlg6L4h+GBKE=;
 b=/qvEUgd/Az5aE10sYrs2r1Hv8RGgz5XYfqKmVhmwDGAFxr4yZWlixSggX5oigm0IrPpxjx/Jb
 5qYAqhutwgKAwH8/I9HcpQWGQG4BBFP6zEOk9PIBBBbC6AR1J5RzQh/
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

The MT7530_HWTRAP and MT7530_MHWTRAP registers are on MT7530 and MT7531.
It's called hardware trap on MT7530, software trap on MT7531. That's
because some bits of the trap on MT7530 cannot be modified by software
whilst all bits of the trap on MT7531 can. Rename the definitions for them
to MT753X_TRAP and MT753X_MTRAP. Add MT7530 and MT7531 prefixes to the
definitions specific to the switch model.

Remove the extra parentheses from MT7530_XTAL_40MHZ and MT7530_XTAL_20MHZ.

Rename MHWTRAP_PHY0_SEL, MHWTRAP_MANUAL, and MHWTRAP_PHY_ACCESS to be on
par with the "MT7621 Giga Switch Programming Guide v0.3" document.

Make an enumaration for the XTAL frequency. Set the data type of the xtal
variable on mt7531_pll_setup() to it.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 59 ++++++++++++++++++++++++------------------------
 drivers/net/dsa/mt7530.h | 50 ++++++++++++++++++++--------------------
 2 files changed, 54 insertions(+), 55 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 39c47499036b..606516206fb9 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -417,23 +417,23 @@ mt7530_setup_port6(struct dsa_switch *ds, phy_interface_t interface)
 
 	mt7530_rmw(priv, MT7530_P6ECR, P6_INTF_MODE_MASK, P6_INTF_MODE(1));
 
-	xtal = mt7530_read(priv, MT7530_MHWTRAP) & HWTRAP_XTAL_MASK;
+	xtal = mt7530_read(priv, MT753X_MTRAP) & MT7530_XTAL_MASK;
 
-	if (xtal == HWTRAP_XTAL_25MHZ)
+	if (xtal == MT7530_XTAL_25MHZ)
 		ssc_delta = 0x57;
 	else
 		ssc_delta = 0x87;
 
 	if (priv->id == ID_MT7621) {
 		/* PLL frequency: 125MHz: 1.0GBit */
-		if (xtal == HWTRAP_XTAL_40MHZ)
+		if (xtal == MT7530_XTAL_40MHZ)
 			ncpo1 = 0x0640;
-		if (xtal == HWTRAP_XTAL_25MHZ)
+		if (xtal == MT7530_XTAL_25MHZ)
 			ncpo1 = 0x0a00;
 	} else { /* PLL frequency: 250MHz: 2.0Gbit */
-		if (xtal == HWTRAP_XTAL_40MHZ)
+		if (xtal == MT7530_XTAL_40MHZ)
 			ncpo1 = 0x0c80;
-		if (xtal == HWTRAP_XTAL_25MHZ)
+		if (xtal == MT7530_XTAL_25MHZ)
 			ncpo1 = 0x1400;
 	}
 
@@ -456,19 +456,20 @@ mt7530_setup_port6(struct dsa_switch *ds, phy_interface_t interface)
 static void
 mt7531_pll_setup(struct mt7530_priv *priv)
 {
+	enum mt7531_xtal_fsel xtal;
 	u32 top_sig;
 	u32 hwstrap;
-	u32 xtal;
 	u32 val;
 
 	val = mt7530_read(priv, MT7531_CREV);
 	top_sig = mt7530_read(priv, MT7531_TOP_SIG_SR);
-	hwstrap = mt7530_read(priv, MT7531_HWTRAP);
+	hwstrap = mt7530_read(priv, MT753X_TRAP);
 	if ((val & CHIP_REV_M) > 0)
-		xtal = (top_sig & PAD_MCM_SMI_EN) ? HWTRAP_XTAL_FSEL_40MHZ :
-						    HWTRAP_XTAL_FSEL_25MHZ;
+		xtal = (top_sig & PAD_MCM_SMI_EN) ? MT7531_XTAL_FSEL_40MHZ :
+						    MT7531_XTAL_FSEL_25MHZ;
 	else
-		xtal = hwstrap & HWTRAP_XTAL_FSEL_MASK;
+		xtal = (hwstrap & MT7531_XTAL25) ? MT7531_XTAL_FSEL_25MHZ :
+						   MT7531_XTAL_FSEL_40MHZ;
 
 	/* Step 1 : Disable MT7531 COREPLL */
 	val = mt7530_read(priv, MT7531_PLLGP_EN);
@@ -497,13 +498,13 @@ mt7531_pll_setup(struct mt7530_priv *priv)
 	usleep_range(25, 35);
 
 	switch (xtal) {
-	case HWTRAP_XTAL_FSEL_25MHZ:
+	case MT7531_XTAL_FSEL_25MHZ:
 		val = mt7530_read(priv, MT7531_PLLGP_CR0);
 		val &= ~RG_COREPLL_SDM_PCW_M;
 		val |= 0x140000 << RG_COREPLL_SDM_PCW_S;
 		mt7530_write(priv, MT7531_PLLGP_CR0, val);
 		break;
-	case HWTRAP_XTAL_FSEL_40MHZ:
+	case MT7531_XTAL_FSEL_40MHZ:
 		val = mt7530_read(priv, MT7531_PLLGP_CR0);
 		val &= ~RG_COREPLL_SDM_PCW_M;
 		val |= 0x190000 << RG_COREPLL_SDM_PCW_S;
@@ -877,20 +878,20 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
 
 	mutex_lock(&priv->reg_mutex);
 
-	val = mt7530_read(priv, MT7530_MHWTRAP);
+	val = mt7530_read(priv, MT753X_MTRAP);
 
-	val |= MHWTRAP_MANUAL | MHWTRAP_P5_MAC_SEL | MHWTRAP_P5_DIS;
-	val &= ~MHWTRAP_P5_RGMII_MODE & ~MHWTRAP_PHY0_SEL;
+	val |= MT7530_CHG_TRAP | MT7530_P5_MAC_SEL | MT7530_P5_DIS;
+	val &= ~MT7530_P5_RGMII_MODE & ~MT7530_P5_PHY0_SEL;
 
 	switch (priv->p5_mode) {
 	/* MUX_PHY_P0: P0 -> P5 -> SoC MAC */
 	case MUX_PHY_P0:
-		val |= MHWTRAP_PHY0_SEL;
+		val |= MT7530_P5_PHY0_SEL;
 		fallthrough;
 
 	/* MUX_PHY_P4: P4 -> P5 -> SoC MAC */
 	case MUX_PHY_P4:
-		val &= ~MHWTRAP_P5_MAC_SEL & ~MHWTRAP_P5_DIS;
+		val &= ~MT7530_P5_MAC_SEL & ~MT7530_P5_DIS;
 
 		/* Setup the MAC by default for the cpu port */
 		mt7530_write(priv, MT753X_PMCR_P(5), 0x56300);
@@ -898,13 +899,13 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
 
 	/* GMAC5: P5 -> SoC MAC or external PHY */
 	default:
-		val &= ~MHWTRAP_P5_DIS;
+		val &= ~MT7530_P5_DIS;
 		break;
 	}
 
 	/* Setup RGMII settings */
 	if (phy_interface_mode_is_rgmii(interface)) {
-		val |= MHWTRAP_P5_RGMII_MODE;
+		val |= MT7530_P5_RGMII_MODE;
 
 		/* P5 RGMII RX Clock Control: delay setting for 1000M */
 		mt7530_write(priv, MT7530_P5RGMIIRXCR, CSR_RGMII_EDGE_ALIGN);
@@ -924,7 +925,7 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
 			     P5_IO_CLK_DRV(1) | P5_IO_DATA_DRV(1));
 	}
 
-	mt7530_write(priv, MT7530_MHWTRAP, val);
+	mt7530_write(priv, MT753X_MTRAP, val);
 
 	dev_dbg(ds->dev, "Setup P5, HWTRAP=0x%x, mode=%s, phy-mode=%s\n", val,
 		mt7530_p5_mode_str(priv->p5_mode), phy_modes(interface));
@@ -2365,7 +2366,7 @@ mt7530_setup(struct dsa_switch *ds)
 	}
 
 	/* Waiting for MT7530 got to stable */
-	INIT_MT7530_DUMMY_POLL(&p, priv, MT7530_HWTRAP);
+	INIT_MT7530_DUMMY_POLL(&p, priv, MT753X_TRAP);
 	ret = readx_poll_timeout(_mt7530_read, &p, val, val != 0,
 				 20, 1000000);
 	if (ret < 0) {
@@ -2380,7 +2381,7 @@ mt7530_setup(struct dsa_switch *ds)
 		return -ENODEV;
 	}
 
-	if ((val & HWTRAP_XTAL_MASK) == HWTRAP_XTAL_20MHZ) {
+	if ((val & MT7530_XTAL_MASK) == MT7530_XTAL_20MHZ) {
 		dev_err(priv->dev,
 			"MT7530 with a 20MHz XTAL is not supported!\n");
 		return -EINVAL;
@@ -2401,12 +2402,12 @@ mt7530_setup(struct dsa_switch *ds)
 			   RD_TAP_MASK, RD_TAP(16));
 
 	/* Enable port 6 */
-	val = mt7530_read(priv, MT7530_MHWTRAP);
-	val &= ~MHWTRAP_P6_DIS & ~MHWTRAP_PHY_ACCESS;
-	val |= MHWTRAP_MANUAL;
-	mt7530_write(priv, MT7530_MHWTRAP, val);
+	val = mt7530_read(priv, MT753X_MTRAP);
+	val &= ~MT7530_P6_DIS & ~MT7530_PHY_INDIRECT_ACCESS;
+	val |= MT7530_CHG_TRAP;
+	mt7530_write(priv, MT753X_MTRAP, val);
 
-	if ((val & HWTRAP_XTAL_MASK) == HWTRAP_XTAL_40MHZ)
+	if ((val & MT7530_XTAL_MASK) == MT7530_XTAL_40MHZ)
 		mt7530_pll_setup(priv);
 
 	mt753x_trap_frames(priv);
@@ -2586,7 +2587,7 @@ mt7531_setup(struct dsa_switch *ds)
 	}
 
 	/* Waiting for MT7530 got to stable */
-	INIT_MT7530_DUMMY_POLL(&p, priv, MT7530_HWTRAP);
+	INIT_MT7530_DUMMY_POLL(&p, priv, MT753X_TRAP);
 	ret = readx_poll_timeout(_mt7530_read, &p, val, val != 0,
 				 20, 1000000);
 	if (ret < 0) {
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index c6ef20b7bbdd..1f3aeccc77be 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -495,32 +495,30 @@ enum mt7531_clk_skew {
 	MT7531_CLK_SKEW_REVERSE = 3,
 };
 
-/* Register for hw trap status */
-#define MT7530_HWTRAP			0x7800
-#define  HWTRAP_XTAL_MASK		(BIT(10) | BIT(9))
-#define  HWTRAP_XTAL_25MHZ		(BIT(10) | BIT(9))
-#define  HWTRAP_XTAL_40MHZ		(BIT(10))
-#define  HWTRAP_XTAL_20MHZ		(BIT(9))
-
-#define MT7531_HWTRAP			0x7800
-#define  HWTRAP_XTAL_FSEL_MASK		BIT(7)
-#define  HWTRAP_XTAL_FSEL_25MHZ		BIT(7)
-#define  HWTRAP_XTAL_FSEL_40MHZ		0
-/* Unique fields of (M)HWSTRAP for MT7531 */
-#define  XTAL_FSEL_S			7
-#define  XTAL_FSEL_M			BIT(7)
-#define  PHY_EN				BIT(6)
-#define  CHG_STRAP			BIT(8)
-
-/* Register for hw trap modification */
-#define MT7530_MHWTRAP			0x7804
-#define  MHWTRAP_PHY0_SEL		BIT(20)
-#define  MHWTRAP_MANUAL			BIT(16)
-#define  MHWTRAP_P5_MAC_SEL		BIT(13)
-#define  MHWTRAP_P6_DIS			BIT(8)
-#define  MHWTRAP_P5_RGMII_MODE		BIT(7)
-#define  MHWTRAP_P5_DIS			BIT(6)
-#define  MHWTRAP_PHY_ACCESS		BIT(5)
+/* Register for trap status */
+#define MT753X_TRAP			0x7800
+#define  MT7530_XTAL_MASK		(BIT(10) | BIT(9))
+#define  MT7530_XTAL_25MHZ		(BIT(10) | BIT(9))
+#define  MT7530_XTAL_40MHZ		BIT(10)
+#define  MT7530_XTAL_20MHZ		BIT(9)
+#define  MT7531_XTAL25			BIT(7)
+
+/* Register for trap modification */
+#define MT753X_MTRAP			0x7804
+#define  MT7530_P5_PHY0_SEL		BIT(20)
+#define  MT7530_CHG_TRAP		BIT(16)
+#define  MT7530_P5_MAC_SEL		BIT(13)
+#define  MT7530_P6_DIS			BIT(8)
+#define  MT7530_P5_RGMII_MODE		BIT(7)
+#define  MT7530_P5_DIS			BIT(6)
+#define  MT7530_PHY_INDIRECT_ACCESS	BIT(5)
+#define  MT7531_CHG_STRAP		BIT(8)
+#define  MT7531_PHY_EN			BIT(6)
+
+enum mt7531_xtal_fsel {
+	MT7531_XTAL_FSEL_25MHZ,
+	MT7531_XTAL_FSEL_40MHZ,
+};
 
 /* Register for TOP signal control */
 #define MT7530_TOP_SIG_CTRL		0x7808

-- 
2.40.1



