Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2962A754097
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbjGNRk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbjGNRkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:40:45 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068A23A94;
        Fri, 14 Jul 2023 10:40:34 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-78654448524so84722139f.2;
        Fri, 14 Jul 2023 10:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356433; x=1691948433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J8HZmWu+OEfP542TGa0O8NOGgGHKWsqIzIaBCAMvs6s=;
        b=BfzOaI3LJKfk/4rt0fb+peer+OttvEfXHHU+HZnc3lmf7R/AkcckaX152KYxvgPI58
         G2sBNZSHnvo6zEu8lVq4fi7H04jmNJMWYb3DaDvUl0ew+pwXqCpoQynTIxUU0M0VYP4Y
         MUKZPufOXtdGOmoRmct+iXkKoBKNODwiqa/5CQh41/57CbcSSEgc5uYNbXNIEiWMGqXl
         cPS47q/87gRKgCSf/cWvksWLaEn/VnKTkpy1BpcO4Dy/ksd225jxEaKLxcc5x1PW9gcX
         oGrtuvbPn/4+APaLd6wdefOXv2R5Y2xXatt1kG9ooWNJrgnPStGGxT7IAQJL5PQ63Xwu
         kGTg==
X-Gm-Message-State: ABy/qLYa+z5wNeeHtn7t6CvPohOUo7PTSlhsEWk1VWHt6DAQQhe+6GiN
        93qz6018L9LmWgnk0M8CJW7ItiVBbw==
X-Google-Smtp-Source: APBJJlE0Xr/tYNBuP64yZBakCQqjUwRAMXcFq+N/oL3UMYtYU18+ljm6/N1rK/s1HAVAv2Ed0ZRNsg==
X-Received: by 2002:a5e:8d0a:0:b0:786:cd9b:1ccd with SMTP id m10-20020a5e8d0a000000b00786cd9b1ccdmr5744631ioj.0.1689356433568;
        Fri, 14 Jul 2023 10:40:33 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id g10-20020a02cd0a000000b0042b28813816sm2744356jaq.14.2023.07.14.10.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:40:32 -0700 (PDT)
Received: (nullmailer pid 4040189 invoked by uid 1000);
        Fri, 14 Jul 2023 17:40:30 -0000
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        John Crispin <john@phrozen.org>
Cc:     devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:40:27 -0600
Message-Id: <20230714174028.4040093-1-robh@kernel.org>
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
 arch/mips/bmips/setup.c               | 1 -
 arch/mips/cavium-octeon/flash_setup.c | 3 ++-
 arch/mips/lantiq/irq.c                | 2 +-
 arch/mips/lantiq/xway/dcdc.c          | 3 ++-
 arch/mips/lantiq/xway/gptu.c          | 4 ++--
 arch/mips/lantiq/xway/sysctrl.c       | 1 -
 arch/mips/lantiq/xway/vmmc.c          | 3 ++-
 arch/mips/pci/pci-lantiq.c            | 4 ++--
 arch/mips/pci/pci-rt2880.c            | 5 ++---
 arch/mips/pic32/pic32mzda/config.c    | 1 -
 arch/mips/ralink/irq.c                | 2 +-
 arch/mips/ralink/of.c                 | 2 +-
 arch/mips/ralink/prom.c               | 2 --
 13 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index 053805cb741c..ec180ab92eaa 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -16,7 +16,6 @@
 #include <linux/of.h>
 #include <linux/of_clk.h>
 #include <linux/of_fdt.h>
-#include <linux/of_platform.h>
 #include <linux/libfdt.h>
 #include <linux/smp.h>
 #include <asm/addrspace.h>
diff --git a/arch/mips/cavium-octeon/flash_setup.c b/arch/mips/cavium-octeon/flash_setup.c
index c8a8c6d359b9..3395acde4d60 100644
--- a/arch/mips/cavium-octeon/flash_setup.c
+++ b/arch/mips/cavium-octeon/flash_setup.c
@@ -12,7 +12,8 @@
 #include <linux/semaphore.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/mtd/partitions.h>
 
 #include <asm/octeon/octeon.h>
diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index 20622bf0a9b3..8f208007b8e8 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -10,7 +10,7 @@
 #include <linux/sched.h>
 #include <linux/irqchip.h>
 #include <linux/irqdomain.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 
