Return-Path: <linux-kernel+bounces-51593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E250D848CFC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 11:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F3A71F221C6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F423D21A19;
	Sun,  4 Feb 2024 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malat-biz.20230601.gappssmtp.com header.i=@malat-biz.20230601.gappssmtp.com header.b="qM2S3kHD"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CD321A06
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 10:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707044026; cv=none; b=OWRR1r6fyhSfpB29EfkzDWryWyyeY0gIgU25M2l2EWtpb5uLEvROUsA70HufHkp0l9X2tD+rtecFOqAyYy+gQ5UiWxMYhgc9W72kG7cEYDcjhouiKwX9MI8QZK0aPBu2Is95XX0m7EPd+G43pJ+UWV/ISZM7QtqunibMhN1L8ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707044026; c=relaxed/simple;
	bh=ZtIqpe+i0cPBiUWNfsXNOv8o5sAFhaKbYey39tPLngM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dfNhlkNE8rGr2pU9GU15jzsxkWma/uBAyVtDczQDqWbaK7eDYC0X5Si+RTYBeKbuekmvkjbEzegS3X53JnVOqCmlwtcRZkMo4hqHxDnW1aX3o23Wb9v4dM3d5sddOOLg2utHHCCNmFcRwCu07hPjzvwp9wPWXPEYhqxme5grR8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz; spf=none smtp.mailfrom=malat.biz; dkim=pass (2048-bit key) header.d=malat-biz.20230601.gappssmtp.com header.i=@malat-biz.20230601.gappssmtp.com header.b=qM2S3kHD; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=malat.biz
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so3987331a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 02:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20230601.gappssmtp.com; s=20230601; t=1707044021; x=1707648821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wmx6AaXhCgv2wUYmuFYojIQr5ckW3z1tnaWtbM8fkKw=;
        b=qM2S3kHDOatSFXJ1qgIePzktchtJFsqEU2pOgUPQwt60y2uoLYM7B7oVrPNenaMllq
         FxbxKVTAUMl53kbJCWaXGO/AOuVsVSrsxg78+XN5uloijwJ1LlfOFFnRatGFyHLEbr//
         IioSAulBG1r34owFvKjfOpXlaSDKLpcnXr+zry1VpWxncQBshUCBSW02PWmzkIXrH8Na
         5pBuEWwmASde+3KmngPMWebg4Dhv676pTr0msVtd8mti/uufHwY9M/o9xME3/wdji3em
         RHQ8zsmFOSw3jx5M5k31B6l0dOdObm1qqLD1bQcjxJfENx9qOH2VyijNR3tgzx0bQv6S
         6cYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707044021; x=1707648821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wmx6AaXhCgv2wUYmuFYojIQr5ckW3z1tnaWtbM8fkKw=;
        b=F5Zq471F//L+LsqZr9Mmh9A1xBnPO3+hoNL/qbN/9nG019Lj000wTpjh48vAlLGrYI
         zRgewcRN82OnzErlIss9hViW4M1IDw9Kksi1mvZiMq2GIsLuq94lruOfPW76RyG+w97t
         N3MejAK9wDIuthNjTebDKAR4EhvM1oGH9I1j9KGjstgKnDtUIF1HCdbMwuMyVBm+EcjR
         CqbQebr6Pk+p68p9jFosbv6ZoOrU1NlyA24wojYgzipNVaaovblC9JhYVKvwLMlAI4iE
         KaQB0rZogZbpM23+jQxJ8Q6hIY5pzQFK46/qGp2ymMueAyGABolLJNrez7izlyL14VyF
         7aWA==
X-Gm-Message-State: AOJu0YzstN/t/C/mVNlQbl/h/k+ZyDDpY5t8hKk9ACZjBegx6kyWjdmI
	qiLUaibwS+D8inckWqUMe77eHJZmZhvFIBD4vun2AzgipBGVwJ70584QZc/MxUMva2nnftX8iYJ
	7HQ==
