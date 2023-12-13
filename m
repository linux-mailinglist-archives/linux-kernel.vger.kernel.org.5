Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985BA80E5EB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 09:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346257AbjLLIXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 03:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjLLIWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 03:22:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E74ED
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:22:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65F43C116B4;
        Tue, 12 Dec 2023 08:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702369325;
        bh=B8ZiLtBGXLbR7qoYbOTfiZMqMBl62eYsJWPIMirndxc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=uZYxEAqdBA2TNeeK14dz6oAnMI2SlEAmbBlJY4ilA0OS4rZh1gUAS7HjwHGsPYxmC
         99N3/fxwhBXGA/ewUOo4yGT6YqiLSuSqp6nGbBJGd2klMsXArPfbqN4iwGOolM+lT+
         i0U8+rjD/Bef/kjlEFoW5AaQ2oL9XYZg0jYAjoycOmxH8Q0nBq5SbXRJV0y9c/XoNt
         4nlz3DhrRDuCNwdi2ZiSK0F6t+PcEf9fEY4/FytY6lx+oPplkDfLCfSRR2RcBw7Bm+
         ijqvow2ptxxYjjmlpke+xfz/WXqioeIp2e3V/ICcv7jB2flxoFiF+4RCjgScuLNJBg
         Mse9cj8VDqcTw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 55DE0C4332F;
        Tue, 12 Dec 2023 08:22:05 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Tue, 12 Dec 2023 11:20:33 +0300
Subject: [PATCH v6 16/40] spi: ep93xx: add DT support for Cirrus EP93xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-ep93xx-v6-16-c307b8ac9aa8@maquefel.me>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
In-Reply-To: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702369322; l=4919;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=OYD5e78as1K2YGZuUl59eu6mcZ+fN0DYGOt3PUkJWa0=; =?utf-8?q?b=3DGNRxtSo93P4d?=
 =?utf-8?q?4W69iGK97JLvdf58I+DPmHjRCFYdGC4yvcGuthU1yMq6vZhEeL6c1ApczWsSk0dL?=
 EEFt+XjxBcW+SR1dcH2t+4oGpbGGoJ8n75hTyN9FjgiXP5jGw7hd
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
- add device tree DMA request, so we can probe defer, in case DMA is not
  ready yet
- drop DMA platform code

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/spi/spi-ep93xx.c | 68 ++++++++++++++++++------------------------------
 1 file changed, 25 insertions(+), 43 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index a1d60e51c053..01df1f8ae680 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -18,18 +18,18 @@
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/bitops.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/scatterlist.h>
 #include <linux/spi/spi.h>
 
-#include <linux/platform_data/dma-ep93xx.h>
-#include <linux/platform_data/spi-ep93xx.h>
-
 #define SSPCR0			0x0000
 #define SSPCR0_SPO		BIT(6)
 #define SSPCR0_SPH		BIT(7)
@@ -92,8 +92,6 @@ struct ep93xx_spi {
 	size_t				fifo_level;
 	struct dma_chan			*dma_rx;
 	struct dma_chan			*dma_tx;
-	struct ep93xx_dma_data		dma_rx_data;
-	struct ep93xx_dma_data		dma_tx_data;
 	struct sg_table			rx_sgt;
 	struct sg_table			tx_sgt;
 	void				*zeropage;
@@ -575,46 +573,25 @@ static int ep93xx_spi_unprepare_hardware(struct spi_controller *host)
 	return 0;
 }
 
-static bool ep93xx_spi_dma_filter(struct dma_chan *chan, void *filter_param)
+static int ep93xx_spi_setup_dma(struct device *dev, struct ep93xx_spi *espi)
 {
-	if (ep93xx_dma_chan_is_m2p(chan))
-		return false;
-
-	chan->private = filter_param;
-	return true;
-}
-
-static int ep93xx_spi_setup_dma(struct ep93xx_spi *espi)
-{
-	dma_cap_mask_t mask;
 	int ret;
 
 	espi->zeropage = (void *)get_zeroed_page(GFP_KERNEL);
 	if (!espi->zeropage)
 		return -ENOMEM;
 
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-
-	espi->dma_rx_data.port = EP93XX_DMA_SSP;
-	espi->dma_rx_data.direction = DMA_DEV_TO_MEM;
-	espi->dma_rx_data.name = "ep93xx-spi-rx";
-
-	espi->dma_rx = dma_request_channel(mask, ep93xx_spi_dma_filter,
-					   &espi->dma_rx_data);
-	if (!espi->dma_rx) {
-		ret = -ENODEV;
+	espi->dma_rx = dma_request_chan(dev, "rx");
+	if (IS_ERR(espi->dma_rx)) {
+		ret = PTR_ERR(espi->dma_rx);
+		dev_err_probe(dev, ret, "rx DMA setup failed");
 		goto fail_free_page;
 	}
 
-	espi->dma_tx_data.port = EP93XX_DMA_SSP;
-	espi->dma_tx_data.direction = DMA_MEM_TO_DEV;
-	espi->dma_tx_data.name = "ep93xx-spi-tx";
-
-	espi->dma_tx = dma_request_channel(mask, ep93xx_spi_dma_filter,
-					   &espi->dma_tx_data);
-	if (!espi->dma_tx) {
-		ret = -ENODEV;
+	espi->dma_tx = dma_request_chan(dev, "tx");
+	if (IS_ERR(espi->dma_tx)) {
+		ret = PTR_ERR(espi->dma_tx);
+		dev_err_probe(dev, ret, "tx DMA setup failed");
 		goto fail_release_rx;
 	}
 
@@ -647,18 +624,11 @@ static void ep93xx_spi_release_dma(struct ep93xx_spi *espi)
 static int ep93xx_spi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *host;
-	struct ep93xx_spi_info *info;
 	struct ep93xx_spi *espi;
 	struct resource *res;
 	int irq;
 	int error;
 
-	info = dev_get_platdata(&pdev->dev);
-	if (!info) {
-		dev_err(&pdev->dev, "missing platform data\n");
-		return -EINVAL;
-	}
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
@@ -713,12 +683,17 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 		goto fail_release_host;
 	}
 
-	if (info->use_dma && ep93xx_spi_setup_dma(espi))
+	error = ep93xx_spi_setup_dma(&pdev->dev, espi);
+	if (error == -EPROBE_DEFER)
+		goto fail_release_host;
+
+	if (error)
 		dev_warn(&pdev->dev, "DMA setup failed. Falling back to PIO\n");
 
 	/* make sure that the hardware is disabled */
 	writel(0, espi->mmio + SSPCR1);
 
+	device_set_node(&host->dev, dev_fwnode(&pdev->dev));
 	error = devm_spi_register_controller(&pdev->dev, host);
 	if (error) {
 		dev_err(&pdev->dev, "failed to register SPI host\n");
@@ -746,9 +721,16 @@ static void ep93xx_spi_remove(struct platform_device *pdev)
 	ep93xx_spi_release_dma(espi);
 }
 
+static const struct of_device_id ep93xx_spi_of_ids[] = {
+	{ .compatible = "cirrus,ep9301-spi" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ep93xx_spi_of_ids);
+
 static struct platform_driver ep93xx_spi_driver = {
 	.driver		= {
 		.name	= "ep93xx-spi",
+		.of_match_table = ep93xx_spi_of_ids,
 	},
 	.probe		= ep93xx_spi_probe,
 	.remove_new	= ep93xx_spi_remove,

-- 
2.41.0

