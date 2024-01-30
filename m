Return-Path: <linux-kernel+bounces-44010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2396F841C2C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC911F25BE0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207F93CF66;
	Tue, 30 Jan 2024 06:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eYC2M3eF"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDCC39879
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 06:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706597370; cv=none; b=kzAN6RK1fXBjFjux3uEiP0QmNQ1pNjorGkLT8tNqq8wzypic0vSomxerK1SwfEL7SMJfNqhoXizvstbvMM4buOCLEiPC8TjXCgfe67RaIbW3AV2NGHDBYthDfFi9GTfa238/0mIC7POGCwLNLg4QN0f4zEMIHbxxOvUzy4B/6Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706597370; c=relaxed/simple;
	bh=F677IBoUhHzMTuvWXqwcPdgWDOJp521cNnxnaG/vMiM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HPylqKdw5iRnURNNZce9LVsWe49b9jFRTkwwiyNn1uJVDH6+dWrExiVfyUfD2/4RWFRca8IW5s2SpA5Yb58BM6jl8LugLLd7slwc/7C/lXmjcqdyikd/9nLH7yoUP6lcOlKvXWR3ZAJCCZd53/NARsx2tYE+VsBzkcMjI3iNcrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eYC2M3eF; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso5762412276.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 22:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706597367; x=1707202167; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0kJpyZRLEun0ampJIfj1X21WJ21b9jsbskmJbElfrgM=;
        b=eYC2M3eFPEOfG+smc9aFGfTkPI3tlUcxF9DEyL+NkZqXhxBG7Pn5MZsPLCDUy8YOHA
         K6PI9gejBBDWuCfpA9rSkPiA+b52atjnTS8r1vi+3JeAyfTFMV7mi4kyISEJoIaCLFXv
         0yu0dDImyHSKzpLSA5eHq+xwHeMfx02hibxyoKI1gYqf/7Taz6j2N9HG3lBuCbE4VxlH
         YvpuGQjhQ+r0pY0e3Oibr2xJS3Toq/Iqb00kuiLkRXgIA5xpzXk8NhbI3GvhC3xOAFj2
         pIkrlNxmktQ6iPotU+SF1wbvs/9CITAleFef5cYBZSOcDBY+CT5QFGmRgFZ/5Awp+4af
         wIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706597367; x=1707202167;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0kJpyZRLEun0ampJIfj1X21WJ21b9jsbskmJbElfrgM=;
        b=PH7FTMXcI4u6j5UsoQosX120yeze2lCLkgs2sX7xbE56EQbeLh8J3r4C0JaHXcn2JP
         nKOiBsXAkCb/brxHH66fEsUzQJrkH+yjEURITr+aPWdyVJa4DExSIRmr6Nu3UOAjMlfY
         qh2/zPR0QD5fTsgve03N7aS9joCmmgxsNzYOWogRKUQjuNcbLLRGAwGeVDt1zJouGAli
         Atj2+kb/JXyYkHRNkwPIY6mYpkN0GpKjBYemN6pxFebT3h64uxJy3tRp2OO/NeBW1lky
         quIsQ48fkkO7TNO8HCqC/Mgikdh6x+57YhQlKa6ej0lB1Srv5Zo6N/K0QRoFEBNksq8l
         niaQ==
X-Gm-Message-State: AOJu0YwC56eDYssifuFrunX2XxcVMZ+v1DAD7+bbr/QfZ4PENXedmlMl
	nO0iQrwxO3tcRtS/wDqtjWeScSCpAsUUa4ONW+Gs4djtWU5xhLDfsdkA2y3bNHXQr1WLO7mmOXU
	ZgOtXfwfduF7sRA==
X-Google-Smtp-Source: AGHT+IHeRsN4S+ZasZ7WTqWPfffkOA5I3/+8mG/F05qDX+kl3h16PrH683ZuBuiyqhOvgaIrGl0G8sP0P81XF/s=
X-Received: from guanyulin.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:1af])
 (user=guanyulin job=sendgmr) by 2002:a05:6902:108f:b0:dc2:23d8:722d with SMTP
 id v15-20020a056902108f00b00dc223d8722dmr2784786ybu.13.1706597367593; Mon, 29
 Jan 2024 22:49:27 -0800 (PST)
Date: Tue, 30 Jan 2024 06:47:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240130064819.1362642-1-guanyulin@google.com>
Subject: [PATCH] [RFC] usb: host: Allow userspace to control usb suspend flows
From: Guan-Yu Lin <guanyulin@google.com>
To: gregkh@linuxfoundation.org, mathias.nyman@intel.com, 
	stern@rowland.harvard.edu, royluo@google.com, hadess@hadess.net, 
	benjamin.tissoires@redhat.com, heikki.krogerus@linux.intel.com, 
	oneukum@suse.com, grundler@chromium.org, yajun.deng@linux.dev, 
	dianders@chromium.org
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, badhri@google.com, 
	albertccwang@google.com, pumahsu@google.com, 
	Guan-Yu Lin <guanyulin@google.com>
Content-Type: text/plain; charset="UTF-8"

In a system with sub-system engaged, the controllers are controlled by
both the main processor and the co-processor. Chances are when the main
processor decides to suspend the USB device, the USB device might still
be used by the co-processor. In this scenario, we need a way to let
system know whether it can suspend the USB device or not. We introduce a
new sysfs entry "deprecate_device_pm" to allow userspace to control the
device power management functionality on demand. As the userspace should
possess the information of both the main processor and the co-processor,
it should be able to address the conflict mentioned above.

Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
---
 Documentation/ABI/testing/sysfs-bus-usb | 10 +++++++++
 drivers/usb/core/driver.c               | 18 ++++++++++++++++
 drivers/usb/core/sysfs.c                | 28 +++++++++++++++++++++++++
 drivers/usb/host/xhci-plat.c            | 20 ++++++++++++++++++
 include/linux/usb.h                     |  4 ++++
 5 files changed, 80 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
