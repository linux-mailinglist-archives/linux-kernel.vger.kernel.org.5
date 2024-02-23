Return-Path: <linux-kernel+bounces-78507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D08861448
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274FA1F21F41
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D388224CF;
	Fri, 23 Feb 2024 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OWopO9Si"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D612232D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699121; cv=none; b=BhMJWPZN8bcj94+NqXZE/2JOUMmMPpFb6Bb/iNbHX/6oHjAf/8KNu3ciqWiZm7ZwSohDRWXtyVRkVVT3bkdf+YopuF2iM2/NjHB6GFc0juGY5eHE0/qrzbjOc3ZgLyTzIA+IynuKRDrossw1TL5ROKBfgIbR60JXawSXrKxowT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699121; c=relaxed/simple;
	bh=lPpsf+ctjoERqolin0a9v4LZu/IJHVLvdotwrmjWYEw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Bpp1XCxiqpjll2iYtriyrnRx3Ln0IpbMQFfifGZO7MeQ1s1Uk7hNpayCNm+GFuxSPdLSrA1hVT5iE4neg6FvEdGVN122BT8lY5ntMYrpUAKF4AfM8YcdpoEseY+2Lv0HqTL34kVbaODt12zf0+lGB2ZjuFgwdL/KWqoPvwfdlYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OWopO9Si; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1dc685df4adso1844665ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 06:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708699119; x=1709303919; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xNKWGob6G7Q1K3q4m5EExpE7FnwHmLwzIXKPndEszZM=;
        b=OWopO9SiwfNI712UpmT9KlQlOq71/RcxWbeVzgm0tqIcADYPE8PzAyW1RSeb3XIP1N
         JzPbQDRdl0DYtPGmkdIfcdIZT1xxHBSPIE2IPCDeX6B/rTo/vAaKQkVWNLNi8TmAnxf+
         +04KncY6JJ4DPyuMkg1/nKGH3833WbhOB0y+KIAc7ArljiAwQ3jaX3jzsrAliINjy4OO
         5Bp5RWv3ZXe+YzAVXZcPcmgs2uTXbPEmKk8HgrkSUZVjJdaUp8y+KidxCE+mV7t8uRmx
         ERhriad7yvMukU1xEB7ahQw5NaFeLmmX6jidZUdiAwvtCVZPYYYXdoQCwaFJ8wp5vm8P
         wRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708699119; x=1709303919;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xNKWGob6G7Q1K3q4m5EExpE7FnwHmLwzIXKPndEszZM=;
        b=nsVxOIaJCBtvQ4h8fC62SPCvAtKcjRiOWKTmGMH6edPwrVe5Wn9aDFMYgbvNvSpNyu
         eMSQnB9BNayVqqr/XT34dUwAAMGpw0Rdyz8c0e7dnL9MKFzKGX6I4Cz0JxHJORCcd6mX
         bPED3wSA6/wbjQU2X07cKV26VL27F1rTlr/KUXzEBv6JfDzAveLxQbFtDzhQ5iI7JFaQ
         FQy4iwmFKssGKokRoCiQ51o1c6drUK9KaQOC8MJKlGwauK/xnYW+zeCWB2r4kxbT8Jge
         CS5BisKB3UD+eakxSfr9QiZOmynUPuk6IV0176HvYeIMjCChsz/dIE6zhPgwXY3etKxa
         mipg==
X-Gm-Message-State: AOJu0Yx4TKChuxyg6WSJNhWiOooS/rRfkXzbdt1qfWs9w/CyoO1mvWg+
	WJbR0vdNSISz8e8NsWg1hKQ1AtMU2MO+jKM0SBHaG9jD8P8aXMMyii5Zm3JYBqztcpovAZocINP
	OpICYwTF4ae5jgg==
X-Google-Smtp-Source: AGHT+IFTiGCoBvAgUBZXt0Q1pMETEIr1MdripTJ2jtoCm510pap6JTosXI3YJq6SK8nb/Qfn70+9sAtQJb1REBk=
X-Received: from guanyulin.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:1af])
 (user=guanyulin job=sendgmr) by 2002:a17:903:187:b0:1db:eec6:5b81 with SMTP
 id z7-20020a170903018700b001dbeec65b81mr6035plg.5.1708699118780; Fri, 23 Feb
 2024 06:38:38 -0800 (PST)
Date: Fri, 23 Feb 2024 14:38:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240223143833.1509961-1-guanyulin@google.com>
Subject: [PATCH v3] PM / core: conditionally skip system pm in device/driver model
From: Guan-Yu Lin <guanyulin@google.com>
To: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com, 
	gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com, 
	petr.tesarik.ext@huawei.com, rdunlap@infradead.org, james@equiv.tech, 
	broonie@kernel.org, james.clark@arm.com, masahiroy@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Guan-Yu Lin <guanyulin@google.com>
Content-Type: text/plain; charset="UTF-8"

In systems with a main processor and a co-processor, asynchronous
controller management can lead to conflicts.  One example is the main
processor attempting to suspend a device while the co-processor is
actively using it. To address this, we introduce a new sysfs entry
called "conditional_skip". This entry allows the system to selectively
skip certain device power management state transitions. To use this
feature, set the value in "conditional_skip" to indicate the type of
state transition you want to avoid.  Please review /Documentation/ABI/
testing/sysfs-devices-power for more detailed information.

Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
---
V2 -> V3: Integrate the feature with the pm core framework.
V1 -> V2: Cosmetics changes on coding style.
[v2] usb: host: enable suspend-to-RAM control in userspace
[v1] [RFC] usb: host: Allow userspace to control usb suspend flows
---
 Documentation/ABI/testing/sysfs-devices-power | 11 ++++++++
 drivers/base/power/main.c                     | 16 ++++++++++++
 drivers/base/power/sysfs.c                    | 26 +++++++++++++++++++
 include/linux/device.h                        |  7 +++++
 include/linux/pm.h                            |  1 +
 5 files changed, 61 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
