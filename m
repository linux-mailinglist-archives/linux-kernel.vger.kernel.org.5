Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6297EAEFE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjKNL3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjKNL3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:29:07 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160131BC3;
        Tue, 14 Nov 2023 03:28:53 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 855CE60003;
        Tue, 14 Nov 2023 11:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699961332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iLcv2U5/tJBWHcDOVIYyQDAJQb5WKSZvw4UjIoMJnco=;
        b=UeNHFzoca1jxUrPL+28Ae9JWb/zm78O+AOPDkYg+wTysnLLAkXJGFc59Xt3o88b3hWU32c
        s7RQrOWZLOlDKjHYXRzrvp2IB5c1nkB1ue567XbrjXplnMqzyyuC2ctGi5FVDdBR2dxi6Z
        RP72IKdPjeWixKv6iE4CZeAWLHErtyIFZ1pqQceRFlQ5mP0i20Tyx6mqF9VqiHPpnYx27a
        pcALGz3SQ7ppzvCrmvVUIqZza7EUw1RJH3RZtXBLX0ZOkKjYI4Zwo0hqgvKZGSHBJOsZlR
        j6t0dcecd570rhwx/Sp6f8Pf6vHXUJUNhgtCn8CJEzbXIz+QbvVw6RCwS+BuDg==
From:   Kory Maincent <kory.maincent@bootlin.com>
Date:   Tue, 14 Nov 2023 12:28:30 +0100
Subject: [PATCH net-next v7 02/16] net: phy: Remove the call to
 phy_mii_ioctl in phy_hwstamp_get/set
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-feature_ptp_netnext-v7-2-472e77951e40@bootlin.com>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
In-Reply-To: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__phy_hwtstamp_set function were calling the phy_mii_ioctl function
which will then use the ifreq pointer to call the hwtstamp callback.
Now that ifreq has been removed from the hwstamp callback parameters
it seems more logical to not go through the phy_mii_ioctl function and pass
directly kernel_hwtstamp_config parameter to the hwtstamp callback.

Lets do the same for __phy_hwtstamp_get function and return directly
EOPNOTSUPP as SIOCGHWTSTAMP is not supported for now for the PHYs.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/phy/phy.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index d058316666ba..3376e58e2b88 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -486,7 +486,7 @@ int __phy_hwtstamp_get(struct phy_device *phydev,
 	if (!phydev)
 		return -ENODEV;
 
-	return phy_mii_ioctl(phydev, config->ifr, SIOCGHWTSTAMP);
+	return -EOPNOTSUPP;
 }
 
 /**
@@ -503,7 +503,10 @@ int __phy_hwtstamp_set(struct phy_device *phydev,
 	if (!phydev)
 		return -ENODEV;
 
-	return phy_mii_ioctl(phydev, config->ifr, SIOCSHWTSTAMP);
+	if (phydev->mii_ts && phydev->mii_ts->hwtstamp)
+		return phydev->mii_ts->hwtstamp(phydev->mii_ts, config, extack);
+
+	return -EOPNOTSUPP;
 }
 
 /**

-- 
2.25.1

