Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683DE7B09FB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjI0QZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjI0QZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:25:28 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2AEE7EB;
        Wed, 27 Sep 2023 09:25:25 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,181,1694703600"; 
   d="scan'208";a="177447629"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 28 Sep 2023 01:25:24 +0900
Received: from mulinux.home (unknown [10.226.92.108])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id ACBD9401F564;
        Thu, 28 Sep 2023 01:25:20 +0900 (JST)
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
Subject: [PATCH v2 2/2] spi: rzv2m-csi: Add target mode support
Date:   Wed, 27 Sep 2023 17:25:08 +0100
Message-Id: <20230927162508.328736-3-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927162508.328736-1-fabrizio.castro.jz@renesas.com>
References: <20230927162508.328736-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CSI IP found inside the Renesas RZ/V2M SoC supports
both SPI host and SPI target roles.

When working in target mode, the CSI IP has the option
of using its Slave Selection (SS) pin to enable TX and RX
operations. Since the SPI target cannot control the clock,
when working as target it's best not to stop operations
during a transfer, as by doing so the IP will not send or
receive data, regardless of clock and active level on pin SS.
A side effect from not stopping operations is that the RX
FIFO needs to be flushed, word by word, when RX data needs
to be discarded.

Finally, when in target mode timings are tighter, as missing a
deadline translates to errors being thrown, resulting in
aborting the transfer. In order to speed things up, we can
avoid waiting for the TX FIFO to be empty, we can just wait
for the RX FIFO to contain at least the number of words that
we expect.

Add target support to the currently existing CSI driver.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
v1->v2: I have dropped properties renesas,csi-ss and
        renesas,csi-ss-high. The driver now uses property
	renesas,csi-no-ss to disable the SS pin.
	The driver now looks for SPI_CS_HIGH within the SPI
	mode field to configure the SS pin as active high.
	I have dropped "depends on SPI_SLAVE" from Kconfig.
	The current role doesn't get stored within the private
	data structure anymore, I am using spi_controller_is_target
	instead to check the role.
	I have also purged "master" and "slave" as naming
	schemes, I am now using "host" and "target" (in the code
	and also in the changelog) and related APIs instead.

 drivers/spi/Kconfig         |   3 +-
 drivers/spi/spi-rzv2m-csi.c | 127 +++++++++++++++++++++++-------------
 2 files changed, 85 insertions(+), 45 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 2c21d5b96fdc..d4ac184bce95 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -862,7 +862,8 @@ config SPI_RZV2M_CSI
 	tristate "Renesas RZ/V2M CSI controller"
 	depends on ARCH_RENESAS || COMPILE_TEST
 	help
-	  SPI driver for Renesas RZ/V2M Clocked Serial Interface (CSI)
+	  SPI driver for Renesas RZ/V2M Clocked Serial Interface (CSI).
+	  CSI supports both SPI host and SPI target roles.
 
 config SPI_QCOM_QSPI
 	tristate "QTI QSPI controller"
diff --git a/drivers/spi/spi-rzv2m-csi.c b/drivers/spi/spi-rzv2m-csi.c
index d0f51b17aa7c..741e0f44c49c 100644
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
@@ -82,6 +86,10 @@
 
 #define CSI_MAX_SPI_SCKO	(8 * HZ_PER_MHZ)
 
