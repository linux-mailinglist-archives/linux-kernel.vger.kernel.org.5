Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575F57AF6D7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 01:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbjIZXn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 19:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjIZXlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 19:41:55 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A26876B3;
        Tue, 26 Sep 2023 15:57:09 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,178,1694703600"; 
   d="scan'208";a="181059348"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 27 Sep 2023 06:08:35 +0900
Received: from mulinux.home (unknown [10.226.92.200])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id B3D8C40B91B6;
        Wed, 27 Sep 2023 06:08:31 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/2] spi: rzv2m-csi: Add Slave mode support
Date:   Tue, 26 Sep 2023 22:08:18 +0100
Message-Id: <20230926210818.197356-3-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926210818.197356-1-fabrizio.castro.jz@renesas.com>
References: <20230926210818.197356-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CSI IP found inside the Renesas RZ/V2M SoC supports
both SPI Master and SPI Slave roles.

When working in slave mode, the CSI IP has the option
of using its Slave Select (SS) pin to enable TX and RX
operations. Since the SPI slave cannot control the clock,
when working as slave it's best not to stop operations
during a transfer, as by doing so the IP will not send or
receive data, regardless of clock and active level on pin SS.
A side effect from not stopping operations is that the RX
FIFO needs to be flushed, word by word, when RX data needs
to be discarded.

Finally, when in slave mode timings are tighter, as missing a
deadline translates to errors being thrown, resulting in
aborting the transfer. In order to speed things up, we can
avoid waiting for the TX FIFO to be empty, we can just wait
for the RX FIFO to contain at least the number of words that
we expect.

Add slave support to the currently existing CSI driver.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 drivers/spi/Kconfig         |   4 +-
 drivers/spi/spi-rzv2m-csi.c | 137 +++++++++++++++++++++++++-----------
 2 files changed, 97 insertions(+), 44 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 2c21d5b96fdc..2c657df3e304 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -861,8 +861,10 @@ config SPI_RSPI
 config SPI_RZV2M_CSI
 	tristate "Renesas RZ/V2M CSI controller"
 	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on SPI_SLAVE
 	help
-	  SPI driver for Renesas RZ/V2M Clocked Serial Interface (CSI)
+	  SPI driver for Renesas RZ/V2M Clocked Serial Interface (CSI).
+	  CSI supports master and slave roles.
 
 config SPI_QCOM_QSPI
 	tristate "QTI QSPI controller"
diff --git a/drivers/spi/spi-rzv2m-csi.c b/drivers/spi/spi-rzv2m-csi.c
index d0f51b17aa7c..c700a9922402 100644
--- a/drivers/spi/spi-rzv2m-csi.c
+++ b/drivers/spi/spi-rzv2m-csi.c
@@ -11,6 +11,7 @@
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/log2.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/reset.h>
@@ -38,6 +39,9 @@
 #define CSI_MODE_SETUP		0x00000040
 
 /* CSI_CLKSEL */
+#define CSI_CLKSEL_SS_ENA	BIT(19)
+#define CSI_CLKSEL_SS_POL	BIT(18)
+#define CSI_CLKSEL_SS		(CSI_CLKSEL_SS_ENA | CSI_CLKSEL_SS_POL)
 #define CSI_CLKSEL_CKP		BIT(17)
 #define CSI_CLKSEL_DAP		BIT(16)
 #define CSI_CLKSEL_MODE		(CSI_CLKSEL_CKP|CSI_CLKSEL_DAP)
@@ -82,6 +86,15 @@
 
 #define CSI_MAX_SPI_SCKO	(8 * HZ_PER_MHZ)
 
