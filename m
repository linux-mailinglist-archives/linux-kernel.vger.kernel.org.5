Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370A77D2EFA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjJWJyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjJWJyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:54:39 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CC9E6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:54:37 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32d834ec222so2098493f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698054875; x=1698659675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YC/W8702n/IhtK2/nRJYRFXj5SA3+z6eWXwAmZT4eY=;
        b=z8wzB8ADL91wvnnXhOGSny0rBqZvEsstAaA622VYDARD0xigKUTqXyak+lEh8S0YQO
         AkjrNpQXEyRaRszo1z3IYkKQNiU0gRG62OdzhB9vohlAkm+thWM+PpELgG94GSn3n/lf
         4wEOsr37gIReLlnkN9fqZNvgaprkJ0F71vh6PdD8LeE0G8yuvLk9idvMd/QZ7RnMtIx+
         AkjltU+uoXU+SXhOpPrFJo7TXlMEo0zeLW+vZgHwWM2N+M+dhtL+ttiFsXvrtZ4nnk1v
         lb4AmITxRCfVvHvUktw/RY0kveaJdfItkNEWcrZjyjtr2eJmF4vZaqpBuXm/kIw+DLL5
         raoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698054875; x=1698659675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4YC/W8702n/IhtK2/nRJYRFXj5SA3+z6eWXwAmZT4eY=;
        b=A4dgRIyMTkXhBysYr/LuPyHtFsAxWEI+4KVoGU0GLV18tGGRa3ZQl5ftRubzJudZ8Y
         rRcK5GLs0PAyK8Rw8vIvFHVnHc/ZX8gRc5a4to/p/AC4fMYMCNL4Yv4zWZrqnXQyzVmd
         U0rcGcuzfEwDhqs9Dq9diCzPcB90yALq4R+NDi3x8eT+C3vCz9dbF4uiDz1C+LrSjkqv
         hT5Xh/8G8dNu7GEul9AIzcy7nTuxOO12T5cMYXbBmy7xsRWBrLze3Lz3klaL6HHZjEu/
         U/s+NpezyZ0d6CXHSOhIhx3SyBWvvG4C6Gm4OlAqMNx6CXHn63k1wuvtk5xxCU2o9i6o
         0rTQ==
X-Gm-Message-State: AOJu0Yw0hWcTN9aalyZgN64MWeZxV7XL1saZBfRw59LfqWW/avT7eBmp
        W9I8ZbPWEngkIAxUHMTcWA0S9g==
X-Google-Smtp-Source: AGHT+IEHt7MU0pVVH3QtAU35Dth6+VQAGLU4qZyA/p6jZNdd35Imw6TEqgJZWhxMs2mnHadLP+Eb6A==
X-Received: by 2002:adf:fc09:0:b0:323:10b8:543e with SMTP id i9-20020adffc09000000b0032310b8543emr5848249wrr.49.1698054875438;
        Mon, 23 Oct 2023 02:54:35 -0700 (PDT)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id u14-20020a5d468e000000b00323330edbc7sm7428801wrq.20.2023.10.23.02.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 02:54:35 -0700 (PDT)
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
Subject: [RFT PATCH 01/17] ASoC: codecs: 88pm860x: Handle component name prefix
Date:   Mon, 23 Oct 2023 11:54:12 +0200
Message-Id: <20231023095428.166563-2-krzysztof.kozlowski@linaro.org>
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
 sound/soc/codecs/88pm860x-codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index d99b674d574b..be01f0928393 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -400,9 +400,9 @@ static int pm860x_dac_event(struct snd_soc_dapm_widget *w,
 	unsigned int dac = 0;
 	int data;
 
-	if (!strcmp(w->name, "Left DAC"))
+	if (!snd_soc_dapm_widget_name_cmp(w, "Left DAC"))
 		dac = DAC_LEFT;
-	if (!strcmp(w->name, "Right DAC"))
+	if (!snd_soc_dapm_widget_name_cmp(w, "Right DAC"))
 		dac = DAC_RIGHT;
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-- 
2.34.1

