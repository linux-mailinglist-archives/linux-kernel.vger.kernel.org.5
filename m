Return-Path: <linux-kernel+bounces-64970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0F4854544
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C292909AD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2ED217571;
	Wed, 14 Feb 2024 09:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EspVej7R"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6348B12B69
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903018; cv=none; b=n7vOjj9ZMdnm56BKvUXMb81JteEyOu7R2CPRXNeTUAQWByZVYwWiz1I7LmJYDW7oUvf/V7hNgKl/zG+8fgVOi/pVDzAupCTthgo7NX+jBk43BwbKFn+vY93yF+KbXlT8IwEq9eMnBaw1YClpRj45DcWjpebR5IbvSqM5ikv3Dyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903018; c=relaxed/simple;
	bh=0sbOqlYgKuYMYuenntCpahB0mOEu7ATewBc2h8dzDgg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qBCDIl9DKa9Bnv0Gpk589Rh7nC5fZgM4T0BNZRIPmsk2VzSwVwW3OYUyH8M91GCntUv7pykopXBCAGV7jek51ZPlWu/UG9dW0LiDv4A9dm4KNr5CkSVbcjFBxlzJK9acHjWvjdXZAiuhaAkuWX2ShQ9Ow3z1s5M1vVUNWiCkQRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pranavpp.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EspVej7R; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pranavpp.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf216080f5so8377250276.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707903015; x=1708507815; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gJBAQ5NDq5JSH9VWfJvPqqJU+MxkFsGwwmLKeuSdh/k=;
        b=EspVej7RJH1F+MlajvtpRMhK9DI1TKsrVxBtepsf6AvCL7yqxqtu9XCbNqY5t9/Cf/
         sJ9ZW6CpyXXefhLIrEF+GXEQ7U7zuD8wcls3W8EqAIclbUTyin4x19Z5PkqcQDvUhGdr
         o9HsdUQImHXV9vYnUlWWl9k8xu8DIoM0iaiL0Eft0/XWwsRYZdDSNAvZ0v5nwutzVfxg
         TBnj+OCvXUK5lXULY6/H2dJCgICcGPgiu2ZoDZsTIrRnIj6mjDf/DORInOZaXTLUbqZs
         TaNPXrv+6kueAznQJWQAVin0BS9Iz+wSpcAw1srLQCuUC6Lfg/y4mHmBq0Y8IsYdYlhA
         at8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707903015; x=1708507815;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gJBAQ5NDq5JSH9VWfJvPqqJU+MxkFsGwwmLKeuSdh/k=;
        b=TYTeffhlBKmA3frCs91wM9345zdDmIboHgHdKMO6mP9txbwmd2CPFBg9UvUv9YE9oZ
         zeTtJnW67MAuIzsUAMzLX2ARzHNP7N8rmwOnLEfm2xnKCWDBRKltq8uG1aPQlopS44o2
         6xZKV8DSPMeqnhGKJp8iAjpTwCe5qlkdD4tGIGYFQXiJuYbGm04NZdGaPrZyLZsEhU0H
         OxjeNuYSB+1lR+KBtIwQot4SR0xULaJMXpdLqgcXgFSmcii/w90WzZcQfPYDfza9efBt
         A/DzAxk6kd1dFWKyB5DBbMOA3o5pew+d+ZUgVZt/FnHRXC5+zcUhtZDU2QA4La9We0Ig
         YlXg==
X-Gm-Message-State: AOJu0YyiwGdJ5gKM68JtSMDqXrP8gGzqdSr5X69DhbTbKxdLy/rgtPdG
	uB+dqDV1hWqyesJ9SxvkgiT3WnP3MQH/FiWW6UNo6JanwLnXOy8L0vKtmEhTVdp7mmUjPu5Pc+J
	uSb+f761s9A==
X-Google-Smtp-Source: AGHT+IHwPGosCFYzXixzK4uFt0LDPTYvPF+MLTwF71VxaOkMvtS5etq7RRoJc7IPknUUKOHvzhGVYDNv1m0Z8g==
X-Received: from pranav-first.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:390b])
 (user=pranavpp job=sendgmr) by 2002:a25:3619:0:b0:dc6:c2e4:5126 with SMTP id
 d25-20020a253619000000b00dc6c2e45126mr406705yba.12.1707903015399; Wed, 14 Feb
 2024 01:30:15 -0800 (PST)
Date: Wed, 14 Feb 2024 09:29:01 +0000
In-Reply-To: <20240214092902.1908443-1-pranavpp@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214092902.1908443-1-pranavpp@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240214092902.1908443-2-pranavpp@google.com>
Subject: [PATCH v3 1/2] alarmtimer: Add PM notifier to check early for
 imminent alarm
From: Pranav Prasad <pranavpp@google.com>
To: tglx@linutronix.de, jstultz@google.com, sboyd@kernel.org
Cc: linux-kernel@vger.kernel.org, krossmo@google.com, 
	Pranav Prasad <pranavpp@google.com>
Content-Type: text/plain; charset="UTF-8"

The alarmtimer driver currently fails suspend attempts when there is an
alarm pending within the next 2 seconds, since the system is expected to
wake up soon anyway. The entire suspend process is initiated even though
the system will immediately awaken. This process includes substantial work
before the suspend fails and additional work afterwards to undo the failed
suspend that was attempted. Therefore on battery-powered devices that
initiate suspend attempts from userspace, it may be advantageous to be
able to fail the suspend earlier in the suspend flow to avoid power
consumption instead of unnecessarily doing extra work. As one data point,
an analysis of a subset of Android devices showed that imminent alarms
account for roughly 40% of all suspend failures on average leading to
unnecessary power wastage.

