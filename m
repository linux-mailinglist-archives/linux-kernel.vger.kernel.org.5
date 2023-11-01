Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA7E7DE396
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbjKAPP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjKAPPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:15:53 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC61115
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 08:15:49 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-41cd4446cf5so42784871cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 08:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1698851748; x=1699456548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBZulpjRU9moTg60fC2zDfoRy+4B70morE4SFIpFMP4=;
        b=QRTmcpss/APiVv50ME8kzi6nRzbw/gkOYNNvsP7wpWnQCBgItb9jagN92OtNJKDp0F
         QV+BxN7r64ysQtXGkbYe3999LCTR3D9HYpnp9t+yAdbAQZfmpN0efBF5zjTGzbaG5GlT
         Emki84YAOa+PlGSqvMbuUMrONGdDYkomMSOdHtFUkZgHiywuAAvVMFgGoPZWdP0rRHPk
         SJBXPhZdGYdmNRMvqGMsy/KZ3Bu86OMVL/UdbRr1rL//GtrWWsCe0ccYWeRPA1cCFRUt
         41QS0KN34o6RnNU3NPBylDO4WWHqDo/YWVzhfcbo0TqIMDqLDXAveDmHvSPFHMxitUh6
         RNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698851748; x=1699456548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBZulpjRU9moTg60fC2zDfoRy+4B70morE4SFIpFMP4=;
        b=Nc7A1L9jc/6VKPj1Y4jRzTwwx0nVcbi/1wloXgF5oiWZEEAaLx8jy1zup1RObTZ3K3
         985jU1ZAHFTYyLrapB+vFLLcjGB5Gh3LEO891ebXKXFpfil+javNCeLJJTnIw5+0KXTE
         YZRCxL/QIRDNVQxRXAen+hjXqNckgbNE8aveCDZUrAkSgBhNJgK1sMRz4p2/OqQeNxVA
         HlRFBl5qpa2h6nUF3+BAq5XFyKlvaedWyU1JnzW4lXWuDf3VPlYW3DZZHpQJ+w3bXWfd
         izktphShWzZvlixnM9HfIfk62muRdnUyQIbS2NEMsnLw36zmvbVN0qSZSDGpJTp0FwM2
         Oz7w==
X-Gm-Message-State: AOJu0YzZ+qE5NeR2a3YLfpVYn6ml5O+Y2wiGSyoTmaYVQfbizJZKuKh3
        32rx3fow97EtkLGsn8A/L3Vd4w==
X-Google-Smtp-Source: AGHT+IH8L8Oqtq39Y9RCbXNWwCGF4qpbG01vDHg7C+fxan0Q7+wHdiHCCnn5hsLYlM5fy7boTxVe7g==
X-Received: by 2002:ac8:5741:0:b0:41b:b7ff:2342 with SMTP id 1-20020ac85741000000b0041bb7ff2342mr19926061qtx.44.1698851747981;
        Wed, 01 Nov 2023 08:15:47 -0700 (PDT)
Received: from localhost.localdomain ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id dn5-20020a05622a470500b004181a8a3e2dsm1477165qtb.41.2023.11.01.08.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 08:15:47 -0700 (PDT)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Erwan Leray <erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH 1/5] spi: stm32: rename stm32f4_* to stm32fx_*
Date:   Wed,  1 Nov 2023 11:08:06 -0400
Message-ID: <20231101150811.2747455-2-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231101150811.2747455-1-ben.wolsieffer@hefring.com>
References: <20231101150811.2747455-1-ben.wolsieffer@hefring.com>
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

The STM32F4 and STM32F7 SPI peripherals are very similar, therefore
most of the driver can be shared between the two. In preparation for
adding support for the F7, change all functions and defines to use a
generic stm32fx prefix, except for code and registers that differ
between the two devices.

Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
 drivers/spi/spi-stm32.c | 290 ++++++++++++++++++++--------------------
 1 file changed, 145 insertions(+), 145 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index e6e3e4ea29f9..02d1409d7229 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -22,58 +22,58 @@
 
 #define DRIVER_NAME "spi_stm32"
 
