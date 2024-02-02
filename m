Return-Path: <linux-kernel+bounces-49505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14878846B35
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD1A296651
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FB95FEF1;
	Fri,  2 Feb 2024 08:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="docIvLfx"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A610182BF
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863736; cv=none; b=hhNOsqilD5xegh78SV1p7JaMhllQHZHwvgql68+rkjSzM8hEgoPeT0JwSGVGVbH6TvmoDqJr9zrNSFacm8m4L6zNlTgAqEe+/ySH8DkgBaJl3lG6jOhxJ4s8+SExMG5A675GSFPZZbi/pcQAj8jfrhegUZYGtSR3iY9fwsrg9x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863736; c=relaxed/simple;
	bh=PyfZug3UJbUT2FpKBL66KgofFvAVaAe+Y0aAJL/b8gU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ja/XIlmuc4Ly3M9YkhkCKw4odmNIN88sZKy1HATG5TJFQ8Eg8WEZzHV2p1JaT0yP4EjIOkDEoEoR3kLd+stN0EINEl59kif08dsjjSVTLGhbQV3s6CJ7lBFZsHZmlnyvQTOP8vkGg4B9jmO0ibk516R/ni/60VRAly7rxWZHFbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=docIvLfx; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc693399655so2997488276.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 00:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706863733; x=1707468533; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cS/CXgsmoznLCM/58EMa+C4HAC14gnF5J7VKWxLdqzo=;
        b=docIvLfx/y43tGLFtzVNeQxQhniD5ZAOULOT2Ler5jQ8yRDBnUjKigZa0FhyWvcjBe
         n+c5rcRcHY04OVt4YzK3lvVInV6kiW1B+38B3JL9dtlrvGQh8Z+3Vv4Lv1ufm4xHOO6/
         z9jepCeDFNdwTXt11CFJcVbjJ2IuvR/u/2sXfc4rMw5jefPLzYYriSEWakcIez046pPM
         2AsWugWQjYfcZgp8dy0nk8UyylPLwEMzXhZMr6igTYvEoHi4/oJQ2tElLriij+dia7p6
         9vuR2ub0XG07xoeI6Wtqc3TfbGjdGhnAFhflQlFSa9ddKMjG5bCFj6F07Jg+/tRvzqRW
         2ZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706863733; x=1707468533;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cS/CXgsmoznLCM/58EMa+C4HAC14gnF5J7VKWxLdqzo=;
        b=FuCGpY7cvn8onTn2/5FN8gfZQr1FW38Tj4/IB40+nZDed4XsHnP/wvmE1NfV9BQ6+g
         jqlFvp0eZv5asRVPqdojOYacpLr6p6/ITDVjQF8FaNa3Jw4njATn3k2dTm3ty3Xo8T4i
         DHQgtnqI74FDbwqbYoj3U8VC4uvtNO8JPiD/bYfKMVuwQAkZF2GtMHFiphLjYTZktvyA
         loRouTzLilfA8aA7PgbTriU5vW2/aTqUMe/RfvJ/Hvn/HcrzPB9L96kyo9F9zYp99gNj
         2iOaeHolWT/LVNiHs9UxDRs5sktMgvWgbGdhYJ00XmQtABTxyzfYrQTOdbYjQszeKoqS
         e5TQ==
X-Gm-Message-State: AOJu0Yyh05IdiqW+1q3rh+PWeCgf3MYQfNcRvWwQ5H2ugFsJVSGMJXCr
	g3p0wjIighC9E/sgJjc7n7CD37mZyOqND9mTEc5KVD9aED97zE/uFNbUmNhHL8HpJcVaxn4lwNL
	hVZBZJx6h1Ka9SA==
X-Google-Smtp-Source: AGHT+IF6xSbbu10GIVl4H7+tZyrBPZryIPb0mbF+NXCFwl8Nvh4CdA77KCaumYU6jv2DEa4k6vNprhMgTbaxpwI=
X-Received: from guanyulin.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:1af])
 (user=guanyulin job=sendgmr) by 2002:a05:6902:1085:b0:dc6:e5e9:f3af with SMTP
 id v5-20020a056902108500b00dc6e5e9f3afmr685079ybu.9.1706863733001; Fri, 02
 Feb 2024 00:48:53 -0800 (PST)
