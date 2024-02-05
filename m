Return-Path: <linux-kernel+bounces-52859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082E2849D84
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6889DB25D96
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480AD2E62D;
	Mon,  5 Feb 2024 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kzvfDQtO"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952B62D054;
	Mon,  5 Feb 2024 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707145060; cv=none; b=Zv2iQPlV8PLLWiFmoRFe57m9Crc+/qV8o1t0WwYB2O+L8FF93u0UQFORuTh2vg6Ox0rT8zOsizJj4bVRpRsJnVWYb5Ql+qItMFS7I96UAKHEo2oLsAisQ/b46BZkRT4NtdCEMVgLnYI+Ns9LVaIeQAgJ6t+KOEYDA8j9G55Xhao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707145060; c=relaxed/simple;
	bh=0TIv8do25e/uL4lq4tvg5O/ua8nIaVhna6ZlQbpAaHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uGV6t7EhyxX+9lMe5pJXlahf3UFHb91EMBbZc2gdFbGUe517ppWH27/JEEqEFU9Ie2Jlk1y3RTmZ7hd6VYbju1hk1rVi7xnYzZ5B19P+Ey+rQqecslkhbR9d13GvbXe3B7UCQvHJKcf7l8ZdgPv1BP9gXxvntVeF3962P9w/VEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kzvfDQtO; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1A9F520010;
	Mon,  5 Feb 2024 14:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707145051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2dW3YRsN3P/j/sY75FzxRXD8f2o0gC9+4GEJkf/Bos8=;
	b=kzvfDQtOo6/Vma01SnlkXEt4R6RXIKcub5Z85ty5eZbHB0g6f9mzimhgyVoHvWrCDc7zbM
	YItcz0fwfImmnCPXLr0oIDtX/U6+IA2c0kHG7LsSQKVlWbnPJvWQXGBuuduTmS2CK5Myb5
	ZIBf0iK0vFyzq5qLqDEBOpyQPaUk8PJYytpQcruA+ZZ93JhCakpb6Ufq6p9WpJ9CQprqBC
	w4uUCIkS2JH0TwJBYOV/+pMiNlH8dqvn1zyef/m3MTMtTLazqch+oX3U7IfzerLYp4YnaZ
	vArJcemC99BrioYouxkSHzLR6JJzYHflxI4/0bDdUNRc4TbS4FSu1P6tTCtV4Q==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Mon, 05 Feb 2024 15:57:30 +0100
Subject: [PATCH v2 2/4] spi: cadence-qspi: fix pointer reference in runtime
 PM hooks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240205-cdns-qspi-pm-fix-v2-2-2e7bbad49a46@bootlin.com>
References: <20240205-cdns-qspi-pm-fix-v2-0-2e7bbad49a46@bootlin.com>
In-Reply-To: <20240205-cdns-qspi-pm-fix-v2-0-2e7bbad49a46@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Apurva Nandan <a-nandan@ti.com>, 
 Dhruva Gole <d-gole@ti.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

dev_get_drvdata() gets used to acquire the pointer to cqspi and the SPI
controller. Neither embed the other; this lead to memory corruption.

On a given platform (Mobileye EyeQ5) the memory corruption is hidden
inside cqspi->f_pdata. Also, this uninitialised memory is used as a
mutex (ctlr->bus_lock_mutex) by spi_controller_suspend().

Fixes: 2087e85bb66e ("spi: cadence-quadspi: fix suspend-resume implementations")
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 720b28d2980c..1a27987638f0 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1930,10 +1930,9 @@ static void cqspi_remove(struct platform_device *pdev)
 static int cqspi_runtime_suspend(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
-	struct spi_controller *host = dev_get_drvdata(dev);
 	int ret;
 
-	ret = spi_controller_suspend(host);
+	ret = spi_controller_suspend(cqspi->host);
 	cqspi_controller_enable(cqspi, 0);
 
 	clk_disable_unprepare(cqspi->clk);
@@ -1944,7 +1943,6 @@ static int cqspi_runtime_suspend(struct device *dev)
 static int cqspi_runtime_resume(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
-	struct spi_controller *host = dev_get_drvdata(dev);
 
 	clk_prepare_enable(cqspi->clk);
 	cqspi_wait_idle(cqspi);
@@ -1953,7 +1951,7 @@ static int cqspi_runtime_resume(struct device *dev)
 	cqspi->current_cs = -1;
 	cqspi->sclk = 0;
 
-	return spi_controller_resume(host);
+	return spi_controller_resume(cqspi->host);
 }
 
 static DEFINE_RUNTIME_DEV_PM_OPS(cqspi_dev_pm_ops, cqspi_runtime_suspend,

-- 
2.43.0


