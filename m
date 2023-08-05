Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE492771037
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 16:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjHEOpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 10:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjHEOpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 10:45:51 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADFD4224;
        Sat,  5 Aug 2023 07:45:50 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qSIXH-0000Ou-2v;
        Sat, 05 Aug 2023 14:45:44 +0000
Date:   Sat, 5 Aug 2023 15:45:36 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: mt7530: improve and relax PHY driver
 dependency
Message-ID: <3ae907b7b60792e36bc5292c2e0bab74f84285e7.1691246642.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Different MT7530 variants require different PHY drivers.
Use 'imply' instead of 'select' to relax the dependency on the PHY
driver, and choose the appropriate driver.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 3ed5391bb18d6..f8c1d73b251d0 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -37,7 +37,6 @@ config NET_DSA_LANTIQ_GSWIP
 config NET_DSA_MT7530
 	tristate "MediaTek MT7530 and MT7531 Ethernet switch support"
 	select NET_DSA_TAG_MTK
-	select MEDIATEK_GE_PHY
 	imply NET_DSA_MT7530_MDIO
 	imply NET_DSA_MT7530_MMIO
 	help
@@ -49,6 +48,7 @@ config NET_DSA_MT7530
 config NET_DSA_MT7530_MDIO
 	tristate "MediaTek MT7530 MDIO interface driver"
 	depends on NET_DSA_MT7530
+	imply MEDIATEK_GE_PHY
 	select PCS_MTK_LYNXI
 	help
 	  This enables support for the MediaTek MT7530 and MT7531 switch
@@ -60,6 +60,7 @@ config NET_DSA_MT7530_MMIO
 	tristate "MediaTek MT7530 MMIO interface driver"
 	depends on NET_DSA_MT7530
 	depends on HAS_IOMEM
+	imply MEDIATEK_GE_SOC_PHY
 	help
 	  This enables support for the built-in Ethernet switch found
 	  in the MediaTek MT7988 SoC.
-- 
2.41.0
