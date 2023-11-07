Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3707E3542
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 07:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjKGGhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 01:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjKGGhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 01:37:31 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7054610D;
        Mon,  6 Nov 2023 22:37:27 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A76ZulZ64026563, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3A76ZulZ64026563
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Nov 2023 14:35:56 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 7 Nov 2023 14:35:56 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 7 Nov 2023 14:35:55 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Tue, 7 Nov 2023 14:35:55 +0800
From:   Stanley Chang <stanley_chang@realtek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Stanley Chang <stanley_chang@realtek.com>,
        Vinod Koul <vkoul@kernel.org>, Johan Hovold <johan@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        Yang Yingliang <yangyingliang@huawei.com>,
        =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        Ray Chi <raychi@google.com>, Roy Luo <royluo@google.com>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH v1 3/4] phy: realtek: usb3: Remove the legacy usb phy implementation
Date:   Tue, 7 Nov 2023 14:33:46 +0800
Message-ID: <20231107063518.27824-3-stanley_chang@realtek.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107063518.27824-1-stanley_chang@realtek.com>
References: <20231107063518.27824-1-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS05.realtek.com.tw, 9
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

Same as phy-rtk-usb2.c

Remove the port status notification on legacy USB PHY.
Use the generic PHY to notify the usb device connect and disconnect.

To avoid using these PHYs would require describing the very same
PHY using both the generic "phy" property and the deprecated "usb-phy"
property.

Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
---
 drivers/phy/realtek/phy-rtk-usb3.c | 56 ++++++++++++------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/drivers/phy/realtek/phy-rtk-usb3.c b/drivers/phy/realtek/phy-rtk-usb3.c
index 67446a85e968..d992a21243e1 100644
--- a/drivers/phy/realtek/phy-rtk-usb3.c
+++ b/drivers/phy/realtek/phy-rtk-usb3.c
@@ -18,8 +18,6 @@
 #include <linux/mfd/syscon.h>
 #include <linux/phy/phy.h>
 #include <linux/usb.h>
-#include <linux/usb/hcd.h>
-#include <linux/usb/phy.h>
 
 #define USB_MDIO_CTRL_PHY_BUSY BIT(7)
 #define USB_MDIO_CTRL_PHY_WRITE BIT(0)
@@ -85,7 +83,6 @@ struct phy_parameter {
 };
 
 struct rtk_phy {
-	struct usb_phy phy;
 	struct device *dev;
 
 	struct phy_cfg *phy_cfg;
@@ -303,18 +300,9 @@ static int rtk_phy_exit(struct phy *phy)
 	return 0;
 }
 
-static const struct phy_ops ops = {
-	.init		= rtk_phy_init,
-	.exit		= rtk_phy_exit,
-	.owner		= THIS_MODULE,
-};
-
-static void rtk_phy_toggle(struct usb_phy *usb3_phy, bool connect, int port)
+static void rtk_phy_toggle(struct rtk_phy *rtk_phy, bool connect, int port)
 {
 	int index = port;
-	struct rtk_phy *rtk_phy = NULL;
-
-	rtk_phy = dev_get_drvdata(usb3_phy->dev);
 
 	if (index > rtk_phy->num_phy) {
 		dev_err(rtk_phy->dev, "%s: The port=%d is not in usb phy (num_phy=%d)\n",
@@ -325,22 +313,34 @@ static void rtk_phy_toggle(struct usb_phy *usb3_phy, bool connect, int port)
 	do_rtk_usb3_phy_toggle(rtk_phy, index, connect);
 }
 
-static int rtk_phy_notify_port_status(struct usb_phy *x, int port,
-				      u16 portstatus, u16 portchange)
+static int rtk_phy_connect(struct phy *phy, int port)
 {
-	bool connect = false;
+	struct rtk_phy *rtk_phy = phy_get_drvdata(phy);
+
+	dev_dbg(rtk_phy->dev, "%s port=%d\n", __func__, port);
+	rtk_phy_toggle(rtk_phy, true, port);
+
+	return 0;
+}
 
-	pr_debug("%s port=%d portstatus=0x%x portchange=0x%x\n",
-		 __func__, port, (int)portstatus, (int)portchange);
-	if (portstatus & USB_PORT_STAT_CONNECTION)
-		connect = true;
+static int rtk_phy_disconnect(struct phy *phy, int port)
+{
+	struct rtk_phy *rtk_phy = phy_get_drvdata(phy);
 
-	if (portchange & USB_PORT_STAT_C_CONNECTION)
-		rtk_phy_toggle(x, connect, port);
+	dev_dbg(rtk_phy->dev, "%s port=%d\n", __func__, port);
+	rtk_phy_toggle(rtk_phy, false, port);
 
 	return 0;
 }
 
+static const struct phy_ops ops = {
+	.init		= rtk_phy_init,
+	.exit		= rtk_phy_exit,
+	.connect	= rtk_phy_connect,
+	.disconnect	= rtk_phy_disconnect,
+	.owner		= THIS_MODULE,
+};
+
 #ifdef CONFIG_DEBUG_FS
 static struct dentry *create_phy_debug_root(void)
 {
@@ -419,8 +419,6 @@ static inline void create_debug_files(struct rtk_phy *rtk_phy)
 
 	debugfs_create_file("parameter", 0444, rtk_phy->debug_dir, rtk_phy,
 			    &rtk_usb3_parameter_fops);
-
-	return;
 }
 
 static inline void remove_debug_files(struct rtk_phy *rtk_phy)
@@ -578,10 +576,6 @@ static int rtk_usb3phy_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	rtk_phy->dev			= &pdev->dev;
-	rtk_phy->phy.dev		= rtk_phy->dev;
-	rtk_phy->phy.label		= "rtk-usb3phy";
-	rtk_phy->phy.notify_port_status = rtk_phy_notify_port_status;
-
 	rtk_phy->phy_cfg = devm_kzalloc(dev, sizeof(*phy_cfg), GFP_KERNEL);
 
 	memcpy(rtk_phy->phy_cfg, phy_cfg, sizeof(*phy_cfg));
@@ -604,10 +598,6 @@ static int rtk_usb3phy_probe(struct platform_device *pdev)
 	if (IS_ERR(phy_provider))
 		return PTR_ERR(phy_provider);
 
-	ret = usb_add_phy_dev(&rtk_phy->phy);
-	if (ret)
-		goto err;
-
 	create_debug_files(rtk_phy);
 
 err:
@@ -619,8 +609,6 @@ static void rtk_usb3phy_remove(struct platform_device *pdev)
 	struct rtk_phy *rtk_phy = platform_get_drvdata(pdev);
 
 	remove_debug_files(rtk_phy);
-
-	usb_remove_phy(&rtk_phy->phy);
 }
 
 static const struct phy_cfg rtd1295_phy_cfg = {
-- 
2.34.1

