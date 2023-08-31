Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD58C78E45B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 03:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242736AbjHaBbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 21:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjHaBbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 21:31:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED920CD2;
        Wed, 30 Aug 2023 18:31:31 -0700 (PDT)
Date:   Thu, 31 Aug 2023 01:31:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693445489;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WUIKRhv5gIRziAG2zV4Mhab8ZDRM5SOetHTPjv0BoGg=;
        b=q6ddolQRubppIsxI9RdXqGTnoCN6RZCk6ub4FRFKoLAhxplCUW7bPb26+WdjMLaCJm3+e9
        8EmzTSQ1LCFtlD/i9UYGxWiydfGY9cULW/xdYmZ+5rdFns1nIbSt5l/cnttmfzbK72vDcl
        whGiuEzFHMYOhHyynqdUMYaO1c4blKacz4wxaK48ERn0kItkqhYU1ZmZyt2k9g9n7D2CZr
        j6GdaW8Gv0nTAiO/wQI5HaHfpgKsEfAj7DgJ76SEDegJ//NKMG/NBjwVVC7NMvZbdhNejJ
        89rqfbEZXulhcHn8RmcPzcqd9L7hCSMjOCSHBk3sDqtTbLzGplBi1f6aq14y2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693445489;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WUIKRhv5gIRziAG2zV4Mhab8ZDRM5SOetHTPjv0BoGg=;
        b=C4kDRienMdyYsia1+tQQhj0iNdJS7oTH0jNv+wr/4CIY1VKzRFhWclYzrVXLsECln/XINL
        jpgB0UX4llLio5Cg==
From:   "tip-bot2 for Rob Herring" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: Explicitly include correct DT includes
Cc:     Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230714174409.4053843-1-robh@kernel.org>
References: <20230714174409.4053843-1-robh@kernel.org>
MIME-Version: 1.0
Message-ID: <169344548858.27769.1599461037653979553.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     0a8b07c77ea09602a152d3604e599f95726306d0
Gitweb:        https://git.kernel.org/tip/0a8b07c77ea09602a152d3604e599f95726306d0
Author:        Rob Herring <robh@kernel.org>
AuthorDate:    Fri, 14 Jul 2023 11:44:09 -06:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 18 Aug 2023 12:16:01 +02:00

clocksource: Explicitly include correct DT includes

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230714174409.4053843-1-robh@kernel.org
---
 drivers/clocksource/bcm2835_timer.c       | 2 +-
 drivers/clocksource/nomadik-mtu.c         | 2 +-
 drivers/clocksource/sh_cmt.c              | 1 -
 drivers/clocksource/timer-cadence-ttc.c   | 1 +
 drivers/clocksource/timer-gxp.c           | 1 +
 drivers/clocksource/timer-integrator-ap.c | 2 +-
 drivers/clocksource/timer-tegra186.c      | 1 -
 drivers/clocksource/timer-ti-dm.c         | 1 -
 8 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/bcm2835_timer.c b/drivers/clocksource/bcm2835_timer.c
index 1592650..319c0c7 100644
--- a/drivers/clocksource/bcm2835_timer.c
+++ b/drivers/clocksource/bcm2835_timer.c
@@ -10,9 +10,9 @@
 #include <linux/irqreturn.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/sched_clock.h>
diff --git a/drivers/clocksource/nomadik-mtu.c b/drivers/clocksource/nomadik-mtu.c
index 1cf3304..53d0159 100644
--- a/drivers/clocksource/nomadik-mtu.c
+++ b/drivers/clocksource/nomadik-mtu.c
@@ -10,9 +10,9 @@
 #include <linux/io.h>
 #include <linux/clockchips.h>
 #include <linux/clocksource.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <linux/clk.h>
 #include <linux/jiffies.h>
 #include <linux/delay.h>
diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index e81c588..2691955 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -18,7 +18,6 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
index 0d52e28..32daaac 100644
--- a/drivers/clocksource/timer-cadence-ttc.c
+++ b/drivers/clocksource/timer-cadence-ttc.c
@@ -13,6 +13,7 @@
 #include <linux/clocksource.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/sched_clock.h>
 #include <linux/module.h>
diff --git a/drivers/clocksource/timer-gxp.c b/drivers/clocksource/timer-gxp.c
index fe4fa8d..57aa2e2 100644
--- a/drivers/clocksource/timer-gxp.c
+++ b/drivers/clocksource/timer-gxp.c
@@ -8,6 +8,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/sched_clock.h>
 
 #define TIMER0_FREQ	1000000
diff --git a/drivers/clocksource/timer-integrator-ap.c b/drivers/clocksource/timer-integrator-ap.c
index b0fcbaa..a4c700b 100644
--- a/drivers/clocksource/timer-integrator-ap.c
+++ b/drivers/clocksource/timer-integrator-ap.c
@@ -7,9 +7,9 @@
 
 #include <linux/clk.h>
 #include <linux/clocksource.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
 #include <linux/sched_clock.h>
diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer-tegra186.c
index 83d0859..304537d 100644
--- a/drivers/clocksource/timer-tegra186.c
+++ b/drivers/clocksource/timer-tegra186.c
@@ -8,7 +8,6 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/watchdog.h>
diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 349236a..09ab29c 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -27,7 +27,6 @@
 #include <linux/err.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/dmtimer-omap.h>
 
