Return-Path: <linux-kernel+bounces-51792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A6B848F55
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6F81C210FF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCC924B59;
	Sun,  4 Feb 2024 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h07Rhw4q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F12E22F13;
	Sun,  4 Feb 2024 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707064492; cv=none; b=IavsgwF/+YkJyeKDbKFF6qeNs85akYok/ix2Qa4AoIKUNQkNBDOaQu0sZ1lMp+E3CVZd0gu0i9slXzE14x2OOXhr7kxD09IMD96DPqhVGOr7RmNuFi2dXZaQ/jxmX7DiKMJhmwGgzJ1ttKaJ0I3YOG8LS4Omb9VXeYu2T1rAvUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707064492; c=relaxed/simple;
	bh=puE0H+0dxqk+kALrvio38D2+1eLpQM/MJiPG9L3BHjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cJOK2N+EmISSxTBBCKodjJjqajTad26bYJiN0aIuSSF7ljx1mlg9p/bEJ80EzprAuoKYDEUs+iVqZfrlcyqCOJq3V0WIiUBybV54ecdPHcmp/epQRQLwM4l9iQGlfQCNOjVDZcHpOFxFaLsQZ6IKzhRhrGVapBf+xr/oJI+N4RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h07Rhw4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4C0EC433A6;
	Sun,  4 Feb 2024 16:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707064492;
	bh=puE0H+0dxqk+kALrvio38D2+1eLpQM/MJiPG9L3BHjg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=h07Rhw4qRDGgkMJrU1Xc1ZGl9lO3hyNleItqd/zpnYyOLj1H+9k2sETdMKkOhODVQ
	 PD9/DUpuqdh9QIAZaM1cNGx+LKtLTAHR57z3cSbF8QKb7RDmls+qcBrn3wHI/1Y626
	 NbMcgon37KI+yJ1cs4xyiMs3af2w3gdms/Twht8khA+ZGuf3qmEerg0fri1BO5FRF9
	 p16JoqSAJTZn2Pmd5qdJzebdda8i0uEYv3xn9OJ8A6wh7PSJaD4EkcHUwvQCgDxxbN
	 mW6Ul22Ctdcm44fZiFY7AD+dhyStNW7jqGPWtTO/r2P561cPe5Ryl/ntYwsWblltO3
	 AkZ/m/tEC8jFQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53CAC4828F;
	Sun,  4 Feb 2024 16:34:51 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Sun, 04 Feb 2024 19:34:21 +0300
Subject: [PATCH net-next v4 3/7] net: dsa: mt7530: simplify
 mt7530_pad_clk_setup()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id:
 <20240204-for-netnext-mt7530-improvements-2-v4-3-02bf0abaadb8@arinc9.com>
References:
 <20240204-for-netnext-mt7530-improvements-2-v4-0-02bf0abaadb8@arinc9.com>
In-Reply-To:
 <20240204-for-netnext-mt7530-improvements-2-v4-0-02bf0abaadb8@arinc9.com>
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
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707064489; l=4954;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=9/J2GD71ZKdoYnfGtT2kaa92CIVclpnfm7Vnc7HsKpg=;
 b=ZVKzvpto9gb+0jhVVuEjsboUy0hB8B7l/tQy/WqE31KW22plC1Papds/RD+GCCiTVAw0mUPAH
 3VndNirdV+nAEJMEfkN0Pv817lQ2lbl8pRBn6R4QyBYeOnL1+i3vYwa
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

From: Arınç ÜNAL <arinc.unal@arinc9.com>

This code is from before this driver was converted to phylink API. Phylink
deals with the unsupported interface cases before mt7530_pad_clk_setup() is
run. Therefore, the default case would never run. However, it must be
defined nonetheless to handle all the remaining enumeration values, the
phy-modes.

Switch to if statement for RGMII and return which simplifies the code and
saves an indent.

Set P6_INTF_MODE, which is the three least significant bits of the
MT7530_P6ECR register, to 0 for RGMII even though it will already be 0
after reset. This is to keep supporting dynamic reconfiguration of the port
in the case the interface changes from TRGMII to RGMII.

Disable the TRGMII clocks for all cases. They will be enabled if TRGMII is
being used.

Read XTAL after checking for RGMII as it's only needed for the TRGMII
interface mode.

Reviewed-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 91 +++++++++++++++++++++---------------------------
 1 file changed, 40 insertions(+), 51 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 8b8469eba863..82e90da1e52b 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -418,64 +418,53 @@ static int
 mt7530_pad_clk_setup(struct dsa_switch *ds, phy_interface_t interface)
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
-	}
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
+	}
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
 
 	return 0;
 }

-- 
2.40.1


