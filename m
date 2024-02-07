Return-Path: <linux-kernel+bounces-56281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E82284C844
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012781F24D0C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AC825779;
	Wed,  7 Feb 2024 10:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kezZJ3r3"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A691A25567
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 10:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707300400; cv=none; b=RdxmrI8K3LaJZtCr9Y8rAYfQk8BMszQAIK6BzPJVEUBRQNpx1k9REIohNJoVUuV6S23f57NwqUmmwR/+6aEPYSkfLewSqZZe5P77AT2ywTCPTE8+Lsv0NGCDxYSn6JXfY67DgPxJox2vC+xxCYFAmqzs13iZ6fUMHacTQtWsgrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707300400; c=relaxed/simple;
	bh=9L1TGEU45Ux6IE1/28h+r8bLolg1IHUK0dCIu0KT0ik=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L82nJYtihlAcMWaeJfMyHmfcG77zGaR7nN8SaKYsJZun5mX6DUAjd+815jx4DPbdtrXlwaUasQ9cdM0iloMjrTpMXBXo2xyNHz7wr092fMeauWavtYB4NCkEiaOdgTF4ZQWhgyTVTKfxPmaReO0L38qnd1aF3lixcKCFEEb2j64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pranavpp.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kezZJ3r3; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pranavpp.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6e05118feabso511725b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 02:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707300398; x=1707905198; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hibLsU9VPwJifCjSyfxgS+Y2Xj9FySfn0enbUMWfKnM=;
        b=kezZJ3r3EhXxvyw9YTGY+R3TpSjpEjguPToaXVL4I6ffe+TeteVPTpaxio1Xku3eUB
         TR7LhdgNCKIpFnW8CsJUp1BHPTk0V1jwFyXfmAJazDcxJcLDbm2FYUGj76MoZveBWtL8
         ZHqsHPtQ5nVaoj8yxlhlRV7S5C8PifpW9Ymt/TraC7lmAKWjCzPlCVoMeMmAS6HBKE1B
         X9bvX4hWc7T0UGlfe04VZ5/Gqd4o3OJ6GRKQCfpZWocy2vZnXgR8fMyRJuU3H2rqU/OW
         PMj+M/m2FHCMs0IGJcwMbZ5Clr2WHzpKArRP82wE/V9ASDedWYjvbvJOIGmvkMLYVzvo
         gUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707300398; x=1707905198;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hibLsU9VPwJifCjSyfxgS+Y2Xj9FySfn0enbUMWfKnM=;
        b=o7zYLmS1VKWZlyHpo6gfg6eH/UYyU30n+dpoZNTctFkR/k5snYX+91VGeopHAe5FIA
         /99BpnGpFtWColV3UUXdrmEy/NkzriUJndJJuMk5DF/0jbWfp2Ki5DtrQjkE4WjUW/9l
         vxEKi6JOOI63OcutIhfApdY48WhcefiE5LjXiI4B10UWm6IGxBFMzHtmnMNFOH37tH02
         UHC+p68j8GVtB5wiw3k2RcRUd/y5Yy1fC2oHi2PewenPrbrixLrADaLPQ4bDoNkXqC9m
         9FHy7+/WyTcWdyA1/HjgqvWzaFy4xlDYFWqn0P1qp8e5lGU9aavOGSdrks+HdHQ5t4b1
         d/rA==
X-Gm-Message-State: AOJu0YxP35qQtIrXtC/ye4B0UInRgzwo5opXpLnDo1bNQ19bsRP/kdEZ
	AJcthlN/S4AvONgI7Hn/WJ1DQGLhinmfIv3piLQsUqbsLVk3OaaPyniDR/E3tNbgDCbLtW3LDKE
	5AFtbTSmMgA==
X-Google-Smtp-Source: AGHT+IEk7gp7F6zx3HLFDVJcA/l0MKImgisNE12doNqdMuCQ88ZyEQfsss+eKg8IX9Z8YJ3BIoXAZFBbdvTsKg==
X-Received: from pranav-first.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:390b])
 (user=pranavpp job=sendgmr) by 2002:a05:6a00:228a:b0:6e0:2d2c:d2ec with SMTP
 id f10-20020a056a00228a00b006e02d2cd2ecmr82970pfe.0.1707300397931; Wed, 07
 Feb 2024 02:06:37 -0800 (PST)
