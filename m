Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE4D7A35E7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 16:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbjIQOhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 10:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236757AbjIQOgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 10:36:42 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD2B18E
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 07:36:36 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id hsstqeOGW9p0Shssuq1bZf; Sun, 17 Sep 2023 16:36:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1694961389;
        bh=Eb9i/pcg2sDgpzwYBXcHCssoUoji+5TNSyNGZC5cFDI=;
        h=From:To:Cc:Subject:Date;
        b=OUpyags0q45Skaeadp0j10giUtgRYonu/aKJ16AVOVD6A2stjVU2bpJsEf1Gek3nY
         Y7vZgkJw84llWWsZMfMK7Jaj9aYH3VV9pCl9+reGddQJdSKL2zWJXkqpf8VoM3GxhO
         GXwcv/Py9iCKgAHi1SGaYt5icxMiU6dTHQC0/V+4vpnsl8gySvCTXq/xaY2NWRkHll
         Ijzh1pG79230bGCDcS1VXhSUGutSYiYUKushEwsFoKQYRyFMECO6psyphEWqgSlz2J
         4PFphBZ0eDwqGvC6CB2ijPj6wayN24dyBnxGslGwsp4ZOnKCXVW2nBcgvUNT02Jtq+
         gB23zUaopkKUg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 17 Sep 2023 16:36:29 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] spi: at91-usart: Remove some dead code
Date:   Sun, 17 Sep 2023 16:36:26 +0200
Message-Id: <84eb08daf85d203b34af9d8d08abf86804211413.1694961365.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_request_chan() does not return NULL. It returns a valid pointer or an
error pointer.

So, some dead code can be removed.

The IS_ERR_OR_NULL() in the error handling path are still needed, because
the error handling path is common to the whole function and the
ctlr->dma_xx are NULL when at91_usart_spi_configure_dma() is called.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/spi/spi-at91-usart.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index b11d0f993cc7..1cea8e159344 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -132,28 +132,14 @@ static int at91_usart_spi_configure_dma(struct spi_controller *ctlr,
 	dma_cap_set(DMA_SLAVE, mask);
 
 	ctlr->dma_tx = dma_request_chan(dev, "tx");
-	if (IS_ERR_OR_NULL(ctlr->dma_tx)) {
-		if (IS_ERR(ctlr->dma_tx)) {
-			err = PTR_ERR(ctlr->dma_tx);
-			goto at91_usart_spi_error_clear;
-		}
-
-		dev_dbg(dev,
-			"DMA TX channel not available, SPI unable to use DMA\n");
-		err = -EBUSY;
+	if (IS_ERR(ctlr->dma_tx)) {
+		err = PTR_ERR(ctlr->dma_tx);
 		goto at91_usart_spi_error_clear;
 	}
 
 	ctlr->dma_rx = dma_request_chan(dev, "rx");
-	if (IS_ERR_OR_NULL(ctlr->dma_rx)) {
-		if (IS_ERR(ctlr->dma_rx)) {
-			err = PTR_ERR(ctlr->dma_rx);
-			goto at91_usart_spi_error;
-		}
-
-		dev_dbg(dev,
-			"DMA RX channel not available, SPI unable to use DMA\n");
-		err = -EBUSY;
+	if (IS_ERR(ctlr->dma_rx)) {
+		err = PTR_ERR(ctlr->dma_rx);
 		goto at91_usart_spi_error;
 	}
 
-- 
2.34.1

