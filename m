Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC8475E42A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 20:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjGWSdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 14:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjGWSdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 14:33:20 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B62AE64
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 11:33:19 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3fbc5d5746cso33876165e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 11:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690137198; x=1690741998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xne8idaRlbxCOrCJa4iK/MOIRttrSCYL5hIu0XZTkzs=;
        b=QhrOwKsegSQVu5wdtm+vkeCAnVWj9NhSsCjAkWV6+57Mguz5mCnqzZ+WJItNU+qEB2
         jwPnj95r9dtb17v4ZPwDqXwRmy8AS7CB2/KgKo8YUac3uyPZYk1z6r2Qe3KFB7bA2yxM
         GNRRUJuIhbq15xTt3/Gm/6jtEdikLakDgsRpP0C5B/MwNaHFo8vGVLsRTWPOWwg+pJLV
         lRUe5Gbo+Qa7XU6yBKFFSvxH6H7GO8KjG6mhnc4WI1T1gJr8E+/pD3bjB1hNhwNHUYxJ
         90dBVzAo1ead94RpRtsWhHkvyhbN38EPvO2jaRER7ldqXiHI54IoMWhznBdU9V/WwoV1
         C9gg==
X-Gm-Message-State: ABy/qLZTXl50h8YnJu9r7q3Os1rW76uCDs2CUHJ9/VSihmnyZc38kdmx
        cRw4gsf0K5pgXKiCaRbuJ09Tqdi6K1Ad4UQX
X-Google-Smtp-Source: APBJJlFMtu2aqQ3XUnxNzJ4iKyM5/9QSND/gHUBzVeUOqlHtY+Zg7MkNHVS24iy4q1nvR2hepbY06g==
X-Received: by 2002:a05:600c:210b:b0:3fb:b56b:470f with SMTP id u11-20020a05600c210b00b003fbb56b470fmr6309026wml.14.1690137197505;
        Sun, 23 Jul 2023 11:33:17 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a040:199:8930:2c90:cb9e:b154:73dc])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c314e00b003fc3b03e41dsm11202145wmo.0.2023.07.23.11.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 11:33:16 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Costa Shulyupin <costa.shul@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Cc:     junxiao.chang@intel.com, pauld@redhat.com, prarit@redhat.com
Subject: [RFC PATCH] hrtimer: warn when delay is too long
Date:   Sun, 23 Jul 2023 21:31:30 +0300
Message-ID: <20230723183132.1910579-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=true
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking hrtimer_get_softexpires value because sometimes it is 1,
at least for 4.18.0-372.49.1.rt7.206.el8_6.

This patch helped debug a very big problem and find this solution:
https://lore.kernel.org/lkml/20221208075604.811710-1-junxiao.chang@intel.com/

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 kernel/time/Kconfig   |  6 ++++++
 kernel/time/hrtimer.c | 14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index bae8f11070be..ccc1458b2ba6 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -196,6 +196,12 @@ config HIGH_RES_TIMERS
 	  hardware is not capable then this option only increases
 	  the size of the kernel image.
 
+config HIGH_RES_TIMERS_DEBUG
+	bool "High Resolution Timer Debug"
+	default y if HIGH_RES_TIMERS && DEBUG_KERNEL
+	help
+	  Warn when hrtimer delay is too long.
+
 config CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
 	int "Clocksource watchdog maximum allowable skew (in μs)"
 	depends on CLOCKSOURCE_WATCHDOG
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 238262e4aba7..d0087b709bc1 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -123,6 +123,10 @@ static const int hrtimer_clock_to_base_table[MAX_CLOCKS] = {
 	[CLOCK_TAI]		= HRTIMER_BASE_TAI,
 };
 
+#ifdef CONFIG_HIGH_RES_TIMERS_DEBUG
+int timer_threshold_ns = 1000000;
+#endif
+
 /*
  * Functions and macros which are different for UP/SMP systems are kept in a
  * single place
@@ -1651,6 +1655,16 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
 	bool expires_in_hardirq;
 	int restart;
 
+#ifdef CONFIG_HIGH_RES_TIMERS_DEBUG
+	if (timer_threshold_ns && hrtimer_get_softexpires(timer) > 0) {
+		s64 delay_ns = ktime_to_ns(ktime_sub(*now,
+					   hrtimer_get_softexpires(timer)));
+
+		if (delay_ns > timer_threshold_ns)
+			printk_deferred(KERN_WARNING
+					"hrtimer: delay_ns=%lld\n", delay_ns);
+	}
+#endif
 	lockdep_assert_held(&cpu_base->lock);
 
 	debug_deactivate(timer);
-- 
2.41.0

