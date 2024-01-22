Return-Path: <linux-kernel+bounces-33924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0530837048
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2745A28AEDE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10A260EC9;
	Mon, 22 Jan 2024 18:08:31 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81818604DD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946909; cv=none; b=O/2uTCPwLOpGf/xbyXZEs0kmCKCjXfytMX3OV8BX5L1OormD6fP6U0WBWl+yVK/U8LYa5UGlVjsWUE6ffQppoUG/rT8OWYL0P93NXJ25KdKeSwhwSOwtotSIH6R8NsVHTU9wSpFsUwgkaNxICjjHVBcvq2AEACNz4Q7BYDLYyZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946909; c=relaxed/simple;
	bh=SdZTU4cjBqn9scLdVAgPZ8Ip7EBDBVJ1+tLNcihMbP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q7JFC59h3zBOKe+wj2sOU7SsZym8xE6thJOUXv/eXwr6dGTDc+oUQ5EU7fhG6M0n76Her2vSJvOb20wZ2IWVsUqKJgHFH+9RDS1IPDYak9eiq8l0qmZCh4LaLKyB+guqFwMa5FNYA3DimZmkht4aknWDn/DanBh7hHPvVlvjyHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiW-0001sh-R2; Mon, 22 Jan 2024 19:08:16 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiW-001eQF-7k; Mon, 22 Jan 2024 19:08:16 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiW-005Zxp-0W;
	Mon, 22 Jan 2024 19:08:16 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Michal Simek <michal.simek@amd.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 17/33] spi: bitbang: Follow renaming of SPI "master" to "controller"
Date: Mon, 22 Jan 2024 19:07:12 +0100
Message-ID:  <b2035a8030b77e8a3eea87adf7e4a191c0a18717.1705944943.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
References: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=17893; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=SdZTU4cjBqn9scLdVAgPZ8Ip7EBDBVJ1+tLNcihMbP8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlrq7W35YxnBGNUkgfp9sxp8TauqA0FqGjsoNII 2JDhmvilzSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZa6u1gAKCRCPgPtYfRL+ ThbFB/9W0wGaQyeB2R9TDqr4nJD7OCpgaf6AP3X7v2WmBbVc8al2BWaN0LgThsmXboxN/3Jts0s FHEF5wgQlY3tQEgHJMGni4ZTaj1bEJlSUaYDra66lQawLfOC7EZOl0NfQUC1N/ejVhqnUt3ROul TwhlQ1zQiG62zJ/JCPsW5YWA1vAUkPKtw+ao+NtRweguL6Su6AgvJ6fd4uiqcyV3tgfe+g8n+bu XSj617MW4NNZp+ZBn9am/UMxSjyNWUSaQD39obX3Sf0/dIxtKquhEr9W+pTr3pQHIuJHJEJCB62 hDFs8iUXfYiaxN3jnOzgsfJDjjJ0HfF/0/ZHJSCOEfLlqMo2
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
some functions and struct members were renamed. To not break all drivers
compatibility macros were provided.

To be able to remove these compatibility macros push the renaming into
the SPI bitbang controller drivers.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-ath79.c         |  4 +--
 drivers/spi/spi-bitbang.c       | 64 ++++++++++++++++-----------------
 drivers/spi/spi-butterfly.c     |  6 ++--
 drivers/spi/spi-davinci.c       |  6 ++--
 drivers/spi/spi-gpio.c          |  2 +-
 drivers/spi/spi-lm70llp.c       |  6 ++--
 drivers/spi/spi-oc-tiny.c       |  6 ++--
 drivers/spi/spi-omap-uwire.c    |  4 +--
 drivers/spi/spi-sh-sci.c        | 10 +++---
 drivers/spi/spi-xilinx.c        |  4 +--
 drivers/spi/spi-xtensa-xtfpga.c |  2 +-
 include/linux/spi/spi_bitbang.h |  2 +-
 12 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index b7ada981464a..d78762d4db98 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -189,7 +189,7 @@ static int ath79_spi_probe(struct platform_device *pdev)
 	host->num_chipselect = 3;
 	host->mem_ops = &ath79_mem_ops;
 
