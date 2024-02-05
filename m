Return-Path: <linux-kernel+bounces-52861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28555849D8A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A2A61C22A43
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240ED36123;
	Mon,  5 Feb 2024 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bqC4KiMd"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709272D607;
	Mon,  5 Feb 2024 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707145061; cv=none; b=MOQUHSwYrjIolx3XX5c/JIGCW5ppOpYkqarnWXyScVGhfwASwJ5ozjlmfh4eNz5xeTa+Z+vWDJ6IwjLCjJLnqIBSMs6jXtwDQdK6b7/koH5G3PaRI17mT4ttMzJtR4ThttT8YvcRhcz0aY48a7ywlTRjOTE3/+HkYNXzuXh1lNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707145061; c=relaxed/simple;
	bh=cstpzce+J+7b1urmkwA3P0JVejglpP3nSE1z8JR3RxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f8WCThDIq0gTT3P5uHFg8ufBbtZjt5YPv/x57Y3erBAxEC7dm3H9IjxIm/vomTba1/+tRQHxayHm1dsRewJp8x7w+rxhsJkPcPYooZD/k3phMoXq2JB1FpZ4lUC0+RYGnWN/G7x88V8WECwlW43EPlNYKryGVt2FeDvRkdleUIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bqC4KiMd; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0E51A2000F;
	Mon,  5 Feb 2024 14:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707145052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RqketI7LTDXTpTwWPnxjrx3WSm2BtW9HamRjcUb4AQk=;
	b=bqC4KiMdfymIvbi/PG+BDj33Q8eJ4s2v+BfhsI02Q9bYVMCXh9FLDiiwjqSHzOkR+c2uti
	YlTQqD4JuqvOUOJszNbmBRwmztc0joTBsXatNC43dal/y/HrVLjDAccxh2gI6j42H1QK9V
	iWYhdYrJl4cKxv2ZFo7my4osnMVK1WJcWbkDhOi2gPs7e+i6h9hSgIVvzn+LN6jxtl+5wT
	xkZQKhaz4cFGThnNCetNQT2EZJDDyGaDYNzYWLibM2o0DolK0SosnE45Blfd0JRcRqMd0y
	HyOE5JaMQMVsNZQ7qNqQojBTDJmvnyz21aGaay4TzXBBUWqhbIqmvPFKXe0ATg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Mon, 05 Feb 2024 15:57:32 +0100
Subject: [PATCH v2 4/4] spi: cadence-qspi: add system-wide suspend and
 resume callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240205-cdns-qspi-pm-fix-v2-4-2e7bbad49a46@bootlin.com>
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


