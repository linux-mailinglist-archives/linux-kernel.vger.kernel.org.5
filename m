Return-Path: <linux-kernel+bounces-138253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CA489EED2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7C211C20297
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AED158A28;
	Wed, 10 Apr 2024 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pFRsG+H4"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B0813D2BC;
	Wed, 10 Apr 2024 09:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712741357; cv=none; b=F9iyg++h3gZXlRM6njqulEuT1ZAX9L+mmbvwAikb9RJG+IkHZLoXEXFWe91HndfoFiSzOHrccv7Xu38uiAe8xafUUJM/fgOMQw84Fihh1GfsZunPySruVAeQW3fdEcPaLM/qMrvxIRgrOB+pHTmg78/tKg7avEIC7S4cRVw9ImM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712741357; c=relaxed/simple;
	bh=XllhvdNXULIE3CImgSBufNbbReemMbchd9h8L7I837A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bhyquqH4OiUKY8HeYGlzhFjQvm2PgsGP7EeAfkQOIJH8DYCqfGj7rl5hcSrW0YTGCmGxnD8RjpH4jc+KZ1caNYiun71bM1KhC/wVCViYRSdl4XiVFnn2GaIkq5fL3Rv+BTs+8qlasVr4shGmhrxOa6CxIL1SOLtn/UIUUMJYWok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pFRsG+H4; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2E23BC0002;
	Wed, 10 Apr 2024 09:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712741352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qT2L9De8YkW05zivGysH06k/sTuQS9j+DtTxCa88wj8=;
	b=pFRsG+H4vyr+tpo0uK0Zr/biVUnYkP/DFrU7kPN2jIbW5xI2MdNCCxYkvLdd1214/RIcrO
	50bd/l53bmuI+S0wJiYq4cImG4DxKD436/AiWYKNxhPbCBg+IEehr9YUc5Je/VhcNBQ5+X
	EH5OItp5myteh3tIVOh7Zv03X9E0SJovHZ0F0VyU5SPDoY+T4qLKacRAYwBLF3OBjriuW6
	zlM/jAGZJuoWbIZt12raR0yC5OXKIe2MRoCU5kMI00KE7k67t3nMuEVNo6GQizs35Kz2Fv
	dOk4d80RpdPemEbmM+GKAxhu0RVXpnW2xu5XSD/jAa1Dwa9cLVw5fn2tat2yzg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 10 Apr 2024 11:29:08 +0200
Subject: [PATCH v3 5/9] spi: cadence-qspi: add no-IRQ mode to indirect
 reads
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240410-cdns-qspi-mbly-v3-5-7b7053449cf7@bootlin.com>
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

Support reads through polling, without any IRQ. The main reason is
performance; profiling shows that the first IRQ comes quickly on our
specific hardware. Once this IRQ arrives, we poll until all data is
retrieved. Avoid initial sleep to reduce IRQ count.

Hide this behavior behind a quirk flag.

This is confirmed through micro-benchmarks, but also end-to-end
performance tests. Mobileye EyeQ5, octal flash, reading 235M on a UBIFS
filesystem:
 - No optimizations, ~10.34s, ~22.7 MB/s, 199230 IRQs
 - CQSPI_SLOW_SRAM,  ~10.34s, ~22.7 MB/s,  70284 IRQs
 - CQSPI_RD_NO_IRQ,   ~9.37s, ~25.1 MB/s,    521 IRQs

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index b499f2e5ec87..cde84d10678e 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -42,6 +42,7 @@ static_assert(CQSPI_MAX_CHIPSELECT <= SPI_CS_CNT_MAX);
 #define CQSPI_NO_SUPPORT_WR_COMPLETION	BIT(3)
 #define CQSPI_SLOW_SRAM		BIT(4)
 #define CQSPI_NEEDS_APB_AHB_HAZARD_WAR	BIT(5)
+#define CQSPI_RD_NO_IRQ			BIT(6)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -702,6 +703,7 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 				       const size_t n_rx)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
+	bool use_irq = !(cqspi->ddata && cqspi->ddata->quirks & CQSPI_RD_NO_IRQ);
 	struct device *dev = &cqspi->pdev->dev;
 	void __iomem *reg_base = cqspi->iobase;
 	void __iomem *ahb_base = cqspi->ahb_base;
@@ -725,17 +727,20 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 	 * all the read interrupts disabled for max performance.
 	 */
 
-	if (!cqspi->slow_sram)
+	if (use_irq && cqspi->slow_sram)
+		writel(CQSPI_REG_IRQ_WATERMARK, reg_base + CQSPI_REG_IRQMASK);
+	else if (use_irq)
 		writel(CQSPI_IRQ_MASK_RD, reg_base + CQSPI_REG_IRQMASK);
 	else
-		writel(CQSPI_REG_IRQ_WATERMARK, reg_base + CQSPI_REG_IRQMASK);
+		writel(0, reg_base + CQSPI_REG_IRQMASK);
 
 	reinit_completion(&cqspi->transfer_complete);
 	writel(CQSPI_REG_INDIRECTRD_START_MASK,
 	       reg_base + CQSPI_REG_INDIRECTRD);
 
 	while (remaining > 0) {
-		if (!wait_for_completion_timeout(&cqspi->transfer_complete,
+		if (use_irq &&
+		    !wait_for_completion_timeout(&cqspi->transfer_complete,
 						 msecs_to_jiffies(CQSPI_READ_TIMEOUT_MS)))
 			ret = -ETIMEDOUT;
 
@@ -777,7 +782,7 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 			bytes_to_read = cqspi_get_rd_sram_level(cqspi);
 		}
 
-		if (remaining > 0) {
+		if (use_irq && remaining > 0) {
 			reinit_completion(&cqspi->transfer_complete);
 			if (cqspi->slow_sram)
 				writel(CQSPI_REG_IRQ_WATERMARK, reg_base + CQSPI_REG_IRQMASK);

-- 
2.44.0


