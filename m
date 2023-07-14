Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E787541B0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236762AbjGNRx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236499AbjGNRxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:53:42 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899EB3C0F;
        Fri, 14 Jul 2023 10:53:04 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-3458a08310aso9710035ab.3;
        Fri, 14 Jul 2023 10:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689357049; x=1691949049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iaw00yMxGJGRJdIygNJuXQl3uxTjHBXTV1DPEy5+uDw=;
        b=CBhXIXHRZyvDDOh36JH/ADPb6D1E4nAOJUMHEvfuN92/PDA4rAYLY77ExTMlBQx+a9
         H3n0DVjE/wIP9oEPRqvSGt4LpM3N+owxrv61axuoQImk73mgI7p96VpLQJqmU3OYeJj3
         UiZ/B57wrzbMp+LHPvbCOTRAHIxKdXKpXIirpEGAfenrBln0dSk/e++eSepyuWA/VA/r
         0m5zi4KLz6jHrn5eBU2j1/NkJ/5MHZOqSK2Ky7XmmwQBO13OImEnbBrHUbuCYpLAzsVE
         OWzWuf58SO0er1V+N5PasszUl7o4mzd1zDLkmS5phJrX53Tz2h6+NJJFo3RliLBrH42t
         XFjg==
X-Gm-Message-State: ABy/qLaFJyhhDCzTcl4SBhKqBc0x4dJymNI1fzJ5wc2hytj1ZZs1yEci
        RztPDwhV+ZboQQSGJ9LDaQ==
X-Google-Smtp-Source: APBJJlEhNUc2vuMNMCUh8zw4wj/1hFpPNMRrjB7AN15Zunw1zSYsxrlp1muY9M9wVP9ot13KbIk8Jw==
X-Received: by 2002:a92:ce0d:0:b0:342:512a:ccec with SMTP id b13-20020a92ce0d000000b00342512accecmr4305890ilo.31.1689357048989;
        Fri, 14 Jul 2023 10:50:48 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id e7-20020a056638020700b0042b03d40279sm2814768jaq.80.2023.07.14.10.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:50:48 -0700 (PDT)
Received: (nullmailer pid 4064914 invoked by uid 1000);
        Fri, 14 Jul 2023 17:50:18 -0000
From:   Rob Herring <robh@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Russell King <linux@armlinux.org.uk>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Jacky Huang <ychuang3@nuvoton.com>,
        Shan-Chun Hung <schung@nuvoton.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Timur Tabi <timur@kernel.org>
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: [PATCH] tty: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:50:11 -0600
Message-Id: <20230714175013.4064763-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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
 drivers/tty/hvc/hvc_opal.c             | 2 +-
 drivers/tty/serial/8250/8250_early.c   | 1 -
 drivers/tty/serial/8250/8250_ingenic.c | 1 -
 drivers/tty/serial/8250/8250_omap.c    | 1 -
 drivers/tty/serial/amba-pl011.c        | 2 +-
 drivers/tty/serial/apbuart.c           | 3 ---
 drivers/tty/serial/atmel_serial.c      | 1 -
 drivers/tty/serial/fsl_linflexuart.c   | 2 +-
 drivers/tty/serial/fsl_lpuart.c        | 2 +-
 drivers/tty/serial/imx.c               | 1 -
 drivers/tty/serial/lantiq.c            | 3 ++-
 drivers/tty/serial/liteuart.c          | 3 +--
 drivers/tty/serial/ma35d1_serial.c     | 2 +-
 drivers/tty/serial/mps2-uart.c         | 1 -
 drivers/tty/serial/mxs-auart.c         | 2 +-
 drivers/tty/serial/pic32_uart.c        | 1 -
 drivers/tty/serial/qcom_geni_serial.c  | 1 -
 drivers/tty/serial/serial-tegra.c      | 1 -
 drivers/tty/serial/sh-sci.c            | 1 -
 drivers/tty/serial/sunhv.c             | 4 ++--
 drivers/tty/serial/sunsab.c            | 3 ++-
 drivers/tty/serial/sunsu.c             | 4 ++--
 drivers/tty/serial/sunzilog.c          | 4 ++--
 drivers/tty/serial/tegra-tcu.c         | 1 -
 drivers/tty/serial/uartlite.c          | 3 ---
 drivers/tty/serial/ucc_uart.c          | 3 ++-
 drivers/tty/serial/vt8500_serial.c     | 2 +-
 27 files changed, 20 insertions(+), 35 deletions(-)

diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index 794c7b18aa06..992e199e0ea8 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -14,7 +14,7 @@
 #include <linux/console.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/export.h>
 #include <linux/interrupt.h>
 
diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 4299a8bd83d9..9837a27739fd 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -27,7 +27,6 @@
 #include <linux/init.h>
 #include <linux/console.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/serial_reg.h>
 #include <linux/serial.h>
 #include <linux/serial_8250.h>
diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index 617b8ce60d6b..4c4c4da73ad0 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -13,7 +13,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
 #include <linux/serial_core.h>
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index d48a82f1634e..26dd089d8e82 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -18,7 +18,6 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/of_irq.h>
 #include <linux/delay.h>
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index c5c3f4674459..a1e594b79890 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -20,6 +20,7 @@
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/console.h>
+#include <linux/platform_device.h>
 #include <linux/sysrq.h>
 #include <linux/device.h>
 #include <linux/tty.h>