X-Google-Smtp-Source: AGHT+IGwTtr5HLwF0fYykJg48bt3Q3Lnh1lM42xxFP2lqnHGoVKr59igbfLekhk19p57EUnsMNWPjw==
X-Received: by 2002:a17:906:2191:b0:a37:51b0:d256 with SMTP id 17-20020a170906219100b00a3751b0d256mr1822778eju.12.1707044020507;
        Sun, 04 Feb 2024 02:53:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVJUzP+TszJM53aAmCYfUUX2iCTKQjqoFAxgH8wynKss4fvHZ/fxw6yjWDxSpjFclZ2Oj6PLAVOKfL/XEKSP/lkcEuE/Iu8M7CHj+aemhBN9l6FQKUwQcNpDLL3QAIjitJEI96CxwkP0mtC+ZdRXrslcTB2fiKgsFdDSVlkRVwE+gigpLgRMQqbZBPqUZFrQJ9HdNnzxLgRrtYSe0G8Hivi73A=
Received: from localhost.localdomain ([193.86.118.65])
        by smtp.googlemail.com with ESMTPSA id f23-20020a1709067f9700b00a37b0d09d9esm40015ejr.119.2024.02.04.02.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 02:53:39 -0800 (PST)
From: Petr Malat <oss@malat.biz>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	andriy.shevchenko@linux.intel.com,
	petr.tesarik.ext@huawei.com,
	james@equiv.tech,
	Petr Malat <oss@malat.biz>
Subject: [PATCH] driver core: Avoid race between bus_add_device() and bus_add_driver()
Date: Sun,  4 Feb 2024 11:53:16 +0100
Message-Id: <20240204105316.719318-1-oss@malat.biz>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

device_add() adds the device to the bus list in bus_add_device(), but
until fw_devlink_link_device() is called, the device must not be probed,
because devlinks created after the device is bound would be stuck in
activating state. Also add and bind uevents could be generated in a wrong
order.

bus_add_driver() lacks any synchronization, which would prevent it from
picking the device and trying to probe it once it's on the bus list.

Straightforward fix could lock the device before bus_add_device() and
unlock it when probing is safe, but this would affect all bus match
callbacks and bus_notifier callbacks, which would suddenly receive
locked device.

Instead, introduce two state booleans in device structure to track the
device adding progress:
 - probe_ready starts cleared to 0 and is set to 1 in device_add() once
   the device is ready to be probed.
 - probe_pending is set to 1 by bus_add_device() before the device is
   added to the bus list if drivers_autoprobe is enabled. It's cleared by
   __device__attach() called by device_initial_probe().
When bus_add_driver() executes and sees probe_pending is set, it skips
the probe because it knows device_add() will call it when the device is
ready and it will find the driver on the bus list. If both probe_pending
and probe_ready are 0, bus_add_driver() must wait for probe_ready being
set. This can happen if drivers_autoprobe is changed at runtime.

Perform the synchronization before calling bus match callback to be
sure devices are always at the same state of initialization independently
of the match being called from device_add() or bus_add_driver() code path.

Signed-off-by: Petr Malat <oss@malat.biz>
---
 drivers/base/base.h    |  1 +
 drivers/base/bus.c     |  3 ++-
 drivers/base/core.c    |  2 ++
 drivers/base/dd.c      | 34 ++++++++++++++++++++++++++++++++++
 include/linux/device.h |  8 ++++++++
 5 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index eb4c0ace9242..f11d102548ef 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -186,6 +186,7 @@ void deferred_probe_extend_timeout(void);
 void driver_deferred_probe_trigger(void);
 const char *device_get_devnode(const struct device *dev, umode_t *mode,
 			       kuid_t *uid, kgid_t *gid, const char **tmp);
