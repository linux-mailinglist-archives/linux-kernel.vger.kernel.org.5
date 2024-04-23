Return-Path: <linux-kernel+bounces-155758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD228AF6C2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E0C3B256C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF80113E8B8;
	Tue, 23 Apr 2024 18:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iA2ypVaD"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB47D23741;
	Tue, 23 Apr 2024 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713897735; cv=none; b=HKzJKDFDXNObJJZUF0/LvrLKSNtA6VsJoQuXUCEa9Qc3cI14/xc9LSC4ra6COC8DRWshMNDSaQiKeOwUWRDCAomF0TV4rSt7JRLdOryTdnV2h0imNmXlSpYCFeVbv78NIpdTU2mpVGP5uOJpLCIebEs7lbBWB4QFZIlFY3amcm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713897735; c=relaxed/simple;
	bh=4wCmUOm0XhENiAWT4g5nwDJ/9ACSGatVBuBMzSmBaqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pcQ6zJPIa8Yn9uVqi34LlOinwRoEUlM+xU0bcn4sOeN7S32HeD7vaPbj4rVDAGK+MQBLtpclR+WncKaNCymLaIHY3a80wD1HI4GFZ31IWgRbFaWTQ92yX9iXuAH/xWtUIBUT2noDKnsyDaBJbyntxWGW4ddq3S0XMrL4DCvFQGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iA2ypVaD; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 4510BC0049BD;
	Tue, 23 Apr 2024 11:33:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 4510BC0049BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1713897221;
	bh=4wCmUOm0XhENiAWT4g5nwDJ/9ACSGatVBuBMzSmBaqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iA2ypVaDTxQCRz/94GER6n/uGpnEXoC4NFukI6VeQrGjeL/qs7YJjxZfttSxwbNW+
	 1Go6kXj+xTtkds5pKyN2BN8gzStFrdNDSNLqHcXXiCG1Pcv4bVWmobvmv3DSCqBQAb
	 U0o5ynoAT1BMTXhmEJV5RBEGHLdkJomKGlE6Ni4U=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 663A518041CAC8;
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
Subject: [PATCH net-next 3/8] net: dsa: b53: Introduce b53_adjust_5325_mii()
Date: Tue, 23 Apr 2024 11:33:34 -0700
Message-Id: <20240423183339.1368511-4-florian.fainelli@broadcom.com>
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

Takes care of doing the 5325 switch series specific MII programming and
is called from b53_adjust_link() to allow the future removal of
b53_adjust_link().

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 44 ++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 744567c465f7..a127a17be11c 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1309,6 +1309,29 @@ static void b53_adjust_531x5_rgmii(struct dsa_switch *ds, int port,
 		 phy_modes(interface));
 }
 
+static void b53_adjust_5325_mii(struct dsa_switch *ds, int port)
+{
+	struct b53_device *dev = ds->priv;
+	u8 reg = 0;
+
+	b53_read8(dev, B53_CTRL_PAGE, B53_PORT_OVERRIDE_CTRL,
+		  &reg);
+
+	/* reverse mii needs to be enabled */
+	if (!(reg & PORT_OVERRIDE_RV_MII_25)) {
+		b53_write8(dev, B53_CTRL_PAGE, B53_PORT_OVERRIDE_CTRL,
+			   reg | PORT_OVERRIDE_RV_MII_25);
+		b53_read8(dev, B53_CTRL_PAGE, B53_PORT_OVERRIDE_CTRL,
+			  &reg);
+
+		if (!(reg & PORT_OVERRIDE_RV_MII_25)) {
+			dev_err(ds->dev,
+				"Failed to enable reverse MII mode\n");
+			return;
+		}
+	}
+}
+
 static void b53_adjust_link(struct dsa_switch *ds, int port,
 			    struct phy_device *phydev)
 {
@@ -1316,7 +1339,6 @@ static void b53_adjust_link(struct dsa_switch *ds, int port,
 	struct ethtool_keee *p = &dev->ports[port].eee;
 	bool tx_pause = false;
 	bool rx_pause = false;
-	u8 reg = 0;
 
 	if (!phy_is_pseudo_fixed_link(phydev))
 		return;
@@ -1342,24 +1364,8 @@ static void b53_adjust_link(struct dsa_switch *ds, int port,
 		b53_adjust_531x5_rgmii(ds, port, phydev->interface);
 
 	/* configure MII port if necessary */
-	if (is5325(dev)) {
-		b53_read8(dev, B53_CTRL_PAGE, B53_PORT_OVERRIDE_CTRL,
-			  &reg);
-
-		/* reverse mii needs to be enabled */
-		if (!(reg & PORT_OVERRIDE_RV_MII_25)) {
-			b53_write8(dev, B53_CTRL_PAGE, B53_PORT_OVERRIDE_CTRL,
-				   reg | PORT_OVERRIDE_RV_MII_25);
-			b53_read8(dev, B53_CTRL_PAGE, B53_PORT_OVERRIDE_CTRL,
-				  &reg);
-
-			if (!(reg & PORT_OVERRIDE_RV_MII_25)) {
-				dev_err(ds->dev,
-					"Failed to enable reverse MII mode\n");
-				return;
-			}
-		}
-	}
+	if (is5325(dev))
+		b53_adjust_5325_mii(ds, port);
 
 	/* Re-negotiate EEE if it was enabled already */
 	p->eee_enabled = b53_eee_init(ds, port, phydev);
-- 
2.34.1


