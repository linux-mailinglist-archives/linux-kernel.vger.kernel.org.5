Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEB8754130
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbjGNRsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236503AbjGNRsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:48:07 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F873C31;
        Fri, 14 Jul 2023 10:47:46 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-783544a1c90so90669539f.1;
        Fri, 14 Jul 2023 10:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356832; x=1691948832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UeiE+HnMouYzfyNd/68oi3j74UMDXi8ibPx8eeIgmvQ=;
        b=dmrxAnDAtRaTkidCwQZ6wfaEjBgdSP0reKQwdm3ahm16R9ebL9P5gyobTeLFDEfs5B
         FliYSuZsu1dYgtud0rm7hLdEQV75/TQORrEnfMWkVb38INg0RgqetTFnxGRp64PJjQOi
         JLx/1OeTvHT8m9PAkuQ0/SNzUYKHVWdhVEmOCiJ6JBfiBCeJHdTHjelG/tblDmkHcjm8
         oJEE/QnpYaGjyITx9g/OcVtEnl4dd+f/cv6mjvzf8/s2c22wfpVLoyzouKEHCVNwNhB1
         FDnVyxdTLg41+hs/WJJYTRxe5tYvd7oIbUzUTrH0TI+SaQglBTt/M/60U7D0PmSdvXcF
         CQrw==
X-Gm-Message-State: ABy/qLaqJXHUnYb1AhoYsuRYQwwrouQKYxc0NWkE43kO5U6lN284N8Ec
        Y+Dh0Zsf/7cAiAGQ8stR9A==
X-Google-Smtp-Source: APBJJlHXZn+MEv7nNeSi3qT88gFKsbjEuS3B/1KXeEjspYv3anvorPWqBdLrFlgJP8t9t4ZuNyU9aA==
X-Received: by 2002:a5e:df4d:0:b0:786:4198:3c2d with SMTP id g13-20020a5edf4d000000b0078641983c2dmr5706464ioq.1.1689356832311;
        Fri, 14 Jul 2023 10:47:12 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id c5-20020a6b7d05000000b0077e24ace3edsm2632026ioq.52.2023.07.14.10.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:47:11 -0700 (PDT)
Received: (nullmailer pid 4058687 invoked by uid 1000);
        Fri, 14 Jul 2023 17:46:49 -0000
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-arm-msm@vger.kernel.org
Subject: [PATCH] irqchip: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:46:43 -0600
Message-Id: <20230714174645.4058547-1-robh@kernel.org>
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
 drivers/irqchip/irq-bcm6345-l1.c            | 1 -
 drivers/irqchip/irq-bcm7038-l1.c            | 1 -
 drivers/irqchip/irq-brcmstb-l2.c            | 1 -
 drivers/irqchip/irq-gic-pm.c                | 2 +-
 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c | 2 --
 drivers/irqchip/irq-imx-intmux.c            | 3 ++-
 drivers/irqchip/irq-imx-irqsteer.c          | 3 ++-
 drivers/irqchip/irq-keystone.c              | 2 +-
 drivers/irqchip/irq-loongson-htvec.c        | 1 -
 drivers/irqchip/irq-loongson-pch-pic.c      | 2 +-
 drivers/irqchip/irq-madera.c                | 4 +---
 drivers/irqchip/irq-pruss-intc.c            | 2 +-
 drivers/irqchip/irq-qcom-mpm.c              | 2 +-
 drivers/irqchip/irq-renesas-intc-irqpin.c   | 1 -
 drivers/irqchip/irq-st.c                    | 2 +-
 drivers/irqchip/irq-stm32-exti.c            | 3 ++-
 drivers/irqchip/irq-sunxi-nmi.c             | 1 -
 drivers/irqchip/irq-tb10x.c                 | 1 -
 drivers/irqchip/irq-ti-sci-inta.c           | 4 ++--
 drivers/irqchip/irq-ti-sci-intr.c           | 4 ++--
 drivers/irqchip/irq-uniphier-aidet.c        | 1 -
 drivers/irqchip/irqchip.c                   | 2 +-
 drivers/irqchip/qcom-pdc.c                  | 1 -
 23 files changed, 18 insertions(+), 28 deletions(-)

diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l1.c
index fa113cb2529a..b521897277a8 100644
--- a/drivers/irqchip/irq-bcm6345-l1.c
+++ b/drivers/irqchip/irq-bcm6345-l1.c
@@ -60,7 +60,6 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index a62b96237b82..24ca1d656adc 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -20,7 +20,6 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index 091b0fe7e324..5559c943f03f 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -15,7 +15,6 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/io.h>
diff --git a/drivers/irqchip/irq-gic-pm.c b/drivers/irqchip/irq-gic-pm.c
index 3989d16f997b..a275a8071a25 100644
--- a/drivers/irqchip/irq-gic-pm.c
+++ b/drivers/irqchip/irq-gic-pm.c
@@ -4,7 +4,7 @@
  */
 #include <linux/module.h>
 #include <linux/clk.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/irqchip/arm-gic.h>
 #include <linux/platform_device.h>
diff --git a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
index 634263dfd7b5..8e87fc35f8aa 100644
--- a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
@@ -9,8 +9,6 @@
 
 #include <linux/acpi.h>
 #include <linux/acpi_iort.h>