To facilitate this, register a PM notifier in the alarmtimer subsystem
that checks if an alarm is imminent during the prepare stage of kernel
suspend denoted by the event PM_SUSPEND_PREPARE. If an alarm is imminent,
it returns the errno code ETIME instead of EBUSY to userspace in order to
make it easily diagnosable.

Signed-off-by: Pranav Prasad <pranavpp@google.com>
---
 kernel/time/alarmtimer.c | 100 +++++++++++++++++++++++++++++++--------
 1 file changed, 79 insertions(+), 21 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 4657cb8e8b1f..366ca3568f87 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -27,6 +27,7 @@
 #include <linux/compat.h>
 #include <linux/module.h>
 #include <linux/time_namespace.h>
+#include <linux/suspend.h>
 
 #include "posix-timers.h"
 
@@ -63,6 +64,78 @@ static struct rtc_timer		rtctimer;
 static struct rtc_device	*rtcdev;
 static DEFINE_SPINLOCK(rtcdev_lock);
 
+/**
+ * alarmtimer_get_soonest - Finds the soonest alarm to expire among the
+ * alarm bases.
+ * @min: ptr to relative time to the soonest alarm to expire
+ * @expires: ptr to absolute time of the soonest alarm to expire
+ * @type: ptr to alarm type
+ *
+ * Returns true if soonest alarm was found, returns false if don't care.
+ */
+static bool alarmtimer_get_soonest(ktime_t *min,
+				   ktime_t *expires, int *type)
+{
+	unsigned long flags;
+	int i;
+
+	/* Find the soonest timer to expire */
+	for (i = 0; i < ALARM_NUMTYPE; i++) {
+		struct alarm_base *base = &alarm_bases[i];
+		struct timerqueue_node *next;
+		ktime_t delta;
+
+		spin_lock_irqsave(&base->lock, flags);
+		next = timerqueue_getnext(&base->timerqueue);
+		spin_unlock_irqrestore(&base->lock, flags);
+		if (!next)
+			continue;
+		delta = ktime_sub(next->expires, base->get_ktime());
+		if (*min == 0 || delta < *min) {
+			*expires = next->expires;
+			*min = delta;
+			*type = i;
+		}
+	}
+
+	if (*min == 0)
+		return false;
+
+	return true;
+}
+
+static int alarmtimer_pm_callback(struct notifier_block *nb,
+				  unsigned long mode, void *_unused)
+{
+	struct rtc_device *rtc;
+	ktime_t min, expires;
+	int type;
+
+	switch (mode) {
+	case PM_SUSPEND_PREPARE:
+		rtc = alarmtimer_get_rtcdev();
+		/* If we have no rtcdev, just return */
+		if (!rtc)
+			return NOTIFY_DONE;
+
+		/* Find the soonest timer to expire */
+		if (!alarmtimer_get_soonest(&min, &expires, &type))
+			return NOTIFY_DONE;
+
+		if (ktime_to_ns(min) < 2 * NSEC_PER_SEC) {
+			pr_debug("Suspend abort due to imminent alarm\n");
+			pm_wakeup_event(&rtc->dev, 2 * MSEC_PER_SEC);
+			return notifier_from_errno(-ETIME);
+		}
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block alarmtimer_pm_notifier = {
+	.notifier_call = alarmtimer_pm_callback,
+};
+
 /**
  * alarmtimer_get_rtcdev - Return selected rtcdevice
  *
@@ -126,6 +199,7 @@ static int alarmtimer_rtc_add_device(struct device *dev)
 static inline void alarmtimer_rtc_timer_init(void)
 {
 	rtc_timer_init(&rtctimer, NULL, NULL);
+	register_pm_notifier(&alarmtimer_pm_notifier);
 }
 
 static struct class_interface alarmtimer_rtc_interface = {
@@ -241,10 +315,10 @@ EXPORT_SYMBOL_GPL(alarm_expires_remaining);
 static int alarmtimer_suspend(struct device *dev)
 {
 	ktime_t min, now, expires;
-	int i, ret, type;
 	struct rtc_device *rtc;
 	unsigned long flags;
 	struct rtc_time tm;
+	int ret, type;
 
 	spin_lock_irqsave(&freezer_delta_lock, flags);
 	min = freezer_delta;
@@ -258,30 +332,14 @@ static int alarmtimer_suspend(struct device *dev)
 	if (!rtc)
 		return 0;
 
-	/* Find the soonest timer to expire*/
-	for (i = 0; i < ALARM_NUMTYPE; i++) {
-		struct alarm_base *base = &alarm_bases[i];
-		struct timerqueue_node *next;
-		ktime_t delta;
-
-		spin_lock_irqsave(&base->lock, flags);
-		next = timerqueue_getnext(&base->timerqueue);
-		spin_unlock_irqrestore(&base->lock, flags);
-		if (!next)
-			continue;
-		delta = ktime_sub(next->expires, base->get_ktime());
-		if (!min || (delta < min)) {
-			expires = next->expires;
-			min = delta;
-			type = i;
-		}
-	}
-	if (min == 0)
+	/* Find the soonest timer to expire */
+	if (!alarmtimer_get_soonest(&min, &expires, &type))
 		return 0;
 
 	if (ktime_to_ns(min) < 2 * NSEC_PER_SEC) {
+		pr_debug("Suspend abort due to imminent alarm\n");
 		pm_wakeup_event(dev, 2 * MSEC_PER_SEC);
-		return -EBUSY;
+		return -ETIME;
 	}
 
 	trace_alarmtimer_suspend(expires, type);
-- 
2.43.0.687.g38aa6559b0-goog


