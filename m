Return-Path: <linux-kernel+bounces-49547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0588C846BBD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFBD328A4C4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2830377F35;
	Fri,  2 Feb 2024 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cprgKsM/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A44D63128;
	Fri,  2 Feb 2024 09:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865573; cv=none; b=qiGb1tSQ89BrddpDvyjRgp39ehetcUFG++Opy3GUSKeFT9JQp91UiuBC+ZHsLN4oS8WhpClMib/aXR2uHNm1U6Wn5/VWVVzDFmAfbyhtQ1rTSqC+4g3Wiwt5LezI6aCOl7npgRxoQ7Akyy96a2C3/5MEXWJgUgfEaM3hGB+veTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865573; c=relaxed/simple;
	bh=geuIbXh9w4KhgrtRBbriGKSSJk8c4449tqrOQjGdf2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cMiew0Xw97LOeDA1HCq1BATrl7AO5yANGJ7IU9BKq262MRUjkRgwnRwZe6XLxR8sSCzhjd5W90GUcAzpkvL202TleTI3zEP8txZZwCBCeBRcQh/AWgSnQW9DAms0eMt9dD3QFClZZkOJBbqqljRPtLK3fEwkztw0r+jY0FDH9dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cprgKsM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE4F6C43399;
	Fri,  2 Feb 2024 09:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706865572;
	bh=geuIbXh9w4KhgrtRBbriGKSSJk8c4449tqrOQjGdf2M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cprgKsM/iYxfcE/7gy+vSMDr5VSP4I5OoyPwpPsUO6No9rHZdl41a6ty2ma/TAICp
	 kS47Pc6TGee22xTayvCbuP81VaBhAJOx7m2C4T5Mkfmwq7r/JpJYMLxY65nz2FPyl2
	 sKxRy0rm+TWLC8RX3yxWUV3tNdLAV02w2WaHoylsUQwHfr1jloDOavL9EMnJ910tp7
	 IQdd2ZZORYFikFL9WokRRM4stfMvXVrs+LYW9rVuHdwpoZsbpb8HDbQ/HVRI5gLm/K
	 GD7gKo5InX7r6TZfwrrx5BKnK4+Dz6YZ4BfYj2kw3EM+lINSrOPEB/dAYhWR9mUFyV
	 P3xOAAfq6tS5w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70E7C47258;
	Fri,  2 Feb 2024 09:19:32 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Fri, 02 Feb 2024 12:19:09 +0300
Subject: [PATCH net-next v3 3/7] net: dsa: mt7530: remove pad_setup
 function pointer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id:
 <20240202-for-netnext-mt7530-improvements-2-v3-3-63d5adae99ca@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706865569; l=5377;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=mGG9kyQDvMUC5EklHXtFMAWXK1ZdqyzJT5eZTcp+Y90=;
 b=f+JF8KM64zJRkj/KJDQN8vkKEhVQccWLWxKkI9NLRqF95gugIsq0aGI6z7zAusGK1wqh/vUX9
 98PKylHG9ELB39c21cVqccSsAatjC94jCTROF3zABtiabLBf0e5hZVJ
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

From: Arınç ÜNAL <arinc.unal@arinc9.com>

The pad_setup function pointer was introduced with 88bdef8be9f6 ("net: dsa:
mt7530: Extend device data ready for adding a new hardware"). It was being
used to set up the core clock and port 6 of the MT7530 switch, and pll of
the MT7531 switch.

All of these were moved to more appropriate locations, and it was never
used for the switch on the MT7988 SoC. Therefore, this function pointer
hasn't got a use anymore. Remove it.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/net/dsa/mt7530.c | 36 ++----------------------------------
 drivers/net/dsa/mt7530.h |  3 ---
 2 files changed, 2 insertions(+), 37 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 2d468a5f2e70..fdaf65b58b72 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -487,18 +487,6 @@ mt7530_setup_port6(struct dsa_switch *ds, phy_interface_t interface)
 	return 0;
 }
 
-static int
-mt7530_pad_clk_setup(struct dsa_switch *ds, phy_interface_t interface)
-{
-	return 0;
-}
-
-static int
-mt7531_pad_setup(struct dsa_switch *ds, phy_interface_t interface)
-{
-	return 0;
-}
-
 static void
 mt7531_pll_setup(struct mt7530_priv *priv)
 {
@@ -2617,14 +2605,6 @@ static void mt7988_mac_port_get_caps(struct dsa_switch *ds, int port,
 	}
 }
 
-static int
-mt753x_pad_setup(struct dsa_switch *ds, const struct phylink_link_state *state)
-{
-	struct mt7530_priv *priv = ds->priv;
-
-	return priv->info->pad_setup(ds, state->interface);
-}
-
 static int
 mt7530_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 		  phy_interface_t interface)
