Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52ECC810894
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 04:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378401AbjLMDNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 22:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjLMDNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 22:13:21 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0862CB2;
        Tue, 12 Dec 2023 19:13:23 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BD3C6prC3944118, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BD3C6prC3944118
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Dec 2023 11:12:06 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 13 Dec 2023 11:12:06 +0800
Received: from RTEXH36506.realtek.com.tw (172.21.6.27) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 13 Dec 2023 11:12:03 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server id
 15.1.2507.17 via Frontend Transport; Wed, 13 Dec 2023 11:12:03 +0800
From:   Stanley Chang <stanley_chang@realtek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Stanley Chang <stanley_chang@realtek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Rob Herring <robh@kernel.org>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        Roy Luo <royluo@google.com>,
        =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH v4 1/4] phy: core: add notify_connect and notify_disconnect callback
Date:   Wed, 13 Dec 2023 11:10:06 +0800
Message-ID: <20231213031203.4911-1-stanley_chang@realtek.com>
X-Mailer: git-send-email 2.43.0
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

In Realtek SoC, the parameter of usb phy is designed to be able to
do dynamic tuning based in the port status. Therefore, add a notify
callback of phy driver when usb connection/disconnection change.

Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
---
v3 to v4 change:
   1. Modified some phrasing.
   2. Add the description for callback function.
v2 to v3:
    No change
v1 to v2:
    No change
---
 drivers/phy/phy-core.c  | 47 +++++++++++++++++++++++++++++++++++++++++
 include/linux/phy/phy.h | 21 ++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 96a0b1e111f3..acfa408a3ca5 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -489,6 +489,53 @@ int phy_calibrate(struct phy *phy)
 }
 EXPORT_SYMBOL_GPL(phy_calibrate);
 
+/**
+ * phy_notify_connect() - phy connect notification
+ * @phy: the phy returned by phy_get()
+ * @port: the port index for connect
+ *
+ * If the phy needs to get connection status, the callback can be used.
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
+ * phy_notify_disconnect() - phy disconnect notification
+ * @phy: the phy returned by phy_get()
+ * @port: the port index for disconnect
+ *
+ * If the phy needs to get connection status, the callback can be used.
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
index f6d607ef0e80..aa76609ba258 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -122,6 +122,11 @@ struct phy_ops {
 			    union phy_configure_opts *opts);
 	int	(*reset)(struct phy *phy);
 	int	(*calibrate)(struct phy *phy);
+
+	/* notify phy connect status change */
+	int	(*connect)(struct phy *phy, int port);
+	int	(*disconnect)(struct phy *phy, int port);
+
 	void	(*release)(struct phy *phy);
 	struct module *owner;
 };
@@ -243,6 +248,8 @@ static inline enum phy_mode phy_get_mode(struct phy *phy)
 }
 int phy_reset(struct phy *phy);
 int phy_calibrate(struct phy *phy);
+int phy_notify_connect(struct phy *phy, int port);
+int phy_notify_disconnect(struct phy *phy, int port);
 static inline int phy_get_bus_width(struct phy *phy)
 {
 	return phy->attrs.bus_width;
@@ -396,6 +403,20 @@ static inline int phy_calibrate(struct phy *phy)
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

