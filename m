Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66DA7B8548
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243356AbjJDQao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243357AbjJDQam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:30:42 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348B6AB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:30:38 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-991c786369cso3384466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 09:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696437036; x=1697041836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwQca6O5TUZpsEPN/2hcx/QMSO8jnzGhlyFu3rhBscM=;
        b=nyiYMenyKC9/MiIt3VcIrQ0AhgDT7q8YGtzB/EhZH7ptycCOtDp9ufFX47amV3rIqf
         1Vbd/LB1jk6YoMISLeKzV3f07NP57ca/6dwZWQ+CMmo/lciV4UPXPYbcOTF0hXflLMVH
         FWQ3shRImndUHcVpHVyfaPI91OrkY8Q9ToZX8q4vJURg2jFQcx2gI0xaj3gwrqwdknpf
         wnB8Al8qZCVuBXFGzwo/A/AOiKO4RCkE0MbERaostollWzgX4nekXE0tOtskqOy5yLD1
         1XdEfvjN/bl7PMeHrbVTtBiTkcn7LTsJwArR3wi9++0cUHYnbW/dtRlu/dqPQArBTs9f
         9V0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696437036; x=1697041836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZwQca6O5TUZpsEPN/2hcx/QMSO8jnzGhlyFu3rhBscM=;
        b=cFoFEPDA9JwlAfj4lRLwTVTQJzHIZ1Xbnr1HHNz2jVug2725qnER/UahP/J4SBtyhB
         7aczmsDebR/ub3QD/kv6J3WMDFxbOoE1LjmS6o6UqkvfOKuBPk+Imkl2Z0/PHZGtjT0G
         uTrx18eFJQZ2f+MSw6W02CDdiAGkVypt07+VNir97bM+z7Ql1Ys20R2CFlCzbl8dCMqf
         QDehk0sy+P09f/VTjmkFby/qGV++1lBBTE2LWeXjrnugBFdHoXDB/2XTkn9fiyy/u8+l
         whaYFc4b45AhUsZ+WPpXPdMnuPrgOKbZKK1vM4XiG1DW45/HPHFtjal0Y8UaqG+ljIpi
         wtOw==
X-Gm-Message-State: AOJu0Yxs3y19s+9evnrOqV9iCNPbUjlFlye8WUnE3SS5owRxXNlbKKyA
        oOnp4+MxGDTyGyFDVX65fkI2yQ==
X-Google-Smtp-Source: AGHT+IE9v5jPqyhMR480KMRuqa9F6S2fCZypeRwKq7VdOsoAo3KvQZ/dHSb2DgA0cn6DDsC/0JnosQ==
X-Received: by 2002:a17:906:209:b0:9a9:e5bb:eddc with SMTP id 9-20020a170906020900b009a9e5bbeddcmr2636791ejd.16.1696437036512;
        Wed, 04 Oct 2023 09:30:36 -0700 (PDT)
