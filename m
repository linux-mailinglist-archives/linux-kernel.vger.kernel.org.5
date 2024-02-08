Return-Path: <linux-kernel+bounces-58638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6D384E935
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 112D6B27FA8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B679383AF;
	Thu,  8 Feb 2024 19:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lybLQk+Y"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31CA383B0
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 19:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707422201; cv=none; b=EwRXhgUPUEnWN0ljpVFde87GWsodVTbTl592iURP/TV1dvsBsOFIL+VKXM5bjT13KQ2ko60a+an3aWrizQe4GhQVMV0B/5W878GDuzrpL743mnydLA7rH0C+LjrNvXy9VpV/7I0j/ghG5e8nkymUC9l7SmdDXVsz7Y5YpfsWFLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707422201; c=relaxed/simple;
	bh=YuOGVyhQ0G/NAULkmFSuiReHREPJ7BzhTsSx1dgiFmI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J9Fw+dcbGruiBsSjrXFVXHdAa693hIzh+p8h9XamE3vGzKbfHhwRK8f6v5DGwZTS4BY2wPH/2u8AUSWcgZkzsH1QIcAIyNMBcdvIgf+FL7FY48h3v4WZJVrQaM1ZiZpqycNEvA0Fz3LmgsNTaSGQOL/W0jOTImM8KUxn4A4mhmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pranavpp.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lybLQk+Y; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pranavpp.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6047a047f58so4738187b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 11:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707422198; x=1708026998; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zaRZ3wf2NZjQHPcjuUdcp3FA76JczLwqBxReMfEbU8g=;
        b=lybLQk+YXOmdWEd308D+V3i9jp2QP3QsNjkjSX9FJrbU69f63Zk2Kiu7/FdJYTX+2B
         DgvCR0CfiiMaYM0fu5e3/pMP+NUSMnGKQGCKcCKMcyqyQjNynXuZ2gm4Hd+ZOn3IAiEW
         KZkjAV4/SwFsW2IUZgbnX2uzDmHWDMvSJOa8430EGPUgAkc7/liTzgV66bAOsKfV9k6l
         Fw57rhYXtDXvswcK/f3ENzK4Uk5UrG78/iJn7tGVFUf4l+siZ449WuEXwxZBaSWzquMc
         L6PRj9xj+EMMjEN/l9kEYYX9o7MmsHCWK3gNtjIumCy7vGPtAosVboQccwklYJ3iMro0
         rAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707422198; x=1708026998;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zaRZ3wf2NZjQHPcjuUdcp3FA76JczLwqBxReMfEbU8g=;
        b=pwF+m0SATDSl3CDzIvNMC8ZQs+ar2xxcoNHMXHxwOiOGaSgF2lLaTtENrVAWdhAlUW
         J+OMg42vTxnOnsqj4rfxQelaU/dwL7Mdkp7egNMolZOsNJIWR/Nt2yb3ic1p0GRNdty7
         Zb7CxEDSc6VOlLovjrvqZIIRtjjpWaYn2Jhz5LKFCuF0iHeBij4gGh/3B0fdPfeGr5Pl
         +G9n3D1LbapmFGoxbofU8WuBaeFTNcMs7L7eqjZrVgu5QXAJSBAN3kN44gYmuIgJI911
         vo9wMROl3mFSrTY1FeXeJ3VUOdwDDzOsUYbCraW2xHg+PULjOePIstrraus1e0ijJin/
         1KHA==
X-Gm-Message-State: AOJu0YxN8jTPXhok6hz203IYWYFddVYvItDRy7LHrf2GTO39uusgyh8S
	Yt7XAfYdK2eLkiJbVXhqJumfQ+FbgRBtrLFueVXGxI7IlJpauuQueK+k429xbbXeVDnIxC0be40
	5kAU3au0YEQ==
