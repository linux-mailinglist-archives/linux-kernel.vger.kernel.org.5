Return-Path: <linux-kernel+bounces-154829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 761308AE1A4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D91281A70
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B3665194;
	Tue, 23 Apr 2024 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="np8hB3aR"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A817A5EE8D;
	Tue, 23 Apr 2024 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713866515; cv=none; b=CINCsopKf5XJYentvX8su8Xj4+zEgegultUsUgU8o+q2LwJ8SgC2Px651V4JcN8oUyWA0s43NuaeKewsKj5KL/En1kIkpyJp1H5XT+s2iTT0t8UzsSKxGojyi1zQYZB0z4CJ2fy94juUxrZ605k4pM0GxBpVd2wTwkAACrBRvt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713866515; c=relaxed/simple;
	bh=HK7nTIHxj4vRn1zLzL4Ml297uns17UJ5VfHqPQW4dAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rfPDemz5XyfH2GYJiTDddvY9+pk70W2IuIx8vmHE3PIDQbIxB9lhXfYNhKmH9vdCUmNpoubJJhf53ogoBfXjfgXTzWm8jVBfXEjY43xmX1H33JFspdO489ClCt+QNGn1x4qxG3w+VNWtQLIegXeiCoA/6gpRzG6q6qM+cJEyh6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=np8hB3aR; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 269F41C000C;
	Tue, 23 Apr 2024 10:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713866508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+jkSaR8RN3FHUyVZmT8l3Mp5fnnAxigkjdQtpVmnrtI=;
	b=np8hB3aRqLPP/YVkDs5g4oOgvcmkH8S/H24b1cwNg4ihYKUhKBbpH8qtwvSPc7LQafk7pv
	+7MVQtuzACXnZWNEfb6jMduRm5IuCL7yLuTyJxApsw6n2sgnAjXtAIg8yUFpuncozYoM/I
	3pne5mfZFjZt4D0pZtjprMGYBMyw2rQhU7J1QdSj4uUPaqAQA769NrjpRMnVpd7EABn1ok
	ObUYB5QKoBupMY2QH2IQB8aDXb9P3zSzFNCBagtVRGfYFvJHFlnE8/WYOGAaRxa2/k2MvO
	rD6nD7fXI4nn9xCghIgMea5yO+k+YmAM1AKWbRXEaMKojACj6pjhKJGvbQ43Bw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 23 Apr 2024 12:01:40 +0200
Subject: [PATCH v4 1/6] spi: cadence-qspi: allow FIFO depth detection
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-cdns-qspi-mbly-v4-1-3d2a7b535ad0@bootlin.com>
References: <20240423-cdns-qspi-mbly-v4-0-3d2a7b535ad0@bootlin.com>
In-Reply-To: <20240423-cdns-qspi-mbly-v4-0-3d2a7b535ad0@bootlin.com>
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
 drivers/spi/spi-cadence-quadspi.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 9896e9fe7ffb..5a83940220a9 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1510,8 +1510,8 @@ static int cqspi_of_get_pdata(struct cqspi_st *cqspi)
 	cqspi->is_decoded_cs = of_property_read_bool(np, "cdns,is-decoded-cs");
 
 	if (of_property_read_u32(np, "cdns,fifo-depth", &cqspi->fifo_depth)) {
-		dev_err(dev, "couldn't determine fifo-depth\n");
-		return -ENXIO;
+		/* Zero signals FIFO depth should be runtime detected. */
+		cqspi->fifo_depth = 0;
 	}
 
 	if (of_property_read_u32(np, "cdns,fifo-width", &cqspi->fifo_width)) {
@@ -1541,8 +1541,6 @@ static void cqspi_controller_init(struct cqspi_st *cqspi)
 {
 	u32 reg;
 
-	cqspi_controller_enable(cqspi, 0);
-
 	/* Configure the remap address register, no remap */
 	writel(0, cqspi->iobase + CQSPI_REG_REMAP);
 
@@ -1576,8 +1574,29 @@ static void cqspi_controller_init(struct cqspi_st *cqspi)
 		reg |= CQSPI_REG_CONFIG_DMA_MASK;
 		writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
 	}
+}
 
-	cqspi_controller_enable(cqspi, 1);
+static void cqspi_controller_detect_fifo_depth(struct cqspi_st *cqspi)
+{
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
@@ -1730,6 +1749,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	cqspi->pdev = pdev;
 	cqspi->host = host;
 	cqspi->is_jh7110 = false;
+	cqspi->ddata = ddata = of_device_get_match_data(dev);
 	platform_set_drvdata(pdev, cqspi);
 
 	/* Obtain configuration from OF. */
@@ -1821,8 +1841,6 @@ static int cqspi_probe(struct platform_device *pdev)
 	/* write completion is supported by default */
 	cqspi->wr_completion = true;
 
-	ddata = of_device_get_match_data(dev);
-	cqspi->ddata = ddata;
 	if (ddata) {
 		if (ddata->quirks & CQSPI_NEEDS_WR_DELAY)
 			cqspi->wr_delay = 50 * DIV_ROUND_UP(NSEC_PER_SEC,
@@ -1864,7 +1882,10 @@ static int cqspi_probe(struct platform_device *pdev)
 	}
 
 	cqspi_wait_idle(cqspi);
+	cqspi_controller_enable(cqspi, 0);
+	cqspi_controller_detect_fifo_depth(cqspi);
 	cqspi_controller_init(cqspi);
+	cqspi_controller_enable(cqspi, 1);
 	cqspi->current_cs = -1;
 	cqspi->sclk = 0;
 
@@ -1947,7 +1968,9 @@ static int cqspi_runtime_resume(struct device *dev)
 
 	clk_prepare_enable(cqspi->clk);
 	cqspi_wait_idle(cqspi);
+	cqspi_controller_enable(cqspi, 0);
 	cqspi_controller_init(cqspi);
+	cqspi_controller_enable(cqspi, 1);
 
 	cqspi->current_cs = -1;
 	cqspi->sclk = 0;

-- 
2.44.0