-/* STM32F4 SPI registers */
-#define STM32F4_SPI_CR1			0x00
-#define STM32F4_SPI_CR2			0x04
-#define STM32F4_SPI_SR			0x08
-#define STM32F4_SPI_DR			0x0C
-#define STM32F4_SPI_I2SCFGR		0x1C
-
-/* STM32F4_SPI_CR1 bit fields */
-#define STM32F4_SPI_CR1_CPHA		BIT(0)
-#define STM32F4_SPI_CR1_CPOL		BIT(1)
-#define STM32F4_SPI_CR1_MSTR		BIT(2)
-#define STM32F4_SPI_CR1_BR_SHIFT	3
-#define STM32F4_SPI_CR1_BR		GENMASK(5, 3)
-#define STM32F4_SPI_CR1_SPE		BIT(6)
-#define STM32F4_SPI_CR1_LSBFRST		BIT(7)
-#define STM32F4_SPI_CR1_SSI		BIT(8)
-#define STM32F4_SPI_CR1_SSM		BIT(9)
-#define STM32F4_SPI_CR1_RXONLY		BIT(10)
+/* STM32F4/7 SPI registers */
+#define STM32FX_SPI_CR1			0x00
+#define STM32FX_SPI_CR2			0x04
+#define STM32FX_SPI_SR			0x08
+#define STM32FX_SPI_DR			0x0C
+#define STM32FX_SPI_I2SCFGR		0x1C
+
+/* STM32FX_SPI_CR1 bit fields */
+#define STM32FX_SPI_CR1_CPHA		BIT(0)
+#define STM32FX_SPI_CR1_CPOL		BIT(1)
+#define STM32FX_SPI_CR1_MSTR		BIT(2)
+#define STM32FX_SPI_CR1_BR_SHIFT	3
+#define STM32FX_SPI_CR1_BR		GENMASK(5, 3)
+#define STM32FX_SPI_CR1_SPE		BIT(6)
+#define STM32FX_SPI_CR1_LSBFRST		BIT(7)
+#define STM32FX_SPI_CR1_SSI		BIT(8)
+#define STM32FX_SPI_CR1_SSM		BIT(9)
+#define STM32FX_SPI_CR1_RXONLY		BIT(10)
 #define STM32F4_SPI_CR1_DFF		BIT(11)
-#define STM32F4_SPI_CR1_CRCNEXT		BIT(12)
-#define STM32F4_SPI_CR1_CRCEN		BIT(13)
-#define STM32F4_SPI_CR1_BIDIOE		BIT(14)
-#define STM32F4_SPI_CR1_BIDIMODE	BIT(15)
-#define STM32F4_SPI_CR1_BR_MIN		0
-#define STM32F4_SPI_CR1_BR_MAX		(GENMASK(5, 3) >> 3)
-
-/* STM32F4_SPI_CR2 bit fields */
-#define STM32F4_SPI_CR2_RXDMAEN		BIT(0)
-#define STM32F4_SPI_CR2_TXDMAEN		BIT(1)
-#define STM32F4_SPI_CR2_SSOE		BIT(2)
-#define STM32F4_SPI_CR2_FRF		BIT(4)
-#define STM32F4_SPI_CR2_ERRIE		BIT(5)
-#define STM32F4_SPI_CR2_RXNEIE		BIT(6)
-#define STM32F4_SPI_CR2_TXEIE		BIT(7)
-
-/* STM32F4_SPI_SR bit fields */
-#define STM32F4_SPI_SR_RXNE		BIT(0)
-#define STM32F4_SPI_SR_TXE		BIT(1)
-#define STM32F4_SPI_SR_CHSIDE		BIT(2)
-#define STM32F4_SPI_SR_UDR		BIT(3)
-#define STM32F4_SPI_SR_CRCERR		BIT(4)
-#define STM32F4_SPI_SR_MODF		BIT(5)
-#define STM32F4_SPI_SR_OVR		BIT(6)
-#define STM32F4_SPI_SR_BSY		BIT(7)
-#define STM32F4_SPI_SR_FRE		BIT(8)
-
-/* STM32F4_SPI_I2SCFGR bit fields */
-#define STM32F4_SPI_I2SCFGR_I2SMOD	BIT(11)
+#define STM32FX_SPI_CR1_CRCNEXT		BIT(12)
+#define STM32FX_SPI_CR1_CRCEN		BIT(13)
+#define STM32FX_SPI_CR1_BIDIOE		BIT(14)
+#define STM32FX_SPI_CR1_BIDIMODE	BIT(15)
+#define STM32FX_SPI_CR1_BR_MIN		0
+#define STM32FX_SPI_CR1_BR_MAX		(GENMASK(5, 3) >> 3)
+
+/* STM32FX_SPI_CR2 bit fields */
+#define STM32FX_SPI_CR2_RXDMAEN		BIT(0)
+#define STM32FX_SPI_CR2_TXDMAEN		BIT(1)
+#define STM32FX_SPI_CR2_SSOE		BIT(2)
+#define STM32FX_SPI_CR2_FRF		BIT(4)
+#define STM32FX_SPI_CR2_ERRIE		BIT(5)
+#define STM32FX_SPI_CR2_RXNEIE		BIT(6)
+#define STM32FX_SPI_CR2_TXEIE		BIT(7)
+
+/* STM32FX_SPI_SR bit fields */
+#define STM32FX_SPI_SR_RXNE		BIT(0)
+#define STM32FX_SPI_SR_TXE		BIT(1)
+#define STM32FX_SPI_SR_CHSIDE		BIT(2)
+#define STM32FX_SPI_SR_UDR		BIT(3)
+#define STM32FX_SPI_SR_CRCERR		BIT(4)
+#define STM32FX_SPI_SR_MODF		BIT(5)
+#define STM32FX_SPI_SR_OVR		BIT(6)
+#define STM32FX_SPI_SR_BSY		BIT(7)
+#define STM32FX_SPI_SR_FRE		BIT(8)
+
+/* STM32FX_SPI_I2SCFGR bit fields */
+#define STM32FX_SPI_I2SCFGR_I2SMOD	BIT(11)
 
 /* STM32F4 SPI Baud Rate min/max divisor */
