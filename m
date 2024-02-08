Return-Path: <linux-kernel+bounces-58640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C777E84E936
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397371F306BE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B28381D9;
	Thu,  8 Feb 2024 19:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3tlsG2bE"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6236F3C06A
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 19:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707422211; cv=none; b=UcrOOjbiAa5ouFBe0yu2l854HyL3fTjqf7dGo5VkOgzcnpJa5W7AX89as+HIjGAutWlAPoxPRz3IGbHMWq7tQTuTOLZH2UdLH6hLaKyoxycBIVIi/aFAcXhz4hZvYhfyV7H+9Kt56DRutEW7kyk0zvk492I87pC1vnjfLyYKmiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707422211; c=relaxed/simple;
	bh=hR3uFrKpWs9ZL5wZZwmaEE6pKEDdze82pyxCfRxki4c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GZQd7wvS2jVZgzKZXem+sypMQX1sy+NIHKHS0xFjqykouLkOSEjfQHXDAtt/N7CN9q1gXHBMW+KwZDchc4T2P9j7zMHOP8hd8lwPj5/l0r8yQMF2IQokSTTXvGaskV4Uo+JJARcrDpxm2i24oQhjs+KxrznFyHQggJ8C+n9VxiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pranavpp.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3tlsG2bE; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pranavpp.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc746178515so327537276.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 11:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707422208; x=1708027008; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TnQJCTWx6Sm6QL8V28Ci6hAsHnK1z9M5vvlKvn8fEaM=;
        b=3tlsG2bEDzZe6ws47zQk83wbJyBz86sgPT3z1VFIGeOj2TRs4bYRqXAdiTeMCL71LQ
         UnulDlDtkqE/ZKhhOGQqWGI4AI1yXpmcmQ1lHtm0SK6j8Z3Cr6gqjgXcr0HeMfx1wVam
         4iA6SrQBx1rcSEt8lTPz7Gmi+dt5ee8zcUCLDyiVawKOGdyVIaLQO1EjunanOeTx++kh
         DTI8mVkDWAXkI/i19gYDE9o9udODxPPK5ahQSSBj6spnrPcgw+CCY0PM7IxIhDn98dSJ
         AJvLuJ3wPrMR+KU7WqWm5lsYwbtRj1j6hva/s5KZhx1jTpDlVuETqgrsRbcaJ5esoGdy
         mqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707422208; x=1708027008;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TnQJCTWx6Sm6QL8V28Ci6hAsHnK1z9M5vvlKvn8fEaM=;
        b=exwDKjFoSy9uI7jeZZZ22X+VPWqfGZmMx2liPxoNZqZQG0KP6V8PfLt5T7nvL4rQ4g
         sZaJu9OOFKA4qBenM+oRxY/As2jRxLV3Hvar+Aw5Pa+9DPXsknDw0Kh2CwQ+BMPqITnQ
         pPsaHP3X6lnSHfag11x+cJt+IpMYlR6RdDy3g4frg8ImuhyOYBWME/dqzBFaw3GZpvpK
         jRdUhqn94a1pVwWGgyR1O8adZHBaKhe7yjDy28fwmW44xQkvkTp27UbzTuVNpl+NCajT
         k+REnR/ht17Vy++8hpoi6VttKJm5Mbw5PdeoQAbqVQovHKPPMV5y9fui5t2dofapzgcS
         50JA==
X-Gm-Message-State: AOJu0YzMB41S6IjqRAla5+UdzA/idG2xbnQAQkYiKBXCoI9giJqOuiMZ
	o80gpwxIZbB9GeM7/JudDQT8ofhnNtopzwrLEbKTXi/eOaUefWYYeMdZHdNB9WOvgM9jDp9wkXW
	oZ1dOJH1BTA==
X-Google-Smtp-Source: AGHT+IHrUSklj3s46v5/6PED0ma7fS6zz4j3DzgOp9FJi/0xi5qjqmjSVHsTauOqOqBVwo38tscyJ+fvEK0+YA==
X-Received: from pranav-first.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:390b])
 (user=pranavpp job=sendgmr) by 2002:a05:6902:1108:b0:dc7:49a9:6666 with SMTP
 id o8-20020a056902110800b00dc749a96666mr120837ybu.3.1707422208265; Thu, 08
 Feb 2024 11:56:48 -0800 (PST)
Date: Thu,  8 Feb 2024 19:56:22 +0000
In-Reply-To: <20240208195622.758765-1-pranavpp@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208195622.758765-1-pranavpp@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240208195622.758765-3-pranavpp@google.com>
Subject: [PATCH v2 2/2] alarmtimer: Modify alarmtimer suspend callback to
 check for imminent alarm using PM notifier
From: Pranav Prasad <pranavpp@google.com>
To: tglx@linutronix.de, jstultz@google.com, sboyd@kernel.org
Cc: linux-kernel@vger.kernel.org, krossmo@google.com, 
	Pranav Prasad <pranavpp@google.com>
Content-Type: text/plain; charset="UTF-8"

