Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FE2800DD3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 16:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379285AbjLAPBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379265AbjLAPBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:01:47 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ED9193;
        Fri,  1 Dec 2023 07:01:51 -0800 (PST)
Received: from i53875b61.versanet.de ([83.135.91.97] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1r951T-0000eX-PW; Fri, 01 Dec 2023 16:01:43 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     andrew@lunn.ch, hkallweit1@gmail.com
Cc:     linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, quentin.schulz@theobroma-systems.com,
        heiko@sntech.de, Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 2/2] net: phy: micrel: allow usage of generic ethernet-phy clock
Date:   Fri,  1 Dec 2023 16:01:31 +0100
Message-Id: <20231201150131.326766-3-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231201150131.326766-1-heiko@sntech.de>
References: <20231201150131.326766-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The generic ethernet-phy binding allows describing an external clock since
commit 350b7a258f20 ("dt-bindings: net: phy: Document support for external PHY clk")
for cases where the phy is not supplied by an oscillator but instead
by a clock from the host system.

And the old named "rmii-ref" clock from 2014 is only specified for phys
of the KSZ8021, KSZ8031, KSZ8081, KSZ8091 types.

So allow retrieving and enabling the optional generic clock on phys that
do not provide a rmii-ref clock.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/net/phy/micrel.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index ec6a39dc9053..9490849437c0 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -2021,6 +2021,11 @@ static int kszphy_probe(struct phy_device *phydev)
 				   rate);
 			return -EINVAL;
 		}
+	} else if (!clk) {
+		/* unnamed clock from the generic ethernet-phy binding */
+		clk = devm_clk_get_optional_enabled(&phydev->mdio.dev, NULL);
+		if (IS_ERR(clk))
+			return PTR_ERR(clk);
 	}
 
 	if (ksz8041_fiber_mode(phydev))
-- 
2.39.2

