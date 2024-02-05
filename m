Return-Path: <linux-kernel+bounces-54005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7A584A90D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC1F1F2D506
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB2D50260;
	Mon,  5 Feb 2024 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bd+oM3BE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CEA4F1F9;
	Mon,  5 Feb 2024 22:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707170895; cv=none; b=ViROH1hKPrzq89FI7KRr1DllijA3r2fFjF/tn1evRe9IzWYqzmfP6jt346BdvuNYq6Pc6ruSduXHNEWvZI1RA2do05E9+V/BtaE+4HAyltcbCVoHInn0c+hqMaVhJq9sUQUBfgf2MQUflarHLSuEGZFEbDhSHBmFgBG2DEPM6zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707170895; c=relaxed/simple;
	bh=Uf0g4Qb5P+7ZYHDQw51gFFMasfxBAhZ+RnpnJ/76axw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cZwezOYvVxcRRp/F7qvzlYwDzXWhQA8lFBWP6khx7/zqEYBwn2VTrzidFS+z0jfBy0JuQH5yfzamM1jArePpBL04I3D7lRy/CCtunIYva1kY9xtM3hqAPAccfImr7hxagF9LVi+yxfvAMDIid8CP4M0olo4Cc73XAIMH8rDcXEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bd+oM3BE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B892C433B2;
	Mon,  5 Feb 2024 22:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707170894;
	bh=Uf0g4Qb5P+7ZYHDQw51gFFMasfxBAhZ+RnpnJ/76axw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Bd+oM3BEixCJsKhTBAR5GXqMplR1bphEWeNhHdCXyS5A8XASusY9LxvjjUtTfdHj6
	 E8IyCe00OKf9k0X+i2UUnXXt8WK1aGIes1dVdqwC6dcmSY47LHd1AwFenhTiBadpNu
	 4k6rtpCAMBH2e9Fz6/wnCq36dX3SSpUm/kurTqtlzhTZfgl0xKpa9OLVrWLnyNE7yH
	 irkkdwISXnuXb8zdUim8PlqHhpa2sK8BmwFLeAQuhSQYbMQWeREMQ7MqYrWS+gFD3h
	 6bx+TB1Rh7wWpDLe8kd6PZcesn6s/y5EAWFgmvWwRyCQdFjXh26aA6I+7fa4ZOR1SL
	 GcKL5iba1diaw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650B4C4828D;
	Mon,  5 Feb 2024 22:08:14 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Tue, 06 Feb 2024 01:08:05 +0300
Subject: [PATCH net-next v5 4/7] net: dsa: mt7530: call port 6 setup from
 mt7530_mac_config()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id:
 <20240206-for-netnext-mt7530-improvements-2-v5-4-d7d92a185cb1@arinc9.com>
References:
 <20240206-for-netnext-mt7530-improvements-2-v5-0-d7d92a185cb1@arinc9.com>
In-Reply-To:
 <20240206-for-netnext-mt7530-improvements-2-v5-0-d7d92a185cb1@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707170890; l=2979;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=UBXiDmUmgNDE85r+ztHOrUIfTqBEqvXKt7NAM/BM3UM=;
 b=00was5bGkw7O2xyflNXvpULDNK4uI/oAl8q+Mmi/ctA5y3Ph/OEFfbROXJXfjwuEmyP6KsWX3
 FFBAh3y1X7pDgElk6nb8ksdSHFwaF6EjB8dJPpMELsjcfmQBLt/UAwB
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

From: Arınç ÜNAL <arinc.unal@arinc9.com>

mt7530_pad_clk_setup() is called if port 6 is enabled. It used to do more
things than setting up port 6. That part was moved to more appropriate
locations, mt7530_setup() and mt7530_pll_setup().

Now that all it does is set up port 6, rename it to mt7530_setup_port6(),
and move it to a more appropriate location, under mt7530_mac_config().

Change mt7530_setup_port6() to void as there're no error cases.

Leave an empty mt7530_pad_clk_setup() to satisfy the pad_setup function
pointer.

This is the code path for setting up the ports before:

dsa_switch_ops :: phylink_mac_config() -> mt753x_phylink_mac_config()
-> mt753x_mac_config()
   -> mt753x_info :: mac_port_config() -> mt7530_mac_config()
      -> mt7530_setup_port5()
-> mt753x_pad_setup()
   -> mt753x_info :: pad_setup() -> mt7530_pad_clk_setup()

This is after:

dsa_switch_ops :: phylink_mac_config() -> mt753x_phylink_mac_config()
-> mt753x_mac_config()
   -> mt753x_info :: mac_port_config() -> mt7530_mac_config()
      -> mt7530_setup_port5()
      -> mt7530_setup_port6()

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index e13b9c9cb19f..65c2f5f275a3 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -414,8 +414,8 @@ mt753x_preferred_default_local_cpu_port(struct dsa_switch *ds)
 }
 
 /* Setup port 6 interface mode and TRGMII TX circuit */
-static int
-mt7530_pad_clk_setup(struct dsa_switch *ds, phy_interface_t interface)
+static void
+mt7530_setup_port6(struct dsa_switch *ds, phy_interface_t interface)
 {
 	struct mt7530_priv *priv = ds->priv;
 	u32 ncpo1, ssc_delta, xtal;
@@ -426,7 +426,7 @@ mt7530_pad_clk_setup(struct dsa_switch *ds, phy_interface_t interface)
 	if (interface == PHY_INTERFACE_MODE_RGMII) {
 		mt7530_rmw(priv, MT7530_P6ECR, P6_INTF_MODE_MASK,
 			   P6_INTF_MODE(0));
-		return 0;
+		return;
 	}
 
 	mt7530_rmw(priv, MT7530_P6ECR, P6_INTF_MODE_MASK, P6_INTF_MODE(1));
@@ -465,7 +465,11 @@ mt7530_pad_clk_setup(struct dsa_switch *ds, phy_interface_t interface)
 
 	/* Enable the MT7530 TRGMII clocks */
 	core_set(priv, CORE_TRGMII_GSW_CLK_CG, REG_TRGMIICK_EN);
+}
 
+static int
+mt7530_pad_clk_setup(struct dsa_switch *ds, phy_interface_t interface)
+{
 	return 0;
 }
 
@@ -2613,11 +2617,10 @@ mt7530_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 {
 	struct mt7530_priv *priv = ds->priv;
 
-	/* Only need to setup port5. */
-	if (port != 5)
-		return 0;
-
-	mt7530_setup_port5(priv->ds, interface);
+	if (port == 5)
+		mt7530_setup_port5(priv->ds, interface);
+	else if (port == 6)
+		mt7530_setup_port6(priv->ds, interface);
 
 	return 0;
 }

-- 
2.40.1


