Return-Path: <linux-kernel+bounces-133208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE9889A08B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013241F243AA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DA3171090;
	Fri,  5 Apr 2024 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PxQN75Id"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE4016F854;
	Fri,  5 Apr 2024 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329342; cv=none; b=fDns8ARj8JPRJieS3ZOJ5hR3YD43KOGK0/sNijlTdZikx03JkC3fDGWxfgRfhhDrSsgMQvLzrbiIgkvXlgS1hbm9qQ7me4j/kX3nIdu3GfxaO5vNP3tI/8tax/2AivNV09p5tccqAg16Q/5CpPg5Qhsb5EuPBQQCjetIFM6s7n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329342; c=relaxed/simple;
	bh=8yaXS+IOb/F69hVyWvfoEo1mtRnN+GmdaXySoxOrDqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QJsULmnszFndTAvNEBTAGLkVhQLqvnvsu2cAH2XjSm3BQWlrm/S7R1hBVhc5iaLO5k1hSOkXw9p9YFbn3PfzA2pGq40njJzVa2EBky22WTMHrvWWu1+W1wwmXkt5LTHSm+sV/4z9m0IZYg/BjSHfrX6jniGKumvxgGvlI7cvqGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PxQN75Id; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2CCE91BF21B;
	Fri,  5 Apr 2024 15:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712329338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jXGUgPteTgG103mmpT+uk+Z0LmFOU065TLnoYvPItNU=;
	b=PxQN75IdiqDieoXjFrJbS+oYV0dqsp2PxpzPnqE8+bgc/80r2/FPpE4CEsYF3PqS5JXKq5
	+FkuKdbHOJJdC0xxB4RHPkfs6pNvHYOfXrkmqWUVgRFomgZ40QOyHASNzlBTRcVRFJXy5u
	0rgWmyOemYp9yw2SlTmET5SuJ39walPKKZ6WQuMeljXGe2JZc5KAxm3WGJ5s9xWdrlH/sG
	6DY8qX5sGHBh6/roIhQobQvaR4PVqNs0s2loSJZi4XNL65PrBrW1ejk+KEk9L1eRXwaRhr
	SSwtzExb9sOa9I5UBg7Qr4hjxWcA5USW0Myg4KaQ1ON4Y12A05+xVfUKKNrYcg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 05 Apr 2024 17:02:15 +0200
Subject: [PATCH v2 05/11] spi: cadence-qspi: add FIFO depth detection quirk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240405-cdns-qspi-mbly-v2-5-956679866d6d@bootlin.com>
References: <20240405-cdns-qspi-mbly-v2-0-956679866d6d@bootlin.com>
In-Reply-To: <20240405-cdns-qspi-mbly-v2-0-956679866d6d@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Rob Herring <robh@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Use hardware ability to read the FIFO depth thanks to
CQSPI_REG_SRAMPARTITION that is partially read-only. Keep current
behavior identical for existing compatibles.

Hide feature behind a flag. If unset and detected value is different
from the devicetree-provided value, warn.

Move probe cqspi->ddata assignment prior to cqspi_of_get_pdata() call.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index abc1c35929cc..04a473fafe43 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -42,6 +42,7 @@ static_assert(CQSPI_MAX_CHIPSELECT <= SPI_CS_CNT_MAX);
 #define CQSPI_NO_SUPPORT_WR_COMPLETION	BIT(3)
 #define CQSPI_SLOW_SRAM		BIT(4)
 #define CQSPI_NEEDS_APB_AHB_HAZARD_WAR	BIT(5)
