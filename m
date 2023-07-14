Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6EE7540E1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbjGNRoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236170AbjGNRo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:44:27 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7C5173B;
        Fri, 14 Jul 2023 10:44:16 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3486eeb5c43so3789565ab.1;
        Fri, 14 Jul 2023 10:44:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356656; x=1691948656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g8skStFDOXTknvcj3hj7vs1tDZ9Dye1jTlfDv2JHfSA=;
        b=TrjqKHuI2mPrxJoxuWKUaI49KjcatlfsAD6nB101cGsvPERsOgTlbI7R8BFau9btv1
         HCrP5lBNG9Abn0I78mGGcxTWTE1Ku0On5ofoSgN6ckfpsuK55/xZsLBwHrcGI2xpNrG0
         RYdg9twn2BK+jdr4kVPw6z/Dll0+jH1ef7HkzbsdchYUCFUysovhHfaf4PaQZUXm17n5
         SCEjlcbm/qlsO/NV1E5UlTt+uxg0543B8OwvXgFgzHg4fOCOJ2bzl+lwX7gaG9tQNzUY
         /q2IztilHRj9AYr8dOjGM+PfJKbFjo17ZwXee7pUIDRg91pRdESgj7FmHTVBITz8/5xO
         wEjg==
X-Gm-Message-State: ABy/qLbY+vmc7tGnMszGmP/7NulbOQbLhOC7B1tj4P2AEsEtzCQR4QN8
        7BbBMpOsvnyWDFqm0KtPLwBB1wDhzA==
X-Google-Smtp-Source: APBJJlGiTa/QUw4kYTN/GCYI+lP9irbXOHggTxTC1FEOM5XlHlp6a7ydxOnN43/wbfPexuMMZ/Vgag==
X-Received: by 2002:a92:690c:0:b0:346:191b:1e02 with SMTP id e12-20020a92690c000000b00346191b1e02mr4927984ilc.29.1689356655947;
        Fri, 14 Jul 2023 10:44:15 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id 18-20020a92c652000000b00345ffd35a29sm2909624ill.68.2023.07.14.10.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:44:15 -0700 (PDT)
Received: (nullmailer pid 4053967 invoked by uid 1000);
        Fri, 14 Jul 2023 17:44:13 -0000
From:   Rob Herring <robh@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Michal Simek <michal.simek@amd.com>,
        Jean-Marie Verdun <verdun@hpe.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: [PATCH] clocksource: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:44:09 -0600
Message-Id: <20230714174409.4053843-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
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
index 1592650b2c92..319c0c780a15 100644
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
index 1cf3304652d6..53d0159cc6be 100644
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
index e81c588d9afe..26919556ef5f 100644
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
index 0d52e28fea4d..32daaac9b132 100644
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
index fe4fa8d7b3f1..57aa2e2cce53 100644
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
index b0fcbaac58b0..a4c700b11dc0 100644
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
index 83d08591ea0a..304537dadf2c 100644
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
index 349236a7ba5f..09ab29cb7f64 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -27,7 +27,6 @@
 #include <linux/err.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/dmtimer-omap.h>
 
-- 
2.40.1

