Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5A180616D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346435AbjLEWGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 17:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346455AbjLEWGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 17:06:06 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A853135;
        Tue,  5 Dec 2023 14:06:09 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1d08a924fcfso27332305ad.2;
        Tue, 05 Dec 2023 14:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701813969; x=1702418769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0Y5IM2vDue8lpCmMVrkGDpOK8xGwXyYPvY3SFd/ZFc=;
        b=ga1ZFGZtlKnDcTaVB5GvwjF6iQQl9xxZMIYa2WrQ6FTxCqpo5f30fE9jpyUkUrZLSj
         QngXHTZsZ18c9wtCJ3S5L4GiK5rW1yeU5ImoWMaMYiMFRzaQiGgRnz0DUNbVc7zj0z+4
         yjnKW2q4TV940h4AW6hzVHIs5K5blGMVEDaanlt8ZXRRa3gvEo2Wk6/ecTBC6DtJw8Gk
         2AYcbaSjPnYHjkcK7iSsjaFw3HebBok5VCSCUkBr+2pmF9gspIPCuROep2EEXN8DGLwi
         W1HUY9BPPiCoQ0sp5Nivag3tIPmo5dm/p68SqZw4krk0qw9wYY/nA7Bfa0rlSwELDV8M
         DiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701813969; x=1702418769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0Y5IM2vDue8lpCmMVrkGDpOK8xGwXyYPvY3SFd/ZFc=;
        b=Q2VpZ0AF+v25KV34nO98+2kr6VYPN8Phg4mSwhAbBCEMt8Hp6GSJu1fofxivz/4Njc
         sJEFJhDveI72P9wrYSts/9C+M88t3ocW4YZVNo4EHFkG92yYDwrM+Cg+fyoHUUQ2NEUg
         PQWr+Ih7fWE81qmtiMLCTHMUrp/TJ+6IkDTe4W5666Gg6JM0Rczn17LPEUBs+rG7cIu4
         k3Ce3m0xxlqjC+CAXHURCj90qbNuHkoU6EEuxEiJA33RuUonGP8AHsz53MyqCG5Hd4xA
         +oh+J/PzyjL5M9sQMm+mSn/etFI8rOBkD0NcpJSeAlGJl/HXfDC5hehFL5WjaUEeqt5E
         CMbw==
X-Gm-Message-State: AOJu0YyAslqsB4BwCqKp/nssZ5ndXIP2Hh5M7NcZq6PREVARD8fUo2a/
        8YCbr5vweSiIm1kRFModWtU=
X-Google-Smtp-Source: AGHT+IHJG4BKY3aS3NTFxpFz+sjEXOm4ND2PiRmRLhposCzjbOXluCzkhZwcs+OLvgwAfpAu11tz+A==
X-Received: by 2002:a17:902:c946:b0:1d0:7f06:1741 with SMTP id i6-20020a170902c94600b001d07f061741mr7074300pla.30.1701813968796;
        Tue, 05 Dec 2023 14:06:08 -0800 (PST)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id q24-20020a170902bd9800b001d1c96a0c63sm191990pls.274.2023.12.05.14.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 14:06:08 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/5] drm/msm/adreno: Split catalog into separate files
Date:   Tue,  5 Dec 2023 14:03:28 -0800
Message-ID: <20231205220526.417719-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231205220526.417719-1-robdclark@gmail.com>
References: <20231205220526.417719-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Split each gen's gpu table into it's own file.  Only code-motion, no
functional change.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/Makefile               |   5 +
 drivers/gpu/drm/msm/adreno/a2xx_catalog.c  |  53 ++
 drivers/gpu/drm/msm/adreno/a3xx_catalog.c  |  75 +++
 drivers/gpu/drm/msm/adreno/a4xx_catalog.c  |  51 ++
 drivers/gpu/drm/msm/adreno/a5xx_catalog.c  | 145 ++++++
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c  | 285 +++++++++++
 drivers/gpu/drm/msm/adreno/adreno_device.c | 570 +--------------------
 7 files changed, 620 insertions(+), 564 deletions(-)
 create mode 100644 drivers/gpu/drm/msm/adreno/a2xx_catalog.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a3xx_catalog.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a4xx_catalog.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a5xx_catalog.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a6xx_catalog.c

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 49671364fdcf..32f2fd980452 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -7,12 +7,17 @@ ccflags-$(CONFIG_DRM_MSM_DP) += -I $(srctree)/$(src)/dp
 msm-y := \
 	adreno/adreno_device.o \
 	adreno/adreno_gpu.o \
+	adreno/a2xx_catalog.o \
 	adreno/a2xx_gpu.o \
+	adreno/a3xx_catalog.o \
 	adreno/a3xx_gpu.o \
+	adreno/a4xx_catalog.o \
 	adreno/a4xx_gpu.o \
+	adreno/a5xx_catalog.o \
 	adreno/a5xx_gpu.o \
 	adreno/a5xx_power.o \
 	adreno/a5xx_preempt.o \
+	adreno/a6xx_catalog.o \
 	adreno/a6xx_gpu.o \
 	adreno/a6xx_gmu.o \
 	adreno/a6xx_hfi.o \
