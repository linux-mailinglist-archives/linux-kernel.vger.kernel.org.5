Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA873767C5A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 07:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbjG2Fb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 01:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjG2FbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 01:31:22 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5D3449CA;
        Fri, 28 Jul 2023 22:31:18 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36T5UHcxC025140, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36T5UHcxC025140
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sat, 29 Jul 2023 13:30:17 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Sat, 29 Jul 2023 13:30:30 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Sat, 29 Jul 2023 13:30:29 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Sat, 29 Jul 2023 13:30:29 +0800
From:   Stanley Chang <stanley_chang@realtek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Stanley Chang <stanley_chang@realtek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        <linux-phy@lists.infradead.org>
Subject: [PATCH usb-next] phy: realtek: usb: phy-rtk-usb2 and phy-rtk-usb3 needs USB_COMMON
Date:   Sat, 29 Jul 2023 13:30:26 +0800
Message-ID: <20230729053029.6226-1-stanley_chang@realtek.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When USB_COMMON are not enabled, phy-rtk-usb2 and phy-rtk-usb3 suffers
a build error due to a missing usb_debug_root that is provided
by CONFIG_USB_COMMON, so make the driver select USB_COMMON.

   or1k-linux-ld: drivers/phy/realtek/phy-rtk-usb2.o: in function `create_phy_debug_root':
>> drivers/phy/realtek/phy-rtk-usb2.c:715: undefined reference to `usb_debug_root'
>> or1k-linux-ld: drivers/phy/realtek/phy-rtk-usb2.c:715: undefined reference to `usb_debug_root'

   or1k-linux-ld: drivers/phy/realtek/phy-rtk-usb3.o: in function `create_phy_debug_root':
>> drivers/phy/realtek/phy-rtk-usb3.c:349: undefined reference to `usb_debug_root'
>> or1k-linux-ld: drivers/phy/realtek/phy-rtk-usb3.c:349: undefined reference to `usb_debug_root'

Fixes: 134e6d25f6bd ("phy: realtek: usb: Add driver for the Realtek SoC USB 2.0 PHY")
Fixed: adda6e82a7de ("phy: realtek: usb: Add driver for the Realtek SoC USB 3.0 PHY")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307290733.weSlHrGp-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202307291022.3pVeTR9z-lkp@intel.com/
Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
---
 drivers/phy/realtek/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/realtek/Kconfig b/drivers/phy/realtek/Kconfig
index a5a5a71edc9c..650e20ed69af 100644
--- a/drivers/phy/realtek/Kconfig
+++ b/drivers/phy/realtek/Kconfig
@@ -7,6 +7,7 @@ config PHY_RTK_RTD_USB2PHY
 	depends on USB_SUPPORT
 	select GENERIC_PHY
 	select USB_PHY
+	select USB_COMMON
 	help
 	  Enable this to support Realtek SoC USB2 phy transceiver.
 	  The DHC (digital home center) RTD series SoCs used the Synopsys
@@ -18,6 +19,7 @@ config PHY_RTK_RTD_USB3PHY
 	depends on USB_SUPPORT
 	select GENERIC_PHY
 	select USB_PHY
+	select USB_COMMON
 	help
 	  Enable this to support Realtek SoC USB3 phy transceiver.
 	  The DHC (digital home center) RTD series SoCs used the Synopsys
-- 
2.34.1

