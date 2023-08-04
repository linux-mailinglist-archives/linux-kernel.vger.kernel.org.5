Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C8776F776
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 04:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjHDCDE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Aug 2023 22:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjHDCDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 22:03:01 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA04B448B;
        Thu,  3 Aug 2023 19:02:59 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 5724124DCFA;
        Fri,  4 Aug 2023 10:02:57 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 4 Aug
 2023 10:02:57 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX068.cuchost.com (172.16.6.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Fri, 4 Aug 2023 10:02:56 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v6 2/3] spi: cadence-quadspi: Add clock configuration for StarFive JH7110 QSPI
Date:   Fri, 4 Aug 2023 10:02:53 +0800
Message-ID: <20230804020254.291239-3-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804020254.291239-1-william.qiu@starfivetech.com>
References: <20230804020254.291239-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add JH7110's clock initialization code to the driver.

Signed-off-by: William Qiu <william.qiu@starfivetech.com>
Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
---
 drivers/spi/spi-cadence-quadspi.c | 67 +++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index abf10f92415d..16985e1fe610 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -47,6 +47,12 @@
 
 #define CQSPI_OP_WIDTH(part) ((part).nbytes ? ilog2((part).buswidth) : 0)
 
+enum {
+	CLK_QSPI_APB = 0,
+	CLK_QSPI_AHB,
+	CLK_QSPI_NUM,
+};
+
 struct cqspi_st;
 
 struct cqspi_flash_pdata {
@@ -64,6 +70,7 @@ struct cqspi_st {
 	struct platform_device	*pdev;
 	struct spi_master	*master;
 	struct clk		*clk;
+	struct clk		*clks[CLK_QSPI_NUM];
 	unsigned int		sclk;
 
 	void __iomem		*iobase;
@@ -92,6 +99,8 @@ struct cqspi_st {
 	bool			wr_completion;
 	bool			slow_sram;
 	bool			apb_ahb_hazard;
+
+	bool			is_jh7110; /* Flag for StarFive JH7110 SoC */
 };
 
 struct cqspi_driver_platdata {
@@ -100,6 +109,8 @@ struct cqspi_driver_platdata {
 	int (*indirect_read_dma)(struct cqspi_flash_pdata *f_pdata,
 				 u_char *rxbuf, loff_t from_addr, size_t n_rx);
 	u32 (*get_dma_status)(struct cqspi_st *cqspi);
+	int (*jh7110_clk_init)(struct platform_device *pdev,
+			       struct cqspi_st *cqspi);
 };
 
 /* Operation timeout value */
@@ -1630,6 +1641,51 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi)
 	return 0;
 }
 
+static int cqspi_jh7110_clk_init(struct platform_device *pdev, struct cqspi_st *cqspi)
+{
+	static struct clk_bulk_data qspiclk[] = {
+		{ .id = "apb" },
+		{ .id = "ahb" },
+	};
+
+	int ret = 0;
+
+	ret = devm_clk_bulk_get(&pdev->dev, ARRAY_SIZE(qspiclk), qspiclk);
+	if (ret) {
+		dev_err(&pdev->dev, "%s: failed to get qspi clocks\n", __func__);
+		return ret;
+	}
+
+	cqspi->clks[CLK_QSPI_APB] = qspiclk[0].clk;
+	cqspi->clks[CLK_QSPI_AHB] = qspiclk[1].clk;
+
+	ret = clk_prepare_enable(cqspi->clks[CLK_QSPI_APB]);
+	if (ret) {
+		dev_err(&pdev->dev, "%s: failed to enable CLK_QSPI_APB\n", __func__);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(cqspi->clks[CLK_QSPI_AHB]);
+	if (ret) {
+		dev_err(&pdev->dev, "%s: failed to enable CLK_QSPI_AHB\n", __func__);
+		goto disable_apb_clk;
+	}
+
+	cqspi->is_jh7110 = true;
+
+	return 0;
+
+disable_apb_clk:
+	clk_disable_unprepare(cqspi->clks[CLK_QSPI_APB]);
+
+	return ret;
+}
+
+static void cqspi_jh7110_disable_clk(struct platform_device *pdev, struct cqspi_st *cqspi)
+{
+	clk_disable_unprepare(cqspi->clks[CLK_QSPI_AHB]);
+	clk_disable_unprepare(cqspi->clks[CLK_QSPI_APB]);
+}
 static int cqspi_probe(struct platform_device *pdev)
 {
 	const struct cqspi_driver_platdata *ddata;
@@ -1655,6 +1711,7 @@ static int cqspi_probe(struct platform_device *pdev)
 
 	cqspi->pdev = pdev;
 	cqspi->master = master;
+	cqspi->is_jh7110 = false;
 	platform_set_drvdata(pdev, cqspi);
 
 	/* Obtain configuration from OF. */
@@ -1766,6 +1823,12 @@ static int cqspi_probe(struct platform_device *pdev)
 		if (ddata->quirks & CQSPI_NEEDS_APB_AHB_HAZARD_WAR)
 			cqspi->apb_ahb_hazard = true;
 
+		if (ddata->jh7110_clk_init) {
+			ret = cqspi_jh7110_clk_init(pdev, cqspi);
+			if (ret)
+				goto probe_clk_failed;
+		}
+
 		if (of_device_is_compatible(pdev->dev.of_node,
 					    "xlnx,versal-ospi-1.0")) {
 			ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
@@ -1830,6 +1893,9 @@ static void cqspi_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(cqspi->clk);
 
+	if (cqspi->is_jh7110)
+		cqspi_jh7110_disable_clk(pdev, cqspi);
+
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 }
@@ -1897,6 +1963,7 @@ static const struct cqspi_driver_platdata versal_ospi = {
 
 static const struct cqspi_driver_platdata jh7110_qspi = {
 	.quirks = CQSPI_DISABLE_DAC_MODE,
+	.jh7110_clk_init = cqspi_jh7110_clk_init,
 };
 
 static const struct cqspi_driver_platdata pensando_cdns_qspi = {
-- 
2.34.1

