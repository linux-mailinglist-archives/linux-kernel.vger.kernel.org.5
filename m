Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AF07DFB0C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377398AbjKBTiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377311AbjKBTiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:38:03 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41F418E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 12:38:00 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-66d0c777bf0so8212936d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 12:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1698953880; x=1699558680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCGqKJF6SsDfNrHHzhtnH0GPRPMyo2Rte78iygg6g5o=;
        b=SyQSTv1cpqUZxlzsFKaAKcrDnscDpuZQY1PNfllvM1VDZaY1okXF2H2wggWlQ8jc6m
         wm7kVdtCgW6/rJKe9LSy2hwCpePcRf7Wtq4h7WtU4sei6PcgvEBtGZvNFHQfZPGd6TEM
         mxEdswX0CMvtAoK+VNNU1dyw8KkoifWft/d/WKWRrTGVfNeWNS9PQBFj02qDbxvT8WlK
         RplLoQog6OIGqDq26A1uQ/jvLoO8FhvKeGeDzPIhfnRuDwXi60W+kMFtNSadxHoy59Nm
         IeiWWvlSFf92/qiRodCrU0Hm8Pf0CqfJq9FA3JShki92BjIYw6ajcbp7BsjDb6LsPbP3
         fIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698953880; x=1699558680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCGqKJF6SsDfNrHHzhtnH0GPRPMyo2Rte78iygg6g5o=;
        b=jDkz8EiRlqd2+3OHhFk8DkpYsP1/LkoVQMey/5CTmea4elSQBebja2Tmqq+iNS8Kt1
         fYWxFrJUcGw5nQ7/ZqYiKLF7j5AYUKWL+MirolutLejUNZcNYO6rWYGIvwcMofJ/yZHh
         AzPvOLjwkbsdlMDNaPBlKSFPeupX4a3fBLbJgfyEwBfeuAVD9I2tRCUviskD8o+HTnaJ
         N8fro5jLZZOUHlFKKTpgdU5zKk105fGzxcbL+/r2ICaPJ6YBW7Du788uxxAX/fWhEn1P
         sa+/wMy89R97/8G64pAY066OSrkhmHn6pFFlH02AGGhPUjkmvvMcpg5DzMfNLRSf7OAW
         Zmfw==
X-Gm-Message-State: AOJu0YwHzqBfZHcEajcQ61uWNxTg1gHs1YtZ4x6w5ZkDXbuM1LVNgA8t
        HWu+sB3/LmUnaQf5Urj9W8Ts+A==
X-Google-Smtp-Source: AGHT+IEtm34TPaGi4W7uKrej4zTnLABaepScjmhEkv/rbDHqn1aFt5BdoRmSlKa4eiA5zKkmAT22Qw==
X-Received: by 2002:a05:6214:76e:b0:66d:3716:4e11 with SMTP id f14-20020a056214076e00b0066d37164e11mr26916465qvz.38.1698953879859;
        Thu, 02 Nov 2023 12:37:59 -0700 (PDT)
Received: from localhost.localdomain ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id a10-20020a0ce90a000000b0065b260eafd9sm30654qvo.87.2023.11.02.12.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 12:37:59 -0700 (PDT)
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
Subject: [PATCH v2 2/5] spi: stm32: use callbacks for read_rx and write_tx
Date:   Thu,  2 Nov 2023 15:37:19 -0400
Message-ID: <20231102193722.3042245-3-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231102193722.3042245-1-ben.wolsieffer@hefring.com>
References: <20231102193722.3042245-1-ben.wolsieffer@hefring.com>
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

The STM32F7 will require different read and write routines, so make
these functions into configurable callbacks.

Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
 drivers/spi/spi-stm32.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 02d1409d7229..427788d18532 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -229,6 +229,8 @@ struct stm32_spi;
  * time between frames (if driver has this functionality)
  * @set_number_of_data: optional routine to configure registers to desired
  * number of data (if driver has this functionality)
+ * @write_tx: routine to write to transmit register/FIFO
+ * @read_rx: routine to read from receive register/FIFO
  * @transfer_one_dma_start: routine to start transfer a single spi_transfer
  * using DMA
  * @dma_rx_cb: routine to call after DMA RX channel operation is complete
@@ -252,6 +254,8 @@ struct stm32_spi_cfg {
 	int (*set_mode)(struct stm32_spi *spi, unsigned int comm_type);
 	void (*set_data_idleness)(struct stm32_spi *spi, u32 length);
 	int (*set_number_of_data)(struct stm32_spi *spi, u32 length);
+	void (*write_tx)(struct stm32_spi *spi);
+	void (*read_rx)(struct stm32_spi *spi);
 	void (*transfer_one_dma_start)(struct stm32_spi *spi);
 	void (*dma_rx_cb)(void *data);
 	void (*dma_tx_cb)(void *data);
@@ -822,17 +826,17 @@ static irqreturn_t stm32fx_spi_irq_event(int irq, void *dev_id)
 
 	if (sr & STM32FX_SPI_SR_TXE) {
 		if (spi->tx_buf)
-			stm32f4_spi_write_tx(spi);
+			spi->cfg->write_tx(spi);
 		if (spi->tx_len == 0)
 			end = true;
 	}
 
 	if (sr & STM32FX_SPI_SR_RXNE) {
-		stm32f4_spi_read_rx(spi);
+		spi->cfg->read_rx(spi);
 		if (spi->rx_len == 0)
 			end = true;
 		else if (spi->tx_buf)/* Load data for discontinuous mode */
-			stm32f4_spi_write_tx(spi);
+			spi->cfg->write_tx(spi);
 	}
 
 end_irq:
@@ -1149,7 +1153,7 @@ static int stm32fx_spi_transfer_one_irq(struct stm32_spi *spi)
 
 	/* starting data transfer when buffer is loaded */
 	if (spi->tx_buf)
-		stm32f4_spi_write_tx(spi);
+		spi->cfg->write_tx(spi);
 
 	spin_unlock_irqrestore(&spi->lock, flags);
 
@@ -1752,6 +1756,8 @@ static const struct stm32_spi_cfg stm32f4_spi_cfg = {
 	.config = stm32fx_spi_config,
 	.set_bpw = stm32f4_spi_set_bpw,
 	.set_mode = stm32fx_spi_set_mode,
+	.write_tx = stm32f4_spi_write_tx,
+	.read_rx = stm32f4_spi_read_rx,
 	.transfer_one_dma_start = stm32fx_spi_transfer_one_dma_start,
 	.dma_tx_cb = stm32fx_spi_dma_tx_cb,
 	.dma_rx_cb = stm32_spi_dma_rx_cb,
@@ -1775,6 +1781,8 @@ static const struct stm32_spi_cfg stm32h7_spi_cfg = {
 	.set_mode = stm32h7_spi_set_mode,
 	.set_data_idleness = stm32h7_spi_data_idleness,
 	.set_number_of_data = stm32h7_spi_number_of_data,
+	.write_tx = stm32h7_spi_write_txfifo,
+	.read_rx = stm32h7_spi_read_rxfifo,
 	.transfer_one_dma_start = stm32h7_spi_transfer_one_dma_start,
 	.dma_rx_cb = stm32_spi_dma_rx_cb,
 	/*
-- 
2.42.0

