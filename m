Return-Path: <linux-kernel+bounces-61256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5931850FE8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA40C1C20FCB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51F917C6B;
	Mon, 12 Feb 2024 09:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kjXKmUen"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D57817BA1
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707731188; cv=none; b=Rs5PUkEgFMDofK9P2tXS1MqzsTAXcZ25YIhQhDsEGX45FEzpP9GS8pYDJpWdoLJ2PAaNwhNihlIKbH9k/MOo+EzRWFfKPaFcELmcA4RbuGeEXOWoSStoIYzw+u6MPoac8qaJYNK0eGAHFEXAl1ZEM0IAZZJLg8a2m4WjHkzWuSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707731188; c=relaxed/simple;
	bh=WmFlSgLi47sXJGi5sZiuSkwcH7ucQ1q75XcGBBFiDF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QGxOltaPwfn6U1zZJSghyVkmt21XFfaMyd6wHzNX197w9b96iT+0WMA/T7yZW9dmNProkqndCLPr4MiSMPlTbQruCYLT4KrOaLnSpHAtWRmgNcGRb3fS0jTE4W/+0HJbR0+l2rwfNEr5OunG8mq8HqmNiHOHK1KndPKHycR4MNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kjXKmUen; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707731186; x=1739267186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WmFlSgLi47sXJGi5sZiuSkwcH7ucQ1q75XcGBBFiDF8=;
  b=kjXKmUendv4DZfskhCsPWNWxNMrM6l6byM7cUu1eok/LJ4X1KMm3/XRM
   e/hZPq/nHCc8yBAmEINupoq66jkr56IA2TT4Og6zifxzIwKSqYNTN/7Pe
   usqqS7wf8Anj731FGYgk7MSbGolVW3IOrdZCT3xRqgdVLjAHrHYMRJ063
   QVbv4H8kiLfkY0+GVTMbD4vzd2uIxGVsUjj5MsPcR29fxUwFsXCFykKc4
   678dVXPbgJlltTxSX9VT9XWi1NtemozBLQiwptiOlqWWPt312nbDBegkf
   a+mbY0lcbQQfepEBmQeV62ulg/Jhw6mZHR7qBovEc+6mf+pm4aa19KVR8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="12335875"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="12335875"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 01:46:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="2502532"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 01:46:23 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id A50F811F9DB;
	Mon, 12 Feb 2024 11:46:19 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Wentong Wu <wentong.wu@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/3] mei: vsc: Call wake_up() and event handler in a workqueue
Date: Mon, 12 Feb 2024 11:46:16 +0200
Message-Id: <20240212094618.344921-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212094618.344921-1-sakari.ailus@linux.intel.com>
References: <20240212094618.344921-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The event handler, in this case that of mei_vsc_event_cb() of
platform-vsc.c, is called from a threaded interrupt handler in
uninterruptible context. However there are multiple places where the
handler may sleep. This patch creates a per-device workqueue and calls
wake_up() and the event callback from queued work where sleeping is
allowed.

Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/misc/mei/vsc-tp.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index 6f4a4be6ccb5..264ece72f0bf 100644
--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -72,6 +72,8 @@ struct vsc_tp {
 	atomic_t assert_cnt;
 	wait_queue_head_t xfer_wait;
 
+	struct workqueue_struct *event_workqueue;
+	struct work_struct event_work;
 	vsc_tp_event_cb_t event_notify;
 	void *event_notify_context;
 
@@ -416,19 +418,19 @@ static irqreturn_t vsc_tp_isr(int irq, void *data)
 
 	atomic_inc(&tp->assert_cnt);
 
-	wake_up(&tp->xfer_wait);
+	queue_work(tp->event_workqueue, &tp->event_work);
 
-	return IRQ_WAKE_THREAD;
+	return IRQ_HANDLED;
 }
 
-static irqreturn_t vsc_tp_thread_isr(int irq, void *data)
+static void vsc_tp_event_work(struct work_struct *work)
 {
-	struct vsc_tp *tp = data;
+	struct vsc_tp *tp = container_of(work, struct vsc_tp, event_work);;
+
+	wake_up(&tp->xfer_wait);
 
 	if (tp->event_notify)
 		tp->event_notify(tp->event_notify_context);
-
-	return IRQ_HANDLED;
 }
 
 static int vsc_tp_match_any(struct acpi_device *adev, void *data)
@@ -481,13 +483,18 @@ static int vsc_tp_probe(struct spi_device *spi)
 	init_waitqueue_head(&tp->xfer_wait);
 	tp->spi = spi;
 
+	tp->event_workqueue = create_singlethread_workqueue(dev_name(dev));
+	if (!tp->event_workqueue)
+		return -ENOMEM;
+
+	INIT_WORK(&tp->event_work, vsc_tp_event_work);
+
 	irq_set_status_flags(spi->irq, IRQ_DISABLE_UNLAZY);
-	ret = devm_request_threaded_irq(dev, spi->irq, vsc_tp_isr,
-					vsc_tp_thread_isr,
-					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-					dev_name(dev), tp);
+	ret = devm_request_irq(dev, spi->irq, vsc_tp_isr,
+			       IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+			       dev_name(dev), tp);
 	if (ret)
-		return ret;
+		goto err_destroy_workqueue;
 
 	mutex_init(&tp->mutex);
 
@@ -516,6 +523,10 @@ static int vsc_tp_probe(struct spi_device *spi)
 
 	return 0;
 
+err_destroy_workqueue:
+	destroy_workqueue(tp->event_workqueue);
+	kfree(tp->event_workqueue);
+
 err_destroy_lock:
 	mutex_destroy(&tp->mutex);
 
@@ -528,6 +539,8 @@ static void vsc_tp_remove(struct spi_device *spi)
 
 	platform_device_unregister(tp->pdev);
 
+	destroy_workqueue(tp->event_workqueue);
+	kfree(tp->event_workqueue);
 	mutex_destroy(&tp->mutex);
 }
 
-- 
2.39.2


