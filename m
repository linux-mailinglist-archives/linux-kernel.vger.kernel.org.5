Return-Path: <linux-kernel+bounces-129043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B708963B2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4AB1C23036
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 04:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D791D46430;
	Wed,  3 Apr 2024 04:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zj2ngS5R"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157F245977;
	Wed,  3 Apr 2024 04:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712119987; cv=none; b=hM8IyED/v/z6GfXuYBFU8boBJ+Syw4f1vm1bmUAvciEQKX+AKu4qEXG9pZ64b0mM9bUfeWBzwY26Lu2EmBa+1g6QEYHbCnXIXMtyJz0iJUYPRRbyoUlfIpLvIjZlYjHS5xs3UWULDoO6J4CEJuQGU9gGIlQb8/mTydqEACILSnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712119987; c=relaxed/simple;
	bh=osExHUORjnSoQrqmwXTVAUyT8Z84AYG2aSoz6kn1HiE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ePhePd/jAVaNo8O0rcniTqtk9XCeis/paEmU68G12RE+HqTSPeKNI4Jgf6Olm3WmQ/2Z5gCJlQl7gV2urNWtnJAqoilx5lhcD4iLcNklMgp4p3/seGOrOYWd+vUNDhrxdOlZimupwgxZRgAlj2wF8nWhlJqgYS3kROVeWatYcWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zj2ngS5R; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712119985; x=1743655985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=osExHUORjnSoQrqmwXTVAUyT8Z84AYG2aSoz6kn1HiE=;
  b=Zj2ngS5RtDGvNoDkgAcgGsNfW5eRBsunc8diR3l0CBwegQS1SDIBav9r
   cnAkn+xPWtZMoKKYux9lSyoHmbpJJRhC01+psMGJdFROlBPrR4YrojV9c
   TxyMMLKWEcb1JXMeJ38CNyz4Cf1nFtomWpIs+CiszGtsu4DSeJRyqlX5h
   mJVyBHw34JyOcFWa885vP1vEZPLdRaDWgrxJMBm8wwvHq6bc5MUMSxQFc
   WYCwqZkvEjYgan58iDKoeTzRh5WKpUrakiksCGg7YHs/KaQgZ5ZNrOnaM
   WsYD1tQfCRfeDnbplsqjzozl7tF4spc3DiM2f/JJozozMuWIrJSTY+yoL
   Q==;
X-CSE-ConnectionGUID: N7EWQuj+Rlqx+ff9wUZ1bw==
X-CSE-MsgGUID: SzD3ew4JTDG0RLoU5bUdTw==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="24786573"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="24786573"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 21:53:04 -0700
X-CSE-ConnectionGUID: w8+p6xDJSZ+/jZpKOKjigA==
X-CSE-MsgGUID: qxH+92kaQuexhbdchuEY7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="18352733"
Received: from wentongw-optiplex-8070.sh.intel.com ([10.239.154.12])
  by fmviesa006.fm.intel.com with ESMTP; 02 Apr 2024 21:53:02 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: sakari.ailus@linux.intel.com,
	tomas.winkler@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	hao.yao@intel.com,
	stable@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Wentong Wu <wentong.wu@intel.com>
Subject: [PATCH v2 2/2] mei: vsc: Unregister interrupt handler for system suspend
Date: Wed,  3 Apr 2024 13:13:41 +0800
Message-Id: <20240403051341.3534650-2-wentong.wu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403051341.3534650-1-wentong.wu@intel.com>
References: <20240403051341.3534650-1-wentong.wu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sakari Ailus <sakari.ailus@linux.intel.com>

Unregister the MEI VSC interrupt handler before system suspend and
re-register it at system resume time. This mirrors implementation of other
MEI devices.

This patch fixes the bug that causes continuous stream of MEI VSC errors
after system resume.

Fixes: 386a766c4169 ("mei: Add MEI hardware support for IVSC device")
Cc: stable@vger.kernel.org # for 6.8
Reported-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Wentong Wu <wentong.wu@intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/misc/mei/platform-vsc.c | 17 ++++++-
 drivers/misc/mei/vsc-tp.c       | 84 +++++++++++++++++++++++----------
 drivers/misc/mei/vsc-tp.h       |  3 ++
 3 files changed, 78 insertions(+), 26 deletions(-)

