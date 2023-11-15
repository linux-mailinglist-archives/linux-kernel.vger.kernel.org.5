Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B567EC446
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344050AbjKOOAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbjKOOAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:00:35 -0500
Received: from mail.pcs.gmbh (mail.pcs.gmbh [89.27.162.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E54B3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:00:31 -0800 (PST)
Received: from mail.csna.de (mail.csna.de [89.27.162.50])
        by mail.pcs.gmbh with ESMTPA
        ; Wed, 15 Nov 2023 15:00:12 +0100
Received: from EXCHANGE2019.pcs.ditec.de (mail.pcs.com [89.27.162.5])
        by mail.csna.de with ESMTPSA
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256)
        ; Wed, 15 Nov 2023 15:00:11 +0100
Received: from EXCHANGE2019.pcs.ditec.de (192.168.8.214) by
 EXCHANGE2019.pcs.ditec.de (192.168.8.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 15 Nov 2023 15:00:12 +0100
Received: from lxtpfaff.pcs.ditec.de (192.168.9.96) by
 EXCHANGE2019.pcs.ditec.de (192.168.8.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Wed, 15 Nov 2023 15:00:12 +0100
Date:   Wed, 15 Nov 2023 15:00:11 +0100
From:   Thomas Pfaff <tpfaff@pcs.com>
To:     <tudor.ambarus@microchip.com>
CC:     <broonie@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC 2/3 stable-6.1] spi: spi-atmel: use dma buffers for pdc
 transfer
Message-ID: <b4b5e37d-9691-ef5e-3e55-84e02e9bfd1f@pcs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-KSE-ServerInfo: EXCHANGE2019.pcs.ditec.de, 9
X-KSE-AntiSpam-Interceptor-Info: white sender email list
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 15.11.2023 11:15:00
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Pfaff <tpfaff@pcs.com>

pdc transfer is broken (at least on AT91SAM9G45), because dma_map_single 
will always return false on vmalloc addresses.
This can be avoided by using the buffers for dma transfers for pdc too.

Signed-off-by: Thomas Pfaff <tpfaff@pcs.com>
---
diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index fc566d22aa36..eaf4f9ff2504 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -267,6 +267,7 @@ struct atmel_spi {
 	dma_addr_t		dma_addr_tx_bbuf;
 	void			*addr_rx_bbuf;
 	void			*addr_tx_bbuf;
+	void			*addr_rx_buf;
 
 	struct completion	xfer_completion;
 
@@ -906,42 +907,22 @@ static void atmel_spi_pdc_next_xfer(struct spi_master *master,
 }
 
 /*
- * For DMA, tx_buf/tx_dma have the same relationship as rx_buf/rx_dma:
- *  - The buffer is either valid for CPU access, else NULL
- *  - If the buffer is valid, so is its DMA address
- *
- * This driver manages the dma address unless message->is_dma_mapped.
+ * Use the internal dma buffers for pdc transfers,
  */
-static int
+static void
 atmel_spi_dma_map_xfer(struct atmel_spi *as, struct spi_transfer *xfer)
 {
-	struct device	*dev = &as->pdev->dev;
-
 	xfer->tx_dma = xfer->rx_dma = INVALID_DMA_ADDRESS;
 	if (xfer->tx_buf) {
-		/* tx_buf is a const void* where we need a void * for the dma
-		 * mapping */
-		void *nonconst_tx = (void *)xfer->tx_buf;
-
-		xfer->tx_dma = dma_map_single(dev,
-				nonconst_tx, xfer->len,
-				DMA_TO_DEVICE);
-		if (dma_mapping_error(dev, xfer->tx_dma))
-			return -ENOMEM;
+		memcpy(as->addr_tx_bbuf, xfer->tx_buf, xfer->len);
+		xfer->tx_dma = as->dma_addr_tx_bbuf;
+		xfer->tx_buf = as->addr_tx_bbuf;
 	}
 	if (xfer->rx_buf) {
-		xfer->rx_dma = dma_map_single(dev,
-				xfer->rx_buf, xfer->len,
-				DMA_FROM_DEVICE);
-		if (dma_mapping_error(dev, xfer->rx_dma)) {
-			if (xfer->tx_buf)
-				dma_unmap_single(dev,
-						xfer->tx_dma, xfer->len,
-						DMA_TO_DEVICE);
-			return -ENOMEM;
-		}
+		as->addr_rx_buf = xfer->rx_buf;
+		xfer->rx_dma = as->dma_addr_rx_bbuf;
+		xfer->rx_buf = as->addr_rx_bbuf;
 	}
-	return 0;
 }
 
 static void atmel_spi_dma_unmap_xfer(struct spi_master *master,
@@ -1125,6 +1106,11 @@ atmel_spi_pdc_interrupt(int irq, void *dev_id)
 
 		spi_writel(as, IDR, pending);
 
+		if (as->addr_rx_buf) {
+			as->current_transfer->rx_buf = as->addr_rx_buf;
+			memcpy(as->current_transfer->rx_buf, as->addr_rx_bbuf,
+			       as->current_transfer->len);
+		}
 		complete(&as->xfer_completion);
 	}
 
@@ -1296,10 +1282,10 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 	 * better fault reporting.
 	 */
 	if ((!master->cur_msg->is_dma_mapped)
-		&& as->use_pdc) {
-		if (atmel_spi_dma_map_xfer(as, xfer) < 0)
-			return -ENOMEM;
-	}
+	    && as->use_pdc)
+		atmel_spi_dma_map_xfer(as, xfer);
+	else
+		as->addr_rx_buf = NULL;
 
 	atmel_spi_set_xfer_speed(as, spi, xfer);
 
@@ -1512,28 +1498,25 @@ static int atmel_spi_probe(struct platform_device *pdev)
 		as->use_pdc = true;
 	}
 
-	if (IS_ENABLED(CONFIG_SOC_SAM_V4_V5)) {
-		as->addr_rx_bbuf = dmam_alloc_coherent(&pdev->dev,
+	as->addr_rx_bbuf = dmam_alloc_coherent(&pdev->dev,
+					       SPI_MAX_DMA_XFER,
+					       &as->dma_addr_rx_bbuf,
+					       GFP_KERNEL | GFP_DMA);
+	if (!as->addr_rx_bbuf) {
+		as->use_dma = false;
+		as->use_pdc = false;
+	} else {
+		as->addr_tx_bbuf = dmam_alloc_coherent(&pdev->dev,
 						       SPI_MAX_DMA_XFER,
-						       &as->dma_addr_rx_bbuf,
+						       &as->dma_addr_tx_bbuf,
 						       GFP_KERNEL | GFP_DMA);
-		if (!as->addr_rx_bbuf) {
+		if (!as->addr_tx_bbuf) {
 			as->use_dma = false;
-		} else {
-			as->addr_tx_bbuf = dmam_alloc_coherent(&pdev->dev,
-							       SPI_MAX_DMA_XFER,
-							       &as->dma_addr_tx_bbuf,
-							       GFP_KERNEL | GFP_DMA);
-			if (!as->addr_tx_bbuf) {
-				as->use_dma = false;
-				dmam_free_coherent(&pdev->dev, SPI_MAX_DMA_XFER,
-						   as->addr_rx_bbuf,
-						   as->dma_addr_rx_bbuf);
-			}
+			as->use_pdc = false;
+			dmam_free_coherent(&pdev->dev, SPI_MAX_DMA_XFER,
+					   as->addr_rx_bbuf,
+					   as->dma_addr_rx_bbuf);
 		}
-		if (!as->use_dma)
-			dev_info(master->dev.parent,
-				 "  can not allocate dma coherent memory\n");
 	}
 
 	if (as->caps.has_dma_support && !as->use_dma)


