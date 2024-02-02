Return-Path: <linux-kernel+bounces-49549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7191E846BC3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9633C1C21D71
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5A77CF0F;
	Fri,  2 Feb 2024 09:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJ24hMNu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7997764E;
	Fri,  2 Feb 2024 09:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865573; cv=none; b=RB5+jizW4wz64ZA0EJ+FAGGdpzTgNshHA9nXVHRARVaXORdrFvXZZPIrIWP2QDbHtRWtaCqcBP7t5TgYBxCrCTSc+JSDlSzZalzRCe+FaI/12lMIuHLibybb9A3wzGgPIZe1oW0sXSGpFEUDFKu5qMeU84/RLejTHOQevQ4yvkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865573; c=relaxed/simple;
	bh=xTag5UeYCBFjGLTqYPztkFTzgUMpHMbTCDlpW8VBOsc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ARnmvB20EOkl+Yl4d/22YohRrO69Lk9Z4SKSENpHy8Zwjk6GdGf6tw/dZiwZwj5jTccz5DdPV73mpeee2jaYeG4wwDG6ka1LyTHrk/BvlczaSc38mH4gvyj/tmc0J+wd7zJ/Py7b0BGheMOki67Up0bCY+Ka7t9tIsOzCUq7CDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJ24hMNu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFB13C43601;
	Fri,  2 Feb 2024 09:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706865573;
	bh=xTag5UeYCBFjGLTqYPztkFTzgUMpHMbTCDlpW8VBOsc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jJ24hMNurZacuxVaYkfPuVcw+PJt7GAnMHBCNtW5K5e46vJ+0UA0+KmaF8bMqGa2L
	 5GOHiKtq4a0roT8zttztYWEdM7ZI3O4o74zjVyS1l46uaWgTbQF/Uxs862gBUQ7uzf
	 BA1fMHE/xqaA8/xdTH+PF+5BGQRP5BLBJFpdKflwwAwDfhjF+y0nA/EkN8hE+0q37z
	 JCk1ghXDJUwuCmtJz5biPCE4MRJBMLVAGF2XDtnUB8aJosfaEqIKNoon7Jkv2EVf3l
	 iQRepIEbKdDhSSWCF/+uxKNpuCq0pqG5WoVrZmILIwv1Z3YTEFC2h+0zwJrEdIpW5F
	 tv/3F92/9uhAg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92A1C4828E;
	Fri,  2 Feb 2024 09:19:32 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Fri, 02 Feb 2024 12:19:11 +0300
Subject: [PATCH net-next v3 5/7] net: dsa: mt7530: simplify
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
 <20240202-for-netnext-mt7530-improvements-2-v3-5-63d5adae99ca@arinc9.com>
References:
 <20240202-for-netnext-mt7530-improvements-2-v3-0-63d5adae99ca@arinc9.com>
In-Reply-To:
 <20240202-for-netnext-mt7530-improvements-2-v3-0-63d5adae99ca@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706865569; l=5591;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=SClOUTS4gvpigG+FVYtC+TPHpycdVONKPohI+GCk4KI=;
 b=qPBLSFm+L/Yaib7/N//8D44YxDAQUAw4+rorBwSOBqzArtOT3qYv+2l5seZyQMGGDnN3lgyy0
 /XcqPXQzWmPDb54yJubWLPRxknKKft7BqfU3PVIAXJf1KoI3VIC2CRh
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
in the case the interface changes from TRGMII to RGMII.

Disable the TRGMII clocks for all cases. They will be enabled if TRGMII is
being used.

Read XTAL after checking for RGMII as it's only needed for the TRGMII
interface mode.

Change mt7530_setup_port6() to void now that there're no error cases left.

Reviewed-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 101 ++++++++++++++++++++---------------------------
 1 file changed, 42 insertions(+), 59 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index c4d492e29fdf..e1fdef5766fb 100644
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
+	u32 ncpo1, ssc_delta, xtal;
 
-	xtal = mt7530_read(priv, MT7530_MHWTRAP) & HWTRAP_XTAL_MASK;
+	/* Disable the MT7530 TRGMII clocks */
+	core_clear(priv, CORE_TRGMII_GSW_CLK_CG, REG_TRGMIICK_EN);
 
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


