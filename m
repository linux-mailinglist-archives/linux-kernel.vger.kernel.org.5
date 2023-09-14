Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF2F7A051E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238773AbjINNMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238750AbjINNL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:11:59 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E6D1FD8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:11:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qgm8J-0002Jp-R9; Thu, 14 Sep 2023 15:11:47 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qgm8I-006JUJ-89; Thu, 14 Sep 2023 15:11:46 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <ore@pengutronix.de>)
        id 1qgm8I-000657-0b;
        Thu, 14 Sep 2023 15:11:46 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com, Petr Machata <petrm@nvidia.com>,
        Lukasz Majewski <lukma@denx.de>
Subject: [PATCH net-next 1/2] net: dsa: microchip: Move *_port_setup code to dsa_switch_ops::port_setup()
Date:   Thu, 14 Sep 2023 15:11:44 +0200
Message-Id: <20230914131145.23336-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, the *_port_setup code is in dsa_switch_ops::port_enable(),
which is not the best place for it. This patch moves it to a more
suitable place, dsa_switch_ops::port_setup(), to match the function's
purpose and name.

This patch is a preparation for coming ACL support patch.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz_common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 54048b82db71..209a5243bd5a 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2564,8 +2564,7 @@ static int ksz_port_mdb_del(struct dsa_switch *ds, int port,
 	return dev->dev_ops->mdb_del(dev, port, mdb, db);
 }
 
-static int ksz_enable_port(struct dsa_switch *ds, int port,
-			   struct phy_device *phy)
+static int ksz_port_setup(struct dsa_switch *ds, int port)
 {
 	struct ksz_device *dev = ds->priv;
 
@@ -3497,7 +3496,7 @@ static const struct dsa_switch_ops ksz_switch_ops = {
 	.phylink_mac_config	= ksz_phylink_mac_config,
 	.phylink_mac_link_up	= ksz_phylink_mac_link_up,
 	.phylink_mac_link_down	= ksz_mac_link_down,
-	.port_enable		= ksz_enable_port,
+	.port_setup		= ksz_port_setup,
 	.set_ageing_time	= ksz_set_ageing_time,
 	.get_strings		= ksz_get_strings,
 	.get_ethtool_stats	= ksz_get_ethtool_stats,
-- 
2.39.2

