Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8AE75411E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbjGNRtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbjGNRsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:48:15 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2674E173B;
        Fri, 14 Jul 2023 10:47:54 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3465bd756afso10335135ab.3;
        Fri, 14 Jul 2023 10:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356843; x=1691948843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPqdUUqkc4rI75UMAc4Xs8y3YEcjzz1RiNA4x7IYBHU=;
        b=DSV7d7Gi3N3EfMJsfSKQx3LaqqLecV4ge3OBFOMxA6oZcqeqN5SA0dFeSbExAt/LbS
         tvB3E4B6ZCblf2yVnHgCEQU0q4FRMIFqwf3VNW9gF6kNvj6Y6MZIdbPfXiFVnGhWV/Om
         nV9Ai9fuadYTSAdIskZcOfYeuueGuEdfi9riBgwXhk4usfWwPRjwcwNIAFRlzP7P9sz4
         JUwWKVsAgyWqHbFa+WMZXNaZSSvZRktZqslXRQhMa2Nc23QxPtjbkiucajxTDSh04aIX
         V1YFe8pciy9aZifJ6WVmReWM9Kreu74FAUGdi00dzUpQFy5Ls5dGriFMTLIoCj/bY04y
         xUxg==
X-Gm-Message-State: ABy/qLbRPse1Bdj9+jzY+dL8VAc9wTCwOuOlwk9904zfaF1fIexWbh7o
        Qw/DbXrFNq8f1MIezht8GQ==
X-Google-Smtp-Source: APBJJlE9mCouhYM8S5pU14gRiUMFnROknyjtSCY83LyzowqhqRu2tyhgLmXsFN5YRo8A9ohFE0CbNg==
X-Received: by 2002:a92:c6ce:0:b0:346:46e:2099 with SMTP id v14-20020a92c6ce000000b00346046e2099mr5032285ilm.1.1689356843369;
        Fri, 14 Jul 2023 10:47:23 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id gu16-20020a0566382e1000b0042b534e9f52sm2642967jab.59.2023.07.14.10.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:47:22 -0700 (PDT)
Received: (nullmailer pid 4059270 invoked by uid 1000);
        Fri, 14 Jul 2023 17:47:07 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michal Simek <michal.simek@amd.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org
Subject: [PATCH] mailbox: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:47:01 -0600
Message-Id: <20230714174702.4059100-1-robh@kernel.org>
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
 drivers/mailbox/arm_mhu.c            | 1 +
 drivers/mailbox/arm_mhu_db.c         | 1 -
 drivers/mailbox/hi3660-mailbox.c     | 1 +
 drivers/mailbox/hi6220-mailbox.c     | 1 +
 drivers/mailbox/imx-mailbox.c        | 3 ++-
 drivers/mailbox/mailbox-mpfs.c       | 1 +
 drivers/mailbox/mailbox.c            | 1 +
 drivers/mailbox/mtk-adsp-mailbox.c   | 3 ++-
 drivers/mailbox/mtk-cmdq-mailbox.c   | 2 +-
 drivers/mailbox/omap-mailbox.c       | 2 +-
 drivers/mailbox/platform_mhu.c       | 1 +
 drivers/mailbox/rockchip-mailbox.c   | 2 +-
 drivers/mailbox/sprd-mailbox.c       | 2 +-
 drivers/mailbox/stm32-ipcc.c         | 1 +
 drivers/mailbox/tegra-hsp.c          | 1 -
 drivers/mailbox/zynqmp-ipi-mailbox.c | 2 --
 16 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/mailbox/arm_mhu.c b/drivers/mailbox/arm_mhu.c
index 22243cabe056..537f7bfb7b06 100644
--- a/drivers/mailbox/arm_mhu.c
+++ b/drivers/mailbox/arm_mhu.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/mailbox_controller.h>
 #include <linux/module.h>
+#include <linux/of.h>
 
 #define INTR_STAT_OFS	0x0
 #define INTR_SET_OFS	0x8
diff --git a/drivers/mailbox/arm_mhu_db.c b/drivers/mailbox/arm_mhu_db.c
index aa0a4d83880f..27a510d46908 100644
--- a/drivers/mailbox/arm_mhu_db.c
+++ b/drivers/mailbox/arm_mhu_db.c
@@ -15,7 +15,6 @@
 #include <linux/mailbox_controller.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 
 #define INTR_STAT_OFS	0x0
 #define INTR_SET_OFS	0x8
