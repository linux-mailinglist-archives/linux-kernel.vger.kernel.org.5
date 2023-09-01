Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFD378F7B1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 06:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbjIAExs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 00:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjIAExs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 00:53:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47963E7C
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 21:53:45 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qbw9w-0006Kk-Pq; Fri, 01 Sep 2023 06:53:28 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qbw9t-0034i8-Hc; Fri, 01 Sep 2023 06:53:25 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <ore@pengutronix.de>)
        id 1qbw9t-00GOeB-0W;
        Fri, 01 Sep 2023 06:53:25 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        netdev@vger.kernel.org, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH net v2 1/1] net: phy: micrel: Correct bit assignments for phy_device flags
Date:   Fri,  1 Sep 2023 06:53:23 +0200
Message-Id: <20230901045323.3907976-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, the defines for phy_device flags in the Micrel driver were
ambiguous in their representation. They were intended to be bit masks
but were mistakenly defined as bit positions. This led to the following
issues:

- MICREL_KSZ8_P1_ERRATA, designated for KSZ88xx switches, overlapped
  with MICREL_PHY_FXEN and MICREL_PHY_50MHZ_CLK.
- Due to this overlap, the code path for MICREL_PHY_FXEN, tailored for
  the KSZ8041 PHY, was not executed for KSZ88xx PHYs.
- Similarly, the code associated with MICREL_PHY_50MHZ_CLK wasn't
  triggered for KSZ88xx.

To rectify this, all three flags have now been explicitly converted to
use the `BIT()` macro, ensuring they are defined as bit masks and
preventing potential overlaps in the future.

Fixes: 49011e0c1555 ("net: phy: micrel: ksz886x/ksz8081: add cabletest support")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 include/linux/micrel_phy.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/micrel_phy.h b/include/linux/micrel_phy.h
index 8bef1ab62bba3..322d872559847 100644
--- a/include/linux/micrel_phy.h
+++ b/include/linux/micrel_phy.h
@@ -41,9 +41,9 @@
 #define	PHY_ID_KSZ9477		0x00221631
 
 /* struct phy_device dev_flags definitions */
-#define MICREL_PHY_50MHZ_CLK	0x00000001
-#define MICREL_PHY_FXEN		0x00000002
-#define MICREL_KSZ8_P1_ERRATA	0x00000003
+#define MICREL_PHY_50MHZ_CLK	BIT(0)
+#define MICREL_PHY_FXEN		BIT(1)
+#define MICREL_KSZ8_P1_ERRATA	BIT(2)
 
 #define MICREL_KSZ9021_EXTREG_CTRL	0xB
 #define MICREL_KSZ9021_EXTREG_DATA_WRITE	0xC
-- 
2.39.2

