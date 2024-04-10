Return-Path: <linux-kernel+bounces-138252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9A989EECA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824601C20E30
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB0A156C69;
	Wed, 10 Apr 2024 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E+6gjx2n"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C9F1552F9;
	Wed, 10 Apr 2024 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712741356; cv=none; b=sZ5OOXMj2vLWkg2Tye4oNKN5GBGNR/ncXnNY9CoMf8mAC8RwyWfVBjPmmAOz7HHjj2rg7G7VnWRN3fYommN3srzv4b3nowTSEvajp5/WVhlPfoNXIK9SXQ5LPn5wTE+QbVkW1dgidNTXP5fj75MKAf+oatF8bXrMaRBlLpCEvOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712741356; c=relaxed/simple;
	bh=mvhdsulZewicd+LkZmV4JeCPpon1LTdEp97o824fgI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N6AEbVuQhCvecu2r/mRbpUfWiAbNcJxpc71pR+4mFaY9o9dDbJdpbXhG9idfGcKxy0e7K9CUEwv2wtmaitQw0tVOe+ITgZ0HOyLjuU8LXZ1msL31y8pjxnZPoDCjwuytqxJ6u/XPGkOO12NBRHXuu5a3G+8rjIBZAWDsEGs2KgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E+6gjx2n; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 739EAC0009;
	Wed, 10 Apr 2024 09:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712741352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9QcHeygYSqhOv8EePeVmyZmnPYQEFehYxee2vzIZ9EQ=;
	b=E+6gjx2n/iyBev1MHJsAAnndnpKg7NB7IRzI1DRSsdFi00QTtPbxVXDlQF0Is+BrOHkOGl
	210KORfmjl4HtU4kED/rmn+WBeFEKlwMby07eK1nCFmtDD/pDKGTINGtGhgBFL2u/tOc2q
	7YtwDkFvSmt+uR8eweHLapfZUAcbC6dnX4PjtqKYZ9cesbdHfVozOXivu0KCVNaLAeROVD
	L7IL9AZVHsMoAoIPrCS5ORHhETwznLrY5oMKaRBzWpE+exRHJQyl9Ufj0z+lRhtosikt4q
	DFoY4W0qIpPDrwGsVa1wJiSTR2cEpqq7+fDFWZmQ0QVxpqD0WHnkTS4QEASjzw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 10 Apr 2024 11:29:07 +0200
Subject: [PATCH v3 4/9] spi: cadence-qspi: allow FIFO depth detection
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240410-cdns-qspi-mbly-v3-4-7b7053449cf7@bootlin.com>
References: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
In-Reply-To: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
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

If FIFO depth DT property is provided, check it matches what hardware
reports and warn otherwise. Else, use hardware provided value.

Hardware exposes FIFO depth indirectly because
CQSPI_REG_SRAMPARTITION is partially read-only.

Move probe cqspi->ddata assignment prior to cqspi_of_get_pdata() call.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 9896e9fe7ffb..b499f2e5ec87 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1503,6 +1503,7 @@ static int cqspi_of_get_flash_pdata(struct platform_device *pdev,
 
 static int cqspi_of_get_pdata(struct cqspi_st *cqspi)
 {
+	const struct cqspi_driver_platdata *ddata = cqspi->ddata;
 	struct device *dev = &cqspi->pdev->dev;
 	struct device_node *np = dev->of_node;
 	u32 id[2];
@@ -1510,8 +1511,8 @@ static int cqspi_of_get_pdata(struct cqspi_st *cqspi)
 	cqspi->is_decoded_cs = of_property_read_bool(np, "cdns,is-decoded-cs");
 
 	if (of_property_read_u32(np, "cdns,fifo-depth", &cqspi->fifo_depth)) {
-		dev_err(dev, "couldn't determine fifo-depth\n");
-		return -ENXIO;
+		/* Zero signals FIFO depth should be runtime detected. */
+		cqspi->fifo_depth = 0;
 	}
 
 	if (of_property_read_u32(np, "cdns,fifo-width", &cqspi->fifo_width)) {
@@ -1541,8 +1542,6 @@ static void cqspi_controller_init(struct cqspi_st *cqspi)
 {
 	u32 reg;
 
-	cqspi_controller_enable(cqspi, 0);
-
 	/* Configure the remap address register, no remap */
 	writel(0, cqspi->iobase + CQSPI_REG_REMAP);
 
@@ -1576,8 +1575,30 @@ static void cqspi_controller_init(struct cqspi_st *cqspi)
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
+	/* FIFO depth of zero means no value from devicetree was provided. */
+	if (cqspi->fifo_depth == 0) {
+		cqspi->fifo_depth = fifo_depth;
+		dev_dbg(dev, "using FIFO depth of %u\n", fifo_depth);
+	} else if (fifo_depth != cqspi->fifo_depth) {
+		dev_warn(dev, "detected FIFO depth (%u) different from config (%u)\n",
+			 fifo_depth, cqspi->fifo_depth);
+	}
 }
 
 static int cqspi_request_mmap_dma(struct cqspi_st *cqspi)
@@ -1730,6 +1751,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	cqspi->pdev = pdev;
 	cqspi->host = host;
 	cqspi->is_jh7110 = false;
+	cqspi->ddata = ddata = of_device_get_match_data(dev);
 	platform_set_drvdata(pdev, cqspi);
 
 	/* Obtain configuration from OF. */
@@ -1821,8 +1843,6 @@ static int cqspi_probe(struct platform_device *pdev)
 	/* write completion is supported by default */
 	cqspi->wr_completion = true;
 
-	ddata = of_device_get_match_data(dev);
-	cqspi->ddata = ddata;
 	if (ddata) {
 		if (ddata->quirks & CQSPI_NEEDS_WR_DELAY)
 			cqspi->wr_delay = 50 * DIV_ROUND_UP(NSEC_PER_SEC,
@@ -1864,7 +1884,10 @@ static int cqspi_probe(struct platform_device *pdev)
 	}
 
 	cqspi_wait_idle(cqspi);
+	cqspi_controller_enable(cqspi, 0);
+	cqspi_controller_detect_fifo_depth(cqspi);
 	cqspi_controller_init(cqspi);
+	cqspi_controller_enable(cqspi, 1);
 	cqspi->current_cs = -1;
 	cqspi->sclk = 0;
 
@@ -1947,7 +1970,9 @@ static int cqspi_runtime_resume(struct device *dev)
 
 	clk_prepare_enable(cqspi->clk);
 	cqspi_wait_idle(cqspi);
+	cqspi_controller_enable(cqspi, 0);
 	cqspi_controller_init(cqspi);
+	cqspi_controller_enable(cqspi, 1);
 
 	cqspi->current_cs = -1;
 	cqspi->sclk = 0;

-- 
2.44.0