@@ -2794,8 +2774,6 @@ mt753x_phylink_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 		if (priv->p6_interface == state->interface)
 			break;
 
-		mt753x_pad_setup(ds, state);
-
 		if (mt753x_mac_config(ds, port, mode, state) < 0)
 			goto unsupported;
 
@@ -3113,11 +3091,6 @@ mt753x_conduit_state_change(struct dsa_switch *ds,
 	mt7530_rmw(priv, MT7530_MFC, CPU_EN | CPU_PORT_MASK, val);
 }
 
-static int mt7988_pad_setup(struct dsa_switch *ds, phy_interface_t interface)
-{
-	return 0;
-}
-
 static int mt7988_setup(struct dsa_switch *ds)
 {
 	struct mt7530_priv *priv = ds->priv;
@@ -3181,7 +3154,6 @@ const struct mt753x_info mt753x_table[] = {
 		.phy_write_c22 = mt7530_phy_write_c22,
 		.phy_read_c45 = mt7530_phy_read_c45,
 		.phy_write_c45 = mt7530_phy_write_c45,
-		.pad_setup = mt7530_pad_clk_setup,
 		.mac_port_get_caps = mt7530_mac_port_get_caps,
 		.mac_port_config = mt7530_mac_config,
 	},
@@ -3193,7 +3165,6 @@ const struct mt753x_info mt753x_table[] = {
 		.phy_write_c22 = mt7530_phy_write_c22,
 		.phy_read_c45 = mt7530_phy_read_c45,
 		.phy_write_c45 = mt7530_phy_write_c45,
-		.pad_setup = mt7530_pad_clk_setup,
 		.mac_port_get_caps = mt7530_mac_port_get_caps,
 		.mac_port_config = mt7530_mac_config,
 	},
@@ -3205,7 +3176,6 @@ const struct mt753x_info mt753x_table[] = {
 		.phy_write_c22 = mt7531_ind_c22_phy_write,
 		.phy_read_c45 = mt7531_ind_c45_phy_read,
 		.phy_write_c45 = mt7531_ind_c45_phy_write,
-		.pad_setup = mt7531_pad_setup,
 		.cpu_port_config = mt7531_cpu_port_config,
 		.mac_port_get_caps = mt7531_mac_port_get_caps,
 		.mac_port_config = mt7531_mac_config,
@@ -3218,7 +3188,6 @@ const struct mt753x_info mt753x_table[] = {
 		.phy_write_c22 = mt7531_ind_c22_phy_write,
 		.phy_read_c45 = mt7531_ind_c45_phy_read,
 		.phy_write_c45 = mt7531_ind_c45_phy_write,
-		.pad_setup = mt7988_pad_setup,
 		.cpu_port_config = mt7988_cpu_port_config,
 		.mac_port_get_caps = mt7988_mac_port_get_caps,
 		.mac_port_config = mt7988_mac_config,
@@ -3248,9 +3217,8 @@ mt7530_probe_common(struct mt7530_priv *priv)
 	/* Sanity check if these required device operations are filled
 	 * properly.
 	 */
-	if (!priv->info->sw_setup || !priv->info->pad_setup ||
-	    !priv->info->phy_read_c22 || !priv->info->phy_write_c22 ||
-	    !priv->info->mac_port_get_caps ||
+	if (!priv->info->sw_setup || !priv->info->phy_read_c22 ||
+	    !priv->info->phy_write_c22 || !priv->info->mac_port_get_caps ||
 	    !priv->info->mac_port_config)
 		return -EINVAL;
 
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 80060cc740d2..26a6d2160c08 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -704,8 +704,6 @@ struct mt753x_pcs {
  * @phy_write_c22:	Holding the way writing PHY port using C22
  * @phy_read_c45:	Holding the way reading PHY port using C45
  * @phy_write_c45:	Holding the way writing PHY port using C45
- * @pad_setup:		Holding the way setting up the bus pad for a certain
- *			MAC port
  * @phy_mode_supported:	Check if the PHY type is being supported on a certain
  *			port
  * @mac_port_validate:	Holding the way to set addition validate type for a
@@ -726,7 +724,6 @@ struct mt753x_info {
 			    int regnum);
 	int (*phy_write_c45)(struct mt7530_priv *priv, int port, int devad,
 			     int regnum, u16 val);
-	int (*pad_setup)(struct dsa_switch *ds, phy_interface_t interface);
 	int (*cpu_port_config)(struct dsa_switch *ds, int port);
 	void (*mac_port_get_caps)(struct dsa_switch *ds, int port,
 				  struct phylink_config *config);

-- 
2.40.1


