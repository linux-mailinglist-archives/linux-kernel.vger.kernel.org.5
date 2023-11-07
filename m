Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275B07E3544
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 07:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbjKGGhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 01:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjKGGhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 01:37:31 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766B2119;
        Mon,  6 Nov 2023 22:37:27 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A76ZJYm84026363, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3A76ZJYm84026363
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Nov 2023 14:35:19 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 7 Nov 2023 14:35:19 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 7 Nov 2023 14:35:19 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Tue, 7 Nov 2023 14:35:19 +0800
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
        Roy Luo <royluo@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Ray Chi <raychi@google.com>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: [PATCH v1 1/4] phy: core: add notify_connect and notify_disconnect callback
Date:   Tue, 7 Nov 2023 14:33:44 +0800
Message-ID: <20231107063518.27824-1-stanley_chang@realtek.com>
X-Mailer: git-send-email 2.42.0
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

In Realtek SoC, the parameter of usb phy is designed to can dynamic
tuning base on port status. Therefore, add a notify callback of phy
driver when usb connection/disconnection change.

Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
---
 drivers/phy/phy-core.c  | 47 +++++++++++++++++++++++++++++++++++++++++
 include/linux/phy/phy.h | 18 ++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 96a0b1e111f3..a84ad4896b7f 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -489,6 +489,53 @@ int phy_calibrate(struct phy *phy)
 }
 EXPORT_SYMBOL_GPL(phy_calibrate);
 
+/**
+ * phy_notify_connect() - phy connect notify
+ * @phy: the phy returned by phy_get()
+ * @port: the port index for connect
+ *
+ * If phy need the get connection status, the callback can be used.
+ * Returns: %0 if successful, a negative error code otherwise
+ */
+int phy_notify_connect(struct phy *phy, int port)
+{
+	int ret;
+
+	if (!phy || !phy->ops->connect)
+		return 0;
+
+	mutex_lock(&phy->mutex);
+	ret = phy->ops->connect(phy, port);
+	mutex_unlock(&phy->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(phy_notify_connect);
+
+/**
+ * phy_notify_disconnect() - phy disconnect notify
+ * @phy: the phy returned by phy_get()
+ * @port: the port index for disconnect
+ *
+ * If phy need the get disconnection status, the callback can be used.
+ *
+ * Returns: %0 if successful, a negative error code otherwise
+ */
+int phy_notify_disconnect(struct phy *phy, int port)
+{
+	int ret;
+
+	if (!phy || !phy->ops->disconnect)
+		return 0;
+
+	mutex_lock(&phy->mutex);
+	ret = phy->ops->disconnect(phy, port);
+	mutex_unlock(&phy->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(phy_notify_disconnect);
+
 /**
  * phy_configure() - Changes the phy parameters
  * @phy: the phy returned by phy_get()
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index f6d607ef0e80..cf98cb29ddaa 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -122,6 +122,8 @@ struct phy_ops {
 			    union phy_configure_opts *opts);
 	int	(*reset)(struct phy *phy);
 	int	(*calibrate)(struct phy *phy);
+	int	(*connect)(struct phy *phy, int port);
+	int	(*disconnect)(struct phy *phy, int port);
 	void	(*release)(struct phy *phy);
 	struct module *owner;
 };
@@ -243,6 +245,8 @@ static inline enum phy_mode phy_get_mode(struct phy *phy)
 }
 int phy_reset(struct phy *phy);
 int phy_calibrate(struct phy *phy);
+int phy_notify_connect(struct phy *phy, int port);
+int phy_notify_disconnect(struct phy *phy, int port);
 static inline int phy_get_bus_width(struct phy *phy)
 {
 	return phy->attrs.bus_width;
@@ -396,6 +400,20 @@ static inline int phy_calibrate(struct phy *phy)
 	return -ENOSYS;
 }
 
+static inline int phy_notify_connect(struct phy *phy, int index)
+{
+	if (!phy)
+		return 0;
+	return -ENOSYS;
+}
+
+static inline int phy_notify_disconnect(struct phy *phy, int index)
+{
+	if (!phy)
+		return 0;
+	return -ENOSYS;
+}
+
 static inline int phy_configure(struct phy *phy,
 				union phy_configure_opts *opts)
 {
-- 
2.34.1

