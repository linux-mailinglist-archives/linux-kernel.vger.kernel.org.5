Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D325F7E3546
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 07:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbjKGGhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 01:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjKGGhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 01:37:32 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C6910F;
        Mon,  6 Nov 2023 22:37:27 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A76aE2u94026654, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3A76aE2u94026654
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Nov 2023 14:36:14 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 7 Nov 2023 14:36:15 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 7 Nov 2023 14:36:14 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Tue, 7 Nov 2023 14:36:14 +0800
From:   Stanley Chang <stanley_chang@realtek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Stanley Chang <stanley_chang@realtek.com>,
        Vinod Koul <vkoul@kernel.org>, Johan Hovold <johan@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Rob Herring <robh@kernel.org>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Roy Luo <royluo@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        Ray Chi <raychi@google.com>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: [PATCH v1 4/4] usb: core: add phy notify connect and disconnect
Date:   Tue, 7 Nov 2023 14:33:47 +0800
Message-ID: <20231107063518.27824-4-stanley_chang@realtek.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107063518.27824-1-stanley_chang@realtek.com>
References: <20231107063518.27824-1-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS02.realtek.com.tw, 9
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

Recently added Realtek PHY driver depends on new port status
Notification mechanism built on the deprecated USB PHY implementation.
It's broken by design.

Therefore, USB port status notifications on legacy USB PHYs should be
removed. New mechanism for connect and disconnect USB devices using
to replace it on generic phy.

Additionally, the generic phy only specifies primary_hcd in the original
design. Added specific "usb2-phy" on primary_hcd and "usb3-phy" on
shared_hcd.

In Realtek SoC, the parameter of usb phy is designed to can dynamic
tuning base on device connect and disconnect. Therefore, add a notify
callback of generic phy driver when usb device connection change.

Check if portstatus is USB_PORT_STAT_CONNECTION and portchange is
USB_PORT_STAT_C_CONNECTION.
1. The device is connected, notify phy driver to calibrates
   the phy parameters.
