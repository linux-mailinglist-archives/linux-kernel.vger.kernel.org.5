Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3753A7F40FF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343615AbjKVJCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbjKVJBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:01:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADF5F4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:01:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46A8DC4AF5E;
        Wed, 22 Nov 2023 09:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700643675;
        bh=jUp23sLyZF2ZiQtXRJ5Qs3WUcDXhAHo6TBkYOOsV0MI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=fATj2p9qoGNfI/s6bODUrFypUVSFlQt5EHL84BhKVjrPXNoB39oL0sef6JG2k7fL1
         RCfy/Gp6UL7xKfWryp4wY6cKihoF/JGVpHwdPRwZR1Er1vER7z0zo0V9Y9TwOhTQvs
         PUuoJ1wfm+qSLLOYXOGwZenwOZzpKk4WSXnARLcfBVQQPVzXAGUX8oeBxccIR23rV+
         O+B24eT5+ag5prUUOdYy+0NK+/fNIXeiZodCOdpD9hLhneMzCD7bJJ+5WdIrCw6b9R
         GRzCyQjHpCTTzO5zwd/DCjeBb0NaKQhcfzx8F8ARVMMQT99BcnqUAIRD5mWFho7m+X
         zZjlJnyMaJCCg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 34720C61D9D;
        Wed, 22 Nov 2023 09:01:15 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Wed, 22 Nov 2023 11:59:55 +0300
Subject: [PATCH v5 17/39] net: cirrus: add DT support for Cirrus EP93xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-ep93xx-v5-17-d59a76d5df29@maquefel.me>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
In-Reply-To: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
To:     Hartley Sweeten <hsweeten@visionengravers.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700643671; l=4248;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=Jsr2Z57/1zzjxnodjeFhBhk8dpD7lZ/Sm2ymHhuQVGM=; =?utf-8?q?b=3D9pjWKpAD7FKZ?=
 =?utf-8?q?sto7rhb4p4w2coguelUdAbhvpt2T2Yq7FGIGYi8g6RkJyz68L7uOa8aOefJAloel?=
 02SmdDgWBz1YHde96fTJBs8pHYG3y87Y5DbV/x7CbysNGqriDtV8
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Shubin <nikita.shubin@maquefel.me>

- add OF ID match table
- get phy_id from the device tree, as part of mdio
- copy_addr is now always used, as there is no SoC/board that aren't
- dropped platform header

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/net/ethernet/cirrus/ep93xx_eth.c | 63 ++++++++++++++++----------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/cirrus/ep93xx_eth.c b/drivers/net/ethernet/cirrus/ep93xx_eth.c
index 1c2a540db13d..2a58af5fc288 100644
--- a/drivers/net/ethernet/cirrus/ep93xx_eth.c
+++ b/drivers/net/ethernet/cirrus/ep93xx_eth.c
@@ -17,12 +17,11 @@
 #include <linux/interrupt.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 
-#include <linux/platform_data/eth-ep93xx.h>
-
 #define DRV_MODULE_NAME		"ep93xx-eth"
 
 #define RX_QUEUE_ENTRIES	64
@@ -738,25 +737,6 @@ static const struct net_device_ops ep93xx_netdev_ops = {
 	.ndo_set_mac_address	= eth_mac_addr,
 };
 
-static struct net_device *ep93xx_dev_alloc(struct ep93xx_eth_data *data)
-{
-	struct net_device *dev;
-
-	dev = alloc_etherdev(sizeof(struct ep93xx_priv));
-	if (dev == NULL)
-		return NULL;
-
-	eth_hw_addr_set(dev, data->dev_addr);
-
-	dev->ethtool_ops = &ep93xx_ethtool_ops;
-	dev->netdev_ops = &ep93xx_netdev_ops;
-
-	dev->features |= NETIF_F_SG | NETIF_F_HW_CSUM;
-
-	return dev;
-}
-
-
 static void ep93xx_eth_remove(struct platform_device *pdev)
 {
 	struct net_device *dev;
@@ -786,27 +766,47 @@ static void ep93xx_eth_remove(struct platform_device *pdev)
 
 static int ep93xx_eth_probe(struct platform_device *pdev)
 {
-	struct ep93xx_eth_data *data;
 	struct net_device *dev;
 	struct ep93xx_priv *ep;
 	struct resource *mem;
+	void __iomem *base_addr;
+	struct device_node *np;
+	u32 phy_id;
 	int irq;
 	int err;
 
 	if (pdev == NULL)
 		return -ENODEV;
-	data = dev_get_platdata(&pdev->dev);
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
 	if (!mem || irq < 0)
 		return -ENXIO;
 
-	dev = ep93xx_dev_alloc(data);
+	base_addr = ioremap(mem->start, resource_size(mem));
+	if (!base_addr)
+		return dev_err_probe(&pdev->dev, -EIO, "Failed to ioremap ethernet registers\n");
+
+	np = of_parse_phandle(pdev->dev.of_node, "phy-handle", 0);
+	if (!np)
+		return dev_err_probe(&pdev->dev, -ENODEV, "Please provide \"phy-handle\"\n");
+
+	err = of_property_read_u32(np, "reg", &phy_id);
+	of_node_put(np);
+	if (err)
+		return dev_err_probe(&pdev->dev, -ENOENT, "Failed to locate \"phy_id\"\n");
+
+	dev = alloc_etherdev(sizeof(struct ep93xx_priv));
 	if (dev == NULL) {
 		err = -ENOMEM;
 		goto err_out;
 	}
+
+	eth_hw_addr_set(dev, base_addr + 0x50);
+	dev->ethtool_ops = &ep93xx_ethtool_ops;
+	dev->netdev_ops = &ep93xx_netdev_ops;
+	dev->features |= NETIF_F_SG | NETIF_F_HW_CSUM;
+
 	ep = netdev_priv(dev);
 	ep->dev = dev;
 	SET_NETDEV_DEV(dev, &pdev->dev);
@@ -822,15 +822,10 @@ static int ep93xx_eth_probe(struct platform_device *pdev)
 		goto err_out;
 	}
 
-	ep->base_addr = ioremap(mem->start, resource_size(mem));
-	if (ep->base_addr == NULL) {
-		dev_err(&pdev->dev, "Failed to ioremap ethernet registers\n");
-		err = -EIO;
-		goto err_out;
-	}
+	ep->base_addr = base_addr;
 	ep->irq = irq;
 
-	ep->mii.phy_id = data->phy_id;
+	ep->mii.phy_id = phy_id;
 	ep->mii.phy_id_mask = 0x1f;
 	ep->mii.reg_num_mask = 0x1f;
 	ep->mii.dev = dev;
@@ -857,12 +852,18 @@ static int ep93xx_eth_probe(struct platform_device *pdev)
 	return err;
 }
 
+static const struct of_device_id ep93xx_eth_of_ids[] = {
+	{ .compatible = "cirrus,ep9301-eth" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ep93xx_eth_of_ids);
 
 static struct platform_driver ep93xx_eth_driver = {
 	.probe		= ep93xx_eth_probe,
 	.remove_new	= ep93xx_eth_remove,
 	.driver		= {
 		.name	= "ep93xx-eth",
+		.of_match_table = ep93xx_eth_of_ids,
 	},
 };
 

-- 
2.41.0