diff --git a/arch/mips/lantiq/xway/dcdc.c b/arch/mips/lantiq/xway/dcdc.c
index 96199966a350..4a808f8c5beb 100644
--- a/arch/mips/lantiq/xway/dcdc.c
+++ b/arch/mips/lantiq/xway/dcdc.c
@@ -6,7 +6,8 @@
  */
 
 #include <linux/ioport.h>
-#include <linux/of_platform.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 
 #include <lantiq_soc.h>
 
diff --git a/arch/mips/lantiq/xway/gptu.c b/arch/mips/lantiq/xway/gptu.c
index a492b1eb1925..e254b108fb9b 100644
--- a/arch/mips/lantiq/xway/gptu.c
+++ b/arch/mips/lantiq/xway/gptu.c
@@ -8,8 +8,8 @@
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
-#include <linux/of_platform.h>
-#include <linux/of_irq.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 
 #include <lantiq_soc.h>
 #include "../clk.h"
diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index d444a1b98a72..3ed078225222 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -10,7 +10,6 @@
 #include <linux/clkdev.h>
 #include <linux/spinlock.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
 #include <linux/of_address.h>
 
 #include <lantiq_soc.h>
diff --git a/arch/mips/lantiq/xway/vmmc.c b/arch/mips/lantiq/xway/vmmc.c
index 2796e87dfcae..37c133052ef7 100644
--- a/arch/mips/lantiq/xway/vmmc.c
+++ b/arch/mips/lantiq/xway/vmmc.c
@@ -7,7 +7,8 @@
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/gpio/consumer.h>
-#include <linux/of_platform.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 
 #include <lantiq_soc.h>
diff --git a/arch/mips/pci/pci-lantiq.c b/arch/mips/pci/pci-lantiq.c
index 79e29bf42a24..80f7293166bb 100644
--- a/arch/mips/pci/pci-lantiq.c
+++ b/arch/mips/pci/pci-lantiq.c
@@ -13,9 +13,9 @@
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
 #include <linux/clk.h>
-#include <linux/of_platform.h>
-#include <linux/of_irq.h>
+#include <linux/of.h>
 #include <linux/of_pci.h>
+#include <linux/platform_device.h>
 
 #include <asm/addrspace.h>
 
diff --git a/arch/mips/pci/pci-rt2880.c b/arch/mips/pci/pci-rt2880.c
index e9dd01431f21..1cada09fa5db 100644
--- a/arch/mips/pci/pci-rt2880.c
+++ b/arch/mips/pci/pci-rt2880.c
@@ -13,9 +13,8 @@
 #include <linux/pci.h>
 #include <linux/io.h>
 #include <linux/init.h>
-#include <linux/of_platform.h>
-#include <linux/of_irq.h>
-#include <linux/of_pci.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 
 #include <asm/mach-ralink/rt288x.h>
 
diff --git a/arch/mips/pic32/pic32mzda/config.c b/arch/mips/pic32/pic32mzda/config.c
index f69532007717..6e94ae66eba8 100644
--- a/arch/mips/pic32/pic32mzda/config.c
+++ b/arch/mips/pic32/pic32mzda/config.c
@@ -5,7 +5,6 @@
  */
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/of_platform.h>
 
 #include <asm/mach-pic32/pic32.h>
 
diff --git a/arch/mips/ralink/irq.c b/arch/mips/ralink/irq.c
index fa353bc13947..46aef0a1b22a 100644
--- a/arch/mips/ralink/irq.c
+++ b/arch/mips/ralink/irq.c
@@ -7,7 +7,7 @@
 
 #include <linux/io.h>
 #include <linux/bitops.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/irqdomain.h>
diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
index 45d60c094496..7f90068c68f2 100644
--- a/arch/mips/ralink/of.c
+++ b/arch/mips/ralink/of.c
@@ -14,7 +14,7 @@
 #include <linux/of_fdt.h>
 #include <linux/kernel.h>
 #include <linux/memblock.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 
 #include <asm/reboot.h>
diff --git a/arch/mips/ralink/prom.c b/arch/mips/ralink/prom.c
index aaac1e6ec7d9..c3b96861844c 100644
--- a/arch/mips/ralink/prom.c
+++ b/arch/mips/ralink/prom.c
@@ -7,8 +7,6 @@
  */
 
 #include <linux/string.h>
-#include <linux/of_fdt.h>
-#include <linux/of_platform.h>
 
 #include <asm/bootinfo.h>
 #include <asm/addrspace.h>
-- 
2.40.1

