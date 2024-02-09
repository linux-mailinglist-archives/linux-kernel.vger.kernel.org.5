Return-Path: <linux-kernel+bounces-59394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6306F84F641
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCAFFB249EC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF7857314;
	Fri,  9 Feb 2024 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nPeFEuvr"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C63F4D11D;
	Fri,  9 Feb 2024 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707486977; cv=none; b=pnyLu75tKcqnQHm5B5njiv4uUYQe4J62u3u7uxaO8W33gCwBdI3kuUX6E0LblPOmaIEbm2wSWmSwWrHZwJC/7Ie8OBYzV5l6STdrMqO+0iIhTFgpX5lcPpvP8XdVm+bNSHCczqDXIf58Q44usx9iEsh+asqw8/wb/AF/hbuMFj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707486977; c=relaxed/simple;
	bh=u9bsxtohU+8O0/ftK0UrMmBKffO0/k0GLIWvh6WyXKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X9/H3xGSHjEYCYxwSLJNlHk5ZbsO7Bt9RgpswLsrf/ojAlndFdtDuurnEO8UB5QfvCzLtK3LGWc6WdZAFhHrnpNZ02tIlacd2AWF+M3uujDWBBHiCVHqR5WMDj85sXUPio+ls0OYKpQaGQPpzHww/0J4xH8FRrJyFFBtgz2X1XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nPeFEuvr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0A9A81BF20D;
	Fri,  9 Feb 2024 13:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707486966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXmlq/yLijYckXKkeLmVy9L0DG5yOUTwBMD5D252K9Y=;
	b=nPeFEuvrBc6WFjtuX4Ol3EEl2l2ga5mNYxvBsWEZi9cPKD0z5zCCwAbmfpSzOXgK4UBkYl
	jXPYBcrI6YMJ2jYWl7KYtGdRREsX36Qxdcsf9oOH09qe1fCfMHnhttCYChAa6QXLAZwjUf
	dIgprqI5Db+mnbGjYnFsALRLEKvCSNchwEVLkiR+aFAtS5bvUKal0nrSfCZnXmnDIikFZT
	8QVx9Yhwwr9AwwrSWnkht7PRLc6tVtzOT0deupkTT0T5juYvfZFjZ3peAyUohMfojWrXXe
	OHp7lAY7FdqWCLRAVSQRRA+kA3BA3HaNs8QpaDE/akdfbRDl88iG61A0VuT0PQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 09 Feb 2024 14:55:52 +0100
Subject: [PATCH v3 3/4] spi: cadence-qspi: put runtime in runtime PM hooks
 names
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240209-cdns-qspi-pm-fix-v3-3-540ac222f26b@bootlin.com>
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
2.43.0