index 54195530e97a..3ac4e40f07a0 100644
--- a/Documentation/ABI/testing/sysfs-devices-power
+++ b/Documentation/ABI/testing/sysfs-devices-power
@@ -305,3 +305,14 @@ Description:
 		Reports the runtime PM children usage count of a device, or
 		0 if the children will be ignored.
 
+What:		/sys/devices/.../power/conditional_skip
+Date:		Feburary 2024
+Contact:	Guan-Yu Lin <guanyulin@google.com>
+Description:
+		The /sys/devices/.../conditional_skip attribute provides a way
+		to selectively skip system-wide power transitions like
+		suspend-to-RAM or hibernation. To skip a specific transition,
+		write its corresponding value to this attribute. For skipping
+		multiple transitions, combine their values using a bitwise OR
+		and write the result to this attribute.
+
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index fadcd0379dc2..d507626c7892 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1881,6 +1881,7 @@ static int device_prepare(struct device *dev, pm_message_t state)
  */
 int dpm_prepare(pm_message_t state)
 {
+	struct list_head list;
 	int error = 0;
 
 	trace_suspend_resume(TPS("dpm_prepare"), state.event, true);
@@ -1900,12 +1901,26 @@ int dpm_prepare(pm_message_t state)
 	 */
 	device_block_probing();
 
+	INIT_LIST_HEAD(&list);
 	mutex_lock(&dpm_list_mtx);
 	while (!list_empty(&dpm_list) && !error) {
 		struct device *dev = to_device(dpm_list.next);
 
 		get_device(dev);
 
+		if (dev->power.conditional_skip_pm & state.event) {
+			dev_info(dev, "skip system PM transition (event = 0x%04x)\n",
+				 state.event);
+
+			if (!list_empty(&dev->power.entry))
+				list_move_tail(&dev->power.entry, &list);
+
+			mutex_unlock(&dpm_list_mtx);
+			put_device(dev);
+			mutex_lock(&dpm_list_mtx);
+			continue;
+		}
+
 		mutex_unlock(&dpm_list_mtx);
 
 		trace_device_pm_callback_start(dev, "", state.event);
@@ -1931,6 +1946,7 @@ int dpm_prepare(pm_message_t state)
 
 		mutex_lock(&dpm_list_mtx);
 	}
+	list_splice(&list, &dpm_list);
 	mutex_unlock(&dpm_list_mtx);
 	trace_suspend_resume(TPS("dpm_prepare"), state.event, false);
 	return error;
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index a1474fb67db9..1feacb01b1e9 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -610,6 +610,31 @@ static DEVICE_ATTR_RW(async);
 #endif /* CONFIG_PM_SLEEP */
 #endif /* CONFIG_PM_ADVANCED_DEBUG */
 
+static ssize_t conditional_skip_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	return sysfs_emit(buf, "0x%04x\n", dev->power.conditional_skip_pm);
+}
+
+static ssize_t conditional_skip_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t n)
+{
+	int ret;
+
+	if (kstrtoint(buf, 0, &ret))
+		return -EINVAL;
+
+	ret &= (PM_EVENT_FREEZE|PM_EVENT_SUSPEND|PM_EVENT_HIBERNATE);
+
+	dev->power.conditional_skip_pm = ret;
+
+	return n;
+}
+
+static DEVICE_ATTR_RW(conditional_skip);
+
 static struct attribute *power_attrs[] = {
 #ifdef CONFIG_PM_ADVANCED_DEBUG
 #ifdef CONFIG_PM_SLEEP
@@ -620,6 +645,7 @@ static struct attribute *power_attrs[] = {
 	&dev_attr_runtime_active_kids.attr,
 	&dev_attr_runtime_enabled.attr,
 #endif /* CONFIG_PM_ADVANCED_DEBUG */
+	&dev_attr_conditional_skip.attr,
 	NULL,
 };
 static const struct attribute_group pm_attr_group = {
diff --git a/include/linux/device.h b/include/linux/device.h
index 97c4b046c09d..f2c73dd00211 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -968,6 +968,13 @@ static inline void device_set_pm_not_required(struct device *dev)
 	dev->power.no_pm = true;
 }
 
+static inline void device_set_pm_conditional_skip(struct device *dev,
+						  int condition)
+{
+	condition &= (PM_EVENT_FREEZE|PM_EVENT_SUSPEND|PM_EVENT_HIBERNATE);
+	dev->power.conditional_skip_pm = condition;
+}
+
 static inline void dev_pm_syscore_device(struct device *dev, bool val)
 {
 #ifdef CONFIG_PM_SLEEP
diff --git a/include/linux/pm.h b/include/linux/pm.h
index a2f3e53a8196..890c7a601c2a 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -713,6 +713,7 @@ struct dev_pm_info {
 	enum rpm_status		last_status;
 	int			runtime_error;
 	int			autosuspend_delay;
+	int			conditional_skip_pm;
 	u64			last_busy;
 	u64			active_time;
 	u64			suspended_time;
-- 
2.44.0.rc0.258.g7320e95886-goog


