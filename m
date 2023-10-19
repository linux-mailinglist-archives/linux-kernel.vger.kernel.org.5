Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0387CF668
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjJSLPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjJSLPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:15:15 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73176FA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:15:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qtQzV-0000t1-RA; Thu, 19 Oct 2023 13:15:01 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qtQzU-002mGF-WA; Thu, 19 Oct 2023 13:15:01 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <ore@pengutronix.de>)
        id 1qtQzU-004CEM-2z;
        Thu, 19 Oct 2023 13:15:00 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        netdev@vger.kernel.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH net-next v3 2/2] net: phy: micrel: Fix forced link mode for KSZ886X switches
Date:   Thu, 19 Oct 2023 13:14:59 +0200
Message-Id: <20231019111459.1000218-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231019111459.1000218-1-o.rempel@pengutronix.de>
References: <20231019111459.1000218-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Address a link speed detection issue in KSZ886X PHY driver when in
forced link mode. Previously, link partners like "ASIX AX88772B"
with KSZ8873 could fall back to 10Mbit instead of configured 100Mbit.

The issue arises as KSZ886X PHY continues sending Fast Link Pulses (FLPs)
even with autonegotiation off, misleading link partners in autoneg mode,
leading to incorrect link speed detection.

Now, when autonegotiation is disabled, the driver sets the link state
forcefully using KSZ886X_CTRL_FORCE_LINK bit. This action, beyond just
disabling autonegotiation, makes the PHY state more reliably detected by
link partners using parallel detection, thus fixing the link speed
misconfiguration.

With autonegotiation enabled, link state is not forced, allowing proper
autonegotiation process participation.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/micrel.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 927d3d54658e..08e3915001c3 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -1733,6 +1733,28 @@ static int ksz886x_config_aneg(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	if (phydev->autoneg != AUTONEG_ENABLE) {
+		/* When autonegotation is disabled, we need to manually force
+		 * the link state. If we don't do this, the PHY will keep
+		 * sending Fast Link Pulses (FLPs) which are part of the
+		 * autonegotiation process. This is not desired when
+		 * autonegotiation is off.
+		 */
+		ret = phy_set_bits(phydev, MII_KSZPHY_CTRL,
+				   KSZ886X_CTRL_FORCE_LINK);
+		if (ret)
+			return ret;
+	} else {
+		/* If we had previously forced the link state, we need to
+		 * clear KSZ886X_CTRL_FORCE_LINK bit now. Otherwise, the PHY
+		 * will not perform autonegotiation.
+		 */
+		ret = phy_clear_bits(phydev, MII_KSZPHY_CTRL,
+				     KSZ886X_CTRL_FORCE_LINK);
+		if (ret)
+			return ret;
+	}
+
 	/* The MDI-X configuration is automatically changed by the PHY after
 	 * switching from autoneg off to on. So, take MDI-X configuration under
 	 * own control and set it after autoneg configuration was done.
-- 
2.39.2

