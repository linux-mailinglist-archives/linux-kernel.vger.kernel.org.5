Return-Path: <linux-kernel+bounces-97369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BC7876995
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4967F1F22E3B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300A35A0E9;
	Fri,  8 Mar 2024 17:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SG1Wv8Ep"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881B028DA5;
	Fri,  8 Mar 2024 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918310; cv=none; b=ImKjzHkrFaqNfzJvOst1LLc1wYzEYXWDIgf5eO6iWsu+KJk1WJ2LFJof2Rs0rRYJ+9PK0bpo14Ahw8yJRz0yIMBsaxBzcoGaTtTsuHfUgiihlfqhn3Zhs9UNOF0QHxEXe8nckAr8KFdOIWFF1AjEJIf+paVAL6b3rKTxIPJXw0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918310; c=relaxed/simple;
	bh=VXeunZ5N76jlGdhugZbRm6cy1XlnU0cXgDgDsneqnKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZUgxF/5I/EUj4k9GY9hSuo+JWKxnFykG56d6Olm5z6Rhsm0ck3aWoH2B22M1JG8NlBuuNYn1j3H61oKwnAzPB3OEvgcKSjobU3C7HKP1Q1CN6ZSthfcTTDN25mWErOiFAkO8YDWFuR7TI65Wos+5p48r1Dvx9rEFIsxe6LajJN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SG1Wv8Ep; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DCA88C0008;
	Fri,  8 Mar 2024 17:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709918300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7P82CvPIyWzjYW3qcslrXHP+TE4Er05uK/MYjNOvvnk=;
	b=SG1Wv8EpNFPpbrhFxsXJRIte9ZXfor+k+zdFyVM0jC7gFmO2B2W9RTrX0ZsUJDKPDnAIJJ
	D0cFP3mi/3KPmD16bnOO9B9lyd7YyM/M0+loBj8ToysxNO8bxE6mMmEvjP2LA5s0d4qkRw
	BtwCTGbXpzKppr2E+4V7OYDrH56hY1X3wlCqY9Ijeky0v1bUVoXXUMIfSLQJJnvmnSbmuL
	dNH8USCxy/dezHiVjPj/9SMZF/uRaXKHCrHA8DRQI4O/gur41plVmX5tgWzBq15PGMD752
	HE6Y8WAXmwVow0DKDBmxM+B0jDPwbpmoY5rE+IjJ2fqGJQ0u5RqoStsTbf7q7Q==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 08 Mar 2024 18:18:19 +0100
Subject: [PATCH 04/11] spi: cadence-qspi: store device data pointer in
 private struct
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240308-cdns-qspi-mbly-v1-4-a503856dd205@bootlin.com>
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

Avoid of_device_get_match_data() call on each IRQ and each read
operation. Store pointer in `struct cqspi_st` device instance.

End-to-end performance measurements improve with this patch. On a given
octal flash, reading 235M over UBIFS is ~3.4% faster. During that read,
the average cqspi_exec_mem_op() call goes from 85.4µs to 80.7µs
according to ftrace. The worst case goes from 622.4µs to 615.2µs.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 266a5d5dcfaf..02a80745fa6d 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -102,6 +102,8 @@ struct cqspi_st {
 	bool			apb_ahb_hazard;
 
 	bool			is_jh7110; /* Flag for StarFive JH7110 SoC */
+
+	const struct cqspi_driver_platdata *ddata;
 };
 
 struct cqspi_driver_platdata {
@@ -334,11 +336,8 @@ static u32 cqspi_get_versal_dma_status(struct cqspi_st *cqspi)
 static irqreturn_t cqspi_irq_handler(int this_irq, void *dev)
 {
 	struct cqspi_st *cqspi = dev;
+	const struct cqspi_driver_platdata *ddata = cqspi->ddata;
 	unsigned int irq_status;
-	struct device *device = &cqspi->pdev->dev;
-	const struct cqspi_driver_platdata *ddata;
-
-	ddata = of_device_get_match_data(device);
 
 	/* Read interrupt status */
 	irq_status = readl(cqspi->iobase + CQSPI_REG_IRQSTATUS);
@@ -1358,16 +1357,13 @@ static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
 			  const struct spi_mem_op *op)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
-	struct device *dev = &cqspi->pdev->dev;
-	const struct cqspi_driver_platdata *ddata;
+	const struct cqspi_driver_platdata *ddata = cqspi->ddata;
 	loff_t from = op->addr.val;
 	size_t len = op->data.nbytes;
 	u_char *buf = op->data.buf.in;
 	u64 dma_align = (u64)(uintptr_t)buf;
 	int ret;
 
-	ddata = of_device_get_match_data(dev);
-
 	ret = cqspi_read_setup(f_pdata, op);
 	if (ret)
 		return ret;
@@ -1823,7 +1819,8 @@ static int cqspi_probe(struct platform_device *pdev)
 	/* write completion is supported by default */
 	cqspi->wr_completion = true;
 
-	ddata  = of_device_get_match_data(dev);
+	ddata = of_device_get_match_data(dev);
+	cqspi->ddata = ddata;
 	if (ddata) {
 		if (ddata->quirks & CQSPI_NEEDS_WR_DELAY)
 			cqspi->wr_delay = 50 * DIV_ROUND_UP(NSEC_PER_SEC,

-- 
2.44.0