-	sp->bitbang.master = host;
+	sp->bitbang.ctlr = host;
 	sp->bitbang.chipselect = ath79_spi_chipselect;
 	sp->bitbang.txrx_word[SPI_MODE_0] = ath79_spi_txrx_mode0;
 	sp->bitbang.flags = SPI_CS_HIGH;
@@ -237,7 +237,7 @@ static void ath79_spi_remove(struct platform_device *pdev)
 
 	spi_bitbang_stop(&sp->bitbang);
 	ath79_spi_disable(sp);
-	spi_controller_put(sp->bitbang.master);
+	spi_controller_put(sp->bitbang.ctlr);
 }
 
 static void ath79_spi_shutdown(struct platform_device *pdev)
diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index ecd44016c197..a0e2204fc039 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -187,7 +187,7 @@ int spi_bitbang_setup(struct spi_device *spi)
 	bool			initial_setup = false;
 	int			retval;
 
-	bitbang = spi_master_get_devdata(spi->master);
+	bitbang = spi_controller_get_devdata(spi->controller);
 
 	if (!cs) {
 		cs = kzalloc(sizeof(*cs), GFP_KERNEL);
@@ -236,7 +236,7 @@ static int spi_bitbang_bufs(struct spi_device *spi, struct spi_transfer *t)
 	unsigned		nsecs = cs->nsecs;
 	struct spi_bitbang	*bitbang;
 
-	bitbang = spi_master_get_devdata(spi->master);
+	bitbang = spi_controller_get_devdata(spi->controller);
 	if (bitbang->set_line_direction) {
 		int err;
 
@@ -268,11 +268,11 @@ static int spi_bitbang_bufs(struct spi_device *spi, struct spi_transfer *t)
  * transfer-at-a-time ones to leverage dma or fifo hardware.
  */
 
-static int spi_bitbang_prepare_hardware(struct spi_master *spi)
+static int spi_bitbang_prepare_hardware(struct spi_controller *spi)
 {
 	struct spi_bitbang	*bitbang;
 
-	bitbang = spi_master_get_devdata(spi);
+	bitbang = spi_controller_get_devdata(spi);
 
 	mutex_lock(&bitbang->lock);
 	bitbang->busy = 1;
@@ -281,11 +281,11 @@ static int spi_bitbang_prepare_hardware(struct spi_master *spi)
 	return 0;
 }
 
-static int spi_bitbang_transfer_one(struct spi_master *master,
+static int spi_bitbang_transfer_one(struct spi_controller *ctlr,
 				    struct spi_device *spi,
 				    struct spi_transfer *transfer)
 {
-	struct spi_bitbang *bitbang = spi_master_get_devdata(master);
+	struct spi_bitbang *bitbang = spi_controller_get_devdata(ctlr);
 	int status = 0;
 
 	if (bitbang->setup_transfer) {
@@ -303,16 +303,16 @@ static int spi_bitbang_transfer_one(struct spi_master *master,
 		status = -EREMOTEIO;
 
 out:
-	spi_finalize_current_transfer(master);
+	spi_finalize_current_transfer(ctlr);
 
 	return status;
 }
 
-static int spi_bitbang_unprepare_hardware(struct spi_master *spi)
+static int spi_bitbang_unprepare_hardware(struct spi_controller *spi)
 {
 	struct spi_bitbang	*bitbang;
 
-	bitbang = spi_master_get_devdata(spi);
+	bitbang = spi_controller_get_devdata(spi);
 
 	mutex_lock(&bitbang->lock);
 	bitbang->busy = 0;
@@ -323,7 +323,7 @@ static int spi_bitbang_unprepare_hardware(struct spi_master *spi)
 
 static void spi_bitbang_set_cs(struct spi_device *spi, bool enable)
 {
-	struct spi_bitbang *bitbang = spi_master_get_devdata(spi->master);
+	struct spi_bitbang *bitbang = spi_controller_get_devdata(spi->controller);
 
 	/* SPI core provides CS high / low, but bitbang driver
 	 * expects CS active
@@ -341,10 +341,10 @@ static void spi_bitbang_set_cs(struct spi_device *spi, bool enable)
 
 int spi_bitbang_init(struct spi_bitbang *bitbang)
 {
-	struct spi_master *master = bitbang->master;
+	struct spi_controller *ctlr = bitbang->ctlr;
 	bool custom_cs;
 
-	if (!master)
+	if (!ctlr)
 		return -EINVAL;
 	/*
 	 * We only need the chipselect callback if we are actually using it.
@@ -352,39 +352,39 @@ int spi_bitbang_init(struct spi_bitbang *bitbang)
 	 * SPI_CONTROLLER_GPIO_SS flag is set, we always need to call the
 	 * driver-specific chipselect routine.
 	 */
-	custom_cs = (!master->use_gpio_descriptors ||
-		     (master->flags & SPI_CONTROLLER_GPIO_SS));
+	custom_cs = (!ctlr->use_gpio_descriptors ||
+		     (ctlr->flags & SPI_CONTROLLER_GPIO_SS));
 
 	if (custom_cs && !bitbang->chipselect)
 		return -EINVAL;
 
 	mutex_init(&bitbang->lock);
 
-	if (!master->mode_bits)
-		master->mode_bits = SPI_CPOL | SPI_CPHA | bitbang->flags;
+	if (!ctlr->mode_bits)
+		ctlr->mode_bits = SPI_CPOL | SPI_CPHA | bitbang->flags;
 
-	if (master->transfer || master->transfer_one_message)
+	if (ctlr->transfer || ctlr->transfer_one_message)
 		return -EINVAL;
 
-	master->prepare_transfer_hardware = spi_bitbang_prepare_hardware;
-	master->unprepare_transfer_hardware = spi_bitbang_unprepare_hardware;
-	master->transfer_one = spi_bitbang_transfer_one;
+	ctlr->prepare_transfer_hardware = spi_bitbang_prepare_hardware;
+	ctlr->unprepare_transfer_hardware = spi_bitbang_unprepare_hardware;
+	ctlr->transfer_one = spi_bitbang_transfer_one;
 	/*
 	 * When using GPIO descriptors, the ->set_cs() callback doesn't even
 	 * get called unless SPI_CONTROLLER_GPIO_SS is set.
 	 */
 	if (custom_cs)
-		master->set_cs = spi_bitbang_set_cs;
+		ctlr->set_cs = spi_bitbang_set_cs;
 
 	if (!bitbang->txrx_bufs) {
 		bitbang->use_dma = 0;
 		bitbang->txrx_bufs = spi_bitbang_bufs;
-		if (!master->setup) {
+		if (!ctlr->setup) {
 			if (!bitbang->setup_transfer)
 				bitbang->setup_transfer =
 					 spi_bitbang_setup_transfer;
-			master->setup = spi_bitbang_setup;
-			master->cleanup = spi_bitbang_cleanup;
+			ctlr->setup = spi_bitbang_setup;
+			ctlr->cleanup = spi_bitbang_cleanup;
 		}
 	}
 
@@ -411,18 +411,18 @@ EXPORT_SYMBOL_GPL(spi_bitbang_init);
  * master methods.  Those methods are the defaults if the bitbang->txrx_bufs
  * routine isn't initialized.
  *
- * This routine registers the spi_master, which will process requests in a
+ * This routine registers the spi_controller, which will process requests in a
  * dedicated task, keeping IRQs unblocked most of the time.  To stop
  * processing those requests, call spi_bitbang_stop().
  *
- * On success, this routine will take a reference to master. The caller is
- * responsible for calling spi_bitbang_stop() to decrement the reference and
- * spi_master_put() as counterpart of spi_alloc_master() to prevent a memory
+ * On success, this routine will take a reference to the controller. The caller
+ * is responsible for calling spi_bitbang_stop() to decrement the reference and
+ * spi_controller_put() as counterpart of spi_alloc_master() to prevent a memory
  * leak.
  */
 int spi_bitbang_start(struct spi_bitbang *bitbang)
 {
-	struct spi_master *master = bitbang->master;
+	struct spi_controller *ctlr = bitbang->ctlr;
 	int ret;
 
 	ret = spi_bitbang_init(bitbang);
@@ -432,9 +432,9 @@ int spi_bitbang_start(struct spi_bitbang *bitbang)
 	/* driver may get busy before register() returns, especially
 	 * if someone registered boardinfo for devices
 	 */
-	ret = spi_register_master(spi_master_get(master));
+	ret = spi_register_controller(spi_controller_get(ctlr));
 	if (ret)
-		spi_master_put(master);
+		spi_controller_put(ctlr);
 
 	return ret;
 }
@@ -445,7 +445,7 @@ EXPORT_SYMBOL_GPL(spi_bitbang_start);
  */
 void spi_bitbang_stop(struct spi_bitbang *bitbang)
 {
-	spi_unregister_master(bitbang->master);
+	spi_unregister_controller(bitbang->ctlr);
 }
 EXPORT_SYMBOL_GPL(spi_bitbang_stop);
 
diff --git a/drivers/spi/spi-butterfly.c b/drivers/spi/spi-butterfly.c
index 289b4454242a..1d267e6c22a4 100644
--- a/drivers/spi/spi-butterfly.c
+++ b/drivers/spi/spi-butterfly.c
@@ -205,7 +205,7 @@ static void butterfly_attach(struct parport *p)
 	host->bus_num = 42;
 	host->num_chipselect = 2;
 
-	pp->bitbang.master = host;
+	pp->bitbang.ctlr = host;
 	pp->bitbang.chipselect = butterfly_chipselect;
 	pp->bitbang.txrx_word[SPI_MODE_0] = butterfly_txrx_word_mode0;
 
@@ -263,7 +263,7 @@ static void butterfly_attach(struct parport *p)
 	pp->info[0].platform_data = &flash;
 	pp->info[0].chip_select = 1;
 	pp->info[0].controller_data = pp;
-	pp->dataflash = spi_new_device(pp->bitbang.master, &pp->info[0]);
+	pp->dataflash = spi_new_device(pp->bitbang.ctlr, &pp->info[0]);
 	if (pp->dataflash)
 		pr_debug("%s: dataflash at %s\n", p->name,
 			 dev_name(&pp->dataflash->dev));
@@ -308,7 +308,7 @@ static void butterfly_detach(struct parport *p)
 	parport_release(pp->pd);
 	parport_unregister_device(pp->pd);
 
-	spi_controller_put(pp->bitbang.master);
+	spi_controller_put(pp->bitbang.ctlr);
 }
 
 static struct parport_driver butterfly_driver = {
diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 5688be245c68..be3998104bfb 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -459,7 +459,7 @@ static bool davinci_spi_can_dma(struct spi_controller *host,
 
 static int davinci_spi_check_error(struct davinci_spi *dspi, int int_status)
 {
-	struct device *sdev = dspi->bitbang.master->dev.parent;
+	struct device *sdev = dspi->bitbang.ctlr->dev.parent;
 
 	if (int_status & SPIFLG_TIMEOUT_MASK) {
 		dev_err(sdev, "SPI Time-out Error\n");
@@ -742,7 +742,7 @@ static irqreturn_t davinci_spi_irq(s32 irq, void *data)
 
 static int davinci_spi_request_dma(struct davinci_spi *dspi)
 {
-	struct device *sdev = dspi->bitbang.master->dev.parent;
+	struct device *sdev = dspi->bitbang.ctlr->dev.parent;
 
 	dspi->dma_rx = dma_request_chan(sdev, "rx");
 	if (IS_ERR(dspi->dma_rx))
@@ -913,7 +913,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_host;
 
-	dspi->bitbang.master = host;
+	dspi->bitbang.ctlr = host;
 
 	dspi->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(dspi->clk)) {
diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index d8db4564b406..909cce109bba 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -427,7 +427,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	host->cleanup = spi_gpio_cleanup;
 
 	bb = &spi_gpio->bitbang;
-	bb->master = host;
+	bb->ctlr = host;
 	/*
 	 * There is some additional business, apart from driving the CS GPIO
 	 * line, that we need to do on selection. This makes the local
diff --git a/drivers/spi/spi-lm70llp.c b/drivers/spi/spi-lm70llp.c
index e6a65b5c8c31..f982bdebd028 100644
--- a/drivers/spi/spi-lm70llp.c
+++ b/drivers/spi/spi-lm70llp.c
@@ -212,7 +212,7 @@ static void spi_lm70llp_attach(struct parport *p)
 	/*
 	 * SPI and bitbang hookup.
 	 */
-	pp->bitbang.master = host;
+	pp->bitbang.ctlr = host;
 	pp->bitbang.chipselect = lm70_chipselect;
 	pp->bitbang.txrx_word[SPI_MODE_0] = lm70_txrx;
 	pp->bitbang.flags = SPI_3WIRE;
@@ -264,7 +264,7 @@ static void spi_lm70llp_attach(struct parport *p)
 	 * the board info's (void *)controller_data.
 	 */
 	pp->info.controller_data = pp;
-	pp->spidev_lm70 = spi_new_device(pp->bitbang.master, &pp->info);
+	pp->spidev_lm70 = spi_new_device(pp->bitbang.ctlr, &pp->info);
 	if (pp->spidev_lm70)
 		dev_dbg(&pp->spidev_lm70->dev, "spidev_lm70 at %s\n",
 			dev_name(&pp->spidev_lm70->dev));
@@ -309,7 +309,7 @@ static void spi_lm70llp_detach(struct parport *p)
 	parport_release(pp->pd);
 	parport_unregister_device(pp->pd);
 
-	spi_controller_put(pp->bitbang.master);
+	spi_controller_put(pp->bitbang.ctlr);
 
 	lm70llp = NULL;
 }
diff --git a/drivers/spi/spi-oc-tiny.c b/drivers/spi/spi-oc-tiny.c
index cf7c111088a6..6ea38f5e7d64 100644
--- a/drivers/spi/spi-oc-tiny.c
+++ b/drivers/spi/spi-oc-tiny.c
@@ -194,7 +194,7 @@ static int tiny_spi_of_probe(struct platform_device *pdev)
 
 	if (!np)
 		return 0;
-	hw->bitbang.master->dev.of_node = pdev->dev.of_node;
+	hw->bitbang.ctlr->dev.of_node = pdev->dev.of_node;
 	if (!of_property_read_u32(np, "clock-frequency", &val))
 		hw->freq = val;
 	if (!of_property_read_u32(np, "baud-width", &val))
@@ -229,7 +229,7 @@ static int tiny_spi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, hw);
 
 	/* setup the state for the bitbang driver */
-	hw->bitbang.master = host;
+	hw->bitbang.ctlr = host;
 	hw->bitbang.setup_transfer = tiny_spi_setup_transfer;
 	hw->bitbang.txrx_bufs = tiny_spi_txrx_bufs;
 
@@ -274,7 +274,7 @@ static int tiny_spi_probe(struct platform_device *pdev)
 static void tiny_spi_remove(struct platform_device *pdev)
 {
 	struct tiny_spi *hw = platform_get_drvdata(pdev);
-	struct spi_controller *host = hw->bitbang.master;
+	struct spi_controller *host = hw->bitbang.ctlr;
 
 	spi_bitbang_stop(&hw->bitbang);
 	spi_controller_put(host);
diff --git a/drivers/spi/spi-omap-uwire.c b/drivers/spi/spi-omap-uwire.c
index 2dd1c1bcf4bf..210a98d903fa 100644
--- a/drivers/spi/spi-omap-uwire.c
+++ b/drivers/spi/spi-omap-uwire.c
@@ -448,7 +448,7 @@ static void uwire_off(struct uwire_spi *uwire)
 {
 	uwire_write_reg(UWIRE_SR3, 0);
 	clk_disable_unprepare(uwire->ck);
-	spi_controller_put(uwire->bitbang.master);
+	spi_controller_put(uwire->bitbang.ctlr);
 }
 
 static int uwire_probe(struct platform_device *pdev)
@@ -493,7 +493,7 @@ static int uwire_probe(struct platform_device *pdev)
 	host->setup = uwire_setup;
 	host->cleanup = uwire_cleanup;
 
-	uwire->bitbang.master = host;
+	uwire->bitbang.ctlr = host;
 	uwire->bitbang.chipselect = uwire_chipselect;
 	uwire->bitbang.setup_transfer = uwire_setup_transfer;
 	uwire->bitbang.txrx_bufs = uwire_txrx;
diff --git a/drivers/spi/spi-sh-sci.c b/drivers/spi/spi-sh-sci.c
index 148d615d2f38..3d560b154ad3 100644
--- a/drivers/spi/spi-sh-sci.c
+++ b/drivers/spi/spi-sh-sci.c
@@ -136,9 +136,9 @@ static int sh_sci_spi_probe(struct platform_device *dev)
 	}
 
 	/* setup spi bitbang adaptor */
-	sp->bitbang.master = host;
-	sp->bitbang.master->bus_num = sp->info->bus_num;
-	sp->bitbang.master->num_chipselect = sp->info->num_chipselect;
+	sp->bitbang.ctlr = host;
+	sp->bitbang.ctlr->bus_num = sp->info->bus_num;
+	sp->bitbang.ctlr->num_chipselect = sp->info->num_chipselect;
 	sp->bitbang.chipselect = sh_sci_spi_chipselect;
 
 	sp->bitbang.txrx_word[SPI_MODE_0] = sh_sci_spi_txrx_mode0;
@@ -166,7 +166,7 @@ static int sh_sci_spi_probe(struct platform_device *dev)
 	setbits(sp, PIN_INIT, 0);
 	iounmap(sp->membase);
  err1:
-	spi_controller_put(sp->bitbang.master);
+	spi_controller_put(sp->bitbang.ctlr);
  err0:
 	return ret;
 }
@@ -178,7 +178,7 @@ static void sh_sci_spi_remove(struct platform_device *dev)
 	spi_bitbang_stop(&sp->bitbang);
 	setbits(sp, PIN_INIT, 0);
 	iounmap(sp->membase);
-	spi_controller_put(sp->bitbang.master);
+	spi_controller_put(sp->bitbang.ctlr);
 }
 
 static struct platform_driver sh_sci_spi_drv = {
diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 12355957be97..7795328427a6 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -434,7 +434,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 
 	xspi = spi_controller_get_devdata(host);
 	xspi->cs_inactive = 0xffffffff;
-	xspi->bitbang.master = host;
+	xspi->bitbang.ctlr = host;
 	xspi->bitbang.chipselect = xilinx_spi_chipselect;
 	xspi->bitbang.setup_transfer = xilinx_spi_setup_transfer;
 	xspi->bitbang.txrx_bufs = xilinx_spi_txrx_bufs;
@@ -516,7 +516,7 @@ static void xilinx_spi_remove(struct platform_device *pdev)
 	/* Disable the global IPIF interrupt */
 	xspi->write_fn(0, regs_base + XIPIF_V123B_DGIER_OFFSET);
 
-	spi_controller_put(xspi->bitbang.master);
+	spi_controller_put(xspi->bitbang.ctlr);
 }
 
 /* work with hotplug and coldplug */
diff --git a/drivers/spi/spi-xtensa-xtfpga.c b/drivers/spi/spi-xtensa-xtfpga.c
index 3c7721894376..3c2cda315397 100644
--- a/drivers/spi/spi-xtensa-xtfpga.c
+++ b/drivers/spi/spi-xtensa-xtfpga.c
@@ -93,7 +93,7 @@ static int xtfpga_spi_probe(struct platform_device *pdev)
 	host->dev.of_node = pdev->dev.of_node;
 
 	xspi = spi_controller_get_devdata(host);
-	xspi->bitbang.master = host;
+	xspi->bitbang.ctlr = host;
 	xspi->bitbang.chipselect = xtfpga_spi_chipselect;
 	xspi->bitbang.txrx_word[SPI_MODE_0] = xtfpga_spi_txrx_word;
 	xspi->regs = devm_platform_ioremap_resource(pdev, 0);
diff --git a/include/linux/spi/spi_bitbang.h b/include/linux/spi/spi_bitbang.h
index 4444c2a992cb..b930eca2ef7b 100644
--- a/include/linux/spi/spi_bitbang.h
+++ b/include/linux/spi/spi_bitbang.h
@@ -10,7 +10,7 @@ struct spi_bitbang {
 	u8			use_dma;
 	u16			flags;		/* extra spi->mode support */
 
-	struct spi_master	*master;
+	struct spi_controller	*ctlr;
 
 	/* setup_transfer() changes clock and/or wordsize to match settings
 	 * for this transfer; zeroes restore defaults from spi_device.
-- 
2.43.0