Date: Fri,  2 Feb 2024 08:42:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202084815.3064391-1-guanyulin@google.com>
Subject: [PATCH] usb: host: enable suspend-to-RAM control in userspace
From: Guan-Yu Lin <guanyulin@google.com>
To: gregkh@linuxfoundation.org, mathias.nyman@intel.com, 
	stern@rowland.harvard.edu, royluo@google.com, benjamin.tissoires@redhat.com, 
	hadess@hadess.net, heikki.krogerus@linux.intel.com, grundler@chromium.org, 
	oneukum@suse.com, dianders@chromium.org, yajun.deng@linux.dev
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	Guan-Yu Lin <guanyulin@google.com>
Content-Type: text/plain; charset="UTF-8"

In systems with both a main processor and a co-processor, asynchronous
controller management can lead to conflicts. For example, the main
processor might attempt to suspend a USB device while the co-processor
is actively transferring data. To address this, we introduce a new
sysfs entry, "disable_suspend2ram", which allows userspace to control
the suspend-to-RAM functionality of devices on a specific USB bus.
Since the userspace has visibility into the activities of both
processors, it can resolve potential conflicts.

Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
---
 Documentation/ABI/testing/sysfs-bus-usb | 10 +++++++
 drivers/usb/core/driver.c               | 12 ++++++++
 drivers/usb/core/sysfs.c                | 29 ++++++++++++++++++
 drivers/usb/host/xhci-plat.c            | 40 ++++++++++++++++++++++---
 include/linux/usb.h                     |  4 +++
 5 files changed, 91 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
index 2b7108e21977..f6a4f496c8f6 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb
+++ b/Documentation/ABI/testing/sysfs-bus-usb
@@ -19,6 +19,16 @@ Description:
 		would be authorized by default.
 		The value can be 1 or 0. It's by default 1.
 
+What:		/sys/bus/usb/devices/usbX/disable_suspend2ram
+Date:		January 2024
+Contact:	Guan-Yu Lin <guanyulin@google.com>
+Description:
+		Disables "suspend-to-RAM" system power management in USB devices
+		and their host contorller under this usb bus. The modification of
+		this entry should be done when the system is active to ensure the
+		correctness of system power state transitions.
+		The value can be 1 or 0. It's by default 0.
+
 What:		/sys/bus/usb/device/.../authorized
 Date:		July 2008
 KernelVersion:	2.6.26
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index e02ba15f6e34..c555e2b1ddda 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -1569,6 +1569,12 @@ int usb_suspend(struct device *dev, pm_message_t msg)
 	struct usb_device	*udev = to_usb_device(dev);
 	int r;
 
+	if (msg.event == PM_EVENT_SUSPEND && udev->bus->disable_suspend2ram) {
+		/* Skip "suspend-to-RAM" process under the same USB bus */
+		dev_dbg(dev, "suspend-to-RAM disabled, skipping dev_pm_ops.suspend\n");
+		return 0;
+	}
+
 	unbind_no_pm_drivers_interfaces(udev);
 
 	/* From now on we are sure all drivers support suspend/resume
@@ -1605,6 +1611,12 @@ int usb_resume(struct device *dev, pm_message_t msg)
 	struct usb_device	*udev = to_usb_device(dev);
 	int			status;
 
+	if (msg.event == PM_EVENT_RESUME && udev->bus->disable_suspend2ram) {
+		/* Skip "suspend-to-RAM" process under the same USB bus */
+		dev_dbg(dev, "suspend-to-RAM disabled, skipping dev_pm_ops.resume\n");
+		return 0;
+	}
+
 	/* For all calls, take the device back to full power and
 	 * tell the PM core in case it was autosuspended previously.
 	 * Unbind the interfaces that will need rebinding later,
diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index 5d21718afb05..7a228ea95506 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -68,6 +68,34 @@ static ssize_t bMaxPower_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(bMaxPower);
 
+static ssize_t disable_suspend2ram_show(struct device *dev,
+					struct device_attribute *attr, char *buf)
+{
+	struct usb_device *udev;
+
+	udev = to_usb_device(dev);
+	return sysfs_emit(buf, "%d\n", !!(udev->bus->disable_suspend2ram));
+}
+
+static ssize_t disable_suspend2ram_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct usb_device *udev = to_usb_device(dev);
+	bool val;
+	int rc;
+
+	if (kstrtobool(buf, &val) != 0)
+		return -EINVAL;
+	rc = usb_lock_device_interruptible(udev);
+	if (rc < 0)
+		return -EINTR;
+	udev->bus->disable_suspend2ram = !!(val);
+	usb_unlock_device(udev);
+	return count;
+}
+static DEVICE_ATTR_RW(disable_suspend2ram);
+
 static ssize_t configuration_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -984,6 +1012,7 @@ static DEVICE_ATTR_RW(interface_authorized_default);
 static struct attribute *usb_bus_attrs[] = {
 		&dev_attr_authorized_default.attr,
 		&dev_attr_interface_authorized_default.attr,
+		&dev_attr_disable_suspend2ram.attr,
 		NULL,
 };
 
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index f04fde19f551..86733249fcdc 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -436,12 +436,18 @@ void xhci_plat_remove(struct platform_device *dev)
 }
 EXPORT_SYMBOL_GPL(xhci_plat_remove);
 
-static int xhci_plat_suspend(struct device *dev)
+static int xhci_plat_suspend_common(struct device *dev, struct pm_message pmsg)
 {
 	struct usb_hcd	*hcd = dev_get_drvdata(dev);
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
 	int ret;
 
+	if (pmsg.event == PM_EVENT_SUSPEND && hcd->self.disable_suspend2ram) {
+		/* Skip "suspend-to-RAM" process under the same USB bus */
+		dev_dbg(dev, "suspend-to-RAM disabled, skipping dev_pm_ops.suspend\n");
+		return 0;
+	}
+
 	if (pm_runtime_suspended(dev))
 		pm_runtime_resume(dev);
 
