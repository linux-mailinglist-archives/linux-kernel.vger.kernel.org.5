Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C951A7EAF14
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjKNLaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbjKNL3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:29:19 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9381BF8;
        Tue, 14 Nov 2023 03:28:59 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9856860008;
        Tue, 14 Nov 2023 11:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699961337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xRVp9zBKQvCZ72vII/R3dn2g9lLmskljfqZbCexdHAY=;
        b=QZQkWtSl7PmdL73sxcougZ9DULCoiLNr/Jy23LSSav81BScnnp7ruModPFv/n0nEIboFFm
        D5iZoMMk41fBXAPqdrVKt7/r4BnBMoUfV4X9S6iVLpH2EB+Ork30YBWIYXawhIj1fVUVoh
        Dbra9ThaRleSY6RFzg1cS83QpLJjSzzhKbquAMAhUyZNAB7doVXurnqrfczCriyGazI2dy
        GZ/t7Tb/2jSRP7RdO1gvbpnzP0RWTRf+k91zjln9irqjpc7DpsYlGSC4iCgMXXJTLNzzdJ
        0hbFfz6MYhi+09uBslUlQ/LOSU3o3W9dhT7qf3H37nG6BiFQTQqiX4wX9e7PoQ==
From:   Kory Maincent <kory.maincent@bootlin.com>
Date:   Tue, 14 Nov 2023 12:28:34 +0100
Subject: [PATCH net-next v7 06/16] net: phy: micrel: fix ts_info value in
 case of no phc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-feature_ptp_netnext-v7-6-472e77951e40@bootlin.com>
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
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of no phc we should not return SOFTWARE TIMESTAMPING flags as we do
not know whether the netdev supports of timestamping.
Remove it from the lan8841_ts_info and simply return 0.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

This patch is not tested but it seems consistent to me.

Changes in v6:
- Update the commit message.
---
 drivers/net/phy/micrel.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 99af1e500c6c..bd4cd082662f 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -3629,12 +3629,8 @@ static int lan8841_ts_info(struct mii_timestamper *mii_ts,
 
 	info->phc_index = ptp_priv->ptp_clock ?
 				ptp_clock_index(ptp_priv->ptp_clock) : -1;
-	if (info->phc_index == -1) {
-		info->so_timestamping |= SOF_TIMESTAMPING_TX_SOFTWARE |
-					 SOF_TIMESTAMPING_RX_SOFTWARE |
-					 SOF_TIMESTAMPING_SOFTWARE;
+	if (info->phc_index == -1)
 		return 0;
-	}
 
 	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |

-- 
2.25.1

