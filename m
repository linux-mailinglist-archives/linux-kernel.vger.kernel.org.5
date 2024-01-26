Return-Path: <linux-kernel+bounces-40508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2524983E1C1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2779B1C22BD2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE3F2554E;
	Fri, 26 Jan 2024 18:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="K1cY11S1"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7399A219F6;
	Fri, 26 Jan 2024 18:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706294348; cv=none; b=mBI3rgeIv4lwy9/yWzMoha1bcV28TfMrxFRyzF3cejZZjbZ9/sG3oi0q7QLPTngdVoD7LzOO9ea0wjoFy2Lfon2eI9kY3MgsXQD+ECGQS5mqOu6Ro+5FUQ30uZjAnP1nxcc2uaYNwmUBMQLFWWEPPm9aGfNTuOhSbm2Sf1zYMC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706294348; c=relaxed/simple;
	bh=CofSQsjewpyFb8w9CmMhlBzYF5E9Mw5U3FybyDlHT+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WgTZOZTghHZCIKqEcQ7w/iUBEg4S2qkG4S6/e/vEI5RuvW9AIYkPeWfibN1LjKWT2wp3REuObOJnOEUOGLsJrylBAAYPH5x/Wi/99UnuwDOk0adj757m5GIiaOBLgaEAaXyPhM/H6XVT7/TvwjC1EZWy94GVZF8MOtATmEiZ6V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=K1cY11S1; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C9373FF808;
	Fri, 26 Jan 2024 18:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706294338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6TtLjJtA9OfPwNx2FGXMuOf3z4KyBrlFotwFfAaPqco=;
	b=K1cY11S1LCxC5G46CGRQyozhhKRbQ/S6Hb9JnnSIzPuXQL4Dhhe25/IK1kBCCOBFaIWIFX
	+P7jvktqbO8JIekdC7yqawYXEX+j3SzcEupxEtp/llxi/AHAb38W6v1MZGIhTRI+QAXI2w
	4m0kosYqp8xbKNKzRfmgEUjBHeAJmX1c6/nkl88R4PSqVgUHy1Bm81xFv/NYjU0FduwQ/2
	RtH/5JZgAgc2eqPsQrYlrAAEEdSCR5arwa4+Ekgd2sytTmq5J/cZn/AOR5eIYh6alr2FN2
	NobKjE1Pz699taqyoiROcaZVq118iAyn7DNeVj7813IxglfOAafUDTY65Q16jA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v6 03/13] net: phy: add helpers to handle sfp phy connect/disconnect
Date: Fri, 26 Jan 2024 19:38:40 +0100
Message-ID: <20240126183851.2081418-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126183851.2081418-1-maxime.chevallier@bootlin.com>
References: <20240126183851.2081418-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

There are a few PHY drivers that can handle SFP modules through their
sfp_upstream_ops. Introduce Phylib helpers to keep track of connected
SFP PHYs in a netdevice's namespace, by adding the SFP PHY to the
upstream PHY's netdev's namespace.

By doing so, these SFP PHYs can be enumerated and exposed to users,
which will be able to use their capabilities.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V6: Moved phy_get_link_topology() definition to this patch
V5: No Changes
V4: Rebased the at803x part with the newer version on net-next
V3: Renaming
V2: Renaming

 drivers/net/phy/at803x.c          |  2 ++
 drivers/net/phy/marvell-88x2222.c |  2 ++
 drivers/net/phy/marvell.c         |  2 ++
 drivers/net/phy/marvell10g.c      |  2 ++
 drivers/net/phy/phy_device.c      | 48 +++++++++++++++++++++++++++++++
 include/linux/phy.h               |  2 ++
 6 files changed, 58 insertions(+)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index a62442a55774..2f50170738f3 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -1475,6 +1475,8 @@ static const struct sfp_upstream_ops at8031_sfp_ops = {
 	.attach = phy_sfp_attach,
 	.detach = phy_sfp_detach,
 	.module_insert = at8031_sfp_insert,
+	.connect_phy = phy_sfp_connect_phy,
+	.disconnect_phy = phy_sfp_disconnect_phy,
 };
 
 static int at8031_parse_dt(struct phy_device *phydev)
diff --git a/drivers/net/phy/marvell-88x2222.c b/drivers/net/phy/marvell-88x2222.c
index e3aa30dad2e6..3f77bbc7e04f 100644
--- a/drivers/net/phy/marvell-88x2222.c
+++ b/drivers/net/phy/marvell-88x2222.c
@@ -555,6 +555,8 @@ static const struct sfp_upstream_ops sfp_phy_ops = {
 	.link_down = mv2222_sfp_link_down,
 	.attach = phy_sfp_attach,
 	.detach = phy_sfp_detach,
+	.connect_phy = phy_sfp_connect_phy,
+	.disconnect_phy = phy_sfp_disconnect_phy,
 };
 
 static int mv2222_probe(struct phy_device *phydev)
diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index eba652a4c1d8..674e29bce2cc 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -3254,6 +3254,8 @@ static const struct sfp_upstream_ops m88e1510_sfp_ops = {
 	.module_remove = m88e1510_sfp_remove,
 	.attach = phy_sfp_attach,
 	.detach = phy_sfp_detach,
+	.connect_phy = phy_sfp_connect_phy,
+	.disconnect_phy = phy_sfp_disconnect_phy,
 };
 
 static int m88e1510_probe(struct phy_device *phydev)
diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index ad43e280930c..6642eb642d4b 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -503,6 +503,8 @@ static int mv3310_sfp_insert(void *upstream, const struct sfp_eeprom_id *id)
 static const struct sfp_upstream_ops mv3310_sfp_ops = {
 	.attach = phy_sfp_attach,
 	.detach = phy_sfp_detach,
+	.connect_phy = phy_sfp_connect_phy,
+	.disconnect_phy = phy_sfp_disconnect_phy,
 	.module_insert = mv3310_sfp_insert,
 };
 
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 9385a4ee9380..436c7b62d5be 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -266,6 +266,14 @@ static void phy_mdio_device_remove(struct mdio_device *mdiodev)
 
 static struct phy_driver genphy_driver;
 
+static struct phy_link_topology *phy_get_link_topology(struct phy_device *phydev)
+{
+	if (phydev->attached_dev)
+		return phydev->attached_dev->link_topo;
+
+	return NULL;
+}
+
 static LIST_HEAD(phy_fixup_list);
 static DEFINE_MUTEX(phy_fixup_lock);
 
@@ -1355,6 +1363,46 @@ phy_standalone_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(phy_standalone);
 
+/**
+ * phy_sfp_connect_phy - Connect the SFP module's PHY to the upstream PHY
+ * @upstream: pointer to the upstream phy device
+ * @phy: pointer to the SFP module's phy device
+ *
+ * This helper allows keeping track of PHY devices on the link. It adds the
+ * SFP module's phy to the phy namespace of the upstream phy
+ */
+int phy_sfp_connect_phy(void *upstream, struct phy_device *phy)
+{
+	struct phy_device *phydev = upstream;
+	struct phy_link_topology *topo = phy_get_link_topology(phydev);
+
+	if (topo)
+		return phy_link_topo_add_phy(topo, phy, PHY_UPSTREAM_PHY, phydev);
+
+	return 0;
+}
+EXPORT_SYMBOL(phy_sfp_connect_phy);
+
+/**
+ * phy_sfp_disconnect_phy - Disconnect the SFP module's PHY from the upstream PHY
+ * @upstream: pointer to the upstream phy device
+ * @phy: pointer to the SFP module's phy device
+ *
+ * This helper allows keeping track of PHY devices on the link. It removes the
+ * SFP module's phy to the phy namespace of the upstream phy. As the module phy
+ * will be destroyed, re-inserting the same module will add a new phy with a
+ * new index.
+ */
+void phy_sfp_disconnect_phy(void *upstream, struct phy_device *phy)
+{
+	struct phy_device *phydev = upstream;
+	struct phy_link_topology *topo = phy_get_link_topology(phydev);
+
+	if (topo)
+		phy_link_topo_del_phy(topo, phy);
+}
+EXPORT_SYMBOL(phy_sfp_disconnect_phy);
+
 /**
  * phy_sfp_attach - attach the SFP bus to the PHY upstream network device
  * @upstream: pointer to the phy device
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 78647b5e0c13..3637bdfc1166 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1725,6 +1725,8 @@ int phy_suspend(struct phy_device *phydev);
 int phy_resume(struct phy_device *phydev);
 int __phy_resume(struct phy_device *phydev);
 int phy_loopback(struct phy_device *phydev, bool enable);
+int phy_sfp_connect_phy(void *upstream, struct phy_device *phy);
+void phy_sfp_disconnect_phy(void *upstream, struct phy_device *phy);
 void phy_sfp_attach(void *upstream, struct sfp_bus *bus);
 void phy_sfp_detach(void *upstream, struct sfp_bus *bus);
 int phy_sfp_probe(struct phy_device *phydev,
-- 
2.43.0


