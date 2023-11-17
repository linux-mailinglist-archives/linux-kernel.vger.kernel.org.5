Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEFB7EF57E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 16:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346071AbjKQPkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 10:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjKQPk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 10:40:26 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F0910D0;
        Fri, 17 Nov 2023 07:40:22 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 703451BF211;
        Fri, 17 Nov 2023 15:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700235621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rRo/pQcZejgRnemKP4uNQxIXQrj56PAQ2aabjMSpgaA=;
        b=GnhtVcTeeFqGMaAcovX1o3xPo/YAWPfzDS9rVjV7Qcv7xceupy2l5m9E9wXuXb7XB5Nbqz
        9zCF+d6vMutig1CM32SZHX3qyFliuI6TSuSU+pVWZVgWEDI2/xoi/oGMO2ns7Di2vVjdUp
        y6t7kSCWp9Q1M4UefMNzQedp5vrtRrNdRCkEo5wxqU1U6X+Sy7e85y9hux490ttCcCXLpG
        6NC5rfPOPYZl4fRe3x/wQQlvnYJsRyS3kEb01suvfauDbSsc++V14l7qEBBDf5KOphcIc3
        UnwYdnCOszVKHAyRhxu0SZuYFlAdxgAlo5T1buzTI9GnQyxqzj3tQZQo/5vj2g==
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
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [RFC PATCH net-next v2 04/10] net: sfp: Add helper to return the SFP bus name
Date:   Fri, 17 Nov 2023 17:23:15 +0100
Message-ID: <20231117162323.626979-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231117162323.626979-1-maxime.chevallier@bootlin.com>
References: <20231117162323.626979-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Knowing the bus name is helpful when we want to expose the link topology
to userspace, add a helper to return the SFP bus name.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/sfp-bus.c | 9 +++++++++
 include/linux/sfp.h       | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
index f42e9a082935..835fb2271b12 100644
--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -859,3 +859,12 @@ void sfp_unregister_socket(struct sfp_bus *bus)
 	sfp_bus_put(bus);
 }
 EXPORT_SYMBOL_GPL(sfp_unregister_socket);
+
+const char *sfp_get_name(struct sfp_bus *bus)
+{
+	if (bus->sfp_dev)
+		return dev_name(bus->sfp_dev);
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(sfp_get_name);
diff --git a/include/linux/sfp.h b/include/linux/sfp.h
index 0573e53b0c11..96f7644908bd 100644
--- a/include/linux/sfp.h
+++ b/include/linux/sfp.h
@@ -570,6 +570,7 @@ struct sfp_bus *sfp_bus_find_fwnode(const struct fwnode_handle *fwnode);
 int sfp_bus_add_upstream(struct sfp_bus *bus, void *upstream,
 			 const struct sfp_upstream_ops *ops);
 void sfp_bus_del_upstream(struct sfp_bus *bus);
+const char *sfp_get_name(struct sfp_bus *bus);
 #else
 static inline int sfp_parse_port(struct sfp_bus *bus,
 				 const struct sfp_eeprom_id *id,
@@ -648,6 +649,11 @@ static inline int sfp_bus_add_upstream(struct sfp_bus *bus, void *upstream,
 static inline void sfp_bus_del_upstream(struct sfp_bus *bus)
 {
 }
+
+static const char *sfp_get_name(struct sfp_bus *bus)
+{
+	return NULL;
+}
 #endif
 
 #endif
-- 
2.41.0

