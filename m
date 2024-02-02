Return-Path: <linux-kernel+bounces-50234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FD7847616
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 586F328CAE1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7AF14AD1E;
	Fri,  2 Feb 2024 17:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BGVzjsA6"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9759514A4F2;
	Fri,  2 Feb 2024 17:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895008; cv=none; b=Qm5J8OslidCGbEMYV/W6SemtlgVmyIp1u6pvVRL6Rkt8Btan5NHCEE46O2Mv9FjaD2p6Q3XOVwKsJVsLn7E+LInwVvEvx5CHTlSbRcxQnzJ+Qzb/AgXUlGpDKzocGEsVBbGHwBNJNt0tLp7KaqgdtGVYYu18Zq9pae0jNNLNG1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895008; c=relaxed/simple;
	bh=wqNuAPanptQME98W67sLtw8ZvWcSrR//ShLTuJ17UaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pWOkgH9RXvcY+1iVywbXDd7gwsf0QJonbSTmicom2BHlX+zHBI7QElgLO4IFJaTTuXFm0/00M5h+ggNEvxAjY7OWXL5rNg3j7R7TGLTL6UAXldpUweh4an7B6mP7qKJRtaCQrd+Z01KMcL0XJ6EuucoQ6rFwsTVJkyEGLH5quJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BGVzjsA6; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BF38C40007;
	Fri,  2 Feb 2024 17:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706894998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+FIIaUhKnjjImo2lXmcI5ga52r8L4n7S83Aop/cwrI4=;
	b=BGVzjsA6m18eDYYQlpjHqj6iSi3qWCJgfHuP4KjmyGA6vLM+OZ++ZPTPu3glA9vGETzMQ1
	7G8YKJzMNtM5rfSxRcv9buvL8rrcQXPNAsDuGDQh0Bx4DkSxk31pDBeL5JxvhQKKTKnl8X
	sakENjwkaxhlfotrFmIP6RR82effY+SjOkm4C2PxiLgA0zCvW7BE4Y3JVd78DdceShuk6U
	156ZQf6fCDWMZBqd9E4WWLY8jVT1e+C0j6VoQe9HSbNA0KT7inemWVm4yZHq9H3+qaySmi
	8FuOi2sW5X9UVk+7PQlo8Q7gjslh1N0xKmciaTrmTa30eHuA0SfBAF86wz3CYw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 02 Feb 2024 18:29:40 +0100
Subject: [PATCH] spi: cadence-qspi: stop calling system-wide PM helpers for
 runtime PM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240202-cdns-qspi-pm-fix-v1-1-3c8feb2bfdd8@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAIMmvWUC/x2MQQqAMAwEv1JyNlCLKPoV8aBt1BystQERpH83e
 BmYgd0XhDKTwGBeyHSz8BlV6sqA3+e4EXJQB2ddYxXoQxS8JDGmA1d+0PWttd63oVtW0FnKpPm
 /HKdSPpR19q9iAAAA
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

The cadence-qspi ->exec_op() implementation bumps the usage counter at
its start. It might therefore run our ->runtime_resume()
implementation. However, ctlr->bus_lock_mutex is acquired by
spi_mem_exec_op() while ->exec_op() is being called.

Here is a brief call tree highlighting the issue:

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

The fatal conclusion of this is a deadlock: we acquire a lock on each
operation but while running the operation, we might want to runtime
resume and acquire the same lock.

Anyway, those helpers (spi_controller_{suspend,resume}) are aimed at
system-wide suspend and resume and should NOT be called at runtime
suspend & resume.

Side note: the previous implementation had a second issue. It acquired a
pointer to both `struct cqspi_st` and `struct spi_controller` using
dev_get_drvdata(). Neither embed the other. This lead to memory
corruption that was being hidden inside the big cqspi->f_pdata array on
my setup. It was working until I tried changing the array side to its
theorical max of 4, which lead to the discovery of this gnarly bug.

Fixes: 0578a6dbfe75 ("spi: spi-cadence-quadspi: add runtime pm support")
Fixes: 2087e85bb66e ("spi: cadence-quadspi: fix suspend-resume implementations")
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Hi,

This is a draft patch highlighting a serious bug in the
->runtime_suspend() and ->runtime_resume() implementations of
cadence-qspi. Seeing how runtime PM and autosuspend are enabled by
default, I believe this affects all users of the driver.

I've tried my best to be exhaustive in the commit message. Have I missed
something that could explain how the current implementations could have
been functional in the last few revisions of the kernel?

The MIPS platform at hand, used for debugging and testing, is currently
not supported by the driver. It is the Mobileye EyeQ5 [0]. No code
changes are required for support, only a new compatible and appropriate
match data + flags. That will come later, with some performance-related
patches.

Conclusion being: feedback from maintainers & others that know the
driver and subsystem would be useful to bring this forward.

Thanks all,
Théo

[0]: https://lore.kernel.org/lkml/20240118155252.397947-1-gregory.clement@bootlin.com/
---
 drivers/spi/spi-cadence-quadspi.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 74647dfcb86c..72f80c77ee35 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1927,24 +1927,18 @@ static void cqspi_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
-static int cqspi_suspend(struct device *dev)
+static int cqspi_runtime_suspend(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
-	struct spi_controller *host = dev_get_drvdata(dev);
-	int ret;
 
-	ret = spi_controller_suspend(host);
 	cqspi_controller_enable(cqspi, 0);
-
 	clk_disable_unprepare(cqspi->clk);
-
-	return ret;
+	return 0;
 }
 
-static int cqspi_resume(struct device *dev)
+static int cqspi_runtime_resume(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
-	struct spi_controller *host = dev_get_drvdata(dev);
 
 	clk_prepare_enable(cqspi->clk);
 	cqspi_wait_idle(cqspi);
@@ -1953,11 +1947,11 @@ static int cqspi_resume(struct device *dev)
 	cqspi->current_cs = -1;
 	cqspi->sclk = 0;
 
-	return spi_controller_resume(host);
+	return 0;
 }
 
-static DEFINE_RUNTIME_DEV_PM_OPS(cqspi_dev_pm_ops, cqspi_suspend,
-				 cqspi_resume, NULL);
+static DEFINE_RUNTIME_DEV_PM_OPS(cqspi_dev_pm_ops, cqspi_runtime_suspend,
+				 cqspi_runtime_resume, NULL);
 
 static const struct cqspi_driver_platdata cdns_qspi = {
 	.quirks = CQSPI_DISABLE_DAC_MODE,

---
base-commit: 27470aa9b51a348f7edfb99641b5a9004f81e3e6
change-id: 20240202-cdns-qspi-pm-fix-29600cc6d7bf

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