diff --git a/drivers/gpu/drm/msm/adreno/a2xx_catalog.c b/drivers/gpu/drm/msm/adreno/a2xx_catalog.c
new file mode 100644
index 000000000000..1a4d182279fc
--- /dev/null
+++ b/drivers/gpu/drm/msm/adreno/a2xx_catalog.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2013-2014 Red Hat
+ * Author: Rob Clark <robdclark@gmail.com>
+ *
+ * Copyright (c) 2014,2017 The Linux Foundation. All rights reserved.
+ */
+
+#include "adreno_gpu.h"
+
+const struct adreno_info a2xx_gpus[] = {
+	{
+		.chip_ids = ADRENO_CHIP_IDS(0x02000000),
+		.family = ADRENO_2XX_GEN1,
+		.revn  = 200,
+		.fw = {
+			[ADRENO_FW_PM4] = "yamato_pm4.fw",
+			[ADRENO_FW_PFP] = "yamato_pfp.fw",
+		},
+		.gmem  = SZ_256K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init  = a2xx_gpu_init,
+	}, { /* a200 on i.mx51 has only 128kib gmem */
+		.chip_ids = ADRENO_CHIP_IDS(0x02000001),
+		.family = ADRENO_2XX_GEN1,
+		.revn  = 201,
+		.fw = {
+			[ADRENO_FW_PM4] = "yamato_pm4.fw",
+			[ADRENO_FW_PFP] = "yamato_pfp.fw",
+		},
+		.gmem  = SZ_128K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init  = a2xx_gpu_init,
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x02020000),
+		.family = ADRENO_2XX_GEN2,
+		.revn  = 220,
+		.fw = {
+			[ADRENO_FW_PM4] = "leia_pm4_470.fw",
+			[ADRENO_FW_PFP] = "leia_pfp_470.fw",
+		},
+		.gmem  = SZ_512K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init  = a2xx_gpu_init,
+	}, {
+		/* sentinal */
+	}
+};
+
+MODULE_FIRMWARE("qcom/leia_pfp_470.fw");
+MODULE_FIRMWARE("qcom/leia_pm4_470.fw");
+MODULE_FIRMWARE("qcom/yamato_pfp.fw");
+MODULE_FIRMWARE("qcom/yamato_pm4.fw");
\ No newline at end of file
diff --git a/drivers/gpu/drm/msm/adreno/a3xx_catalog.c b/drivers/gpu/drm/msm/adreno/a3xx_catalog.c
new file mode 100644
index 000000000000..1f1fa70c5e5e
--- /dev/null
+++ b/drivers/gpu/drm/msm/adreno/a3xx_catalog.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2013-2014 Red Hat
+ * Author: Rob Clark <robdclark@gmail.com>
+ *
+ * Copyright (c) 2014,2017 The Linux Foundation. All rights reserved.
+ */
+
+#include "adreno_gpu.h"
+
+const struct adreno_info a3xx_gpus[] = {
+	{
+		.chip_ids = ADRENO_CHIP_IDS(
+			0x03000512,
+			0x03000520
+		),
+		.family = ADRENO_3XX,
+		.revn  = 305,
+		.fw = {
+			[ADRENO_FW_PM4] = "a300_pm4.fw",
+			[ADRENO_FW_PFP] = "a300_pfp.fw",
+		},
+		.gmem  = SZ_256K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init  = a3xx_gpu_init,
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x03000600),
+		.family = ADRENO_3XX,
+		.revn  = 307,        /* because a305c is revn==306 */
+		.fw = {
+			[ADRENO_FW_PM4] = "a300_pm4.fw",
+			[ADRENO_FW_PFP] = "a300_pfp.fw",
+		},
+		.gmem  = SZ_128K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init  = a3xx_gpu_init,
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(
+			0x03020000,
+			0x03020001,
+			0x03020002
+		),
+		.family = ADRENO_3XX,
+		.revn  = 320,
+		.fw = {
+			[ADRENO_FW_PM4] = "a300_pm4.fw",
+			[ADRENO_FW_PFP] = "a300_pfp.fw",
+		},
+		.gmem  = SZ_512K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init  = a3xx_gpu_init,
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(
+			0x03030000,
+			0x03030001,
+			0x03030002
+		),
+		.family = ADRENO_3XX,
+		.revn  = 330,
+		.fw = {
+			[ADRENO_FW_PM4] = "a330_pm4.fw",
+			[ADRENO_FW_PFP] = "a330_pfp.fw",
+		},
+		.gmem  = SZ_1M,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init  = a3xx_gpu_init,
+	}, {
+		/* sentinal */
+	}
+};
+
+MODULE_FIRMWARE("qcom/a300_pm4.fw");
+MODULE_FIRMWARE("qcom/a300_pfp.fw");
+MODULE_FIRMWARE("qcom/a330_pm4.fw");
+MODULE_FIRMWARE("qcom/a330_pfp.fw");
\ No newline at end of file
diff --git a/drivers/gpu/drm/msm/adreno/a4xx_catalog.c b/drivers/gpu/drm/msm/adreno/a4xx_catalog.c
new file mode 100644
index 000000000000..39d92cb4bcf5
--- /dev/null
+++ b/drivers/gpu/drm/msm/adreno/a4xx_catalog.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2013-2014 Red Hat
+ * Author: Rob Clark <robdclark@gmail.com>
+ *
+ * Copyright (c) 2014,2017 The Linux Foundation. All rights reserved.
+ */
+
+#include "adreno_gpu.h"
+
+const struct adreno_info a4xx_gpus[] = {
+	{
+		.chip_ids = ADRENO_CHIP_IDS(0x04000500),
+		.family = ADRENO_4XX,
+		.revn  = 405,
+		.fw = {
+			[ADRENO_FW_PM4] = "a420_pm4.fw",
+			[ADRENO_FW_PFP] = "a420_pfp.fw",
+		},
+		.gmem  = SZ_256K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init  = a4xx_gpu_init,
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x04020000),
+		.family = ADRENO_4XX,
+		.revn  = 420,
+		.fw = {
+			[ADRENO_FW_PM4] = "a420_pm4.fw",
+			[ADRENO_FW_PFP] = "a420_pfp.fw",
+		},
+		.gmem  = (SZ_1M + SZ_512K),
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init  = a4xx_gpu_init,
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x04030002),
+		.family = ADRENO_4XX,
+		.revn  = 430,
+		.fw = {
+			[ADRENO_FW_PM4] = "a420_pm4.fw",
+			[ADRENO_FW_PFP] = "a420_pfp.fw",
+		},
+		.gmem  = (SZ_1M + SZ_512K),
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init  = a4xx_gpu_init,
+	}, {
+		/* sentinal */
+	}
+};
+
+MODULE_FIRMWARE("qcom/a420_pm4.fw");
+MODULE_FIRMWARE("qcom/a420_pfp.fw");
\ No newline at end of file
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_catalog.c b/drivers/gpu/drm/msm/adreno/a5xx_catalog.c
new file mode 100644
index 000000000000..80d70ee8c1f2
--- /dev/null
+++ b/drivers/gpu/drm/msm/adreno/a5xx_catalog.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2013-2014 Red Hat
+ * Author: Rob Clark <robdclark@gmail.com>
+ *
+ * Copyright (c) 2014,2017 The Linux Foundation. All rights reserved.
+ */
+
+#include "adreno_gpu.h"
+
+const struct adreno_info a5xx_gpus[] = {
+	{
+		.chip_ids = ADRENO_CHIP_IDS(0x05000600),
+		.family = ADRENO_5XX,
+		.revn = 506,
+		.fw = {
+			[ADRENO_FW_PM4] = "a530_pm4.fw",
+			[ADRENO_FW_PFP] = "a530_pfp.fw",
+		},
+		.gmem = (SZ_128K + SZ_8K),
+		/*
+		 * Increase inactive period to 250 to avoid bouncing
+		 * the GDSC which appears to make it grumpy
+		 */
+		.inactive_period = 250,
+		.quirks = ADRENO_QUIRK_TWO_PASS_USE_WFI |
+			  ADRENO_QUIRK_LMLOADKILL_DISABLE,
+		.init = a5xx_gpu_init,
+		.zapfw = "a506_zap.mdt",
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x05000800),
+		.family = ADRENO_5XX,
+		.revn = 508,
+		.fw = {
+			[ADRENO_FW_PM4] = "a530_pm4.fw",
+			[ADRENO_FW_PFP] = "a530_pfp.fw",
+		},
+		.gmem = (SZ_128K + SZ_8K),
+		/*
+		 * Increase inactive period to 250 to avoid bouncing
+		 * the GDSC which appears to make it grumpy
+		 */
+		.inactive_period = 250,
+		.quirks = ADRENO_QUIRK_LMLOADKILL_DISABLE,
+		.init = a5xx_gpu_init,
+		.zapfw = "a508_zap.mdt",
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x05000900),
+		.family = ADRENO_5XX,
+		.revn = 509,
+		.fw = {
+			[ADRENO_FW_PM4] = "a530_pm4.fw",
+			[ADRENO_FW_PFP] = "a530_pfp.fw",
+		},
+		.gmem = (SZ_256K + SZ_16K),
+		/*
+		 * Increase inactive period to 250 to avoid bouncing
+		 * the GDSC which appears to make it grumpy
+		 */
+		.inactive_period = 250,
+		.quirks = ADRENO_QUIRK_LMLOADKILL_DISABLE,
+		.init = a5xx_gpu_init,
+		/* Adreno 509 uses the same ZAP as 512 */
+		.zapfw = "a512_zap.mdt",
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x05010000),
+		.family = ADRENO_5XX,
+		.revn = 510,
+		.fw = {
+			[ADRENO_FW_PM4] = "a530_pm4.fw",
+			[ADRENO_FW_PFP] = "a530_pfp.fw",
+		},
+		.gmem = SZ_256K,
+		/*
+		 * Increase inactive period to 250 to avoid bouncing
+		 * the GDSC which appears to make it grumpy
+		 */
+		.inactive_period = 250,
+		.init = a5xx_gpu_init,
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x05010200),
+		.family = ADRENO_5XX,
+		.revn = 512,
+		.fw = {
+			[ADRENO_FW_PM4] = "a530_pm4.fw",
+			[ADRENO_FW_PFP] = "a530_pfp.fw",
+		},
+		.gmem = (SZ_256K + SZ_16K),
+		/*
+		 * Increase inactive period to 250 to avoid bouncing
+		 * the GDSC which appears to make it grumpy
+		 */
+		.inactive_period = 250,
+		.quirks = ADRENO_QUIRK_LMLOADKILL_DISABLE,
+		.init = a5xx_gpu_init,
+		.zapfw = "a512_zap.mdt",
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(
+			0x05030002,
+			0x05030004
+		),
+		.family = ADRENO_5XX,
+		.revn = 530,
+		.fw = {
+			[ADRENO_FW_PM4] = "a530_pm4.fw",
+			[ADRENO_FW_PFP] = "a530_pfp.fw",
+			[ADRENO_FW_GPMU] = "a530v3_gpmu.fw2",
+		},
+		.gmem = SZ_1M,
+		/*
+		 * Increase inactive period to 250 to avoid bouncing
+		 * the GDSC which appears to make it grumpy
+		 */
+		.inactive_period = 250,
+		.quirks = ADRENO_QUIRK_TWO_PASS_USE_WFI |
+			ADRENO_QUIRK_FAULT_DETECT_MASK,
+		.init = a5xx_gpu_init,
+		.zapfw = "a530_zap.mdt",
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x05040001),
+		.family = ADRENO_5XX,
+		.revn = 540,
+		.fw = {
+			[ADRENO_FW_PM4] = "a530_pm4.fw",
+			[ADRENO_FW_PFP] = "a530_pfp.fw",
+			[ADRENO_FW_GPMU] = "a540_gpmu.fw2",
+		},
+		.gmem = SZ_1M,
+		/*
+		 * Increase inactive period to 250 to avoid bouncing
+		 * the GDSC which appears to make it grumpy
+		 */
+		.inactive_period = 250,
+		.quirks = ADRENO_QUIRK_LMLOADKILL_DISABLE,
+		.init = a5xx_gpu_init,
+		.zapfw = "a540_zap.mdt",
+	}, {
+		/* sentinal */
+	}
+};
+
+MODULE_FIRMWARE("qcom/a530_pm4.fw");
+MODULE_FIRMWARE("qcom/a530_pfp.fw");
+MODULE_FIRMWARE("qcom/a530v3_gpmu.fw2");
+MODULE_FIRMWARE("qcom/a540_gpmu.fw2");
\ No newline at end of file
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
new file mode 100644
index 000000000000..5c1199eab82b
--- /dev/null
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2013-2014 Red Hat
+ * Author: Rob Clark <robdclark@gmail.com>
+ *
+ * Copyright (c) 2014,2017 The Linux Foundation. All rights reserved.
+ */
+
+#include "adreno_gpu.h"
+
+const struct adreno_info a6xx_gpus[] = {
+	{
+		.chip_ids = ADRENO_CHIP_IDS(0x06010000),
+		.family = ADRENO_6XX_GEN1,
+		.revn = 610,
+		.fw = {
+			[ADRENO_FW_SQE] = "a630_sqe.fw",
+		},
+		.gmem = (SZ_128K + SZ_4K),
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init = a6xx_gpu_init,
+		.zapfw = "a610_zap.mdt",
+		.hwcg = a612_hwcg,
+		/*
+		 * There are (at least) three SoCs implementing A610: SM6125
+		 * (trinket), SM6115 (bengal) and SM6225 (khaje). Trinket does
+		 * not have speedbinning, as only a single SKU exists and we
+		 * don't support khaje upstream yet.  Hence, this matching
+		 * table is only valid for bengal.
+		 */
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0,   0 },
+			{ 206, 1 },
+			{ 200, 2 },
+			{ 157, 3 },
+			{ 127, 4 },
+		),
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x06010800),
+		.family = ADRENO_6XX_GEN1,
+		.revn = 618,
+		.fw = {
+			[ADRENO_FW_SQE] = "a630_sqe.fw",
+			[ADRENO_FW_GMU] = "a630_gmu.bin",
+		},
+		.gmem = SZ_512K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
+		.init = a6xx_gpu_init,
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0,   0 },
+			{ 169, 1 },
+			{ 174, 2 },
+		),
+	}, {
+		.machine = "qcom,sm4350",
+		.chip_ids = ADRENO_CHIP_IDS(0x06010900),
+		.family = ADRENO_6XX_GEN1,
+		.revn = 619,
+		.fw = {
+			[ADRENO_FW_SQE] = "a630_sqe.fw",
+			[ADRENO_FW_GMU] = "a619_gmu.bin",
+		},
+		.gmem = SZ_512K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init = a6xx_gpu_init,
+		.zapfw = "a615_zap.mdt",
+		.hwcg = a615_hwcg,
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0,   0 },
+			{ 138, 1 },
+			{ 92,  2 },
+		),
+	}, {
+		.machine = "qcom,sm6375",
+		.chip_ids = ADRENO_CHIP_IDS(0x06010901),
+		.family = ADRENO_6XX_GEN1,
+		.revn = 619,
+		.fw = {
+			[ADRENO_FW_SQE] = "a630_sqe.fw",
+			[ADRENO_FW_GMU] = "a619_gmu.bin",
+		},
+		.gmem = SZ_512K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init = a6xx_gpu_init,
+		.zapfw = "a615_zap.mdt",
+		.hwcg = a615_hwcg,
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0,   0 },
+			{ 190, 1 },
+			{ 177, 2 },
+		),
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x06010900),
+		.family = ADRENO_6XX_GEN1,
+		.revn = 619,
+		.fw = {
+			[ADRENO_FW_SQE] = "a630_sqe.fw",
+			[ADRENO_FW_GMU] = "a619_gmu.bin",
+		},
+		.gmem = SZ_512K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
+		.init = a6xx_gpu_init,
+		.zapfw = "a615_zap.mdt",
+		.hwcg = a615_hwcg,
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0,   0 },
+			{ 120, 4 },
+			{ 138, 3 },
+			{ 169, 2 },
+			{ 180, 1 },
+		),
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(
+			0x06030001,
+			0x06030002
+		),
+		.family = ADRENO_6XX_GEN1,
+		.revn = 630,
+		.fw = {
+			[ADRENO_FW_SQE] = "a630_sqe.fw",
+			[ADRENO_FW_GMU] = "a630_gmu.bin",
+		},
+		.gmem = SZ_1M,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
+		.init = a6xx_gpu_init,
+		.zapfw = "a630_zap.mdt",
+		.hwcg = a630_hwcg,
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x06040001),
+		.family = ADRENO_6XX_GEN2,
+		.revn = 640,
+		.fw = {
+			[ADRENO_FW_SQE] = "a630_sqe.fw",
+			[ADRENO_FW_GMU] = "a640_gmu.bin",
+		},
+		.gmem = SZ_1M,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
+		.init = a6xx_gpu_init,
+		.zapfw = "a640_zap.mdt",
+		.hwcg = a640_hwcg,
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0, 0 },
+			{ 1, 1 },
+		),
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x06050002),
+		.family = ADRENO_6XX_GEN3,
+		.revn = 650,
+		.fw = {
+			[ADRENO_FW_SQE] = "a650_sqe.fw",
+			[ADRENO_FW_GMU] = "a650_gmu.bin",
+		},
+		.gmem = SZ_1M + SZ_128K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
+			ADRENO_QUIRK_HAS_HW_APRIV,
+		.init = a6xx_gpu_init,
+		.zapfw = "a650_zap.mdt",
+		.hwcg = a650_hwcg,
+		.address_space_size = SZ_16G,
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0, 0 },
+			{ 1, 1 },
+			{ 2, 3 }, /* Yep, 2 and 3 are swapped! :/ */
+			{ 3, 2 },
+		),
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x06060001),
+		.family = ADRENO_6XX_GEN4,
+		.revn = 660,
+		.fw = {
+			[ADRENO_FW_SQE] = "a660_sqe.fw",
+			[ADRENO_FW_GMU] = "a660_gmu.bin",
+		},
+		.gmem = SZ_1M + SZ_512K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
+			ADRENO_QUIRK_HAS_HW_APRIV,
+		.init = a6xx_gpu_init,
+		.zapfw = "a660_zap.mdt",
+		.hwcg = a660_hwcg,
+		.address_space_size = SZ_16G,
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x06030500),
+		.family = ADRENO_6XX_GEN4,
+		.fw = {
+			[ADRENO_FW_SQE] = "a660_sqe.fw",
+			[ADRENO_FW_GMU] = "a660_gmu.bin",
+		},
+		.gmem = SZ_512K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
+			ADRENO_QUIRK_HAS_HW_APRIV,
+		.init = a6xx_gpu_init,
+		.zapfw = "a660_zap.mbn",
+		.hwcg = a660_hwcg,
+		.address_space_size = SZ_16G,
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0,   0 },
+			{ 117, 0 },
+			{ 172, 2 }, /* Called speedbin 1 downstream, but let's not break things! */
+			{ 190, 1 },
+		),
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x06080000),
+		.family = ADRENO_6XX_GEN2,
+		.revn = 680,
+		.fw = {
+			[ADRENO_FW_SQE] = "a630_sqe.fw",
+			[ADRENO_FW_GMU] = "a640_gmu.bin",
+		},
+		.gmem = SZ_2M,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
+		.init = a6xx_gpu_init,
+		.zapfw = "a640_zap.mdt",
+		.hwcg = a640_hwcg,
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x06090000),
+		.family = ADRENO_6XX_GEN4,
+		.fw = {
+			[ADRENO_FW_SQE] = "a660_sqe.fw",
+			[ADRENO_FW_GMU] = "a660_gmu.bin",
+		},
+		.gmem = SZ_4M,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
+			ADRENO_QUIRK_HAS_HW_APRIV,
+		.init = a6xx_gpu_init,
+		.zapfw = "a690_zap.mdt",
+		.hwcg = a690_hwcg,
+		.address_space_size = SZ_16G,
+	}, {
+		/* sentinal */
+	}
+};
+
+MODULE_FIRMWARE("qcom/a619_gmu.bin");
+MODULE_FIRMWARE("qcom/a630_sqe.fw");
+MODULE_FIRMWARE("qcom/a630_gmu.bin");
+MODULE_FIRMWARE("qcom/a640_gmu.bin");
+MODULE_FIRMWARE("qcom/a650_gmu.bin");
+MODULE_FIRMWARE("qcom/a650_sqe.fw");
+MODULE_FIRMWARE("qcom/a660_gmu.bin");
+MODULE_FIRMWARE("qcom/a660_sqe.fw");
+
+const struct adreno_info a7xx_gpus[] = {
+	{
+		.chip_ids = ADRENO_CHIP_IDS(0x07030001),
+		.family = ADRENO_7XX_GEN1,
+		.fw = {
+			[ADRENO_FW_SQE] = "a730_sqe.fw",
+			[ADRENO_FW_GMU] = "gmu_gen70000.bin",
+		},
+		.gmem = SZ_2M,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
+			  ADRENO_QUIRK_HAS_HW_APRIV,
+		.init = a6xx_gpu_init,
+		.zapfw = "a730_zap.mdt",
+		.hwcg = a730_hwcg,
+		.address_space_size = SZ_16G,
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x43050a01), /* "C510v2" */
+		.family = ADRENO_7XX_GEN2,
+		.fw = {
+			[ADRENO_FW_SQE] = "a740_sqe.fw",
+			[ADRENO_FW_GMU] = "gmu_gen70200.bin",
+		},
+		.gmem = 3 * SZ_1M,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
+			  ADRENO_QUIRK_HAS_HW_APRIV,
+		.init = a6xx_gpu_init,
+		.zapfw = "a740_zap.mdt",
+		.hwcg = a740_hwcg,
+		.address_space_size = SZ_16G,
+	}, {
+		/* sentinal */
+	}
+};
\ No newline at end of file
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 36392801f929..8af921193f1e 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -20,542 +20,12 @@ bool allow_vram_carveout = false;
 MODULE_PARM_DESC(allow_vram_carveout, "Allow using VRAM Carveout, in place of IOMMU");
 module_param_named(allow_vram_carveout, allow_vram_carveout, bool, 0600);
 
