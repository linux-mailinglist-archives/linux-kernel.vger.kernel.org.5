Return-Path: <linux-kernel+bounces-154828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 415958AE1A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D176B22A42
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D257165191;
	Tue, 23 Apr 2024 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GhHVZ5ZA"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82895FDA6;
	Tue, 23 Apr 2024 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713866515; cv=none; b=F10Xb5KtKGIIr9VHorzN6vnShb2ax+OMJnxCa99A/5QmuEdENO5sttM3RQCHWOe87JZGhWN+cZJAtIjPANLOAy5DQy2OWs4d/g7hUrCBgUvtes+Ulwto+/XoiOxIp5DxsKf1Mlm8rgJtNY6MIf0WGP34qX2h52Ek/lr1UphrE9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713866515; c=relaxed/simple;
	bh=dcXbMxuE/tABSUjCypgQi/OO1/z4/yFSUvAZnJO/+kw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QNJN8BgP690mvBI6ChDEmBy0ApOtRwLRI38Ixt9r6+uVjF0+murBcBVWmdvsro71TXFlplziBgckK7WjZrbOrat0OqGLnEZ7BFyJnbAOephZJF9B1Pso3e8xljV6wuJUDKoAqKW/oEupYKQrvOcTuI+9OdjmIIm/aCfZIUviO1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GhHVZ5ZA; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E57C91C0003;
	Tue, 23 Apr 2024 10:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713866509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kGNLEQi4vjLPM4/+K8lcB+bqcRv9SUQX2PQJaBnW2l0=;
	b=GhHVZ5ZA4maacHUrY5LlPBRHRa83rkSGLklZkRpZM6NF8c634ZZY8qVk5/DmO5oSNpre8k
	Ufazmo1CO5N5inq10XLSDMBWMz7p8yRPa8uduyLqWzNeq8hSw1Ks7ra/Cytui6i2njQh5Z
	SfAb5arq1yAzO2hytaNQHQ7L+9YK3bIsRLIUNHl+d+sPz9QXqfjEDFblYTN/eTfT/vrAWC
	dd2Et2R9dhdbDl0YLRpDBDV1u3GrgLHXc2j/yYoSoadqsHHmePs7BsJ8EU7/t6UPnG8+ap
	SvQTHjnbanBtnJwtsUMXHZO0+NktIy3CdS+VM3JUZLphPfGkWQxD3Tt/VYzG6g==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 23 Apr 2024 12:01:41 +0200
Subject: [PATCH v4 2/6] spi: cadence-qspi: add no-IRQ mode to indirect
 reads
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-cdns-qspi-mbly-v4-2-3d2a7b535ad0@bootlin.com>
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
index 5a83940220a9..a82e23526a6f 100644
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


