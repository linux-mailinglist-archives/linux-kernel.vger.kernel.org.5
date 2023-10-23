Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B25A7D2F0F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbjJWJzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbjJWJzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:55:14 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4A8E6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:54:57 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32d9b507b00so2282584f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698054896; x=1698659696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkUvzAZAFAxBUpUecaFOI7DumC3gwDv4zZE7XoEdjuk=;
        b=Q5ynP456sBY9q+s7u+xqYUeiMrakgZWEFKXvM/6j0781R3HNLoi+WmlKpMl9HYJctk
         rwmIAwP6yyFP+kNIM1vBq+GU3OyGWfCo6awqI2QqhTeZkQ5rgPXOU+g/JYgpb4BZrDLn
         A5R5iP/Z9MsP6UAwbIYUVn1po8KWIV3BuJLuOqAOqbgnZ3Uz7oiFXDbyYN6cqxY3isVz
         Ujn5N8YT6tn21ESFS02QF+DMLWZVVEv4GVV+6XMicb36R40AcmImX8xHj0NjN4LhYj+e
         P6e4FyyESqMChd4d7+BzSPV4EWrWz8faUDjLXsjUK3wOGXKaDDP9V5519sVmBiwVfd1/
         KI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698054896; x=1698659696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkUvzAZAFAxBUpUecaFOI7DumC3gwDv4zZE7XoEdjuk=;
        b=tcxskQtjtWpKXzU92cwi9vnQCLU/wRyt7IurLXMGmA0y5xdDRVtvLpIgbYX86Ge30P
         T8rz6T7wpzmD6+XNBo/KcEf+9ey3VJ15q42exb7pc1rudvlAoMhTVUUFg8AFnB1HGplu
         1gS/v3fA391Y2uQHAZH1lnr5fUFqoYGi7IfOtqOYNhZWGgM5fgzv5r8CM8/LWV1UeRlo
         lAtAP6pAnIKnmILIBlfJSza94h/8xoFan0AFhKTeJw/dZFntdKC7/1xr0raTASr/fbWY
         zzy8BKSPa1xchgec0qjhJnAPGBG+UMOVnHZ/Sl7LQewUxwr/5qTbyc5Zi2/16tGJMHBL
         3WNA==
X-Gm-Message-State: AOJu0Yw8jA+8o/B3u9uHyFUItoyUxgmUf10Qz2YgCvkYGWDCTtZFriBB
        N/kh+quiT+VpaJ3SEon+ch0jtA==
X-Google-Smtp-Source: AGHT+IHWg8SLe3xjPrj28tLTDiymcbd03RUAChA7SD3rg/2FeMGUhVv6IRTOZLXoX6FA5TVWxviBfw==
X-Received: by 2002:a5d:6804:0:b0:32d:8907:4528 with SMTP id w4-20020a5d6804000000b0032d89074528mr5681524wru.28.1698054895793;
        Mon, 23 Oct 2023 02:54:55 -0700 (PDT)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id u14-20020a5d468e000000b00323330edbc7sm7428801wrq.20.2023.10.23.02.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 02:54:55 -0700 (PDT)
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
Subject: [RFT PATCH 10/17] ASoC: codecs: wm8994: Handle component name prefix
Date:   Mon, 23 Oct 2023 11:54:21 +0200
Message-Id: <20231023095428.166563-11-krzysztof.kozlowski@linaro.org>
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
 sound/soc/codecs/wm8994.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index a48e904a9740..fc9894975a1d 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -262,7 +262,7 @@ static int check_clk_sys(struct snd_soc_dapm_widget *source,
 	else
 		clk = "AIF1CLK";
 
-	return strcmp(source->name, clk) == 0;
+	return snd_soc_dapm_widget_name_cmp(source, clk) == 0;
 }
 
 static const char *sidetone_hpf_text[] = {
-- 
2.34.1