@@ -464,12 +470,33 @@ static int xhci_plat_suspend(struct device *dev)
 	return 0;
 }
 
+static int xhci_plat_suspend(struct device *dev)
+{
+	return xhci_plat_suspend_common(dev, PMSG_SUSPEND);
+}
+
+static int xhci_plat_freeze(struct device *dev)
+{
+	return xhci_plat_suspend_common(dev, PMSG_FREEZE);
+}
+
+static int xhci_plat_poweroff(struct device *dev)
+{
+	return xhci_plat_suspend_common(dev, PMSG_HIBERNATE);
+}
+
 static int xhci_plat_resume_common(struct device *dev, struct pm_message pmsg)
 {
 	struct usb_hcd	*hcd = dev_get_drvdata(dev);
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
 	int ret;
 
+	if (pmsg.event == PM_EVENT_RESUME && hcd->self.disable_suspend2ram) {
+		/* Skip "suspend-to-RAM" process under the same USB bus */
+		dev_dbg(dev, "suspend-to-RAM disabled, skipping dev_pm_ops.resume\n");
+		return 0;
+	}
+
 	if (!device_may_wakeup(dev) && (xhci->quirks & XHCI_SUSPEND_RESUME_CLKS)) {
 		ret = clk_prepare_enable(xhci->clk);
 		if (ret)
@@ -510,6 +537,11 @@ static int xhci_plat_resume(struct device *dev)
 	return xhci_plat_resume_common(dev, PMSG_RESUME);
 }
 
+static int xhci_plat_thaw(struct device *dev)
+{
+	return xhci_plat_resume_common(dev, PMSG_THAW);
+}
+
 static int xhci_plat_restore(struct device *dev)
 {
 	return xhci_plat_resume_common(dev, PMSG_RESTORE);
@@ -539,9 +571,9 @@ static int __maybe_unused xhci_plat_runtime_resume(struct device *dev)
 const struct dev_pm_ops xhci_plat_pm_ops = {
 	.suspend = pm_sleep_ptr(xhci_plat_suspend),
 	.resume = pm_sleep_ptr(xhci_plat_resume),
-	.freeze = pm_sleep_ptr(xhci_plat_suspend),
-	.thaw = pm_sleep_ptr(xhci_plat_resume),
-	.poweroff = pm_sleep_ptr(xhci_plat_suspend),
+	.freeze = pm_sleep_ptr(xhci_plat_freeze),
+	.thaw = pm_sleep_ptr(xhci_plat_thaw),
+	.poweroff = pm_sleep_ptr(xhci_plat_poweroff),
 	.restore = pm_sleep_ptr(xhci_plat_restore),
 
 	SET_RUNTIME_PM_OPS(xhci_plat_runtime_suspend,
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 9e52179872a5..a3b8f799c5a4 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -465,6 +465,10 @@ struct usb_bus {
 					 * the ep queue on a short transfer
 					 * with the URB_SHORT_NOT_OK flag set.
 					 */
+	unsigned disable_suspend2ram:1; /* Disables the "suspend-to-RAM" system
+					 * power management of USB devices on this
+					 * bus and their hcd.
+					 */
 	unsigned no_sg_constraint:1;	/* no sg constraint */
 	unsigned sg_tablesize;		/* 0 or largest number of sg list entries */
 
-- 
2.43.0.594.gd9cf4e227d-goog


