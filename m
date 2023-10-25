Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1A27D6FEA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbjJYOqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344178AbjJYOq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:46:26 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697541B8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:46:11 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5079f9675c6so9043637e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698245170; x=1698849970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXAGRRDQU3qBmM4PuKRmO3omKxsrPu1G2pV7PjgXi9w=;
        b=PMHCUUkvrSK1fb6li3YzbfhtQFF+2mSVW9sqvnHEJ2NsjD/4R5TY2D3PVukGooQgY4
         8J/KsbHB5enFa2DAYE7098OvQk1e6rPQYcBZjWd+fx1eOd3+V3+8fXV8QxzuXZX24jU0
         bqiCr3YCTIGmyZMqTZCgwkUoHWrkyoTa3qCWMuWh7aN9s1IqDkwBsyM7eLuUzcOx5pxx
         gjfZHzZEW3fE4mhhwXkKbu7nAAAF8jRlYjbDeuwpp9DiZTqt0Rk8hzLadAVJ3NaA3ZJ0
         zxY9YHeNZIhJz85YnpRTv47KrZisUFzLSsSLb5QCei4DuKeEZ7LhR6EGaGQ5d0v0Mzld
         dmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698245170; x=1698849970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXAGRRDQU3qBmM4PuKRmO3omKxsrPu1G2pV7PjgXi9w=;
        b=cYpoVAZL4JCrDWbV0hGVjjPWbhPsLY/OoWSoKyAph3LMplQcNvXkrDhVGGj1XP7CzY
         t+1/OZ5ODsAi1dxKQMdzyitEWiMFQ+715KQGWaL/eYVfhvW6L6w7eruT9Ku79aIDbR6D
         0feo59Xv/ZmlKbe1Ig1Qf2i9T8yY7t/D/XsHAp1h+We5O39y5oAAPH8dPUXMRD/C9qHb
         2XpVoRhQfyTypeBCnEO5IZ3Msm49lX3qbeo5Hd2ePwjivicS1LcFCsSVUg8g9ebMAI1I
         UTIDDNpjtj7syt9f1B1aF88RnL0CtE7/rVjAz8KpOgcNZbMzgy76iw6+B7ZuVn6iJoUc
         eXLQ==
X-Gm-Message-State: AOJu0Yy+wslxkjSudONAP4HYPV0IvUKmsHFp0Ysvh/aWXOyjK+woH85l
        eckR/LHlp9DDtUaeC0976gGp/Q==
X-Google-Smtp-Source: AGHT+IEm+oG84DNxepaw/B3zgRVBOqJdqjjLvSed6FNsaPOPc1JSYQPpe7VYHi0f4Xg01yt26Oo5fg==
X-Received: by 2002:ac2:597a:0:b0:507:9623:8ae8 with SMTP id h26-20020ac2597a000000b0050796238ae8mr11125024lfp.29.1698245169886;
        Wed, 25 Oct 2023 07:46:09 -0700 (PDT)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id i1-20020a05600011c100b0032dcb08bf94sm12267138wrx.60.2023.10.25.07.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 07:46:09 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] soundwire: qcom: set owner device of runtime stream
Date:   Wed, 25 Oct 2023 16:46:00 +0200
Message-Id: <20231025144601.268645-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025144601.268645-1-krzysztof.kozlowski@linaro.org>
References: <20231025144601.268645-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Store the pointer to struct device of Soundwire controller owning this
runtime stream.  This can be later used by Soundwire devices, to check
if their DAI prepare callback is called for the same bus, in cases where
multiple Soundwire buses are used in same soundcard codec list.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soundwire/qcom.c      | 1 +
 include/linux/soundwire/sdw.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index fe65c26c5281..a95f39563b47 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -1298,6 +1298,7 @@ static int qcom_swrm_startup(struct snd_pcm_substream *substream,
 		goto err_alloc;
 	}
 
+	sruntime->dev = ctrl->bus.dev;
 	ctrl->sruntime[dai->id] = sruntime;
 
 	for_each_rtd_codec_dais(rtd, i, codec_dai) {
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 4f3d14bb1538..650334adc261 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -1023,6 +1023,7 @@ struct sdw_stream_params {
  * master_list can contain only one m_rt per Master instance
  * for a stream
  * @m_rt_count: Count of Master runtime(s) in this stream
+ * @dev: SoundWire controller owning this runtime stream
  */
 struct sdw_stream_runtime {
 	const char *name;
@@ -1031,6 +1032,7 @@ struct sdw_stream_runtime {
 	enum sdw_stream_type type;
 	struct list_head master_list;
 	int m_rt_count;
+	struct device *dev;
 };
 
 struct sdw_stream_runtime *sdw_alloc_stream(const char *stream_name);
-- 
2.34.1