index 2b7108e21977..3f3d6c14201f 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb
+++ b/Documentation/ABI/testing/sysfs-bus-usb
@@ -19,6 +19,16 @@ Description:
 		would be authorized by default.
 		The value can be 1 or 0. It's by default 1.
 
+What:		/sys/bus/usb/devices/usbX/deprecate_device_pm
+Date:		January 2024
+Contact:	Guan-Yu Lin <guanyulin@google.com>
+Description:
+		Deprecates the device power management functionality of USB devices
+		and their host contorller under this usb bus. The modification of
+		this entry should be done when the system is active to ensure the
+		correctness of system power state transitions.
+		The value can be 1 or 0. It's by default 0.
+
 What:		/sys/bus/usb/device/.../authorized
 Date:		July 2008
 KernelVersion:	2.6.26
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index e02ba15f6e34..e03cf972160d 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -1569,6 +1569,15 @@ int usb_suspend(struct device *dev, pm_message_t msg)
 	struct usb_device	*udev = to_usb_device(dev);
 	int r;
 
+	/*
+	 * Skip the entire suspend process under the same usb bus if its sysfs
+	 * entry `deprecate_device_pm` is set.
+	 */
+	if (udev->bus->deprecate_device_pm) {
+		dev_vdbg(&udev->dev, "deprecating dev_pm_ops: %s\n", __func__);
+		return 0;
+	}
+
 	unbind_no_pm_drivers_interfaces(udev);
 
 	/* From now on we are sure all drivers support suspend/resume
@@ -1605,6 +1614,15 @@ int usb_resume(struct device *dev, pm_message_t msg)
 	struct usb_device	*udev = to_usb_device(dev);
 	int			status;
 
+	/*
+	 * Skip the entire resume process under the same usb bus if its sysfs
+	 * entry `deprecate_device_pm` is set.
+	 */
+	if (udev->bus->deprecate_device_pm) {
+		dev_vdbg(&udev->dev, "deprecating dev_pm_ops: %s\n", __func__);
+		return 0;
+	}
+
 	/* For all calls, take the device back to full power and
 	 * tell the PM core in case it was autosuspended previously.
 	 * Unbind the interfaces that will need rebinding later,
diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index 5d21718afb05..b4520e5c8974 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -68,6 +68,33 @@ static ssize_t bMaxPower_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(bMaxPower);
 
+static ssize_t deprecate_device_pm_show(struct device *dev,
+					struct device_attribute *attr, char *buf)
+{
+	struct usb_device *udev;
+
+	udev = to_usb_device(dev);
+	return sysfs_emit(buf, "%d\n", !!(udev->bus->deprecate_device_pm));
+}
+
+static ssize_t deprecate_device_pm_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct usb_device	*udev = to_usb_device(dev);
+	int			val, rc;
+
+	if (sscanf(buf, "%d", &val) != 1 || val < 0 || val > 1)
+		return -EINVAL;
+	rc = usb_lock_device_interruptible(udev);
+	if (rc < 0)
+		return -EINTR;
+	udev->bus->deprecate_device_pm = !!(val);
+	usb_unlock_device(udev);
+	return count;
+}
+static DEVICE_ATTR_RW(deprecate_device_pm);
+
 static ssize_t configuration_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -984,6 +1011,7 @@ static DEVICE_ATTR_RW(interface_authorized_default);
 static struct attribute *usb_bus_attrs[] = {
 		&dev_attr_authorized_default.attr,
 		&dev_attr_interface_authorized_default.attr,
+		&dev_attr_deprecate_device_pm.attr,
 		NULL,
 };
 
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index f04fde19f551..bc05d83d1c0b 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -442,6 +442,15 @@ static int xhci_plat_suspend(struct device *dev)
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
 	int ret;
 
+	/*
+	 * Skip the entire suspend process under the same usb bus if its sysfs
+	 * entry `deprecate_device_pm` is set.
+	 */
+	if (hcd->self.deprecate_device_pm) {
+		dev_vdbg(dev, "deprecating dev_pm_ops: %s\n", __func__);
+		return 0;
+	}
+
 	if (pm_runtime_suspended(dev))
 		pm_runtime_resume(dev);
 
@@ -507,6 +516,17 @@ static int xhci_plat_resume_common(struct device *dev, struct pm_message pmsg)
 
 static int xhci_plat_resume(struct device *dev)
 {
+	struct usb_hcd	*hcd = dev_get_drvdata(dev);
+
+	/*
+	 * Skip the entire resume process under the same usb bus if its sysfs
+	 * entry `deprecate_device_pm` is set.
+	 */
+	if (hcd->self.deprecate_device_pm) {
+		dev_vdbg(dev, "deprecating dev_pm_ops: %s\n", __func__);
+		return 0;
+	}
+
 	return xhci_plat_resume_common(dev, PMSG_RESUME);
 }
 
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 9e52179872a5..1a1873104663 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -465,6 +465,10 @@ struct usb_bus {
 					 * the ep queue on a short transfer
 					 * with the URB_SHORT_NOT_OK flag set.
 					 */
+	unsigned deprecate_device_pm:1; /* Deprecates the device power management
+					 * functionality of USB devices on this
+					 * bus and their hcd.
+					 */
 	unsigned no_sg_constraint:1;	/* no sg constraint */
 	unsigned sg_tablesize;		/* 0 or largest number of sg list entries */
 
-- 
2.43.0.429.g432eaa2c6b-goog


