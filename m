Return-Path: <linux-kernel+bounces-47005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CDE8447D4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204F41F24403
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415BC3717F;
	Wed, 31 Jan 2024 19:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tuq3KMKS"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9512135A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 19:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706728406; cv=none; b=Qicrd+z/CydYmx3G2yJxr/0ADCg+w0uGRtuHRSi13a7PMu6QiStnlBaPqyjtrwT0HtbPmaiyLjhND5q8L3Xg1mnA+nOG0aGv4tkvmjfn7hSHAxSlBIwd2StfZeAzvcXv6wwDSrlS2HTH+JWQKs8BuCgIHnPPsgCKJHfBgyByd10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706728406; c=relaxed/simple;
	bh=xrLWYG7caEKCeMiEjBSZqR6qf6vWuiqwu82ZWlcv0kE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=N3YG8IKzMmCwBNrIvT3Gfosvaj8y5MtjP2gvZMak/8t04ZmuQgjzauXk4lOTjXFsNEHie80xNvsVsc6znnkVhcBvyFt/0ufc7oDC6/PKI5z64PXL4X5sMlYrGr2HOf6IjHF3sZMk7SWS8173eGbTyDEe0aLnLpsYWbSOATqhRuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pranavpp.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tuq3KMKS; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pranavpp.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5f6c12872fbso2039757b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 11:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706728403; x=1707333203; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MDlCC2r5ivfxMatzw+m44kL9y+ob2qxzmDMpYUeLjRw=;
        b=Tuq3KMKSAPurWglYCkJ16QugJqJKXzSAvbLhHgHfxd/88rvKq4cFYbsPV0qg2ptH1D
         xu8+a4C0D8T7Xn+Tz0jcQBvDEpFIPBZ7hUKlFOz2nmd2xs8SVlC7Llsy8rchRL8ClN+U
         +j3myy2tPrI2gtahh8iZ1Rc0jZnWkwqvfiSRwqz1V3kpBXsoevlagsH82i0Tzv9ulj8q
         68PDnxIcSlPGlFnIJINRYz4vwmuSk2XYJHGk6iIFofivIPdEuWZjxQ/toBLcFmFpClXs
         h8VpJ6QowR83M1htBR35TRRoHQA4//pKv5wDZIMSJUIW1eGmFiZANx6pN5T+YLP4v/CJ
         +UmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706728403; x=1707333203;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MDlCC2r5ivfxMatzw+m44kL9y+ob2qxzmDMpYUeLjRw=;
        b=FGneKos78h6bvW0tI8Pfo3E9JgT9qLxJ7mslEvq+6laNtC0bo/tX1oFu005//AiXKO
         +mtwSPEyqY1rzlyfK1uM95kBizyMr8twUVP/6cASDsMBPnR56h8d+2tiqe1zrWowxvpm
         mRA14IK2jQxjkpPNxg+r7JMHtM/tEPXEoPE7ozxRf5mUDfvHQhM9jW2D2MxrqkKrSlDG
         oiQMSLzSo5u/5PddcJ0dIWTxO6uiGQfpHXbh5nnSu+hPpmfs0+FRLO1zWMimhtE/7QaU
         ux96zaau+wxDNsSbxJCQKW18+YpMeuVLiAiuHtbkaryg2vj3h++0KUtGPQgOaj/XX58l
         +HmA==
X-Gm-Message-State: AOJu0Yyl3Q7srdnc8eONZ9VkvxRAfuHiWlXkQi34v/Li3AB7EZJB9FRd
	mLIr6tlOX1iuQ2JaW40++jZSfTKM9SvdqPphnLSm4oLWxTuHI2RK6cP4vHevK1rVJzqzMSSVxNc
	SPFq7CVzRzQ==
X-Google-Smtp-Source: AGHT+IHQhnxNnGms1Lv1v4wRyVmF3tL2yOxMd366sSLLKAcOE2JiiNngkczV4tzp6DA569p1Cc9GWZJKEFW6kA==
X-Received: from pranav-first.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:390b])
 (user=pranavpp job=sendgmr) by 2002:a05:690c:f94:b0:5fc:548:ca50 with SMTP id
 df20-20020a05690c0f9400b005fc0548ca50mr394574ywb.10.1706728403730; Wed, 31
 Jan 2024 11:13:23 -0800 (PST)
Date: Wed, 31 Jan 2024 19:13:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240131191317.2191421-1-pranavpp@google.com>
Subject: [PATCH] alarmtimer, PM: suspend: Expose a function from
From: Pranav Prasad <pranavpp@google.com>
To: rafael@kernel.org, pavel@ucw.cz, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, krossmo@google.com, jstultz@google.com
Cc: Pranav Prasad <pranavpp@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi!

