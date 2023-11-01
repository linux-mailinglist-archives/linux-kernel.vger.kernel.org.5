Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFE87DE311
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjKAPQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjKAPP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:15:56 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F0F12E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 08:15:53 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-41cc56255e3so39988301cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 08:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1698851752; x=1699456552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fMbtj6Shp6LrDfaVnTk1SrT1Mux6UV0Wpvs8EuVwqM=;
        b=04HGV8dlZQWakoxrVkZ4mi1KDtDG3/GI/QDT+hawh40K8qH7qJtZgev1SLoK9rZ3lY
         GUo7yFBW0OOQXaNHGc6RK0Au4bEgqfKaXNjG1isqxd2BfBf+5zQNP0v/1cP8vA+NVWk5
         4tUULvOszMVyQcsipzeF8Mq/uSf1kw9g9ijoFWEovxdbGnK8/VQi4dYDL95RE0BtYsTr
         YROPSqu70m/eK3ZuqbOnIwevoxdAuurKdkHN31OcIWbE5htc8Erg0v/6k9By21tAfNOO
         d9zJoNBITBneDvRSmy3npTJiI66HaeNAOXCpnq/mi+tUSJ50Ta14NHJMz+Mu818vI7J4
         iO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698851752; x=1699456552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fMbtj6Shp6LrDfaVnTk1SrT1Mux6UV0Wpvs8EuVwqM=;
        b=K9B6idJqmVh4SPMRqQBdpvj9dHspcozTwi7e9Qe/cZ2oluSestC0lpIvJ2U3K4waX2
         mO6k+yubSGagkUH1Mj/C3kZR8i7asBG2Ihsb2RvztWEtyPscqatbwpRXGQP+eiiVZ9Rk
         CwjMwAyyPbv3k9q18+iWR9OBtnZYDEATiwozV9T0Ge9stO6FNRSz3ySP3wjCkzdSh8qA
         rhehcjG8G16zK/vor7v6cKU/7W0E4LrZZmrzjHyDEeQ9LTGDk73emNT74s/iDONRMhSI
         S/WxEYSQIMx+sVYRnWf8wjQqc2gJYD89NO8gLPWTlOB3KOAUUqXedxDq6CSdJVn4e5l8
         BNTA==
X-Gm-Message-State: AOJu0Yxkt/PhJnGZICcirEOFVIYLSi+lGSnOB7dB7ORFTZCss3MEtffz
        cawu65TajKZcRL2C8AosGBukKA==
X-Google-Smtp-Source: AGHT+IFjT3w8tuISHUaom5dqIukVE0D3rKYD1zeO8+HUp49WhQlakhcDhRx4fRU1TAcl1ljJp4mLcQ==
X-Received: by 2002:ac8:5d12:0:b0:41e:24aa:81a0 with SMTP id f18-20020ac85d12000000b0041e24aa81a0mr24071158qtx.62.1698851752073;
        Wed, 01 Nov 2023 08:15:52 -0700 (PDT)
Received: from localhost.localdomain ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id dn5-20020a05622a470500b004181a8a3e2dsm1477165qtb.41.2023.11.01.08.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 08:15:51 -0700 (PDT)
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
Subject: [PATCH 4/5] spi: stm32: add STM32F7 support
Date:   Wed,  1 Nov 2023 11:08:09 -0400
Message-ID: <20231101150811.2747455-5-ben.wolsieffer@hefring.com>
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

The STM32F7 SPI peripheral is similar to the STM32F4, except it allows
arbitrary word lengths between 4 and 16 bits, and has a small 32-bit
FIFO that allows two 8-bit or smaller words to be transferred with a
single 16-bit read/write.

Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
 drivers/spi/spi-stm32.c | 149 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 427788d18532..94df3836834c 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -41,6 +41,7 @@
 #define STM32FX_SPI_CR1_SSM		BIT(9)
 #define STM32FX_SPI_CR1_RXONLY		BIT(10)
 #define STM32F4_SPI_CR1_DFF		BIT(11)
+#define STM32F7_SPI_CR1_CRCL		BIT(11)
 #define STM32FX_SPI_CR1_CRCNEXT		BIT(12)
 #define STM32FX_SPI_CR1_CRCEN		BIT(13)
 #define STM32FX_SPI_CR1_BIDIOE		BIT(14)
@@ -56,6 +57,10 @@
 #define STM32FX_SPI_CR2_ERRIE		BIT(5)
 #define STM32FX_SPI_CR2_RXNEIE		BIT(6)
 #define STM32FX_SPI_CR2_TXEIE		BIT(7)
+#define STM32F7_SPI_CR2_DS		GENMASK(11, 8)
+#define STM32F7_SPI_CR2_FRXTH		BIT(12)
+#define STM32F7_SPI_CR2_LDMA_RX		BIT(13)
+#define STM32F7_SPI_CR2_LDMA_TX		BIT(14)
 
 /* STM32FX_SPI_SR bit fields */
 #define STM32FX_SPI_SR_RXNE		BIT(0)
