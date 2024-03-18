Return-Path: <linux-kernel+bounces-105782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F43987E446
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF91C1C20DFE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC842561D;
	Mon, 18 Mar 2024 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o96972pk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD02249F5;
	Mon, 18 Mar 2024 07:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710748029; cv=none; b=cHBExE1ZDpdd2IrHwodci79WTQ+Zw9U5x5S9/QbpqQMT1I8TAJCyV50Jlnuk3mj68la9ffiQniD9WNtIMI6QRJ34dUAQp4ahIXpcbTAMNa0JHzi5GNnuhMzzardEBKqajtu6W5nhZAvn4mG4BHQoYFYE/E+tpfExEbLKjE+yItI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710748029; c=relaxed/simple;
	bh=ITdv2pn5D4CqC5MwIs/6m1cR8j1oHZxQEiexAzXrA4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jHtTiLw44VwMriSsTV07S8v2DCNwxhMNI9wBdt7U5cl+GLskWKVnEgmK60IWLbVquwgjz/7qp0Yxqr7ZiKfttaDwU4P3kHh6x5Zv16oBefEVWpoglZDI+eoytmzT89s4Ey6kWWcnlweat8QPb4AWdwYktnW74nNioQLAUYm5abM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o96972pk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D36FAC43390;
	Mon, 18 Mar 2024 07:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710748028;
	bh=ITdv2pn5D4CqC5MwIs/6m1cR8j1oHZxQEiexAzXrA4A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=o96972pkM02lrb3svhmh8szqud514TtEC+38sYeWCJV2mtuzlFDo2wmYF797V8aHp
	 0i8dXkxLEHsVohyn46NBAgDMbKIMEANoajNUa/4X+BoeCAV5jMsIewUBqf4CdwlW/1
	 DFPC2B8g+iFXijPPURDbEpT2bBYkM6YV20w38vbLjuhAER/TGx7nBiHGOSvNYmkt/K
	 cKpVqyQ3ov8G/CICVx0rAjl07SnuUULiOqR9lEA8PBLDMotEpSVv1y/0iaQcEz20YT
	 4Box+xyVoPMlT5YhVhE6+lrERzQEsNU2HqslCQD2Xo05Cn8UK5Xds57CAigYXv0xzI
	 MAVRfy02OHHRw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23BEC54E58;
	Mon, 18 Mar 2024 07:47:08 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Mon, 18 Mar 2024 10:46:23 +0300
Subject: [PATCH 1/3] net: dsa: mt7530: fix enabling EEE on MT7531 switch on
 all boards
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: =?utf-8?q?=3C20240318-for-net-mt7530-fix-eee-for-mt7531-mt7988-v?=
 =?utf-8?q?1-1-3f17226344e8=40arinc9=2Ecom=3E?=
References: =?utf-8?q?=3C20240318-for-net-mt7530-fix-eee-for-mt7531-mt7988-v?=
 =?utf-8?q?1-0-3f17226344e8=40arinc9=2Ecom=3E?=
In-Reply-To: =?utf-8?q?=3C20240318-for-net-mt7530-fix-eee-for-mt7531-mt7988-?=
 =?utf-8?q?v1-0-3f17226344e8=40arinc9=2Ecom=3E?=
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
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710748010; l=2411;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=n6GBg3P0wOtkdb07AnyqLGs2kfHYSdBgEmtkDwKT6B8=;
 b=I2LmPwjiQmjqjwCuXvNT3y9Oy+74/n1FBJ1U/eAziVxdZ8NilIckTM/4zYde6k4K5Ari39+4m
 ZWJOVvadHrTCRVVdUIeNpsCFYJciXsPmNKj4nHEmpDy9B+jOl3NrFwy
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

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

The disable EEE bit on the trap pertains to the LAN2LED0 pin which is
usually used to control an LED. Once the bit is unset, the pin will be low.
That will make the active low LED turn on.

The pin is controlled by the switch PHY. It seems that the PHY controls the
pin in the way that it inverts the pin state. That means depending on the
wiring of the LED connected to LAN2LED0 on the board, the LED may be on
without an active link.

Fixes: 40b5d2f15c09 ("net: dsa: mt7530: Add support for EEE features")
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 7 +++++++
 drivers/net/dsa/mt7530.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 678b51f9cea6..d741d03969eb 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2458,6 +2458,13 @@ mt7531_setup(struct dsa_switch *ds)
 	/* Reset the switch through internal reset */
 	mt7530_write(priv, MT7530_SYS_CTRL, SYS_CTRL_SW_RST | SYS_CTRL_REG_RST);
 
+	/* Allow modifying the trap and enable Energy-Efficient Ethernet (EEE).
+	 */
+	val = mt7530_read(priv, MT7531_HWTRAP);
+	val |= CHG_STRAP;
+	val &= ~EEE_DIS;
+	mt7530_write(priv, MT7530_MHWTRAP, val);
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


