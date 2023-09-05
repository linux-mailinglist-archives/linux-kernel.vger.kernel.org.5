Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D3F792A6B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbjIEQgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354064AbjIEJdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:33:49 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF04B1A7;
        Tue,  5 Sep 2023 02:33:45 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 7369E86541;
        Tue,  5 Sep 2023 11:33:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693906424;
        bh=iAVgdRx2LKAmMKxyGtj0T+FEye5UUfEr1r4fnHtpa0Q=;
        h=From:To:Cc:Subject:Date:From;
        b=KPjmlUqT8XnK/1ics+u9AL1nvLKcx75cdQ/GVuKydKH/R9iISX2AATPq2J67BKyXP
         /DhI9157RMTPcf/n8RZxRfoQ55tXJx+Owq5VzlOtPCOEh6vkjnYEikTHxtze0TCNDL
         kxeDP2EtTYm/i7tYMQnpIQBekABiKDEdbS82zHsgeM0XSlFlvjjWKThV4cw6hlmMbC
         kMzBNZKjBL9aM2kBLq+dLosji3ZKv/yDZsYdIZG12JheGz2v/Tpp3Ljfhgw4jdHuZF
         SmfZJqW0Yzj4oANjZho9pN5NPcrCfxBXJarW00w1y/rv6qPP5+Vwk+wODaEBm3DcjC
         Zz1B60OxWvjjQ==
From:   Lukasz Majewski <lukma@denx.de>
To:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>
Subject: [net v4] net: phy: Provide Module 4 KSZ9477 errata (DS80000754C)
Date:   Tue,  5 Sep 2023 11:33:15 +0200
Message-Id: <20230905093315.784052-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KSZ9477 errata points out (in 'Module 4') the link up/down problems
when EEE (Energy Efficient Ethernet) is enabled in the device to which
the KSZ9477 tries to auto negotiate.

The suggested workaround is to clear advertisement of EEE for PHYs in
this chip driver.

To avoid regressions with other switch ICs the new MICREL_NO_EEE flag
has been introduced.

Moreover, the in-register disablement of MMD_DEVICE_ID_EEE_ADV.MMD_EEE_ADV
MMD register is removed, as this code is both; now executed too late
(after previous rework of the PHY and DSA for KSZ switches) and not
required as setting all members of eee_broken_modes bit field prevents
the KSZ9477 from advertising EEE.

Fixes: 69d3b36ca045 ("net: dsa: microchip: enable EEE support") (for KSZ9477).

Signed-off-by: Lukasz Majewski <lukma@denx.de>
Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
Confirmed disabled EEE with oscilloscope.
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

---
Changes for v2:
- Move this fix from clearing directly
  MMD_DEVICE_ID_EEE_ADV.MMD_EEE_ADV MMD register in KSZ DSA switch
  initialization to more generic solution in the micrel.c PHY driver

Changes for v3:
- Drop the rename patch
- Use MICREL_NO_EEE flag as suggested by Oleksij
- Extend the ksz9477_config_init to avoid regression
- Do not use the direct write to MMD 7.60 register - instead the
  phydev->eee_broken_modes is used

Changes for v4:
- Rebase on top of net-next with Oleksij Rempel patch (adding BIT()
  macros on to Micrel flags) applied
- Add SoB and Tested-by tags
---
 drivers/net/dsa/microchip/ksz_common.c | 16 +++++++++++++++-
 drivers/net/phy/micrel.c               |  9 ++++++---
 include/linux/micrel_phy.h             |  1 +
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 6673122266b7..42db7679c360 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2335,13 +2335,27 @@ static u32 ksz_get_phy_flags(struct dsa_switch *ds, int port)
 {
 	struct ksz_device *dev = ds->priv;
 
-	if (dev->chip_id == KSZ8830_CHIP_ID) {
+	switch (dev->chip_id) {
+	case KSZ8830_CHIP_ID:
 		/* Silicon Errata Sheet (DS80000830A):
 		 * Port 1 does not work with LinkMD Cable-Testing.
 		 * Port 1 does not respond to received PAUSE control frames.
 		 */
 		if (!port)
 			return MICREL_KSZ8_P1_ERRATA;
+		break;
+	case KSZ9477_CHIP_ID:
+		/* KSZ9477 Errata DS80000754C
+		 *
+		 * Module 4: Energy Efficient Ethernet (EEE) feature select must
+		 * be manually disabled
+		 *   The EEE feature is enabled by default, but it is not fully
+		 *   operational. It must be manually disabled through register
+		 *   controls. If not disabled, the PHY ports can auto-negotiate
+		 *   to enable EEE, and this feature can cause link drops when
+		 *   linked to another device supporting EEE.
+		 */
+		return MICREL_NO_EEE;
 	}
 
 	return 0;
diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index b6d7981b2d1e..927d3d54658e 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -1800,9 +1800,6 @@ static const struct ksz9477_errata_write ksz9477_errata_writes[] = {
 	/* Transmit waveform amplitude can be improved (1000BASE-T, 100BASE-TX, 10BASE-Te) */
 	{0x1c, 0x04, 0x00d0},
 
-	/* Energy Efficient Ethernet (EEE) feature select must be manually disabled */
-	{0x07, 0x3c, 0x0000},
-
 	/* Register settings are required to meet data sheet supply current specifications */
 	{0x1c, 0x13, 0x6eff},
 	{0x1c, 0x14, 0xe6ff},
@@ -1847,6 +1844,12 @@ static int ksz9477_config_init(struct phy_device *phydev)
 			return err;
 	}
 
+	/* According to KSZ9477 Errata DS80000754C (Module 4) all EEE modes
+	 * in this switch shall be regarded as broken.
+	 */
+	if (phydev->dev_flags & MICREL_NO_EEE)
+		phydev->eee_broken_modes = -1;
+
 	err = genphy_restart_aneg(phydev);
 	if (err)
 		return err;
diff --git a/include/linux/micrel_phy.h b/include/linux/micrel_phy.h
index 322d87255984..4e27ca7c49de 100644
--- a/include/linux/micrel_phy.h
+++ b/include/linux/micrel_phy.h
@@ -44,6 +44,7 @@
 #define MICREL_PHY_50MHZ_CLK	BIT(0)
 #define MICREL_PHY_FXEN		BIT(1)
 #define MICREL_KSZ8_P1_ERRATA	BIT(2)
+#define MICREL_NO_EEE		BIT(3)
 
 #define MICREL_KSZ9021_EXTREG_CTRL	0xB
 #define MICREL_KSZ9021_EXTREG_DATA_WRITE	0xC
-- 
2.20.1