-static const struct adreno_info a2xx_gpus[] = {
-	{
-		.chip_ids = ADRENO_CHIP_IDS(0x02000000),
-		.family = ADRENO_2XX_GEN1,
-		.revn  = 200,
-		.fw = {
-			[ADRENO_FW_PM4] = "yamato_pm4.fw",
-			[ADRENO_FW_PFP] = "yamato_pfp.fw",
-		},
-		.gmem  = SZ_256K,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init  = a2xx_gpu_init,
-	}, { /* a200 on i.mx51 has only 128kib gmem */
-		.chip_ids = ADRENO_CHIP_IDS(0x02000001),
-		.family = ADRENO_2XX_GEN1,
-		.revn  = 201,
-		.fw = {
-			[ADRENO_FW_PM4] = "yamato_pm4.fw",
-			[ADRENO_FW_PFP] = "yamato_pfp.fw",
-		},
-		.gmem  = SZ_128K,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init  = a2xx_gpu_init,
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x02020000),
-		.family = ADRENO_2XX_GEN2,
-		.revn  = 220,
-		.fw = {
-			[ADRENO_FW_PM4] = "leia_pm4_470.fw",
-			[ADRENO_FW_PFP] = "leia_pfp_470.fw",
-		},
-		.gmem  = SZ_512K,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init  = a2xx_gpu_init,
-	}, {
-		/* sentinal */
-	}
-};
-
-static const struct adreno_info a3xx_gpus[] = {
-	{
-		.chip_ids = ADRENO_CHIP_IDS(
-			0x03000512,
-			0x03000520
-		),
-		.family = ADRENO_3XX,
-		.revn  = 305,
-		.fw = {
-			[ADRENO_FW_PM4] = "a300_pm4.fw",
-			[ADRENO_FW_PFP] = "a300_pfp.fw",
-		},
-		.gmem  = SZ_256K,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init  = a3xx_gpu_init,
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x03000600),
-		.family = ADRENO_3XX,
-		.revn  = 307,        /* because a305c is revn==306 */
-		.fw = {
-			[ADRENO_FW_PM4] = "a300_pm4.fw",
-			[ADRENO_FW_PFP] = "a300_pfp.fw",
-		},
-		.gmem  = SZ_128K,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init  = a3xx_gpu_init,
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(
-			0x03020000,
-			0x03020001,
-			0x03020002
-		),
-		.family = ADRENO_3XX,
-		.revn  = 320,
-		.fw = {
-			[ADRENO_FW_PM4] = "a300_pm4.fw",
-			[ADRENO_FW_PFP] = "a300_pfp.fw",
-		},
-		.gmem  = SZ_512K,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init  = a3xx_gpu_init,
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(
-			0x03030000,
-			0x03030001,
-			0x03030002
-		),
-		.family = ADRENO_3XX,
-		.revn  = 330,
-		.fw = {
-			[ADRENO_FW_PM4] = "a330_pm4.fw",
-			[ADRENO_FW_PFP] = "a330_pfp.fw",
-		},
-		.gmem  = SZ_1M,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init  = a3xx_gpu_init,
-	}, {
-		/* sentinal */
-	}
-};
-
-static const struct adreno_info a4xx_gpus[] = {
-	{
-		.chip_ids = ADRENO_CHIP_IDS(0x04000500),
-		.family = ADRENO_4XX,
-		.revn  = 405,
-		.fw = {
-			[ADRENO_FW_PM4] = "a420_pm4.fw",
-			[ADRENO_FW_PFP] = "a420_pfp.fw",
-		},
-		.gmem  = SZ_256K,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init  = a4xx_gpu_init,
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x04020000),
-		.family = ADRENO_4XX,
-		.revn  = 420,
-		.fw = {
-			[ADRENO_FW_PM4] = "a420_pm4.fw",
-			[ADRENO_FW_PFP] = "a420_pfp.fw",
-		},
-		.gmem  = (SZ_1M + SZ_512K),
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init  = a4xx_gpu_init,
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x04030002),
-		.family = ADRENO_4XX,
-		.revn  = 430,
-		.fw = {
-			[ADRENO_FW_PM4] = "a420_pm4.fw",
-			[ADRENO_FW_PFP] = "a420_pfp.fw",
-		},
-		.gmem  = (SZ_1M + SZ_512K),
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init  = a4xx_gpu_init,
-	}, {
-		/* sentinal */
-	}
-};
-
-static const struct adreno_info a5xx_gpus[] = {
-	{
-		.chip_ids = ADRENO_CHIP_IDS(0x05000600),
-		.family = ADRENO_5XX,
-		.revn = 506,
-		.fw = {
-			[ADRENO_FW_PM4] = "a530_pm4.fw",
-			[ADRENO_FW_PFP] = "a530_pfp.fw",
-		},
-		.gmem = (SZ_128K + SZ_8K),
-		/*
-		 * Increase inactive period to 250 to avoid bouncing
-		 * the GDSC which appears to make it grumpy
-		 */
-		.inactive_period = 250,
-		.quirks = ADRENO_QUIRK_TWO_PASS_USE_WFI |
-			  ADRENO_QUIRK_LMLOADKILL_DISABLE,
-		.init = a5xx_gpu_init,
-		.zapfw = "a506_zap.mdt",
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x05000800),
-		.family = ADRENO_5XX,
-		.revn = 508,
-		.fw = {
-			[ADRENO_FW_PM4] = "a530_pm4.fw",
-			[ADRENO_FW_PFP] = "a530_pfp.fw",
-		},
-		.gmem = (SZ_128K + SZ_8K),
-		/*
-		 * Increase inactive period to 250 to avoid bouncing
-		 * the GDSC which appears to make it grumpy
-		 */
-		.inactive_period = 250,
-		.quirks = ADRENO_QUIRK_LMLOADKILL_DISABLE,
-		.init = a5xx_gpu_init,
-		.zapfw = "a508_zap.mdt",
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x05000900),
-		.family = ADRENO_5XX,
-		.revn = 509,
-		.fw = {
-			[ADRENO_FW_PM4] = "a530_pm4.fw",
-			[ADRENO_FW_PFP] = "a530_pfp.fw",
-		},
-		.gmem = (SZ_256K + SZ_16K),
-		/*
-		 * Increase inactive period to 250 to avoid bouncing
-		 * the GDSC which appears to make it grumpy
-		 */
-		.inactive_period = 250,
-		.quirks = ADRENO_QUIRK_LMLOADKILL_DISABLE,
-		.init = a5xx_gpu_init,
-		/* Adreno 509 uses the same ZAP as 512 */
-		.zapfw = "a512_zap.mdt",
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x05010000),
-		.family = ADRENO_5XX,
-		.revn = 510,
-		.fw = {
-			[ADRENO_FW_PM4] = "a530_pm4.fw",
-			[ADRENO_FW_PFP] = "a530_pfp.fw",
-		},
-		.gmem = SZ_256K,
-		/*
-		 * Increase inactive period to 250 to avoid bouncing
-		 * the GDSC which appears to make it grumpy
-		 */
-		.inactive_period = 250,
-		.init = a5xx_gpu_init,
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x05010200),
-		.family = ADRENO_5XX,
-		.revn = 512,
-		.fw = {
-			[ADRENO_FW_PM4] = "a530_pm4.fw",
-			[ADRENO_FW_PFP] = "a530_pfp.fw",
-		},
-		.gmem = (SZ_256K + SZ_16K),
-		/*
-		 * Increase inactive period to 250 to avoid bouncing
-		 * the GDSC which appears to make it grumpy
-		 */
-		.inactive_period = 250,
-		.quirks = ADRENO_QUIRK_LMLOADKILL_DISABLE,
-		.init = a5xx_gpu_init,
-		.zapfw = "a512_zap.mdt",
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(
-			0x05030002,
-			0x05030004
-		),
-		.family = ADRENO_5XX,
-		.revn = 530,
-		.fw = {
-			[ADRENO_FW_PM4] = "a530_pm4.fw",
-			[ADRENO_FW_PFP] = "a530_pfp.fw",
-			[ADRENO_FW_GPMU] = "a530v3_gpmu.fw2",
-		},
-		.gmem = SZ_1M,
-		/*
-		 * Increase inactive period to 250 to avoid bouncing
-		 * the GDSC which appears to make it grumpy
-		 */
-		.inactive_period = 250,
-		.quirks = ADRENO_QUIRK_TWO_PASS_USE_WFI |
-			ADRENO_QUIRK_FAULT_DETECT_MASK,
-		.init = a5xx_gpu_init,
-		.zapfw = "a530_zap.mdt",
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x05040001),
-		.family = ADRENO_5XX,
-		.revn = 540,
-		.fw = {
-			[ADRENO_FW_PM4] = "a530_pm4.fw",
-			[ADRENO_FW_PFP] = "a530_pfp.fw",
-			[ADRENO_FW_GPMU] = "a540_gpmu.fw2",
-		},
-		.gmem = SZ_1M,
-		/*
-		 * Increase inactive period to 250 to avoid bouncing
-		 * the GDSC which appears to make it grumpy
-		 */
-		.inactive_period = 250,
-		.quirks = ADRENO_QUIRK_LMLOADKILL_DISABLE,
-		.init = a5xx_gpu_init,
-		.zapfw = "a540_zap.mdt",
-	}, {
-		/* sentinal */
-	}
-};
-
-static const struct adreno_info a6xx_gpus[] = {
-	{
-		.chip_ids = ADRENO_CHIP_IDS(0x06010000),
-		.family = ADRENO_6XX_GEN1,
-		.revn = 610,
-		.fw = {
-			[ADRENO_FW_SQE] = "a630_sqe.fw",
-		},
-		.gmem = (SZ_128K + SZ_4K),
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init = a6xx_gpu_init,
-		.zapfw = "a610_zap.mdt",
-		.hwcg = a612_hwcg,
-		/*
-		 * There are (at least) three SoCs implementing A610: SM6125
-		 * (trinket), SM6115 (bengal) and SM6225 (khaje). Trinket does
-		 * not have speedbinning, as only a single SKU exists and we
-		 * don't support khaje upstream yet.  Hence, this matching
-		 * table is only valid for bengal.
-		 */
-		.speedbins = ADRENO_SPEEDBINS(
-			{ 0,   0 },
-			{ 206, 1 },
-			{ 200, 2 },
-			{ 157, 3 },
-			{ 127, 4 },
-		),
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x06010800),
-		.family = ADRENO_6XX_GEN1,
-		.revn = 618,
-		.fw = {
-			[ADRENO_FW_SQE] = "a630_sqe.fw",
-			[ADRENO_FW_GMU] = "a630_gmu.bin",
-		},
-		.gmem = SZ_512K,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
-		.init = a6xx_gpu_init,
-		.speedbins = ADRENO_SPEEDBINS(
-			{ 0,   0 },
-			{ 169, 1 },
-			{ 174, 2 },
-		),
-	}, {
-		.machine = "qcom,sm4350",
-		.chip_ids = ADRENO_CHIP_IDS(0x06010900),
-		.family = ADRENO_6XX_GEN1,
-		.revn = 619,
-		.fw = {
-			[ADRENO_FW_SQE] = "a630_sqe.fw",
-			[ADRENO_FW_GMU] = "a619_gmu.bin",
-		},
-		.gmem = SZ_512K,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init = a6xx_gpu_init,
-		.zapfw = "a615_zap.mdt",
-		.hwcg = a615_hwcg,
-		.speedbins = ADRENO_SPEEDBINS(
-			{ 0,   0 },
-			{ 138, 1 },
-			{ 92,  2 },
-		),
-	}, {
-		.machine = "qcom,sm6375",
-		.chip_ids = ADRENO_CHIP_IDS(0x06010901),
-		.family = ADRENO_6XX_GEN1,
-		.revn = 619,
-		.fw = {
-			[ADRENO_FW_SQE] = "a630_sqe.fw",
-			[ADRENO_FW_GMU] = "a619_gmu.bin",
-		},
-		.gmem = SZ_512K,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init = a6xx_gpu_init,
-		.zapfw = "a615_zap.mdt",
-		.hwcg = a615_hwcg,
-		.speedbins = ADRENO_SPEEDBINS(
-			{ 0,   0 },
-			{ 190, 1 },
-			{ 177, 2 },
-		),
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x06010900),
-		.family = ADRENO_6XX_GEN1,
-		.revn = 619,
-		.fw = {
-			[ADRENO_FW_SQE] = "a630_sqe.fw",
-			[ADRENO_FW_GMU] = "a619_gmu.bin",
-		},
-		.gmem = SZ_512K,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
-		.init = a6xx_gpu_init,
-		.zapfw = "a615_zap.mdt",
-		.hwcg = a615_hwcg,
-		.speedbins = ADRENO_SPEEDBINS(
-			{ 0,   0 },
-			{ 120, 4 },
-			{ 138, 3 },
-			{ 169, 2 },
-			{ 180, 1 },
-		),
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(
-			0x06030001,
-			0x06030002
-		),
-		.family = ADRENO_6XX_GEN1,
-		.revn = 630,
-		.fw = {
-			[ADRENO_FW_SQE] = "a630_sqe.fw",
-			[ADRENO_FW_GMU] = "a630_gmu.bin",
-		},
-		.gmem = SZ_1M,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
-		.init = a6xx_gpu_init,
-		.zapfw = "a630_zap.mdt",
-		.hwcg = a630_hwcg,
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x06040001),
-		.family = ADRENO_6XX_GEN2,
-		.revn = 640,
-		.fw = {
-			[ADRENO_FW_SQE] = "a630_sqe.fw",
-			[ADRENO_FW_GMU] = "a640_gmu.bin",
-		},
-		.gmem = SZ_1M,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
-		.init = a6xx_gpu_init,
-		.zapfw = "a640_zap.mdt",
-		.hwcg = a640_hwcg,
-		.speedbins = ADRENO_SPEEDBINS(
-			{ 0, 0 },
-			{ 1, 1 },
-		),
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x06050002),
-		.family = ADRENO_6XX_GEN3,
-		.revn = 650,
-		.fw = {
-			[ADRENO_FW_SQE] = "a650_sqe.fw",
-			[ADRENO_FW_GMU] = "a650_gmu.bin",
-		},
-		.gmem = SZ_1M + SZ_128K,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			ADRENO_QUIRK_HAS_HW_APRIV,
-		.init = a6xx_gpu_init,
-		.zapfw = "a650_zap.mdt",
-		.hwcg = a650_hwcg,
-		.address_space_size = SZ_16G,
-		.speedbins = ADRENO_SPEEDBINS(
-			{ 0, 0 },
-			{ 1, 1 },
-			{ 2, 3 }, /* Yep, 2 and 3 are swapped! :/ */
-			{ 3, 2 },
-		),
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x06060001),
-		.family = ADRENO_6XX_GEN4,
-		.revn = 660,
-		.fw = {
-			[ADRENO_FW_SQE] = "a660_sqe.fw",
-			[ADRENO_FW_GMU] = "a660_gmu.bin",
-		},
-		.gmem = SZ_1M + SZ_512K,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			ADRENO_QUIRK_HAS_HW_APRIV,
-		.init = a6xx_gpu_init,
-		.zapfw = "a660_zap.mdt",
-		.hwcg = a660_hwcg,
-		.address_space_size = SZ_16G,
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x06030500),
-		.family = ADRENO_6XX_GEN4,
-		.fw = {
-			[ADRENO_FW_SQE] = "a660_sqe.fw",
-			[ADRENO_FW_GMU] = "a660_gmu.bin",
-		},
-		.gmem = SZ_512K,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			ADRENO_QUIRK_HAS_HW_APRIV,
-		.init = a6xx_gpu_init,
-		.zapfw = "a660_zap.mbn",
-		.hwcg = a660_hwcg,
-		.address_space_size = SZ_16G,
-		.speedbins = ADRENO_SPEEDBINS(
-			{ 0,   0 },
-			{ 117, 0 },
-			{ 172, 2 }, /* Called speedbin 1 downstream, but let's not break things! */
-			{ 190, 1 },
-		),
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x06080000),
-		.family = ADRENO_6XX_GEN2,
-		.revn = 680,
-		.fw = {
-			[ADRENO_FW_SQE] = "a630_sqe.fw",
-			[ADRENO_FW_GMU] = "a640_gmu.bin",
-		},
-		.gmem = SZ_2M,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
-		.init = a6xx_gpu_init,
-		.zapfw = "a640_zap.mdt",
-		.hwcg = a640_hwcg,
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x06090000),
-		.family = ADRENO_6XX_GEN4,
-		.fw = {
-			[ADRENO_FW_SQE] = "a660_sqe.fw",
-			[ADRENO_FW_GMU] = "a660_gmu.bin",
-		},
-		.gmem = SZ_4M,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			ADRENO_QUIRK_HAS_HW_APRIV,
-		.init = a6xx_gpu_init,
-		.zapfw = "a690_zap.mdt",
-		.hwcg = a690_hwcg,
-		.address_space_size = SZ_16G,
-	}, {
-		/* sentinal */
-	}
-};
-
-static const struct adreno_info a7xx_gpus[] = {
-	{
-		.chip_ids = ADRENO_CHIP_IDS(0x07030001),
-		.family = ADRENO_7XX_GEN1,
-		.fw = {
-			[ADRENO_FW_SQE] = "a730_sqe.fw",
-			[ADRENO_FW_GMU] = "gmu_gen70000.bin",
-		},
-		.gmem = SZ_2M,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			  ADRENO_QUIRK_HAS_HW_APRIV,
-		.init = a6xx_gpu_init,
-		.zapfw = "a730_zap.mdt",
-		.hwcg = a730_hwcg,
-		.address_space_size = SZ_16G,
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x43050a01), /* "C510v2" */
-		.family = ADRENO_7XX_GEN2,
-		.fw = {
-			[ADRENO_FW_SQE] = "a740_sqe.fw",
-			[ADRENO_FW_GMU] = "gmu_gen70200.bin",
-		},
-		.gmem = 3 * SZ_1M,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			  ADRENO_QUIRK_HAS_HW_APRIV,
-		.init = a6xx_gpu_init,
-		.zapfw = "a740_zap.mdt",
-		.hwcg = a740_hwcg,
-		.address_space_size = SZ_16G,
-	}, {
-		/* sentinal */
-	}
-};
+extern const struct adreno_info a2xx_gpus[];
+extern const struct adreno_info a3xx_gpus[];
+extern const struct adreno_info a4xx_gpus[];
+extern const struct adreno_info a5xx_gpus[];
+extern const struct adreno_info a6xx_gpus[];
+extern const struct adreno_info a7xx_gpus[];
 
 static const struct adreno_info *gpulist[] = {
 	a2xx_gpus,
@@ -566,34 +36,6 @@ static const struct adreno_info *gpulist[] = {
 	a7xx_gpus,
 };
 
-MODULE_FIRMWARE("qcom/a300_pm4.fw");
-MODULE_FIRMWARE("qcom/a300_pfp.fw");
-MODULE_FIRMWARE("qcom/a330_pm4.fw");
-MODULE_FIRMWARE("qcom/a330_pfp.fw");
-MODULE_FIRMWARE("qcom/a420_pm4.fw");
-MODULE_FIRMWARE("qcom/a420_pfp.fw");
-MODULE_FIRMWARE("qcom/a530_pm4.fw");
-MODULE_FIRMWARE("qcom/a530_pfp.fw");
-MODULE_FIRMWARE("qcom/a530v3_gpmu.fw2");
-MODULE_FIRMWARE("qcom/a530_zap.mdt");
-MODULE_FIRMWARE("qcom/a530_zap.b00");
-MODULE_FIRMWARE("qcom/a530_zap.b01");
-MODULE_FIRMWARE("qcom/a530_zap.b02");
-MODULE_FIRMWARE("qcom/a540_gpmu.fw2");
-MODULE_FIRMWARE("qcom/a619_gmu.bin");
-MODULE_FIRMWARE("qcom/a630_sqe.fw");
-MODULE_FIRMWARE("qcom/a630_gmu.bin");
-MODULE_FIRMWARE("qcom/a630_zap.mbn");
-MODULE_FIRMWARE("qcom/a640_gmu.bin");
-MODULE_FIRMWARE("qcom/a650_gmu.bin");
-MODULE_FIRMWARE("qcom/a650_sqe.fw");
-MODULE_FIRMWARE("qcom/a660_gmu.bin");
-MODULE_FIRMWARE("qcom/a660_sqe.fw");
-MODULE_FIRMWARE("qcom/leia_pfp_470.fw");
-MODULE_FIRMWARE("qcom/leia_pm4_470.fw");
-MODULE_FIRMWARE("qcom/yamato_pfp.fw");
-MODULE_FIRMWARE("qcom/yamato_pm4.fw");
-
 static const struct adreno_info *adreno_info(uint32_t chip_id)
 {
 	/* identify gpu: */
-- 
2.42.0

