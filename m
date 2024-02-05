Return-Path: <linux-kernel+bounces-52860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1865849D85
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00A7F1C22436
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897FA2E64B;
	Mon,  5 Feb 2024 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IhfWuC8q"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952DE2D057;
	Mon,  5 Feb 2024 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707145060; cv=none; b=qXJUT26VLg0UB3YW/CSJ+2hQVDdOZz/wVurkB93XLCe+oFrTYpA48+P+f0RRycM/KIp03dKrMHyiMo57SGTIVyiqPE+PjOL7w3lo0olMZpFt0Up3tLEE7czt7kg8WzANdXAhegem1JuhPImC17MIDhKcvVN/DXSTe9AtAKxfmxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707145060; c=relaxed/simple;
	bh=m2XZhlLpN5aSeXbQFhpV8z4QLndJRWw0770SYgQStq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vFx/QnHJ7TjFZ/2YDCfUkBFsh5QrTgJLH72+n+xfUXgwjr8kf57Ldtg7Kh2ecQTe9bLR69KfNByMBwPIarMQGsLYh2kdo7ZzowbIeabwu62vgulkGe6raWudhVTN5NB/44f2sxO1FFWKTSxPL7O/UkPHpss+Usx1PkPfs6nH/6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IhfWuC8q; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 94ED420009;
	Mon,  5 Feb 2024 14:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707145051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ntIK1ht2V349W+UW4Kgf9LtLhGBVrs1jWnKGiUHScxQ=;
	b=IhfWuC8q4u6WUe40Tu3HdIb9eC+23NaBw2fa8E8ZkR95N4i6/92BYQnv16mbFY+POXRE7a
	HM9r2xsQYeyZtgcWioLVLSKdTXGVqsz6nhffaj3k4ASSg19LH6R0QqqP8CE8/d0nxXfCai
	rsnhsoL0Jlm8O/odgSbs4SgTLdr9FrjqYo2KlIIFsElR9fo73b/Q3kuR6cNXkacj4enVut
	2cVxm8P/5hkg6iBxM+G6Q0EdpKd8L6VQRR8/OtyeUgjQEwpqRyxH47TdmYgXke8+1QMD+6
	cXelRmn2HOHknzS3GkbUT3Il/uOOCFaWL1mLYNpXuw3w3bgndfgRmB57ENbr8w==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Mon, 05 Feb 2024 15:57:29 +0100
Subject: [PATCH v2 1/4] spi: cadence-qspi: put runtime in runtime PM hooks
 names
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240205-cdns-qspi-pm-fix-v2-1-2e7bbad49a46@bootlin.com>
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

Follow kernel naming convention with regards to power-management
callback function names.

The convention in the kernel is:
 - prefix_suspend means the system-wide suspend callback;
 - prefix_runtime_suspend means the runtime PM suspend callback.
The same applies to resume callbacks.

Fixes: 0578a6dbfe75 ("spi: spi-cadence-quadspi: add runtime pm support")
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 74647dfcb86c..720b28d2980c 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1927,7 +1927,7 @@ static void cqspi_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
-static int cqspi_suspend(struct device *dev)
+static int cqspi_runtime_suspend(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
 	struct spi_controller *host = dev_get_drvdata(dev);
@@ -1941,7 +1941,7 @@ static int cqspi_suspend(struct device *dev)
 	return ret;
 }
 
-static int cqspi_resume(struct device *dev)
+static int cqspi_runtime_resume(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
 	struct spi_controller *host = dev_get_drvdata(dev);
@@ -1956,8 +1956,8 @@ static int cqspi_resume(struct device *dev)
 	return spi_controller_resume(host);
 }
 
-static DEFINE_RUNTIME_DEV_PM_OPS(cqspi_dev_pm_ops, cqspi_suspend,
-				 cqspi_resume, NULL);
+static DEFINE_RUNTIME_DEV_PM_OPS(cqspi_dev_pm_ops, cqspi_runtime_suspend,
+				 cqspi_runtime_resume, NULL);
 
 static const struct cqspi_driver_platdata cdns_qspi = {
 	.quirks = CQSPI_DISABLE_DAC_MODE,

-- 
2.43.0


