Return-Path: <linux-kernel+bounces-152843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5DD8AC531
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4155328203A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B15C50290;
	Mon, 22 Apr 2024 07:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZxlmH25"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73074AEC8;
	Mon, 22 Apr 2024 07:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770131; cv=none; b=mMtQILV+afDOUQmKbv59gLmcV9BBLo0SxWU7A/2+LmfBsNz/un0Eg+dWIfXjJxHszjw6EMtAIFEx4Ziw0qBW52RSnru5UME2rDGpjaVMm3dSVvFjnW40vugIxnvE2/r6i89Ia8Rdos6JD1mYLBk48AhYNNguBeFOihDXekg2jpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770131; c=relaxed/simple;
	bh=iyZfRIz2oGdpKJ1+nD/8wWwJ5jum0Zo+YFlASEG8cYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=irAQxQjDnR/raq3CEjU4HizlZYJDHuJitmImjxR4sr9NkTe0LPUfN2gh3JNl4QU8ugYHgddwFRUblp5303VOei6hgEdEKfsdrp7Mpew4jI1TZXQXwI3j34UtmQOy14pVcHzsIIFjk0O6osiJpz/cAVAaHbE/+jUWiM07iEZw4R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZxlmH25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95C66C116B1;
	Mon, 22 Apr 2024 07:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713770130;
	bh=iyZfRIz2oGdpKJ1+nD/8wWwJ5jum0Zo+YFlASEG8cYY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uZxlmH25aRWjSJVpRMCQ5huptqOk1HYCI4iJSwDgZuAYoFrc2qpflLpX/rfzbX2og
	 Cu8LtrvkGes/Xl/TQEI1lwo4DDHThhW4DzX6mDIAOAW5o9cnrJu7BhFmRkU5gZpH4w
	 i7xm3G1jfvsXbk/d8nS6HCpfDwts4wwMwm4kdwnC2YLv9nlAq8g9z5NEzTgJ47wC7Z
	 xu005DAauflA/8n3o+YL0naUI7j1u2d7haH3UX2fJ06FQO0/Wxnp0caTJuOzy74C4k
	 N5dO//EKZRUtJ9UdP24e8+vlGMkrZU+3cQOAxdnaR6/KNmpGggylWJpgx9KrSdhE8m
	 bOZGRQM3VDB1A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83578C4345F;
	Mon, 22 Apr 2024 07:15:30 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Mon, 22 Apr 2024 10:15:09 +0300
Subject: [PATCH net-next v2 02/15] net: dsa: mt7530: refactor
 MT7530_PMCR_P()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240422-for-netnext-mt7530-improvements-4-v2-2-a75157ba76ad@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713770127; l=8131;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=/1XZ9JHfm5La3LRYYeIf/gk5qAEW+OcTIz4EqNWbcpk=;
 b=3cTDiw7wFTU9MyINjZ7KczWsN7WxLCHVtYcBFglC1N+OY9sLXzUF2M6gaEq/hhNlexPMcBF+o
 PxzvH1ndBZbCecYrqmsuySJqt3teR8Uy1Oitzal+MNh0Jnn7J6FkF/X
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

The MT7530_PMCR_P() registers are on MT7530, MT7531, and the switch on the
MT7988 SoC. Rename the definition for them to MT753X_PMCR_P(). Bit 15 is
for MT7530 only. Add MT7530 prefix to the definition for bit 15.

Use GENMASK and FIELD_PREP for PMCR_IFG_XMIT().

Rename PMCR_TX_EN and PMCR_RX_EN to PMCR_MAC_TX_EN and PMCR_MAC_TX_EN to
follow the naming on the "MT7621 Giga Switch Programming Guide v0.3",
"MT7531 Reference Manual for Development Board v1.0", and "MT7988A Wi-Fi 7
Generation Router Platform: Datasheet (Open Version) v0.1" documents.

These documents show that PMCR_RX_FC_EN is at bit 5. Correct this along
with renaming it to PMCR_FORCE_RX_FC_EN, and the same for PMCR_TX_FC_EN.

Remove PMCR_SPEED_MASK which doesn't have a use.

Rename the force mode definitions for MT7531 to FORCE_MODE. Add MASK at the
end for the mask that includes all force mode definitions.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 24 ++++++++++----------
 drivers/net/dsa/mt7530.h | 58 +++++++++++++++++++++++++-----------------------
 2 files changed, 42 insertions(+), 40 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 04795ef8ebd7..8dee9cee1104 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -896,7 +896,7 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
 		val &= ~MHWTRAP_P5_MAC_SEL & ~MHWTRAP_P5_DIS;
 
 		/* Setup the MAC by default for the cpu port */
-		mt7530_write(priv, MT7530_PMCR_P(5), 0x56300);
+		mt7530_write(priv, MT753X_PMCR_P(5), 0x56300);
 		break;
 	case P5_INTF_SEL_GMAC5:
 		/* MT7530_P5_MODE_GMAC: P5 -> External phy or 2nd GMAC */
