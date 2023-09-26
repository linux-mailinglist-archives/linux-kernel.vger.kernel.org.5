Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84E07AEB96
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 13:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbjIZLid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 07:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjIZLia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 07:38:30 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984C3DD;
        Tue, 26 Sep 2023 04:38:23 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38QBcEZ4084315;
        Tue, 26 Sep 2023 06:38:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695728294;
        bh=fSEggdhifP4uqE7eOpaahQ4oqSuxnwMUVKmERVc6X5M=;
        h=From:To:CC:Subject:Date;
        b=x0s7mxXk99Rk+13HpytZc2ZU3FigovLroiZ4rk+SospAfT9LD36+uhJr/N9Ko6FLx
         nmc9c4XtOgIznSIKdHWSWkKHaeSXFLx2q8gMjW63ZGva1XkyLAs2a9YMLSuchxorcC
         JtaZIDpkhVb0UmURPLd1gCUg2R5Dw6Oh3Au+1RoY=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38QBcEmv120727
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Sep 2023 06:38:14 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Sep 2023 06:38:13 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Sep 2023 06:38:13 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38QBcC81003293;
        Tue, 26 Sep 2023 06:38:13 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC:     <d-gole@ti.com>, <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        <vaishnav.a@ti.com>, <u-kumar1@ti.com>
Subject: [PATCH v2] spi: omap2-mcspi: Fix hardcoded reference clock
Date:   Tue, 26 Sep 2023 17:08:12 +0530
Message-ID: <20230926113812.30692-1-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A hardcoded reference clock of 48 MHz is used to calculate the
clock divisor values, but the reference clock frequency can be
different across devices and can be configured which can cause
a mismatch between the reported frequency and actual SPI clock
frequency observed. Fix this by fetching the clock rate from
the clock provider and falling back to hardcoded reference only
if the clock is not supplied.

Fixes: 2cd7d393f461 ("arm64: dts: ti: k3-am654: Add McSPI DT nodes")

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---

V1->V2:
 * Use u32 instead of unsigned int
 * rename clk to ref_clk and rebase for latest struct ctlr rename changes.

Blamed commit is the first device where the default reference clock was
different from the hardcoded value.
Tested on TDA4VM SK (6.6.0-rc3-next-20230926)
https://gist.github.com/vaishnavachath/7bbc6dd6e02294aed3e8c547cfa039c2

V1 - https://lore.kernel.org/all/20230912100328.31813-1-vaishnav.a@ti.com/

 drivers/spi/spi-omap2-mcspi.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 79888e6c54c2..ddf1c684bcc7 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -125,10 +125,12 @@ struct omap2_mcspi {
 	struct omap2_mcspi_dma	*dma_channels;
 	struct device		*dev;
 	struct omap2_mcspi_regs ctx;
+	struct clk		*ref_clk;
 	int			fifo_depth;
 	bool			target_aborted;
 	unsigned int		pin_dir:1;
 	size_t			max_xfer_len;
+	u32			ref_clk_hz;
 };
 
 struct omap2_mcspi_cs {
@@ -880,12 +882,12 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 	return count - c;
 }
 
-static u32 omap2_mcspi_calc_divisor(u32 speed_hz)
+static u32 omap2_mcspi_calc_divisor(u32 speed_hz, u32 ref_clk_hz)
 {
 	u32 div;
 
 	for (div = 0; div < 15; div++)
-		if (speed_hz >= (OMAP2_MCSPI_MAX_FREQ >> div))
+		if (speed_hz >= (ref_clk_hz >> div))
 			return div;
 
 	return 15;
@@ -897,7 +899,7 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 {
 	struct omap2_mcspi_cs *cs = spi->controller_state;
 	struct omap2_mcspi *mcspi;
-	u32 l = 0, clkd = 0, div, extclk = 0, clkg = 0;
+	u32 ref_clk_hz, l = 0, clkd = 0, div, extclk = 0, clkg = 0;
 	u8 word_len = spi->bits_per_word;
 	u32 speed_hz = spi->max_speed_hz;
 
@@ -911,14 +913,15 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 	if (t && t->speed_hz)
 		speed_hz = t->speed_hz;
 
-	speed_hz = min_t(u32, speed_hz, OMAP2_MCSPI_MAX_FREQ);
-	if (speed_hz < (OMAP2_MCSPI_MAX_FREQ / OMAP2_MCSPI_MAX_DIVIDER)) {
-		clkd = omap2_mcspi_calc_divisor(speed_hz);
-		speed_hz = OMAP2_MCSPI_MAX_FREQ >> clkd;
+	ref_clk_hz = mcspi->ref_clk_hz;
+	speed_hz = min_t(u32, speed_hz, ref_clk_hz);
+	if (speed_hz < (ref_clk_hz / OMAP2_MCSPI_MAX_DIVIDER)) {
+		clkd = omap2_mcspi_calc_divisor(speed_hz, ref_clk_hz);
+		speed_hz = ref_clk_hz >> clkd;
 		clkg = 0;
 	} else {
-		div = (OMAP2_MCSPI_MAX_FREQ + speed_hz - 1) / speed_hz;
-		speed_hz = OMAP2_MCSPI_MAX_FREQ / div;
+		div = (ref_clk_hz + speed_hz - 1) / speed_hz;
+		speed_hz = ref_clk_hz / div;
 		clkd = (div - 1) & 0xf;
 		extclk = (div - 1) >> 4;
 		clkg = OMAP2_MCSPI_CHCONF_CLKG;
@@ -1448,8 +1451,6 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	ctlr->cleanup = omap2_mcspi_cleanup;
 	ctlr->target_abort = omap2_mcspi_target_abort;
 	ctlr->dev.of_node = node;
-	ctlr->max_speed_hz = OMAP2_MCSPI_MAX_FREQ;
-	ctlr->min_speed_hz = OMAP2_MCSPI_MAX_FREQ >> 15;
 	ctlr->use_gpio_descriptors = true;
 
 	platform_set_drvdata(pdev, ctlr);
@@ -1519,6 +1520,14 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 		goto free_ctlr;
 	}
 
+	mcspi->ref_clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
+	if (mcspi->ref_clk)
+		mcspi->ref_clk_hz = clk_get_rate(mcspi->ref_clk);
+	else
+		mcspi->ref_clk_hz = OMAP2_MCSPI_MAX_FREQ;
+	ctlr->max_speed_hz = mcspi->ref_clk_hz;
+	ctlr->min_speed_hz = mcspi->ref_clk_hz >> 15;
+
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_enable(&pdev->dev);
-- 
2.17.1

