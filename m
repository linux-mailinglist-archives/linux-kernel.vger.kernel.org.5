Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCE07D2E5F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjJWJeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjJWJeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:34:08 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061F5BE
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:34:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qurJi-0000DE-0r; Mon, 23 Oct 2023 11:33:46 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qurJh-003fww-2w; Mon, 23 Oct 2023 11:33:45 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <ore@pengutronix.de>)
        id 1qurJg-009wdd-3A;
        Mon, 23 Oct 2023 11:33:44 +0200
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
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org
Subject: [PATCH net-next v7 7/9] net: dsa: microchip: Add error handling for ksz_switch_macaddr_get()
Date:   Mon, 23 Oct 2023 11:33:41 +0200
Message-Id: <20231023093343.2370248-8-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231023093343.2370248-1-o.rempel@pengutronix.de>
References: <20231023093343.2370248-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enhance the ksz_switch_macaddr_get() function to handle errors that may
occur during the call to ksz_write8(). Specifically, this update checks
the return value of ksz_write8(), which may fail if regmap ranges
validation is not passed and returns the error code.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 0442c1b628d9..58ba1e6ff75f 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3640,7 +3640,7 @@ int ksz_switch_macaddr_get(struct dsa_switch *ds, int port,
 	struct ksz_switch_macaddr *switch_macaddr;
 	struct ksz_device *dev = ds->priv;
 	const u16 *regs = dev->info->regs;
-	int i;
+	int i, ret;
 
 	/* Make sure concurrent MAC address changes are blocked */
 	ASSERT_RTNL();
@@ -3667,10 +3667,20 @@ int ksz_switch_macaddr_get(struct dsa_switch *ds, int port,
 	dev->switch_macaddr = switch_macaddr;
 
 	/* Program the switch MAC address to hardware */
-	for (i = 0; i < ETH_ALEN; i++)
-		ksz_write8(dev, regs[REG_SW_MAC_ADDR] + i, addr[i]);
+	for (i = 0; i < ETH_ALEN; i++) {
+		ret = ksz_write8(dev, regs[REG_SW_MAC_ADDR] + i, addr[i]);
+		if (ret)
+			goto macaddr_drop;
+	}
 
 	return 0;
+
+macaddr_drop:
+	dev->switch_macaddr = NULL;
+	refcount_set(&switch_macaddr->refcount, 0);
+	kfree(switch_macaddr);
+
+	return ret;
 }
 
 void ksz_switch_macaddr_put(struct dsa_switch *ds)
-- 
2.39.2

