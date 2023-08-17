Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1125D780164
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355987AbjHQW4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355931AbjHQW4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:56:04 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA2535AD;
        Thu, 17 Aug 2023 15:55:44 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1c5046642b4so153944fac.1;
        Thu, 17 Aug 2023 15:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692312943; x=1692917743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfRFkZNYpcFtEpCJ6592jYz9YhXnTUHLdeGPiNrj2fk=;
        b=MXRCzbCTeWNzNbEDyd8SMiVUQsEtHfbcb6hBK9mJqHcFVGk3X1Cm8T6cZJsg4eap+5
         xj2m86LAyvS6tMx3s0RSLf0LDwThu3a1V38VfwFhGQDfludVBQXo8Bj0vL8xUEEpBTm5
         3g1puHO6TFf7goWKkmfUflJnt0dADKb5JwDmeamQ/muMRcYpe/bJ3dZR4n2wQkZumkDI
         9gQmUZV1xwtBL8a6BIxlAUIkDsZThyQoVTfA+0qwuS5gketBeD4dk0MBsoBLRDtpfVp3
         kJOAJnBQnSBkxXBysbcHxFlcE2y4FK+mfWONZRFT5F99JkqOEBW/69bsTVsl4BiOuvAh
         /C6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692312943; x=1692917743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XfRFkZNYpcFtEpCJ6592jYz9YhXnTUHLdeGPiNrj2fk=;
        b=FXGwI9Kwh/rEpLIdk++OHAmUobPPDXWv8ntqQhx29X4AJ8sWH0kYMY+HKQBf3z/DPr
         EMot4XsZTQaffbHXZ5GN1O+Al5MVSsq7jlUXLmWjsWU3HF8/YFTBVnvT62FF0SbiZH1Y
         aViL6bgKq5p0pECZnVOn2q+H1z9gW9S8TpBroSt064Em+ZIRnvwtl7y8XoxWRKVbfWwH
         iUYkrt/EkMLBWRWCtErdD2pqd1odkpfDgp/VbWf3smXEGrLFTwhtkf7OfL79gOeA32rW
         2O32SA86+e/p09mc3LtI+ptoRKGrouFH3HpioBZB4Q1BLoTp/w3kod2BLUrHRj+bQAL8
         W6lw==
X-Gm-Message-State: AOJu0Yx0DK/HDO4o+85Bg+z4UHPBoXHb5L82eTXkLwrWN2VmuEzekZnr
        /IEBwm5w/gJDgCfJxl8MTsQ=
X-Google-Smtp-Source: AGHT+IGecaZOASaYD6zXgLwsM0W8IL7sV2ZlDZ4eoU13hQxg2omBb9E8fKlB7FZOMNsQwyzsYT6sqQ==
X-Received: by 2002:a05:6870:e304:b0:1c8:baa5:a50f with SMTP id z4-20020a056870e30400b001c8baa5a50fmr1043267oad.27.1692312943209;
        Thu, 17 Aug 2023 15:55:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z15-20020a17090a014f00b0026d214a2b33sm1829850pje.7.2023.08.17.15.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 15:55:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 2/7] rtc: alarmtimer: Use maximum alarm time offset
Date:   Thu, 17 Aug 2023 15:55:32 -0700
Message-Id: <20230817225537.4053865-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230817225537.4053865-1-linux@roeck-us.net>
References: <20230817225537.4053865-1-linux@roeck-us.net>
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
drivers to set the maximum alarm time. While this will result in brief
spurious wakeups from suspend, it is still much better than not suspending
at all.

Cc: Brian Norris <briannorris@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Rename range_max_offset -> alarm_offset_max

 kernel/time/alarmtimer.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 8d9f13d847f0..895e3a6d6444 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -290,6 +290,19 @@ static int alarmtimer_suspend(struct device *dev)
 	rtc_timer_cancel(rtc, &rtctimer);
 	rtc_read_time(rtc, &tm);
 	now = rtc_tm_to_ktime(tm);
+
+	/*
+	 * If the RTC alarm timer only supports a limited time offset, set
+	 * the alarm time to the maximum supported value.
+	 * The system will wake up earlier than necessary and is expected
+	 * to go back to sleep if it has nothing to do.
+	 * It would be desirable to handle such early wakeups without fully
+	 * waking up the system, but it is unknown if this is even possible.
+	 */
+	if (rtc->alarm_offset_max &&
+	    rtc->alarm_offset_max * MSEC_PER_SEC < ktime_to_ms(min))
+		min = ms_to_ktime(rtc->alarm_offset_max * MSEC_PER_SEC);
+
 	now = ktime_add(now, min);
 
 	/* Set alarm, if in the past reject suspend briefly to handle */
-- 
2.39.2

