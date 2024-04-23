Return-Path: <linux-kernel+bounces-155754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48D68AF6A9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7975BB244A4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A161411FE;
	Tue, 23 Apr 2024 18:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="jmXtYAl8"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47DF28DC9;
	Tue, 23 Apr 2024 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713897229; cv=none; b=UXi+wV5doc/CHD1iXAue/khy7q2iItFjgUrYqPjARk76VogQelohLYqkTVbJQ+HZSMv4S41lUWCoh/HWM5fdq/3fvi879Ea82qVP5DyWdHsrwB6cPY8db/fBIA0tGW53VtUpkngJO+0SXsKOxJdXDRoSahnMMtKK3CN+251SdWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713897229; c=relaxed/simple;
	bh=2RgbMZJTXx6wWtzezoSyloI2BXtL889JrErm1lkgkiE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jQnt7Ab98oQAaE8Ljt0mjijiQKXxSaaSSExv858aSrQGquRnFwfcJ77GB97RcIn1wFCIM/PUkBzzzgP5YVBVSYJvKrlll8b8zmP+J7Cdhv5wf+FU3P3EvQ/fm7tPf9zLYYIb5Ph+3SSDXDaClTxLkP/p/YD6gXuX+d1pzcZOoRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=jmXtYAl8; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id D8434C00281F;
	Tue, 23 Apr 2024 11:33:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com D8434C00281F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1713897221;
	bh=2RgbMZJTXx6wWtzezoSyloI2BXtL889JrErm1lkgkiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jmXtYAl80Gmbei5Xdt2iElv4Qu5g4Xc8xTn9n+LTaZm8kwVKWS52jz9SOVK7RjrA7
	 +uD2RxfWko0iPRVauByjoweWPsMO5GAriESYaJll2duba3Q69UV6QV1WUMcEh0Vn14
	 9/aR2POpIgpoYWFdl9611CBd0ZB9kRLF9bt0ix2c=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 03ABF18041CAC8;
	Tue, 23 Apr 2024 11:33:40 -0700 (PDT)
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
Subject: [PATCH net-next 7/8] net: dsa: b53: Remove b53_adjust_link()
Date: Tue, 23 Apr 2024 11:33:38 -0700
Message-Id: <20240423183339.1368511-8-florian.fainelli@broadcom.com>
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

Only use the PHYLINK implementation from there on now that an equivalent
configuration is applied to all of the switch ports.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 40 --------------------------------
 1 file changed, 40 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index a4b50ee97f87..e490ef0fd3f1 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1332,45 +1332,6 @@ static void b53_adjust_5325_mii(struct dsa_switch *ds, int port)
 	}
 }
 
-static void b53_adjust_link(struct dsa_switch *ds, int port,
-			    struct phy_device *phydev)
-{
-	struct b53_device *dev = ds->priv;
-	struct ethtool_keee *p = &dev->ports[port].eee;
-	bool tx_pause = false;
-	bool rx_pause = false;
-
-	if (!phy_is_pseudo_fixed_link(phydev))
-		return;
-
-	/* Enable flow control on BCM5301x's CPU port */
-	if (is5301x(dev) && dsa_is_cpu_port(ds, port))
-		tx_pause = rx_pause = true;
-
-	if (phydev->pause) {
-		if (phydev->asym_pause)
-			tx_pause = true;
-		rx_pause = true;
-	}
-
-	b53_force_port_config(dev, port, phydev->speed, phydev->duplex,
-			      tx_pause, rx_pause);
-	b53_force_link(dev, port, phydev->link);
-
-	if (is63xx(dev) && port >= B53_63XX_RGMII0)
-		b53_adjust_63xx_rgmii(ds, port, phydev->interface);
-
-	if (is531x5(dev) && phy_interface_is_rgmii(phydev))
-		b53_adjust_531x5_rgmii(ds, port, phydev->interface);
-
-	/* configure MII port if necessary */
-	if (is5325(dev))
-		b53_adjust_5325_mii(ds, port);
-
-	/* Re-negotiate EEE if it was enabled already */
-	p->eee_enabled = b53_eee_init(ds, port, phydev);
-}
-
 void b53_port_event(struct dsa_switch *ds, int port)
 {
 	struct b53_device *dev = ds->priv;
@@ -2308,7 +2269,6 @@ static const struct dsa_switch_ops b53_switch_ops = {
 	.get_ethtool_phy_stats	= b53_get_ethtool_phy_stats,
 	.phy_read		= b53_phy_read16,
 	.phy_write		= b53_phy_write16,
-	.adjust_link		= b53_adjust_link,
 	.phylink_get_caps	= b53_phylink_get_caps,
 	.phylink_mac_select_pcs	= b53_phylink_mac_select_pcs,
 	.phylink_mac_config	= b53_phylink_mac_config,
-- 
2.34.1


