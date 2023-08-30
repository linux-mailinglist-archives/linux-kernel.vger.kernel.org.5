Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBC478DFC6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245261AbjH3TWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242721AbjH3JVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:21:42 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73338CCB;
        Wed, 30 Aug 2023 02:21:38 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 428BA864EF;
        Wed, 30 Aug 2023 11:21:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693387296;
        bh=8vxd2qPCpP6m2nYudlDH5tbegJ9wBVvB3PF1O86stzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C1DJodv45zfCQqRv/NeXJL8jLT/pbfn0bfkbs8hXNptSsHmq/vP7KSPgrZV33woan
         i8LP/1OQVxiBVWzSRZTomxKGwPMa4kGcDqDc3/7vDGrVP5exdGMekrlSl0Mf9ZEYkR
         DpfkVTAmbnbhsrBkZv5vz2YOroZZQwxrDAxOK+xAnzx7BQoJSeQ+esNML7kiBBfyLh
         7d092I8jtm8xcxyuc1r3hHf81SF0QinLrmUAp64+wn4KxNhcIsnPdcy8grALUbKYBB
         E1j+hVPghC/qoSEAPdNr/7JOJ+mxayC8agS2Qey2SC3DeO7lypYHxVKvLE4VVawbbz
         vvDw2rHEl7NsQ==
From:   Lukasz Majewski <lukma@denx.de>
To:     Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
        davem@davemloft.net, Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Tristram.Ha@microchip.com, Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 2/2] net: phy: Provide Module 4 KSZ9477 errata (DS80000754C)
Date:   Wed, 30 Aug 2023 11:21:19 +0200
Message-Id: <20230830092119.458330-2-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230830092119.458330-1-lukma@denx.de>
References: <20230830092119.458330-1-lukma@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KSZ9477 errata points out (in 'Module 4') the link up/down problem
when EEE (Energy Efficient Ethernet) is enabled in the device to which
the KSZ9477 tries to auto negotiate.

The suggested workaround is to clear advertisement of EEE for PHYs in
this chip driver.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 drivers/net/phy/micrel.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 87b090ad2874..469dcd8a5711 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -1418,6 +1418,35 @@ static int ksz9131_get_features(struct phy_device *phydev)
 	return 0;
 }
 
+static int ksz9477_get_features(struct phy_device *phydev)
+{
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(zero) = { 0, };
+	int ret;
+
+	ret = genphy_read_abilities(phydev);
+	if (ret)
+		return ret;
+
+	/* KSZ9477 Errata DS80000754C
+	 *
+	 * Module 4: Energy Efficient Ethernet (EEE) feature select must be
+	 * manually disabled
+	 *   The EEE feature is enabled by default, but it is not fully
+	 *   operational. It must be manually disabled through register
+	 *   controls. If not disabled, the PHY ports can auto-negotiate
+	 *   to enable EEE, and this feature can cause link drops when linked
+	 *   to another device supporting EEE.
+	 *
+	 *   Although, the KSZ9477 MMD register
+	 *   (MMD_DEVICE_ID_EEE_ADV.MMD_EEE_ADV) advertise that EEE is
+	 *   operational one needs to manualy clear them to follow the chip
+	 *   errata.
+	 */
+	linkmode_and(phydev->supported_eee, phydev->supported, zero);
+
+	return 0;
+}
+
 #define KSZ8873MLL_GLOBAL_CONTROL_4	0x06
 #define KSZ8873MLL_GLOBAL_CONTROL_4_DUPLEX	BIT(6)
 #define KSZ8873MLL_GLOBAL_CONTROL_4_SPEED	BIT(4)
@@ -4871,7 +4900,7 @@ static struct phy_driver ksphy_driver[] = {
 	.handle_interrupt = kszphy_handle_interrupt,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
-	.get_features	= ksz9131_get_features,
+	.get_features	= ksz9477_get_features,
 } };
 
 module_phy_driver(ksphy_driver);
-- 
2.20.1

