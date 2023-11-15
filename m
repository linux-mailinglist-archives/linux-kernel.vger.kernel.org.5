Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782997ED53E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344674AbjKOVCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344704AbjKOVCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:02:00 -0500
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E4CD79;
        Wed, 15 Nov 2023 13:01:34 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5869914484fso66072eaf.0;
        Wed, 15 Nov 2023 13:01:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700082094; x=1700686894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Duhiu363zZXggZ2tT9xIehHJIKV7YXtPT/E+W7lu59o=;
        b=X+FOlwkhkepXg0QMxwUliO87bV2PrfEsIJyNdzTqkZqMwC7cfXK/Da1mJnu3qNNPet
         nFKNHg6rwYanRYUH0oYYn9obP2NEBB/XtU4PPKrJ3E+ZOiaS7OGdJuoBeZ6/A74j1QaN
         vK0Nlq+61ZzJTRP8uWmBSoM8xp9BdE+BOKcK1gfTcJqCmzW945NUyJ3meElF8jkIxAHL
         Zkq7+g5az9QixsKACOWKZdY+uoWADHLUXG/RzfiNBCS1uayTjvKQuYi8q/AWmUwTWsfq
         sIzkC55ZJ7p1ezxLnkjfpyxeoZVSjk9Mz6EIY7bSVcefPXuWIFunMbQPleXDCfqyEEYO
         V2Sg==
X-Gm-Message-State: AOJu0YzuoyGg7z6DLw3dTMBBgJnEaM3de9oa2okjn6mLtX9jrNIewBgE
        lKUzDZQGzJvpwHZJQ5xn9Q==
X-Google-Smtp-Source: AGHT+IFPPnhO39v8qSE2EKT/HxIVWh6OStRmuQ0hHy6sDMZSxY8Jttc7oJW7BQ2s36jYm/8+/W5SXQ==
X-Received: by 2002:a4a:3457:0:b0:56c:d297:164c with SMTP id n23-20020a4a3457000000b0056cd297164cmr13317917oof.4.1700082094065;
        Wed, 15 Nov 2023 13:01:34 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 123-20020a4a0081000000b00584078d1e17sm826254ooh.45.2023.11.15.13.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 13:01:33 -0800 (PST)
Received: (nullmailer pid 3740022 invoked by uid 1000);
        Wed, 15 Nov 2023 21:01:32 -0000
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
Subject: [RESEND PATCH] net: can: Use device_get_match_data()
Date:   Wed, 15 Nov 2023 15:01:28 -0600
Message-ID: <20231115210129.3739377-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
index d15f85a40c1e..19ea7ebc04ab 100644
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
 
@@ -2034,7 +2034,6 @@ MODULE_DEVICE_TABLE(platform, flexcan_id_table);
 
 static int flexcan_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id;
 	const struct flexcan_devtype_data *devtype_data;
 	struct net_device *dev;
 	struct flexcan_priv *priv;
@@ -2090,10 +2089,8 @@ static int flexcan_probe(struct platform_device *pdev)
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