-#define STM32F4_SPI_BR_DIV_MIN		(2 << STM32F4_SPI_CR1_BR_MIN)
-#define STM32F4_SPI_BR_DIV_MAX		(2 << STM32F4_SPI_CR1_BR_MAX)
+#define STM32FX_SPI_BR_DIV_MIN		(2 << STM32FX_SPI_CR1_BR_MIN)
+#define STM32FX_SPI_BR_DIV_MAX		(2 << STM32FX_SPI_CR1_BR_MAX)
 
 /* STM32H7 SPI registers */
 #define STM32H7_SPI_CR1			0x00
@@ -324,20 +324,20 @@ struct stm32_spi {
 	bool device_mode;
 };
 
-static const struct stm32_spi_regspec stm32f4_spi_regspec = {
-	.en = { STM32F4_SPI_CR1, STM32F4_SPI_CR1_SPE },
+static const struct stm32_spi_regspec stm32fx_spi_regspec = {
+	.en = { STM32FX_SPI_CR1, STM32FX_SPI_CR1_SPE },
 
-	.dma_rx_en = { STM32F4_SPI_CR2, STM32F4_SPI_CR2_RXDMAEN },
-	.dma_tx_en = { STM32F4_SPI_CR2, STM32F4_SPI_CR2_TXDMAEN },
+	.dma_rx_en = { STM32FX_SPI_CR2, STM32FX_SPI_CR2_RXDMAEN },
+	.dma_tx_en = { STM32FX_SPI_CR2, STM32FX_SPI_CR2_TXDMAEN },
 
-	.cpol = { STM32F4_SPI_CR1, STM32F4_SPI_CR1_CPOL },
-	.cpha = { STM32F4_SPI_CR1, STM32F4_SPI_CR1_CPHA },
-	.lsb_first = { STM32F4_SPI_CR1, STM32F4_SPI_CR1_LSBFRST },
+	.cpol = { STM32FX_SPI_CR1, STM32FX_SPI_CR1_CPOL },
+	.cpha = { STM32FX_SPI_CR1, STM32FX_SPI_CR1_CPHA },
+	.lsb_first = { STM32FX_SPI_CR1, STM32FX_SPI_CR1_LSBFRST },
 	.cs_high = {},
-	.br = { STM32F4_SPI_CR1, STM32F4_SPI_CR1_BR, STM32F4_SPI_CR1_BR_SHIFT },
+	.br = { STM32FX_SPI_CR1, STM32FX_SPI_CR1_BR, STM32FX_SPI_CR1_BR_SHIFT },
 
-	.rx = { STM32F4_SPI_DR },
-	.tx = { STM32F4_SPI_DR },
+	.rx = { STM32FX_SPI_DR },
+	.tx = { STM32FX_SPI_DR },
 };
 
 static const struct stm32_spi_regspec stm32h7_spi_regspec = {
@@ -502,19 +502,19 @@ static u32 stm32h7_spi_prepare_fthlv(struct stm32_spi *spi, u32 xfer_len)
  */
 static void stm32f4_spi_write_tx(struct stm32_spi *spi)
 {
-	if ((spi->tx_len > 0) && (readl_relaxed(spi->base + STM32F4_SPI_SR) &
-				  STM32F4_SPI_SR_TXE)) {
+	if ((spi->tx_len > 0) && (readl_relaxed(spi->base + STM32FX_SPI_SR) &
+				  STM32FX_SPI_SR_TXE)) {
 		u32 offs = spi->cur_xferlen - spi->tx_len;
 
 		if (spi->cur_bpw == 16) {
 			const u16 *tx_buf16 = (const u16 *)(spi->tx_buf + offs);
 
-			writew_relaxed(*tx_buf16, spi->base + STM32F4_SPI_DR);
+			writew_relaxed(*tx_buf16, spi->base + STM32FX_SPI_DR);
 			spi->tx_len -= sizeof(u16);
 		} else {
 			const u8 *tx_buf8 = (const u8 *)(spi->tx_buf + offs);
 
-			writeb_relaxed(*tx_buf8, spi->base + STM32F4_SPI_DR);
+			writeb_relaxed(*tx_buf8, spi->base + STM32FX_SPI_DR);
 			spi->tx_len -= sizeof(u8);
 		}
 	}
@@ -566,19 +566,19 @@ static void stm32h7_spi_write_txfifo(struct stm32_spi *spi)
  */
 static void stm32f4_spi_read_rx(struct stm32_spi *spi)
 {
-	if ((spi->rx_len > 0) && (readl_relaxed(spi->base + STM32F4_SPI_SR) &
-				  STM32F4_SPI_SR_RXNE)) {
+	if ((spi->rx_len > 0) && (readl_relaxed(spi->base + STM32FX_SPI_SR) &
+				  STM32FX_SPI_SR_RXNE)) {
 		u32 offs = spi->cur_xferlen - spi->rx_len;
 
 		if (spi->cur_bpw == 16) {
 			u16 *rx_buf16 = (u16 *)(spi->rx_buf + offs);
 
-			*rx_buf16 = readw_relaxed(spi->base + STM32F4_SPI_DR);
+			*rx_buf16 = readw_relaxed(spi->base + STM32FX_SPI_DR);
 			spi->rx_len -= sizeof(u16);
 		} else {
 			u8 *rx_buf8 = (u8 *)(spi->rx_buf + offs);
 
-			*rx_buf8 = readb_relaxed(spi->base + STM32F4_SPI_DR);
+			*rx_buf8 = readb_relaxed(spi->base + STM32FX_SPI_DR);
 			spi->rx_len -= sizeof(u8);
 		}
 	}
@@ -645,10 +645,10 @@ static void stm32_spi_enable(struct stm32_spi *spi)
 }
 
 /**
- * stm32f4_spi_disable - Disable SPI controller
+ * stm32fx_spi_disable - Disable SPI controller
  * @spi: pointer to the spi controller data structure
  */
-static void stm32f4_spi_disable(struct stm32_spi *spi)
+static void stm32fx_spi_disable(struct stm32_spi *spi)
 {
 	unsigned long flags;
 	u32 sr;
@@ -657,20 +657,20 @@ static void stm32f4_spi_disable(struct stm32_spi *spi)
 
 	spin_lock_irqsave(&spi->lock, flags);
 
-	if (!(readl_relaxed(spi->base + STM32F4_SPI_CR1) &
-	      STM32F4_SPI_CR1_SPE)) {
+	if (!(readl_relaxed(spi->base + STM32FX_SPI_CR1) &
+	      STM32FX_SPI_CR1_SPE)) {
 		spin_unlock_irqrestore(&spi->lock, flags);
 		return;
 	}
 
 	/* Disable interrupts */
-	stm32_spi_clr_bits(spi, STM32F4_SPI_CR2, STM32F4_SPI_CR2_TXEIE |
-						 STM32F4_SPI_CR2_RXNEIE |
-						 STM32F4_SPI_CR2_ERRIE);
+	stm32_spi_clr_bits(spi, STM32FX_SPI_CR2, STM32FX_SPI_CR2_TXEIE |
+						 STM32FX_SPI_CR2_RXNEIE |
+						 STM32FX_SPI_CR2_ERRIE);
 
 	/* Wait until BSY = 0 */
-	if (readl_relaxed_poll_timeout_atomic(spi->base + STM32F4_SPI_SR,
-					      sr, !(sr & STM32F4_SPI_SR_BSY),
+	if (readl_relaxed_poll_timeout_atomic(spi->base + STM32FX_SPI_SR,
+					      sr, !(sr & STM32FX_SPI_SR_BSY),
 					      10, 100000) < 0) {
 		dev_warn(spi->dev, "disabling condition timeout\n");
 	}
@@ -680,14 +680,14 @@ static void stm32f4_spi_disable(struct stm32_spi *spi)
 	if (spi->cur_usedma && spi->dma_rx)
 		dmaengine_terminate_async(spi->dma_rx);
 
-	stm32_spi_clr_bits(spi, STM32F4_SPI_CR1, STM32F4_SPI_CR1_SPE);
+	stm32_spi_clr_bits(spi, STM32FX_SPI_CR1, STM32FX_SPI_CR1_SPE);
 
-	stm32_spi_clr_bits(spi, STM32F4_SPI_CR2, STM32F4_SPI_CR2_TXDMAEN |
-						 STM32F4_SPI_CR2_RXDMAEN);
+	stm32_spi_clr_bits(spi, STM32FX_SPI_CR2, STM32FX_SPI_CR2_TXDMAEN |
+						 STM32FX_SPI_CR2_RXDMAEN);
 
 	/* Sequence to clear OVR flag */
-	readl_relaxed(spi->base + STM32F4_SPI_DR);
-	readl_relaxed(spi->base + STM32F4_SPI_SR);
+	readl_relaxed(spi->base + STM32FX_SPI_DR);
+	readl_relaxed(spi->base + STM32FX_SPI_SR);
 
 	spin_unlock_irqrestore(&spi->lock, flags);
 }
@@ -763,11 +763,11 @@ static bool stm32_spi_can_dma(struct spi_controller *ctrl,
 }
 
 /**
- * stm32f4_spi_irq_event - Interrupt handler for SPI controller events
+ * stm32fx_spi_irq_event - Interrupt handler for SPI controller events
  * @irq: interrupt line
  * @dev_id: SPI controller ctrl interface
  */
-static irqreturn_t stm32f4_spi_irq_event(int irq, void *dev_id)
+static irqreturn_t stm32fx_spi_irq_event(int irq, void *dev_id)
 {
 	struct spi_controller *ctrl = dev_id;
 	struct stm32_spi *spi = spi_controller_get_devdata(ctrl);
@@ -776,26 +776,26 @@ static irqreturn_t stm32f4_spi_irq_event(int irq, void *dev_id)
 
 	spin_lock(&spi->lock);
 
-	sr = readl_relaxed(spi->base + STM32F4_SPI_SR);
+	sr = readl_relaxed(spi->base + STM32FX_SPI_SR);
 	/*
 	 * BSY flag is not handled in interrupt but it is normal behavior when
 	 * this flag is set.
 	 */
-	sr &= ~STM32F4_SPI_SR_BSY;
+	sr &= ~STM32FX_SPI_SR_BSY;
 
 	if (!spi->cur_usedma && (spi->cur_comm == SPI_SIMPLEX_TX ||
 				 spi->cur_comm == SPI_3WIRE_TX)) {
 		/* OVR flag shouldn't be handled for TX only mode */
-		sr &= ~(STM32F4_SPI_SR_OVR | STM32F4_SPI_SR_RXNE);
-		mask |= STM32F4_SPI_SR_TXE;
+		sr &= ~(STM32FX_SPI_SR_OVR | STM32FX_SPI_SR_RXNE);
+		mask |= STM32FX_SPI_SR_TXE;
 	}
 
 	if (!spi->cur_usedma && (spi->cur_comm == SPI_FULL_DUPLEX ||
 				spi->cur_comm == SPI_SIMPLEX_RX ||
 				spi->cur_comm == SPI_3WIRE_RX)) {
 		/* TXE flag is set and is handled when RXNE flag occurs */
-		sr &= ~STM32F4_SPI_SR_TXE;
-		mask |= STM32F4_SPI_SR_RXNE | STM32F4_SPI_SR_OVR;
+		sr &= ~STM32FX_SPI_SR_TXE;
+		mask |= STM32FX_SPI_SR_RXNE | STM32FX_SPI_SR_OVR;
 	}
 
 	if (!(sr & mask)) {
@@ -804,12 +804,12 @@ static irqreturn_t stm32f4_spi_irq_event(int irq, void *dev_id)
 		return IRQ_NONE;
 	}
 
-	if (sr & STM32F4_SPI_SR_OVR) {
+	if (sr & STM32FX_SPI_SR_OVR) {
 		dev_warn(spi->dev, "Overrun: received value discarded\n");
 
 		/* Sequence to clear OVR flag */
-		readl_relaxed(spi->base + STM32F4_SPI_DR);
-		readl_relaxed(spi->base + STM32F4_SPI_SR);
+		readl_relaxed(spi->base + STM32FX_SPI_DR);
+		readl_relaxed(spi->base + STM32FX_SPI_SR);
 
 		/*
 		 * If overrun is detected, it means that something went wrong,
@@ -820,14 +820,14 @@ static irqreturn_t stm32f4_spi_irq_event(int irq, void *dev_id)
 		goto end_irq;
 	}
 
-	if (sr & STM32F4_SPI_SR_TXE) {
+	if (sr & STM32FX_SPI_SR_TXE) {
 		if (spi->tx_buf)
 			stm32f4_spi_write_tx(spi);
 		if (spi->tx_len == 0)
 			end = true;
 	}
 
-	if (sr & STM32F4_SPI_SR_RXNE) {
+	if (sr & STM32FX_SPI_SR_RXNE) {
 		stm32f4_spi_read_rx(spi);
 		if (spi->rx_len == 0)
 			end = true;
@@ -838,10 +838,10 @@ static irqreturn_t stm32f4_spi_irq_event(int irq, void *dev_id)
 end_irq:
 	if (end) {
 		/* Immediately disable interrupts to do not generate new one */
-		stm32_spi_clr_bits(spi, STM32F4_SPI_CR2,
-					STM32F4_SPI_CR2_TXEIE |
-					STM32F4_SPI_CR2_RXNEIE |
-					STM32F4_SPI_CR2_ERRIE);
+		stm32_spi_clr_bits(spi, STM32FX_SPI_CR2,
+					STM32FX_SPI_CR2_TXEIE |
+					STM32FX_SPI_CR2_RXNEIE |
+					STM32FX_SPI_CR2_ERRIE);
 		spin_unlock(&spi->lock);
 		return IRQ_WAKE_THREAD;
 	}
@@ -851,17 +851,17 @@ static irqreturn_t stm32f4_spi_irq_event(int irq, void *dev_id)
 }
 
 /**
- * stm32f4_spi_irq_thread - Thread of interrupt handler for SPI controller
+ * stm32fx_spi_irq_thread - Thread of interrupt handler for SPI controller
  * @irq: interrupt line
  * @dev_id: SPI controller interface
  */
-static irqreturn_t stm32f4_spi_irq_thread(int irq, void *dev_id)
+static irqreturn_t stm32fx_spi_irq_thread(int irq, void *dev_id)
 {
 	struct spi_controller *ctrl = dev_id;
 	struct stm32_spi *spi = spi_controller_get_devdata(ctrl);
 
 	spi_finalize_current_transfer(ctrl);
-	stm32f4_spi_disable(spi);
+	stm32fx_spi_disable(spi);
 
 	return IRQ_HANDLED;
 }
@@ -1034,18 +1034,18 @@ static int stm32_spi_prepare_msg(struct spi_controller *ctrl,
 }
 
 /**
- * stm32f4_spi_dma_tx_cb - dma callback
+ * stm32fx_spi_dma_tx_cb - dma callback
  * @data: pointer to the spi controller data structure
  *
  * DMA callback is called when the transfer is complete for DMA TX channel.
  */
-static void stm32f4_spi_dma_tx_cb(void *data)
+static void stm32fx_spi_dma_tx_cb(void *data)
 {
 	struct stm32_spi *spi = data;
 
 	if (spi->cur_comm == SPI_SIMPLEX_TX || spi->cur_comm == SPI_3WIRE_TX) {
 		spi_finalize_current_transfer(spi->ctrl);
-		stm32f4_spi_disable(spi);
+		stm32fx_spi_disable(spi);
 	}
 }
 
@@ -1114,21 +1114,21 @@ static void stm32_spi_dma_config(struct stm32_spi *spi,
 }
 
 /**
- * stm32f4_spi_transfer_one_irq - transfer a single spi_transfer using
+ * stm32fx_spi_transfer_one_irq - transfer a single spi_transfer using
  *				  interrupts
  * @spi: pointer to the spi controller data structure
  *
  * It must returns 0 if the transfer is finished or 1 if the transfer is still
  * in progress.
  */
-static int stm32f4_spi_transfer_one_irq(struct stm32_spi *spi)
+static int stm32fx_spi_transfer_one_irq(struct stm32_spi *spi)
 {
 	unsigned long flags;
 	u32 cr2 = 0;
 
 	/* Enable the interrupts relative to the current communication mode */
 	if (spi->cur_comm == SPI_SIMPLEX_TX || spi->cur_comm == SPI_3WIRE_TX) {
-		cr2 |= STM32F4_SPI_CR2_TXEIE;
+		cr2 |= STM32FX_SPI_CR2_TXEIE;
 	} else if (spi->cur_comm == SPI_FULL_DUPLEX ||
 				spi->cur_comm == SPI_SIMPLEX_RX ||
 				spi->cur_comm == SPI_3WIRE_RX) {
@@ -1136,14 +1136,14 @@ static int stm32f4_spi_transfer_one_irq(struct stm32_spi *spi)
 		 * since the received data are never read. Therefore set OVR
 		 * interrupt only when rx buffer is available.
 		 */
-		cr2 |= STM32F4_SPI_CR2_RXNEIE | STM32F4_SPI_CR2_ERRIE;
+		cr2 |= STM32FX_SPI_CR2_RXNEIE | STM32FX_SPI_CR2_ERRIE;
 	} else {
 		return -EINVAL;
 	}
 
 	spin_lock_irqsave(&spi->lock, flags);
 
-	stm32_spi_set_bits(spi, STM32F4_SPI_CR2, cr2);
+	stm32_spi_set_bits(spi, STM32FX_SPI_CR2, cr2);
 
 	stm32_spi_enable(spi);
 
@@ -1200,11 +1200,11 @@ static int stm32h7_spi_transfer_one_irq(struct stm32_spi *spi)
 }
 
 /**
- * stm32f4_spi_transfer_one_dma_start - Set SPI driver registers to start
+ * stm32fx_spi_transfer_one_dma_start - Set SPI driver registers to start
  *					transfer using DMA
  * @spi: pointer to the spi controller data structure
  */
-static void stm32f4_spi_transfer_one_dma_start(struct stm32_spi *spi)
+static void stm32fx_spi_transfer_one_dma_start(struct stm32_spi *spi)
 {
 	/* In DMA mode end of transfer is handled by DMA TX or RX callback. */
 	if (spi->cur_comm == SPI_SIMPLEX_RX || spi->cur_comm == SPI_3WIRE_RX ||
@@ -1214,7 +1214,7 @@ static void stm32f4_spi_transfer_one_dma_start(struct stm32_spi *spi)
 		 * since the received data are never read. Therefore set OVR
 		 * interrupt only when rx buffer is available.
 		 */
-		stm32_spi_set_bits(spi, STM32F4_SPI_CR2, STM32F4_SPI_CR2_ERRIE);
+		stm32_spi_set_bits(spi, STM32FX_SPI_CR2, STM32FX_SPI_CR2_ERRIE);
 	}
 
 	stm32_spi_enable(spi);
@@ -1353,9 +1353,9 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 static void stm32f4_spi_set_bpw(struct stm32_spi *spi)
 {
 	if (spi->cur_bpw == 16)
-		stm32_spi_set_bits(spi, STM32F4_SPI_CR1, STM32F4_SPI_CR1_DFF);
+		stm32_spi_set_bits(spi, STM32FX_SPI_CR1, STM32F4_SPI_CR1_DFF);
 	else
-		stm32_spi_clr_bits(spi, STM32F4_SPI_CR1, STM32F4_SPI_CR1_DFF);
+		stm32_spi_clr_bits(spi, STM32FX_SPI_CR1, STM32F4_SPI_CR1_DFF);
 }
 
 /**
@@ -1433,26 +1433,26 @@ static unsigned int stm32_spi_communication_type(struct spi_device *spi_dev,
 }
 
 /**
- * stm32f4_spi_set_mode - configure communication mode
+ * stm32fx_spi_set_mode - configure communication mode
  * @spi: pointer to the spi controller data structure
  * @comm_type: type of communication to configure
  */
-static int stm32f4_spi_set_mode(struct stm32_spi *spi, unsigned int comm_type)
+static int stm32fx_spi_set_mode(struct stm32_spi *spi, unsigned int comm_type)
 {
 	if (comm_type == SPI_3WIRE_TX || comm_type == SPI_SIMPLEX_TX) {
-		stm32_spi_set_bits(spi, STM32F4_SPI_CR1,
-					STM32F4_SPI_CR1_BIDIMODE |
-					STM32F4_SPI_CR1_BIDIOE);
+		stm32_spi_set_bits(spi, STM32FX_SPI_CR1,
+					STM32FX_SPI_CR1_BIDIMODE |
+					STM32FX_SPI_CR1_BIDIOE);
 	} else if (comm_type == SPI_FULL_DUPLEX ||
 				comm_type == SPI_SIMPLEX_RX) {
-		stm32_spi_clr_bits(spi, STM32F4_SPI_CR1,
-					STM32F4_SPI_CR1_BIDIMODE |
-					STM32F4_SPI_CR1_BIDIOE);
+		stm32_spi_clr_bits(spi, STM32FX_SPI_CR1,
+					STM32FX_SPI_CR1_BIDIMODE |
+					STM32FX_SPI_CR1_BIDIOE);
 	} else if (comm_type == SPI_3WIRE_RX) {
-		stm32_spi_set_bits(spi, STM32F4_SPI_CR1,
-					STM32F4_SPI_CR1_BIDIMODE);
-		stm32_spi_clr_bits(spi, STM32F4_SPI_CR1,
-					STM32F4_SPI_CR1_BIDIOE);
+		stm32_spi_set_bits(spi, STM32FX_SPI_CR1,
+					STM32FX_SPI_CR1_BIDIMODE);
+		stm32_spi_clr_bits(spi, STM32FX_SPI_CR1,
+					STM32FX_SPI_CR1_BIDIOE);
 	} else {
 		return -EINVAL;
 	}
@@ -1672,18 +1672,18 @@ static int stm32_spi_unprepare_msg(struct spi_controller *ctrl,
 }
 
 /**
- * stm32f4_spi_config - Configure SPI controller as SPI master
+ * stm32fx_spi_config - Configure SPI controller as SPI master
  * @spi: pointer to the spi controller data structure
  */
-static int stm32f4_spi_config(struct stm32_spi *spi)
+static int stm32fx_spi_config(struct stm32_spi *spi)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&spi->lock, flags);
 
 	/* Ensure I2SMOD bit is kept cleared */
-	stm32_spi_clr_bits(spi, STM32F4_SPI_I2SCFGR,
-			   STM32F4_SPI_I2SCFGR_I2SMOD);
+	stm32_spi_clr_bits(spi, STM32FX_SPI_I2SCFGR,
+			   STM32FX_SPI_I2SCFGR_I2SMOD);
 
 	/*
 	 * - SS input value high
@@ -1692,10 +1692,10 @@ static int stm32f4_spi_config(struct stm32_spi *spi)
 	 * - Consider 1 master/n slaves configuration and
 	 *   SS input value is determined by the SSI bit
 	 */
-	stm32_spi_set_bits(spi, STM32F4_SPI_CR1, STM32F4_SPI_CR1_SSI |
-						 STM32F4_SPI_CR1_BIDIOE |
-						 STM32F4_SPI_CR1_MSTR |
-						 STM32F4_SPI_CR1_SSM);
+	stm32_spi_set_bits(spi, STM32FX_SPI_CR1, STM32FX_SPI_CR1_SSI |
+						 STM32FX_SPI_CR1_BIDIOE |
+						 STM32FX_SPI_CR1_MSTR |
+						 STM32FX_SPI_CR1_SSM);
 
 	spin_unlock_irqrestore(&spi->lock, flags);
 
@@ -1746,20 +1746,20 @@ static int stm32h7_spi_config(struct stm32_spi *spi)
 }
 
 static const struct stm32_spi_cfg stm32f4_spi_cfg = {
-	.regs = &stm32f4_spi_regspec,
+	.regs = &stm32fx_spi_regspec,
 	.get_bpw_mask = stm32f4_spi_get_bpw_mask,
-	.disable = stm32f4_spi_disable,
-	.config = stm32f4_spi_config,
+	.disable = stm32fx_spi_disable,
+	.config = stm32fx_spi_config,
 	.set_bpw = stm32f4_spi_set_bpw,
-	.set_mode = stm32f4_spi_set_mode,
-	.transfer_one_dma_start = stm32f4_spi_transfer_one_dma_start,
-	.dma_tx_cb = stm32f4_spi_dma_tx_cb,
+	.set_mode = stm32fx_spi_set_mode,
+	.transfer_one_dma_start = stm32fx_spi_transfer_one_dma_start,
+	.dma_tx_cb = stm32fx_spi_dma_tx_cb,
 	.dma_rx_cb = stm32_spi_dma_rx_cb,
-	.transfer_one_irq = stm32f4_spi_transfer_one_irq,
-	.irq_handler_event = stm32f4_spi_irq_event,
-	.irq_handler_thread = stm32f4_spi_irq_thread,
-	.baud_rate_div_min = STM32F4_SPI_BR_DIV_MIN,
-	.baud_rate_div_max = STM32F4_SPI_BR_DIV_MAX,
+	.transfer_one_irq = stm32fx_spi_transfer_one_irq,
+	.irq_handler_event = stm32fx_spi_irq_event,
+	.irq_handler_thread = stm32fx_spi_irq_thread,
+	.baud_rate_div_min = STM32FX_SPI_BR_DIV_MIN,
+	.baud_rate_div_max = STM32FX_SPI_BR_DIV_MAX,
 	.has_fifo = false,
 	.has_device_mode = false,
 	.flags = SPI_CONTROLLER_MUST_TX,
-- 
2.42.0

