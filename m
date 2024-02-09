Return-Path: <linux-kernel+bounces-59393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC33484F63F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1631F25D1A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E6D4EB29;
	Fri,  9 Feb 2024 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jzWFemig"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C67A4D135;
	Fri,  9 Feb 2024 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707486976; cv=none; b=T8uHrgxDEbMdQerTVl7NsO6NjHtFlAFnlJFyfj1CcmJwrreZji5yDFFyM8eGkIIj9KnJPt/m4oCoSQpB3WROAivFZ0aDFaZ65aLxUL/J5j0ePZQNzkJEAdU8eZjVDE6E4lni2Gpp7fPTRT3+OWBbTYdnyvEDffaJ0LDb3tWpvZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707486976; c=relaxed/simple;
	bh=cstpzce+J+7b1urmkwA3P0JVejglpP3nSE1z8JR3RxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O9rrIz4bzKLEq1Eczh0lDGs4PCkLnnRHWHjJxaczPjXVwvbJJ7rpoAAvLwTjdUZlIwK8HQoTvTf6Klri6WnQ6Lxgwv8c3WNPDrGI3IGiWyt4OENKChcn22RlpDxJas2KgaBysxazBwCAF8KjQjZWVnafgpLe/2g1hudVM2a0KkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jzWFemig; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D3D5F1BF20E;
	Fri,  9 Feb 2024 13:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707486967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RqketI7LTDXTpTwWPnxjrx3WSm2BtW9HamRjcUb4AQk=;
	b=jzWFemigIBN7tkr2IC/YavhPwPGsVSUWlXGPvdXKNdRDGHcLAKcnSS+n7JY+e7eFS0u5bY
	89OPpQ9TxcURK7NssrfPQ/TkCsNmqMc5c9hVljDKS9N9upPZFMVLb8sfbo49mMDSuqoDv3
	pbYb5civJ76rq2a8LtiSXC5oGPONX2Hity5DSJxBJM/xxARh9+VTqGy86dVwa96xby5KSx
	VEsJayEtd0xaP4fuH3CktvM8WSKc87UPY2Igo7MHccdW0pCqtK9L3bxQDz4RQoOlPvBg4d
	nXaDeFPX+frH581MyBvxGxEDza7nKxeDaF2z+rDkTx8NdPgbYGH61BRNx2z94g==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 09 Feb 2024 14:55:53 +0100
Subject: [PATCH v3 4/4] spi: cadence-qspi: add system-wide suspend and
 resume callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240209-cdns-qspi-pm-fix-v3-4-540ac222f26b@bootlin.com>
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

Each SPI controller is expected to call the spi_controller_suspend() and
spi_controller_resume() callbacks at system-wide suspend and resume.

It (1) handles the kthread worker for queued controllers and (2) marks
the controller as suspended to have spi_sync() fail while the
controller is unavailable.

Those two operations do not require the controller to be active, we do
not need to increment the runtime PM usage counter.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index ee14965142ba..f976681187b0 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1949,8 +1949,24 @@ static int cqspi_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static DEFINE_RUNTIME_DEV_PM_OPS(cqspi_dev_pm_ops, cqspi_runtime_suspend,
-				 cqspi_runtime_resume, NULL);
+static int cqspi_suspend(struct device *dev)
+{
+	struct cqspi_st *cqspi = dev_get_drvdata(dev);
+
+	return spi_controller_suspend(cqspi->host);
+}
+
+static int cqspi_resume(struct device *dev)
+{
+	struct cqspi_st *cqspi = dev_get_drvdata(dev);
+
+	return spi_controller_resume(cqspi->host);
+}
+
+static const struct dev_pm_ops cqspi_dev_pm_ops = {
+	SET_RUNTIME_PM_OPS(cqspi_runtime_suspend, cqspi_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(cqspi_suspend, cqspi_resume)
+};
 
 static const struct cqspi_driver_platdata cdns_qspi = {
 	.quirks = CQSPI_DISABLE_DAC_MODE,

-- 
2.43.0


