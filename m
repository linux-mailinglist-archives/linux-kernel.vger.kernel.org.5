Return-Path: <linux-kernel+bounces-76301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DED685F563
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3600CB26E9A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C5A3EA8D;
	Thu, 22 Feb 2024 10:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="C12geg+A"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA8A39864;
	Thu, 22 Feb 2024 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708596759; cv=none; b=tATfKLumMEmykV4X8GNmo82jpVup/qIjG2osBe18wncspJoLWVycbxDT9ENVW4kkT4U70qq1BOFCpQ6+j9uN5CRXJQYaFy2rAqDHDbVcb4GOV7yOBfwMc3AVrx4vqway/9J0vcv0JJo7TQV2/aa5YpxytT39a0BxP4v8DDMumv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708596759; c=relaxed/simple;
	bh=pM5LYZyHZMUxJj8CsXE8e5NI/BUXEphnfuI4iyKBZ3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MEWqwmOO+CcbX9N4TRwdS4GBD2VVRm/in+yc63gtHBjzxyq7bH+p+Grg4uVZP/kP0gbzwYym3yezMsQ1k55rmQSm0+HFWuP6+Cji/6CtCwjc6MHNTb+I8irOvt1f/rzzH8RE9tVcdaILQGhZXiVjN61pdMQR0ChbkzmOE8X7NkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=C12geg+A; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CC85B20004;
	Thu, 22 Feb 2024 10:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708596751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PYyfGG5F+SG8R9R5MyMBf2L1QHcp8qaW343NfMmdTxo=;
	b=C12geg+ATDXZAWApHIm+FM8jNWV2pVTmU59v+gb3sVRSDhDlvErRLgwTh0Uv8UIkhVzs+4
	YnDYb5yCVWElbCaz7tP4LNhgwfa6O9ppsCMqWnUeC0qzFiLGe5GeclDxvWjnUtXKHFe9Gl
	dmG5QRnAoXHR1Z1vShl8oobqr5esxgh4PL2vEdTigvUqGbM58T7eZL0SptBIYTPZ87qQMJ
	5fukdbCBjFHL3amwiG2kEZ/AZ2zb29hi8EEfwJMKvvqfcQy7sV81sGECuUB9LJRKR9IbuK
	Rj5Bsvn2QVdXVG6mcnO2EMKOAgdxhs15vkdxAQ1z/DtH0wGrGkkIZbXkfDESLg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Thu, 22 Feb 2024 11:12:29 +0100
Subject: [PATCH v4 1/4] spi: cadence-qspi: fix pointer reference in runtime
 PM hooks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240222-cdns-qspi-pm-fix-v4-1-6b6af8bcbf59@bootlin.com>
References: <20240222-cdns-qspi-pm-fix-v4-0-6b6af8bcbf59@bootlin.com>
In-Reply-To: <20240222-cdns-qspi-pm-fix-v4-0-6b6af8bcbf59@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Apurva Nandan <a-nandan@ti.com>, 
 Dhruva Gole <d-gole@ti.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

dev_get_drvdata() gets used to acquire the pointer to cqspi and the SPI
controller. Neither embed the other; this lead to memory corruption.

On a given platform (Mobileye EyeQ5) the memory corruption is hidden
inside cqspi->f_pdata. Also, this uninitialised memory is used as a
mutex (ctlr->bus_lock_mutex) by spi_controller_suspend().

Fixes: 2087e85bb66e ("spi: cadence-quadspi: fix suspend-resume implementations")
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 74647dfcb86c..d19ba024c80b 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1930,10 +1930,9 @@ static void cqspi_remove(struct platform_device *pdev)
 static int cqspi_suspend(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
-	struct spi_controller *host = dev_get_drvdata(dev);
 	int ret;
 
-	ret = spi_controller_suspend(host);
+	ret = spi_controller_suspend(cqspi->host);
 	cqspi_controller_enable(cqspi, 0);
 
 	clk_disable_unprepare(cqspi->clk);
@@ -1944,7 +1943,6 @@ static int cqspi_suspend(struct device *dev)
 static int cqspi_resume(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
-	struct spi_controller *host = dev_get_drvdata(dev);
 
 	clk_prepare_enable(cqspi->clk);
 	cqspi_wait_idle(cqspi);
@@ -1953,7 +1951,7 @@ static int cqspi_resume(struct device *dev)
 	cqspi->current_cs = -1;
 	cqspi->sclk = 0;
 
-	return spi_controller_resume(host);
+	return spi_controller_resume(cqspi->host);
 }
 
 static DEFINE_RUNTIME_DEV_PM_OPS(cqspi_dev_pm_ops, cqspi_suspend,

-- 
2.43.2


