Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4672F80116C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378480AbjLAQhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjLAQhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:37:07 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A3CA6;
        Fri,  1 Dec 2023 08:37:13 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 02050C0008;
        Fri,  1 Dec 2023 16:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701448632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sXpDXkkD3ikt6WqoaDXyXCU8qzMrGQc4F7n0ARxk3O4=;
        b=ddV9Snkbf0tVTSbersPvQxpgDW4UOqQBtjgAvBLy177yRPcoMxFw4wnsKegP34Vx+EhueY
        6jaOBKH/MLbetYTTrGCDbKRC+kbyN+YLVmxtuWkwqq6ctI5d72RryLezoMukOS4Nr84ByI
        BUB0xEL2kAkoNf2dziyx4g5em7ERU6WXU4XNh+in8nJ6/bdNAtTOsNDiyKcHkfYwxaUt0P
        qiVjycowzWaU+/GNUyUY6OepOTbDKtQpfDFynOGhWCvDsladZcifBRc8yNYmVLyBRdy2HO
        UpASRyJcGxnzwSGn2BbQ+TT2EEcqHl1JJSY39ymk8XXXaL19B6gRD2MuwHhq/g==
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
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
        =?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>
Subject: [RFC PATCH net-next v3 03/13] net: phy: add helpers to handle sfp phy connect/disconnect
Date:   Fri,  1 Dec 2023 17:36:53 +0100
Message-ID: <20231201163704.1306431-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201163704.1306431-1-maxime.chevallier@bootlin.com>
References: <20231201163704.1306431-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few PHY drivers that can handle SFP modules through their
sfp_upstream_ops. Introduce Phylib helpers to keep track of connected
SFP PHYs in a netdevice's namespace, by adding the SFP PHY to the
upstream PHY's netdev's namespace.

By doing so, these SFP PHYs can be enumerated and exposed to users,
which will be able to use their capabilities.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V3: Renaming
V2: Renaming

 drivers/net/phy/at803x.c          |  2 ++
 drivers/net/phy/marvell-88x2222.c |  2 ++
 drivers/net/phy/marvell.c         |  2 ++
 drivers/net/phy/marvell10g.c      |  2 ++
 drivers/net/phy/phy_device.c      | 40 +++++++++++++++++++++++++++++++
 include/linux/phy.h               |  2 ++
 6 files changed, 50 insertions(+)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 37fb033e1c29..9b1659b03aa5 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -730,6 +730,8 @@ static const struct sfp_upstream_ops at803x_sfp_ops = {
 	.attach = phy_sfp_attach,
 	.detach = phy_sfp_detach,
 	.module_insert = at803x_sfp_insert,
+	.connect_phy = phy_sfp_connect_phy,
+	.disconnect_phy = phy_sfp_disconnect_phy,
 };
 
 static int at803x_parse_dt(struct phy_device *phydev)
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
index d4bb90d76881..a88ebc0a6be5 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -496,6 +496,8 @@ static int mv3310_sfp_insert(void *upstream, const struct sfp_eeprom_id *id)
 static const struct sfp_upstream_ops mv3310_sfp_ops = {
 	.attach = phy_sfp_attach,
 	.detach = phy_sfp_detach,
+	.connect_phy = phy_sfp_connect_phy,
+	.disconnect_phy = phy_sfp_disconnect_phy,
 	.module_insert = mv3310_sfp_insert,
 };
 
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index b921a091d636..675b9afdc66c 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1360,6 +1360,46 @@ phy_standalone_show(struct device *dev, struct device_attribute *attr,
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
index 4cee9c05183f..d1fe51e8ba93 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1722,6 +1722,8 @@ int phy_suspend(struct phy_device *phydev);
 int phy_resume(struct phy_device *phydev);
 int __phy_resume(struct phy_device *phydev);
 int phy_loopback(struct phy_device *phydev, bool enable);
+int phy_sfp_connect_phy(void *upstream, struct phy_device *phy);
+void phy_sfp_disconnect_phy(void *upstream, struct phy_device *phy);
 void phy_sfp_attach(void *upstream, struct sfp_bus *bus);
 void phy_sfp_detach(void *upstream, struct sfp_bus *bus);
 int phy_sfp_probe(struct phy_device *phydev,
-- 
2.42.0

