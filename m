Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4B77F4106
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343747AbjKVJCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343521AbjKVJBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:01:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF315D40
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:01:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F591C116D3;
        Wed, 22 Nov 2023 09:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700643675;
        bh=89sGbAwtHZLmywU3Spbtojj19E+yEgyLt9lhMdOjUSA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=r5VF8Vzc7xcHiLPGyXJJFUWBb6Ay3X3/Wu9TM55wgyrd9mFgJzQZxsxhj3yJqLY98
         4dSS2QRSlp8+e/FE6WE4mCQr+GGXwVmHzwHBhJZRgFjKGdn78YR40ELWgwQkn2icZd
         U8czrVdVBCFr4XCgcCK+EwcGRma8Xu7Sds59HtwpFTZl7teuiCdvajRB6Yoi4CkGON
         zzEsSs6dRyE/RknOsykv9OyXs0a9qhJvkJe8eOHgg/DBEyH8VRBYVdWxZIr26G1a3T
         FL+oCoIx/VE3rruz0fbWVyKM+Tc9Ze0jle29AZH2dPJSwDyvE3k3LUrTo69IoKB40z
         +AQ4q77BDW0wA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 6C509C61D9D;
        Wed, 22 Nov 2023 09:01:15 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Wed, 22 Nov 2023 11:59:59 +0300
Subject: [PATCH v5 21/39] ata: pata_ep93xx: add device tree support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-ep93xx-v5-21-d59a76d5df29@maquefel.me>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
In-Reply-To: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700643671; l=5845;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=w72U3jG1No6t3pMwmT+VIpbkZKZCCOKZg354x7Q6zUs=; =?utf-8?q?b=3D46r+g4fVfWDf?=
 =?utf-8?q?uSmpVbZ1Rhj93Zkgu0Sxe2zIATV5cXfuyUQMjF2bMQiMmt7ELJOuOn38DS+M0mi7?=
 fm1JxBvpAlp+ZErpXRFTrXbarH4L2yxQ4YrQgLmxIAG1KFmxmlc+
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
- drop platform DMA and filters
- change DMA setup to OF, so we can defer probe

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Acked-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/ata/pata_ep93xx.c | 81 +++++++++++++++++++++++++----------------------
 1 file changed, 43 insertions(+), 38 deletions(-)

diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index c84a20892f1b..3f33916c2d23 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -44,8 +44,8 @@
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
 #include <linux/ktime.h>
+#include <linux/mod_devicetable.h>
 
-#include <linux/platform_data/dma-ep93xx.h>
 #include <linux/soc/cirrus/ep93xx.h>
 
 #define DRV_NAME	"ep93xx-ide"
@@ -126,7 +126,7 @@ enum {
 };
 
 struct ep93xx_pata_data {
-	const struct platform_device *pdev;
+	struct platform_device *pdev;
 	void __iomem *ide_base;
 	struct ata_timing t;
 	bool iordy;
@@ -135,9 +135,7 @@ struct ep93xx_pata_data {
 	unsigned long udma_out_phys;
 
 	struct dma_chan *dma_rx_channel;
-	struct ep93xx_dma_data dma_rx_data;
 	struct dma_chan *dma_tx_channel;
-	struct ep93xx_dma_data dma_tx_data;
 };
 
 static void ep93xx_pata_clear_regs(void __iomem *base)
@@ -637,20 +635,13 @@ static void ep93xx_pata_release_dma(struct ep93xx_pata_data *drv_data)
 	}
 }
 
