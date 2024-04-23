Return-Path: <linux-kernel+bounces-155759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F108AF6C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2F828233E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2119813F437;
	Tue, 23 Apr 2024 18:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ogwTU74z"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4C4136989;
	Tue, 23 Apr 2024 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713897735; cv=none; b=oj+T1CPURxGW+kygQ3oc7XwBLCzAUlzchOSNiGHM1gFd8IXl0GA2vB2PARVrQWx9GHkC6UyVx/uneX3k/ei0mBpS010gVPAj1WqVLEgi8QLWyOrdYtgtBl7VHffAaCKCFJmItK8ScgbS8K9imTOFTKyJPe2gNVVJcLrclEhaIwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713897735; c=relaxed/simple;
	bh=sErawwCYvUHt0YL4Bze2yqUWXOhsq1yzz/3NhImhAnw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GO9/9LB755/PRobvVfBM6X+OK/b1iz69FSAPe9jkR/gEEoXVQ8/kJsyXTSKZ2gZlK0zJfht+uBggauZKGdPtjPhv6Hm3TY57F9Edi48UY/hBBFH9PXuUjSDjQDZv3X74oqtfMluVMZ1lo3yPhH0Z5UGv3yUuvnfj+8usIp2v/6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ogwTU74z; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 1F244C0049BB;
	Tue, 23 Apr 2024 11:33:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 1F244C0049BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1713897221;
	bh=sErawwCYvUHt0YL4Bze2yqUWXOhsq1yzz/3NhImhAnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ogwTU74zlzGTjH/CcZyypXFgz5gJpWmuWxCY86v1S/fbzF3UPQnYi99Bnt/D8ZweQ
	 8Rs6EUSuEz4z9G0FhMNwk0Ana4KD5968IBI7bgcEydcNwxnmxYVq+kiOngxzmllUhm
	 q4YuOe9CZWuGO32oyobEq091+ysPqTp/GZDp8mqY=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 41C5518041CAC7;
	Tue, 23 Apr 2024 11:33:39 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 2/8] net: dsa: b53: Introduce b53_adjust_531x5_rgmii()
Date: Tue, 23 Apr 2024 11:33:33 -0700
Message-Id: <20240423183339.1368511-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423183339.1368511-1-florian.fainelli@broadcom.com>
References: <20240423183339.1368511-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Takes care of doing the 531x5 switch series specific RGMII programming
and is called from b53_adjust_link() to allow the future removal of
b53_adjust_link().

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 84 +++++++++++++++++---------------
 1 file changed, 46 insertions(+), 38 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index bd069439549f..744567c465f7 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1266,14 +1266,57 @@ static void b53_adjust_63xx_rgmii(struct dsa_switch *ds, int port,
 		phy_modes(interface));
 }
 
