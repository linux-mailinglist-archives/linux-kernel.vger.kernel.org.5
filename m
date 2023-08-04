Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A887876FAF5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 09:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbjHDHSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 03:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjHDHSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 03:18:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D873B35AA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 00:18:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRp4g-00089W-2V; Fri, 04 Aug 2023 09:18:14 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRp4Z-0011I7-TS; Fri, 04 Aug 2023 09:18:07 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRp4Y-00AKpv-P8; Fri, 04 Aug 2023 09:18:06 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Ioana Ciornei <ciorneiioana@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Andre Edich <andre.edich@microchip.com>,
        Antoine Tenart <atenart@kernel.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Divya Koppera <Divya.Koppera@microchip.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Kresin <dev@kresin.me>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Michael Walle <michael@walle.cc>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Nisar Sayed <Nisar.Sayed@microchip.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Willy Liu <willy.liu@realtek.com>,
        Yuiko Oshino <yuiko.oshino@microchip.com>
Subject: [PATCH] net: phy: Don't disable irqs on shutdown if WoL is enabled
Date:   Fri,  4 Aug 2023 09:17:57 +0200
Message-Id: <20230804071757.383971-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1812; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=VS0duhs9tb1uEImz/dcLi5TtuWmMForApzGS0DBMBK8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkzKYciDor+Q+TNs8MJaBvEB+iLLq2b7H93wMrz hWVoLEgUOmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZMymHAAKCRCPgPtYfRL+ TgtLB/4rCgK94PaBx6OWWpN/SUotuLOTzG1Zno3Z2oaqS+Cq0WO/uu37Rl1f4pGu8cxID2GA+AA 6GACcL9AE/HRsC9OCseSTHueJgAkVHBgGv0mkBGlDIa2L47+GmfCrv/IlCCRMLIkLU2X97h8qzI PM85gWHv2saj0EG0SfJVoujIG4CNCA7uq3cME9R2mwNVk7j3PvxOfDLTYX0FXAe1/Dvw4H8WKj1 5TrND0tytLnzmtxgL7P394PNl1lBo77TCmeNVa3fKbr3s3GU4CTpSBPIC8JnYRjkXaI+N7D96TU yvVorW3kfrymHXtF7G2ck2wnJ8tEMjUUuz4B7Bwb3nr4nvWp
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most PHYs signal WoL using an interrupt. So disabling interrupts breaks
WoL at least on PHYs covered by the marvell driver. So skip disabling
irqs on shutdown if WoL is enabled.

While at it also explain the motivation that irqs are disabled at all.

Fixes: e2f016cf7751 ("net: phy: add a shutdown procedure")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

while I'm not sure that disabling interrupts is a good idea in general,
this change at least should fix the WoL case. Note that this change is
only compile tested as next doesn't boot on my test machine (because of
https://git.kernel.org/linus/b3574f579ece24439c90e9a179742c61205fbcfa)
and 6.1 (which is the other kernel I have running) doesn't know about
.wol_enabled. I don't want to delay this fix until I bisected this new
issue.

Assuming this patch is eligible for backporting to stable, maybe point
out that it depends on v6.5-rc1~163^2~286^2~2 ("net: phy: Allow drivers
to always call into ->suspend()"). Didn't try to backport that.

Best regards
Uwe

 drivers/net/phy/phy_device.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 61921d4dbb13..6d1526bdd1d7 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3340,6 +3340,15 @@ static void phy_shutdown(struct device *dev)
 	if (phydev->state == PHY_READY || !phydev->attached_dev)
 		return;
 
+	/* Most phys signal WoL via the irq line. So for these irqs shouldn't be
+	 * disabled.
+	 */
+	if (phydev->wol_enabled)
+		return;
+
+	/* On shutdown disable irqs to prevent an irq storm on systems where the
+	 * irq line is shared by several devices.
+	 */
 	phy_disable_interrupts(phydev);
 }
 
-- 
2.40.1

