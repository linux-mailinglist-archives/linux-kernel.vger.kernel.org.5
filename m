Return-Path: <linux-kernel+bounces-133207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B2789A086
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38E01F21983
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6FD171063;
	Fri,  5 Apr 2024 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dobKdTLP"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ED916F82C;
	Fri,  5 Apr 2024 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329342; cv=none; b=TXKyPB7/QuOE/atxI48EF8Qt6UcfCMUbdyKc9EurxxemP28Ts/BrDn/OvDrk5xuCT+i9B9YRxBAunpXp7pt/7FK5ZgqGwYfhBlvWjlyTEkNH0R3k+p0GtmF/gGHKyP/NlDO7TIK6mAaC+v2IOHil/sSNskgKiFiHqE8rGzBysaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329342; c=relaxed/simple;
	bh=Wj+u6ruHBUJBotyvFJYd7sZqwOLVa4pj2XBfnuzmF2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LVRBAvL3j4QImOccVuoMTX4AB61MXmUDSfQCiliISACcVtUmicSt8gpVVHvdXcDaNWsU6FN1psK5iZDAL3tlwGceDw2276VNE3n1J/dR742ppvPWPi2qlvNG7FucpE/yIqFZYP/6nicghWa/X4QUOou0MyWYLPsuHhy1RzBqmBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dobKdTLP; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7BA2B1BF218;
	Fri,  5 Apr 2024 15:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712329338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7awS6QTNvJz7vJeE9+3leQq2yx+aHNtkDKIF/ROzt+4=;
	b=dobKdTLPQjLIMKUvRLnHzRmMrgSKTHGfMdCEtwANB1e3DW61caDvZtIgetPR9oi9Oxdnkf
	24HwyB/UPNnNz/J5N3cu8hwqBoEm5JjJDpYLju5ek1Qni5r2VcIyMwH9UwjeVf/YIt1mBn
	Amt4sNLwroPO5GhZAe0jZPlSa3wLk7XWm0A43kek/MRay7b8TlXyYTpGatrZK2p0jnwZkh
	qaPe002zM8fWRFW1kClhy/7uKx4X7HSugVB5FJ9dO0PoaUrGO91OoNKdREGX1GrHhhfeUJ
	6i9KtRunvESZjKrFVOFFzQYE6IbH6DltHW4S8UzCn7lY1UOi0dExM7eg0p/weg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 05 Apr 2024 17:02:14 +0200
Subject: [PATCH v2 04/11] spi: cadence-qspi: store device data pointer in
 private struct
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240405-cdns-qspi-mbly-v2-4-956679866d6d@bootlin.com>
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
index 350b3dab3a05..abc1c35929cc 100644
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
@@ -1822,7 +1818,8 @@ static int cqspi_probe(struct platform_device *pdev)
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


