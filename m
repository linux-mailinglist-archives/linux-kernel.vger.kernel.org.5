Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06997BDD2B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376711AbjJINIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376704AbjJINIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:08:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB3D9C;
        Mon,  9 Oct 2023 06:08:07 -0700 (PDT)
Date:   Mon, 09 Oct 2023 13:08:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696856886;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=seh42BDMFxD1CDYwbST4vPKqH1J5AcIjG1O+fVobOmk=;
        b=dv7KQlWGXTDXxc3gduFYbnEbHREUCKB+Vp9CY+5KXjfU8Wc7AFg2NKOMgfFcZGeNLiOPGc
        nfFEVMaIEIHTK69fzD5N1Z0q867lDahQITgD1CEMia5L88ERLIKIrN2PQYph40VNS9orPL
        MjWtoNrGgRgfVEpV00izxbObvzyXp+Fl+8T01j9A/6akYcRg79+0QilGAvYy5mIhdc7svF
        opDcP3kKFyyudPbHz0wgija3P0sdvrZRsL5F17qfEvoKYvP/3fIGzIhNjm5eeCzqlQpXPq
        LFPG9IxsdUdgnPqY0hEyU8VdRio1kqPAwm4oo7aqYZF4X7oA3gLA4JZlps7YDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696856886;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=seh42BDMFxD1CDYwbST4vPKqH1J5AcIjG1O+fVobOmk=;
        b=fHNXxFNfN90n2MnXXjaEkm3Eq3H3bl4VWaYXu0nU0IFhdwcbBP7qpsD22Vg+PtIsI/SpNY
        fRtQFnwPqjFpBpAA==
From:   "tip-bot2 for Guenter Roeck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] alarmtimer: Use maximum alarm time for suspend
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230915152238.1144706-3-linux@roeck-us.net>
References: <20230915152238.1144706-3-linux@roeck-us.net>
MIME-Version: 1.0
Message-ID: <169685688566.3135.9313648193477749393.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8ceea12d183cf29f28072dede218a04eda2a789c
Gitweb:        https://git.kernel.org/tip/8ceea12d183cf29f28072dede218a04eda2a789c
Author:        Guenter Roeck <linux@roeck-us.net>
AuthorDate:    Fri, 15 Sep 2023 08:22:38 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 09 Oct 2023 15:03:28 +02:00

alarmtimer: Use maximum alarm time for suspend

Some userspace applications use timerfd_create() to request wakeups after
a long period of time. For example, a backup application may request a
wakeup once per week. This is perfectly fine as long as the system does
not try to suspend. However, if the system tries to suspend and the
system's RTC does not support the required alarm timeout, the suspend
operation will fail with an error such as

rtc_cmos 00:01: Alarms can be up to one day in the future
PM: dpm_run_callback(): platform_pm_suspend+0x0/0x4a returns -22
alarmtimer alarmtimer.4.auto: platform_pm_suspend+0x0/0x4a returned -22 after 117 usecs
PM: Device alarmtimer.4.auto failed to suspend: error -22

This results in a refusal to suspend the system, causing substantial
battery drain on affected systems.

To fix the problem, use the maximum alarm time offset as reported by RTC
drivers to set the maximum alarm time. While this may result in early
wakeups from suspend, it is still much better than not suspending at all.

Standardize system behavior if the requested alarm timeout is larger than
the alarm timeout supported by the rtc chip. Currently, in this situation,
the RTC driver will do one of the following:

  - It may return an error.
  - It may limit the alarm timeout to the maximum supported by the rtc chip.
  - It may mask the timeout by the maximum alarm timeout supported by the RTC
    chip (i.e. a requested timeout of 1 day + 1 minute may result in a 1
    minute timeout).

With this in place, if the RTC driver reports the maximum alarm timeout
supported by the RTC chip, the system will always limit the alarm timeout
to the maximum supported by the RTC chip.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/r/20230915152238.1144706-3-linux@roeck-us.net
---
 kernel/time/alarmtimer.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 8d9f13d..4657cb8 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -290,6 +290,17 @@ static int alarmtimer_suspend(struct device *dev)
 	rtc_timer_cancel(rtc, &rtctimer);
 	rtc_read_time(rtc, &tm);
 	now = rtc_tm_to_ktime(tm);
+
+	/*
+	 * If the RTC alarm timer only supports a limited time offset, set the
+	 * alarm time to the maximum supported value.
+	 * The system may wake up earlier (possibly much earlier) than expected
+	 * when the alarmtimer runs. This is the best the kernel can do if
+	 * the alarmtimer exceeds the time that the rtc device can be programmed
+	 * for.
+	 */
+	min = rtc_bound_alarmtime(rtc, min);
+
 	now = ktime_add(now, min);
 
 	/* Set alarm, if in the past reject suspend briefly to handle */
