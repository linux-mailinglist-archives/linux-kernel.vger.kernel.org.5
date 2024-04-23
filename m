Return-Path: <linux-kernel+bounces-155755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A368AF6AC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D280E28CAFB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CF6143862;
	Tue, 23 Apr 2024 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Df0U+Pwq"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F572AD2C;
	Tue, 23 Apr 2024 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713897229; cv=none; b=YmDijZE75fdSpQVZcOTO/pQzD5gM05ZRYrT5HqxQw8lDHgxeR6h9kFPRXeKS0/7n22UTKlNdyYZ/RhdHWne4QquIbyAS7pR/3dGc8kvZr3kJh5K5LBN3dQVz3WvW1kArS/Bpb2TVHgOC0kdisV+VfGlOObxlH9JLUWaAKp5uSk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713897229; c=relaxed/simple;
	bh=c/Ah+ocoUmfGe7UtUQ0MIQIvcS0fCgxsUc5y7Y2Hzns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nVvr60mDpmvvRKy3Z6AZk8Loq+0FNhmvBY8+gOqHJo/5o3KK7zFUkCZRT2Q9COnaVI1VRT8p+lgYpxeUHn6n3iWxZgKbd18lFeRWXeAKVSvLb9qRX1qChvtWub9mLApkeWkXNJuKNK72zrU/CT7Gx8WhKKo0+mxlF6jZ1IELxC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Df0U+Pwq; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 05FC0C002821;
	Tue, 23 Apr 2024 11:33:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 05FC0C002821
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1713897222;
	bh=c/Ah+ocoUmfGe7UtUQ0MIQIvcS0fCgxsUc5y7Y2Hzns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Df0U+PwqGWnGL6cz/LQi8FCGT4wMjX+C5bztz1J7ErXLmQiZEXlE967SpLHWGGKD5
	 7fF5HkIpDEt5gP5eUmPbyIJZC1Hnx640btl9YpitkpoOe1BZ/jz50QjO1kGdX5Dp34
	 MIJsgBh25ttg2sTd3FNoS1Vlh3DSKOzHGKM3be2Q=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 29CE318041CAC4;
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
Subject: [PATCH net-next 8/8] net: dsa: b53: provide own phylink MAC operations
Date: Tue, 23 Apr 2024 11:33:39 -0700
Message-Id: <20240423183339.1368511-9-florian.fainelli@broadcom.com>
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

Convert b53 to provide its own phylink MAC operations, thus avoiding the
shim layer in DSA's port.c

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 40 +++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index e490ef0fd3f1..8f50abe739b7 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1383,24 +1383,27 @@ static void b53_phylink_get_caps(struct dsa_switch *ds, int port,
 		dev->ops->phylink_get_caps(dev, port, config);
 }
 
-static struct phylink_pcs *b53_phylink_mac_select_pcs(struct dsa_switch *ds,
-						      int port,
+static struct phylink_pcs *b53_phylink_mac_select_pcs(struct phylink_config *config,
 						      phy_interface_t interface)
 {
-	struct b53_device *dev = ds->priv;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct b53_device *dev = dp->ds->priv;
 
 	if (!dev->ops->phylink_mac_select_pcs)
 		return NULL;
 
-	return dev->ops->phylink_mac_select_pcs(dev, port, interface);
+	return dev->ops->phylink_mac_select_pcs(dev, dp->index, interface);
 }
 
-static void b53_phylink_mac_config(struct dsa_switch *ds, int port,
+static void b53_phylink_mac_config(struct phylink_config *config,
 				   unsigned int mode,
 				   const struct phylink_link_state *state)
 {
+	struct dsa_port *dp = dsa_phylink_to_port(config);
 	phy_interface_t interface = state->interface;
+	struct dsa_switch *ds = dp->ds;
 	struct b53_device *dev = ds->priv;
+	int port = dp->index;
 
 	if (is63xx(dev) && port >= B53_63XX_RGMII0)
 		b53_adjust_63xx_rgmii(ds, port, interface);
@@ -1415,11 +1418,13 @@ static void b53_phylink_mac_config(struct dsa_switch *ds, int port,
 	}
 }
 
-static void b53_phylink_mac_link_down(struct dsa_switch *ds, int port,
+static void b53_phylink_mac_link_down(struct phylink_config *config,
 				      unsigned int mode,
 				      phy_interface_t interface)
 {
-	struct b53_device *dev = ds->priv;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct b53_device *dev = dp->ds->priv;
+	int port = dp->index;
 
 	if (mode == MLO_AN_PHY)
 		return;
@@ -1434,15 +1439,18 @@ static void b53_phylink_mac_link_down(struct dsa_switch *ds, int port,
 		dev->ops->serdes_link_set(dev, port, mode, interface, false);
 }
 
-static void b53_phylink_mac_link_up(struct dsa_switch *ds, int port,
+static void b53_phylink_mac_link_up(struct phylink_config *config,
+				    struct phy_device *phydev,
 				    unsigned int mode,
 				    phy_interface_t interface,
-				    struct phy_device *phydev,
 				    int speed, int duplex,
 				    bool tx_pause, bool rx_pause)
 {
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct dsa_switch *ds = dp->ds;
 	struct b53_device *dev = ds->priv;
-	struct ethtool_keee *p = &dev->ports[port].eee;
+	struct ethtool_keee *p = &dev->ports[dp->index].eee;
+	int port = dp->index;
 
 	if (mode == MLO_AN_PHY) {
 		/* Re-negotiate EEE if it was enabled already */
@@ -2259,6 +2267,13 @@ static int b53_get_max_mtu(struct dsa_switch *ds, int port)
 	return JMS_MAX_SIZE;
 }
 
+static const struct phylink_mac_ops b53_phylink_mac_ops = {
+	.mac_select_pcs	= b53_phylink_mac_select_pcs,
+	.mac_config	= b53_phylink_mac_config,
+	.mac_link_down	= b53_phylink_mac_link_down,
+	.mac_link_up	= b53_phylink_mac_link_up,
+};
+
 static const struct dsa_switch_ops b53_switch_ops = {
 	.get_tag_protocol	= b53_get_tag_protocol,
 	.setup			= b53_setup,
@@ -2270,10 +2285,6 @@ static const struct dsa_switch_ops b53_switch_ops = {
 	.phy_read		= b53_phy_read16,
 	.phy_write		= b53_phy_write16,
 	.phylink_get_caps	= b53_phylink_get_caps,
-	.phylink_mac_select_pcs	= b53_phylink_mac_select_pcs,
-	.phylink_mac_config	= b53_phylink_mac_config,
-	.phylink_mac_link_down	= b53_phylink_mac_link_down,
-	.phylink_mac_link_up	= b53_phylink_mac_link_up,
 	.port_enable		= b53_enable_port,
 	.port_disable		= b53_disable_port,
 	.get_mac_eee		= b53_get_mac_eee,
@@ -2716,6 +2727,7 @@ struct b53_device *b53_switch_alloc(struct device *base,
 	dev->priv = priv;
 	dev->ops = ops;
 	ds->ops = &b53_switch_ops;
+	ds->phylink_mac_ops = &b53_phylink_mac_ops;
 	dev->vlan_enabled = true;
 	/* Let DSA handle the case were multiple bridges span the same switch
 	 * device and different VLAN awareness settings are requested, which
-- 
2.34.1


