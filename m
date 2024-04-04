Return-Path: <linux-kernel+bounces-131174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3F7898407
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A3B1F28647
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBE18063C;
	Thu,  4 Apr 2024 09:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="perIOnxv"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E580574C0C;
	Thu,  4 Apr 2024 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223017; cv=none; b=VxjbEaOupK9zwJgpBh/q6BgHg8qIJhs9xDygKwkwX+2KYMAeZV+5nDUzJ6eIC9Pvw3mAKp9bsFafT8Bbg6XPxvhAHqNs6WkN7I4lwotVnhLEdkcuDclIX5YdLoFziF4rAAdfEyiOrRtOetmV4/AkmahuiIIkDDF+z9gFfQmqfys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223017; c=relaxed/simple;
	bh=f7pp8IbHBzDyJGUjpJTP5L4gJXeIPA1coE8cm+K94Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZ8opxWi8DertY8vHEWk+QGwBLf/ei5uPjwVy/DSqSvcehR9gXSnLK8G4k20T5EECf6J+DjAJmDMynCcUCqYqaOFxnIbUkye2VH7HExqLafYt4CsIfM6+Uekf7Ex342csWGfnmwaXU/UBufp2kWlVnHm03TEfNZBgvEulcf5e2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=perIOnxv; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 113DCC000D;
	Thu,  4 Apr 2024 09:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712223013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ih82d99xQVMVqjqqF5Vo2JX23MLsJ5HeXCMtgYZC7h4=;
	b=perIOnxvlE62bxjv9VE9xuLDMJnwi+ElxJWOAGT3hO02ruTomoEK3HZPHkp4wzhqoYymyF
	Cnnd4bS89M12YsrefIgxtAXFaobLGtUIF5rQPUlmADKVECwsCC60WM7o9LGwiyHPcmt/M0
	h6rArN2y9hf1qRMR5+voCl6jitPRhAt8bZ0qHDYIlDqJq+eoNJfFftipZDKthH0ajbTO2j
	yyoIz9WW+MyjIgTqrFpqzbD0WMY/iuDawFyhBz/tUbbqPUL72UOCW5ut66JUscbNK6BkCS
	Js4cpYhctBCxdXyonc2azzf/WsFTe5VMg9PEF3eU1/tgIeP+KSsuLK8w5M5J+g==
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
Subject: [PATCH net-next v11 03/13] net: phy: add helpers to handle sfp phy connect/disconnect
Date: Thu,  4 Apr 2024 11:29:53 +0200
Message-ID: <20240404093004.2552221-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404093004.2552221-1-maxime.chevallier@bootlin.com>
References: <20240404093004.2552221-1-maxime.chevallier@bootlin.com>
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
V11: No changes
V10: No changes
V9: No changes
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
index b88398e6872b..0b777cdd7078 100644
--- a/drivers/net/phy/marvell-88x2222.c
+++ b/drivers/net/phy/marvell-88x2222.c
@@ -553,6 +553,8 @@ static const struct sfp_upstream_ops sfp_phy_ops = {
 	.link_down = mv2222_sfp_link_down,
 	.attach = phy_sfp_attach,
 	.detach = phy_sfp_detach,
+	.connect_phy = phy_sfp_connect_phy,
+	.disconnect_phy = phy_sfp_disconnect_phy,
 };
 
 static int mv2222_probe(struct phy_device *phydev)
diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 7c00f47e4ded..b87d0f200643 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -3463,6 +3463,8 @@ static const struct sfp_upstream_ops m88e1510_sfp_ops = {
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
index 452fc8b3406d..616bd7ba46cb 100644
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
index c8f83e5f78ab..105602581a03 100644
--- a/drivers/net/phy/qcom/at803x.c
+++ b/drivers/net/phy/qcom/at803x.c
@@ -770,6 +770,8 @@ static const struct sfp_upstream_ops at8031_sfp_ops = {
 	.attach = phy_sfp_attach,
 	.detach = phy_sfp_detach,
 	.module_insert = at8031_sfp_insert,
+	.connect_phy = phy_sfp_connect_phy,
+	.disconnect_phy = phy_sfp_disconnect_phy,
 };
 
 static int at8031_parse_dt(struct phy_device *phydev)
diff --git a/drivers/net/phy/qcom/qca807x.c b/drivers/net/phy/qcom/qca807x.c
index 672c6929119a..5eb0ab1cb70e 100644
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
index 8c848c79b1fd..3ddfe7fe781a 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1758,6 +1758,8 @@ int phy_suspend(struct phy_device *phydev);
 int phy_resume(struct phy_device *phydev);
 int __phy_resume(struct phy_device *phydev);
 int phy_loopback(struct phy_device *phydev, bool enable);
+int phy_sfp_connect_phy(void *upstream, struct phy_device *phy);
+void phy_sfp_disconnect_phy(void *upstream, struct phy_device *phy);
 void phy_sfp_attach(void *upstream, struct sfp_bus *bus);
 void phy_sfp_detach(void *upstream, struct sfp_bus *bus);
 int phy_sfp_probe(struct phy_device *phydev,
-- 
2.44.0