I am proposing a patch in which I want to return the errno code ETIME
instead of EBUSY in enter_state() in the kernel suspend flow. Currently,
EBUSY is returned  when an imminent alarm is pending which is checked in
alarmtimer_suspend() in alarmtimer.c. The proposed patch series moves the
check to enter_state() in suspend.c to catch a potential suspend failure
early in the suspend flow. I want to replace EBUSY with ETIME to make it
more diagnosable in userspace, and may be more appropriate considering a
timer is about to expire.

I am reaching out to get an opinion from the
suspend maintainers if this would act as any potential risk in the suspend
flow which only has EBUSY, EAGAIN, and EINVAL as return error codes
currently. This has been developed as part of a patch series, and only the
patch of interest is below this message. Any feedback or insights would be
greatly appreciated.

Thank you,
Pranav Prasad

The alarmtimer driver currently fails suspend attempts when there is an
alarm pending within the next suspend_check_duration_ns nanoseconds, since
the   system is expected to wake up soon anyway. The entire suspend process
is initiated even though the system will immediately awaken. This process
includes substantial work before the suspend fails and additional work
afterwards to undo the failed suspend that was attempted. Therefore on
battery-powered devices that initiate suspend attempts from userspace, it
may be advantageous to be able to fail the suspend earlier in the suspend
flow to avoid power consumption instead of unnecessarily doing extra work.
As one data point, an analysis of a subset of Android devices showed that
imminent alarms account for roughly 40% of all suspend failures on average
leading to unnecessary power wastage.

To facilitate this, expose
function time_check_suspend_fail() from alarmtimer to be used by the power
subsystem to perform the check earlier in the suspend flow. Perform the
check in enter_state() and return early if an alarm is to be fired in the
next suspend_check_duration_ns nanoseconds, failing suspend.

Signed-off-by: Pranav Prasad <pranavpp@google.com>
Signed-off-by: Kelly Rossmoyer <krossmo@google.com>
---
 include/linux/time.h     |   1 +
 kernel/power/suspend.c   |   3 ++
 kernel/time/alarmtimer.c | 113 ++++++++++++++++++++++++++++-----------
 3 files changed, 87 insertions(+), 30 deletions(-)

diff --git a/include/linux/time.h b/include/linux/time.h
index 16cf4522d6f3..aab7c4e51e11 100644
--- a/include/linux/time.h
+++ b/include/linux/time.h
@@ -56,6 +56,7 @@ struct tm {
 };
 
 void time64_to_tm(time64_t totalsecs, int offset, struct tm *result);
+int time_check_suspend_fail(void);
 
 # include <linux/time32.h>
 
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index fa3bf161d13f..7a0175dae0d9 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -26,6 +26,7 @@
 #include <linux/suspend.h>
 #include <linux/syscore_ops.h>
 #include <linux/swait.h>
+#include <linux/time.h>
 #include <linux/ftrace.h>
 #include <trace/events/power.h>
 #include <linux/compiler.h>
@@ -564,6 +565,8 @@ static int enter_state(suspend_state_t state)
 #endif
 	} else if (!valid_state(state)) {
 		return -EINVAL;
+	} else if (time_check_suspend_fail()) {
+		return -ETIME;
 	}
 	if (!mutex_trylock(&system_transition_mutex))
 		return -EBUSY;
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index e5d2e560b4c1..085b1ace0c31 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -115,6 +115,84 @@ static int alarmtimer_sysfs_add(void)
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
+/**
+ * time_check_suspend_fail - Check if suspend should be failed due to an
+ * alarm within the next suspend_check_duration nanoseconds.
+ *
+ * Returns error if suspend should be failed, else returns 0.
+ */
+int time_check_suspend_fail(void)
+{
+	ktime_t min, expires;
+	int type;
+
+	/* Initialize parameters to find soonest timer */
+	alarmtimer_init_soonest(&min, &expires, &type);
+
+	/* Find the soonest timer to expire */
+	alarmtimer_get_soonest(&min, &expires, &type);
+
+	if (min == 0)
+		return 0;
+
+	if (ktime_to_ns(min) < suspend_check_duration_ns)
+		return -EBUSY;
+
+	return 0;
+}
+EXPORT_SYMBOL(time_check_suspend_fail);
+
 /**
  * alarmtimer_get_rtcdev - Return selected rtcdevice
  *
@@ -296,49 +374,24 @@ EXPORT_SYMBOL_GPL(alarm_expires_remaining);
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
+	/* Find the soonest timer to expire */
+	alarmtimer_get_soonest(&min, &expires, &type);
 
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
 	if (min == 0)
 		return 0;
 
-	if (ktime_to_ns(min) < suspend_check_duration_ns) {
-		pm_wakeup_event(dev, suspend_check_duration_ns/NSEC_PER_MSEC);
-		return -EBUSY;
-	}
-
 	trace_alarmtimer_suspend(expires, type);
 
 	/* Setup an rtc timer to fire that far in the future */
-- 
2.43.0.429.g432eaa2c6b-goog


