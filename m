Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22237D2F0D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjJWJz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbjJWJzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:55:13 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB271718
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:54:55 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32dbbf3c782so2378926f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698054893; x=1698659693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iygGW2h2lVMWeGfG3UfW0SGTTyTrk1COvj9PMOD/Pf4=;
        b=qUpXN0ILCi4LvFMINMaTf56b3r6pxUi8xiIVFHn6NjdTchBM/L0hxdfp9ZgbPsOMEr
         bMQqww3Arug8O47iA5c00G777hjoX4vSly49WoLvATe6qW+JqpPE8aVsZ/HHLRGfYD9D
         STpDO1D13bAeZT5UgJVBKhZ21o0jBxbXp0bZ19pEbhlDM+cwkmTHRg2JBotvzNQMqEqf
         FBR7EqDniDJw19/OoWcQvddq/qNS+u2nqdZyfu6FYblWgKHhj+6HL/KrpjzyWXVGB3pg
         dxFXOt1wFhm+sOqi234SpH0ek6MIAods1pffV4sRpi0SQILgnVoDiPa1kvzcpmY6ayar
         vWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698054893; x=1698659693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iygGW2h2lVMWeGfG3UfW0SGTTyTrk1COvj9PMOD/Pf4=;
        b=dn1NrKcF0wiK55x2PCXqjXwMwm/Z4cxRu3a+4v3QO/sBUS1WQi8SMtTGOQjazyUkWg
         dmdkT3N6c2PixzbFP5OM8yoaEoT9e9rMOg93VOB/Yl/WJPPSnE93c6bI5xXhBU4lpP80
         EDpSSAX9uFXbth0NBNKVoa53TDMtQLmT0H45g1XcLnb703yqDeZfaEFRiuOYLw5b8sd2
         X2ze9r2kAaY+aNUqW4i4uC9igj6T96jcA59di52P/gGOWghmtJarZcBQFD4IDTYqBW6T
         tpMEuDqInBNIb07AGIGDhDq1VUKntmbWwZ8NikGHsTBGJW0azYnYbgO7XR8G+16h8RWc
         Mqsg==
X-Gm-Message-State: AOJu0Yz13fGtW1GUPIOmsulYd0PS026ijKgFhaYSGzRocunGnGMTfmN9
        URrjMg+MF+HcHMuu/HqwEO0KlQ==
X-Google-Smtp-Source: AGHT+IHTc2UW0PcRRtRg3EJmwXBDKZ0rRGICIe4tZ3tRk+SG6RlHUvnvHSIX5664+drOKrq+nZy8rg==
X-Received: by 2002:a05:6000:92c:b0:32d:81f9:7712 with SMTP id cx12-20020a056000092c00b0032d81f97712mr8264026wrb.20.1698054893380;
        Mon, 23 Oct 2023 02:54:53 -0700 (PDT)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id u14-20020a5d468e000000b00323330edbc7sm7428801wrq.20.2023.10.23.02.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 02:54:53 -0700 (PDT)
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
Subject: [RFT PATCH 09/17] ASoC: codecs: wm8962: Handle component name prefix
Date:   Mon, 23 Oct 2023 11:54:20 +0200
Message-Id: <20231023095428.166563-10-krzysztof.kozlowski@linaro.org>
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
 sound/soc/codecs/wm8962.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 83ce5dbecc45..fb90ae6a8a34 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -1854,10 +1854,10 @@ static int tp_event(struct snd_soc_dapm_widget *w,
 
 	reg = WM8962_ADDITIONAL_CONTROL_4;
 
-	if (!strcmp(w->name, "TEMP_HP")) {
+	if (!snd_soc_dapm_widget_name_cmp(w, "TEMP_HP")) {
 		mask = WM8962_TEMP_ENA_HP_MASK;
 		val = WM8962_TEMP_ENA_HP;
-	} else if (!strcmp(w->name, "TEMP_SPK")) {
+	} else if (!snd_soc_dapm_widget_name_cmp(w, "TEMP_SPK")) {
 		mask = WM8962_TEMP_ENA_SPK_MASK;
 		val = WM8962_TEMP_ENA_SPK;
 	} else {
-- 
2.34.1