-#include <linux/of_device.h>
-#include <linux/of_address.h>
 #include <linux/irq.h>
 #include <linux/msi.h>
 #include <linux/of.h>
diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmux.c
index 80aaea82468a..6d9a08238c9d 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -50,8 +50,9 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/pm_runtime.h>
 
diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
index 96230a04ec23..bd9543314539 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -10,8 +10,9 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
 
diff --git a/drivers/irqchip/irq-keystone.c b/drivers/irqchip/irq-keystone.c
index ba9792e60329..a36396db4b08 100644
--- a/drivers/irqchip/irq-keystone.c
+++ b/drivers/irqchip/irq-keystone.c
@@ -15,7 +15,7 @@
 #include <linux/irqdomain.h>
 #include <linux/irqchip.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 
diff --git a/drivers/irqchip/irq-loongson-htvec.c b/drivers/irqchip/irq-loongson-htvec.c
index fc8bf1f5d41b..0bff728b25e3 100644
--- a/drivers/irqchip/irq-loongson-htvec.c
+++ b/drivers/irqchip/irq-loongson-htvec.c
@@ -15,7 +15,6 @@
 #include <linux/platform_device.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <linux/syscore_ops.h>
 
 /* Registers */
diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index 93a71f66efeb..63db8e2172e0 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -12,9 +12,9 @@
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <linux/syscore_ops.h>
 
 /* Registers */
diff --git a/drivers/irqchip/irq-madera.c b/drivers/irqchip/irq-madera.c
index 8b81271c823c..3eb1f8cdf674 100644
--- a/drivers/irqchip/irq-madera.c
+++ b/drivers/irqchip/irq-madera.c
@@ -10,12 +10,10 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
 #include <linux/irqchip/irq-madera.h>
 #include <linux/mfd/madera/core.h>
 #include <linux/mfd/madera/pdata.h>
diff --git a/drivers/irqchip/irq-pruss-intc.c b/drivers/irqchip/irq-pruss-intc.c
index fa8d89b02ec0..89e337ebc467 100644
--- a/drivers/irqchip/irq-pruss-intc.c
+++ b/drivers/irqchip/irq-pruss-intc.c
@@ -17,7 +17,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 
 /*
diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mpm.c
index d30614661eea..7124565234a5 100644
--- a/drivers/irqchip/irq-qcom-mpm.c
+++ b/drivers/irqchip/irq-qcom-mpm.c
@@ -14,7 +14,7 @@
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/slab.h>
diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index 26e4c17a7bf2..fa19585f3dee 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -17,7 +17,6 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 
 #define INTC_IRQPIN_MAX 8 /* maximum 8 interrupts per driver instance */
diff --git a/drivers/irqchip/irq-st.c b/drivers/irqchip/irq-st.c
index 819a12297b58..de71bb350d57 100644
--- a/drivers/irqchip/irq-st.c
+++ b/drivers/irqchip/irq-st.c
@@ -10,7 +10,7 @@
 #include <dt-bindings/interrupt-controller/irq-st.h>
 #include <linux/err.h>
 #include <linux/mfd/syscon.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index b5fa76ce5046..d8ba5fba7450 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -14,10 +14,11 @@
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/syscore_ops.h>
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index 21d49791f855..e760b1278143 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -19,7 +19,6 @@
 #include <linux/irqdomain.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
 
diff --git a/drivers/irqchip/irq-tb10x.c b/drivers/irqchip/irq-tb10x.c
index 8a0e69298e83..680586354d12 100644
--- a/drivers/irqchip/irq-tb10x.c
+++ b/drivers/irqchip/irq-tb10x.c
@@ -13,7 +13,6 @@
 #include <linux/irqchip.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/bitops.h>
diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index 7133f9fa6fd9..b83f5cbab123 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -15,9 +15,9 @@
 #include <linux/msi.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/of_address.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/soc/ti/ti_sci_inta_msi.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
index 1186f1e431a3..c027cd9e4a69 100644
--- a/drivers/irqchip/irq-ti-sci-intr.c
+++ b/drivers/irqchip/irq-ti-sci-intr.c
@@ -12,9 +12,9 @@
 #include <linux/io.h>
 #include <linux/irqchip.h>
 #include <linux/irqdomain.h>
-#include <linux/of_platform.h>
-#include <linux/of_address.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
+#include <linux/platform_device.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
 
 /**
diff --git a/drivers/irqchip/irq-uniphier-aidet.c b/drivers/irqchip/irq-uniphier-aidet.c
index 716b1bb88bf2..601f9343d5b3 100644
--- a/drivers/irqchip/irq-uniphier-aidet.c
+++ b/drivers/irqchip/irq-uniphier-aidet.c
@@ -12,7 +12,6 @@
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
index 7899607fbee8..1eeb0d0156ce 100644
--- a/drivers/irqchip/irqchip.c
+++ b/drivers/irqchip/irqchip.c
@@ -10,7 +10,7 @@
 
 #include <linux/acpi.h>
 #include <linux/init.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/irqchip.h>
 #include <linux/platform_device.h>
diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index d96916cf6a41..a32c0d28d038 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/soc/qcom/irq.h>
 #include <linux/spinlock.h>
-- 
2.40.1

