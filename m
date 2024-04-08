Return-Path: <linux-kernel+bounces-134877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A59B89B825
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57DF1F22223
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E34E23770;
	Mon,  8 Apr 2024 07:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="in/lzK3/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807EE21373;
	Mon,  8 Apr 2024 07:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712560160; cv=none; b=l2huUTVHq4twmXW/VG1FtMpM4lXyvNaBcJt20Hjm+NXS/tDSPZUXUUImZMi0YtJoacAxUnKJTF/MQkW/igIw69ZeiFZPIF3NpP3aWj4sf78Tn5xul4UwcfOEYh6m7c0G1D5cKlwmVQDMv5+Qv7zUrQOhhhVwyopuJuTutzHFyMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712560160; c=relaxed/simple;
	bh=gHm79mf9dWuS5bcDHOIECrVCMjYGD3c3Yz1JJKRWYHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eD8OhkdBGDJXVXs/KQ+4YEOEW2fQNDdsCNl5i8eESsFPhefh6mFf6+JHCHapKQFy78E9e7J/Qe05vnIFDWcoRhBmLfyrrt1cjb/44ipnTfXanOMFJUSCy8MMB2KmPyzJxdDhE4tLkAUt2VrjObvEvZFMEnLwE0Yvq/9DPfmaXcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=in/lzK3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4AC72C433F1;
	Mon,  8 Apr 2024 07:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712560160;
	bh=gHm79mf9dWuS5bcDHOIECrVCMjYGD3c3Yz1JJKRWYHw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=in/lzK3/xJIYilF1HCvk4EMLomEzDXuKs8edinhjeb7U6MmlFxAKdnwy+95+XQPr5
	 SNJ8VLOgX0qPyO2Gf3vry+VJ12uejDF/DaCALoOSRbCei+oDqR90KYFImISU5PlYlK
	 ve6wllW0+8JTtJzJaQqAZovhtJabF/1U7Zn8YqnBmQccT2GkeITCVDIrHRnd2+wOld
	 5BuKognz3hYDm7T0wSAKCQcAxtH728gzHF+zUdhWLgyxHeG5t18c3kGKaxgNjKMy/9
	 kBUTbtCzEQKUxkdWgMGDEfzNRIlXgsIPdD+FJK7w6D/b65wwvCdvH4e8AkKxU3rLhc
	 puTD1nrZkW62w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DE2CD1292;
	Mon,  8 Apr 2024 07:09:20 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Mon, 08 Apr 2024 10:08:53 +0300
Subject: [PATCH net v3] net: dsa: mt7530: fix enabling EEE on MT7531 switch
 on all boards
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240408-for-net-mt7530-fix-eee-for-mt7531-mt7988-v3-1-84fdef1f008b@arinc9.com>
X-B4-Tracking: v=1; b=H4sIAASYE2YC/5WNyw7CIBBFf6Vh7RielrryP4wLpINlIRhoiKbpv
 4vEhe50Nbn3Ts5ZSMbkMZN9t5CExWcfQw1i0xE7mXBB8GPNhFMuqWA9uJgg4AzXuVeCgvN3QMR
 Wt4q9zqA1GGWVVMJaippU3C1hfW6qI6kEcqrl5PMc06PpC2vT26R/NxUGFIRjPec7ISXqg0k+2
 GFr47VZCv8gc/YHmVfyYNwwKirZ2eEXeV3XJ5AcQDRAAQAA
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
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712560156; l=5377;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=qltAZRBFaTmcscWTR0cgLD3pkbarl63ldtcQJSlZS1A=;
 b=SinTodZV5a3qq0Y5xSGw6i9NCkL5hPnKOUyl/NRE1zpg0H/wRH5jJCFeQ0Zc9TKpLseqAG5A0
 J+uMIgsnr23A8d9q/UMk7Prad+OU27kdgySMP/U1VPyHTu1HBa2IRBE
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt
 with auth_id=115
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

The commit 40b5d2f15c09 ("net: dsa: mt7530: Add support for EEE features")
brought EEE support but did not enable EEE on MT7531 switch MACs. EEE is
enabled on MT7531 switch MACs by pulling the LAN2LED0 pin low on the board
(bootstrapping), unsetting the EEE_DIS bit on the trap register, or setting
the internal EEE switch bit on the CORE_PLL_GROUP4 register. Thanks to
SkyLake Huang (黃啟澤) from MediaTek for providing information on the
internal EEE switch bit.

There are existing boards that were not designed to pull the pin low.
Because of that, the EEE status currently depends on the board design.

The EEE_DIS bit on the trap pertains to the LAN2LED0 pin which is usually
used to control an LED. Once the bit is unset, the pin will be low. That
will make the active low LED turn on. The pin is controlled by the switch
PHY. It seems that the PHY controls the pin in the way that it inverts the
pin state. That means depending on the wiring of the LED connected to
LAN2LED0 on the board, the LED may be on without an active link.