2. The device disconnects, also notify driver to calibrates
   the phy parameters.

Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
---
 drivers/usb/core/hcd.c  | 14 ++++--
 drivers/usb/core/hub.c  | 16 ++++---
 drivers/usb/core/phy.c  | 94 +++++++++++++++++++++++++++++++++++++++++
 drivers/usb/core/phy.h  |  3 ++
 include/linux/usb/phy.h | 13 ------
 5 files changed, 118 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 12b6dfeaf658..992284461ad8 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2794,10 +2794,16 @@ int usb_add_hcd(struct usb_hcd *hcd,
 	struct usb_device *rhdev;
 	struct usb_hcd *shared_hcd;
 
-	if (!hcd->skip_phy_initialization && usb_hcd_is_primary_hcd(hcd)) {
-		hcd->phy_roothub = usb_phy_roothub_alloc(hcd->self.sysdev);
-		if (IS_ERR(hcd->phy_roothub))
-			return PTR_ERR(hcd->phy_roothub);
+	if (!hcd->skip_phy_initialization) {
+		if (usb_hcd_is_primary_hcd(hcd)) {
+			hcd->phy_roothub = usb_phy_roothub_alloc(hcd->self.sysdev);
+			if (IS_ERR(hcd->phy_roothub))
+				return PTR_ERR(hcd->phy_roothub);
+		} else {
+			hcd->phy_roothub = usb_phy_roothub_alloc_usb3_phy(hcd->self.sysdev);
+			if (IS_ERR(hcd->phy_roothub))
+				return PTR_ERR(hcd->phy_roothub);
+		}
 
 		retval = usb_phy_roothub_init(hcd->phy_roothub);
 		if (retval)
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index b4584a0cd484..65c0454ee70a 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -37,6 +37,7 @@
 #include <asm/byteorder.h>
 
 #include "hub.h"
+#include "phy.h"
 #include "otg_productlist.h"
 
 #define USB_VENDOR_GENESYS_LOGIC		0x05e3
@@ -632,16 +633,21 @@ static int hub_ext_port_status(struct usb_hub *hub, int port1, int type,
 		struct usb_device *hdev = hub->hdev;
 
 		/*
-		 * Only roothub will be notified of port state changes,
+		 * Only roothub will be notified of connection changes,
 		 * since the USB PHY only cares about changes at the next
 		 * level.
 		 */
 		if (is_root_hub(hdev)) {
 			struct usb_hcd *hcd = bus_to_hcd(hdev->bus);
-
-			if (hcd->usb_phy)
-				usb_phy_notify_port_status(hcd->usb_phy,
-							   port1 - 1, *status, *change);
+			bool connect;
+			bool connect_change;
+
+			connect_change = *change & USB_PORT_STAT_C_CONNECTION;
+			connect = *status & USB_PORT_STAT_CONNECTION;
+			if (connect_change && connect)
+				usb_phy_roothub_notify_connect(hcd->phy_roothub, port1 - 1);
+			else if (connect_change)
+				usb_phy_roothub_notify_disconnect(hcd->phy_roothub, port1 - 1);
 		}
 	}
 
diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
index fb1588e7c282..26585fc1ec32 100644
--- a/drivers/usb/core/phy.c
+++ b/drivers/usb/core/phy.c
@@ -19,6 +19,29 @@ struct usb_phy_roothub {
 	struct list_head	list;
 };
 
+static int usb_phy_roothub_add_phy_by_name(struct device *dev, const char *name,
+					   struct list_head *list)
+{
+	struct usb_phy_roothub *roothub_entry;
+	struct phy *phy;
+
+	phy = devm_of_phy_get(dev, dev->of_node, name);
+	if (IS_ERR(phy))
+		return PTR_ERR(phy);
+
+	roothub_entry = devm_kzalloc(dev, sizeof(*roothub_entry), GFP_KERNEL);
+	if (!roothub_entry)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&roothub_entry->list);
+
+	roothub_entry->phy = phy;
+
+	list_add_tail(&roothub_entry->list, list);
+
+	return 0;
+}
+
 static int usb_phy_roothub_add_phy(struct device *dev, int index,
 				   struct list_head *list)
 {
@@ -65,6 +88,9 @@ struct usb_phy_roothub *usb_phy_roothub_alloc(struct device *dev)
 
 	INIT_LIST_HEAD(&phy_roothub->list);
 
+	if (!usb_phy_roothub_add_phy_by_name(dev, "usb2-phy", &phy_roothub->list))
+		return phy_roothub;
+
 	for (i = 0; i < num_phys; i++) {
 		err = usb_phy_roothub_add_phy(dev, i, &phy_roothub->list);
 		if (err)
@@ -75,6 +101,32 @@ struct usb_phy_roothub *usb_phy_roothub_alloc(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(usb_phy_roothub_alloc);
 
+struct usb_phy_roothub *usb_phy_roothub_alloc_usb3_phy(struct device *dev)
+{
+	struct usb_phy_roothub *phy_roothub;
+	int num_phys;
+
+	if (!IS_ENABLED(CONFIG_GENERIC_PHY))
+		return NULL;
+
+	num_phys = of_count_phandle_with_args(dev->of_node, "phys",
+					      "#phy-cells");
+	if (num_phys <= 0)
+		return NULL;
+
+	phy_roothub = devm_kzalloc(dev, sizeof(*phy_roothub), GFP_KERNEL);
+	if (!phy_roothub)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&phy_roothub->list);
+
+	if (!usb_phy_roothub_add_phy_by_name(dev, "usb3-phy", &phy_roothub->list))
+		return phy_roothub;
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(usb_phy_roothub_alloc_usb3_phy);
+
 int usb_phy_roothub_init(struct usb_phy_roothub *phy_roothub)
 {
 	struct usb_phy_roothub *roothub_entry;
@@ -172,6 +224,48 @@ int usb_phy_roothub_calibrate(struct usb_phy_roothub *phy_roothub)
 }
 EXPORT_SYMBOL_GPL(usb_phy_roothub_calibrate);
 
+int usb_phy_roothub_notify_connect(struct usb_phy_roothub *phy_roothub, int port)
+{
+	struct usb_phy_roothub *roothub_entry;
+	struct list_head *head;
+	int err;
+
+	if (!phy_roothub)
+		return 0;
+
+	head = &phy_roothub->list;
+
+	list_for_each_entry(roothub_entry, head, list) {
+		err = phy_notify_connect(roothub_entry->phy, port);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(usb_phy_roothub_notify_connect);
+
+int usb_phy_roothub_notify_disconnect(struct usb_phy_roothub *phy_roothub, int port)
+{
+	struct usb_phy_roothub *roothub_entry;
+	struct list_head *head;
+	int err;
+
+	if (!phy_roothub)
+		return 0;
+
+	head = &phy_roothub->list;
+
+	list_for_each_entry(roothub_entry, head, list) {
+		err = phy_notify_disconnect(roothub_entry->phy, port);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(usb_phy_roothub_notify_disconnect);
+
 int usb_phy_roothub_power_on(struct usb_phy_roothub *phy_roothub)
 {
 	struct usb_phy_roothub *roothub_entry;
diff --git a/drivers/usb/core/phy.h b/drivers/usb/core/phy.h
index 20a267cd986b..88b49c0ea6b5 100644
--- a/drivers/usb/core/phy.h
+++ b/drivers/usb/core/phy.h
@@ -12,6 +12,7 @@ struct device;
 struct usb_phy_roothub;
 
 struct usb_phy_roothub *usb_phy_roothub_alloc(struct device *dev);
+struct usb_phy_roothub *usb_phy_roothub_alloc_usb3_phy(struct device *dev);
 
 int usb_phy_roothub_init(struct usb_phy_roothub *phy_roothub);
 int usb_phy_roothub_exit(struct usb_phy_roothub *phy_roothub);
@@ -19,6 +20,8 @@ int usb_phy_roothub_exit(struct usb_phy_roothub *phy_roothub);
 int usb_phy_roothub_set_mode(struct usb_phy_roothub *phy_roothub,
 			     enum phy_mode mode);
 int usb_phy_roothub_calibrate(struct usb_phy_roothub *phy_roothub);
+int usb_phy_roothub_notify_connect(struct usb_phy_roothub *phy_roothub, int port);
+int usb_phy_roothub_notify_disconnect(struct usb_phy_roothub *phy_roothub, int port);
 int usb_phy_roothub_power_on(struct usb_phy_roothub *phy_roothub);
 void usb_phy_roothub_power_off(struct usb_phy_roothub *phy_roothub);
 
diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
index b513749582d7..e4de6bc1f69b 100644
--- a/include/linux/usb/phy.h
+++ b/include/linux/usb/phy.h
@@ -144,10 +144,6 @@ struct usb_phy {
 	 */
 	int	(*set_wakeup)(struct usb_phy *x, bool enabled);
 
-	/* notify phy port status change */
-	int	(*notify_port_status)(struct usb_phy *x, int port,
-				      u16 portstatus, u16 portchange);
-
 	/* notify phy connect status change */
 	int	(*notify_connect)(struct usb_phy *x,
 			enum usb_device_speed speed);
@@ -320,15 +316,6 @@ usb_phy_set_wakeup(struct usb_phy *x, bool enabled)
 		return 0;
 }
 
-static inline int
-usb_phy_notify_port_status(struct usb_phy *x, int port, u16 portstatus, u16 portchange)
-{
-	if (x && x->notify_port_status)
-		return x->notify_port_status(x, port, portstatus, portchange);
-	else
-		return 0;
-}
-
 static inline int
 usb_phy_notify_connect(struct usb_phy *x, enum usb_device_speed speed)
 {
-- 
2.34.1