diff --git a/drivers/mailbox/hi3660-mailbox.c b/drivers/mailbox/hi3660-mailbox.c
index ab24e731a782..17c29e960fbf 100644
--- a/drivers/mailbox/hi3660-mailbox.c
+++ b/drivers/mailbox/hi3660-mailbox.c
@@ -11,6 +11,7 @@
 #include <linux/iopoll.h>
 #include <linux/mailbox_controller.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
diff --git a/drivers/mailbox/hi6220-mailbox.c b/drivers/mailbox/hi6220-mailbox.c
index 1c73c63598f5..f77741ce42e7 100644
--- a/drivers/mailbox/hi6220-mailbox.c
+++ b/drivers/mailbox/hi6220-mailbox.c
@@ -15,6 +15,7 @@
 #include <linux/kfifo.h>
 #include <linux/mailbox_controller.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 20f2ec880ad6..3ef4dd8adf5d 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -14,7 +14,8 @@
 #include <linux/kernel.h>
 #include <linux/mailbox_controller.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/suspend.h>
 #include <linux/slab.h>
diff --git a/drivers/mailbox/mailbox-mpfs.c b/drivers/mailbox/mailbox-mpfs.c
index 162df49654fb..20ee283a04cc 100644
--- a/drivers/mailbox/mailbox-mpfs.c
+++ b/drivers/mailbox/mailbox-mpfs.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/mailbox_controller.h>
 #include <soc/microchip/mpfs.h>
diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index adf36c05fa43..ebff3baf3045 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -17,6 +17,7 @@
 #include <linux/bitops.h>
 #include <linux/mailbox_client.h>
 #include <linux/mailbox_controller.h>
+#include <linux/of.h>
 
 #include "mailbox.h"
 
diff --git a/drivers/mailbox/mtk-adsp-mailbox.c b/drivers/mailbox/mtk-adsp-mailbox.c
index 14bc0057de81..91487aa4d7da 100644
--- a/drivers/mailbox/mtk-adsp-mailbox.c
+++ b/drivers/mailbox/mtk-adsp-mailbox.c
@@ -10,7 +10,8 @@
 #include <linux/kernel.h>
 #include <linux/mailbox_controller.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 
 struct mtk_adsp_mbox_priv {
diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index b18d47ea13a0..4d62b07c1411 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -15,7 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/mailbox_controller.h>
 #include <linux/mailbox/mtk-cmdq-mailbox.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 
 #define CMDQ_OP_CODE_MASK		(0xff << CMDQ_OP_CODE_SHIFT)
 #define CMDQ_NUM_CMD(t)			(t->cmd_buf_size / CMDQ_INST_SIZE)
diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index fa2ce3246b70..792bcaebbc9b 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -16,7 +16,7 @@
 #include <linux/kfifo.h>
 #include <linux/err.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/omap-mailbox.h>
diff --git a/drivers/mailbox/platform_mhu.c b/drivers/mailbox/platform_mhu.c
index a5922ac0b0bf..54161303a36b 100644
--- a/drivers/mailbox/platform_mhu.c
+++ b/drivers/mailbox/platform_mhu.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/mailbox_controller.h>
diff --git a/drivers/mailbox/rockchip-mailbox.c b/drivers/mailbox/rockchip-mailbox.c
index 116286ecc5a0..10c7bee2a915 100644
--- a/drivers/mailbox/rockchip-mailbox.c
+++ b/drivers/mailbox/rockchip-mailbox.c
@@ -8,8 +8,8 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/mailbox_controller.h>
+#include <linux/of.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 
 #define MAILBOX_A2B_INTEN		0x00
diff --git a/drivers/mailbox/sprd-mailbox.c b/drivers/mailbox/sprd-mailbox.c
index e3c899abeed8..9ae57de77d4d 100644
--- a/drivers/mailbox/sprd-mailbox.c
+++ b/drivers/mailbox/sprd-mailbox.c
@@ -11,7 +11,7 @@
 #include <linux/io.h>
 #include <linux/mailbox_controller.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 
diff --git a/drivers/mailbox/stm32-ipcc.c b/drivers/mailbox/stm32-ipcc.c
index 15d538fe2113..4ad3653f3866 100644
--- a/drivers/mailbox/stm32-ipcc.c
+++ b/drivers/mailbox/stm32-ipcc.c
@@ -11,6 +11,7 @@
 #include <linux/io.h>
 #include <linux/mailbox_controller.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_wakeirq.h>
 
diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index 7f98e7436d94..c87c2b900b64 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -8,7 +8,6 @@
 #include <linux/io.h>
 #include <linux/mailbox_controller.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index d097f45b0e5f..e4fcac97dbfa 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -16,8 +16,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 
 /* IPI agent ID any */
-- 
2.40.1

