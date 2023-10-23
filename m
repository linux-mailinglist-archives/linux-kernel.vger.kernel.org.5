Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3359A7D2F0E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjJWJzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbjJWJy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:54:59 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096AB10FA
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:54:52 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32da9ef390fso2147663f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698054891; x=1698659691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PvbddIvQlG0l/ZDn5njSVhrq4RgzTBlbX25/MYIgFc=;
        b=QL3y9JEcLadLoCqVFZ81Hw0SF59gHlxSpxmeZjKjaxcnzAg4Ay57nfed9ds+wXaoCa
         CXX6nVrSEHDEbQ+2wl7+sJr6ijlxjbdzBPc3uO/aY6qgiAEz1WZfl3cvrbUB3odjeBu/
         bDPZrthuoGecsPKU9G3XJlQb5qYtYqBM9Ip+92a4dEV47oezPwEDSQDd197DJbwtKDgB
         mpQvvoNTDA9tgqC9xbP2AzkdfYMnoplOQqx+ZPqzEUyg8+5VPTw/cDw2tVXHa1piqm8X
         J3DhZRQu39hKSBi6tVKhOh7XLU7D2Px1CWCP8zBqSbgD5tTbracrkk0pEsDpNGV7Eewn
         +svQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698054891; x=1698659691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PvbddIvQlG0l/ZDn5njSVhrq4RgzTBlbX25/MYIgFc=;
        b=tl74xKDrTeKlXuvWnpaJgv7b/mKvo03OKIkNftxXEpnRlRuUGYQs/+aLSz/rqajnV/
         NhVRSv9ZJf1FB4Jh9mLBgTch1h1i77QK4kL1YfryFxKKVC0NgNf4nTRlaa3lh6HUKFTo
         qqa3GsRUr7PZg8KTS70edrKNNg4FIN+AbdfiX0mT2O4WocKo05GjHuAUC+vp8hphJJ5e
         +/rCsgOa4Z8h5/VL9LEi0cVcJG/4AnylNA/N0wk23V22vHdwQ8MOEUEPUjVeQI+qAdNV
         cYHmUowKdjUf7J9nJWiaWYtecoBqI5bEVTvNZluF4M8zJiNklpc96aD9G22jmhd9KumE
         ys7w==
X-Gm-Message-State: AOJu0YxX4ku0hClhQzcAZEXphT1GZmPXb2C3naq8cECFAbOlr2TvyOHj
        IIxR7F7aus+QXXvpOYHhy0Sdog==
X-Google-Smtp-Source: AGHT+IEmmCcXMvV2AiWhQpKHX0IqP6/STlrOm+onc5uiN24/C1EAIXqoQxx+Ad9L+iK6N0Yq3GEInA==
X-Received: by 2002:a5d:5709:0:b0:32d:9fd1:91f9 with SMTP id a9-20020a5d5709000000b0032d9fd191f9mr5739165wrv.60.1698054890848;
        Mon, 23 Oct 2023 02:54:50 -0700 (PDT)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id u14-20020a5d468e000000b00323330edbc7sm7428801wrq.20.2023.10.23.02.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 02:54:50 -0700 (PDT)
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
Subject: [RFT PATCH 08/17] ASoC: codecs: wcd9335: Handle component name prefix
Date:   Mon, 23 Oct 2023 11:54:19 +0200
Message-Id: <20231023095428.166563-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023095428.166563-1-krzysztof.kozlowski@linaro.org>
References: <20231023095428.166563-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
 sound/soc/codecs/wcd9335.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index a05b553e6472..43c648efd0d9 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -3296,31 +3296,31 @@ static int wcd9335_codec_enable_interpolator(struct snd_soc_dapm_widget *w,
 	int val;
 	int offset_val = 0;
 
-	if (!(strcmp(w->name, "RX INT0 INTERP"))) {
+	if (!(snd_soc_dapm_widget_name_cmp(w, "RX INT0 INTERP"))) {
 		reg = WCD9335_CDC_RX0_RX_PATH_CTL;
 		gain_reg = WCD9335_CDC_RX0_RX_VOL_CTL;
-	} else if (!(strcmp(w->name, "RX INT1 INTERP"))) {
+	} else if (!(snd_soc_dapm_widget_name_cmp(w, "RX INT1 INTERP"))) {
 		reg = WCD9335_CDC_RX1_RX_PATH_CTL;
 		gain_reg = WCD9335_CDC_RX1_RX_VOL_CTL;
-	} else if (!(strcmp(w->name, "RX INT2 INTERP"))) {
+	} else if (!(snd_soc_dapm_widget_name_cmp(w, "RX INT2 INTERP"))) {
 		reg = WCD9335_CDC_RX2_RX_PATH_CTL;
 		gain_reg = WCD9335_CDC_RX2_RX_VOL_CTL;
-	} else if (!(strcmp(w->name, "RX INT3 INTERP"))) {
+	} else if (!(snd_soc_dapm_widget_name_cmp(w, "RX INT3 INTERP"))) {
 		reg = WCD9335_CDC_RX3_RX_PATH_CTL;
 		gain_reg = WCD9335_CDC_RX3_RX_VOL_CTL;
-	} else if (!(strcmp(w->name, "RX INT4 INTERP"))) {
+	} else if (!(snd_soc_dapm_widget_name_cmp(w, "RX INT4 INTERP"))) {
 		reg = WCD9335_CDC_RX4_RX_PATH_CTL;
 		gain_reg = WCD9335_CDC_RX4_RX_VOL_CTL;
-	} else if (!(strcmp(w->name, "RX INT5 INTERP"))) {
+	} else if (!(snd_soc_dapm_widget_name_cmp(w, "RX INT5 INTERP"))) {
 		reg = WCD9335_CDC_RX5_RX_PATH_CTL;
 		gain_reg = WCD9335_CDC_RX5_RX_VOL_CTL;
-	} else if (!(strcmp(w->name, "RX INT6 INTERP"))) {
+	} else if (!(snd_soc_dapm_widget_name_cmp(w, "RX INT6 INTERP"))) {
 		reg = WCD9335_CDC_RX6_RX_PATH_CTL;
 		gain_reg = WCD9335_CDC_RX6_RX_VOL_CTL;
-	} else if (!(strcmp(w->name, "RX INT7 INTERP"))) {
+	} else if (!(snd_soc_dapm_widget_name_cmp(w, "RX INT7 INTERP"))) {
 		reg = WCD9335_CDC_RX7_RX_PATH_CTL;
 		gain_reg = WCD9335_CDC_RX7_RX_VOL_CTL;
-	} else if (!(strcmp(w->name, "RX INT8 INTERP"))) {
+	} else if (!(snd_soc_dapm_widget_name_cmp(w, "RX INT8 INTERP"))) {
 		reg = WCD9335_CDC_RX8_RX_PATH_CTL;
 		gain_reg = WCD9335_CDC_RX8_RX_VOL_CTL;
 	} else {
-- 
2.34.1

