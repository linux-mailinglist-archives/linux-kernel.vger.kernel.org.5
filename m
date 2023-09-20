Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173F77A7C49
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235040AbjITMAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235036AbjITL7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:59:48 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 303BDA3;
        Wed, 20 Sep 2023 04:59:42 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,161,1688396400"; 
   d="scan'208";a="176655460"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Sep 2023 20:59:41 +0900
Received: from localhost.localdomain (unknown [10.226.93.39])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 19F804328CA5;
        Wed, 20 Sep 2023 20:59:37 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.au@gmail.com>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH] alarmtimer: Fix rebind failure
Date:   Wed, 20 Sep 2023 12:59:35 +0100
Message-Id: <20230920115935.144391-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The resources allocated in alarmtimer_rtc_add_device() are not freed
leading to re-bind failure for the endpoint driver. Fix this issue
by adding alarmtimer_rtc_remove_device().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
This issue is found while adding irq support for built in RTC
found on Renesas PMIC RAA215300 device. This issue should present
on all RTC drivers which calls device_init_wakeup() in probe(). 
---
 kernel/time/alarmtimer.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 8d9f13d847f0..592668136bb5 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -61,6 +61,7 @@ static DEFINE_SPINLOCK(freezer_delta_lock);
 /* rtc timer and device for setting alarm wakeups at suspend */
 static struct rtc_timer		rtctimer;
 static struct rtc_device	*rtcdev;
+static struct platform_device	*rtc_pdev;
 static DEFINE_SPINLOCK(rtcdev_lock);
 
 /**
@@ -109,6 +110,7 @@ static int alarmtimer_rtc_add_device(struct device *dev)
 		}
 
 		rtcdev = rtc;
+		rtc_pdev = pdev;
 		/* hold a reference so it doesn't go away */
 		get_device(dev);
 		pdev = NULL;
@@ -123,6 +125,23 @@ static int alarmtimer_rtc_add_device(struct device *dev)
 	return ret;
 }
 
+static void alarmtimer_rtc_remove_device(struct device *dev)
+{
+	struct rtc_device *rtc = to_rtc_device(dev);
+
+	if (rtc_pdev) {
+		module_put(rtc->owner);
+		if (device_may_wakeup(rtc->dev.parent))
+			device_init_wakeup(&rtc_pdev->dev, false);
+
+		platform_device_unregister(rtc_pdev);
+		put_device(dev);
+	}
+
+	rtcdev = NULL;
+	rtc_pdev = NULL;
+}
+
 static inline void alarmtimer_rtc_timer_init(void)
 {
 	rtc_timer_init(&rtctimer, NULL, NULL);
@@ -130,6 +149,7 @@ static inline void alarmtimer_rtc_timer_init(void)
 
 static struct class_interface alarmtimer_rtc_interface = {
 	.add_dev = &alarmtimer_rtc_add_device,
+	.remove_dev = &alarmtimer_rtc_remove_device,
 };
 
 static int alarmtimer_rtc_interface_setup(void)
-- 
2.25.1

