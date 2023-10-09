Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D1B7BE819
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377884AbjJIRbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377880AbjJIRbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:31:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB419E;
        Mon,  9 Oct 2023 10:31:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FB0C433C8;
        Mon,  9 Oct 2023 17:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696872705;
        bh=OhjQeQRnExrpooqKh3gh9c6wU+rd8LzpqzmrgKzmc1o=;
        h=From:To:Cc:Subject:Date:From;
        b=kKZXKZ6G5xb7CpuYYHYWBpSUVmVlufI1wRkUJBTC7MaTrnX9pu4RW64/9fhopzTyU
         N/kqKCVUtoospBJ9FMM3D4arIyg6JcahLl+0PiJQ2JPJhA6eKVUf0o6X8dC21t+zbM
         1Na/83qcJeyJvDxGYHgl0K86pmV8qxGHn89x1kwIRp5thPEBueG8dGKVGIH66LO+uR
         mRKR10lUSWIEJ/7WhjQDx3VSvFvSpGIo0vvhOB/vT9UAEf6BLqVEELVVb+xUDuWdR8
         Pc5FM+8A5D2Ov9o751mQme1EzDwf3CpIt4UqhAeNtzMm8SexP38NZOTdaHVDgcKFdS
         SnMK4KehDfC8w==
Received: (nullmailer pid 2511395 invoked by uid 1000);
        Mon, 09 Oct 2023 17:31:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Michal Simek <michal.simek@amd.com>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next] net: can: Use device_get_match_data()
Date:   Mon,  9 Oct 2023 12:29:02 -0500
Message-ID: <20231009172923.2457844-7-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/net/can/c_can/c_can_platform.c | 9 +++------
 drivers/net/can/flexcan/flexcan-core.c | 9 +++------
 drivers/net/can/mscan/mpc5xxx_can.c    | 8 ++++----
 drivers/net/can/xilinx_can.c           | 7 ++-----
 4 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index f44ba2600415..caa781018b09 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -30,9 +30,9 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/clk.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 
@@ -259,17 +259,14 @@ static int c_can_plat_probe(struct platform_device *pdev)
 	void __iomem *addr;
 	struct net_device *dev;
 	struct c_can_priv *priv;
-	const struct of_device_id *match;
 	struct resource *mem;
 	int irq;
 	struct clk *clk;
 	const struct c_can_driver_data *drvdata;
 	struct device_node *np = pdev->dev.of_node;
 
-	match = of_match_device(c_can_of_table, &pdev->dev);
-	if (match) {
-		drvdata = match->data;
-	} else if (pdev->id_entry->driver_data) {
+	drvdata = device_get_match_data(&pdev->dev);
+	if (!drvdata && pdev->id_entry->driver_data) {
 		drvdata = (struct c_can_driver_data *)
 			platform_get_device_id(pdev)->driver_data;
 	} else {
diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index add39e922b89..b9dd9597fc97 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -23,11 +23,11 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/can/platform/flexcan.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
@@ -2040,7 +2040,6 @@ MODULE_DEVICE_TABLE(platform, flexcan_id_table);
 
 static int flexcan_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id;
 	const struct flexcan_devtype_data *devtype_data;
 	struct net_device *dev;
 	struct flexcan_priv *priv;
@@ -2096,10 +2095,8 @@ static int flexcan_probe(struct platform_device *pdev)
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
-	of_id = of_match_device(flexcan_of_match, &pdev->dev);
-	if (of_id)
-		devtype_data = of_id->data;
-	else if (platform_get_device_id(pdev)->driver_data)
+	devtype_data = device_get_match_data(&pdev->dev);
+	if (!devtype_data && pdev->id_entry->driver_data)
 		devtype_data = (struct flexcan_devtype_data *)
 			platform_get_device_id(pdev)->driver_data;
 	else
diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/mscan/mpc5xxx_can.c
index 4837df6efa92..5b3d69c3b6b6 100644
--- a/drivers/net/can/mscan/mpc5xxx_can.c
+++ b/drivers/net/can/mscan/mpc5xxx_can.c
@@ -12,8 +12,10 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/netdevice.h>
 #include <linux/can/dev.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
@@ -290,7 +292,7 @@ static int mpc5xxx_can_probe(struct platform_device *ofdev)
 	int irq, mscan_clksrc = 0;
 	int err = -ENOMEM;
 
-	data = of_device_get_match_data(&ofdev->dev);
+	data = device_get_match_data(&ofdev->dev);
 	if (!data)
 		return -EINVAL;
 
@@ -351,13 +353,11 @@ static int mpc5xxx_can_probe(struct platform_device *ofdev)
 
 static void mpc5xxx_can_remove(struct platform_device *ofdev)
 {
-	const struct of_device_id *match;
 	const struct mpc5xxx_can_data *data;
 	struct net_device *dev = platform_get_drvdata(ofdev);
 	struct mscan_priv *priv = netdev_priv(dev);
 
-	match = of_match_device(mpc5xxx_can_table, &ofdev->dev);
-	data = match ? match->data : NULL;
+	data = device_get_match_data(&ofdev->dev);
 
 	unregister_mscandev(dev);
 	if (data && data->put_clock)
diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index abe58f103043..f17fd43d03c0 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -20,8 +20,8 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/skbuff.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
@@ -1726,7 +1726,6 @@ static int xcan_probe(struct platform_device *pdev)
 	struct net_device *ndev;
 	struct xcan_priv *priv;
 	struct phy *transceiver;
-	const struct of_device_id *of_id;
 	const struct xcan_devtype_data *devtype = &xcan_axi_data;
 	void __iomem *addr;
 	int ret;
@@ -1741,9 +1740,7 @@ static int xcan_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	of_id = of_match_device(xcan_of_match, &pdev->dev);
-	if (of_id && of_id->data)
-		devtype = of_id->data;
+	devtype = device_get_match_data(&pdev->dev);
 
 	hw_tx_max_property = devtype->flags & XCAN_FLAG_TX_MAILBOXES ?
 			     "tx-mailbox-count" : "tx-fifo-depth";
-- 
2.42.0

