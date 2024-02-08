Return-Path: <linux-kernel+bounces-57484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF66884D9B3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68352282209
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 05:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5446A8A4;
	Thu,  8 Feb 2024 05:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ap5avz30"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE35467C74;
	Thu,  8 Feb 2024 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707371494; cv=none; b=E6M0wPnYZvv1J8g3S0W8LcnF1kHKmtcaO+ALvFFh90FHU5HuAW9XQrS1URtp6enQzxIVIajrVUSLhIFtnYt42zp16qahlGeeSyQzwe44YlqQszLwOfPIANjYu3x1Mya6ZoRndOuNdZy1QE0DeB571h6y6A9dnbvSMeH4DdcmQZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707371494; c=relaxed/simple;
	bh=33itorBWyf5M6/pJLSa2Fmgkw5O7iOIvVpDVlFfasoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KtpvjAqWN6SlKHkQviVtpreaWiL335PrE59BEK/NA7tetBDOBh6iCVTuKwBUgJiUND56otMrssgH0unj0Q531MJBXSNTRNDzIv6dtP7AfMiKG/62tH6RspXBIgUPS4LEYbdW53FMFaVHQBRS88mW8PYahyt+OB0Ft/VoDmBNqhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ap5avz30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96F57C4166A;
	Thu,  8 Feb 2024 05:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707371493;
	bh=33itorBWyf5M6/pJLSa2Fmgkw5O7iOIvVpDVlFfasoM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ap5avz30RCJeSf1NT2fQRNBhyxv3IKpCXyTh3To1NGuebppqw9BjfWajTU1XsKIcg
	 6C7YsK/uh+6dSuOzTe3p9Qjhh1lPVaQxBwd+Dd3vVyFoT6SPdBw45fKGvn5s/ZraFS
	 wjMCz+FOu0oUmhCsbOYtNovKf2wR7HdF5rAKCPFQatIQiwcyOjVfldpGukfel1ksQt
	 k86sckECQg5LEo4pT3gMxiJ2qNfnbvEVESsOZ23T0pDvuBoLAVSgEem1idPjLHuCQd
	 N48S8dYn9krgw+hcf7baBsYxqKzUhY6YrdwG9++v1kv8r5Zz+n8fsU3xkGh7FXBH42
	 4/j3h4WQHMswg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F56C48260;
	Thu,  8 Feb 2024 05:51:33 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Thu, 08 Feb 2024 08:51:36 +0300
Subject: [PATCH netnext 8/8] net: dsa: mt7530: simplify link operations and
 force link down on all ports
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id:
 <20240208-for-netnext-mt7530-improvements-3-v1-8-d7c1cfd502ca@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707371489; l=5224;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=F8DQ0JkjBlyf4L4PkazDniJyaWulKX69bCZGZtD69sU=;
 b=tN8yIL5E+3fr+kuSvqN6xhIMheBGlRzbAcOb1knVHpcxMUz41gKRyXYb3IF8uzqOwLaMz3I/W
 jwgaXMr0qavBMBQyzJ/6ne8Wg/50fdI0Q33D1D5o7INE3qL+ZIORL+l
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Currently, the link operations for switch MACs are scattered across
port_enable, port_disable, phylink_mac_config, phylink_mac_link_up, and
phylink_mac_link_down.

port_enable and port_disable clears the link settings. Move that to
mt7530_setup() and mt7531_setup_common() which set up the switches. This
way, the link settings are cleared on all ports at setup, and then only
once with phylink_mac_link_down() when a link goes down.

Enable force mode at setup to apply the force part of the link settings.
This ensures that only active ports will have their link up.

Now that the bit for setting the port on force mode is done on
mt7530_setup() and mt7531_setup_common(), get rid of PMCR_FORCE_MODE_ID()
which helped determine which bit to use for the switch model.

The "MT7621 Giga Switch Programming Guide v0.3", "MT7531 Reference Manual
for Development Board v1.0", and "MT7988A Wi-Fi 7 Generation Router
Platform: Datasheet (Open Version) v0.1" documents show that these bits are
enabled at reset:

PMCR_IFG_XMIT(1) (not part of PMCR_LINK_SETTINGS_MASK)
PMCR_MAC_MODE (not part of PMCR_LINK_SETTINGS_MASK)
PMCR_TX_EN
PMCR_RX_EN
PMCR_BACKOFF_EN (not part of PMCR_LINK_SETTINGS_MASK)
PMCR_BACKPR_EN (not part of PMCR_LINK_SETTINGS_MASK)
PMCR_TX_FC_EN
PMCR_RX_FC_EN

These bits also don't exist on the MT7530_PMCR_P(6) register of the switch
on the MT7988 SoC:

PMCR_IFG_XMIT()
PMCR_MAC_MODE
PMCR_BACKOFF_EN
PMCR_BACKPR_EN

