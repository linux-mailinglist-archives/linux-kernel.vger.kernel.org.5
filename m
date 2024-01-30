Return-Path: <linux-kernel+bounces-44828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7508427EF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137CC1F21C05
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5496312AAE1;
	Tue, 30 Jan 2024 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlwQttUm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29816823B2;
	Tue, 30 Jan 2024 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706628057; cv=none; b=YuLg/xqzHYXzszHny53orkFc44lsyb7MgSGA5CmpRNfrfbdL4dIjlsjat/cP9Pz5GWVMGa8RHr8D4UhaWQQdhB35uO9BS3M85b/g4Kr9XMuXx+0IU2RMkykOQPQiheAnfblyGn7LvMa6sTzNRjLFfkphMycFCg1iDA6UM8Mzz0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706628057; c=relaxed/simple;
	bh=+lJa57P19Tq2sGpIYqkCxLj9WTIbGgFWWKjycsir2/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UNdCVX5Xp2buD+1+pppO/B6ZCVImz6IY42VVSMWTWi9CLIsloJ+zINk9474SKF1GvTsDMFhO+IjAQWykJDi5mInNzdsM4Ttppl6vyEHMvKizXGQOT4rakqJ2TbzKoLhFxUxTqc67Fj4RX0BW8GHfXL6Zwbi/OZUS/DMb0THQhOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlwQttUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB732C32783;
	Tue, 30 Jan 2024 15:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706628056;
	bh=+lJa57P19Tq2sGpIYqkCxLj9WTIbGgFWWKjycsir2/w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jlwQttUmaFuqTRBFNcl1ZyyPZcHLx44hIDt1aLVuOsH81+upVNxLtCrOOkNvH6FXS
	 L9QJoC2Xkys01H5OpMEf9idmH1GXDpJaVQ/QMDVinmw0PAwRFGJTM7r4mxyuZpva2r
	 ltE1ULf11Ox53BRsNVBl58bnUnL1HC9X5RXKfXXFTi9K9HPUwpRrcJtEN6pE3eJ6ny
	 3BTvx+G0tkXpgJJ9RsK+6fnv8Jy8rvIYRzKSNxkUSPig8wmQh5qN4JIst1/D1g0uo9
	 DL7YznDdA3cuO7jLI8W4Z/WmCujOQjf05T+FKFUZ7YW/LTmPSE150X60MW83dEpQbD
	 5O36cyFTHfoHg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1A9C46CD2;
	Tue, 30 Jan 2024 15:20:56 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Tue, 30 Jan 2024 18:20:51 +0300
Subject: [PATCH net-next v2 5/7] net: dsa: mt7530: simplify
 mt7530_setup_port6() and change to void
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id:
 <20240130-for-netnext-mt7530-improvements-2-v2-5-ba06f5dd9eb0@arinc9.com>
References:
 <20240130-for-netnext-mt7530-improvements-2-v2-0-ba06f5dd9eb0@arinc9.com>
In-Reply-To:
 <20240130-for-netnext-mt7530-improvements-2-v2-0-ba06f5dd9eb0@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706628055; l=5539;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=SoDdRySeB2VjNzEzmEpX6Ha3WH6UgllbLr7DNQh8kXA=;
 b=f7Hlk9ksPK2bYo8i2hs574JPrUjqxCCTbkdmuLbx4rvEFixJcsrcC1hOZeiahW/zAZM/+oFWD
 QCTHbk7ptDLB8nRYy91zKM2A7PHL9T27uE2gB3ibCLb6FfOWRTXc00w
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

From: Arınç ÜNAL <arinc.unal@arinc9.com>

This code is from before this driver was converted to phylink API. Phylink
deals with the unsupported interface cases before mt7530_setup_port6() is
run. Therefore, the default case would never run. However, it must be
defined nonetheless to handle all the remaining enumeration values, the
phy-modes.

Switch to if statement for RGMII and return which simplifies the code and
saves an indent.

Set P6_INTF_MODE, which is the the three least significant bits of the
MT7530_P6ECR register, to 0 for RGMII even though it will already be 0
after reset. This is to keep supporting dynamic reconfiguration of the port
in the case the interface changes from TRGMII to RGMII. The core operations
for TRGMII does not interfere with RGMII so no need to undo them.

Read XTAL after checking for RGMII as it's only needed for the TRGMII
interface mode.

Change mt7530_setup_port6() to void now that there're no error cases left.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 103 ++++++++++++++++++++---------------------------
 1 file changed, 43 insertions(+), 60 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index c4d492e29fdf..36dc2bbcf3b6 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -414,70 +414,57 @@ mt753x_preferred_default_local_cpu_port(struct dsa_switch *ds)
 }
 
 /* Setup port 6 interface mode and TRGMII TX circuit */
