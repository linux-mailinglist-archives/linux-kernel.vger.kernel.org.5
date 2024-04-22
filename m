Return-Path: <linux-kernel+bounces-152850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA568AC543
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F821F21E7B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1BD56772;
	Mon, 22 Apr 2024 07:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9WxVARk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E344E1D2;
	Mon, 22 Apr 2024 07:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770131; cv=none; b=lXrELw2qPYj8J8lNAAeIXeG9bT7c22BkCARR4Q//r7hA7iCqplr/Nu4J8z0kM5/I3btlL8Uy4zKtWVPko0npmpu28SUwCnHt9KWlnk2p5BK2tWn7go7s+Q1CZzdh8CZdipM41xaPZT6ZZ8aAqv429lGv1AGGJngBwH5bWMnnQy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770131; c=relaxed/simple;
	bh=9aC2izf7pDmtSSitRHIY3XfQzKDzjBkTKbfmsq/v0JU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W/I3XIJrSaGZcELUkWXL0aYLi6yXjUq8KLOoFYVpDERVTXJ6zZGX42muFEU3pfzWk70fBJ1hOjj2f9GwDhqY/xfL1LPi0a51kNW6s4u05sLLOq31vTcPm51RZbGQlxj29SLHxTXrewT3Gw0iTr4/9MM8k4W1nmMe4dd8HoHBsJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9WxVARk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE97DC4AF0E;
	Mon, 22 Apr 2024 07:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713770130;
	bh=9aC2izf7pDmtSSitRHIY3XfQzKDzjBkTKbfmsq/v0JU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=H9WxVARkcobG5qCjw/w5KDIzb/Xd3HCkjFwNnc2HH0Du3MKbIB1r6DCmmKH8T1YF/
	 vmeFkc50JMD/fE11V+fhgLK7kb7QeJaCLwYGFInasYjoFTTtC+xBsqX/Pwq8IIToxu
	 komBQq8NSKfD2N4+QAxDAWirFznp3k7u+7/owW7A3mttXbsdYat3GO9lc2+VLgvyFu
	 CwJimmKOT/8CS7vs0qPFKh4LIjbGEmij5b8JVfICmzTd7etdX5slhctakzccLCuyam
	 D+ouXvuXayZf0gIMje9G/yKyAjiWmR4U6VkVewSCqwUrlQx1fAx8acPx35Y+sFDkky
	 leAylbsyPriKw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1815C10F15;
	Mon, 22 Apr 2024 07:15:30 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Mon, 22 Apr 2024 10:15:14 +0300
Subject: [PATCH net-next v2 07/15] net: dsa: mt7530: move MT753X_MTRAP
 operations for MT7530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240422-for-netnext-mt7530-improvements-4-v2-7-a75157ba76ad@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713770127; l=3575;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=00K+c7w7ciHtR3cg/Vn4V9kvHhcXqDMvGRmHgFwDD6g=;
 b=iAFOJTEc2IUg4VptNYrkdDzK0KVfHzl0nrENTzHB8iCUFHLNebhthKeg5Z+6OC0LCdPu7JSCk
 rk2or1CHHFGBgISZslZ4GGPnV+O1AEghI6aKNwLMmme+il+Vl1C0c2L
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

On MT7530, the media-independent interfaces of port 5 and 6 are controlled
by the MT7530_P5_DIS and MT7530_P6_DIS bits of the hardware trap. Deal with
these bits only when the relevant port is being enabled or disabled. This
ensures that these ports will be disabled when they are not in use.

Do not set MT7530_CHG_TRAP on mt7530_setup_port5() as that's already being
done on mt7530_setup().

Instead of globally setting MT7530_P5_MAC_SEL, clear it, then set it only
on the appropriate case.

If PHY muxing is detected, clear MT7530_P5_DIS before calling
mt7530_setup_port5().

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 606516206fb9..83436723cb16 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -880,8 +880,7 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
 
 	val = mt7530_read(priv, MT753X_MTRAP);
 
