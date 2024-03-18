Return-Path: <linux-kernel+bounces-105795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD7887E49B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB031F219E6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1571A24A03;
	Mon, 18 Mar 2024 08:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ggN01bWF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8618C28DA5;
	Mon, 18 Mar 2024 08:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710748910; cv=none; b=pdZEY0ODWcuHkl91yn/2AZhbiCVrPs4zMcQJM9XsoBCTOO2UyrOzp/jE7Xf69viqQYEQ+TYs9KryaGgwjBV0fH/e9DoONo3yIBZ/6jLiA34DcU6IIRo3xqcl3ybYJK47867RkieKmHqYwbG1/66Q35PlXY1oLDDMumLEP1Amyas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710748910; c=relaxed/simple;
	bh=6ElfNOZ/XMwu2COTpMx7a93NqGekxxAWzc7Fzup9NoA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XLk8MEVYLRGpUeSXpyf/OX5KQT9LxhOl3DG7T9lmUkpZ3DoeGra2cM7GQ3KtiSIkjFfHybXoZYPGcTWIFu3K5Fb51GApGcyJ/Rgv5zvMAfBOWuSAjol/hy0byQ09rfnaPGkL9ApI5tOf6yOlAKLNxHycC/657NPsnDZi+gRtTQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ggN01bWF; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710748908; x=1742284908;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6ElfNOZ/XMwu2COTpMx7a93NqGekxxAWzc7Fzup9NoA=;
  b=ggN01bWFJMjXiEwt4De1gwgoaHictAehfmXyJR25Jf0Od8lxQThgQCU2
   OXVWUCbnG8d2JKXhLfICS9Cdnt56Qbx1NCD0vjeVvCkJjMmUAZt603mlb
   hKpuxVARbTMxTLCnAIZ8PCZzqO35VuXaXY24WaPfc8fDYx1jQr2Rxeihk
   0gAGs0eizgPGZZkyvQjkvwrEgQ5NZo5ScVVE5c0+QFU0CbwQ3mr1vw4Fp
   7xW6OwHyI4ryXv3bjHt+5ZPjLbIZiZaU7C/8mKrJ+m4JzwW2qv6jVvQ9Z
   5qCPCRWURpvQQmXzpMyo2OJ8lRdMc3LoF3qRZy1N5ryJw8xDoo5kl08UT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="16269000"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="16269000"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 01:01:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="14031528"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 01:01:40 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 4718011F853;
	Mon, 18 Mar 2024 10:01:36 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1rm7w8-00Bnuq-0t;
	Mon, 18 Mar 2024 10:01:36 +0200
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wentong Wu <wentong.wu@intel.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 1/1] mei: vsc: Unregister interrupt handler for system suspend
Date: Mon, 18 Mar 2024 10:01:26 +0200
Message-Id: <20240318080126.2813476-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 8d303c6c0000..8db0fcf24e70 100644
--- a/drivers/misc/mei/platform-vsc.c
+++ b/drivers/misc/mei/platform-vsc.c
@@ -402,25 +402,40 @@ static int mei_vsc_remove(struct platform_device *pdev)
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
index 03486bebae09..870c70ef3bb8 100644
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
@@ -485,10 +516,9 @@ static int vsc_tp_probe(struct spi_device *spi)
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
2.39.2


