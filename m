Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B67077E2CE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245635AbjHPNkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245606AbjHPNjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:39:46 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99204B9;
        Wed, 16 Aug 2023 06:39:45 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-26b0b92e190so4152610a91.1;
        Wed, 16 Aug 2023 06:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692193185; x=1692797985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAeAZMPWPQ44R7uqdMO5/pae/vXEz5lKsT8ey03vQrU=;
        b=J8j7FKA5EEOum/SzG20r4GdRcUBht0i+n/qtxvJF2Nj1DcGqrNsTlgx+IeeqveQAn3
         5i0FIV891WXnEOyJesC++tgV/kc2X96a9bCNF3+3iLCZgs18DijoPmOurhPR0yBjKR7J
         imliiLKDhLgzkjE22qVvZGt0DA3qXjsyIvDeGlRgKHhdNyjW5alAIyz4vvYDRZ5NLWcz
         YlwoovhQX/5mX64kl1Iw+6+n7FSrfpvlelX2VRKCSVqn+9ojml91/00S1F9y+t9krBfK
         9OroM+N9SQitIlNaENuNKJRiLGJh63NYC6K8IZRAu1FubcZvS8eAdze6kJcTXCQ8VjTe
         E5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692193185; x=1692797985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BAeAZMPWPQ44R7uqdMO5/pae/vXEz5lKsT8ey03vQrU=;
        b=eTLcuP3TulN0rkT6n6whq/onV1BQ19SCC3QFtexkHb1Z6wRNC4sSY0J5KNUB4/4Vqm
         VGaRCPBt08yn0AaIOzq7OtIRP8YrVeEBnE7r5zyWIY0NRtNNLdeDsJv1ZjRDbObv9lyN
         TfYTO7lPVn+gKhvXhoKKkaXRjs51RGnzkokNKTX3WJbr/3JnlZ0G8Ns1PMgad9Kn+NL0
         wvUpVZ570SM/cX8f73ayjTX3quu1dMYSMJ4NtXi9or4UiDB4UBzkVUAp0321aSWBCzcM
         24co4gbhZv1Hn4i+au3Pef6HHDwep9gDF29M6bOjyZV2MQKLT83/UrzVgS5WTWKYDdLL
         8rRg==
X-Gm-Message-State: AOJu0Yy9QA1XgMdAR0jav6w42oozF/oL83Ku2+qJIJDbfCpZPtaDf/l2
        9s9JF7MhtUw47dJ3Mk1dxz2+DsXiK54=
X-Google-Smtp-Source: AGHT+IHBZNrLU/iY1lISdkWjk0pti9fq9RpxLjFSYHnDjPKoLDjyVMAWxluCc+IVWXPODrTbYfXgMQ==
X-Received: by 2002:a17:90b:1014:b0:268:2af6:e48c with SMTP id gm20-20020a17090b101400b002682af6e48cmr2723405pjb.4.1692193184943;
        Wed, 16 Aug 2023 06:39:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v20-20020a17090ac91400b0026b30377c14sm8512957pjt.6.2023.08.16.06.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 06:39:44 -0700 (PDT)
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
Subject: [PATCH 2/7] rtc: alarmtimer: Use maximum alarm time offset
Date:   Wed, 16 Aug 2023 06:39:31 -0700
Message-Id: <20230816133936.2150294-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816133936.2150294-1-linux@roeck-us.net>
References: <20230816133936.2150294-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
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
 kernel/time/alarmtimer.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 8d9f13d847f0..cc31998a34b9 100644
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
+	if (rtc->range_max_offset &&
+	    rtc->range_max_offset * MSEC_PER_SEC < ktime_to_ms(min))
+		min = ms_to_ktime(rtc->range_max_offset * MSEC_PER_SEC);
+
 	now = ktime_add(now, min);
 
 	/* Set alarm, if in the past reject suspend briefly to handle */
-- 
2.39.2