@@ -36,7 +37,6 @@
 #include <linux/delay.h>
 #include <linux/types.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/sizes.h>
 #include <linux/io.h>
diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
index 915ee4b0d594..f3defc6da3df 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -22,9 +22,6 @@
 #include <linux/kthread.h>
 #include <linux/device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
-#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/serial_core.h>
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 3467a875641a..7ac477344aa3 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -21,7 +21,6 @@
 #include <linux/tty_flip.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/atmel_pdc.h>
diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
index 6fc21b6684e6..f697751c2ad5 100644
--- a/drivers/tty/serial/fsl_linflexuart.c
+++ b/drivers/tty/serial/fsl_linflexuart.c
@@ -11,7 +11,7 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/serial_core.h>
 #include <linux/slab.h>
 #include <linux/tty_flip.h>
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 4d80fae20177..e1a8d5415718 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -18,9 +18,9 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_dma.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/serial_core.h>
 #include <linux/slab.h>
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 7341d060f85c..3ed5083a7108 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -25,7 +25,6 @@
 #include <linux/rational.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/io.h>
 #include <linux/dma-mapping.h>
 
diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index bcaa479608d8..3adb60c683f7 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -17,7 +17,8 @@
 #include <linux/ioport.h>
 #include <linux/lantiq.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
 #include <linux/slab.h>
diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 80de3a42b67b..d881cdd2a58f 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -11,8 +11,7 @@
 #include <linux/litex.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
 #include <linux/slab.h>
diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
index 2604b4d9fb78..789593495a80 100644
--- a/drivers/tty/serial/ma35d1_serial.c
+++ b/drivers/tty/serial/ma35d1_serial.c
@@ -8,7 +8,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/iopoll.h>
 #include <linux/serial_core.h>
 #include <linux/slab.h>
diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
index 860d161fa594..5da88cbeec73 100644
--- a/drivers/tty/serial/mps2-uart.c
+++ b/drivers/tty/serial/mps2-uart.c
@@ -16,7 +16,6 @@
 #include <linux/console.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/of_device.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index a368f4293967..3974ca6ad86c 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -30,7 +30,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/io.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 
diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index 196a4e678451..e308d5022b3f 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -11,7 +11,6 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/of_gpio.h>
 #include <linux/init.h>
diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 444c74eeab7d..5607b668588b 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -11,7 +11,6 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pm_opp.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 1cf08b33456c..cbe641727f2a 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -20,7 +20,6 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pagemap.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 7c9457962a3d..115271d2f82d 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -35,7 +35,6 @@
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
diff --git a/drivers/tty/serial/sunhv.c b/drivers/tty/serial/sunhv.c
index 7d38c33ef506..c671d674bce4 100644
--- a/drivers/tty/serial/sunhv.c
+++ b/drivers/tty/serial/sunhv.c
@@ -17,11 +17,11 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/init.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 
 #include <asm/hypervisor.h>
 #include <asm/spitfire.h>
-#include <asm/prom.h>
 #include <asm/irq.h>
 #include <asm/setup.h>
 
diff --git a/drivers/tty/serial/sunsab.c b/drivers/tty/serial/sunsab.c
index 48b39fdb0397..40eeaf835bba 100644
--- a/drivers/tty/serial/sunsab.c
+++ b/drivers/tty/serial/sunsab.c
@@ -33,7 +33,8 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/init.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 
 #include <linux/io.h>
 #include <asm/irq.h>
diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index fed052a0b931..58a4342ad0f9 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -37,11 +37,11 @@
 #include <linux/serial_reg.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 
 #include <linux/io.h>
 #include <asm/irq.h>
-#include <asm/prom.h>
 #include <asm/setup.h>
 
 #include <linux/serial_core.h>
diff --git a/drivers/tty/serial/sunzilog.c b/drivers/tty/serial/sunzilog.c
index 0fbeb3dbd843..c8c71c56264c 100644
--- a/drivers/tty/serial/sunzilog.c
+++ b/drivers/tty/serial/sunzilog.c
@@ -33,11 +33,11 @@
 #include <linux/serio.h>
 #endif
 #include <linux/init.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 
 #include <linux/io.h>
 #include <asm/irq.h>
-#include <asm/prom.h>
 #include <asm/setup.h>
 
 #include <linux/serial_core.h>
diff --git a/drivers/tty/serial/tegra-tcu.c b/drivers/tty/serial/tegra-tcu.c
index 23500b342da7..65069daf36ec 100644
--- a/drivers/tty/serial/tegra-tcu.c
+++ b/drivers/tty/serial/tegra-tcu.c
@@ -7,7 +7,6 @@
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 679574893ebe..b225a78f6175 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -20,9 +20,6 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
 #include <linux/clk.h>
 #include <linux/pm_runtime.h>
 
diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 404230c1ebb2..284b293fade6 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -17,15 +17,16 @@
  */
 
 #include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
 #include <linux/slab.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/io.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <linux/dma-mapping.h>
 
 #include <linux/fs_uart_pd.h>
diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index cc9157df732f..32433e9b3e5f 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -14,6 +14,7 @@
 #include <linux/irq.h>
 #include <linux/init.h>
 #include <linux/console.h>
+#include <linux/platform_device.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/serial_core.h>
@@ -21,7 +22,6 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/err.h>
 
 /*
-- 
2.40.1