X-Google-Smtp-Source: AGHT+IHcIXKw7zl+teeHhdy4TToU5LqR0glGb5C5kPg/CcccRCV04XsiPSsIlrEAYZZ5RsUQwIVMT/capuezcQ==
X-Received: from pranav-first.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:390b])
 (user=pranavpp job=sendgmr) by 2002:a0d:d583:0:b0:604:5ca:5ab2 with SMTP id
 x125-20020a0dd583000000b0060405ca5ab2mr75992ywd.9.1707422198703; Thu, 08 Feb
 2024 11:56:38 -0800 (PST)
Date: Thu,  8 Feb 2024 19:56:21 +0000
In-Reply-To: <20240208195622.758765-1-pranavpp@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208195622.758765-1-pranavpp@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240208195622.758765-2-pranavpp@google.com>
Subject: [PATCH v2 1/2] alarmtimer: Create alarmtimer sysfs to make duration
 of kernel suspend check configurable
From: Pranav Prasad <pranavpp@google.com>
To: tglx@linutronix.de, jstultz@google.com, sboyd@kernel.org
Cc: linux-kernel@vger.kernel.org, krossmo@google.com, 
	Pranav Prasad <pranavpp@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, the alarmtimer_suspend does not allow the kernel
to suspend if the next alarm is within 2 seconds.
Create alarmtimer sysfs to make the value of 2 seconds configurable.
This allows flexibility to provide a different value based on the
type of device running the Linux kernel. As a data point, about 40% of
kernel suspend failures in a subset of Android devices were due to
this check. A differently configured value can avoid these suspend
failures which performs a lot of additional work affecting the
power consumption of these Android devices.

Signed-off-by: Pranav Prasad <pranavpp@google.com>
---
 kernel/time/alarmtimer.c | 61 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 4657cb8e8b1f..e4b88c8dc0e1 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -33,6 +33,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/alarmtimer.h>
 
+static const char alarmtimer_group_name[] = "alarmtimer";
+
 /**
  * struct alarm_base - Alarm timer bases
  * @lock:		Lock for syncrhonized access to the base
@@ -63,6 +65,56 @@ static struct rtc_timer		rtctimer;
 static struct rtc_device	*rtcdev;
 static DEFINE_SPINLOCK(rtcdev_lock);
 
+/* Duration to check for soonest alarm during kernel suspend */
+static unsigned long suspend_check_duration_ms = 2 * MSEC_PER_SEC;
+
+static ssize_t suspend_check_duration_show(struct kobject *kobj,
+			struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%lu\n", suspend_check_duration_ms);
+}
+
+static ssize_t suspend_check_duration_store(struct kobject *kobj,
+			struct kobj_attribute *attr, const char *buf, size_t n)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	suspend_check_duration_ms = val;
+
+	return n;
+}
+
+static struct kobj_attribute suspend_check_duration =
+			__ATTR_RW(suspend_check_duration);
+
+static struct attribute *alarmtimer_attrs[] = {
+	&suspend_check_duration.attr,
+	NULL,
+};
+
+static const struct attribute_group alarmtimer_attr_group = {
+	.name	= alarmtimer_group_name,
+	.attrs	= alarmtimer_attrs,
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
  * alarmtimer_get_rtcdev - Return selected rtcdevice
  *
@@ -98,8 +150,11 @@ static int alarmtimer_rtc_add_device(struct device *dev)
 
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
@@ -279,8 +334,8 @@ static int alarmtimer_suspend(struct device *dev)
 	if (min == 0)
 		return 0;
 
-	if (ktime_to_ns(min) < 2 * NSEC_PER_SEC) {
-		pm_wakeup_event(dev, 2 * MSEC_PER_SEC);
+	if (ktime_to_ns(min) < suspend_check_duration_ms * NSEC_PER_MSEC) {
+		pm_wakeup_event(dev, suspend_check_duration_ms);
 		return -EBUSY;
 	}
 
-- 
2.43.0.687.g38aa6559b0-goog


