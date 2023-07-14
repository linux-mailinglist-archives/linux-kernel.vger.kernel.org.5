Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8604775422E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236820AbjGNSCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236659AbjGNSBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:01:51 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA85271E;
        Fri, 14 Jul 2023 11:01:06 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-403a72df0a6so14163721cf.2;
        Fri, 14 Jul 2023 11:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689357597; x=1691949597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x7CAXtBYk6X27uebkH9zYJjyXa8Snp/PDN8dALPovlA=;
        b=JmX461CvRYG9EcwGIjmYLjnjOkt96EvhB016+LFjFDpsoC7qYYg5p9pclaahu9smCD
         E7hEyh2fbOzFkvVqrBpDxlZLg7RBwcjm0clmfuAE7JAiR/M8gS4mCWoiUNaxiPeRenOQ
         AvjmHhxs+0cy+UUoW8NoZrQkLj4QDQdCAxZ8DV/dHpGi3+DiCu0GsgR/aY4HlNRg76QJ
         wDh3Bsv6dZoU+41bSZl1WLTHtIp3qUjLCDVumX8lZgUVc8dY6/0wJANziT6oXDR5ij1Y
         yEWNI78b333djghX5XNNdA1OTozCmmYKCdPJFrBMzqZ2Ze2zRB32C2NxAUPh/NqsarmB
         olUg==
X-Gm-Message-State: ABy/qLYj9Gp3BseMeXhdBpvM4MQhYCWcbVvU4NmYq8+CbblfFD3rFsok
        dT/igrH002cbnv+HwgJ2rasYephMKDLV
X-Google-Smtp-Source: APBJJlHM+IfdU83rP5wrXpggh4K0BHRspj+8cjiFvu8XdIfuPps+mwrVgBvFaLyiPhM0nRIFKO8M+A==
X-Received: by 2002:a92:d311:0:b0:346:77f5:116f with SMTP id x17-20020a92d311000000b0034677f5116fmr4943472ila.16.1689356987789;
        Fri, 14 Jul 2023 10:49:47 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id g7-20020a0566380bc700b0042b2e309f97sm2656917jad.177.2023.07.14.10.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:49:47 -0700 (PDT)
Received: (nullmailer pid 4063624 invoked by uid 1000);
        Fri, 14 Jul 2023 17:49:37 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] remoteproc: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:49:33 -0600
Message-Id: <20230714174935.4063513-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
 drivers/remoteproc/imx_dsp_rproc.c        | 3 +--
 drivers/remoteproc/imx_rproc.c            | 2 +-
 drivers/remoteproc/omap_remoteproc.c      | 3 ++-
 drivers/remoteproc/pru_rproc.c            | 3 ++-
 drivers/remoteproc/qcom_q6v5_adsp.c       | 2 +-
 drivers/remoteproc/qcom_q6v5_mss.c        | 3 ++-
 drivers/remoteproc/qcom_q6v5_pas.c        | 2 +-
 drivers/remoteproc/qcom_sysmon.c          | 1 -
 drivers/remoteproc/qcom_wcnss.c           | 2 +-
 drivers/remoteproc/qcom_wcnss_iris.c      | 1 +
 drivers/remoteproc/rcar_rproc.c           | 3 ++-
 drivers/remoteproc/st_slim_rproc.c        | 1 -
 drivers/remoteproc/stm32_rproc.c          | 4 ++--
 drivers/remoteproc/ti_k3_dsp_remoteproc.c | 2 +-
 drivers/remoteproc/ti_k3_r5_remoteproc.c  | 3 ++-
 drivers/remoteproc/wkup_m3_rproc.c        | 2 +-
 16 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index d95fa5586189..8fcda9b74545 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -12,8 +12,7 @@
 #include <linux/mailbox_client.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index f9874fc5a80f..b403a37ddb02 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -13,9 +13,9 @@
 #include <linux/mailbox_client.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_reserved_mem.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/regmap.h>
diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
index 82ed90f03d91..8f50ab80e56f 100644
--- a/drivers/remoteproc/omap_remoteproc.c
+++ b/drivers/remoteproc/omap_remoteproc.c
@@ -19,7 +19,8 @@
 #include <linux/clk/ti.h>
 #include <linux/err.h>
 #include <linux/io.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index 2874c8d324f7..5b2dc75836fc 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -16,8 +16,9 @@
 #include <linux/debugfs.h>
 #include <linux/irqdomain.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
+#include <linux/platform_device.h>
 #include <linux/remoteproc/pruss.h>
 #include <linux/pruss_driver.h>
 #include <linux/remoteproc.h>
diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index 6777a3bd6226..7733be477db5 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -14,8 +14,8 @@
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 70bffc9f33f6..76c546871a94 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -15,9 +15,10 @@
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/of_reserved_mem.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 3153d82037e7..faec3a3d8e4e 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -13,8 +13,8 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/remoteproc/qcom_sysmon.c b/drivers/remoteproc/qcom_sysmon.c
index 746f56b4bafb..c24e4a882873 100644
--- a/drivers/remoteproc/qcom_sysmon.c
+++ b/drivers/remoteproc/qcom_sysmon.c
@@ -9,7 +9,6 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/remoteproc/qcom_rproc.h>
 #include <linux/rpmsg.h>
diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
index 1ed0647bc962..c109096bbfe3 100644
--- a/drivers/remoteproc/qcom_wcnss.c
+++ b/drivers/remoteproc/qcom_wcnss.c
@@ -14,8 +14,8 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/io.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/remoteproc/qcom_wcnss_iris.c b/drivers/remoteproc/qcom_wcnss_iris.c
index 09720ddddc85..dd36fd077911 100644
--- a/drivers/remoteproc/qcom_wcnss_iris.c
+++ b/drivers/remoteproc/qcom_wcnss_iris.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
diff --git a/drivers/remoteproc/rcar_rproc.c b/drivers/remoteproc/rcar_rproc.c
index 90e8769d5624..cc17e8421f65 100644
--- a/drivers/remoteproc/rcar_rproc.c
+++ b/drivers/remoteproc/rcar_rproc.c
@@ -5,8 +5,9 @@
 
 #include <linux/limits.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/remoteproc.h>
 #include <linux/reset.h>
diff --git a/drivers/remoteproc/st_slim_rproc.c b/drivers/remoteproc/st_slim_rproc.c
index 4ed9467897e5..d17719384c16 100644
--- a/drivers/remoteproc/st_slim_rproc.c
+++ b/drivers/remoteproc/st_slim_rproc.c
@@ -12,7 +12,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/remoteproc.h>
 #include <linux/remoteproc/st_slim_rproc.h>
diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index cf073bac79f7..98234b44f038 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -12,9 +12,9 @@
 #include <linux/mailbox_client.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
 #include <linux/pm_wakeirq.h>
 #include <linux/regmap.h>
 #include <linux/remoteproc.h>
diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
index ec626a37fef6..ef8415a7cd54 100644
--- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
@@ -9,7 +9,7 @@
 #include <linux/io.h>
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/omap-mailbox.h>
 #include <linux/platform_device.h>
diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
index 23fe44d4d7a5..ad3415a3851b 100644
--- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
@@ -12,9 +12,10 @@
 #include <linux/kernel.h>
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/of_reserved_mem.h>
+#include <linux/of_platform.h>
 #include <linux/omap-mailbox.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/remoteproc/wkup_m3_rproc.c b/drivers/remoteproc/wkup_m3_rproc.c
index 120dc7d2dac1..36a55f7ffa64 100644
--- a/drivers/remoteproc/wkup_m3_rproc.c
+++ b/drivers/remoteproc/wkup_m3_rproc.c
@@ -12,7 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-- 
2.40.1