To not cause this unwanted behaviour whilst enabling EEE on all boards, set
the internal EEE switch bit on the CORE_PLL_GROUP4 register.

My testing on MT7531 shows a certain amount of traffic loss when EEE is
enabled. That said, I haven't come across a board that enables EEE. So
enable EEE on the switch MACs but disable EEE advertisement on the switch
PHYs. This way, we don't change the behaviour of the majority of the boards
that have this switch. The mediatek-ge PHY driver already disables EEE
advertisement on the switch PHYs but my testing shows that it is somehow
enabled afterwards. Disabling EEE advertisement before the PHY driver
initialises keeps it off.

With this change, EEE can now be enabled using ethtool.

Fixes: 40b5d2f15c09 ("net: dsa: mt7530: Add support for EEE features")
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
Here's some information for the record. EEE could not be enabled on MT7531
on most boards using ethtool before this. On MT7988 SoC switch, EEE is
disabled by default but can be turned on normally using ethtool. EEE is
enabled by default on MT7530 and there's no need to make changes on the DSA
subdriver for it.
---
Changes in v3:
- Remove patch 2, it was revealed that it doesn't fix a bug.
- Patch 1
  - Use the internal EEE switch bit provided by SkyLake Huang (黃啟澤). It
    is a better method compared to unsetting the EEE_DIS bit of the trap as
    the latter method causes unwanted behaviour on the LED connected to the
    pin that pertains to the EEE_DIS bit.
- Link to v2: https://lore.kernel.org/r/20240321-for-net-mt7530-fix-eee-for-mt7531-mt7988-v2-0-9af9d5041bfe@arinc9.com

Changes in v2:
- Delegate the patch to the net tree.
- Remove patch 3, it was revealed that it doesn't fix a bug.
- Patch 1
  - Disable EEE advertisement on MT7531 by default.
- Link to v1: https://lore.kernel.org/r/20240318-for-net-mt7530-fix-eee-for-mt7531-mt7988-v1-0-3f17226344e8@arinc9.com
---
 drivers/net/dsa/mt7530.c | 17 ++++++++++++-----
 drivers/net/dsa/mt7530.h |  1 +
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 1035820c2377..451ff0620c2e 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2505,18 +2505,25 @@ mt7531_setup(struct dsa_switch *ds)
 	mt7530_rmw(priv, MT7531_GPIO_MODE0, MT7531_GPIO0_MASK,
 		   MT7531_GPIO0_INTERRUPT);
 
-	/* Enable PHY core PLL, since phy_device has not yet been created
-	 * provided for phy_[read,write]_mmd_indirect is called, we provide
-	 * our own mt7531_ind_mmd_phy_[read,write] to complete this
-	 * function.
+	/* Enable Energy-Efficient Ethernet (EEE) and PHY core PLL, since
+	 * phy_device has not yet been created provided for
+	 * phy_[read,write]_mmd_indirect is called, we provide our own
+	 * mt7531_ind_mmd_phy_[read,write] to complete this function.
 	 */
 	val = mt7531_ind_c45_phy_read(priv, MT753X_CTRL_PHY_ADDR,
 				      MDIO_MMD_VEND2, CORE_PLL_GROUP4);
-	val |= MT7531_PHY_PLL_BYPASS_MODE;
+	val |= MT7531_RG_SYSPLL_DMY2 | MT7531_PHY_PLL_BYPASS_MODE;
 	val &= ~MT7531_PHY_PLL_OFF;
 	mt7531_ind_c45_phy_write(priv, MT753X_CTRL_PHY_ADDR, MDIO_MMD_VEND2,
 				 CORE_PLL_GROUP4, val);
 
+	/* Disable EEE advertisement on the switch PHYs. */
+	for (i = MT753X_CTRL_PHY_ADDR;
+	     i < MT753X_CTRL_PHY_ADDR + MT7530_NUM_PHYS; i++) {
+		mt7531_ind_c45_phy_write(priv, i, MDIO_MMD_AN, MDIO_AN_EEE_ADV,
+					 0);
+	}
+
 	mt7531_setup_common(ds);
 
 	/* Setup VLAN ID 0 for VLAN-unaware bridges */
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index d17b318e6ee4..9439db495001 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -616,6 +616,7 @@ enum mt7531_clk_skew {
 #define  RG_SYSPLL_DDSFBK_EN		BIT(12)
 #define  RG_SYSPLL_BIAS_EN		BIT(11)
 #define  RG_SYSPLL_BIAS_LPF_EN		BIT(10)
+#define  MT7531_RG_SYSPLL_DMY2		BIT(6)
 #define  MT7531_PHY_PLL_OFF		BIT(5)
 #define  MT7531_PHY_PLL_BYPASS_MODE	BIT(4)
 

---
base-commit: bccb798e07f8bb8b91212fe8ed1e421685449076
change-id: 20240317-for-net-mt7530-fix-eee-for-mt7531-mt7988-a5c5453cc0e8

Best regards,
-- 
Arınç ÜNAL <arinc.unal@arinc9.com>