Date: Wed,  7 Feb 2024 10:06:19 +0000
In-Reply-To: <20240207100619.3947442-1-pranavpp@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207100619.3947442-1-pranavpp@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240207100619.3947442-3-pranavpp@google.com>
Subject: [PATCH 2/2] alarmtimer: Modify alarmtimer suspend callback to
From: Pranav Prasad <pranavpp@google.com>
To: tglx@linutronix.de, jstultz@google.com, sboyd@kernel.org
Cc: linux-kernel@vger.kernel.org, Pranav Prasad <pranavpp@google.com>, 
	Kelly Rossmoyer <krossmo@google.com>
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
Signed-off-by: Kelly Rossmoyer <krossmo@google.com>
---
 kernel/time/alarmtimer.c | 121 ++++++++++++++++++++++++++++-----------
 1 file changed, 88 insertions(+), 33 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index e5d2e560b4c1..229de937c266 100644
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
+ * alarmtimer_init_soonest - Initializes parameters to find soonest alarm.
+ * @min: ptr to relative time to the soonest alarm to expire
+ * @expires: ptr to absolute time of the soonest alarm to expire
+ * @type: ptr to alarm type
+ *
+ */
+static void alarmtimer_init_soonest(ktime_t *min, ktime_t *expires, int *type)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&freezer_delta_lock, flags);
+	*min = freezer_delta;
+	*expires = freezer_expires;
+	*type = freezer_alarmtype;
+	freezer_delta = 0;
+	spin_unlock_irqrestore(&freezer_delta_lock, flags);
+}
+
+/**
+ * alarmtimer_get_soonest - Finds the soonest alarm to expire among the alarm bases.
+ * @min: ptr to relative time to the soonest alarm to expire
+ * @expires: ptr to absolute time of the soonest alarm to expire
+ * @type: ptr to alarm type
+ *
+ */
+static void alarmtimer_get_soonest(ktime_t *min, ktime_t *expires, int *type)
+{
+	int i;
+	unsigned long flags;
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
+		if (!(*min) || (delta < *min)) {
+			*expires = next->expires;
+			*min = delta;
+			*type = i;
+		}
+	}
+}
+
+static int alarmtimer_pm_callback(struct notifier_block *nb,
+			    unsigned long mode, void *_unused)
+{
+	ktime_t min, expires;
+	int type;
+
+	switch (mode) {
+	case PM_SUSPEND_PREPARE:
+		/* Initialize parameters to find soonest timer */
+		alarmtimer_init_soonest(&min, &expires, &type);
+
+		/* Find the soonest timer to expire */
+		alarmtimer_get_soonest(&min, &expires, &type);
+
+		if (min == 0)
+			return NOTIFY_DONE;
+
+		if (ktime_to_ns(min) < suspend_check_duration_ns) {
+			pr_warn("[%s] Suspend abort due to imminent alarm\n", __func__);
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
@@ -296,48 +379,20 @@ EXPORT_SYMBOL_GPL(alarm_expires_remaining);
 static int alarmtimer_suspend(struct device *dev)
 {
 	ktime_t min, now, expires;
-	int i, ret, type;
+	int ret, type;
 	struct rtc_device *rtc;
-	unsigned long flags;
 	struct rtc_time tm;
 
-	spin_lock_irqsave(&freezer_delta_lock, flags);
-	min = freezer_delta;
-	expires = freezer_expires;
-	type = freezer_alarmtype;
-	freezer_delta = 0;
-	spin_unlock_irqrestore(&freezer_delta_lock, flags);
+	/* Initialize parameters to find soonest timer */
+	alarmtimer_init_soonest(&min, &expires, &type);
 
 	rtc = alarmtimer_get_rtcdev();
 	/* If we have no rtcdev, just return */
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
-		return 0;
-
-	if (ktime_to_ns(min) < suspend_check_duration_ns) {
-		pm_wakeup_event(dev, suspend_check_duration_ns/NSEC_PER_MSEC);
-		return -EBUSY;
-	}
+	/* Find the soonest timer to expire */
+	alarmtimer_get_soonest(&min, &expires, &type);
 
 	trace_alarmtimer_suspend(expires, type);
 
-- 
2.43.0.594.gd9cf4e227d-goog


