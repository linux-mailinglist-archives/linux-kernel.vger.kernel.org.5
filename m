Return-Path: <linux-kernel+bounces-73528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C1185C3C7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B2641C224CA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40D514A0B7;
	Tue, 20 Feb 2024 18:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OofyyqEP"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428E37602B;
	Tue, 20 Feb 2024 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708454550; cv=none; b=HRv9FdoryiXPEN9OCtntGEjTzcfMY7lnnTzgIwM7xnJTS26Clir4iDj8GGlgVo5y6J7ETaiwWozEd/yG2COfHARtmMWWTOTqYbZhKtDfAv+4zv4SRs//3ZDeWg8vEqvP2c6+KVz8syfh/Sygt5L4ZUitVqI2biHk4vfqDeNm+PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708454550; c=relaxed/simple;
	bh=DeCUBirGB1av/mDvC3nnEYuk7MDMpLefc0sw1g7BDCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GI9hYqqJJNTPrgtmD1YVzo+xfRfcHfV8rKfBf2C7YrioK4oesTa/vhodrIhnqQusAQXB2Zn3gpNdasjGzokiUYRK1bl6ILS47I62dTqbZYJvvPE1z0QqH8CriZySC1PxR7yLA2wKNRBX9ugC3a/6yqgtkrBP42N3GLEBFdMcGDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OofyyqEP; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4C48160009;
	Tue, 20 Feb 2024 18:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708454546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8xqEsu4HmdJSnEGEDb73iQZfTOge76cU7l1oJzMrygE=;
	b=OofyyqEPtUWFd5rknTdR+h3Kirjisa4l9RF2DcQO+F0y3YBIKENxkeZg6RLyjYAgqzz1q5
	eJapJ3bD8ZJrW5naM691dNM1ROs3K8fFFczE2fhsxy5GkvcBkgWD8/TwuTxtq8aQ/2+w1y
	B4WMRwuQM42MJRmcIbrwyZiYG8QLVY1mWTDaaMTkRFMgTy1ZHhsq9lm4/Ka63KCJyryuvk
	vXXoP4ZdseGOjF9AneLEdCaI8Yo1XqiIKGdMeGcBVSq+OJ0QwouDP2bGs+C3xwdLaWLs3M
	UHxtWWMoh3EHMPtHC5rH77O3GPJFTEaTYFxDprk3iYTvGQTAq0RBJLfcrtXmRA==
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
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org
Subject: [PATCH net-next v8 03/13] net: phy: add helpers to handle sfp phy connect/disconnect
Date: Tue, 20 Feb 2024 19:42:06 +0100
Message-ID: <20240220184217.3689988-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220184217.3689988-1-maxime.chevallier@bootlin.com>
References: <20240220184217.3689988-1-maxime.chevallier@bootlin.com>
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
V8: Took the at803x into account
V7: No changes
V6: Moved phy_get_link_topology() definition to this patch
V5: No Changes
V4: Rebased the at803x part with the newer version on net-next
V3: Renaming
V2: Renaming

 drivers/net/phy/marvell-88x2222.c |  2 ++
 drivers/net/phy/marvell.c         |  2 ++
 drivers/net/phy/marvell10g.c      |  2 ++
 drivers/net/phy/phy_device.c      | 48 +++++++++++++++++++++++++++++++
 drivers/net/phy/qcom/at803x.c     |  2 ++
 drivers/net/phy/qcom/qca807x.c    |  2 ++
 include/linux/phy.h               |  2 ++
 7 files changed, 60 insertions(+)

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
index 1faa22f58366..c26d20bdac51 100644
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
index 8478199f2d89..d47a2aa6ce87 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -277,6 +277,14 @@ static void phy_mdio_device_remove(struct mdio_device *mdiodev)
 
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
 
@@ -1370,6 +1378,46 @@ phy_standalone_show(struct device *dev, struct device_attribute *attr,
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
diff --git a/drivers/net/phy/qcom/at803x.c b/drivers/net/phy/qcom/at803x.c
index 4717c59d51d0..235d242076cb 100644
--- a/drivers/net/phy/qcom/at803x.c
+++ b/drivers/net/phy/qcom/at803x.c
@@ -769,6 +769,8 @@ static const struct sfp_upstream_ops at8031_sfp_ops = {
 	.attach = phy_sfp_attach,
 	.detach = phy_sfp_detach,
 	.module_insert = at8031_sfp_insert,
+	.connect_phy = phy_sfp_connect_phy,
+	.disconnect_phy = phy_sfp_disconnect_phy,
 };
 
 static int at8031_parse_dt(struct phy_device *phydev)
diff --git a/drivers/net/phy/qcom/qca807x.c b/drivers/net/phy/qcom/qca807x.c
index 780c28e2e4aa..0ff16122c3d9 100644
--- a/drivers/net/phy/qcom/qca807x.c
+++ b/drivers/net/phy/qcom/qca807x.c
@@ -699,6 +699,8 @@ static const struct sfp_upstream_ops qca807x_sfp_ops = {
 	.detach = phy_sfp_detach,
 	.module_insert = qca807x_sfp_insert,
 	.module_remove = qca807x_sfp_remove,
+	.connect_phy = phy_sfp_connect_phy,
+	.disconnect_phy = phy_sfp_disconnect_phy,
 };
 
 static int qca807x_probe(struct phy_device *phydev)
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 236b95472865..eb505097bc9f 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1752,6 +1752,8 @@ int phy_suspend(struct phy_device *phydev);
 int phy_resume(struct phy_device *phydev);
 int __phy_resume(struct phy_device *phydev);
 int phy_loopback(struct phy_device *phydev, bool enable);
+int phy_sfp_connect_phy(void *upstream, struct phy_device *phy);
+void phy_sfp_disconnect_phy(void *upstream, struct phy_device *phy);
 void phy_sfp_attach(void *upstream, struct sfp_bus *bus);
 void phy_sfp_detach(void *upstream, struct sfp_bus *bus);
 int phy_sfp_probe(struct phy_device *phydev,
-- 
2.43.2


