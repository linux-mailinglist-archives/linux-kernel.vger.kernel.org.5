Return-Path: <linux-kernel+bounces-152847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6261A8AC540
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8381F20EAD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B679D55E6A;
	Mon, 22 Apr 2024 07:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F77wUubv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260D34CE0F;
	Mon, 22 Apr 2024 07:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770131; cv=none; b=A7N/GTRMpOHraYEr78C4XIrYlTA5AuVfTpHtb8ZEDPep0z+FUlBMgOkssbePqm6fLrtdDvyZNgc68gVexs/b3Rq+72Kd9lDUVXRAIkX4obPiOmhJ7yoCkgVqJuB7W0jLqUTiMZ8bB7dJwkuHyoiQsDe7qJ9QVrwNt6yfZJSCw6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770131; c=relaxed/simple;
	bh=JpDxd3crHAkNzCfUszuShdFULlH95GB99lMPCw4DDgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RIq5/sdkTC35anmlrogjSzvcCqHH2ZE+X9sC3UeRsvFe8uRwfd8tfz/RPg2s8gYJNE9S18RyvQkJfNI4OPd7eFe6Fu17Cbk/FiWqoJ98e/X7LM6nygsu9t7D3NRLOEtecjMyyH/Qe1XxQwKP9Hee45dymVsGs60whkj8MKDIeqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F77wUubv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB927C32782;
	Mon, 22 Apr 2024 07:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713770130;
	bh=JpDxd3crHAkNzCfUszuShdFULlH95GB99lMPCw4DDgU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=F77wUubvAgkNsDdqUA5ECr8+UVhMamvLS6ggLl4CuP+ZR50bvFs8Tw/Spn8RQidh1
	 jIJbt1OcrbbtH7+1kr6zDYSAjul5Gx+iYc6RrofenhMqtaaf0Q5O3WnTmZECLrY4qV
	 35PPU2uDM3rWw74QNxw4qp659hnQzykGEDchGz+o2loynYuCtDMAtV9T7eBLzSwv0p
	 WQz2I3Zz7RP8bMb3+wMFe+8p5J3Js17J1WR0VsGNb0LlGdwuLmi2PnOc4LKEZLPQcY
	 3UFMXfM1+lb0+1z5Eesq2+KwvLx4DntX8tdoR4PMP+x4v6wXgD9IP9PcTxQmFGMOHE
	 dXkSZBidgzksg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2550C07E8F;
	Mon, 22 Apr 2024 07:15:30 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Mon, 22 Apr 2024 10:15:13 +0300
Subject: [PATCH net-next v2 06/15] net: dsa: mt7530: refactor MT7530_HWTRAP
 and MT7530_MHWTRAP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240422-for-netnext-mt7530-improvements-4-v2-6-a75157ba76ad@arinc9.com>
References: <20240422-for-netnext-mt7530-improvements-4-v2-0-a75157ba76ad@arinc9.com>
In-Reply-To: <20240422-for-netnext-mt7530-improvements-4-v2-0-a75157ba76ad@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713770127; l=8925;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=FPSpZup53zPjkFOg+U7o3cVfgrTHkOJAlg6L4h+GBKE=;
 b=1LGQ8Y9tUvLWUDo3ctq3Iw85XokynDBebbR2YMxDQ1xMAiama1PC3E4KXT8Wt/EEhtOiEKdDa
 2Qf+sDSFUj5Bz6jn3ITHyoQFHmVR5MOOOn4Pwg4DC2NhR2TEiddN/DI
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