Remove the setting of the bits not part of PMCR_LINK_SETTINGS_MASK on
phylink_mac_config as they're already set.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 26 +++++++++++++-------------
 drivers/net/dsa/mt7530.h |  2 --
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 5c8ad41ce8cd..f67db577d1c0 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1018,7 +1018,6 @@ mt7530_port_enable(struct dsa_switch *ds, int port,
 	priv->ports[port].enable = true;
 	mt7530_rmw(priv, MT7530_PCR_P(port), PCR_MATRIX_MASK,
 		   priv->ports[port].pm);
-	mt7530_clear(priv, MT7530_PMCR_P(port), PMCR_LINK_SETTINGS_MASK);
 
 	mutex_unlock(&priv->reg_mutex);
 
@@ -1038,7 +1037,6 @@ mt7530_port_disable(struct dsa_switch *ds, int port)
 	priv->ports[port].enable = false;
 	mt7530_rmw(priv, MT7530_PCR_P(port), PCR_MATRIX_MASK,
 		   PCR_MATRIX_CLR);
-	mt7530_clear(priv, MT7530_PMCR_P(port), PMCR_LINK_SETTINGS_MASK);
 
 	mutex_unlock(&priv->reg_mutex);
 }
@@ -2257,6 +2255,12 @@ mt7530_setup(struct dsa_switch *ds)
 	mt7530_mib_reset(ds);
 
 	for (i = 0; i < MT7530_NUM_PORTS; i++) {
+		/* Clear link settings and enable force mode to force link down
+		 * on all ports until they're enabled later.
+		 */
+		mt7530_clear(priv, MT7530_PMCR_P(i), PMCR_LINK_SETTINGS_MASK);
+		mt7530_set(priv, MT7530_PMCR_P(i), PMCR_FORCE_MODE);
+
 		/* Disable forwarding by default on all ports */
 		mt7530_rmw(priv, MT7530_PCR_P(i), PCR_MATRIX_MASK,
 			   PCR_MATRIX_CLR);
@@ -2359,6 +2363,12 @@ mt7531_setup_common(struct dsa_switch *ds)
 		     UNU_FFP_MASK);
 
 	for (i = 0; i < MT7530_NUM_PORTS; i++) {
+		/* Clear link settings and enable force mode to force link down
+		 * on all ports until they're enabled later.
+		 */
+		mt7530_clear(priv, MT7530_PMCR_P(i), PMCR_LINK_SETTINGS_MASK);
+		mt7530_set(priv, MT7530_PMCR_P(i), MT7531_FORCE_MODE);
+
 		/* Disable forwarding by default on all ports */
 		mt7530_rmw(priv, MT7530_PCR_P(i), PCR_MATRIX_MASK,
 			   PCR_MATRIX_CLR);
@@ -2657,23 +2667,13 @@ mt753x_phylink_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 			  const struct phylink_link_state *state)
 {
 	struct mt7530_priv *priv = ds->priv;
-	u32 mcr_cur, mcr_new;
 
 	if ((port == 5 || port == 6) && priv->info->mac_port_config)
 		priv->info->mac_port_config(ds, port, mode, state->interface);
 
-	mcr_cur = mt7530_read(priv, MT7530_PMCR_P(port));
-	mcr_new = mcr_cur;
-	mcr_new &= ~PMCR_LINK_SETTINGS_MASK;
-	mcr_new |= PMCR_IFG_XMIT(1) | PMCR_MAC_MODE | PMCR_BACKOFF_EN |
-		   PMCR_BACKPR_EN | PMCR_FORCE_MODE_ID(priv->id);
-
 	/* Are we connected to external phy */
 	if (port == 5 && dsa_is_user_port(ds, 5))
-		mcr_new |= PMCR_EXT_PHY;
-
-	if (mcr_new != mcr_cur)
-		mt7530_write(priv, MT7530_PMCR_P(port), mcr_new);
+		mt7530_set(priv, MT7530_PMCR_P(port), PMCR_EXT_PHY);
 }
 
 static void mt753x_phylink_mac_link_down(struct dsa_switch *ds, int port,
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 8a8144868eaa..a71166e0a7fc 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -304,8 +304,6 @@ enum mt7530_vlan_port_acc_frm {
 					 MT7531_FORCE_DPX | \
 					 MT7531_FORCE_RX_FC | \
 					 MT7531_FORCE_TX_FC)
-#define  PMCR_FORCE_MODE_ID(id)		((((id) == ID_MT7531) || ((id) == ID_MT7988)) ?	\
-					 MT7531_FORCE_MODE : PMCR_FORCE_MODE)
 #define  PMCR_LINK_SETTINGS_MASK	(PMCR_TX_EN | PMCR_FORCE_SPEED_1000 | \
 					 PMCR_RX_EN | PMCR_FORCE_SPEED_100 | \
 					 PMCR_TX_FC_EN | PMCR_RX_FC_EN | \

-- 
2.40.1


