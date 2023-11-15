Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831E47EC444
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344028AbjKOOAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbjKOOAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:00:01 -0500
Received: from mail.pcs.gmbh (mail.pcs.gmbh [89.27.162.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE8AE1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:59:57 -0800 (PST)
Received: from mail.csna.de (mail.csna.de [89.27.162.50])
        by mail.pcs.gmbh with ESMTPA
        ; Wed, 15 Nov 2023 14:59:17 +0100
Received: from EXCHANGE2019.pcs.ditec.de (mail.pcs.com [89.27.162.5])
        by mail.csna.de with ESMTPSA
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256)
        ; Wed, 15 Nov 2023 14:59:17 +0100
Received: from EXCHANGE2019.pcs.ditec.de (192.168.8.214) by
 EXCHANGE2019.pcs.ditec.de (192.168.8.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 15 Nov 2023 14:59:11 +0100
Received: from lxtpfaff.pcs.ditec.de (192.168.9.96) by
 EXCHANGE2019.pcs.ditec.de (192.168.8.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Wed, 15 Nov 2023 14:59:06 +0100
Date:   Wed, 15 Nov 2023 14:59:06 +0100
From:   Thomas Pfaff <tpfaff@pcs.com>
To:     <tudor.ambarus@microchip.com>
CC:     <broonie@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC 1/3 stable-6.1] spi: spi-atmel: switch to managed
 dma_alloc_coherent
Message-ID: <c8ac6625-a2d8-171d-f1b5-ad72e34a7645@pcs.com>
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

use managed dma_alloc_coherent instead of unmanaged.

Signed-off-by: Thomas Pfaff <tpfaff@pcs.com>
---
diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index c4f22d50dba5..fc566d22aa36 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1513,22 +1513,22 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	}
 
 	if (IS_ENABLED(CONFIG_SOC_SAM_V4_V5)) {
-		as->addr_rx_bbuf = dma_alloc_coherent(&pdev->dev,
-						      SPI_MAX_DMA_XFER,
-						      &as->dma_addr_rx_bbuf,
-						      GFP_KERNEL | GFP_DMA);
+		as->addr_rx_bbuf = dmam_alloc_coherent(&pdev->dev,
+						       SPI_MAX_DMA_XFER,
+						       &as->dma_addr_rx_bbuf,
+						       GFP_KERNEL | GFP_DMA);
 		if (!as->addr_rx_bbuf) {
 			as->use_dma = false;
 		} else {
-			as->addr_tx_bbuf = dma_alloc_coherent(&pdev->dev,
-					SPI_MAX_DMA_XFER,
-					&as->dma_addr_tx_bbuf,
-					GFP_KERNEL | GFP_DMA);
+			as->addr_tx_bbuf = dmam_alloc_coherent(&pdev->dev,
+							       SPI_MAX_DMA_XFER,
+							       &as->dma_addr_tx_bbuf,
+							       GFP_KERNEL | GFP_DMA);
 			if (!as->addr_tx_bbuf) {
 				as->use_dma = false;
-				dma_free_coherent(&pdev->dev, SPI_MAX_DMA_XFER,
-						  as->addr_rx_bbuf,
-						  as->dma_addr_rx_bbuf);
+				dmam_free_coherent(&pdev->dev, SPI_MAX_DMA_XFER,
+						   as->addr_rx_bbuf,
+						   as->dma_addr_rx_bbuf);
 			}
 		}
 		if (!as->use_dma)
@@ -1607,14 +1607,6 @@ static int atmel_spi_remove(struct platform_device *pdev)
 	if (as->use_dma) {
 		atmel_spi_stop_dma(master);
 		atmel_spi_release_dma(master);
-		if (IS_ENABLED(CONFIG_SOC_SAM_V4_V5)) {
-			dma_free_coherent(&pdev->dev, SPI_MAX_DMA_XFER,
-					  as->addr_tx_bbuf,
-					  as->dma_addr_tx_bbuf);
-			dma_free_coherent(&pdev->dev, SPI_MAX_DMA_XFER,
-					  as->addr_rx_bbuf,
-					  as->dma_addr_rx_bbuf);
-		}
 	}
 
 	spin_lock_irq(&as->lock);


