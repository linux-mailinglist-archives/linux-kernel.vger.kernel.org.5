Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FDB7F4189
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbjKVJ0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjKVJ0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:26:00 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEACCF4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:25:55 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1r5jUS-0006KP-9q; Wed, 22 Nov 2023 10:25:48 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1r5jUQ-00AmPc-VF; Wed, 22 Nov 2023 10:25:46 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <ore@pengutronix.de>)
        id 1r5jUQ-00C9JS-2r;
        Wed, 22 Nov 2023 10:25:46 +0100
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
        UNGLinuxDriver@microchip.com
Subject: [PATCH net-next v5 3/3] net: dsa: microchip: make phylink_mac_link_up() not optional
Date:   Wed, 22 Nov 2023 10:25:45 +0100
Message-Id: <20231122092545.2895635-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231122092545.2895635-1-o.rempel@pengutronix.de>
References: <20231122092545.2895635-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Last part of the driver do now support phylink_mac_link_up(). So, make it
not optional.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz_common.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 0ee7cfb8d4bd..ab51b091d098 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3111,10 +3111,8 @@ static void ksz_phylink_mac_link_up(struct dsa_switch *ds, int port,
 {
 	struct ksz_device *dev = ds->priv;
 
-	if (dev->dev_ops->phylink_mac_link_up)
-		dev->dev_ops->phylink_mac_link_up(dev, port, mode, interface,
-						  phydev, speed, duplex,
-						  tx_pause, rx_pause);
+	dev->dev_ops->phylink_mac_link_up(dev, port, mode, interface, phydev,
+					  speed, duplex, tx_pause, rx_pause);
 }
 
 static int ksz_switch_detect(struct ksz_device *dev)
-- 
2.39.2

