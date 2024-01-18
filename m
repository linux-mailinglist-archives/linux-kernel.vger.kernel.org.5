Return-Path: <linux-kernel+bounces-29864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852248314A1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98B61C23FF2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBE82C842;
	Thu, 18 Jan 2024 08:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQmDlXv9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C456413FF8;
	Thu, 18 Jan 2024 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705566179; cv=none; b=utaodEae1XUZhPHLxjTRkHogp/chnBDTul0oCa/KH6GdcE948GQ8u8mEDjta3x8xOAhYHnXcB4diRd4x9L6v36hwf+3d63jL3sTF4B4fjbYFdpAxWf9k/F9jjYIG9mqDu56zPO5mSBg92/dFdUe0lVr5uzjzduiFlFdwSjaaJD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705566179; c=relaxed/simple;
	bh=YmGPmanXocW8O4jITzcpLvtJ6lKasupJRwaKBGtXVPk=;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To; b=Tb2PpTA+HQaSLL3u7VQUJTJKy2MR6dfMpqsGCxme6aRdCG0UPdv8CGQxOEGWkZLk/AtVHN9QYtmtSCjHwtCPFeu5Qvdgbqae2kLxbfdAimbXWk+uIdrZar/plIrSb+zu2nxtPWFMtLHvOWup3DCcH+dBOBT7m906+NYQrX0srvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQmDlXv9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C456C32789;
	Thu, 18 Jan 2024 08:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705566179;
	bh=YmGPmanXocW8O4jITzcpLvtJ6lKasupJRwaKBGtXVPk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QQmDlXv9g5xX/QNi8V4YqlCTLKj37vtcUmy3UGlmuqGtqqUiXgv3qa1bPh4ux0WVx
	 vQgxlyawd7NOTudj93FiK5fJfcYIkwfZ/1n2a3zoFp8al60QgPk3CesWNcaJLpgAUA
	 3peRfB3+6TXcz05OhrXw/wTwuqtqIBf0NeQ/sLAm3KshzUtlAk84xcYTwcq30VI03O
	 qZLGSKbg3I8VzEnkg+xu5BPcOdn4eWGvhGSgdypr/mvCuaCcYwtjQnSRa3oSS3NVKd
	 GcxHlH0Ds26vTOCeXXQsevnhzwABRHGZt0BN8HOTUAXcJaPuZrVPHIRsb9/jQpmhfx
	 Rp/n4AY52RT6A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D021C4707B;
	Thu, 18 Jan 2024 08:22:59 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Thu, 18 Jan 2024 11:20:59 +0300
Subject: [PATCH v7 16/39] spi: ep93xx: add DT support for Cirrus EP93xx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240118-ep93xx-v7-16-d953846ae771@maquefel.me>
References: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
In-Reply-To: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705566176; l=4901;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=8M/HAUqJd+W8e9O32fFZUixHr6QBzfilxUR9p65XK5c=; =?utf-8?q?b=3D8MnfTKdIWVIm?=
 =?utf-8?q?TgBXysZSNUoR/ayBBQmaXdDKAZGWzIpgyuVcJya1am6A3vYzG88ovMBpNl6vXrZ4?=
 IfE14pvkCddbLKBvRbYh+RJn6cbCHbP1xbOU+kz7+vFtfmTtuYyc
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received:
 by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>

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
 drivers/spi/spi-ep93xx.c | 66 +++++++++++++++++-------------------------------
 1 file changed, 23 insertions(+), 43 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index a1d60e51c053..ffbe0d522bce 100644
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
@@ -575,46 +573,23 @@ static int ep93xx_spi_unprepare_hardware(struct spi_controller *host)
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
+		ret = dev_err_probe(dev, PTR_ERR(espi->dma_rx), "rx DMA setup failed");
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
+		ret = dev_err_probe(dev, PTR_ERR(espi->dma_tx), "tx DMA setup failed");
 		goto fail_release_rx;
 	}
 
@@ -647,18 +622,11 @@ static void ep93xx_spi_release_dma(struct ep93xx_spi *espi)
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
@@ -713,12 +681,17 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
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
@@ -746,9 +719,16 @@ static void ep93xx_spi_remove(struct platform_device *pdev)
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


