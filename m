Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01CD7A2242
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbjIOPXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236075AbjIOPWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:22:52 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12B2170E;
        Fri, 15 Sep 2023 08:22:46 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-34961362f67so8606855ab.0;
        Fri, 15 Sep 2023 08:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694791366; x=1695396166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CS9ubDurv0r2cFDb63lHGeCIPsttTPXuX+wI81MOIt8=;
        b=bXey5s/Nso8JNKxFYxU4I8UtXopSoWBEJdpmdLUjqGwUk4PPTX0RNF7FErLFAlJZLP
         e4PKYPCFY73MZ6YWSUDs1hhKFkG6kkApQhb3k80RnJi9Cnduo/4cA+ceJ9G2hB5jbc0y
         u969XjajlWwOr+3PzD4S6ZIXncFZxIk9GQ1YdT6Ys/KUwq3DPh/UfLkCpGRwBR51LugN
         QUyMffoEFyDiHZkNzY+CfdLc5PEeKDR/ZMbrdiMauslYqEejN6Rd3ChQdG3LsD9yxK0u
         15/zPQ0V9PiRkWEewrwS5wROygYqHHhAkNvDvmrt403gWn7ilI+KpmUknXPmgHp6RXmC
         0qtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694791366; x=1695396166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CS9ubDurv0r2cFDb63lHGeCIPsttTPXuX+wI81MOIt8=;
        b=ic3z/mn9a9F3joIN4VB+WM6Bp1zJY9nwhb3g7tBH9Mfr2zfyUFswH9VBNcqFhSKLVB
         Y17+qutkz20SsVElI6t9CHW+dThb2odUBrGiGlg1re2CFXkvuC56xvicA3w276Ngy7qz
         yaMMepaqRqNSvS6T3CnS3deuze9LW503mUB1H8TfkslekTNfpbnjGEoJDHOuTpZAVgRA
         qQd40dGsyQ8mmPGjKA9rG0DRPIM43xNVHRL/1K/L5TcLYnsKvfTW15ItJt7EJe7Yr2Np
         LCLp4z83gkPMDrudnI6Ale9ezkxQvFNkudH5PKdrMF1XKwZa9BVETTde7MQo/mXuhFNU
         jW1w==
X-Gm-Message-State: AOJu0YyNCd+kfS0TGVJgTve74Uu3VOjdApC3F3FhJi9JtetQAwtNls3M
        WZ3KsdfQJEU76PDGGyEmz0E=
X-Google-Smtp-Source: AGHT+IEyKTtdLhvrMRR8y/sQcUoRNWTJW7009ME7Cm7T55Hz4OGh53s1MkerIOe00yK8s/86X+NpoA==
X-Received: by 2002:a05:6e02:1b04:b0:348:c606:bd1a with SMTP id i4-20020a056e021b0400b00348c606bd1amr2338515ilv.15.1694791366105;
        Fri, 15 Sep 2023 08:22:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h1-20020a92d841000000b0034f13bcaf9asm1170309ilq.22.2023.09.15.08.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 08:22:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Stultz <jstultz@google.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 2/2] rtc: alarmtimer: Use maximum alarm time offset
Date:   Fri, 15 Sep 2023 08:22:38 -0700
Message-Id: <20230915152238.1144706-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230915152238.1144706-1-linux@roeck-us.net>
References: <20230915152238.1144706-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

To fix the problem, use the maximum alarm time offset as reported by rtc
drivers to set the maximum alarm time. While this may result in early
wakeups from suspend, it is still much better than not suspending at all.

This patch standardizes system behavior if the requested alarm timeout
is larger than the alarm timeout supported by the rtc chip. Currently,
in this situation, the rtc driver will do one of the following.
- It may return an error.
- It may limit the alarm timeout to the maximum supported by the rtc chip.
- It may mask the timeout by the maximum alarm timeout supported by the RTC
  chip (i.e. a requested timeout of 1 day + 1 minute may result in a 1
  minute timeout).

With this patch in place, if the rtc driver reports the maximum alarm
timeout supported by the rtc chip, the system will always limit the alarm
timeout to the maximum supported by the rtc chip.

Cc: Brian Norris <briannorris@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Use API function instead of accessing rtc core internals directly.
    Modify comment in code per feedback received.

 kernel/time/alarmtimer.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 8d9f13d847f0..0dc68372efd0 100644
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
-- 
2.39.2