Received: from krzk-bin.. (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id kt12-20020a170906aacc00b009a1b857e3a5sm3041038ejb.54.2023.10.04.09.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 09:30:36 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: qcom: reduce number of binding headers includes
Date:   Wed,  4 Oct 2023 18:30:30 +0200
Message-Id: <20231004163030.670039-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the includes of binding headers from Qualcomm SoC sound drivers
headers to unit files actually using these bindings.  This reduces the
amount of work for C preprocessor and makes usage of bindings easier to
follow.  No impact expected on final binaries.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/qcom/apq8016_sbc.c            | 1 +
 sound/soc/qcom/common.c                 | 2 +-
 sound/soc/qcom/lpass-cdc-dma.c          | 1 +
 sound/soc/qcom/lpass-cpu.c              | 1 +
 sound/soc/qcom/lpass-platform.c         | 1 +
 sound/soc/qcom/lpass.h                  | 1 -
 sound/soc/qcom/qdsp6/q6afe-clocks.c     | 1 +
 sound/soc/qcom/qdsp6/q6afe-dai.c        | 1 +
 sound/soc/qcom/qdsp6/q6afe.c            | 1 +
 sound/soc/qcom/qdsp6/q6afe.h            | 2 --
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c | 1 +
 sound/soc/qcom/qdsp6/q6apm.h            | 1 -
 sound/soc/qcom/qdsp6/q6asm-dai.c        | 1 +
 sound/soc/qcom/qdsp6/q6asm.c            | 1 +
 sound/soc/qcom/qdsp6/q6asm.h            | 1 -
 sound/soc/qcom/qdsp6/q6prm-clocks.c     | 2 +-
 sound/soc/qcom/qdsp6/q6routing.c        | 2 ++
 sound/soc/qcom/sc7180.c                 | 2 +-
 sound/soc/qcom/sc7280.c                 | 2 ++
 sound/soc/qcom/sc8280xp.c               | 1 +
 sound/soc/qcom/sdm845.c                 | 1 +
 sound/soc/qcom/sdw.c                    | 2 +-
 sound/soc/qcom/sm8250.c                 | 1 +
 23 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
index ff9f6a1c95df..efbdbb4dd753 100644
--- a/sound/soc/qcom/apq8016_sbc.c
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -16,6 +16,7 @@
 #include <sound/soc.h>
 #include <uapi/linux/input-event-codes.h>
 #include <dt-bindings/sound/apq8016-lpass.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
 #include "common.h"
 #include "qdsp6/q6afe.h"
 
diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index f2d1e3009cd2..483bbf53a541 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -2,10 +2,10 @@
 // Copyright (c) 2018, Linaro Limited.
 // Copyright (c) 2018, The Linux Foundation. All rights reserved.
 
+#include <dt-bindings/sound/qcom,q6afe.h>
 #include <linux/module.h>
 #include <sound/jack.h>
 #include <linux/input-event-codes.h>
-#include "qdsp6/q6afe.h"
 #include "common.h"
 
 static const struct snd_soc_dapm_widget qcom_jack_snd_widgets[] = {
diff --git a/sound/soc/qcom/lpass-cdc-dma.c b/sound/soc/qcom/lpass-cdc-dma.c
index 8221e2cbe35c..586f23049447 100644
--- a/sound/soc/qcom/lpass-cdc-dma.c
+++ b/sound/soc/qcom/lpass-cdc-dma.c
@@ -5,6 +5,7 @@
  * lpass-cdc-dma.c -- ALSA SoC CDC DMA CPU DAI driver for QTi LPASS
  */
 
+#include <dt-bindings/sound/qcom,lpass.h>
 #include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/export.h>
diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 39571fed4001..d15039bb7f82 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -5,6 +5,7 @@
  * lpass-cpu.c -- ALSA SoC CPU DAI driver for QTi LPASS
  */
 
+#include <dt-bindings/sound/qcom,lpass.h>
 #include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index 73e3d39bd24c..5b99b41956ed 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -5,6 +5,7 @@
  * lpass-platform.c -- ALSA SoC platform driver for QTi LPASS
  */
 
+#include <dt-bindings/sound/qcom,lpass.h>
 #include <linux/dma-mapping.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index bdfe66ec3314..dd5e2ccad5d8 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -12,7 +12,6 @@
 #include <linux/compiler.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
-#include <dt-bindings/sound/qcom,lpass.h>
 #include "lpass-hdmi.h"
 
 #define LPASS_AHBIX_CLOCK_FREQUENCY		131072000
diff --git a/sound/soc/qcom/qdsp6/q6afe-clocks.c b/sound/soc/qcom/qdsp6/q6afe-clocks.c
index 1ccab64ff00b..84b9018c36ba 100644
--- a/sound/soc/qcom/qdsp6/q6afe-clocks.c
+++ b/sound/soc/qcom/qdsp6/q6afe-clocks.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2020, Linaro Limited
 
+#include <dt-bindings/sound/qcom,q6afe.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/clk-provider.h>
diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 3faa7e0eb0dd..a9c4f896a7df 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2011-2017, The Linux Foundation. All rights reserved.
 // Copyright (c) 2018, Linaro Limited
 
+#include <dt-bindings/sound/qcom,q6afe.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/module.h>
diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 919e326b9462..91d39f6ad0bd 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2011-2017, The Linux Foundation. All rights reserved.
 // Copyright (c) 2018, Linaro Limited
 
+#include <dt-bindings/sound/qcom,q6afe.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/uaccess.h>
diff --git a/sound/soc/qcom/qdsp6/q6afe.h b/sound/soc/qcom/qdsp6/q6afe.h
index 30fd77e2f458..65d0676075e1 100644
--- a/sound/soc/qcom/qdsp6/q6afe.h
+++ b/sound/soc/qcom/qdsp6/q6afe.h
@@ -3,8 +3,6 @@
 #ifndef __Q6AFE_H__
 #define __Q6AFE_H__
 
-#include <dt-bindings/sound/qcom,q6afe.h>
-
 #define AFE_PORT_MAX		129
 
 #define MSM_AFE_PORT_TYPE_RX 0
diff --git a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
index 7ad604b80e25..a3864eea02d5 100644
--- a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
+++ b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2021, Linaro Limited
 
+#include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/module.h>
diff --git a/sound/soc/qcom/qdsp6/q6apm.h b/sound/soc/qcom/qdsp6/q6apm.h
index f486bd639b9f..c248c8d2b1ab 100644
--- a/sound/soc/qcom/qdsp6/q6apm.h
+++ b/sound/soc/qcom/qdsp6/q6apm.h
@@ -13,7 +13,6 @@
 #include <linux/of_platform.h>
 #include <linux/jiffies.h>
 #include <linux/soc/qcom/apr.h>
-#include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
 #include "audioreach.h"
 
 #define APM_PORT_MAX		127
diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 5e14cd0a38de..a7e37c6e4e92 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2011-2017, The Linux Foundation. All rights reserved.
 // Copyright (c) 2018, Linaro Limited
 
+#include <dt-bindings/sound/qcom,q6asm.h>
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/module.h>
diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 195780f75d05..06a802f9dba5 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2011-2017, The Linux Foundation. All rights reserved.
 // Copyright (c) 2018, Linaro Limited
 
+#include <dt-bindings/sound/qcom,q6asm.h>
 #include <linux/mutex.h>
 #include <linux/wait.h>
 #include <linux/module.h>
diff --git a/sound/soc/qcom/qdsp6/q6asm.h b/sound/soc/qcom/qdsp6/q6asm.h
index 394604c34943..0103d8dae5da 100644
--- a/sound/soc/qcom/qdsp6/q6asm.h
+++ b/sound/soc/qcom/qdsp6/q6asm.h
@@ -2,7 +2,6 @@
 #ifndef __Q6_ASM_H__
 #define __Q6_ASM_H__
 #include "q6dsp-common.h"
-#include <dt-bindings/sound/qcom,q6asm.h>
 
 /* ASM client callback events */
 #define CMD_PAUSE			0x0001
diff --git a/sound/soc/qcom/qdsp6/q6prm-clocks.c b/sound/soc/qcom/qdsp6/q6prm-clocks.c
index 73b0cbac73d4..4c574b48ab00 100644
--- a/sound/soc/qcom/qdsp6/q6prm-clocks.c
+++ b/sound/soc/qcom/qdsp6/q6prm-clocks.c
@@ -1,13 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2021, Linaro Limited
 
+#include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/clk-provider.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
-#include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
 #include "q6dsp-lpass-clocks.h"
 #include "q6prm.h"
 
diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index c583faae3a3e..c0856c10d0a8 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -2,6 +2,8 @@
 // Copyright (c) 2011-2017, The Linux Foundation. All rights reserved.
 // Copyright (c) 2018, Linaro Limited
 
+#include <dt-bindings/sound/qcom,q6asm.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/module.h>
diff --git a/sound/soc/qcom/sc7180.c b/sound/soc/qcom/sc7180.c
index d1fd40e3f7a9..b2211212c53c 100644
--- a/sound/soc/qcom/sc7180.c
+++ b/sound/soc/qcom/sc7180.c
@@ -4,6 +4,7 @@
 //
 // sc7180.c -- ALSA SoC Machine driver for SC7180
 
+#include <dt-bindings/sound/qcom,lpass.h>
 #include <dt-bindings/sound/sc7180-lpass.h>
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
@@ -19,7 +20,6 @@
 #include "../codecs/rt5682.h"
 #include "../codecs/rt5682s.h"
 #include "common.h"
-#include "lpass.h"
 
 #define DEFAULT_MCLK_RATE		19200000
 #define RT5682_PLL1_FREQ (48000 * 512)
diff --git a/sound/soc/qcom/sc7280.c b/sound/soc/qcom/sc7280.c
index c23df4c8f341..f61989d6b57d 100644
--- a/sound/soc/qcom/sc7280.c
+++ b/sound/soc/qcom/sc7280.c
@@ -4,6 +4,8 @@
 //
 // ALSA SoC Machine driver for sc7280
 
+#include <dt-bindings/sound/qcom,lpass.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
index cfb9c8dbd599..6d4a43f94d51 100644
--- a/sound/soc/qcom/sc8280xp.c
+++ b/sound/soc/qcom/sc8280xp.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2022, Linaro Limited
 
+#include <dt-bindings/sound/qcom,q6afe.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of_device.h>
diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 25b964dea6c5..fed5673b61ba 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2018, The Linux Foundation. All rights reserved.
  */
 
+#include <dt-bindings/sound/qcom,q6afe.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of_device.h>
diff --git a/sound/soc/qcom/sdw.c b/sound/soc/qcom/sdw.c
index ce89c0a33ef0..dd275123d31d 100644
--- a/sound/soc/qcom/sdw.c
+++ b/sound/soc/qcom/sdw.c
@@ -2,9 +2,9 @@
 // Copyright (c) 2018, Linaro Limited.
 // Copyright (c) 2018, The Linux Foundation. All rights reserved.
 
+#include <dt-bindings/sound/qcom,q6afe.h>
 #include <linux/module.h>
 #include <sound/soc.h>
-#include "qdsp6/q6afe.h"
 #include "sdw.h"
 
 int qcom_snd_sdw_prepare(struct snd_pcm_substream *substream,
diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
index 6558bf2e14e8..b7e1a5496cfd 100644
--- a/sound/soc/qcom/sm8250.c
+++ b/sound/soc/qcom/sm8250.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2020, Linaro Limited
 
+#include <dt-bindings/sound/qcom,q6afe.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of_device.h>
-- 
2.34.1

