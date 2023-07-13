Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01376751DDC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbjGMJyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbjGMJxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:53:24 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78422689
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:53:19 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3142a9ffa89so676551f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1689241998; x=1691833998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LPqBHwbjNM+xoM+NHlMenvzhZG8Km0jadyqZX+XYIaI=;
        b=xyHCc+a/9Ay9QUMg/ti18Teyz1YDlkma1brdD/5tCneK+zBr7RWvV9iYJvA3kIo729
         cRFl0g3AxqJFmVR6gFcMTIoyPWN46XGmSyJ2loXuywmlQHQOm8yQoS5ivn1XDEWVpxwq
         nYsBPgLRiSaA1sapaVk9T5BQDmKkAtiuEmVrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689241998; x=1691833998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPqBHwbjNM+xoM+NHlMenvzhZG8Km0jadyqZX+XYIaI=;
        b=RvsrnupuDn55dpb8IGo4E7q1aIn+3WO5o3EvFmvlG4DfNYUNoePTmrFwunAPlwGv9Q
         brP9QPnC74+RLh7tdzT5vwBWr7B2deNjpQlwO9WouVPHT3IWqqD3KDzgdpFG3cqzqJPq
         evNCWfr9hSCuPA6zC8vpNu22ghModa77qvnn0FymNoc7uG+3UL9V0ty0w/nxV5yG+7FN
         V361lypzTsUXlCR5LM/9e2MblH5cvfJpDcTmDOgQbrAPKy684ILFadtTSH1SMmg4mEXY
         BFBbyOZignjoEMCBbFC4OySAMuZpe+wK/+sEo1HwMHjNxJ+mh2p3qVN7+NV1g+pWIq3i
         /c2A==
X-Gm-Message-State: ABy/qLbTH7mmeU/WVkYmGhH9jKAo9tc6dryR57/ld1kzrtFRgngVQEpH
        kyW7j/aejWKLZPisCeleaV5+qpOzHCGqBpWz9iI=
X-Google-Smtp-Source: APBJJlHDC754TqcSXUGOL4NL4luC6Yj1LmPPfypP9S0FYc6rjykqiOqSBSAptcJzNQ9PfyZ31y8Yew==
X-Received: by 2002:adf:cd87:0:b0:313:fa0f:3a05 with SMTP id q7-20020adfcd87000000b00313fa0f3a05mr1081570wrj.14.1689241998235;
        Thu, 13 Jul 2023 02:53:18 -0700 (PDT)
Received: from localhost.localdomain (vpn.streamunlimited.com. [91.114.0.140])
        by smtp.gmail.com with ESMTPSA id t12-20020a5d6a4c000000b00314329f7d8asm7439711wrw.29.2023.07.13.02.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 02:53:17 -0700 (PDT)
From:   Peter Suti <peter.suti@streamunlimited.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     pierre-louis.bossart@linux.intel.com,
        Peter Suti <peter.suti@streamunlimited.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] ASoC: soc-dai: don't call PCM audio ops if the stream is not supported
Date:   Thu, 13 Jul 2023 11:52:58 +0200
Message-Id: <20230713095258.3393827-1-peter.suti@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCM audio ops may be called when the stream is not supported.
We should not call the ops in that case to avoid unexpected behavior.

hw_params is handled already in soc-pcm.c

[0] https://lore.kernel.org/alsa-devel/ae06b00a-f3f7-f9d1-0b58-4d71f3394416@linux.intel.com/T/#t

Signed-off-by: Peter Suti <peter.suti@streamunlimited.com>
---
Tested on 6.1 Compile tested on next/master
 sound/soc/soc-dai.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
index 02dd64dea179..73a97ac6ccb8 100644
--- a/sound/soc/soc-dai.c
+++ b/sound/soc/soc-dai.c
@@ -424,6 +424,9 @@ int snd_soc_dai_startup(struct snd_soc_dai *dai,
 {
 	int ret = 0;
 
+	if (!snd_soc_dai_stream_valid(dai, substream->stream))
+		return 0;
+
 	if (dai->driver->ops &&
 	    dai->driver->ops->startup)
 		ret = dai->driver->ops->startup(substream, dai);
@@ -439,6 +442,9 @@ void snd_soc_dai_shutdown(struct snd_soc_dai *dai,
 			  struct snd_pcm_substream *substream,
 			  int rollback)
 {
+	if (!snd_soc_dai_stream_valid(dai, substream->stream))
+		return;
+
 	if (rollback && !soc_dai_mark_match(dai, substream, startup))
 		return;
 
@@ -603,6 +609,8 @@ int snd_soc_pcm_dai_prepare(struct snd_pcm_substream *substream)
 	int i, ret;
 
 	for_each_rtd_dais(rtd, i, dai) {
+		if (!snd_soc_dai_stream_valid(dai, substream->stream))
+			continue;
 		if (dai->driver->ops &&
 		    dai->driver->ops->prepare) {
 			ret = dai->driver->ops->prepare(substream, dai);
@@ -619,6 +627,9 @@ static int soc_dai_trigger(struct snd_soc_dai *dai,
 {
 	int ret = 0;
 
+	if (!snd_soc_dai_stream_valid(dai, substream->stream))
+		return 0;
+
 	if (dai->driver->ops &&
 	    dai->driver->ops->trigger)
 		ret = dai->driver->ops->trigger(substream, cmd, dai);
-- 
2.34.1

