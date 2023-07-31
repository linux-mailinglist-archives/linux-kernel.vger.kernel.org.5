Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B08769D44
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjGaQzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbjGaQzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:55:35 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC32A19B2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:55:29 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe2503e3easo4461104e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690822528; x=1691427328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RpT8nlEbctAiS0l82doDIjU49cpafv/Kh1hBxCyIFMo=;
        b=Rw05xMgeodHctFTvKIC6laouQfNYMrrCy85KAbY3jUEwE/zAzGSE7inbQ1dCSG3OvU
         nJ6lmmm58KV+hhoYyFvzr/6gVyymsQPXPkO8eBpKoGGitA6MHsDcLVT6ile8EKsu5wAc
         Ux7AxuAPnCOrxOoQRMg4BtENAtstKNE2jWV887AvuHdhi94vHi+gLKHvJRGYjF/JKFm+
         p5TvphCnkP8CGtAiQgSb5N+D5Llrz5PrfGODaO14DFc2R8f/SDIkTqy8kq0SD+qFifqC
         ciK2YXicb6C0aTPVn3pECwELMaVncon34fL8AoOsKI2g/0tCmXXKFTs/1sLMjtOqwNq9
         vUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690822528; x=1691427328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RpT8nlEbctAiS0l82doDIjU49cpafv/Kh1hBxCyIFMo=;
        b=HBqphF9LDjC3TeLbuwo2NrAcpSV2H5ooKR1XMrhSiwqVJcMDx6rUrtkmtzqF8D6sk+
         lFSPss+ue2btBxcgCZ9Z50tLknPAq9/C1dyEGZxv9xykBrKW6vC7SkvdOkNwrFLrUQ5q
         BoyRMssELgB8AWebFytw8GrpRQ9tZY+ZppXJ27sJUWzgPPXnk3V919QeMsg3c8isQwVv
         FnkN+QbSq5uy906YQzqryZYvdJ3X1ERPVt9m10Q6yBG0mDn2cjHdZibDkYwq8Im4L0ms
         AGuheeE8d1HbDoyFGBh05cNlWsSH37VYfPhpPGPMnnwpZUmrfQ88YvGNy5YBSXguYMNi
         uH1g==
X-Gm-Message-State: ABy/qLY5qHm67TeSI3yGiGvIqOFXrbycT0nNhgEI4eJstR9bmUtrkzZO
        KCRcvKKdblHRP3Xi38lfTaGd3DXFdAQtWCS1654=
X-Google-Smtp-Source: APBJJlEH5+oK+Q7hPPqgktOZNUuPZU1PTqLvEGDjNa8eYUYojlkbc2qdz2IzV3gGcoZzoec2GACWHQ==
X-Received: by 2002:ac2:5e6b:0:b0:4f8:5905:8e0a with SMTP id a11-20020ac25e6b000000b004f859058e0amr240314lfr.6.1690822527751;
        Mon, 31 Jul 2023 09:55:27 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id s4-20020a170906c30400b009926928d486sm6374444ejz.35.2023.07.31.09.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 09:55:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: codecs: rx-macro: Enable RX path clock to match POST_PMD
Date:   Mon, 31 Jul 2023 18:55:22 +0200
Message-Id: <20230731165522.328301-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver disables RX path clock in SND_SOC_DAPM_POST_PMD of
rx_macro_enable_interp_clk() and rx_macro_enable_mix_path().  Make the
code symmetrical by enabling the clock in SND_SOC_DAPM_PRE_PMU.  This
also matches downstream Qualcomm driver for Qualcomm SM8550 SoC.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/lpass-rx-macro.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 685ca95ef4a9..a758ef4f575a 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -2529,6 +2529,9 @@ static int rx_macro_enable_interp_clk(struct snd_soc_component *component,
 						      CDC_RX_PATH_PGA_MUTE_MASK, 0x1);
 			snd_soc_component_write_field(component, dsm_reg,
 						      CDC_RX_RXn_DSM_CLK_EN_MASK, 0x1);
+			snd_soc_component_update_bits(component, main_reg,
+						      CDC_RX_PATH_CLK_EN_MASK,
+						      CDC_RX_PATH_CLK_ENABLE);
 			snd_soc_component_update_bits(component, rx_cfg2_reg,
 					CDC_RX_RXn_HPF_CUT_FREQ_MASK, 0x03);
 			rx_macro_load_compander_coeff(component, rx, interp_idx, event);
@@ -2595,6 +2598,9 @@ static int rx_macro_enable_mix_path(struct snd_soc_dapm_widget *w,
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		rx_macro_enable_interp_clk(component, event, w->shift);
+		snd_soc_component_update_bits(component, mix_reg,
+					      CDC_RX_RXn_MIX_CLK_EN_MASK,
+					      CDC_RX_RXn_MIX_CLK_EN_MASK);
 		break;
 	case SND_SOC_DAPM_POST_PMU:
 		snd_soc_component_write(component, gain_reg,
-- 
2.34.1

