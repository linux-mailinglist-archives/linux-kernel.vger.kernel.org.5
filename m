Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832B57CFD1C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbjJSOmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbjJSOl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:41:26 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E905198
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:41:16 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40790b0a224so25585415e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697726474; x=1698331274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3cUBjMkJC/g12UTXIKA666/KHuBThA0FV+7EScypba4=;
        b=mQNFyaM1U7vRrHT8xiLvJsxTDeMiHzI+yUtx/9Jx1o/a1kYZH6csHUsrdeKSknJJA+
         mw3aS1Fg2cqFsGk2lVcsfKQLBb526ytKQktcRY0UXzS8gMFCEpTkACtxpo+MLON6IYWg
         C5aNafeHkyv/K75TGarcCkPYHkkomXhSD0hbKokYW0F78tSsc/6BKLKezAWoCYLXL21q
         epYrwVcjBb38Ipq7vjr978N+taSjFLwWEkTo+Oa3qmussmuyCif9skn0L6UmxrPwmOIV
         kO5BRMCybIYUgShMDV2Ax6ioeUhM+Vy0vrPfc4sOnQ1osvy277gyrVfkTqIN/bkSzqoj
         3QZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697726474; x=1698331274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3cUBjMkJC/g12UTXIKA666/KHuBThA0FV+7EScypba4=;
        b=FqID7/8XtucDZsGBPImR83UMQjOvf9eHpTwSyGkPEwVi96Vsywndoa8Xd/uswuo1/I
         v/lC3Yc8sHHg4jMF/qKM7CbSk6pKlc89md5jh7FhVS/zS+80BlY99ekXL8nVN6yUYaJd
         brrRRWn0mjMczw6duSUk2ND8YFQ9GBF1BtMAThQzbTYMl+agDolYqWPnVSyL+peo8y9l
         wxWrDpX7UoFwNRl32yFt2Hgs+mcf/NTbd99c8MuNnagcmwlTLm6PWc0m2REoS1Pe3SWB
         GjhXZANSPGLy+8yWjQgCSZmin6Jp4mDO+PkHM2aoptduqK7D11fq3ZeaYK1Q0DWkHonk
         M9+Q==
X-Gm-Message-State: AOJu0YxS2LG6m0l6Bt/2j06ZCvfVhXh1idQQWaxHrKv4AdwQywlZPnGo
        fj20x3d+3am2TNzSEeU/yVeNuA==
X-Google-Smtp-Source: AGHT+IEmDfsHc85L7p82ZauQvTVy06/R+u2RKdNGWHhKdMANg2TYxpvYzKkGaL8SdFUWt65CCdtlug==
X-Received: by 2002:adf:e605:0:b0:32d:8401:404a with SMTP id p5-20020adfe605000000b0032d8401404amr1925406wrm.10.1697726474187;
        Thu, 19 Oct 2023 07:41:14 -0700 (PDT)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600c4e0e00b0040607da271asm4595657wmq.31.2023.10.19.07.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 07:41:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: codecs: wcd938x: use defines for entries in snd_soc_dai_driver array
Date:   Thu, 19 Oct 2023 16:41:08 +0200
Message-Id: <20231019144108.42853-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

snd_soc_dai_driver array in wcd938x driver has two entries whose order
must match order of wcd938x->sdw_priv array.  The wcd938x_bind() and
wcd938x_codec_set_sdw_stream() rely on this order.  wcd938x->sdw_priv
array is indexed by enum with AIF1_PB and AIF1_CAP, so use the same
defines instead of raw numners for snd_soc_dai_driver array.
No functional impact.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd938x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index a3c680661377..a162bd46ba3e 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3392,7 +3392,7 @@ static const struct snd_soc_dai_ops wcd938x_sdw_dai_ops = {
 };
 
 static struct snd_soc_dai_driver wcd938x_dais[] = {
-	[0] = {
+	[AIF1_PB] = {
 		.name = "wcd938x-sdw-rx",
 		.playback = {
 			.stream_name = "WCD AIF1 Playback",
@@ -3405,7 +3405,7 @@ static struct snd_soc_dai_driver wcd938x_dais[] = {
 		},
 		.ops = &wcd938x_sdw_dai_ops,
 	},
-	[1] = {
+	[AIF1_CAP] = {
 		.name = "wcd938x-sdw-tx",
 		.capture = {
 			.stream_name = "WCD AIF1 Capture",
-- 
2.34.1