@@ -67,6 +72,8 @@
 #define STM32FX_SPI_SR_OVR		BIT(6)
 #define STM32FX_SPI_SR_BSY		BIT(7)
 #define STM32FX_SPI_SR_FRE		BIT(8)
+#define STM32F7_SPI_SR_FRLVL		GENMASK(10, 9)
+#define STM32F7_SPI_SR_FTLVL		GENMASK(12, 11)
 
 /* STM32FX_SPI_I2SCFGR bit fields */
 #define STM32FX_SPI_I2SCFGR_I2SMOD	BIT(11)
@@ -413,6 +420,16 @@ static int stm32f4_spi_get_bpw_mask(struct stm32_spi *spi)
 	return SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
 }
 
+/**
+ * stm32f7_spi_get_bpw_mask - Return bits per word mask
+ * @spi: pointer to the spi controller data structure
+ */
+static int stm32f7_spi_get_bpw_mask(struct stm32_spi *spi)
+{
+	dev_dbg(spi->dev, "16-bit maximum data frame\n");
+	return SPI_BPW_RANGE_MASK(4, 16);
+}
+
 /**
  * stm32h7_spi_get_bpw_mask - Return bits per word mask
  * @spi: pointer to the spi controller data structure
@@ -526,6 +543,35 @@ static void stm32f4_spi_write_tx(struct stm32_spi *spi)
 	dev_dbg(spi->dev, "%s: %d bytes left\n", __func__, spi->tx_len);
 }
 
+/**
+ * stm32f7_spi_write_tx - Write bytes to Transmit Data Register
+ * @spi: pointer to the spi controller data structure
+ *
+ * Read from tx_buf depends on remaining bytes to avoid to read beyond
+ * tx_buf end.
+ */
+static void stm32f7_spi_write_tx(struct stm32_spi *spi)
+{
+	if ((spi->tx_len > 0) && (readl_relaxed(spi->base + STM32FX_SPI_SR) &
+				  STM32FX_SPI_SR_TXE)) {
+		u32 offs = spi->cur_xferlen - spi->tx_len;
+
+		if (spi->tx_len >= sizeof(u16)) {
+			const u16 *tx_buf16 = (const u16 *)(spi->tx_buf + offs);
+
+			writew_relaxed(*tx_buf16, spi->base + STM32FX_SPI_DR);
+			spi->tx_len -= sizeof(u16);
+		} else {
+			const u8 *tx_buf8 = (const u8 *)(spi->tx_buf + offs);
+
+			writeb_relaxed(*tx_buf8, spi->base + STM32FX_SPI_DR);
+			spi->tx_len -= sizeof(u8);
+		}
+	}
+
+	dev_dbg(spi->dev, "%s: %d bytes left\n", __func__, spi->tx_len);
+}
+
 /**
  * stm32h7_spi_write_txfifo - Write bytes in Transmit Data Register
  * @spi: pointer to the spi controller data structure
@@ -590,6 +636,46 @@ static void stm32f4_spi_read_rx(struct stm32_spi *spi)
 	dev_dbg(spi->dev, "%s: %d bytes left\n", __func__, spi->rx_len);
 }
 
+/**
+ * stm32f7_spi_read_rx - Read bytes from Receive Data Register
+ * @spi: pointer to the spi controller data structure
+ *
+ * Write in rx_buf depends on remaining bytes to avoid to write beyond
+ * rx_buf end.
+ */
+static void stm32f7_spi_read_rx(struct stm32_spi *spi)
+{
+	u32 sr = readl_relaxed(spi->base + STM32FX_SPI_SR);
+	u32 frlvl = FIELD_GET(STM32F7_SPI_SR_FRLVL, sr);
+
+	while ((spi->rx_len > 0) && (frlvl > 0)) {
+		u32 offs = spi->cur_xferlen - spi->rx_len;
+
+		if ((spi->rx_len >= sizeof(u16)) && (frlvl >= 2)) {
+			u16 *rx_buf16 = (u16 *)(spi->rx_buf + offs);
+
+			*rx_buf16 = readw_relaxed(spi->base + STM32FX_SPI_DR);
+			spi->rx_len -= sizeof(u16);
+		} else {
+			u8 *rx_buf8 = (u8 *)(spi->rx_buf + offs);
+
+			*rx_buf8 = readb_relaxed(spi->base + STM32FX_SPI_DR);
+			spi->rx_len -= sizeof(u8);
+		}
+
+		sr = readl_relaxed(spi->base + STM32FX_SPI_SR);
+		frlvl = FIELD_GET(STM32F7_SPI_SR_FRLVL, sr);
+	}
+
+	if (spi->rx_len >= sizeof(u16))
+		stm32_spi_clr_bits(spi, STM32FX_SPI_CR2, STM32F7_SPI_CR2_FRXTH);
+	else
+		stm32_spi_set_bits(spi, STM32FX_SPI_CR2, STM32F7_SPI_CR2_FRXTH);
+
+	dev_dbg(spi->dev, "%s: %d bytes left (sr=%08x)\n",
+		__func__, spi->rx_len, sr);
+}
+
 /**
  * stm32h7_spi_read_rxfifo - Read bytes in Receive Data Register
  * @spi: pointer to the spi controller data structure
@@ -1224,6 +1310,22 @@ static void stm32fx_spi_transfer_one_dma_start(struct stm32_spi *spi)
 	stm32_spi_enable(spi);
 }
 
+/**
+ * stm32f7_spi_transfer_one_dma_start - Set SPI driver registers to start
+ *					transfer using DMA
+ * @spi: pointer to the spi controller data structure
+ */
+static void stm32f7_spi_transfer_one_dma_start(struct stm32_spi *spi)
+{
+	/* Configure DMA request trigger threshold according to DMA width */
+	if (spi->cur_bpw <= 8)
+		stm32_spi_set_bits(spi, STM32FX_SPI_CR2, STM32F7_SPI_CR2_FRXTH);
+	else
+		stm32_spi_clr_bits(spi, STM32FX_SPI_CR2, STM32F7_SPI_CR2_FRXTH);
+
+	stm32fx_spi_transfer_one_dma_start(spi);
+}
+
 /**
  * stm32h7_spi_transfer_one_dma_start - Set SPI driver registers to start
  *					transfer using DMA
@@ -1362,6 +1464,31 @@ static void stm32f4_spi_set_bpw(struct stm32_spi *spi)
 		stm32_spi_clr_bits(spi, STM32FX_SPI_CR1, STM32F4_SPI_CR1_DFF);
 }
 
+/**
+ * stm32f7_spi_set_bpw - Configure bits per word
+ * @spi: pointer to the spi controller data structure
+ */
+static void stm32f7_spi_set_bpw(struct stm32_spi *spi)
+{
+	u32 bpw;
+	u32 cr2_clrb = 0, cr2_setb = 0;
+
+	bpw = spi->cur_bpw - 1;
+
+	cr2_clrb |= STM32F7_SPI_CR2_DS;
+	cr2_setb |= FIELD_PREP(STM32F7_SPI_CR2_DS, bpw);
+
+	if (spi->rx_len >= sizeof(u16))
+		cr2_clrb |= STM32F7_SPI_CR2_FRXTH;
+	else
+		cr2_setb |= STM32F7_SPI_CR2_FRXTH;
+
+	writel_relaxed(
+		(readl_relaxed(spi->base + STM32FX_SPI_CR2) &
+		 ~cr2_clrb) | cr2_setb,
+		spi->base + STM32FX_SPI_CR2);
+}
+
 /**
  * stm32h7_spi_set_bpw - configure bits per word
  * @spi: pointer to the spi controller data structure
@@ -1771,6 +1898,27 @@ static const struct stm32_spi_cfg stm32f4_spi_cfg = {
 	.flags = SPI_CONTROLLER_MUST_TX,
 };
 
+static const struct stm32_spi_cfg stm32f7_spi_cfg = {
+	.regs = &stm32fx_spi_regspec,
+	.get_bpw_mask = stm32f7_spi_get_bpw_mask,
+	.disable = stm32fx_spi_disable,
+	.config = stm32fx_spi_config,
+	.set_bpw = stm32f7_spi_set_bpw,
+	.set_mode = stm32fx_spi_set_mode,
+	.write_tx = stm32f7_spi_write_tx,
+	.read_rx = stm32f7_spi_read_rx,
+	.transfer_one_dma_start = stm32f7_spi_transfer_one_dma_start,
+	.dma_tx_cb = stm32fx_spi_dma_tx_cb,
+	.dma_rx_cb = stm32_spi_dma_rx_cb,
+	.transfer_one_irq = stm32fx_spi_transfer_one_irq,
+	.irq_handler_event = stm32fx_spi_irq_event,
+	.irq_handler_thread = stm32fx_spi_irq_thread,
+	.baud_rate_div_min = STM32FX_SPI_BR_DIV_MIN,
+	.baud_rate_div_max = STM32FX_SPI_BR_DIV_MAX,
+	.has_fifo = false,
+	.flags = SPI_CONTROLLER_MUST_TX,
+};
+
 static const struct stm32_spi_cfg stm32h7_spi_cfg = {
 	.regs = &stm32h7_spi_regspec,
 	.get_fifo_size = stm32h7_spi_get_fifo_size,
@@ -1800,6 +1948,7 @@ static const struct stm32_spi_cfg stm32h7_spi_cfg = {
 static const struct of_device_id stm32_spi_of_match[] = {
 	{ .compatible = "st,stm32h7-spi", .data = (void *)&stm32h7_spi_cfg },
 	{ .compatible = "st,stm32f4-spi", .data = (void *)&stm32f4_spi_cfg },
+	{ .compatible = "st,stm32f7-spi", .data = (void *)&stm32f7_spi_cfg },
 	{},
 };
 MODULE_DEVICE_TABLE(of, stm32_spi_of_match);
-- 
2.42.0