diff --git a/drivers/misc/mei/platform-vsc.c b/drivers/misc/mei/platform-vsc.c
index 6c9f00bcb94b..b543e6b9f3cf 100644
--- a/drivers/misc/mei/platform-vsc.c
+++ b/drivers/misc/mei/platform-vsc.c
@@ -400,25 +400,40 @@ static void mei_vsc_remove(struct platform_device *pdev)
 static int mei_vsc_suspend(struct device *dev)
 {
 	struct mei_device *mei_dev = dev_get_drvdata(dev);
+	struct mei_vsc_hw *hw = mei_dev_to_vsc_hw(mei_dev);
 
 	mei_stop(mei_dev);
 
+	mei_disable_interrupts(mei_dev);
+
+	vsc_tp_free_irq(hw->tp);
+
 	return 0;
 }
 
 static int mei_vsc_resume(struct device *dev)
 {
 	struct mei_device *mei_dev = dev_get_drvdata(dev);
+	struct mei_vsc_hw *hw = mei_dev_to_vsc_hw(mei_dev);
 	int ret;
 
-	ret = mei_restart(mei_dev);
+	ret = vsc_tp_request_irq(hw->tp);
 	if (ret)
 		return ret;
 
+	ret = mei_restart(mei_dev);
+	if (ret)
+		goto err_free;
+
 	/* start timer if stopped in suspend */
 	schedule_delayed_work(&mei_dev->timer_work, HZ);
 
 	return 0;
+
+err_free:
+	vsc_tp_free_irq(hw->tp);
+
+	return ret;
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(mei_vsc_pm_ops, mei_vsc_suspend, mei_vsc_resume);
diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index 968a92a7425d..e6a98dba8a73 100644
--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -94,6 +94,27 @@ static const struct acpi_gpio_mapping vsc_tp_acpi_gpios[] = {
 	{}
 };
 
+static irqreturn_t vsc_tp_isr(int irq, void *data)
+{
+	struct vsc_tp *tp = data;
+
+	atomic_inc(&tp->assert_cnt);
+
+	wake_up(&tp->xfer_wait);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t vsc_tp_thread_isr(int irq, void *data)
+{
+	struct vsc_tp *tp = data;
+
+	if (tp->event_notify)
+		tp->event_notify(tp->event_notify_context);
+
+	return IRQ_HANDLED;
+}
+
 /* wakeup firmware and wait for response */
 static int vsc_tp_wakeup_request(struct vsc_tp *tp)
 {
@@ -383,6 +404,37 @@ int vsc_tp_register_event_cb(struct vsc_tp *tp, vsc_tp_event_cb_t event_cb,
 }
 EXPORT_SYMBOL_NS_GPL(vsc_tp_register_event_cb, VSC_TP);
 
+/**
+ * vsc_tp_request_irq - request irq for vsc_tp device
+ * @tp: vsc_tp device handle
+ */
+int vsc_tp_request_irq(struct vsc_tp *tp)
+{
+	struct spi_device *spi = tp->spi;
+	struct device *dev = &spi->dev;
+	int ret;
+
+	irq_set_status_flags(spi->irq, IRQ_DISABLE_UNLAZY);
+	ret = request_threaded_irq(spi->irq, vsc_tp_isr, vsc_tp_thread_isr,
+				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+				   dev_name(dev), tp);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(vsc_tp_request_irq, VSC_TP);
+
+/**
+ * vsc_tp_free_irq - free irq for vsc_tp device
+ * @tp: vsc_tp device handle
+ */
+void vsc_tp_free_irq(struct vsc_tp *tp)
+{
+	free_irq(tp->spi->irq, tp);
+}
+EXPORT_SYMBOL_NS_GPL(vsc_tp_free_irq, VSC_TP);
+
 /**
  * vsc_tp_intr_synchronize - synchronize vsc_tp interrupt
  * @tp: vsc_tp device handle
@@ -413,27 +465,6 @@ void vsc_tp_intr_disable(struct vsc_tp *tp)
 }
 EXPORT_SYMBOL_NS_GPL(vsc_tp_intr_disable, VSC_TP);
 
-static irqreturn_t vsc_tp_isr(int irq, void *data)
-{
-	struct vsc_tp *tp = data;
-
-	atomic_inc(&tp->assert_cnt);
-
-	wake_up(&tp->xfer_wait);
-
-	return IRQ_WAKE_THREAD;
-}
-
-static irqreturn_t vsc_tp_thread_isr(int irq, void *data)
-{
-	struct vsc_tp *tp = data;
-
-	if (tp->event_notify)
-		tp->event_notify(tp->event_notify_context);
-
-	return IRQ_HANDLED;
-}
-
 static int vsc_tp_match_any(struct acpi_device *adev, void *data)
 {
 	struct acpi_device **__adev = data;
@@ -490,10 +521,9 @@ static int vsc_tp_probe(struct spi_device *spi)
 	tp->spi = spi;
 
 	irq_set_status_flags(spi->irq, IRQ_DISABLE_UNLAZY);
-	ret = devm_request_threaded_irq(dev, spi->irq, vsc_tp_isr,
-					vsc_tp_thread_isr,
-					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-					dev_name(dev), tp);
+	ret = request_threaded_irq(spi->irq, vsc_tp_isr, vsc_tp_thread_isr,
+				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+				   dev_name(dev), tp);
 	if (ret)
 		return ret;
 
@@ -522,6 +552,8 @@ static int vsc_tp_probe(struct spi_device *spi)
 err_destroy_lock:
 	mutex_destroy(&tp->mutex);
 
+	free_irq(spi->irq, tp);
+
 	return ret;
 }
 
@@ -532,6 +564,8 @@ static void vsc_tp_remove(struct spi_device *spi)
 	platform_device_unregister(tp->pdev);
 
 	mutex_destroy(&tp->mutex);
+
+	free_irq(spi->irq, tp);
 }
 
 static const struct acpi_device_id vsc_tp_acpi_ids[] = {
diff --git a/drivers/misc/mei/vsc-tp.h b/drivers/misc/mei/vsc-tp.h
index f9513ddc3e40..14ca195cbddc 100644
--- a/drivers/misc/mei/vsc-tp.h
+++ b/drivers/misc/mei/vsc-tp.h
@@ -37,6 +37,9 @@ int vsc_tp_xfer(struct vsc_tp *tp, u8 cmd, const void *obuf, size_t olen,
 int vsc_tp_register_event_cb(struct vsc_tp *tp, vsc_tp_event_cb_t event_cb,
 			     void *context);
 
+int vsc_tp_request_irq(struct vsc_tp *tp);
+void vsc_tp_free_irq(struct vsc_tp *tp);
+
 void vsc_tp_intr_enable(struct vsc_tp *tp);
 void vsc_tp_intr_disable(struct vsc_tp *tp);
 void vsc_tp_intr_synchronize(struct vsc_tp *tp);
-- 
2.34.1


