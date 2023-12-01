Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61C8801599
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 22:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379687AbjLAVlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 16:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjLAVlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 16:41:21 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC81E6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 13:41:27 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-423c28db22eso30968521cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 13:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1701466886; x=1702071686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=59mXeYglHvFe+i0q8a+nNQILZScUscbdHfS/fP8kp0o=;
        b=cRGJHK1Gf02sJnV6elAOh99xCx4MP65bmpP4BtcDT7D92BfirX1OYHwgC4IT6rKMv+
         b96+LMav+i8mm1vFDCxIUBT8iyIqhMfOpfCa5uU69CauqSlAx1yxgIuMWNO/Xsbk+lcE
         ZwoNYakZiz95QWWVV4nFEXjD9deXgtA4XXplF/R+cpjkDb2D4BQaXp7JWeiPsIZgXOY6
         1Wz95gf/O211yM273HUS49UJ0cOTYsIuVS2Lovm5tPlwGQjg6qU0ZYXRWSSGs5K3CyYB
         tq4J0YJBBf+qxDqIH+h8GGOFIikU4lxgGLHve4JNsF8suz76KLFu/Yy7eh2P8PXxzrYu
         EE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701466886; x=1702071686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59mXeYglHvFe+i0q8a+nNQILZScUscbdHfS/fP8kp0o=;
        b=jkiGQ5/HT1rpr2pc5mGbg98EsxlNVP9FnZAjWQdY9DeMSLgvBpIptRtuAUQkukG8Oc
         8r8qZw8tZq3IhifSv9Ga02/05QDDRUMik2b751uo8Wv4K1DUyofE2XRGsbW2cHvttH7U
         CL9NDS8DazQX16GSjI3qOZo/ebNi+0WozRSvvrhrS4Ta2tsbqZuruUon9ZQ8E87E/Qd2
         kcn+7TXa1DHrthGQVQ7Zm7cKrQTpGgYneZg8fWZPK4S/ed393MMq3GXjDil1RyI+Jg/4
         bpV2uJgQXtqV/s6dD2ZCJ2M3N9d7FC8q29+mnlZPi1W3Izv/pgRzn9jd0P6fg8bHo1uZ
         wJ8w==
X-Gm-Message-State: AOJu0Yw6QTd5OJ+hz63A4C0EOdNZjqypqM7kkUVs/tbpoqcG9BHXTv7C
        PrOYocZu14bXoPrqSNlsC0QNxQ==
X-Google-Smtp-Source: AGHT+IGoHQeQx+AvBZHeMuz4zrtTBJeL+RuLI8owzZH0hlPvq2bzzBRU91U6JRy1DLfm1yGhJb+4/A==
X-Received: by 2002:a05:622a:1306:b0:425:4054:bc51 with SMTP id v6-20020a05622a130600b004254054bc51mr236289qtk.45.1701466886267;
        Fri, 01 Dec 2023 13:41:26 -0800 (PST)
Received: from localhost.localdomain ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id v20-20020ac873d4000000b00423af25edefsm1834582qtp.27.2023.12.01.13.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 13:41:25 -0800 (PST)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH] spi: stm32: enable controller before asserting CS
Date:   Fri,  1 Dec 2023 16:40:14 -0500
Message-ID: <20231201214014.2539031-1-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the STM32F4/7, the SPI pins float while the controller is disabled.
Currently, the controller is enabled in the transfer_one() callback,
which runs after CS is asserted. Therefore, there is a period where the
SPI pins are floating while CS is asserted, making it possible for stray
signals to disrupt communications. An analogous problem occurs at the
end of the transfer when the controller is disabled before CS is
released.

This problem can be reliably observed by enabling the pull-up (if
CPOL=0) or pull-down (if CPOL=1) on the clock pin. This will cause two
extra unintended clock edges per transfer, when the controller is
enabled and disabled.

This patch fixes the bug by enabling the controller in prepare_message()
and disabling it in unprepare_message(), which are called while CS is
not asserted.

Note that bug is likely not present on the STM32H7, because it supports
the AFCNTR bit (and this driver sets it), which keeps the SPI pins
driven even while the controller is disabled.

This patch has been tested on an STM32F746 with a MAX14830 UART
expander.

Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
 drivers/spi/spi-stm32.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 94df3836834c..885f53a51441 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -948,10 +948,8 @@ static irqreturn_t stm32fx_spi_irq_event(int irq, void *dev_id)
 static irqreturn_t stm32fx_spi_irq_thread(int irq, void *dev_id)
 {
 	struct spi_controller *ctrl = dev_id;
-	struct stm32_spi *spi = spi_controller_get_devdata(ctrl);
 
 	spi_finalize_current_transfer(ctrl);
-	stm32fx_spi_disable(spi);
 
 	return IRQ_HANDLED;
 }
@@ -1118,6 +1116,8 @@ static int stm32_spi_prepare_msg(struct spi_controller *ctrl,
 			 ~clrb) | setb,
 			spi->base + spi->cfg->regs->cpol.reg);
 
+	stm32_spi_enable(spi);
+
 	spin_unlock_irqrestore(&spi->lock, flags);
 
 	return 0;
@@ -1135,7 +1135,6 @@ static void stm32fx_spi_dma_tx_cb(void *data)
 
 	if (spi->cur_comm == SPI_SIMPLEX_TX || spi->cur_comm == SPI_3WIRE_TX) {
 		spi_finalize_current_transfer(spi->ctrl);
-		stm32fx_spi_disable(spi);
 	}
 }
 
@@ -1150,7 +1149,6 @@ static void stm32_spi_dma_rx_cb(void *data)
 	struct stm32_spi *spi = data;
 
 	spi_finalize_current_transfer(spi->ctrl);
-	spi->cfg->disable(spi);
 }
 
 /**
@@ -1235,8 +1233,6 @@ static int stm32fx_spi_transfer_one_irq(struct stm32_spi *spi)
 
 	stm32_spi_set_bits(spi, STM32FX_SPI_CR2, cr2);
 
-	stm32_spi_enable(spi);
-
 	/* starting data transfer when buffer is loaded */
 	if (spi->tx_buf)
 		spi->cfg->write_tx(spi);
@@ -1273,8 +1269,6 @@ static int stm32h7_spi_transfer_one_irq(struct stm32_spi *spi)
 
 	spin_lock_irqsave(&spi->lock, flags);
 
-	stm32_spi_enable(spi);
-
 	/* Be sure to have data in fifo before starting data transfer */
 	if (spi->tx_buf)
 		stm32h7_spi_write_txfifo(spi);
@@ -1306,8 +1300,6 @@ static void stm32fx_spi_transfer_one_dma_start(struct stm32_spi *spi)
 		 */
 		stm32_spi_set_bits(spi, STM32FX_SPI_CR2, STM32FX_SPI_CR2_ERRIE);
 	}
-
-	stm32_spi_enable(spi);
 }
 
 /**
@@ -1341,8 +1333,6 @@ static void stm32h7_spi_transfer_one_dma_start(struct stm32_spi *spi)
 
 	stm32_spi_set_bits(spi, STM32H7_SPI_IER, ier);
 
-	stm32_spi_enable(spi);
-
 	if (STM32_SPI_MASTER_MODE(spi))
 		stm32_spi_set_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_CSTART);
 }
-- 
2.42.1

