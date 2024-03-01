Return-Path: <linux-kernel+bounces-88277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DD986DF85
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A701C22850
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D536F07D;
	Fri,  1 Mar 2024 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqil/Xbc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873FB6BFB9;
	Fri,  1 Mar 2024 10:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709289779; cv=none; b=dE+pYP6x/1YEfmlhylYOhDlBA+uzgp0/MbhtIRIV4mzcNDD3ab3flLuGQI/fBhezn6RzerjpmJHq2b+ymlY0SQmS0sKoG6HDNdsP2udfVEL12KIHKHmwc+o4ZAEcRhKIwN/W2/rQQwO0/nNelDxEy6/cwIk6+Jlkme2wbqPnF1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709289779; c=relaxed/simple;
	bh=sa9GDhwHLam8Wcmm30zorJWAPpLaxT+d7nBFuW01m64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nza2RSQQSPOGlbBu0BjZDaqqnckyBBabe0BzE9ddvA1JFuJi8iR5iBbEabQFXbKX/PobjN1i2qFkWCvlxTwpngZ1448sB1qapu91hZ4LVB0JYnLhjGA7S4RSdmSIcIm8YjQ/mlVMqgzo2qyeUj9xorbKWpA0xvuF7bBvzXsT4Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqil/Xbc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38D66C4166C;
	Fri,  1 Mar 2024 10:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709289779;
	bh=sa9GDhwHLam8Wcmm30zorJWAPpLaxT+d7nBFuW01m64=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gqil/Xbcmt0wVwFFx+xYoYmLuRDhAWE9HBvtEO3s2l/JWSp4eCpqH8o9w7BacLIdr
	 +FDiho7bur0Y4TfjIwAQeLPQ+F3cXxJF/DylUpJTnuA1W8/3Fak+C1FXp0PTJgw14Y
	 RuO8SROaKHkLGppS7N+VrG4bqMXjYOH71CUI2gEUI/mFUvoJOR56GORHRrB+Kj43Eu
	 walh46STXmgsu06NYJqP8dBLgnFTeQC69RCaz805sAWxJK2PFV8/JFZyWOUnY5nAfG
	 m7HYbHIDVqGu7bkgyvkI45xUYbU48DuCYQtoYdxNOq8rw0XR9RFDMXX1ApDNq40Im+
	 AH6gQg9OMRl/w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EFFC5475B;
	Fri,  1 Mar 2024 10:42:59 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Fri, 01 Mar 2024 12:43:05 +0200
Subject: [PATCH net-next v3 9/9] net: dsa: mt7530: simplify link operations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id:
 <20240301-for-netnext-mt7530-improvements-3-v3-9-449f4f166454@arinc9.com>
References:
 <20240301-for-netnext-mt7530-improvements-3-v3-0-449f4f166454@arinc9.com>
In-Reply-To:
 <20240301-for-netnext-mt7530-improvements-3-v3-0-449f4f166454@arinc9.com>
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
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709289777; l=2923;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=Y7BEseLX82gaZsmn62yVWfr/R6XW4VPG+wedT6lFZoQ=;
 b=L4aHWuOWf1yvKF7VB/JxV7BDpvvS36FtQzN+PMdGKvt6UIjX322sQ/GarUAxd1MI8GLvYc0O5
 aozuo9vZWBDBddKZfOJSl0TvmiL0dgVUyoN6l+k4rtsFreNURKRyCTJ
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront with auth_id=137
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

From: Arınç ÜNAL <arinc.unal@arinc9.com>

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

The bit for setting the port on force mode is already done on
mt7530_setup() and mt7531_setup_common(). So get rid of
PMCR_FORCE_MODE_ID() which helped determine which bit to use for the switch
model.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 12 +-----------
 drivers/net/dsa/mt7530.h |  2 --
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 91d927bb49f7..1ae11b180d54 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2667,23 +2667,13 @@ mt753x_phylink_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
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