@@ -2444,8 +2444,8 @@ mt7530_setup(struct dsa_switch *ds)
 		/* Clear link settings and enable force mode to force link down
 		 * on all ports until they're enabled later.
 		 */
-		mt7530_rmw(priv, MT7530_PMCR_P(i), PMCR_LINK_SETTINGS_MASK |
-			   PMCR_FORCE_MODE, PMCR_FORCE_MODE);
+		mt7530_rmw(priv, MT753X_PMCR_P(i), PMCR_LINK_SETTINGS_MASK |
+			   MT7530_FORCE_MODE, MT7530_FORCE_MODE);
 
 		/* Disable forwarding by default on all ports */
 		mt7530_rmw(priv, MT7530_PCR_P(i), PCR_MATRIX_MASK,
@@ -2555,8 +2555,8 @@ mt7531_setup_common(struct dsa_switch *ds)
 		/* Clear link settings and enable force mode to force link down
 		 * on all ports until they're enabled later.
 		 */
-		mt7530_rmw(priv, MT7530_PMCR_P(i), PMCR_LINK_SETTINGS_MASK |
-			   MT7531_FORCE_MODE, MT7531_FORCE_MODE);
+		mt7530_rmw(priv, MT753X_PMCR_P(i), PMCR_LINK_SETTINGS_MASK |
+			   MT7531_FORCE_MODE_MASK, MT7531_FORCE_MODE_MASK);
 
 		/* Disable forwarding by default on all ports */
 		mt7530_rmw(priv, MT7530_PCR_P(i), PCR_MATRIX_MASK,
@@ -2639,7 +2639,7 @@ mt7531_setup(struct dsa_switch *ds)
 
 	/* Force link down on all ports before internal reset */
 	for (i = 0; i < MT7530_NUM_PORTS; i++)
-		mt7530_write(priv, MT7530_PMCR_P(i), MT7531_FORCE_LNK);
+		mt7530_write(priv, MT753X_PMCR_P(i), MT7531_FORCE_MODE_LNK);
 
 	/* Reset the switch through internal reset */
 	mt7530_write(priv, MT7530_SYS_CTRL, SYS_CTRL_SW_RST | SYS_CTRL_REG_RST);
@@ -2881,7 +2881,7 @@ mt753x_phylink_mac_config(struct phylink_config *config, unsigned int mode,
 
 	/* Are we connected to external phy */
 	if (port == 5 && dsa_is_user_port(ds, 5))
-		mt7530_set(priv, MT7530_PMCR_P(port), PMCR_EXT_PHY);
+		mt7530_set(priv, MT753X_PMCR_P(port), PMCR_EXT_PHY);
 }
 
 static void mt753x_phylink_mac_link_down(struct phylink_config *config,
@@ -2891,7 +2891,7 @@ static void mt753x_phylink_mac_link_down(struct phylink_config *config,
 	struct dsa_port *dp = dsa_phylink_to_port(config);
 	struct mt7530_priv *priv = dp->ds->priv;
 
-	mt7530_clear(priv, MT7530_PMCR_P(dp->index), PMCR_LINK_SETTINGS_MASK);
+	mt7530_clear(priv, MT753X_PMCR_P(dp->index), PMCR_LINK_SETTINGS_MASK);
 }
 
 static void mt753x_phylink_mac_link_up(struct phylink_config *config,
@@ -2905,7 +2905,7 @@ static void mt753x_phylink_mac_link_up(struct phylink_config *config,
 	struct mt7530_priv *priv = dp->ds->priv;
 	u32 mcr;
 
-	mcr = PMCR_RX_EN | PMCR_TX_EN | PMCR_FORCE_LNK;
+	mcr = PMCR_MAC_RX_EN | PMCR_MAC_TX_EN | PMCR_FORCE_LNK;
 
 	switch (speed) {
 	case SPEED_1000:
@@ -2920,9 +2920,9 @@ static void mt753x_phylink_mac_link_up(struct phylink_config *config,
 	if (duplex == DUPLEX_FULL) {
 		mcr |= PMCR_FORCE_FDX;
 		if (tx_pause)
-			mcr |= PMCR_TX_FC_EN;
+			mcr |= PMCR_FORCE_TX_FC_EN;
 		if (rx_pause)
-			mcr |= PMCR_RX_FC_EN;
+			mcr |= PMCR_FORCE_RX_FC_EN;
 	}
 
 	if (mode == MLO_AN_PHY && phydev && phy_init_eee(phydev, false) >= 0) {
@@ -2937,7 +2937,7 @@ static void mt753x_phylink_mac_link_up(struct phylink_config *config,
 		}
 	}
 
-	mt7530_set(priv, MT7530_PMCR_P(dp->index), mcr);
+	mt7530_set(priv, MT753X_PMCR_P(dp->index), mcr);
 }
 
 static void mt753x_phylink_get_caps(struct dsa_switch *ds, int port,
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index f7c5355c1642..7d7abb67202f 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -304,44 +304,46 @@ enum mt7530_vlan_port_acc_frm {
 #define  G0_PORT_VID_DEF		G0_PORT_VID(0)
 
 /* Register for port MAC control register */
-#define MT7530_PMCR_P(x)		(0x3000 + ((x) * 0x100))
-#define  PMCR_IFG_XMIT(x)		(((x) & 0x3) << 18)
+#define MT753X_PMCR_P(x)		(0x3000 + ((x) * 0x100))
+#define  PMCR_IFG_XMIT_MASK		GENMASK(19, 18)
+#define  PMCR_IFG_XMIT(x)		FIELD_PREP(PMCR_IFG_XMIT_MASK, x)
 #define  PMCR_EXT_PHY			BIT(17)
 #define  PMCR_MAC_MODE			BIT(16)
-#define  PMCR_FORCE_MODE		BIT(15)
-#define  PMCR_TX_EN			BIT(14)
-#define  PMCR_RX_EN			BIT(13)
+#define  MT7530_FORCE_MODE		BIT(15)
+#define  PMCR_MAC_TX_EN			BIT(14)
+#define  PMCR_MAC_RX_EN			BIT(13)
 #define  PMCR_BACKOFF_EN		BIT(9)
 #define  PMCR_BACKPR_EN			BIT(8)
 #define  PMCR_FORCE_EEE1G		BIT(7)
 #define  PMCR_FORCE_EEE100		BIT(6)
-#define  PMCR_TX_FC_EN			BIT(5)
-#define  PMCR_RX_FC_EN			BIT(4)
+#define  PMCR_FORCE_RX_FC_EN		BIT(5)
+#define  PMCR_FORCE_TX_FC_EN		BIT(4)
 #define  PMCR_FORCE_SPEED_1000		BIT(3)
 #define  PMCR_FORCE_SPEED_100		BIT(2)
 #define  PMCR_FORCE_FDX			BIT(1)
 #define  PMCR_FORCE_LNK			BIT(0)
-#define  PMCR_SPEED_MASK		(PMCR_FORCE_SPEED_100 | \
-					 PMCR_FORCE_SPEED_1000)
-#define  MT7531_FORCE_LNK		BIT(31)
-#define  MT7531_FORCE_SPD		BIT(30)
-#define  MT7531_FORCE_DPX		BIT(29)
-#define  MT7531_FORCE_RX_FC		BIT(28)
-#define  MT7531_FORCE_TX_FC		BIT(27)
-#define  MT7531_FORCE_EEE100		BIT(26)
-#define  MT7531_FORCE_EEE1G		BIT(25)
-#define  MT7531_FORCE_MODE		(MT7531_FORCE_LNK | \
-					 MT7531_FORCE_SPD | \
-					 MT7531_FORCE_DPX | \
-					 MT7531_FORCE_RX_FC | \
-					 MT7531_FORCE_TX_FC | \
-					 MT7531_FORCE_EEE100 | \
-					 MT7531_FORCE_EEE1G)
-#define  PMCR_LINK_SETTINGS_MASK	(PMCR_TX_EN | PMCR_FORCE_SPEED_1000 | \
-					 PMCR_RX_EN | PMCR_FORCE_SPEED_100 | \
-					 PMCR_TX_FC_EN | PMCR_RX_FC_EN | \
-					 PMCR_FORCE_FDX | PMCR_FORCE_LNK | \
-					 PMCR_FORCE_EEE1G | PMCR_FORCE_EEE100)
+#define  MT7531_FORCE_MODE_LNK		BIT(31)
+#define  MT7531_FORCE_MODE_SPD		BIT(30)
+#define  MT7531_FORCE_MODE_DPX		BIT(29)
+#define  MT7531_FORCE_MODE_RX_FC	BIT(28)
+#define  MT7531_FORCE_MODE_TX_FC	BIT(27)
+#define  MT7531_FORCE_MODE_EEE100	BIT(26)
+#define  MT7531_FORCE_MODE_EEE1G	BIT(25)
+#define  MT7531_FORCE_MODE_MASK		(MT7531_FORCE_MODE_LNK | \
+					 MT7531_FORCE_MODE_SPD | \
+					 MT7531_FORCE_MODE_DPX | \
+					 MT7531_FORCE_MODE_RX_FC | \
+					 MT7531_FORCE_MODE_TX_FC | \
+					 MT7531_FORCE_MODE_EEE100 | \
+					 MT7531_FORCE_MODE_EEE1G)
+#define  PMCR_LINK_SETTINGS_MASK	(PMCR_MAC_TX_EN | PMCR_MAC_RX_EN | \
+					 PMCR_FORCE_EEE1G | \
+					 PMCR_FORCE_EEE100 | \
+					 PMCR_FORCE_RX_FC_EN | \
+					 PMCR_FORCE_TX_FC_EN | \
+					 PMCR_FORCE_SPEED_1000 | \
+					 PMCR_FORCE_SPEED_100 | \
+					 PMCR_FORCE_FDX | PMCR_FORCE_LNK)
 
 #define MT7530_PMEEECR_P(x)		(0x3004 + (x) * 0x100)
 #define  WAKEUP_TIME_1000(x)		(((x) & 0xFF) << 24)

-- 
2.40.1



