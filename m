Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBEC7AAC62
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjIVINT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbjIVIMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:12:51 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3995A1F04;
        Fri, 22 Sep 2023 01:12:16 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,167,1694703600"; 
   d="scan'208";a="176896542"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 22 Sep 2023 17:12:15 +0900
Received: from localhost.localdomain (unknown [10.226.92.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id E56BC400F937;
        Fri, 22 Sep 2023 17:12:11 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.au@gmail.com>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2] alarmtimer: Fix rebind failure
Date:   Fri, 22 Sep 2023 09:12:08 +0100
Message-Id: <20230922081208.26334-1-biju.das.jz@bp.renesas.com>
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

Fixes: c79108bd19a8 ("alarmtimer: Make alarmtimer platform device child of RTC device")
Fixes: 7c94caca877b ("alarmtimer: Use wakeup source from alarmtimer platform device")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Add fixes tag.
 * Replaced the variable rtc_pdev->alarmtimer_pdev
 * Added the check rtcdev == rtc before unregistering the real alarmtimer.
Note:
 This issue is found while adding irq support for built in RTC
 found on Renesas PMIC RAA215300 device. This issue should present
 on all RTC drivers which calls device_init_wakeup() in probe().
---
 kernel/time/alarmtimer.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 8d9f13d847f0..04d67de8b1fe 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -61,6 +61,7 @@ static DEFINE_SPINLOCK(freezer_delta_lock);
 /* rtc timer and device for setting alarm wakeups at suspend */
 static struct rtc_timer		rtctimer;
 static struct rtc_device	*rtcdev;
+static struct platform_device	*alarmtimer_pdev;
 static DEFINE_SPINLOCK(rtcdev_lock);
 
 /**
@@ -109,6 +110,7 @@ static int alarmtimer_rtc_add_device(struct device *dev)
 		}
 
 		rtcdev = rtc;
+		alarmtimer_pdev = pdev;
 		/* hold a reference so it doesn't go away */
 		get_device(dev);
 		pdev = NULL;
@@ -123,6 +125,22 @@ static int alarmtimer_rtc_add_device(struct device *dev)
 	return ret;
 }
 
+static void alarmtimer_rtc_remove_device(struct device *dev)
+{
+	struct rtc_device *rtc = to_rtc_device(dev);
+
+	if (rtcdev == rtc) {
+		module_put(rtc->owner);
+		if (device_may_wakeup(rtc->dev.parent))
+			device_init_wakeup(&alarmtimer_pdev->dev, false);
+
+		platform_device_unregister(alarmtimer_pdev);
+		put_device(dev);
+		alarmtimer_pdev = NULL;
+		rtcdev = NULL;
+	}
+}
+
 static inline void alarmtimer_rtc_timer_init(void)
 {
 	rtc_timer_init(&rtctimer, NULL, NULL);
@@ -130,6 +148,7 @@ static inline void alarmtimer_rtc_timer_init(void)
 
 static struct class_interface alarmtimer_rtc_interface = {
 	.add_dev = &alarmtimer_rtc_add_device,
+	.remove_dev = &alarmtimer_rtc_remove_device,
 };
 
 static int alarmtimer_rtc_interface_setup(void)
-- 
2.25.1

