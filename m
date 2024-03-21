Return-Path: <linux-kernel+bounces-110340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DED885D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8951F2617F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2871812CDB7;
	Thu, 21 Mar 2024 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbmFLEAR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A8F12C532;
	Thu, 21 Mar 2024 16:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711038580; cv=none; b=UuN0bXXz+JuFmM/Yox6NAGXY5P/9sFJF0wWGxnstXPlP2wnzDE6G8cv8CjRjePaMcQKqr6vJxekVPh4jsxR6fOZUsKZaecos8qDoEM7byiltMUVpIi15Wij9q5s46WXc9eps8rN2x8FCUNY9UQO+BQk1YAQGbmgY91LT9uNxde0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711038580; c=relaxed/simple;
	bh=Dm1PpESmKUiBkJ+3cICRSDiBnf/1JiIG6XDigLGXMlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AROueQ8VfxrhV3v12Odb4QcyWZrV8IJToXoM4Da0QE+ttk9MWoIGRAmhU2WpMxgd6Rq+7BaDBtD0ixZtc/PN4cImlvBuy3PVwziHEHbCNDZFKrkeEHg4og7SFRh4QshXBP8+7BbbytDjgbrrfCin5y1Ru9UiX4FV69RrS9K4wzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbmFLEAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F12EBC433C7;
	Thu, 21 Mar 2024 16:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711038580;
	bh=Dm1PpESmKUiBkJ+3cICRSDiBnf/1JiIG6XDigLGXMlQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FbmFLEAR2OjkUz89fFAGbWQaIBm7VPp+wrODGf3cgpaW90dcMMuLPUIBy4ru/hhLb
	 zfgNOMoZT4E2PAniw6E7a3cgj69iN8oHRRILIap1aZb7vlU72m1BtedZcv0Ia+qf9T
	 vuAP8YSIFtNAijVsMjR9CQ8nG8mT4zlWwoYDf19CkpQDwdS7pbWPG585rZI/KUoNIm
	 AVyj7tERnH4WO6w+4cFron94YQimE9rxVXrTVVp+Ge8/M9SV6CstakFSIFlInqNC+k
	 YN6FSt43taTpm3dvkiUPLu4r8exbptcplSQC7tDyKaEKHjZXtxMq7aDLz35zQTva21
	 c6h466+5AOmww==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD1ECD11C2;
	Thu, 21 Mar 2024 16:29:39 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Thu, 21 Mar 2024 19:29:13 +0300
Subject: [PATCH net v2 1/2] net: dsa: mt7530: fix enabling EEE on MT7531
 switch on all boards
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240321-for-net-mt7530-fix-eee-for-mt7531-mt7988-v2-1-9af9d5041bfe@arinc9.com>
References: <20240321-for-net-mt7530-fix-eee-for-mt7531-mt7988-v2-0-9af9d5041bfe@arinc9.com>
In-Reply-To: <20240321-for-net-mt7530-fix-eee-for-mt7531-mt7988-v2-0-9af9d5041bfe@arinc9.com>
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 =?utf-8?q?Ren=C3=A9_van_Dorst?= <opensource@vdorst.com>, 
 Russell King <linux@armlinux.org.uk>, 
 SkyLake Huang <SkyLake.Huang@mediatek.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: Bartel Eerdekens <bartel.eerdekens@constell8.be>, 
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711038558; l=3102;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=jPUSZ3Gz1HwFE6kGrRuGpoudPKmyUngv0UO3D4WqCPk=;
 b=PDdYcDWLl5PpsAn992chSxQxfWJGD18RI8e2IpPDL4UEksOruuIlksuJkAwm3bSzIZepdQ05O
 Pv6HZ7ZaNQkBAN7PxMeFnwusBGvksLdTarcCSmntqk+/6dnQ1ijKJO6
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt
 with auth_id=115
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

The commit 40b5d2f15c09 ("net: dsa: mt7530: Add support for EEE features")
brought EEE support but did not enable EEE on MT7531 switch MACs. EEE is
enabled on MT7531 switch MACs either by pulling the LAN2LED0 pin low on the
board (bootstrapping), or unsetting the EEE_DIS bit on the trap register.

There are existing boards that were not designed to pull the pin low.
Therefore, unset the EEE_DIS bit on the trap register.

Unlike MT7530, the modifiable trap register won't be populated identical to
the trap status register after reset. Therefore, read from the trap status
register, modify the bits, then write to the modifiable trap register.

My testing on MT7531 shows a certain amount of traffic loss when EEE is
enabled. That said, I haven't come across a board that enables EEE. So
enable EEE on the switch MACs but disable EEE advertisement on the switch
PHYs. This way, we don't change the behaviour of the majority of the boards
that have this switch.

With this change, EEE can now be enabled using ethtool.

The disable EEE bit on the trap pertains to the LAN2LED0 pin which is
usually used to control an LED. Once the bit is unset, the pin will be low.
That will make the active low LED turn on.

The pin is controlled by the switch PHY. It seems that the PHY controls the
pin in the way that it inverts the pin state. That means depending on the
wiring of the LED connected to LAN2LED0 on the board, the LED may be on
without an active link.

Fixes: 40b5d2f15c09 ("net: dsa: mt7530: Add support for EEE features")
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 14 ++++++++++++++
 drivers/net/dsa/mt7530.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 678b51f9cea6..6aa99b590329 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2458,6 +2458,20 @@ mt7531_setup(struct dsa_switch *ds)
 	/* Reset the switch through internal reset */
 	mt7530_write(priv, MT7530_SYS_CTRL, SYS_CTRL_SW_RST | SYS_CTRL_REG_RST);
 
+	/* Allow modifying the trap and enable Energy-Efficient Ethernet (EEE).
+	 */
+	val = mt7530_read(priv, MT7531_HWTRAP);
+	val |= CHG_STRAP;
+	val &= ~EEE_DIS;
+	mt7530_write(priv, MT7530_MHWTRAP, val);
+
+	/* Disable EEE advertisement on the switch PHYs. */
+	for (i = MT753X_CTRL_PHY_ADDR;
+	     i < MT753X_CTRL_PHY_ADDR + MT7530_NUM_PHYS; i++) {
+		mt7531_ind_c45_phy_write(priv, i, MDIO_MMD_AN, MDIO_AN_EEE_ADV,
+					 0);
+	}
+
 	if (!priv->p5_sgmii) {
 		mt7531_pll_setup(priv);
 	} else {
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index a71166e0a7fc..509ed5362236 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -457,6 +457,7 @@ enum mt7531_clk_skew {
 #define  XTAL_FSEL_M			BIT(7)
 #define  PHY_EN				BIT(6)
 #define  CHG_STRAP			BIT(8)
+#define  EEE_DIS			BIT(4)
 
 /* Register for hw trap modification */
 #define MT7530_MHWTRAP			0x7804

-- 
2.40.1



