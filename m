Return-Path: <linux-kernel+bounces-59392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C8884F63E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3211F25D1A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E2D4EB23;
	Fri,  9 Feb 2024 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VOlPNAV+"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C561B286AF;
	Fri,  9 Feb 2024 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707486976; cv=none; b=oviaPrGKTr92sc4z4+Pxc3/D4HtT5RVvkEmhpuZm/oU24LPbmC/Tnsuiab2VmY9b/7CU6X/awQ4tdDbgK6C3euGqwqfhtn/e2BDyO49CyBdHHFbbVR02fGprV4UL411h6uS4uygc5gly07Jfn1RSxtaTa9GOtcSqmOwI0uCfg8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707486976; c=relaxed/simple;
	bh=MJODknsNdPWKKihYzzcpVIfotVeSxNrGrwbmt2FA684=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y6JwHb3WmsuQbIwmmcD+YIMsboiYxkouMVy7ytm0inFL4e/IlvBbv7aaQ10gCYTE9LwP2gVZ5oKL0WfTwJx0sSzQL1wQANFZvD1zErzGhfpkZ0XqjxUbg5kFQ4IMbH+mCA9xSba931REHO3OOlXEezi/uxXxu/BSE3fsJUv0qas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VOlPNAV+; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3393D1BF20A;
	Fri,  9 Feb 2024 13:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707486965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mHHh5pthlaRvRNGcIbfyZm+1KloZJQv9bQbNMTFQ/6M=;
	b=VOlPNAV+tLPiurdzfe97v46AUhH37VsDMw1b/jI6cao5J1q0Kp5XtEJtH7jsDKnozdlOg/
	DKyakZx3/Y02haNkXr8PaUtg1obtMx81vPp0ZRAb3zbymAod1GTg+fSrAx5gilmbU1vdy2
	EWuW14fIZB31iqm31NFrLyIGG0xAgVM5EgrmkYFXYJ4/vNbqvr5aZa0glNeMW6cC63DQPh
	M3W4gY8wZdQ8mhLVDkRbCvgck34H5fKTyf4eu4iaSzrdk6LAKdk8KlpVekSoHgr42QSQqn
	V0NKiQWm+uMZbDUFhdcZ8E07HQaSDe7cLVjukk2mR1nTv+aJus4/xIVALJDaIw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 09 Feb 2024 14:55:51 +0100
Subject: [PATCH v3 2/4] spi: cadence-qspi: remove system-wide suspend
 helper calls from runtime PM hooks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240209-cdns-qspi-pm-fix-v3-2-540ac222f26b@bootlin.com>
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
2.43.0


