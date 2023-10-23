Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3377D2F00
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjJWJzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbjJWJyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:54:54 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385FB10C2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:54:48 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507b9408c61so4216272e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698054886; x=1698659686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mg1xiJ4tpWrc01TGrYLaIzComQYv1hvzEAR610Ntv3U=;
        b=JvPo8itjnZKIOL3UKj+h26Qsqnz1vIHwnQKAtfZbht61ULhSuht5nI6AGqtZeMKihV
         +MdVA6scm4aoYbJPRY+ddPNe+Um0dLrSMB2M54HXv5g7zjV9U+UcgemyI/b0dM4Du3sz
         cV8fFiQ7g0s9UKrkVurikbBmR7/nlOv0sZGbIkwvQ2r1iV0WD8t/ZDbsDCPS7tLqTLxE
         CVBqJH8DSQQlaTj0Qi93iQxCeu4ElE4i2i0ljbv8NSNNPnf7TbnwG3yYpkjHru5A0eOl
         jIgxsipz3FiEJR0pzuAMCjo48lahAxBWPWg9kS6BEecVnd/vgxeEEwBGZKzznkSCsNIm
         EXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698054886; x=1698659686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mg1xiJ4tpWrc01TGrYLaIzComQYv1hvzEAR610Ntv3U=;
        b=m6H7JkQl4N/R6Z3UCYdR/ErM6gKwsxBVcdmGyhIy92CQxFQg8SK28mjFHlV+PRU/nq
         8WENGRY3mTyZajiaezokNoFeklXTeMT9vh3RTez1sHAaPDh8SaGV8REOMbrG/tWknOzu
         ghMK6kNpOgeQf7Qxhm4CbsokaObKHeBKX7dOuXP+9DDZ+lZCPHNjgzTrwwwTAPsrinwd
         h0/1mMku0qVMBUO8e/2u9hHDj9yRR+Crqlw6MifFA3R+N6fAONGxuVqcQ+YmXqxa8kEE
         NSvTiGT/90glk0bBFwXG3oZhAPL2XBDke/xjGBepVbaEb8W1lc5dO0LTyIXWfxKLdEEi
         eZxg==
X-Gm-Message-State: AOJu0YyxYUzxEOHLhbKVW8vpXivcUDjCUzPPf/eZ+ASOvI8Nw8tGUQ5Y
        AHcl6Xcj81pTsWW6BfKL+Nl8wA==
X-Google-Smtp-Source: AGHT+IGVnDVUzhqtZG2Rxtx8SwcXnzeMCoNHkuKGJvqRY3jD0nxvOcWU8+AB175lzXv5OfVrm4BxmA==
X-Received: by 2002:ac2:4430:0:b0:500:b7ed:105a with SMTP id w16-20020ac24430000000b00500b7ed105amr6312430lfl.29.1698054886439;
        Mon, 23 Oct 2023 02:54:46 -0700 (PDT)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id u14-20020a5d468e000000b00323330edbc7sm7428801wrq.20.2023.10.23.02.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 02:54:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 06/17] ASoC: codecs: rt5682s: Handle component name prefix
Date:   Mon, 23 Oct 2023 11:54:17 +0200
Message-Id: <20231023095428.166563-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023095428.166563-1-krzysztof.kozlowski@linaro.org>
References: <20231023095428.166563-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use snd_soc_dapm_widget_name_cmp() helper when comparing widget names,
to include also the component's name prefix.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/rt5682s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5682s.c b/sound/soc/codecs/rt5682s.c
index 68ac5ea50396..c261c33c4be7 100644
--- a/sound/soc/codecs/rt5682s.c
+++ b/sound/soc/codecs/rt5682s.c
@@ -1323,9 +1323,9 @@ static int set_i2s_event(struct snd_soc_dapm_widget *w,
 	if (SND_SOC_DAPM_EVENT_ON(event))
 		on = 1;
 
-	if (!strcmp(w->name, "I2S1") && !rt5682s->wclk_enabled)
+	if (!snd_soc_dapm_widget_name_cmp(w, "I2S1") && !rt5682s->wclk_enabled)
 		rt5682s_set_i2s(rt5682s, RT5682S_AIF1, on);
-	else if (!strcmp(w->name, "I2S2"))
+	else if (!snd_soc_dapm_widget_name_cmp(w, "I2S2"))
 		rt5682s_set_i2s(rt5682s, RT5682S_AIF2, on);
 
 	return 0;
-- 
2.34.1

