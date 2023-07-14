Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241267541D2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbjGNRvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236342AbjGNRu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:50:58 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DB83C27;
        Fri, 14 Jul 2023 10:50:31 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-77a62a84855so87703039f.1;
        Fri, 14 Jul 2023 10:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356956; x=1691948956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gv6mglAVvH2vWt/oL/OorStmbFmB+aPDGFPGYKqJNFM=;
        b=IljuEB13oD1KcBnLQUhz0Ns/hkNNrMG6m4kBWonCNae3C7D9yc/WN3F1ANM/Z7mnyU
         SskeDX3Uv5G8mQczuWBnjwh6Cb9aKgrF6zXDAVadBuFFqpchRWEc0bRX/5OG1UgXnhnQ
         e7Hlirr8y5uML0sAfxHWVmmy+1Zy3Lgpv1LywGfcd6X1oVT9aRKDYOP8Vp6xSpy7Yzhb
         GrKqNMShAdFNyK2Heoz6a2l8oFFsiH/8Hi5eJIZQToP7azqTghPfcwnOTukeuDcu8lov
         PXfoHy0SLxhi8naCu4rVpu0GeIwXxExalR9iYNtGyw/LlfQKizt4dBTs2vuetLigOBbH
         fCbg==
X-Gm-Message-State: ABy/qLZKV7NGyCvxlT4F6mUlU2L4SjWKNYB22NSqbNftcGnzfg5frlO3
        tjWNaVyK/tJyDKFZf+PJRw==
X-Google-Smtp-Source: APBJJlF9IMlurlu4MO+SsiwcNYAJ+lt6SWyHecRouMhZaN1LAiASF/mqoJTsdZnMn0yFvjphxZ9lrQ==
X-Received: by 2002:a92:c081:0:b0:347:6d5f:ab2f with SMTP id h1-20020a92c081000000b003476d5fab2fmr4792743ile.6.1689356956095;
        Fri, 14 Jul 2023 10:49:16 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id o17-20020a92c691000000b00345d00dc3fdsm2850838ilg.78.2023.07.14.10.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:49:15 -0700 (PDT)
Received: (nullmailer pid 4061876 invoked by uid 1000);
        Fri, 14 Jul 2023 17:48:35 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jiucheng Xu <jiucheng.xu@amlogic.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Frank Li <Frank.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/perf: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:48:31 -0600
Message-Id: <20230714174832.4061752-1-robh@kernel.org>
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
 drivers/perf/amlogic/meson_ddr_pmu_core.c | 2 --
 drivers/perf/arm-cci.c                    | 5 +----
 drivers/perf/arm_dsu_pmu.c                | 2 +-
 drivers/perf/arm_pmu_platform.c           | 1 -
 drivers/perf/arm_spe_pmu.c                | 3 +--
 drivers/perf/fsl_imx8_ddr_perf.c          | 3 +--
 drivers/perf/fsl_imx9_ddr_perf.c          | 4 +---
 drivers/perf/marvell_cn10k_ddr_pmu.c      | 3 +--
 drivers/perf/marvell_cn10k_tad_pmu.c      | 3 +--
 9 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/perf/amlogic/meson_ddr_pmu_core.c b/drivers/perf/amlogic/meson_ddr_pmu_core.c
index 0b24dee1ed3c..bbc7285fd934 100644
--- a/drivers/perf/amlogic/meson_ddr_pmu_core.c
+++ b/drivers/perf/amlogic/meson_ddr_pmu_core.c
@@ -9,8 +9,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
 #include <linux/printk.h>
diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 998259f1d973..61de861eaf91 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -7,10 +7,7 @@
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index fe2abb412c00..8223c49bd082 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -20,7 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
index 933b96e243b8..3596db36cbff 100644
--- a/drivers/perf/arm_pmu_platform.c
+++ b/drivers/perf/arm_pmu_platform.c
@@ -16,7 +16,6 @@
 #include <linux/irqdesc.h>
 #include <linux/kconfig.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/percpu.h>
 #include <linux/perf/arm_pmu.h>
 #include <linux/platform_device.h>
diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index b9ba4c4fe5a2..d2b0cbf0e0c4 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -25,8 +25,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/perf_event.h>
 #include <linux/perf/arm_pmu.h>
 #include <linux/platform_device.h>
diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index 5222ba1e79d0..1cb3861ab0e0 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -10,10 +10,9 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/perf_event.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 
 #define COUNTER_CNTL		0x0
diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 71d5b07e3aff..5cf770a1bc31 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -7,9 +7,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
+#include <linux/platform_device.h>
 #include <linux/perf_event.h>
 
 /* Performance monitor configuration */
diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
index b94a5f6cc22b..524ba82bfce2 100644
--- a/drivers/perf/marvell_cn10k_ddr_pmu.c
+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
@@ -8,11 +8,10 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/perf_event.h>
 #include <linux/hrtimer.h>
 #include <linux/acpi.h>
+#include <linux/platform_device.h>
 
 /* Performance Counters Operating Mode Control Registers */
 #define DDRC_PERF_CNT_OP_MODE_CTRL	0x8020
diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
index 3972197e2210..fec8e82edb95 100644
--- a/drivers/perf/marvell_cn10k_tad_pmu.c
+++ b/drivers/perf/marvell_cn10k_tad_pmu.c
@@ -6,10 +6,9 @@
 
 #define pr_fmt(fmt) "tad_pmu: " fmt
 
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/cpuhotplug.h>
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
-- 
2.40.1

