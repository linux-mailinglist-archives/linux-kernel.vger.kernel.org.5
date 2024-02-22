Return-Path: <linux-kernel+bounces-76298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 882D085F55F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433D4282115
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450223A278;
	Thu, 22 Feb 2024 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dfvMuerq"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D7339860;
	Thu, 22 Feb 2024 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708596757; cv=none; b=h8XEHn9H9La0mCP44P+yPVIinV6ZAZpHnME0kTPWHKq5t4vEctw2X4lrdwYI8VTdt6EevBStqf/pNZNVBZjeC897SNDLkVn2mi6zFgjT4UxSERX93fqv+A9IZhxnj7ejCVU4CmxyrYUTbfVYXD/wuiWoZuCY78GGTKXjctHyIpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708596757; c=relaxed/simple;
	bh=8k//nV4PgtS77JaVQHMDyRcyJk3UctPeuulRegs63Dc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ddiEmeT+Sknx5JCsSrCB/zCna/jkTL0wV5E+LJH79pjjTQxBu5QfcIS0x9MnVGFvfVHjrNkF2hRKGQIUKr5MH5Xlcfh8Grzrz043KYJ1k32YJdXUNHWpAHhvUiFPiLiitUrViSH6ZRtyUrV1k3kn0H+TaCSyM1wzcGeUYw6taqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dfvMuerq; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CA9D820003;
	Thu, 22 Feb 2024 10:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708596752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mvoigvJmPhizIcq2GVnu6+m2ifoXHPhDFh2hNqMqK4E=;
	b=dfvMuerqqH9Msxa66Jb04Loi05gLrfXlH4U7nG19LWMspJ5RZrc+/RIIDj84N+4ipp5HxA
	SvbJjT+cIwSjxXVEmKiWLUwUrxwMG0QCa97fPqjItYJ1NiD00/5QzrXPy4VXuADVvyyjKa
	KBwIFDs9m7ih7V5mGBnnHmSdtIyto1jWVesTlXtCwPKtwN6kLVS8CYD7OeSWpZ6ctVBbkA
	dUAOinAR2lXOA4OL7ZswXSsYKV3EY8784LKdMjCmC9e51kFNJonrI0JNyu8t5B+mMcT4op
	tfFYOpMHrIEpM9h2Y5861K/Qrm3s8KtsrF0oiiJ0RjqsiYOLNRr1zDezYq6fAA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Thu, 22 Feb 2024 11:12:31 +0100
Subject: [PATCH v4 3/4] spi: cadence-qspi: put runtime in runtime PM hooks
 names
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240222-cdns-qspi-pm-fix-v4-3-6b6af8bcbf59@bootlin.com>
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

Follow kernel naming convention with regards to power-management
callback function names.

The convention in the kernel is:
 - prefix_suspend means the system-wide suspend callback;
 - prefix_runtime_suspend means the runtime PM suspend callback.
The same applies to resume callbacks.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 809bbbb876ad..ee14965142ba 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1927,7 +1927,7 @@ static void cqspi_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
-static int cqspi_suspend(struct device *dev)
+static int cqspi_runtime_suspend(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
 
@@ -1936,7 +1936,7 @@ static int cqspi_suspend(struct device *dev)
 	return 0;
 }
 
-static int cqspi_resume(struct device *dev)
+static int cqspi_runtime_resume(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
 
@@ -1949,8 +1949,8 @@ static int cqspi_resume(struct device *dev)
 	return 0;
 }
 
-static DEFINE_RUNTIME_DEV_PM_OPS(cqspi_dev_pm_ops, cqspi_suspend,
-				 cqspi_resume, NULL);
+static DEFINE_RUNTIME_DEV_PM_OPS(cqspi_dev_pm_ops, cqspi_runtime_suspend,
+				 cqspi_runtime_resume, NULL);
 
 static const struct cqspi_driver_platdata cdns_qspi = {
 	.quirks = CQSPI_DISABLE_DAC_MODE,

-- 
2.43.2