-static bool ep93xx_pata_dma_filter(struct dma_chan *chan, void *filter_param)
+static int ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 {
-	if (ep93xx_dma_chan_is_m2p(chan))
-		return false;
-
-	chan->private = filter_param;
-	return true;
-}
-
-static void ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
-{
-	const struct platform_device *pdev = drv_data->pdev;
+	struct platform_device *pdev = drv_data->pdev;
+	struct device *dev = &pdev->dev;
 	dma_cap_mask_t mask;
 	struct dma_slave_config conf;
+	int ret;
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
@@ -660,22 +651,17 @@ static void ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 	 * to request only one channel, and reprogram it's direction at
 	 * start of new transfer.
 	 */
-	drv_data->dma_rx_data.port = EP93XX_DMA_IDE;
-	drv_data->dma_rx_data.direction = DMA_DEV_TO_MEM;
-	drv_data->dma_rx_data.name = "ep93xx-pata-rx";
-	drv_data->dma_rx_channel = dma_request_channel(mask,
-		ep93xx_pata_dma_filter, &drv_data->dma_rx_data);
-	if (!drv_data->dma_rx_channel)
-		return;
+	drv_data->dma_rx_channel = dma_request_chan(dev, "rx");
+	if (IS_ERR(drv_data->dma_rx_channel)) {
+		ret = PTR_ERR(drv_data->dma_rx_channel);
+		return dev_err_probe(dev, ret, "rx DMA setup failed");
+	}
 
-	drv_data->dma_tx_data.port = EP93XX_DMA_IDE;
-	drv_data->dma_tx_data.direction = DMA_MEM_TO_DEV;
-	drv_data->dma_tx_data.name = "ep93xx-pata-tx";
-	drv_data->dma_tx_channel = dma_request_channel(mask,
-		ep93xx_pata_dma_filter, &drv_data->dma_tx_data);
-	if (!drv_data->dma_tx_channel) {
-		dma_release_channel(drv_data->dma_rx_channel);
-		return;
+	drv_data->dma_tx_channel = dma_request_chan(&pdev->dev, "tx");
+	if (IS_ERR(drv_data->dma_tx_channel)) {
+		ret = PTR_ERR(drv_data->dma_tx_channel);
+		dev_err_probe(dev, ret, "tx DMA setup failed");
+		goto fail_release_rx;
 	}
 
 	/* Configure receive channel direction and source address */
@@ -683,10 +669,10 @@ static void ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 	conf.direction = DMA_DEV_TO_MEM;
 	conf.src_addr = drv_data->udma_in_phys;
 	conf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	if (dmaengine_slave_config(drv_data->dma_rx_channel, &conf)) {
-		dev_err(&pdev->dev, "failed to configure rx dma channel\n");
-		ep93xx_pata_release_dma(drv_data);
-		return;
+	ret = dmaengine_slave_config(drv_data->dma_rx_channel, &conf);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to configure rx dma channel");
+		goto fail_release_dma;
 	}
 
 	/* Configure transmit channel direction and destination address */
@@ -694,10 +680,20 @@ static void ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 	conf.direction = DMA_MEM_TO_DEV;
 	conf.dst_addr = drv_data->udma_out_phys;
 	conf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	if (dmaengine_slave_config(drv_data->dma_tx_channel, &conf)) {
-		dev_err(&pdev->dev, "failed to configure tx dma channel\n");
-		ep93xx_pata_release_dma(drv_data);
+	ret = dmaengine_slave_config(drv_data->dma_tx_channel, &conf);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to configure tx dma channel");
+		goto fail_release_dma;
 	}
+
+	return 0;
+
+fail_release_rx:
+	dma_release_channel(drv_data->dma_rx_channel);
+fail_release_dma:
+	ep93xx_pata_release_dma(drv_data);
+
+	return ret;
 }
 
 static void ep93xx_pata_dma_start(struct ata_queued_cmd *qc)
@@ -954,7 +950,9 @@ static int ep93xx_pata_probe(struct platform_device *pdev)
 	drv_data->ide_base = ide_base;
 	drv_data->udma_in_phys = mem_res->start + IDEUDMADATAIN;
 	drv_data->udma_out_phys = mem_res->start + IDEUDMADATAOUT;
-	ep93xx_pata_dma_init(drv_data);
+	err = ep93xx_pata_dma_init(drv_data);
+	if (err)
+		return err;
 
 	/* allocate host */
 	host = ata_host_alloc(&pdev->dev, 1);
@@ -1021,9 +1019,16 @@ static void ep93xx_pata_remove(struct platform_device *pdev)
 	ep93xx_ide_release_gpio(pdev);
 }
 
+static const struct of_device_id ep93xx_pata_of_ids[] = {
+	{ .compatible = "cirrus,ep9312-pata" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ep93xx_pata_of_ids);
+
 static struct platform_driver ep93xx_pata_platform_driver = {
 	.driver = {
 		.name = DRV_NAME,
+		.of_match_table = ep93xx_pata_of_ids,
 	},
 	.probe = ep93xx_pata_probe,
 	.remove_new = ep93xx_pata_remove,

-- 
2.41.0