+static void b53_adjust_531x5_rgmii(struct dsa_switch *ds, int port,
+				   phy_interface_t interface)
+{
+	struct b53_device *dev = ds->priv;
+	u8 rgmii_ctrl = 0, off;
+
+	if (port == dev->imp_port)
+		off = B53_RGMII_CTRL_IMP;
+	else
+		off = B53_RGMII_CTRL_P(port);
+
+	/* Configure the port RGMII clock delay by DLL disabled and
+	 * tx_clk aligned timing (restoring to reset defaults)
+	 */
+	b53_read8(dev, B53_CTRL_PAGE, off, &rgmii_ctrl);
+	rgmii_ctrl &= ~(RGMII_CTRL_DLL_RXC | RGMII_CTRL_DLL_TXC |
+			RGMII_CTRL_TIMING_SEL);
+
+	/* PHY_INTERFACE_MODE_RGMII_TXID means TX internal delay, make
+	 * sure that we enable the port TX clock internal delay to
+	 * account for this internal delay that is inserted, otherwise
+	 * the switch won't be able to receive correctly.
+	 *
+	 * PHY_INTERFACE_MODE_RGMII means that we are not introducing
+	 * any delay neither on transmission nor reception, so the
+	 * BCM53125 must also be configured accordingly to account for
+	 * the lack of delay and introduce
+	 *
+	 * The BCM53125 switch has its RX clock and TX clock control
+	 * swapped, hence the reason why we modify the TX clock path in
+	 * the "RGMII" case
+	 */
+	if (interface == PHY_INTERFACE_MODE_RGMII_TXID)
+		rgmii_ctrl |= RGMII_CTRL_DLL_TXC;
+	if (interface == PHY_INTERFACE_MODE_RGMII)
+		rgmii_ctrl |= RGMII_CTRL_DLL_TXC | RGMII_CTRL_DLL_RXC;
+	rgmii_ctrl |= RGMII_CTRL_TIMING_SEL;
+	b53_write8(dev, B53_CTRL_PAGE, off, rgmii_ctrl);
+
+	dev_info(ds->dev, "Configured port %d for %s\n", port,
+		 phy_modes(interface));
+}
+
 static void b53_adjust_link(struct dsa_switch *ds, int port,
 			    struct phy_device *phydev)
 {
 	struct b53_device *dev = ds->priv;
 	struct ethtool_keee *p = &dev->ports[port].eee;
-	u8 rgmii_ctrl = 0, reg = 0, off;
 	bool tx_pause = false;
 	bool rx_pause = false;
+	u8 reg = 0;
 
 	if (!phy_is_pseudo_fixed_link(phydev))
 		return;
@@ -1295,43 +1338,8 @@ static void b53_adjust_link(struct dsa_switch *ds, int port,
 	if (is63xx(dev) && port >= B53_63XX_RGMII0)
 		b53_adjust_63xx_rgmii(ds, port, phydev->interface);
 
-	if (is531x5(dev) && phy_interface_is_rgmii(phydev)) {
-		if (port == dev->imp_port)
-			off = B53_RGMII_CTRL_IMP;
-		else
-			off = B53_RGMII_CTRL_P(port);
-
-		/* Configure the port RGMII clock delay by DLL disabled and
-		 * tx_clk aligned timing (restoring to reset defaults)
-		 */
-		b53_read8(dev, B53_CTRL_PAGE, off, &rgmii_ctrl);
-		rgmii_ctrl &= ~(RGMII_CTRL_DLL_RXC | RGMII_CTRL_DLL_TXC |
-				RGMII_CTRL_TIMING_SEL);
-
-		/* PHY_INTERFACE_MODE_RGMII_TXID means TX internal delay, make
-		 * sure that we enable the port TX clock internal delay to
-		 * account for this internal delay that is inserted, otherwise
-		 * the switch won't be able to receive correctly.
-		 *
-		 * PHY_INTERFACE_MODE_RGMII means that we are not introducing
-		 * any delay neither on transmission nor reception, so the
-		 * BCM53125 must also be configured accordingly to account for
-		 * the lack of delay and introduce
-		 *
-		 * The BCM53125 switch has its RX clock and TX clock control
-		 * swapped, hence the reason why we modify the TX clock path in
-		 * the "RGMII" case
-		 */
-		if (phydev->interface == PHY_INTERFACE_MODE_RGMII_TXID)
-			rgmii_ctrl |= RGMII_CTRL_DLL_TXC;
-		if (phydev->interface == PHY_INTERFACE_MODE_RGMII)
-			rgmii_ctrl |= RGMII_CTRL_DLL_TXC | RGMII_CTRL_DLL_RXC;
-		rgmii_ctrl |= RGMII_CTRL_TIMING_SEL;
-		b53_write8(dev, B53_CTRL_PAGE, off, rgmii_ctrl);
-
-		dev_info(ds->dev, "Configured port %d for %s\n", port,
-			 phy_modes(phydev->interface));
-	}
+	if (is531x5(dev) && phy_interface_is_rgmii(phydev))
+		b53_adjust_531x5_rgmii(ds, port, phydev->interface);
 
 	/* configure MII port if necessary */
 	if (is5325(dev)) {
-- 
2.34.1


