Return-Path: <linux-kernel+bounces-76300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CF685F561
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EFA028241C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70E13BB35;
	Thu, 22 Feb 2024 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dsw6aMVe"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB343987A;
	Thu, 22 Feb 2024 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708596758; cv=none; b=CPbwKFM/GgQGFsiuOXCPdVpNtiB9SpJTetLd+qdguv5qF1tduXq6C3rYMXUlII2RbNOBNB9BHJ+bnTGNlZBb5T3sjen9KbVdV1FxmLUrXAGcXOzu1PHkAIdnltHFQj9i3bqNKy+D+snMZHVMy/trSRYU/8lyR6FJvxtWMP1toIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708596758; c=relaxed/simple;
	bh=U+gzS1ckVJjVA+ftOBxZZr+oCPKKnY2akQ+FTUE4Vlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JimIglmSvNhdVYyTGbFWrp98VTI8397ueBQi9hXVABdFLl8F/mqyqIrRymuhGwtd7urMrXbmw3BxT+bF+lAkVY5rUw86EHautfhaapToPBYZwMnndauHdY+FwJcWV5qtoTFugSo7gzHAA3KRmz8pZGOPddlp2Hllfd1THCNfJa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dsw6aMVe; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 538872000D;
	Thu, 22 Feb 2024 10:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708596751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kr+jGKZ7wa4euSb09lk+qCqBrZfe1hy6OrbVIm5KELU=;
	b=dsw6aMVe503SzQB89/ddzyuJ08+ZL7xstYhTijpcje0Wv9Zr92DVNUljvFTlOHNMCg0TFY
	NSDq8XEDWEvjkbsXHhxTXNBHcGwmwLH9CRFP17TfJVWJZ12xX/oyKLs3NwcFgu0Gnvlwpm
	ft6uzCM7UCQ96ffobAChRCH1vFNm6YyukGTRAZZ/TRnXboUVmFN38QcZ6CWVvVK0FcF+0h
	fFtlhR14w0ApR5fUA58MefDhqH5oeFxBkGhZ8XAs5VdPLEpYU57EGuwTZiZsft+4mEVvyT
	ZvsFuIk4OQ4FsvaOWA4Tlu7lQaU38ZKCUbrV8RNoQhFHL5ev2LL6ZuWqvDX7BQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Thu, 22 Feb 2024 11:12:30 +0100
Subject: [PATCH v4 2/4] spi: cadence-qspi: remove system-wide suspend
 helper calls from runtime PM hooks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240222-cdns-qspi-pm-fix-v4-2-6b6af8bcbf59@bootlin.com>
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

The ->runtime_suspend() and ->runtime_resume() callbacks are not
expected to call spi_controller_suspend() and spi_controller_resume().
Remove calls to those in the cadence-qspi driver.

Those helpers have two roles currently:
 - They stop/start the queue, including dealing with the kworker.
 - They toggle the SPI controller SPI_CONTROLLER_SUSPENDED flag. It
   requires acquiring ctlr->bus_lock_mutex.

Step one is irrelevant because cadence-qspi is not queued. Step two
however has two implications:
 - A deadlock occurs, because ->runtime_resume() is called in a context
   where the lock is already taken (in the ->exec_op() callback, where
   the usage count is incremented).
 - It would disallow all operations once the device is auto-suspended.

Here is a brief call tree highlighting the mutex deadlock:

spi_mem_exec_op()
        ...
        spi_mem_access_start()
                mutex_lock(&ctlr->bus_lock_mutex)

        cqspi_exec_mem_op()
                pm_runtime_resume_and_get()
                        cqspi_resume()
                                spi_controller_resume()
                                        mutex_lock(&ctlr->bus_lock_mutex)
                ...

        spi_mem_access_end()
                mutex_unlock(&ctlr->bus_lock_mutex)
        ...

Fixes: 0578a6dbfe75 ("spi: spi-cadence-quadspi: add runtime pm support")
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index d19ba024c80b..809bbbb876ad 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1930,14 +1930,10 @@ static void cqspi_remove(struct platform_device *pdev)
 static int cqspi_suspend(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
-	int ret;
 
-	ret = spi_controller_suspend(cqspi->host);
 	cqspi_controller_enable(cqspi, 0);
-
 	clk_disable_unprepare(cqspi->clk);
-
-	return ret;
+	return 0;
 }
 
 static int cqspi_resume(struct device *dev)
@@ -1950,8 +1946,7 @@ static int cqspi_resume(struct device *dev)
 
 	cqspi->current_cs = -1;
 	cqspi->sclk = 0;
-
-	return spi_controller_resume(cqspi->host);
+	return 0;
 }
 
 static DEFINE_RUNTIME_DEV_PM_OPS(cqspi_dev_pm_ops, cqspi_suspend,

-- 
2.43.2