+#define CSI_CLKSEL_SS_DISABLED			0
+#define CSI_CLKSEL_SS_ENABLED_ACTIVE_LOW	BIT(1)
+#define CSI_CLKSEL_SS_ENABLED_ACTIVE_HIGH	GENMASK(1, 0)
+
+enum {
+	RZV2M_CSI_SPI_MASTER,
+	RZV2M_CSI_SPI_SLAVE,
+};
+
 struct rzv2m_csi_priv {
 	void __iomem *base;
 	struct clk *csiclk;
@@ -99,6 +112,9 @@ struct rzv2m_csi_priv {
 	wait_queue_head_t wait;
 	u32 errors;
 	u32 status;
+	int mode;
+	int slave_select;
+	bool slave_aborted;
 };
 
 static void rzv2m_csi_reg_write_bit(const struct rzv2m_csi_priv *csi,
@@ -193,6 +209,14 @@ static int rzv2m_csi_read_rxfifo(struct rzv2m_csi_priv *csi)
 	return 0;
 }
 
+static inline void rzv2m_csi_empty_rxfifo(struct rzv2m_csi_priv *csi)
+{
+	unsigned int i;
+
+	for (i = 0; i < csi->words_to_transfer; i++)
+		readl(csi->base + CSI_IFIFO);
+}
+
 static inline void rzv2m_csi_calc_current_transfer(struct rzv2m_csi_priv *csi)
 {
 	unsigned int bytes_transferred = max(csi->bytes_received, csi->bytes_sent);
@@ -279,32 +303,23 @@ static int rzv2m_csi_wait_for_interrupt(struct rzv2m_csi_priv *csi,
 
 	rzv2m_csi_enable_irqs(csi, enable_bits);
 
-	ret = wait_event_timeout(csi->wait,
-				 ((csi->status & wait_mask) == wait_mask) ||
-				 csi->errors, HZ);
+	if (csi->mode == RZV2M_CSI_SPI_SLAVE) {
+		ret = wait_event_interruptible(csi->wait,
+				((csi->status & wait_mask) == wait_mask) ||
+				csi->errors || csi->slave_aborted);
+		if (ret || csi->slave_aborted)
+			ret = -EINTR;
+	} else {
+		ret = wait_event_timeout(csi->wait,
+				((csi->status & wait_mask) == wait_mask) ||
+				csi->errors, HZ) == 0 ? -ETIMEDOUT : 0;
+	}
 
 	rzv2m_csi_disable_irqs(csi, enable_bits);
 
 	if (csi->errors)
 		return -EIO;
 
-	if (!ret)
-		return -ETIMEDOUT;
-
-	return 0;
-}
-
-static int rzv2m_csi_wait_for_tx_empty(struct rzv2m_csi_priv *csi)
-{
-	int ret;
-
-	if (readl(csi->base + CSI_OFIFOL) == 0)
-		return 0;
-
-	ret = rzv2m_csi_wait_for_interrupt(csi, CSI_INT_TREND, CSI_CNT_TREND_E);
-	if (ret == -ETIMEDOUT)
-		csi->errors |= TX_TIMEOUT_ERROR;
-
 	return ret;
 }
 
@@ -312,7 +327,7 @@ static inline int rzv2m_csi_wait_for_rx_ready(struct rzv2m_csi_priv *csi)
 {
 	int ret;
 
-	if (readl(csi->base + CSI_IFIFOL) == csi->bytes_to_transfer)
+	if (readl(csi->base + CSI_IFIFOL) >= csi->bytes_to_transfer)
 		return 0;
 
 	ret = rzv2m_csi_wait_for_interrupt(csi, CSI_INT_R_TRGR,
@@ -402,8 +417,14 @@ static int rzv2m_csi_setup(struct spi_device *spi)
 	rzv2m_csi_reg_write_bit(csi, CSI_MODE, CSI_MODE_DIR,
 				!!(spi->mode & SPI_LSB_FIRST));
 
-	/* Set the operation mode as master */
-	rzv2m_csi_reg_write_bit(csi, CSI_CLKSEL, CSI_CLKSEL_SLAVE, 0);
+	/* Set the role, 1 for slave and 0 for master */
+	rzv2m_csi_reg_write_bit(csi, CSI_CLKSEL, CSI_CLKSEL_SLAVE,
+				csi->mode == RZV2M_CSI_SPI_SLAVE);
+
+	if (csi->mode == RZV2M_CSI_SPI_SLAVE)
+		/* Configure the slave select pin */
+		rzv2m_csi_reg_write_bit(csi, CSI_CLKSEL, CSI_CLKSEL_SS,
+					csi->slave_select);
 
 	/* Give the IP a SW reset */
 	ret = rzv2m_csi_sw_reset(csi, 1);
@@ -431,9 +452,13 @@ static int rzv2m_csi_pio_transfer(struct rzv2m_csi_priv *csi)
 	/* Make sure the TX FIFO is empty */
 	writel(0, csi->base + CSI_OFIFOL);
 
+	/* Make sure the RX FIFO is empty */
+	writel(0, csi->base + CSI_IFIFOL);
+
 	csi->bytes_sent = 0;
 	csi->bytes_received = 0;
 	csi->errors = 0;
+	csi->slave_aborted = false;
 
 	rzv2m_csi_disable_all_irqs(csi);
 	rzv2m_csi_clear_all_irqs(csi);
@@ -452,28 +477,21 @@ static int rzv2m_csi_pio_transfer(struct rzv2m_csi_priv *csi)
 
 		rzv2m_csi_enable_irqs(csi, CSI_INT_OVERF | CSI_INT_UNDER);
 
-		/* Make sure the RX FIFO is empty */
-		writel(0, csi->base + CSI_IFIFOL);
-
 		writel(readl(csi->base + CSI_INT), csi->base + CSI_INT);
 		csi->status = 0;
 
-		rzv2m_csi_start_stop_operation(csi, 1, false);
-
 		/* TX */
 		if (csi->txbuf) {
 			ret = rzv2m_csi_fill_txfifo(csi);
 			if (ret)
 				break;
 
-			ret = rzv2m_csi_wait_for_tx_empty(csi);
-			if (ret)
-				break;
-
 			if (csi->bytes_sent == csi->buffer_len)
 				tx_completed = true;
 		}
 
+		rzv2m_csi_start_stop_operation(csi, 1, false);
+
 		/*
 		 * Make sure the RX FIFO contains the desired number of words.
 		 * We then either flush its content, or we copy it onto
@@ -483,31 +501,28 @@ static int rzv2m_csi_pio_transfer(struct rzv2m_csi_priv *csi)
 		if (ret)
 			break;
 
-		/* RX */
-		if (csi->rxbuf) {
+		if (csi->mode == RZV2M_CSI_SPI_MASTER)
 			rzv2m_csi_start_stop_operation(csi, 0, false);
 
+		/* RX */
+		if (csi->rxbuf) {
 			ret = rzv2m_csi_read_rxfifo(csi);
 			if (ret)
 				break;
 
 			if (csi->bytes_received == csi->buffer_len)
 				rx_completed = true;
+		} else {
+			rzv2m_csi_empty_rxfifo(csi);
 		}
 
-		ret = rzv2m_csi_start_stop_operation(csi, 0, true);
-		if (ret)
-			goto pio_quit;
-
 		if (csi->errors) {
 			ret = -EIO;
-			goto pio_quit;
+			break;
 		}
 	}
 
 	rzv2m_csi_start_stop_operation(csi, 0, true);
-
-pio_quit:
 	rzv2m_csi_disable_all_irqs(csi);
 	rzv2m_csi_enable_rx_trigger(csi, false);
 	rzv2m_csi_clear_all_irqs(csi);
@@ -529,7 +544,8 @@ static int rzv2m_csi_transfer_one(struct spi_controller *controller,
 
 	rzv2m_csi_setup_operating_mode(csi, transfer);
 
-	rzv2m_csi_setup_clock(csi, transfer->speed_hz);
+	if (csi->mode == RZV2M_CSI_SPI_MASTER)
+		rzv2m_csi_setup_clock(csi, transfer->speed_hz);
 
 	ret = rzv2m_csi_pio_transfer(csi);
 	if (ret) {
@@ -546,24 +562,58 @@ static int rzv2m_csi_transfer_one(struct spi_controller *controller,
 	return ret;
 }
 
+static int rzv2m_csi_slave_abort(struct spi_controller *ctlr)
+{
+	struct rzv2m_csi_priv *csi = spi_controller_get_devdata(ctlr);
+
+	csi->slave_aborted = true;
+	wake_up(&csi->wait);
+
+	return 0;
+}
+
 static int rzv2m_csi_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	struct spi_controller *controller;
 	struct device *dev = &pdev->dev;
 	struct rzv2m_csi_priv *csi;
 	struct reset_control *rstc;
+	int mode;
 	int irq;
 	int ret;
 
-	controller = devm_spi_alloc_host(dev, sizeof(*csi));
+	mode = of_property_read_bool(np, "spi-slave") ? RZV2M_CSI_SPI_SLAVE :
+							RZV2M_CSI_SPI_MASTER;
+
+	if (mode == RZV2M_CSI_SPI_MASTER)
+		controller = devm_spi_alloc_host(dev, sizeof(*csi));
+	else
+		controller = devm_spi_alloc_target(dev, sizeof(*csi));
+
 	if (!controller)
 		return -ENOMEM;
 
 	csi = spi_controller_get_devdata(controller);
 	platform_set_drvdata(pdev, csi);
 
+	if (mode == RZV2M_CSI_SPI_SLAVE) {
+		if (of_property_read_bool(np, "renesas,csi-ss")) {
+			if (of_property_read_bool(np, "renesas,csi-ss-high"))
+				csi->slave_select =
+					CSI_CLKSEL_SS_ENABLED_ACTIVE_HIGH;
+			else
+				csi->slave_select =
+					CSI_CLKSEL_SS_ENABLED_ACTIVE_LOW;
+		} else {
+			csi->slave_select = CSI_CLKSEL_SS_DISABLED;
+		}
+	}
+
 	csi->dev = dev;
 	csi->controller = controller;
+	csi->mode = mode;
+	csi->slave_aborted = false;
 
 	csi->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(csi->base))
@@ -594,6 +644,7 @@ static int rzv2m_csi_probe(struct platform_device *pdev)
 	controller->setup = rzv2m_csi_setup;
 	controller->transfer_one = rzv2m_csi_transfer_one;
 	controller->use_gpio_descriptors = true;
+	controller->slave_abort = rzv2m_csi_slave_abort;
 
 	device_set_node(&controller->dev, dev_fwnode(dev));
 
-- 
2.34.1