-static int
+static void
 mt7530_setup_port6(struct dsa_switch *ds, phy_interface_t interface)
 {
 	struct mt7530_priv *priv = ds->priv;
-	u32 ncpo1, ssc_delta, trgint, xtal;
-
-	xtal = mt7530_read(priv, MT7530_MHWTRAP) & HWTRAP_XTAL_MASK;
+	u32 ncpo1, ssc_delta, xtal;
 
-	switch (interface) {
-	case PHY_INTERFACE_MODE_RGMII:
-		trgint = 0;
-		break;
-	case PHY_INTERFACE_MODE_TRGMII:
-		trgint = 1;
-		if (xtal == HWTRAP_XTAL_25MHZ)
-			ssc_delta = 0x57;
-		else
-			ssc_delta = 0x87;
-		if (priv->id == ID_MT7621) {
-			/* PLL frequency: 125MHz: 1.0GBit */
-			if (xtal == HWTRAP_XTAL_40MHZ)
-				ncpo1 = 0x0640;
-			if (xtal == HWTRAP_XTAL_25MHZ)
-				ncpo1 = 0x0a00;
-		} else { /* PLL frequency: 250MHz: 2.0Gbit */
-			if (xtal == HWTRAP_XTAL_40MHZ)
-				ncpo1 = 0x0c80;
-			if (xtal == HWTRAP_XTAL_25MHZ)
-				ncpo1 = 0x1400;
-		}
-		break;
-	default:
-		dev_err(priv->dev, "xMII interface %d not supported\n",
-			interface);
-		return -EINVAL;
+	if (interface == PHY_INTERFACE_MODE_RGMII) {
+		mt7530_rmw(priv, MT7530_P6ECR, P6_INTF_MODE_MASK,
+			   P6_INTF_MODE(0));
+		return;
 	}
 
-	mt7530_rmw(priv, MT7530_P6ECR, P6_INTF_MODE_MASK,
-		   P6_INTF_MODE(trgint));
+	mt7530_rmw(priv, MT7530_P6ECR, P6_INTF_MODE_MASK, P6_INTF_MODE(1));
 
-	if (trgint) {
-		/* Disable the MT7530 TRGMII clocks */
-		core_clear(priv, CORE_TRGMII_GSW_CLK_CG, REG_TRGMIICK_EN);
+	xtal = mt7530_read(priv, MT7530_MHWTRAP) & HWTRAP_XTAL_MASK;
 
-		/* Setup the MT7530 TRGMII Tx Clock */
-		core_write(priv, CORE_PLL_GROUP5, RG_LCDDS_PCW_NCPO1(ncpo1));
-		core_write(priv, CORE_PLL_GROUP6, RG_LCDDS_PCW_NCPO0(0));
-		core_write(priv, CORE_PLL_GROUP10, RG_LCDDS_SSC_DELTA(ssc_delta));
-		core_write(priv, CORE_PLL_GROUP11, RG_LCDDS_SSC_DELTA1(ssc_delta));
-		core_write(priv, CORE_PLL_GROUP4,
-			   RG_SYSPLL_DDSFBK_EN | RG_SYSPLL_BIAS_EN |
-			   RG_SYSPLL_BIAS_LPF_EN);
-		core_write(priv, CORE_PLL_GROUP2,
-			   RG_SYSPLL_EN_NORMAL | RG_SYSPLL_VODEN |
-			   RG_SYSPLL_POSDIV(1));
-		core_write(priv, CORE_PLL_GROUP7,
-			   RG_LCDDS_PCW_NCPO_CHG | RG_LCCDS_C(3) |
-			   RG_LCDDS_PWDB | RG_LCDDS_ISO_EN);
+	if (xtal == HWTRAP_XTAL_25MHZ)
+		ssc_delta = 0x57;
+	else
+		ssc_delta = 0x87;
 
-		/* Enable the MT7530 TRGMII clocks */
-		core_set(priv, CORE_TRGMII_GSW_CLK_CG, REG_TRGMIICK_EN);
+	if (priv->id == ID_MT7621) {
+		/* PLL frequency: 125MHz: 1.0GBit */
+		if (xtal == HWTRAP_XTAL_40MHZ)
+			ncpo1 = 0x0640;
+		if (xtal == HWTRAP_XTAL_25MHZ)
+			ncpo1 = 0x0a00;
+	} else { /* PLL frequency: 250MHz: 2.0Gbit */
+		if (xtal == HWTRAP_XTAL_40MHZ)
+			ncpo1 = 0x0c80;
+		if (xtal == HWTRAP_XTAL_25MHZ)
+			ncpo1 = 0x1400;
 	}
 
-	return 0;
+	/* Disable the MT7530 TRGMII clocks */
+	core_clear(priv, CORE_TRGMII_GSW_CLK_CG, REG_TRGMIICK_EN);
+
+	/* Setup the MT7530 TRGMII Tx Clock */
+	core_write(priv, CORE_PLL_GROUP5, RG_LCDDS_PCW_NCPO1(ncpo1));
+	core_write(priv, CORE_PLL_GROUP6, RG_LCDDS_PCW_NCPO0(0));
+	core_write(priv, CORE_PLL_GROUP10, RG_LCDDS_SSC_DELTA(ssc_delta));
+	core_write(priv, CORE_PLL_GROUP11, RG_LCDDS_SSC_DELTA1(ssc_delta));
+	core_write(priv, CORE_PLL_GROUP4, RG_SYSPLL_DDSFBK_EN |
+		   RG_SYSPLL_BIAS_EN | RG_SYSPLL_BIAS_LPF_EN);
+	core_write(priv, CORE_PLL_GROUP2, RG_SYSPLL_EN_NORMAL |
+		   RG_SYSPLL_VODEN | RG_SYSPLL_POSDIV(1));
+	core_write(priv, CORE_PLL_GROUP7, RG_LCDDS_PCW_NCPO_CHG |
+		   RG_LCCDS_C(3) | RG_LCDDS_PWDB | RG_LCDDS_ISO_EN);
+
+	/* Enable the MT7530 TRGMII clocks */
+	core_set(priv, CORE_TRGMII_GSW_CLK_CG, REG_TRGMIICK_EN);
 }
 
 static void
@@ -2609,15 +2596,11 @@ mt7530_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 		  phy_interface_t interface)
 {
 	struct mt7530_priv *priv = ds->priv;
-	int ret;
 
-	if (port == 5) {
+	if (port == 5)
 		mt7530_setup_port5(priv->ds, interface);
-	} else if (port == 6) {
-		ret = mt7530_setup_port6(priv->ds, interface);
-		if (ret)
-			return ret;
-	}
+	else if (port == 6)
+		mt7530_setup_port6(priv->ds, interface);
 
 	return 0;
 }

-- 
2.40.1


