Return-Path: <linux-kernel+bounces-56279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FF084C840
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD79E286262
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396462561D;
	Wed,  7 Feb 2024 10:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IeMtiH1Z"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F5D25602
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 10:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707300395; cv=none; b=YK5U2I5NciLs8OX/DW0H88QL/bDnpL4cKRBW4qNGUVOiMnidisXBOWmUlfp8M1MvzWg8Y8uyaW/cyMgB2g15FZ2bdQAwIpVzJeqq/AD3yQEK4DISx+/buBU8uUPkLW9o4UBS60K1kOEw2jYBxS3ipErkN+68Y1L/8g806c/T1ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707300395; c=relaxed/simple;
	bh=e+QYfe3EBAnFeI6C06KSlz6hgCpRzI0/cX5GEtPsNfg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fgf40/LemyrFGbzrv7xXxRSUoFDw//E7UIUu9HdiAnZnEUyoKwLJBrtb0FQnjPN9w2rE5nUQ5FzRY9M6VO3RjE/HlpyPEsEuFnUtbpR/QNi4GUHPf0DuV2vaZAwvN67PR7OnhzSSXzZN1nVWJmV/MtKdWOVGJvZIa0TWF0i0unQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pranavpp.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IeMtiH1Z; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pranavpp.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-296e09c305eso488152a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 02:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707300393; x=1707905193; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JHyxNaPCKju0suiGcb7YkRX+LpmSfcg8/gQ3kq3ldf8=;
        b=IeMtiH1ZN91C6+yvDyPuFLmRl+pabFaac/Lhm0oSRLDv3V3AbDbTIYzIDZAcgRIXo/
         rJVDYtBKLShXpVPFWMI51ur24FWRSvXZ2DMDJhgr3KxvJVJAloASj6NW8wl9hrYS+rUK
         ZzUglr3SExuyb+/5Fc9hAvfY+08Gxf4i3JpwAuGLUoBRz5F0caabMxP6AVkxM88MNSz/
         SmbZAvjklHC/juUS/iCXrlxmc2X48GXupNMYVB5mxPPZUbIZR4LQDw/9k5q4hoGZe9SC
         WpBYWMBMRq/EZTBwCQgw1MlEGfIBSF2WnZjTZHj0xc2uI0OOEI12CpO0T5NFVLzhOkYQ
         qLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707300393; x=1707905193;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JHyxNaPCKju0suiGcb7YkRX+LpmSfcg8/gQ3kq3ldf8=;
        b=jeilbY+gisMopPPsShT59sNWbHjBs+4mvi3WPExDrNhnP//nBzgOhAcbEUD6zgY8g/
         ui0fQue0qwu4SfPO25H3g93/+7yssWuwdkssBl/4HHkLVX0a5/KEmevJArNiC37UnIH5
         SIFdShHn9AbuGhtaYxPr0ZEIKhcYSllQlq9u3nyyYqx5FmW/FTDpw1/t99Y4rpj5sZg+
         owHkM+zAO6ii9yR1Pz2EATkmUfcBltTvpM+vPlk5v0CCBpbITSL2XZLvzGtg0MOmyOSm
         jxCN7YYP8YUwKBdymk4DRB+BZIXMfzMcY1VXZbB+UMQjejghWNDhgsPgaYrGoS0vKvCI
         0QfA==
X-Gm-Message-State: AOJu0YypjgjNLZkzXK2K6UUoM5Rl8kOlv3MdpbGKAp3JQXZy2pQ00zY/
	k/2ZWHGizKSLEe1ocd5x6uNEaRzMsEv4rMjLRlt6Kto1pfV+pmaVBP2ClwkVIpa4zyAomp+zhqU
	JK+gL99yxvw==
X-Google-Smtp-Source: AGHT+IFTya2ZyeZ/C36rVXr9zqm2bHORKHvP6G9MfSZoDZoGhxV1NyJpb+dnBDqe/z8HmrRbZ8laRTzSvJ3YXw==
X-Received: from pranav-first.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:390b])
 (user=pranavpp job=sendgmr) by 2002:a17:90a:cc3:b0:296:dd68:e4d4 with SMTP id
 3-20020a17090a0cc300b00296dd68e4d4mr36447pjt.3.1707300393162; Wed, 07 Feb
 2024 02:06:33 -0800 (PST)
Date: Wed,  7 Feb 2024 10:06:18 +0000
In-Reply-To: <20240207100619.3947442-1-pranavpp@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207100619.3947442-1-pranavpp@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240207100619.3947442-2-pranavpp@google.com>
Subject: [PATCH 1/2] alarmtimer: Create alarmtimer sysfs to make duration of
 kernel suspend check configurable
From: Pranav Prasad <pranavpp@google.com>
To: tglx@linutronix.de, jstultz@google.com, sboyd@kernel.org
Cc: linux-kernel@vger.kernel.org, Pranav Prasad <pranavpp@google.com>, 
	Kelly Rossmoyer <krossmo@google.com>
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
Signed-off-by: Kelly Rossmoyer <krossmo@google.com>
---
 kernel/time/alarmtimer.c | 61 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 4657cb8e8b1f..e5d2e560b4c1 100644
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
+static u64 suspend_check_duration_ns = 2 * NSEC_PER_SEC;
+
+static ssize_t suspend_check_duration_show(struct kobject *kobj,
+			struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n", suspend_check_duration_ns);
+}
+
+static ssize_t suspend_check_duration_store(struct kobject *kobj,
+			struct kobj_attribute *attr, const char *buf, size_t n)
+{
+	u64 val;
+
+	if (kstrtou64(buf, 10, &val))
+		return -EINVAL;
+
+	suspend_check_duration_ns = val;
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
+	if (ktime_to_ns(min) < suspend_check_duration_ns) {
+		pm_wakeup_event(dev, suspend_check_duration_ns/NSEC_PER_MSEC);
 		return -EBUSY;
 	}
 
-- 
2.43.0.594.gd9cf4e227d-goog


