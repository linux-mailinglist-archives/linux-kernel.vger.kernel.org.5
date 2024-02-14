Return-Path: <linux-kernel+bounces-64971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0520E854545
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A37A1C25830
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888AC18633;
	Wed, 14 Feb 2024 09:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xp7RErj1"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6EB1643E
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903019; cv=none; b=o63Orr1HRfC0LRS1EPUCfhyydzJu3Vjyh4uwrB47KpBgFASyf39iDAUyH0Pdh7JPDKw19EKrQz8v+2g1rQKq8ElLlzlSJqorH523pWzlEBqpQI6qTgfKrBQoCqqp2lS3dswmXWA0tltxahflUkOKruDvRZoEMQXwDWUagH1tI90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903019; c=relaxed/simple;
	bh=jNtQz+owYOLm3MkN2mpaPOkCW0/vAPSlEGfcoArUtWE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kAIrGLYUAZmKwT3elAkXmAVMtHQbcQmFCKA61nW7SktLMAY/kfmfHhR98tAP5AQusBwtkMl01EC1V7Ug2Yh0FvtvfG4NepXxjgqn6pCoItvFtM9DjX3D/2oK1FV4hQNIUapQEmgVFIZdldj7i2g3K7lp1EDA1z18dY160Oh1S7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pranavpp.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xp7RErj1; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pranavpp.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6077ec913f0so39993577b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707903017; x=1708507817; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mKxGRkg+AXU4O8sjeZUwM8p4zzY+fxcXGuSAzHn2RVs=;
        b=xp7RErj1vC03IjNj4N4B8YwY8nU9Zonl2e/ZxSmXBjC1BMSuR7rbswNvnJ8MBE0kb+
         SFR7pOiGa018wkMAP02yR6LEfI9jyym5RtcWBGd2ZQ1c3bnl/1kEgGR4Z9KhQCrAvDYN
         ZNnON0biCUOtBoA0PmuCB5IVQh/ZH+WlKHTollYvDySeYM9yPkzdWAZAsibVWAv0m7ZK
         rDD8dXNVlYkLS8gr4Exa1c2JAJ7iIn4xTVNGT6nhZ1/NxFs8E/vE/cdPMBQLnRrmpYyu
         QlDQW2VTqjfFQHkzLSum5RaKw8NActCsdHGfWBaZZ1YgMqkvD1HGR1WHFZh9fUPXY847
         UAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707903017; x=1708507817;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mKxGRkg+AXU4O8sjeZUwM8p4zzY+fxcXGuSAzHn2RVs=;
        b=tYuc7cW+8OPz+txXHjy+nJ2DCTvQ53QaBjvCK6OZ2kIjYloM95i/zRm8TmkPPAZqL0
         PhnV5GQsR3xucQIuzOYtZcdMM0kbqfK45zPCMZclyRAkEAia11ik75qP8T8SaOn0jLS9
         AJX0MNYFG1+CodYDYteDXJiGctBi/KdPE0+eHVgWHBUL+SqgWBwdk/XKhaTuW0PzNLz2
         YbhwRZ1s1InFKBQppB/0YuHnO6VQIIKCQkhGv4CaugWGR+2KcaZcAlXy4xnm4Vpe+hBw
         uah0Ppz0FH5acM/5wTm3xbjSfJwbSvOlUUJIZ31Wykw9Cd4wlDTTxReOqQ3jcaXe8V55
         QqBQ==
X-Gm-Message-State: AOJu0YygWMjo/AxeDiFPtDY3p7KZvWmcIQKQaTRljJBxVJZ57IPC/X+M
	YELvZCK0EhjBmbAkhSR8HR2M8qWTQWZGzjiBhmr8NJVL1d/N3VOuPIQ7Ekzq+QkalzWaF8LtZQf
	NbsXUz1JuUg==
X-Google-Smtp-Source: AGHT+IEv8GrwP/i3IsbR+vfs1v3w4X7af5ZTo88vxdHwCynHVQGYRsE17F1QmaaYb3at+54Za53Il6pLr9Ly4g==
X-Received: from pranav-first.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:390b])
 (user=pranavpp job=sendgmr) by 2002:a05:6902:1811:b0:dc6:dfc6:4207 with SMTP
 id cf17-20020a056902181100b00dc6dfc64207mr455834ybb.10.1707903017135; Wed, 14
 Feb 2024 01:30:17 -0800 (PST)
Date: Wed, 14 Feb 2024 09:29:02 +0000
In-Reply-To: <20240214092902.1908443-1-pranavpp@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214092902.1908443-1-pranavpp@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240214092902.1908443-3-pranavpp@google.com>
Subject: [PATCH v3 2/2] alarmtimer: Create sysfs to make alarm check window configurable
From: Pranav Prasad <pranavpp@google.com>
To: tglx@linutronix.de, jstultz@google.com, sboyd@kernel.org
Cc: linux-kernel@vger.kernel.org, krossmo@google.com, 
	Pranav Prasad <pranavpp@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, the alarmtimer_suspend does not allow the kernel
to suspend if the next alarm is within 2 seconds. Instead, a configurable
value for the window to check the next pending alarm allows developers
to change the value according to their specific device and use case.
As an example, on Android devices if the value is changed to the short
suspend threshold used in Android's SuspendControlService, it is expected
to lower power consumption during kernel suspend.

