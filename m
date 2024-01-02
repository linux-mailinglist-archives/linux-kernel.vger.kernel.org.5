Return-Path: <linux-kernel+bounces-14243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B27468219C7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD20282BA1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D1CE546;
	Tue,  2 Jan 2024 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GHZw89Z2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568FEDF51;
	Tue,  2 Jan 2024 10:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 402ATpYu012619;
	Tue, 2 Jan 2024 04:29:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704191391;
	bh=py4JJm+wTIiadC5aI9EnyBmLyFhvonKYqsl52ZyUjE8=;
	h=From:To:CC:Subject:Date;
	b=GHZw89Z26f/IbpjxHF70MbGJrqMHhvQI1nKCRMpx2yMfaNlgCvR9ZpF2xYnr85Lj1
	 M/tjHyCgsMpBGISjVzOKK/nZKd2J7sKulzt3uq/4TBD3xNLcFsvQax2UyLQhHLs7gI
	 PGJ++7P9xXYSs6eHcK1Q2wl6ISbZkff7ojxiFczQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 402ATpfN025970
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Jan 2024 04:29:51 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Jan 2024 04:29:51 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Jan 2024 04:29:50 -0600
Received: from localhost ([10.249.131.155])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 402AToSq071024;
	Tue, 2 Jan 2024 04:29:50 -0600
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <linux-can@vger.kernel.org>, <b-kapoor@ti.com>,
        <mailhol.vincent@wanadoo.fr>, <rcsekar@samsung.com>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <mkl@pengutronix.de>, <wg@grandegger.com>,
        <vigneshr@ti.com>, <u-kumar1@ti.com>
Subject: [PATCH] net: can: Add support for aliases in CAN
Date: Tue, 2 Jan 2024 15:59:49 +0530
Message-ID: <20240102102949.138607-1-b-kapoor@ti.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

When multiple CAN's are present, then names that are getting assigned
changes after every boot even after providing alias in the device tree.
Thus, Add support for implementing CAN aliasing so that names or
alias for CAN will now be provided from device tree.

Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---
 drivers/net/can/dev/dev.c     | 15 ++++++++++++---
 drivers/net/can/m_can/m_can.c |  2 +-
 include/linux/can/dev.h       |  8 +++++---
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 3a3be5cdfc1f..ed483c23ec79 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -247,12 +247,14 @@ void can_setup(struct net_device *dev)
 
 /* Allocate and setup space for the CAN network device */
 struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
-				    unsigned int txqs, unsigned int rxqs)
+					unsigned int txqs, unsigned int rxqs,
+					struct device *candev)
 {
 	struct can_ml_priv *can_ml;
 	struct net_device *dev;
 	struct can_priv *priv;
-	int size;
+	int size, aliasid;
+	char devname[6] = "can%d";
 
 	/* We put the driver's priv, the CAN mid layer priv and the
 	 * echo skb into the netdevice's priv. The memory layout for
@@ -273,7 +275,14 @@ struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
 		size = ALIGN(size, sizeof(struct sk_buff *)) +
 			echo_skb_max * sizeof(struct sk_buff *);
 
-	dev = alloc_netdev_mqs(size, "can%d", NET_NAME_UNKNOWN, can_setup,
+	if (candev) {
+		aliasid = of_alias_get_id(candev->of_node, "can");
+		if (aliasid >= 0)
+			snprintf(devname, sizeof(devname), "%s%d", "can", aliasid);
+	}
+	dev_dbg(candev, "Name of CAN assigned is : %s\n", devname);
+
+	dev = alloc_netdev_mqs(size, devname, NET_NAME_UNKNOWN, can_setup,
 			       txqs, rxqs);
 	if (!dev)
 		return NULL;
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 16ecc11c7f62..c91a5c7b3ae5 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2029,7 +2029,7 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 	tx_fifo_size = mram_config_vals[7];
 
 	/* allocate the m_can device */
-	net_dev = alloc_candev(sizeof_priv, tx_fifo_size);
+	net_dev = alloc_candev_with_dev(sizeof_priv, tx_fifo_size, dev);
 	if (!net_dev) {
 		dev_err(dev, "Failed to allocate CAN device");
 		goto out;
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 1b92aed49363..b59142c16e59 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -171,11 +171,13 @@ static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *s
 void can_setup(struct net_device *dev);
 
 struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
-				    unsigned int txqs, unsigned int rxqs);
+					unsigned int txqs, unsigned int rxqs, struct device *dev);
 #define alloc_candev(sizeof_priv, echo_skb_max) \
-	alloc_candev_mqs(sizeof_priv, echo_skb_max, 1, 1)
+	alloc_candev_mqs(sizeof_priv, echo_skb_max, 1, 1, NULL)
+#define alloc_candev_with_dev(sizeof_priv, echo_skb_max, dev) \
+	alloc_candev_mqs(sizeof_priv, echo_skb_max, 1, 1, dev)
 #define alloc_candev_mq(sizeof_priv, echo_skb_max, count) \
-	alloc_candev_mqs(sizeof_priv, echo_skb_max, count, count)
+	alloc_candev_mqs(sizeof_priv, echo_skb_max, count, count, NULL)
 void free_candev(struct net_device *dev);
 
 /* a candev safe wrapper around netdev_priv */
-- 
2.40.1