-	val |= MT7530_CHG_TRAP | MT7530_P5_MAC_SEL | MT7530_P5_DIS;
-	val &= ~MT7530_P5_RGMII_MODE & ~MT7530_P5_PHY0_SEL;
+	val &= ~MT7530_P5_PHY0_SEL & ~MT7530_P5_MAC_SEL & ~MT7530_P5_RGMII_MODE;
 
 	switch (priv->p5_mode) {
 	/* MUX_PHY_P0: P0 -> P5 -> SoC MAC */
@@ -891,15 +890,13 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
 
 	/* MUX_PHY_P4: P4 -> P5 -> SoC MAC */
 	case MUX_PHY_P4:
-		val &= ~MT7530_P5_MAC_SEL & ~MT7530_P5_DIS;
-
 		/* Setup the MAC by default for the cpu port */
 		mt7530_write(priv, MT753X_PMCR_P(5), 0x56300);
 		break;
 
 	/* GMAC5: P5 -> SoC MAC or external PHY */
 	default:
-		val &= ~MT7530_P5_DIS;
+		val |= MT7530_P5_MAC_SEL;
 		break;
 	}
 
@@ -1193,6 +1190,14 @@ mt7530_port_enable(struct dsa_switch *ds, int port,
 
 	mutex_unlock(&priv->reg_mutex);
 
+	if (priv->id != ID_MT7530 && priv->id != ID_MT7621)
+		return 0;
+
+	if (port == 5)
+		mt7530_clear(priv, MT753X_MTRAP, MT7530_P5_DIS);
+	else if (port == 6)
+		mt7530_clear(priv, MT753X_MTRAP, MT7530_P6_DIS);
+
 	return 0;
 }
 
@@ -1211,6 +1216,14 @@ mt7530_port_disable(struct dsa_switch *ds, int port)
 		   PCR_MATRIX_CLR);
 
 	mutex_unlock(&priv->reg_mutex);
+
+	if (priv->id != ID_MT7530 && priv->id != ID_MT7621)
+		return;
+
+	if (port == 5)
+		mt7530_set(priv, MT753X_MTRAP, MT7530_P5_DIS);
+	else if (port == 6)
+		mt7530_set(priv, MT753X_MTRAP, MT7530_P6_DIS);
 }
 
 static int
@@ -2401,11 +2414,11 @@ mt7530_setup(struct dsa_switch *ds)
 		mt7530_rmw(priv, MT7530_TRGMII_RD(i),
 			   RD_TAP_MASK, RD_TAP(16));
 
-	/* Enable port 6 */
-	val = mt7530_read(priv, MT753X_MTRAP);
-	val &= ~MT7530_P6_DIS & ~MT7530_PHY_INDIRECT_ACCESS;
-	val |= MT7530_CHG_TRAP;
-	mt7530_write(priv, MT753X_MTRAP, val);
+	/* Allow modifying the trap and directly access PHY registers via the
+	 * MDIO bus the switch is on.
+	 */
+	mt7530_rmw(priv, MT753X_MTRAP, MT7530_CHG_TRAP |
+		   MT7530_PHY_INDIRECT_ACCESS, MT7530_CHG_TRAP);
 
 	if ((val & MT7530_XTAL_MASK) == MT7530_XTAL_40MHZ)
 		mt7530_pll_setup(priv);
@@ -2488,8 +2501,11 @@ mt7530_setup(struct dsa_switch *ds)
 			break;
 		}
 
-		if (priv->p5_mode == MUX_PHY_P0 || priv->p5_mode == MUX_PHY_P4)
+		if (priv->p5_mode == MUX_PHY_P0 ||
+		    priv->p5_mode == MUX_PHY_P4) {
+			mt7530_clear(priv, MT753X_MTRAP, MT7530_P5_DIS);
 			mt7530_setup_port5(ds, interface);
+		}
 	}
 
 #ifdef CONFIG_GPIOLIB

-- 
2.40.1



