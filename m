Return-Path: <linux-kernel+bounces-97374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE20D8769AF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF46B1C20CDE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E4A5E084;
	Fri,  8 Mar 2024 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Z0eJ2djL"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416E656473;
	Fri,  8 Mar 2024 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918311; cv=none; b=TFnCS+3CGq8yn9weCwgjPhKsJ35xmUABumF6AHw/KbqePi3TN6RdtUVfdC8WMb47zYmm3CDtMBuwsyHQwXdA1KTQpGHAEVuZrhQZbI+chaq6vfOKl0+dbeS7nn8rMkbGIa5b7zzVeo9PxU7GsvzF7BzLp4Rw4tegtt8VPikA9b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918311; c=relaxed/simple;
	bh=M9X2TXlu0Zd1vsp9mlncE7tOEu3zaByCOibyclsjtko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J+MfcuZb2TNrHqEyEITGRl7uLOTEFEV52KazhsX922TdymSij5soS5HQ+sYIbNfRUzIrPS3RJzgBO1hVmkSZYMlfAYY5dKqxm90AlbAJ8wE2DXddEIErj9i3xfCBtLOpOup5qzz2RyCtywvvEVLTaRoIaocCreI3H4+HbDv3NSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Z0eJ2djL; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A85F4C000B;
	Fri,  8 Mar 2024 17:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709918302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6miKRXN1WuQxZt8v8O82Gej5zMYl19Jf0WHTTc8pDtQ=;
	b=Z0eJ2djL/tGY3KS/eUjK/7fhC3Fz726SexT0tMJ9i1AZAHmQ21UG3Y+8ieG3sDhNIGJyKp
	umYdWzHGKKU1caWTQTrVq/UvnFrgwHz0ik+9XOLHpoPQX+DovUFY9sqqx9adeKu3VkT8FU
	jDdUvCosL6DDHdBThi5MzkZcfwJ1pN7qSb9Vfor8I/FPNinHnAhYATTnsj2beNeSv8M8xp
	LghlihkzDe5ECKXoBpv5MC+aqRmfBT0iTCRQsNKQMSk80gLD5DT9oMTpfY9rnjZGn3eRz9
	hN6sLAuRtkbMgdXTFcR84IHDBzhzyOFrs5ET+jF3KylC53gSO9gj+eDo4rOzXA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 08 Mar 2024 18:18:22 +0100
Subject: [PATCH 07/11] spi: cadence-qspi: add no-IRQ mode to indirect reads
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240308-cdns-qspi-mbly-v1-7-a503856dd205@bootlin.com>
References: <20240308-cdns-qspi-mbly-v1-0-a503856dd205@bootlin.com>
In-Reply-To: <20240308-cdns-qspi-mbly-v1-0-a503856dd205@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
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
index 0fc452bab0ee..973ea4edbe3a 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -43,6 +43,7 @@ static_assert(CQSPI_MAX_CHIPSELECT <= SPI_CS_CNT_MAX);
 #define CQSPI_SLOW_SRAM		BIT(4)
 #define CQSPI_NEEDS_APB_AHB_HAZARD_WAR	BIT(5)
 #define CQSPI_DETECT_FIFO_DEPTH		BIT(6)
+#define CQSPI_RD_NO_IRQ			BIT(7)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -703,6 +704,7 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 				       const size_t n_rx)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
+	bool use_irq = !(cqspi->ddata && cqspi->ddata->quirks & CQSPI_RD_NO_IRQ);
 	struct device *dev = &cqspi->pdev->dev;
 	void __iomem *reg_base = cqspi->iobase;
 	void __iomem *ahb_base = cqspi->ahb_base;
@@ -726,17 +728,20 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
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
 
@@ -778,7 +783,7 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 			bytes_to_read = cqspi_get_rd_sram_level(cqspi);
 		}
 
-		if (remaining > 0) {
+		if (use_irq && remaining > 0) {
 			reinit_completion(&cqspi->transfer_complete);
 			if (cqspi->slow_sram)
 				writel(CQSPI_REG_IRQ_WATERMARK, reg_base + CQSPI_REG_IRQMASK);

-- 
2.44.0


