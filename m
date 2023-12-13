Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCE2811130
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjLMMgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbjLMMgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:36:31 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A18E4;
        Wed, 13 Dec 2023 04:36:36 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6ce26a03d9eso4326198b3a.0;
        Wed, 13 Dec 2023 04:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702470996; x=1703075796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6o9+b/zVNvA4/sI4WpDCuE/Pf6Swn7qoeIeF6jMIaTc=;
        b=UC5Fa1JZNxtJ5dxppPYVEvY+na6kHQuy6yE56hh2nlcCq5ZmjPYz3Ea+90G6+L7Azr
         JDjXS0uGvmpqHQ97gnyz2q0UL/Wh5hD6Ast0suEmWBfXMeoZm+eulbmluf1PZb8jImTs
         Mje3TH9VJUeeZdpXRhBJrXFkrCCWaa0vo4n/NryR+oq+q7ZyLvpzGLw6pVoL4Dgi8zML
         Xvy1sZEb7ibBqv6t7kbV4kaIsdsdfYi+15mSDYAJlMNY/ajbRhJLL1MlovCxxVm+ImHd
         aV3TovjOHy00k67Y5sFrlP8s4LSom1KQxrbXhcJvMtSdBbRkkcp1LoTyuORE6hbhIxNS
         sKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702470996; x=1703075796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6o9+b/zVNvA4/sI4WpDCuE/Pf6Swn7qoeIeF6jMIaTc=;
        b=C/zV1HLynB30mvKlpyw80I19q6JamLnyFJrnMwIdBYKMbHegre96nYjV4B4r8m07VC
         a+x2K6cv+m4fRti8A4mqG61mQ39vuiHsxyIRWqc1wf5sAuDno0ImBEBh6amcT+v7eRaC
         ElkdNDXvK7ULKVXLoUdxbUdWGdsNU3D4NmrKeC9wEROhqkj5dj9kXHrGLRIV0oY+z9Q/
         ol2kL/9EtqjelobAnmp7T6o6Qmhew9/kO9osFUw7XYDeUKm8yHmw3Y0bEzpwQ3v4DHpz
         q3jIpiRRk6UA42Ps/3A4eUHoc2fW8odxwIrKUgEvmTmZ+BL9jFBa+5+q/TDG3HXUIxIS
         21kg==
X-Gm-Message-State: AOJu0Yw0Reo5+ewOdg8eepp+VblUgQhqxNnpdtqutcxtvtBoQpb+ube3
        9UR2RdGzCcqGPrmYS9hPz/s2HPQn6HATgVF1
X-Google-Smtp-Source: AGHT+IGoI9nmTylJCkQMFXcqOVFTf2O9jztpOZQGEDTcSur6zbqLpwGGseS6UD76b141XTMjdovkrQ==
X-Received: by 2002:a05:6a00:3305:b0:6ce:6007:9bb with SMTP id cq5-20020a056a00330500b006ce600709bbmr4308409pfb.60.1702470996273;
        Wed, 13 Dec 2023 04:36:36 -0800 (PST)
Received: from localhost.localdomain ([117.189.237.103])
        by smtp.gmail.com with ESMTPSA id x3-20020a056a00188300b0068fe5a5a566sm10193584pfh.142.2023.12.13.04.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 04:36:35 -0800 (PST)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH v3 3/4] Asoc: qcom: sdw: Add TDM support
Date:   Wed, 13 Dec 2023 20:35:55 +0800
Message-ID: <20231213123556.20469-3-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231213123556.20469-1-lujianhua000@gmail.com>
References: <20231213123556.20469-1-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setup TDM ports when dai id is matched to *_TDM_*.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
Changes in v3:
  1. split qcom_snd_tdm_hw_params function to common.c

Changes in v2:
  1. remove EXPORT_SYMBOL_GPL
  2. remove static modifier

 sound/soc/qcom/sdw.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/sdw.c b/sound/soc/qcom/sdw.c
index 77dbe0c28b29..c07d878a1c18 100644
--- a/sound/soc/qcom/sdw.c
+++ b/sound/soc/qcom/sdw.c
@@ -5,6 +5,7 @@
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <linux/module.h>
 #include <sound/soc.h>
+#include "common.h"
 #include "sdw.h"
 
 /**
@@ -109,7 +110,7 @@ int qcom_snd_sdw_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *codec_dai;
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct sdw_stream_runtime *sruntime;
-	int i;
+	int ret, i;
 
 	switch (cpu_dai->id) {
 	case WSA_CODEC_DMA_RX_0:
@@ -125,6 +126,14 @@ int qcom_snd_sdw_hw_params(struct snd_pcm_substream *substream,
 				*psruntime = sruntime;
 		}
 		break;
+	case PRIMARY_TDM_RX_0...QUINARY_TDM_TX_7:
+		ret = qcom_snd_tdm_hw_params(substream, params);
+		if (ret < 0) {
+			dev_err(rtd->dev, "%s: failed to setup TDM err:%d\n",
+				__func__, ret);
+			return ret;
+		}
+		break;
 	}
 
 	return 0;
-- 
2.41.0

