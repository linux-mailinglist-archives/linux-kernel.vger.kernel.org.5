Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE4276A9D1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 09:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjHAHQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 03:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjHAHQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 03:16:47 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F5FC1736;
        Tue,  1 Aug 2023 00:16:46 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3717Frj96006523, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3717Frj96006523
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 1 Aug 2023 15:15:53 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 1 Aug 2023 15:15:10 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 1 Aug 2023 15:15:09 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Tue, 1 Aug 2023 15:15:09 +0800
From:   Stanley Chang <stanley_chang@realtek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Stanley Chang <stanley_chang@realtek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        <linux-phy@lists.infradead.org>
Subject: [PATCH usb-next] phy: realtek: usb: add the error handler for nvmem_cell_read
Date:   Tue, 1 Aug 2023 15:14:52 +0800
Message-ID: <20230801071509.20096-1-stanley_chang@realtek.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS01.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are following smatch warning:
drivers/phy/realtek/phy-rtk-usb2.c:901 get_phy_data_by_efuse()
error: 'buf' dereferencing possible ERR_PTR()
drivers/phy/realtek/phy-rtk-usb2.c:942 get_phy_data_by_efuse()
error: 'buf' dereferencing possible ERR_PTR()

drivers/phy/realtek/phy-rtk-usb3.c:460
get_phy_data_by_efuse() error: 'buf' dereferencing possible ERR_PTR()

The nvmem_cell_read may fail to read. So, driver must handle failure cases.

Fixes: 134e6d25f6bd ("phy: realtek: usb: Add driver for the Realtek SoC USB 2.0 PHY")
Fixes: adda6e82a7de ("phy: realtek: usb: Add driver for the Realtek SoC USB 3.0 PHY")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-phy/e7ff2870-c30c-4d8d-a7a9-d2d6a4962eb5@kadam.mountain/
Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
---
 drivers/phy/realtek/phy-rtk-usb2.c | 14 ++++++++------
 drivers/phy/realtek/phy-rtk-usb3.c |  7 ++++---
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/realtek/phy-rtk-usb2.c b/drivers/phy/realtek/phy-rtk-usb2.c
index ed47a1ce5d9c..5e7ee060b404 100644
--- a/drivers/phy/realtek/phy-rtk-usb2.c
+++ b/drivers/phy/realtek/phy-rtk-usb2.c
@@ -898,9 +898,10 @@ static int get_phy_data_by_efuse(struct rtk_phy *rtk_phy,
 		size_t buf_size;
 
 		buf = nvmem_cell_read(cell, &buf_size);
-		value = buf[0] & phy_cfg->dc_driving_mask;
-
-		kfree(buf);
+		if (!IS_ERR(buf)) {
+			value = buf[0] & phy_cfg->dc_driving_mask;
+			kfree(buf);
+		}
 		nvmem_cell_put(cell);
 	}
 
@@ -939,9 +940,10 @@ static int get_phy_data_by_efuse(struct rtk_phy *rtk_phy,
 		size_t buf_size;
 
 		buf = nvmem_cell_read(cell, &buf_size);
-		value = buf[0] & phy_cfg->dc_disconnect_mask;
-
-		kfree(buf);
+		if (!IS_ERR(buf)) {
+			value = buf[0] & phy_cfg->dc_disconnect_mask;
+			kfree(buf);
+		}
 		nvmem_cell_put(cell);
 	}
 
diff --git a/drivers/phy/realtek/phy-rtk-usb3.c b/drivers/phy/realtek/phy-rtk-usb3.c
index 6050f1ef4f6b..7881f908aade 100644
--- a/drivers/phy/realtek/phy-rtk-usb3.c
+++ b/drivers/phy/realtek/phy-rtk-usb3.c
@@ -457,9 +457,10 @@ static int get_phy_data_by_efuse(struct rtk_phy *rtk_phy,
 		size_t buf_size;
 
 		buf = nvmem_cell_read(cell, &buf_size);
-		value = buf[0] & USB_U3_TX_LFPS_SWING_TRIM_MASK;
-
-		kfree(buf);
+		if (!IS_ERR(buf)) {
+			value = buf[0] & USB_U3_TX_LFPS_SWING_TRIM_MASK;
+			kfree(buf);
+		}
 		nvmem_cell_put(cell);
 	}
 
-- 
2.34.1