+#define CSI_CLKSEL_SS_DISABLED			0
+#define CSI_CLKSEL_SS_ENABLED_ACTIVE_LOW	BIT(1)
+#define CSI_CLKSEL_SS_ENABLED_ACTIVE_HIGH	GENMASK(1, 0)
+
 struct rzv2m_csi_priv {
 	void __iomem *base;
 	struct clk *csiclk;
@@ -99,6 +107,8 @@ struct rzv2m_csi_priv {
 	wait_queue_head_t wait;
 	u32 errors;
 	u32 status;
+	bool target_aborted;
+	bool use_ss_pin;
 };
 
 static void rzv2m_csi_reg_write_bit(const struct rzv2m_csi_priv *csi,
@@ -193,6 +203,14 @@ static int rzv2m_csi_read_rxfifo(struct rzv2m_csi_priv *csi)
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
@@ -279,32 +297,23 @@ static int rzv2m_csi_wait_for_interrupt(struct rzv2m_csi_priv *csi,
 
 	rzv2m_csi_enable_irqs(csi, enable_bits);
 
-	ret = wait_event_timeout(csi->wait,
-				 ((csi->status & wait_mask) == wait_mask) ||
-				 csi->errors, HZ);
+	if (spi_controller_is_target(csi->controller)) {
+		ret = wait_event_interruptible(csi->wait,
+				((csi->status & wait_mask) == wait_mask) ||
+				csi->errors || csi->target_aborted);
+		if (ret || csi->target_aborted)
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
 
@@ -312,7 +321,7 @@ static inline int rzv2m_csi_wait_for_rx_ready(struct rzv2m_csi_priv *csi)
 {
 	int ret;
 
-	if (readl(csi->base + CSI_IFIFOL) == csi->bytes_to_transfer)
+	if (readl(csi->base + CSI_IFIFOL) >= csi->bytes_to_transfer)
 		return 0;
 
 	ret = rzv2m_csi_wait_for_interrupt(csi, CSI_INT_R_TRGR,
@@ -388,6 +397,7 @@ static void rzv2m_csi_setup_operating_mode(struct rzv2m_csi_priv *csi,
 static int rzv2m_csi_setup(struct spi_device *spi)
 {
 	struct rzv2m_csi_priv *csi = spi_controller_get_devdata(spi->controller);
+	u32 slave_selection = CSI_CLKSEL_SS_DISABLED;
 	int ret;
 
 	rzv2m_csi_sw_reset(csi, 0);
@@ -402,8 +412,17 @@ static int rzv2m_csi_setup(struct spi_device *spi)
 	rzv2m_csi_reg_write_bit(csi, CSI_MODE, CSI_MODE_DIR,
 				!!(spi->mode & SPI_LSB_FIRST));
 
-	/* Set the operation mode as master */
-	rzv2m_csi_reg_write_bit(csi, CSI_CLKSEL, CSI_CLKSEL_SLAVE, 0);
+	/* Set the role, 1 for target and 0 for host */
+	rzv2m_csi_reg_write_bit(csi, CSI_CLKSEL, CSI_CLKSEL_SLAVE,
+				!!spi_controller_is_target(csi->controller));
+
+	if (csi->use_ss_pin)
+		slave_selection = spi->mode & SPI_CS_HIGH ?
+			CSI_CLKSEL_SS_ENABLED_ACTIVE_HIGH :
+			CSI_CLKSEL_SS_ENABLED_ACTIVE_LOW;
+
+	/* Configure the slave selection (SS) pin */
+	rzv2m_csi_reg_write_bit(csi, CSI_CLKSEL, CSI_CLKSEL_SS, slave_selection);
 
 	/* Give the IP a SW reset */
 	ret = rzv2m_csi_sw_reset(csi, 1);
@@ -431,9 +450,13 @@ static int rzv2m_csi_pio_transfer(struct rzv2m_csi_priv *csi)
 	/* Make sure the TX FIFO is empty */
 	writel(0, csi->base + CSI_OFIFOL);
 
+	/* Make sure the RX FIFO is empty */
+	writel(0, csi->base + CSI_IFIFOL);
+
 	csi->bytes_sent = 0;
 	csi->bytes_received = 0;
 	csi->errors = 0;
+	csi->target_aborted = false;
 
 	rzv2m_csi_disable_all_irqs(csi);
 	rzv2m_csi_clear_all_irqs(csi);
@@ -452,28 +475,21 @@ static int rzv2m_csi_pio_transfer(struct rzv2m_csi_priv *csi)
 
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
@@ -483,31 +499,28 @@ static int rzv2m_csi_pio_transfer(struct rzv2m_csi_priv *csi)
 		if (ret)
 			break;
 
-		/* RX */
-		if (csi->rxbuf) {
+		if (!spi_controller_is_target(csi->controller))
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
@@ -529,7 +542,8 @@ static int rzv2m_csi_transfer_one(struct spi_controller *controller,
 
 	rzv2m_csi_setup_operating_mode(csi, transfer);
 
-	rzv2m_csi_setup_clock(csi, transfer->speed_hz);
+	if (!spi_controller_is_target(csi->controller))
+		rzv2m_csi_setup_clock(csi, transfer->speed_hz);
 
 	ret = rzv2m_csi_pio_transfer(csi);
 	if (ret) {
@@ -546,24 +560,48 @@ static int rzv2m_csi_transfer_one(struct spi_controller *controller,
 	return ret;
 }
 
+static int rzv2m_csi_target_abort(struct spi_controller *ctlr)
+{
+	struct rzv2m_csi_priv *csi = spi_controller_get_devdata(ctlr);
+
+	csi->target_aborted = true;
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
+	bool target_mode;
 	int irq;
 	int ret;
 
-	controller = devm_spi_alloc_host(dev, sizeof(*csi));
+	target_mode = of_property_read_bool(np, "spi-slave");
+
+	if (target_mode)
+		controller = devm_spi_alloc_target(dev, sizeof(*csi));
+	else
+		controller = devm_spi_alloc_host(dev, sizeof(*csi));
+
 	if (!controller)
 		return -ENOMEM;
 
 	csi = spi_controller_get_devdata(controller);
 	platform_set_drvdata(pdev, csi);
 
+	csi->use_ss_pin = false;
+	if (spi_controller_is_target(controller) &&
+	    !of_property_read_bool(np, "renesas,csi-no-ss"))
+		csi->use_ss_pin = true;
+
 	csi->dev = dev;
 	csi->controller = controller;
+	csi->target_aborted = false;
 
 	csi->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(csi->base))
@@ -589,11 +627,12 @@ static int rzv2m_csi_probe(struct platform_device *pdev)
 
 	init_waitqueue_head(&csi->wait);
 
-	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
+	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST | SPI_CS_HIGH;
 	controller->bits_per_word_mask = SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
 	controller->setup = rzv2m_csi_setup;
 	controller->transfer_one = rzv2m_csi_transfer_one;
 	controller->use_gpio_descriptors = true;
+	controller->target_abort = rzv2m_csi_target_abort;
 
 	device_set_node(&controller->dev, dev_fwnode(dev));
 
-- 
2.34.1

