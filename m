Return-Path: <linux-kernel+bounces-152396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EAF8ABDD0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 02:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19811F214A2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 00:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5951843;
	Sun, 21 Apr 2024 00:08:55 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005B8161;
	Sun, 21 Apr 2024 00:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713658134; cv=none; b=GuLFA0TbA3CrWTvTA5mJDa97mwY/08f/rKX2atM21Ojrcd6ZuhSByun1ZHuRubGsOPcru5wC0AyyGpu7ZB4Oc/rYHZcp5GcqTqMs9yPLjCkguvn7ObjTf3dVy8j33+eKZ2EVHyzPnuYzjiXFXQG0j0vzAS/KtycWXDNGCZ1+xNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713658134; c=relaxed/simple;
	bh=SV1WNsuQUfWW8r3HygOyF2sEn+ZsPEZW3vRuzkIb1jU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jBj0wOMt3rTV1KKT675XvfJMA8z4tkZzWCz6i75O4zlz3FOy9DO31zApYRcC6RfqIfsv3VpeHUJYVxbC1apUszwcF4U12KVeuFDIGHHEnLujj+5bo8VdBkCsa1q4YK1rEHXnndioMrnSUpvjofhKGPSzJyx6CK2ZsBb+qVTlfgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1ryKl5-0000000045H-02wC;
	Sun, 21 Apr 2024 00:08:39 +0000
Date: Sun, 21 Apr 2024 01:08:31 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net] net: phy: mediatek-ge-soc: follow netdev LED trigger
 semantics
Message-ID: <4983a6b197ed999808c5690d01ec1ffb4f6407b7.1713656093.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Only blink if the link is up on a LED which is programmed to also
indicate link-status.

Otherwise, if both LEDs are in use to indicate different speeds, the
resulting blinking being inverted on LEDs which aren't switched on at
a specific speed is quite counter-intuitive.

Also make sure that state left behind by reset or the bootloader is
recognized correctly including the half-duplex and full-duplex bits as
well as the (unsupported by Linux netdev trigger semantics) link-down
bit.

Fixes: c66937b0f8db ("net: phy: mediatek-ge-soc: support PHY LEDs")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/mediatek-ge-soc.c | 43 +++++++++++++++++++------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/net/phy/mediatek-ge-soc.c b/drivers/net/phy/mediatek-ge-soc.c
index 0f3a1538a8b8..f4f9412d0cd7 100644
--- a/drivers/net/phy/mediatek-ge-soc.c
+++ b/drivers/net/phy/mediatek-ge-soc.c
@@ -216,6 +216,9 @@
 #define   MTK_PHY_LED_ON_LINK1000		BIT(0)
 #define   MTK_PHY_LED_ON_LINK100		BIT(1)
 #define   MTK_PHY_LED_ON_LINK10			BIT(2)
+#define   MTK_PHY_LED_ON_LINK			(MTK_PHY_LED_ON_LINK10 |\
+						 MTK_PHY_LED_ON_LINK100 |\
+						 MTK_PHY_LED_ON_LINK1000)
 #define   MTK_PHY_LED_ON_LINKDOWN		BIT(3)
 #define   MTK_PHY_LED_ON_FDX			BIT(4) /* Full duplex */
 #define   MTK_PHY_LED_ON_HDX			BIT(5) /* Half duplex */
@@ -231,6 +234,12 @@
 #define   MTK_PHY_LED_BLINK_100RX		BIT(3)
 #define   MTK_PHY_LED_BLINK_10TX		BIT(4)
 #define   MTK_PHY_LED_BLINK_10RX		BIT(5)
+#define   MTK_PHY_LED_BLINK_RX			(MTK_PHY_LED_BLINK_10RX |\
+						 MTK_PHY_LED_BLINK_100RX |\
+						 MTK_PHY_LED_BLINK_1000RX)
+#define   MTK_PHY_LED_BLINK_TX			(MTK_PHY_LED_BLINK_10TX |\
+						 MTK_PHY_LED_BLINK_100TX |\
+						 MTK_PHY_LED_BLINK_1000TX)
 #define   MTK_PHY_LED_BLINK_COLLISION		BIT(6)
 #define   MTK_PHY_LED_BLINK_RX_CRC_ERR		BIT(7)
 #define   MTK_PHY_LED_BLINK_RX_IDLE_ERR		BIT(8)
