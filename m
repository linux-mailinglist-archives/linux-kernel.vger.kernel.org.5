Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8F37F4EE1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344312AbjKVSB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344293AbjKVSB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:01:57 -0500
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354001B3;
        Wed, 22 Nov 2023 10:01:53 -0800 (PST)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-357ccaf982eso142485ab.0;
        Wed, 22 Nov 2023 10:01:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700676112; x=1701280912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=If8d0YtZJS0mQrEYNoRxWpqFNsU6KzCVMh6IszFfggc=;
        b=Yhfd1+HoF7cNyR9ezXQhgeBCA+4CDwxOfpWtpyPtc8rNIh1xn8UWhrPd4rzaOSuPyo
         xWuY9/i3eHB8YMSoBRJXPJTgSKPHn23+UcVy15l8ar5hO8JGPGlSM3+Nlyoy9iHS4ius
         NnNbtwBD4IJal8UeWMvJXuzdcrx93c0xQKLwWur0cA0kdVyDRs34zoNuK2zUXEQjyRZg
         i+FH1unuBDtVVN3kvO5PFp4cK1S0Norxxnq77jubWVmXKpdzDQhSBm1tYig4caADN+kZ
         FlHapmdKS9Rdtk7HPvpGWlDNQfcHaNeidmYWkmCJfLrK7r0MZxSBSMuSuNJShy7Iggkd
         0wsQ==
X-Gm-Message-State: AOJu0Yw7ZcAgNJN1grjpaCHpWzPYjbFIgENzKeoz47q6M1Bf6AfhF6Lc
        mU3sBETxFV2ApVliKBylEw==
X-Google-Smtp-Source: AGHT+IF1dkbNJetLgO0LDH6ZmMlsbwQjH0FPKo8tVU1ObnCUsCKI/ybOACitXlO0Xw/jZM71V94chA==
X-Received: by 2002:a05:6e02:20c7:b0:35a:d0b3:427a with SMTP id 7-20020a056e0220c700b0035ad0b3427amr3956494ilq.1.1700676112384;
        Wed, 22 Nov 2023 10:01:52 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v19-20020a056638359300b004665c29605fsm1766820jal.139.2023.11.22.10.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 10:01:51 -0800 (PST)
Received: (nullmailer pid 1433277 invoked by uid 1000);
        Wed, 22 Nov 2023 18:01:49 -0000
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
Cc:     Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] net: can: Use device_get_match_data()
Date:   Wed, 22 Nov 2023 11:01:39 -0700
Message-ID: <20231122180140.1432025-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Error checking for matching and match data was not necessary as matching
is always successful if we're already in probe and the match tables always
have data pointers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
  - Drop calling "platform_get_device_id(pdev)->driver_data" in c_can
    and flexcan as device_get_match_data() already did that. The logic
    was also wrong and would have resulted in returning -ENODEV.
  - Drop initializing devtype in xilinx_can
---
 drivers/net/can/c_can/c_can_platform.c | 13 ++-----------
 drivers/net/can/flexcan/flexcan-core.c | 12 ++----------
 drivers/net/can/mscan/mpc5xxx_can.c    |  8 ++++----
 drivers/net/can/xilinx_can.c           |  9 +++------
 4 files changed, 11 insertions(+), 31 deletions(-)

diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index f44ba2600415..e2ec69aa46e5 100644
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
 
@@ -259,22 +259,13 @@ static int c_can_plat_probe(struct platform_device *pdev)
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
-		drvdata = (struct c_can_driver_data *)
-			platform_get_device_id(pdev)->driver_data;
-	} else {
-		return -ENODEV;
-	}
+	drvdata = device_get_match_data(&pdev->dev);
 
 	/* get the appropriate clk */
 	clk = devm_clk_get(&pdev->dev, NULL);
diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index d15f85a40c1e..8ea7f2795551 100644
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
@@ -2090,14 +2089,7 @@ static int flexcan_probe(struct platform_device *pdev)
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
-	of_id = of_match_device(flexcan_of_match, &pdev->dev);
-	if (of_id)
-		devtype_data = of_id->data;
-	else if (platform_get_device_id(pdev)->driver_data)
-		devtype_data = (struct flexcan_devtype_data *)
-			platform_get_device_id(pdev)->driver_data;
-	else
-		return -ENODEV;
+	devtype_data = device_get_match_data(&pdev->dev);
 
 	if ((devtype_data->quirks & FLEXCAN_QUIRK_SUPPORT_FD) &&
 	    !((devtype_data->quirks &
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
index abe58f103043..3722eaa84234 100644
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
@@ -1726,8 +1726,7 @@ static int xcan_probe(struct platform_device *pdev)
 	struct net_device *ndev;
 	struct xcan_priv *priv;
 	struct phy *transceiver;
-	const struct of_device_id *of_id;
-	const struct xcan_devtype_data *devtype = &xcan_axi_data;
+	const struct xcan_devtype_data *devtype;
 	void __iomem *addr;
 	int ret;
 	int rx_max, tx_max;
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

