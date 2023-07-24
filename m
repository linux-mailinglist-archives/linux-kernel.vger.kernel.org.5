Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57D775F371
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjGXKgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjGXKgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:36:50 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 387A9DD;
        Mon, 24 Jul 2023 03:36:49 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36OAZoHY2028924, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36OAZoHY2028924
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 24 Jul 2023 18:35:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 24 Jul 2023 18:36:01 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 24 Jul 2023 18:36:01 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Mon, 24 Jul 2023 18:36:01 +0800
From:   Stanley Chang <stanley_chang@realtek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Stanley Chang <stanley_chang@realtek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Roy Luo <royluo@google.com>, Ray Chi <raychi@google.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: [PATCH v8 1/5] usb: phy: add usb phy notify port status API
Date:   Mon, 24 Jul 2023 18:34:48 +0800
Message-ID: <20230724103600.14164-1-stanley_chang@realtek.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

In Realtek SoC, the parameter of usb phy is designed to can dynamic
tuning base on port status. Therefore, add a notify callback of phy
driver when usb port status change.

The Realtek phy driver is designed to dynamically adjust disconnection
level and calibrate phy parameters. When the device connected bit changes
and when the disconnected bit changes, do port status change notification:

Check if portstatus is USB_PORT_STAT_CONNECTION and portchange is
USB_PORT_STAT_C_CONNECTION.
1. The device is connected, the driver lowers the disconnection level and
   calibrates the phy parameters.
2. The device disconnects, the driver increases the disconnect level and
   calibrates the phy parameters.

When controller to notify connect that device is already ready. If we
adjust the disconnection level in notify_connect, the disconnect may have
been triggered at this stage. So we need to change that as early as
possible. The status change of connection is before port reset.
Therefore, we add an api to notify phy the port status changes. In this
stage, the device is not port enable, and it will not trigger disconnection.

Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
---
v7 to v8 change:
    Add more comments about this api.
v6 to v7 change:
    No change
v5 to v6 change:
    No change
v4 to v5 change:
    No change
v3 to v4 change:
    Fix the warning for checkpatch with strict.
v2 to v3 change:
    Add more comments about the reason for adding this api
v1 to v2 change:
    No change
---
 drivers/usb/core/hub.c  | 24 ++++++++++++++++++++++++
 include/linux/usb/phy.h | 13 +++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index a739403a9e45..cd2c9c6eab95 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -614,6 +614,30 @@ static int hub_ext_port_status(struct usb_hub *hub, int port1, int type,
 		ret = 0;
 	}
 	mutex_unlock(&hub->status_mutex);
+
+	/*
+	 * There is no need to lock status_mutex here, because status_mutex
+	 * protects hub->status, and the phy driver only checks the port
+	 * status without changing the status.
+	 */
+	if (!ret) {
+		struct usb_device *hdev = hub->hdev;
+
+		/*
+		 * Applies to roothub only. That is, when hdev->parent is
+		 * empty. Only roothub will be notified of port state
+		 * changes, since the USB PHY only cares about changes at
+		 * the next level.
+		 */
+		if (hdev && !hdev->parent) {
+			struct usb_hcd *hcd = bus_to_hcd(hdev->bus);
+
+			if (hcd->usb_phy)
+				usb_phy_notify_port_status(hcd->usb_phy,
+							   port1 - 1, *status, *change);
+		}
+	}
+
 	return ret;
 }
 
diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
index e4de6bc1f69b..b513749582d7 100644
--- a/include/linux/usb/phy.h
+++ b/include/linux/usb/phy.h
@@ -144,6 +144,10 @@ struct usb_phy {
 	 */
 	int	(*set_wakeup)(struct usb_phy *x, bool enabled);
 
+	/* notify phy port status change */
+	int	(*notify_port_status)(struct usb_phy *x, int port,
+				      u16 portstatus, u16 portchange);
+
 	/* notify phy connect status change */
 	int	(*notify_connect)(struct usb_phy *x,
 			enum usb_device_speed speed);
@@ -316,6 +320,15 @@ usb_phy_set_wakeup(struct usb_phy *x, bool enabled)
 		return 0;
 }
 
+static inline int
+usb_phy_notify_port_status(struct usb_phy *x, int port, u16 portstatus, u16 portchange)
+{
+	if (x && x->notify_port_status)
+		return x->notify_port_status(x, port, portstatus, portchange);
+	else
+		return 0;
+}
+
 static inline int
 usb_phy_notify_connect(struct usb_phy *x, enum usb_device_speed speed)
 {
-- 
2.34.1

