Return-Path: <linux-kernel+bounces-76297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F04DA85F55C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91438B21C61
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFD939FDA;
	Thu, 22 Feb 2024 10:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SqGH+qEE"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB0239876;
	Thu, 22 Feb 2024 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708596757; cv=none; b=o9ubogkRHDnhyXDaoSRaFVTQmBX7FcFF9pJY8xRo9xnmFrrNOzU8TQpc3o4DGegSAp2zeF9V/pxzguRhWjJuAb/f9jAkvEtPHNRzPgydEgtEvvs4mPpT4f/YymjHixi3sO821RUI0tZUSDBO/IN2UZi5RhO6zEqaAWUP8eJWhgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708596757; c=relaxed/simple;
	bh=phqB6EsMKmMZCxST51NEKAHp04XCYXDRfwNdDc4qp3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DYnaqOZOAvLvuUlitX1JKj3TiYcL4RQHyBaiRc52+BK8ocvg9RTFLAfo2VP5if7M++RVNAb9NdHfeVxws6m6hf8P9EOMMxYa/P0hwKaJVzoSCINFVu2KjjN66SZ1O/9LX3qPHc6p/z6XjbDQtoOMEmXFALNPkTiTGByr2ePlOeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SqGH+qEE; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5239320013;
	Thu, 22 Feb 2024 10:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708596752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eg97yjO7KdqvwAZXBVokHmZiB+7Ptk8zlKT2d8Y1vCs=;
	b=SqGH+qEEI2ulAOG8ee55jdUpIZiKanKdcg3SxLMP34ZEIL0BtCd4sBiOQU0Tra3JQhnFbD
	PjaMzsqcC5FdcQLbQ1pRoYgt1dX9lmG3fW1z3HZA6RCI7cdsAyKv34zCRGJyygK7L7bHDU
	wHeAzwYBq7D5Ai1cGs2XeLRjFA3KNFQpdfTAwozXeWoVAKiiXwRFT8DruAPifaj8DnSaWH
	kIZtV8CZtGFTG6rdP35efOOTIaSsysvUDaze0bdkXfkk+/TdBUzlksUi4/nPjECEpa0sMu
	+y18tn4dI5IPHVHkGrJYbNgXrhEXrCb6SJBVN7L3O6jcrVk/x5Pd5EUs3gCYeg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Thu, 22 Feb 2024 11:12:32 +0100
Subject: [PATCH v4 4/4] spi: cadence-qspi: add system-wide suspend and
 resume callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240222-cdns-qspi-pm-fix-v4-4-6b6af8bcbf59@bootlin.com>
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
index ee14965142ba..8bcbab90cb75 100644
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
+	RUNTIME_PM_OPS(cqspi_runtime_suspend, cqspi_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(cqspi_suspend, cqspi_resume)
+};
 
 static const struct cqspi_driver_platdata cdns_qspi = {
 	.quirks = CQSPI_DISABLE_DAC_MODE,

-- 
2.43.2