+#define CQSPI_DETECT_FIFO_DEPTH		BIT(6)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -1500,13 +1501,15 @@ static int cqspi_of_get_flash_pdata(struct platform_device *pdev,
 
 static int cqspi_of_get_pdata(struct cqspi_st *cqspi)
 {
+	const struct cqspi_driver_platdata *ddata = cqspi->ddata;
 	struct device *dev = &cqspi->pdev->dev;
 	struct device_node *np = dev->of_node;
 	u32 id[2];
 
 	cqspi->is_decoded_cs = of_property_read_bool(np, "cdns,is-decoded-cs");
 
-	if (of_property_read_u32(np, "cdns,fifo-depth", &cqspi->fifo_depth)) {
+	if (!(ddata && ddata->quirks & CQSPI_DETECT_FIFO_DEPTH) &&
+	    of_property_read_u32(np, "cdns,fifo-depth", &cqspi->fifo_depth)) {
 		dev_err(dev, "couldn't determine fifo-depth\n");
 		return -ENXIO;
 	}
@@ -1538,8 +1541,6 @@ static void cqspi_controller_init(struct cqspi_st *cqspi)
 {
 	u32 reg;
 
-	cqspi_controller_enable(cqspi, 0);
-
 	/* Configure the remap address register, no remap */
 	writel(0, cqspi->iobase + CQSPI_REG_REMAP);
 
@@ -1573,8 +1574,29 @@ static void cqspi_controller_init(struct cqspi_st *cqspi)
 		reg |= CQSPI_REG_CONFIG_DMA_MASK;
 		writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
 	}
+}
 
-	cqspi_controller_enable(cqspi, 1);
+static void cqspi_controller_detect_fifo_depth(struct cqspi_st *cqspi)
+{
+	const struct cqspi_driver_platdata *ddata = cqspi->ddata;
+	struct device *dev = &cqspi->pdev->dev;
+	u32 reg, fifo_depth;
+
+	/*
+	 * Bits N-1:0 are writable while bits 31:N are read as zero, with 2^N
+	 * the FIFO depth.
+	 */
+	writel(U32_MAX, cqspi->iobase + CQSPI_REG_SRAMPARTITION);
+	reg = readl(cqspi->iobase + CQSPI_REG_SRAMPARTITION);
+	fifo_depth = reg + 1;
+
+	if (ddata && ddata->quirks & CQSPI_DETECT_FIFO_DEPTH) {
+		cqspi->fifo_depth = fifo_depth;
+		dev_dbg(dev, "using FIFO depth of %u\n", fifo_depth);
+	} else if (fifo_depth != cqspi->fifo_depth) {
+		dev_warn(dev, "detected FIFO depth (%u) different from config (%u)\n",
+			 fifo_depth, cqspi->fifo_depth);
+	}
 }
 
 static int cqspi_request_mmap_dma(struct cqspi_st *cqspi)
@@ -1727,6 +1749,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	cqspi->pdev = pdev;
 	cqspi->host = host;
 	cqspi->is_jh7110 = false;
+	cqspi->ddata = ddata = of_device_get_match_data(dev);
 	platform_set_drvdata(pdev, cqspi);
 
 	/* Obtain configuration from OF. */
@@ -1818,8 +1841,6 @@ static int cqspi_probe(struct platform_device *pdev)
 	/* write completion is supported by default */
 	cqspi->wr_completion = true;
 
-	ddata = of_device_get_match_data(dev);
-	cqspi->ddata = ddata;
 	if (ddata) {
 		if (ddata->quirks & CQSPI_NEEDS_WR_DELAY)
 			cqspi->wr_delay = 50 * DIV_ROUND_UP(NSEC_PER_SEC,
@@ -1861,7 +1882,10 @@ static int cqspi_probe(struct platform_device *pdev)
 	}
 
 	cqspi_wait_idle(cqspi);
+	cqspi_controller_enable(cqspi, 0);
+	cqspi_controller_detect_fifo_depth(cqspi);
 	cqspi_controller_init(cqspi);
+	cqspi_controller_enable(cqspi, 1);
 	cqspi->current_cs = -1;
 	cqspi->sclk = 0;
 
@@ -1944,7 +1968,9 @@ static int cqspi_runtime_resume(struct device *dev)
 
 	clk_prepare_enable(cqspi->clk);
 	cqspi_wait_idle(cqspi);
+	cqspi_controller_enable(cqspi, 0);
 	cqspi_controller_init(cqspi);
+	cqspi_controller_enable(cqspi, 1);
 
 	cqspi->current_cs = -1;
 	cqspi->sclk = 0;

-- 
2.44.0


