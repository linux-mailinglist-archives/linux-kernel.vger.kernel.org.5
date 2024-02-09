Return-Path: <linux-kernel+bounces-59391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C1584F63B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7376E283488
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297F94D5B0;
	Fri,  9 Feb 2024 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PVJ6UVBC"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A45A4D11A;
	Fri,  9 Feb 2024 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707486974; cv=none; b=RXD7Th3oDXBDmyzya9BSxjnQ9xooR3yDRHDGDh3BmMTdn/K3x5+9HP0zfAqsOvGv0UEWHnEVV+LwwoFs3mbTQlA89Zt/D1T1/cyd+oAtaFr/9uvGr5MoJpu7DbRDbkz9fW+HIPfEwYqvG4nqZNR3w10v4GKY4P0McSFLFbn9Frw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707486974; c=relaxed/simple;
	bh=Y7H7/t7uj8gApP1bpHRilwd85LT3J++X+h8HBhu5qUE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ek8llW/pZ/KSwL83zvF+1TC0Ss3JEnjO+THVMFrOM4qGwRCJEYmhsJIyQTKKtzgijtGXZdIkDexhmyA2DKyvCbtuKOhTp26H1yXkEjYHHowmb9jhTV+OGoaLwbawEi9qqNB7giQgoNUW03fxc4yE/ZReir+SkmbyzfkmMJjAl1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PVJ6UVBC; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 527851BF206;
	Fri,  9 Feb 2024 13:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707486965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=edgfHyClH8frjqdW176guaeqRWtXQmQVgxIX7uID0gk=;
	b=PVJ6UVBC5ChpcMt8ptcINE+fuPY2TiGagSVF3uJU2+QddUP1LeGL0w4FRb0pFUOhCqjhWt
	bjTOPdW5gB2RI7SoAMoMMSFemuA+eq9D6Ni8zaFWqMYZv160/NbcUhG/iB+r0tRoEq03RC
	D2hn4hgqH4ySbdIC16GGjFM4Fhm21rY4sBESzpWBc9HNfTwg1KSzEV1lZ+7qaPXEBTe2tl
	FO1ODI4CnMP18TPzLgtz6GDqBebIKxwMzzkSaO/YfspkG7U+HrSaTCbJKVYdbD5ksmb2qQ
	DqxZU2j52LoFPPQFX7IDiVc/Z9XDnYrZuvPmWWZX+u9I6jXZbTe0aEHfdWSNuQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 09 Feb 2024 14:55:50 +0100
Subject: [PATCH v3 1/4] spi: cadence-qspi: fix pointer reference in runtime
 PM hooks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240209-cdns-qspi-pm-fix-v3-1-540ac222f26b@bootlin.com>
References: <20240209-cdns-qspi-pm-fix-v3-0-540ac222f26b@bootlin.com>
In-Reply-To: <20240209-cdns-qspi-pm-fix-v3-0-540ac222f26b@bootlin.com>
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
2.43.0