+void device_set_probe_ready(struct device *dev);
 
 /* /sys/devices directory */
 extern struct kset *devices_kset;
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index daee55c9b2d9..78795f168d62 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -503,6 +503,7 @@ int bus_add_device(struct device *dev)
 		goto out_subsys;
 
 	klist_add_tail(&dev->p->knode_bus, &sp->klist_devices);
+	dev->probe_pending = sp->drivers_autoprobe;
 	return 0;
 
 out_subsys:
@@ -528,7 +529,7 @@ void bus_probe_device(struct device *dev)
 	if (!sp)
 		return;
 
-	if (sp->drivers_autoprobe)
+	if (sp->drivers_autoprobe || dev->probe_pending)
 		device_initial_probe(dev);
 
 	mutex_lock(&sp->mutex);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 14d46af40f9a..896f8fec4a71 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3623,6 +3623,8 @@ int device_add(struct device *dev)
 	}
 
 	bus_probe_device(dev);
+	/* Now it's safe for drivers to probe it as well */
+	device_set_probe_ready(dev);
 
 	/*
 	 * If all driver registration is done and a newly added device doesn't
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 85152537dbf1..2004280d7a2e 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -997,12 +997,27 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
 	put_device(dev);
 }
 
+/*
+ * To synchronize __device_attach() and __driver_attach(). It's rarely needed,
+ * we can use one instance for all devices and drivers.
+ */
+static DECLARE_WAIT_QUEUE_HEAD(probe_ready_waitqueue);
+
+void device_set_probe_ready(struct device *dev)
+{
+	device_lock(dev);
+	dev->probe_ready = 1;
+	device_unlock(dev);
+	wake_up_all(&probe_ready_waitqueue);
+}
+
 static int __device_attach(struct device *dev, bool allow_async)
 {
 	int ret = 0;
 	bool async = false;
 
 	device_lock(dev);
+	dev->probe_pending = 0;
 	if (dev->p->dead) {
 		goto out_unlock;
 	} else if (dev->driver) {
@@ -1159,6 +1174,25 @@ static int __driver_attach(struct device *dev, void *data)
 	bool async = false;
 	int ret;
 
+	/*
+	 * Driver is already on the bus drivers list and device_add() hasn't
+	 * probed yet. Return, device_add will probe the driver.
+	 */
+	if (unlikely(dev->probe_pending)) {
+		device_lock(dev);
+		ret = dev->probe_pending;
+		device_unlock(dev);
+		if (ret)
+			return 0;
+	}
+
+	/*
+	 * Device add is running in parallel, we must wait before executing
+	 * driver_match_device(), to be sure all data match relies on are there.
+	 */
+	if (unlikely(!dev->probe_ready))
+		wait_event(probe_ready_waitqueue, dev->probe_ready);
+
 	/*
 	 * Lock device and try to bind to it. We drop the error
 	 * here and always return 0, because we need to keep trying
diff --git a/include/linux/device.h b/include/linux/device.h
index 97c4b046c09d..a2c07d57cd85 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -691,6 +691,12 @@ struct device_physical_location {
  *		and optionall (if the coherent mask is large enough) also
  *		for dma allocations.  This flag is managed by the dma ops
  *		instance from ->dma_supported.
+ * @probe_ready: Set from device_add() under device lock when the device is
+ * 		ready to be probed by a driver to prevent the driver from
+ * 		probing the device too early.
+ * @probe_pending: Set by device_add() before adding the device to the bus list,
+ * 		if it knows, it will call initial probe. Cleared by
+ * 		__device_attach() under the device lock.
  *
  * At the lowest level, every device in a Linux system is represented by an
  * instance of struct device. The device structure contains the information
@@ -803,6 +809,8 @@ struct device {
 #ifdef CONFIG_DMA_OPS_BYPASS
 	bool			dma_ops_bypass : 1;
 #endif
+	bool			probe_ready:1;
+	bool			probe_pending:1;
 };
 
 /**
-- 
2.39.2