@@ -1247,11 +1256,9 @@ static int mt798x_phy_led_hw_control_get(struct phy_device *phydev, u8 index,
 	if (blink < 0)
 		return -EIO;
 
-	if ((on & (MTK_PHY_LED_ON_LINK1000 | MTK_PHY_LED_ON_LINK100 |
-		   MTK_PHY_LED_ON_LINK10)) ||
-	    (blink & (MTK_PHY_LED_BLINK_1000RX | MTK_PHY_LED_BLINK_100RX |
-		      MTK_PHY_LED_BLINK_10RX | MTK_PHY_LED_BLINK_1000TX |
-		      MTK_PHY_LED_BLINK_100TX | MTK_PHY_LED_BLINK_10TX)))
+	if ((on & (MTK_PHY_LED_ON_LINK | MTK_PHY_LED_ON_FDX | MTK_PHY_LED_ON_HDX |
+		   MTK_PHY_LED_ON_LINKDOWN)) ||
+	    (blink & (MTK_PHY_LED_BLINK_RX | MTK_PHY_LED_BLINK_TX)))
 		set_bit(bit_netdev, &priv->led_state);
 	else
 		clear_bit(bit_netdev, &priv->led_state);
@@ -1269,7 +1276,7 @@ static int mt798x_phy_led_hw_control_get(struct phy_device *phydev, u8 index,
 	if (!rules)
 		return 0;
 
-	if (on & (MTK_PHY_LED_ON_LINK1000 | MTK_PHY_LED_ON_LINK100 | MTK_PHY_LED_ON_LINK10))
+	if (on & MTK_PHY_LED_ON_LINK)
 		*rules |= BIT(TRIGGER_NETDEV_LINK);
 
 	if (on & MTK_PHY_LED_ON_LINK10)
@@ -1287,10 +1294,10 @@ static int mt798x_phy_led_hw_control_get(struct phy_device *phydev, u8 index,
 	if (on & MTK_PHY_LED_ON_HDX)
 		*rules |= BIT(TRIGGER_NETDEV_HALF_DUPLEX);
 
-	if (blink & (MTK_PHY_LED_BLINK_1000RX | MTK_PHY_LED_BLINK_100RX | MTK_PHY_LED_BLINK_10RX))
+	if (blink & MTK_PHY_LED_BLINK_RX)
 		*rules |= BIT(TRIGGER_NETDEV_RX);
 
-	if (blink & (MTK_PHY_LED_BLINK_1000TX | MTK_PHY_LED_BLINK_100TX | MTK_PHY_LED_BLINK_10TX))
+	if (blink & MTK_PHY_LED_BLINK_TX)
 		*rules |= BIT(TRIGGER_NETDEV_TX);
 
 	return 0;
@@ -1323,15 +1330,19 @@ static int mt798x_phy_led_hw_control_set(struct phy_device *phydev, u8 index,
 		on |= MTK_PHY_LED_ON_LINK1000;
 
 	if (rules & BIT(TRIGGER_NETDEV_RX)) {
-		blink |= MTK_PHY_LED_BLINK_10RX  |
-			 MTK_PHY_LED_BLINK_100RX |
-			 MTK_PHY_LED_BLINK_1000RX;
+		blink |= (on & MTK_PHY_LED_ON_LINK) ?
+			  (((on & MTK_PHY_LED_ON_LINK10) ? MTK_PHY_LED_BLINK_10RX : 0) |
+			   ((on & MTK_PHY_LED_ON_LINK100) ? MTK_PHY_LED_BLINK_100RX : 0) |
+			   ((on & MTK_PHY_LED_ON_LINK1000) ? MTK_PHY_LED_BLINK_1000RX : 0)) :
+			  MTK_PHY_LED_BLINK_RX;
 	}
 
 	if (rules & BIT(TRIGGER_NETDEV_TX)) {
-		blink |= MTK_PHY_LED_BLINK_10TX  |
-			 MTK_PHY_LED_BLINK_100TX |
-			 MTK_PHY_LED_BLINK_1000TX;
+		blink |= (on & MTK_PHY_LED_ON_LINK) ?
+			  (((on & MTK_PHY_LED_ON_LINK10) ? MTK_PHY_LED_BLINK_10TX : 0) |
+			   ((on & MTK_PHY_LED_ON_LINK100) ? MTK_PHY_LED_BLINK_100TX : 0) |
+			   ((on & MTK_PHY_LED_ON_LINK1000) ? MTK_PHY_LED_BLINK_1000TX : 0)) :
+			  MTK_PHY_LED_BLINK_TX;
 	}
 
 	if (blink || on)
@@ -1344,9 +1355,7 @@ static int mt798x_phy_led_hw_control_set(struct phy_device *phydev, u8 index,
 				MTK_PHY_LED0_ON_CTRL,
 			     MTK_PHY_LED_ON_FDX     |
 			     MTK_PHY_LED_ON_HDX     |
-			     MTK_PHY_LED_ON_LINK10  |
-			     MTK_PHY_LED_ON_LINK100 |
-			     MTK_PHY_LED_ON_LINK1000,
+			     MTK_PHY_LED_ON_LINK,
 			     on);
 
 	if (ret)
-- 
2.44.0


