Return-Path: <linux-kernel+bounces-151300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 690B08AAC98
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF7D1C21149
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EAC12D1E8;
	Fri, 19 Apr 2024 10:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8GDhT5i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D22B7F7C7;
	Fri, 19 Apr 2024 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713521378; cv=none; b=CsdvrPn24b12Wri4vAFz7lyHvH55gr4pFjfNP2CdamGNAbgGj/7eTbi547Nfw/5uT3ig8jA0EOufEv08VVivh1mHhS7iJrzVMVTTjyOkkslhbSngaig3ePYbp6tw1lIaRYDtJmL4vrCLMzvw0If4jmS5SLrXiq3+NC/6kmQ7O4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713521378; c=relaxed/simple;
	bh=9aC2izf7pDmtSSitRHIY3XfQzKDzjBkTKbfmsq/v0JU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ltIBmNzFnqy8+/BPlowPgBFFrdRvocp76eH4v/8TJViL/9HbZLyZR8dgbWSr9bqu4EZLOnSpROc9Ivls5wZuDphZkvAmU3NyDz+0k1HFjJZ4bKAOeQGKQ1axiZb3deaDH0YCKkxzEnDgN33sgpuorow2QZF64z75cvC5dDjoJJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8GDhT5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D40CEC4AF0A;
	Fri, 19 Apr 2024 10:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713521377;
	bh=9aC2izf7pDmtSSitRHIY3XfQzKDzjBkTKbfmsq/v0JU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=N8GDhT5iZg5kzgkwZtP3YEuxaF4E3iMqbumHLuCwvvdaxFO3mFuiIv7nUZxZV8450
	 A176TPrVQ+o/y4bqNG0/MfSPrZ/z4Y5J1quHYVe0XpnhSD2j9IePAR5/Az91I9g1nI
	 XvX8OGBlQx8gqZ0b8a//8M6WiOQAwzqjbYliszTe9ogD/SxtsQQxu+LYxQSVi+OOjE
	 h02BX2fUO4StBf8exKaDJikOzZvm+dnnGLC6cKbHsafTmy9sGm6DfDxcTWpucaYPPJ
	 gK9U+FoRGTYUj8SSaEo8XPaSGJghOqys+j2QmdewDhUlfWuvlUOn9ntpbXrlGyRhy7
	 WFvzoA4QBVE9Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC031C04FF6;
	Fri, 19 Apr 2024 10:09:37 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Fri, 19 Apr 2024 13:09:30 +0300
Subject: [PATCH net-next 07/13] net: dsa: mt7530: move MT753X_MTRAP
 operations for MT7530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240419-for-netnext-mt7530-improvements-4-v1-7-6d852ca79b1d@arinc9.com>
References: <20240419-for-netnext-mt7530-improvements-4-v1-0-6d852ca79b1d@arinc9.com>
In-Reply-To: <20240419-for-netnext-mt7530-improvements-4-v1-0-6d852ca79b1d@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713521374; l=3575;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=00K+c7w7ciHtR3cg/Vn4V9kvHhcXqDMvGRmHgFwDD6g=;
 b=D1+kXUJAtGNwzmHs5kYKJ5HJ23tyiDDh8eH4aG2XtQ5JyJpgadsmiAogJdOjaNYwdoa082TZO
 JLYAWJ8lOJtDejMzAyJ6Er0pkW6F8erqc68SUXVo8HRZoztqYlwhvmT
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