The alarmtimer driver currently fails suspend attempts when there is an
alarm pending within the next suspend_check_duration_ns nanoseconds, since
the system is expected to wake up soon anyway. The entire suspend process
is initiated even though the system will immediately awaken. This process
includes substantial work before the suspend fails and additional work
afterwards to undo the failed suspend that was attempted. Therefore on
battery-powered devices that initiate suspend attempts from userspace, it
may be advantageous to be able to fail the suspend earlier in the suspend
flow to avoid power consumption instead of unnecessarily doing extra work.
As one data point, an analysis of a subset of Android devices showed that
imminent alarms account for roughly 40% of all suspend failures on average
leading to unnecessary power wastage.

To facilitate this, register a PM notifier in the alarmtimer subsystem
that checks if an alarm is imminent during the prepare stage of kernel
suspend denoted by the event PM_SUSPEND_PREPARE. If an alarm is imminent,
it returns the errno code ETIME instead of EBUSY to userspace in order to
make it easily diagnosable.

Signed-off-by: Pranav Prasad <pranavpp@google.com>
---
 kernel/time/alarmtimer.c | 126 +++++++++++++++++++++++++++------------
 1 file changed, 87 insertions(+), 39 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index e4b88c8dc0e1..809cfd97328d 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -27,6 +27,7 @@
 #include <linux/compat.h>
 #include <linux/module.h>
 #include <linux/time_namespace.h>
+#include <linux/suspend.h>
 
 #include "posix-timers.h"
 
@@ -115,6 +116,87 @@ static int alarmtimer_sysfs_add(void)
 	return ret;
 }
 
+/**
+ * alarmtimer_get_soonest - Finds the soonest alarm to expire among the
+ * alarm bases.
+ * @rtc: ptr to rtc_device struct
+ * @min: ptr to relative time to the soonest alarm to expire
+ * @expires: ptr to absolute time of the soonest alarm to expire
+ * @type: ptr to alarm type
+ *
+ * Returns 1 if soonest alarm was found, returns 0 if don't care.
+ */
+static int alarmtimer_get_soonest(struct rtc_device *rtc, ktime_t *min,
+					ktime_t *expires, int *type)
+{
+	int i;
+	unsigned long flags;
+
+	spin_lock_irqsave(&freezer_delta_lock, flags);
+	*min = freezer_delta;
+	*expires = freezer_expires;
+	*type = freezer_alarmtype;
+	freezer_delta = 0;
+	spin_unlock_irqrestore(&freezer_delta_lock, flags);
+
+	rtc = alarmtimer_get_rtcdev();
+	/* If we have no rtcdev, just return */
+	if (!rtc)
+		return 0;
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
+		if (!*min || delta < *min) {
+			*expires = next->expires;
+			*min = delta;
+			*type = i;
+		}
+	}
+
+	if (*min == 0)
+		return 0;
+
+	return 1;
+}
+
+static int alarmtimer_pm_callback(struct notifier_block *nb,
+			    unsigned long mode, void *_unused)
+{
+	ktime_t min, expires;
+	struct rtc_device *rtc = NULL;
+	int type;
+
+	switch (mode) {
+	case PM_SUSPEND_PREPARE:
+		/* Find the soonest timer to expire */
+		if (!alarmtimer_get_soonest(rtc, &min, &expires, &type))
+			return NOTIFY_DONE;
+
+		if (ktime_to_ns(min) <
+			suspend_check_duration_ms * NSEC_PER_MSEC) {
+			pr_warn("[%s] Suspend abort due to imminent alarm\n", __func__);
+			pm_wakeup_event(&rtc->dev, suspend_check_duration_ms);
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
@@ -181,6 +263,7 @@ static int alarmtimer_rtc_add_device(struct device *dev)
 static inline void alarmtimer_rtc_timer_init(void)
 {
 	rtc_timer_init(&rtctimer, NULL, NULL);
+	register_pm_notifier(&alarmtimer_pm_notifier);
 }
 
 static struct class_interface alarmtimer_rtc_interface = {
@@ -296,49 +379,14 @@ EXPORT_SYMBOL_GPL(alarm_expires_remaining);
 static int alarmtimer_suspend(struct device *dev)
 {
 	ktime_t min, now, expires;
-	int i, ret, type;
-	struct rtc_device *rtc;
-	unsigned long flags;
+	struct rtc_device *rtc = NULL;
 	struct rtc_time tm;
+	int ret, type;
 
-	spin_lock_irqsave(&freezer_delta_lock, flags);
-	min = freezer_delta;
-	expires = freezer_expires;
-	type = freezer_alarmtype;
-	freezer_delta = 0;
-	spin_unlock_irqrestore(&freezer_delta_lock, flags);
-
-	rtc = alarmtimer_get_rtcdev();
-	/* If we have no rtcdev, just return */
-	if (!rtc)
-		return 0;
-
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
+	if (!alarmtimer_get_soonest(rtc, &min, &expires, &type))
 		return 0;
 
-	if (ktime_to_ns(min) < suspend_check_duration_ms * NSEC_PER_MSEC) {
-		pm_wakeup_event(dev, suspend_check_duration_ms);
-		return -EBUSY;
-	}
-
 	trace_alarmtimer_suspend(expires, type);
 
 	/* Setup an rtc timer to fire that far in the future */
-- 
2.43.0.687.g38aa6559b0-goog


