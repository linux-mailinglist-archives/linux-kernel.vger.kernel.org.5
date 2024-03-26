Return-Path: <linux-kernel+bounces-118653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D370B88BDD2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DBBF2E6ECB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEC7129A96;
	Tue, 26 Mar 2024 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpkqQ0Yz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802CA6CDAB;
	Tue, 26 Mar 2024 09:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444842; cv=none; b=CUChIwl31fVqRFD7dnf3fZIxrE78Wrw6aUEewB9iw0NOceLmpcY9E5rPo7Op37knpMPt+u8dd334jOnUf7zcP7ITjQzthoEGr7ItrA15SijKqkawlM8sCqP29xsIZ45ZKu5ffGswo5Pr5I8HRFRABYOwL+6kkG3KzHf6Sezm0D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444842; c=relaxed/simple;
	bh=S5+oyUYTbgn+qXL5avFw/jxfYv109CuTwr1u7Wdrc5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UoclOdR8Vy0F62czE68hbYJrfUJx0R++rv3AY3L/lWsxq3KkbWm8fQ/66UGY0T5ujdGbKN4ijz2BXr80LDFRAUKErOrH0w0g1uBMSRZ6/+9t0bVd7+oHznruh2p5KZ0Xl95YZbJHgMAEs4LGrPO50hG1C8xgD1YJ1tp8jmXmI8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpkqQ0Yz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEC95C4166B;
	Tue, 26 Mar 2024 09:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711444841;
	bh=S5+oyUYTbgn+qXL5avFw/jxfYv109CuTwr1u7Wdrc5o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gpkqQ0YzZ5CM/uKRvKZgJKBbJDcLHaOkMPcyUbfR4XaFaKCJfJ1AWR6Su/Xz0yTd8
	 UQDK6DZCmuR8ZGdGXPbuSWYKAoXo+qQ2N5G8tK3VwpN+4EnSf8w4GXgn76PkrQ9xOQ
	 WaBFlZ1H18SxP4WL+a3jPbkQ0MukAZHv2V8RJoXYW+OClJf/EQlmWt1MfpPBxkBDAl
	 4hlKIgcBxkAfh7u/MeZLxIN3HzjatZV0dDi+RkKLbsCzKJOncARYTdV4fLumIZw3Go
	 Wj/IRTCUAQjTre6Y9B2avzL2ZH57SWIAN5fz1tXuqyixSuGKQhjbg1b//Xz5cEw2nT
	 YayR40Ejfvupw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6643C54E58;
	Tue, 26 Mar 2024 09:20:41 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Tue, 26 Mar 2024 12:18:44 +0300
Subject: [PATCH v9 17/38] net: cirrus: add DT support for Cirrus EP93xx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-ep93xx-v9-17-156e2ae5dfc8@maquefel.me>
References: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
In-Reply-To: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
To: Hartley Sweeten <hsweeten@visionengravers.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711444837; l=4277;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=haHUoZpq1/NsK767bzrp9qO3hwzqe9FSBz/rqgnsK5I=;
 b=xkNnlMK6Z1tjz3MKcBvXz/h5xvOXsT/2RNrXf6OHfUg+qdv0M1d/p+BeXrUH7ScYYJ6wwHOsSqvw
 thH0/krpCGaxGkyg7vZtDZop/fGyj7LS24EVU4eQVUCn+EStEzyI
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

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
index 1f495cfd7959..2523d9c9d1b8 100644
--- a/drivers/net/ethernet/cirrus/ep93xx_eth.c
+++ b/drivers/net/ethernet/cirrus/ep93xx_eth.c
@@ -16,13 +16,12 @@
 #include <linux/ethtool.h>
 #include <linux/interrupt.h>
 #include <linux/moduleparam.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
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



