Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C5A7D95CA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345710AbjJ0K6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjJ0K6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:58:10 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E32196
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:58:07 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40790b0a224so14184375e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698404286; x=1699009086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XkBdStWyOQZPgBS6S/Ka3+9ogTtzOlDV9P3Ay7BAQI=;
        b=DrZB9rR9N44MHZTVCkAT9mN0+vIM9/W7I89j1vwwkU4+ACc4OMvAjWdZssoQEsv/wr
         09BkJk7HAaP56doSuE9L+zmExeeO7f0HdyDZ9y77/J80T57oCQ+qZxbEG9DFplo3LCfX
         PwbveLuOHg75kx6L3DaKHky1MFhk36R7RfDlA9eSBxjLUfRMbS5euLaLXOBdovVCq2Xl
         6CBT2kLyx7d/B9yuO1T9DGYAs4P7nmbACCdBwTsXT343A65zlsRE8QeNMGGimTVKbCEr
         jvhAg7UcKsjRCKs9s7C3Vfc7OfJqcGBbYxwlpGq9NKf06iKlDs1ZLS2flqaTIkfKGTec
         RvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698404286; x=1699009086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9XkBdStWyOQZPgBS6S/Ka3+9ogTtzOlDV9P3Ay7BAQI=;
        b=vy7S5oqKJ1fp1ywCUQ3jv/euiINumZRS4dlKrSJpgbNXWd5mTlt7nVrBT+8kmHN6/Y
         XfXVkBiRD1xJn5DLv2JmxkVZmygFznMM9yBQrAOTrM8ROE7mAIcwOKLsOvFONwiX3yC8
         Bm0XWjdz2fnNLcpZJ1TzzjNr+ot9Gg5NJqCqvE7xegvZ1GwhQBYbWiUzURNOVdtGwFdP
         b2x+/oN8u+M1F50k6EFQ0bZ+9wxFKlNoXenUxA7U2wYYkF5ho9QnBopm8vOTjhEez92g
         dPaMb7oAfQBB2Lgyk/ilOQSYvae3kR/quy0zWAu3CFvhQI9RbKklH3rAStNUa58l0igH
         Jrig==
X-Gm-Message-State: AOJu0Yxev6e6gukA69ovsQmWeIhBOdDZEhrsu9afLi0amZybcxhk/iL7
        Cmvtd3cBLZ6YlA6y8UpFrma0+A==
X-Google-Smtp-Source: AGHT+IE3n/7ZTwMVhcJx5Pj0MGRIdZXTm5/giEYVamfl4WpRmVJi152Yyfa8zz62tvthZTBvwdHjVA==
X-Received: by 2002:a05:600c:3d9a:b0:408:5ba9:d707 with SMTP id bi26-20020a05600c3d9a00b004085ba9d707mr2017805wmb.16.1698404286317;
        Fri, 27 Oct 2023 03:58:06 -0700 (PDT)
Received: from srini-hackbox.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ay32-20020a05600c1e2000b004065daba6casm4819626wmb.46.2023.10.27.03.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 03:58:05 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     johan@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 1/2] ASoC: soc-dai: add flag to mute and unmute stream during trigger
Date:   Fri, 27 Oct 2023 11:57:46 +0100
Message-Id: <20231027105747.32450-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20231027105747.32450-1-srinivas.kandagatla@linaro.org>
References: <20231027105747.32450-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some setups like Speaker amps which are very sensitive, ex: keeping them
unmute without actual data stream for very short duration results in a
static charge and results in pop and clicks. To minimize this, provide a way
to mute and unmute such codecs during trigger callbacks.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/sound/soc-dai.h |  1 +
 sound/soc/soc-dai.c     |  7 +++++++
 sound/soc/soc-pcm.c     | 12 ++++++++----
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index e3906ecda740..5827b4d882fc 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -355,6 +355,7 @@ struct snd_soc_dai_ops {
 
 	/* bit field */
 	unsigned int no_capture_mute:1;
+	unsigned int mute_unmute_on_trigger:1;
 };
 
 struct snd_soc_cdai_ops {
diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
index 02dd64dea179..28d8c6c3d3b2 100644
--- a/sound/soc/soc-dai.c
+++ b/sound/soc/soc-dai.c
@@ -641,6 +641,10 @@ int snd_soc_pcm_dai_trigger(struct snd_pcm_substream *substream,
 			ret = soc_dai_trigger(dai, substream, cmd);
 			if (ret < 0)
 				break;
+
+			if (dai->driver->ops && dai->driver->ops->mute_unmute_on_trigger)
+				snd_soc_dai_digital_mute(dai, 0, substream->stream);
+
 			soc_dai_mark_push(dai, substream, trigger);
 		}
 		break;
@@ -651,6 +655,9 @@ int snd_soc_pcm_dai_trigger(struct snd_pcm_substream *substream,
 			if (rollback && !soc_dai_mark_match(dai, substream, trigger))
 				continue;
 
+			if (dai->driver->ops && dai->driver->ops->mute_unmute_on_trigger)
+				snd_soc_dai_digital_mute(dai, 1, substream->stream);
+
 			r = soc_dai_trigger(dai, substream, cmd);
 			if (r < 0)
 				ret = r; /* use last ret */
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 3aa6b988cb4b..0f9f4da25158 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -703,8 +703,10 @@ static int soc_pcm_clean(struct snd_soc_pcm_runtime *rtd,
 			if (snd_soc_dai_active(dai) == 0)
 				soc_pcm_set_dai_params(dai, NULL);
 
-			if (snd_soc_dai_stream_active(dai, substream->stream) == 0)
-				snd_soc_dai_digital_mute(dai, 1, substream->stream);
+			if (snd_soc_dai_stream_active(dai, substream->stream) ==  0) {
+				if (dai->driver->ops && !dai->driver->ops->mute_unmute_on_trigger)
+					snd_soc_dai_digital_mute(dai, 1, substream->stream);
+			}
 		}
 	}
 
@@ -898,8 +900,10 @@ static int __soc_pcm_prepare(struct snd_soc_pcm_runtime *rtd,
 	snd_soc_dapm_stream_event(rtd, substream->stream,
 			SND_SOC_DAPM_STREAM_START);
 
-	for_each_rtd_dais(rtd, i, dai)
-		snd_soc_dai_digital_mute(dai, 0, substream->stream);
+	for_each_rtd_dais(rtd, i, dai) {
+		if (dai->driver->ops && !dai->driver->ops->mute_unmute_on_trigger)
+			snd_soc_dai_digital_mute(dai, 0, substream->stream);
+	}
 
 out:
 	return soc_pcm_ret(rtd, ret);
-- 
2.21.0

