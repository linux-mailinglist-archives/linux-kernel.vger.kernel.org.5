Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DDD7B9ECE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjJEONU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbjJEOLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:11:20 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A682B83C1
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 00:52:56 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso122183766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 00:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696492375; x=1697097175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cm78yTq+4+JEr7sdqQ4kBse0aE3dfNiiuqyM5NvDPh0=;
        b=AzWvNJDgLQ5crQoTvZzI1hqjVdyu4XF2xVBYkIdboX126zkXozH/Z3Z2qQmi1BIn6p
         gBva8FH+P4P4bd+/xnnXcBfSfpLoWYqsPN/yjdiaW1ONMdKRViJyq7YsdT6n/IZSREIW
         +Kgm08VLOERoiE6g62VY6xUK2dCQl0QoJlrcWOlX6PglArE6+Z+Oh9FI7yJcL1MT0CCO
         fEca8Na5U7jUB9bDEQ7XRblUL9lGgFaRWD1JYbl6dPW/PMEiezWFQ9M1xIs/V0/rJA+e
         tzPs9Rm98bSJkUBOh0DoKQ6gdgcL8m5jaARnlF3ecDCC81YuGd/RSUzFKzHNnlxlbLuD
         ptEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696492375; x=1697097175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cm78yTq+4+JEr7sdqQ4kBse0aE3dfNiiuqyM5NvDPh0=;
        b=lcvFFqkDICB6hkG4dTimkZ+Me+rik0lBCur3FSuRBCy8nSXmeO4azvlo5GmoD2i80k
         YCCqByzIOV1N7bUAyx5ZOCraKRnujxCzRIhPWknyrwbiSq6KtWx6bV9tuYHjyEnSWK3o
         SNDbjCLo10/RqXBIZPPwkFk5MLJCmEXl1W49zU2W7D6oBtFpCn5tIPMl0xFJV5cK/d+g
         U/+kwK1pd1tRe+X4XTWfCJ6/A+M3URv3Hzv3RRVtY2ptGRnVs5kI95fAM2I4lHrhNekG
         DWSILwMbVBVaC3suNXjdTcIhf/aKc2k+CLbzaaxPKASRYN0+zxAQ55Mhbu8v9PzXf7MC
         tvWw==
X-Gm-Message-State: AOJu0Yw9Bhez/IJDj/YkBMSUsePxuBKg2hTcJWSApD2QGaxNnKl9LuGh
        K1yGNPXSQKxjLm97TzNS3UPi3A==
X-Google-Smtp-Source: AGHT+IETcShgHGDNS6NDLn57L1RzUtV/ujBOSvyYMycJxCUU38u8IVpPaaq69/B9/xqxmSgkLr0pcw==
X-Received: by 2002:a17:906:3197:b0:9af:4561:591d with SMTP id 23-20020a170906319700b009af4561591dmr4064788ejy.18.1696492375032;
        Thu, 05 Oct 2023 00:52:55 -0700 (PDT)
Received: from krzk-bin.. (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id l12-20020a170906078c00b009b94fe3fc47sm722051ejc.159.2023.10.05.00.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 00:52:54 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/2] ASoC: qcom: reduce number of binding headers includes
Date:   Thu,  5 Oct 2023 09:52:50 +0200
Message-Id: <20231005075250.88159-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005075250.88159-1-krzysztof.kozlowski@linaro.org>
References: <20231005075250.88159-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
follow.  No impact expected on the final binaries.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Do not remove include of dt-bindings/sound/qcom,lpass.h from the
   sound/soc/qcom/lpass.h, because it is actually used there. This fixes
   kernel test robot report.
---
 sound/soc/qcom/apq8016_sbc.c            | 1 +
 sound/soc/qcom/common.c                 | 2 +-
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
 sound/soc/qcom/sc7180.c                 | 1 -
 sound/soc/qcom/sc7280.c                 | 1 +
 sound/soc/qcom/sc8280xp.c               | 1 +
 sound/soc/qcom/sdm845.c                 | 1 +
 sound/soc/qcom/sdw.c                    | 2 +-
 sound/soc/qcom/sm8250.c                 | 1 +
 19 files changed, 16 insertions(+), 8 deletions(-)

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
index d1fd40e3f7a9..21becfd5aff4 100644
--- a/sound/soc/qcom/sc7180.c
+++ b/sound/soc/qcom/sc7180.c
@@ -19,7 +19,6 @@
 #include "../codecs/rt5682.h"
 #include "../codecs/rt5682s.h"
 #include "common.h"
-#include "lpass.h"
 
 #define DEFAULT_MCLK_RATE		19200000
 #define RT5682_PLL1_FREQ (48000 * 512)
diff --git a/sound/soc/qcom/sc7280.c b/sound/soc/qcom/sc7280.c
index 095756883050..f61989d6b57d 100644
--- a/sound/soc/qcom/sc7280.c
+++ b/sound/soc/qcom/sc7280.c
@@ -5,6 +5,7 @@
 // ALSA SoC Machine driver for sc7280
 
 #include <dt-bindings/sound/qcom,lpass.h>
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