The value to be configured needs to be found experimentally based on the
device and use case. The current value of 2 seconds will continue to be
used as the default if no changes are made. If the value is configured to
be very small, there may be a pending alarm that would wake the system up
right after the successful kernel suspend, which would devalue the
benefits of having the check. If the value is configured to be very large,
the kernel suspend would be aborted regularly which would cause to lose
the benefits of kernel suspension in general. Therefore, the value
should not lean too much in either direction.

To facilitate this, create alarmtimer sysfs to make the value of
2 seconds configurable.

Signed-off-by: Pranav Prasad <pranavpp@google.com>
---
 kernel/time/alarmtimer.c | 70 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 64 insertions(+), 6 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 366ca3568f87..d11f8cb945c2 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -34,6 +34,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/alarmtimer.h>
 
+static const char alarmtimer_group_name[] = "alarmtimer";
+
 /**
  * struct alarm_base - Alarm timer bases
  * @lock:		Lock for syncrhonized access to the base
@@ -64,6 +66,56 @@ static struct rtc_timer		rtctimer;
 static struct rtc_device	*rtcdev;
 static DEFINE_SPINLOCK(rtcdev_lock);
 
+/* Duration to check for soonest alarm during kernel suspend */
+static unsigned long suspend_alarm_pending_window_ms = 2 * MSEC_PER_SEC;
+
+static ssize_t suspend_alarm_pending_window_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%lu\n", suspend_alarm_pending_window_ms);
+}
+
+static ssize_t suspend_alarm_pending_window_store(struct kobject *kobj,
+			struct kobj_attribute *attr, const char *buf, size_t n)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	suspend_alarm_pending_window_ms = val;
+
+	return n;
+}
+
+static struct kobj_attribute suspend_alarm_pending_window =
+			__ATTR_RW(suspend_alarm_pending_window);
+
+static struct attribute *alarmtimer_attrs[] = {
+	&suspend_alarm_pending_window.attr,
+	NULL,
+};
+
+static const struct attribute_group alarmtimer_attr_group = {
+	.name   = alarmtimer_group_name,
+	.attrs  = alarmtimer_attrs,
+};
+
+/**
+ * alarmtimer_sysfs_add - Adds sysfs attributes for alarmtimer
+ *
+ * Returns 0 if successful, non-zero value for error.
+ */
+static int alarmtimer_sysfs_add(void)
+{
+	int ret = sysfs_create_group(kernel_kobj, &alarmtimer_attr_group);
+
+	if (ret)
+		pr_warn("[%s] failed to create a sysfs group\n", __func__);
+
+	return ret;
+}
+
 /**
  * alarmtimer_get_soonest - Finds the soonest alarm to expire among the
  * alarm bases.
@@ -105,7 +157,7 @@ static bool alarmtimer_get_soonest(ktime_t *min,
 }
 
 static int alarmtimer_pm_callback(struct notifier_block *nb,
-			    	  unsigned long mode, void *_unused)
+				  unsigned long mode, void *_unused)
 {
 	struct rtc_device *rtc;
 	ktime_t min, expires;
@@ -122,9 +174,11 @@ static int alarmtimer_pm_callback(struct notifier_block *nb,
 		if (!alarmtimer_get_soonest(&min, &expires, &type))
 			return NOTIFY_DONE;
 
-		if (ktime_to_ns(min) < 2 * NSEC_PER_SEC) {
+		if (ktime_to_ns(min) <
+		    suspend_alarm_pending_window_ms * NSEC_PER_MSEC) {
 			pr_debug("Suspend abort due to imminent alarm\n");
-			pm_wakeup_event(&rtc->dev, 2 * MSEC_PER_SEC);
+			pm_wakeup_event(&rtc->dev,
+					suspend_alarm_pending_window_ms);
 			return notifier_from_errno(-ETIME);
 		}
 	}
@@ -171,8 +225,11 @@ static int alarmtimer_rtc_add_device(struct device *dev)
 
 	pdev = platform_device_register_data(dev, "alarmtimer",
 					     PLATFORM_DEVID_AUTO, NULL, 0);
-	if (!IS_ERR(pdev))
+	if (!IS_ERR(pdev)) {
 		device_init_wakeup(&pdev->dev, true);
+		if (alarmtimer_sysfs_add())
+			pr_warn("[%s] Failed to add alarmtimer sysfs attributes\n", __func__);
+	}
 
 	spin_lock_irqsave(&rtcdev_lock, flags);
 	if (!IS_ERR(pdev) && !rtcdev) {
@@ -336,9 +393,10 @@ static int alarmtimer_suspend(struct device *dev)
 	if (!alarmtimer_get_soonest(&min, &expires, &type))
 		return 0;
 
-	if (ktime_to_ns(min) < 2 * NSEC_PER_SEC) {
+	if (ktime_to_ns(min) <
+	    suspend_alarm_pending_window_ms * NSEC_PER_MSEC) {
 		pr_debug("Suspend abort due to imminent alarm\n");
-		pm_wakeup_event(dev, 2 * MSEC_PER_SEC);
+		pm_wakeup_event(dev, suspend_alarm_pending_window_ms);
 		return -ETIME;
 	}
 
-- 
2.43.0.687.g38aa6559b0-goog


