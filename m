Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8087D2EFE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjJWJys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbjJWJyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:54:41 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE81D6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:54:38 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32daeed7771so2082371f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698054877; x=1698659677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJErgU+nUAjpf1N+MX3RFSZtoYrYFdNiReNrVNbPccY=;
        b=hmVeL1P/ij1fv6Iv9vFwD9B3HWyQfQMCIaVad7JXndz7emTjBmt3LbnG/Umkhw/K3i
         m9ssoZtsBTsgwoI/RY9gzD0Ei8klrTy6S2GBhd8D44RGQZtIWQM11QyyknVQzXdLm3GT
         1cLXuyMZ9Tvao3v6hx6j/YlKf1ejvEM+SC48Kkv0wYjoRb/CpIyOjAA+poD6WC6qDGHc
         9iw+GKImIu2SP1qm8DIVgypIvvCGcennBJ+vJjjOZVtJ7rHIUKcdRst1TcSR9l0h4upC
         0mnrQO0aTDSoguHJaBkgBaaY70XgDx6UEftJnF/4x2iWmSag/izSj+CNP2+4VmHMKPM2
         sVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698054877; x=1698659677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJErgU+nUAjpf1N+MX3RFSZtoYrYFdNiReNrVNbPccY=;
        b=MuY2S8E/TnW5Qf1/OynkaPhQvYeezTJXPXLUKyouKMZCqcfkU3GxP3yh/Oi8etdWM6
         EKWTTsPfocOiSR6uh3zBaPorQwHBoANYBXY+Qkp6wPaOITPV8KZykc4Cjy37DTE1YGxj
         1/AVd7et1Jq3UpNZDKKVdzkS3tjZZXtyh9paZLHnhYYXSSwqWkaYap4mPrhSLdJd+vSP
         Gl70+wx++Z9vLmYqe6t3+FZDrAIbgrm6spVH7MQrBELeDMq4Nkhp02iaort2mYDJ2fzY
         le4bxHpOI+assXJTtuZFjOkeFfUpjuRLPjtcBINlHQlVsij1jqR20ltgxMEzmmW9lnMk
         8WcQ==
X-Gm-Message-State: AOJu0YzqS7/c3p8ddwr1xTdYmwy8k+yed/UvUJXI+P29VtAa9WnAFnpb
        vtD2je2KGt15VabI/ueRzEJMxQ==
X-Google-Smtp-Source: AGHT+IGm+wzbFOSTt4RIIX0gXAgxOLyRHhiU4Y3meUgY+Qffx0kn9EZ6h3swR1er/PSz6I6OP4nsNQ==
X-Received: by 2002:a5d:4483:0:b0:319:8a66:f695 with SMTP id j3-20020a5d4483000000b003198a66f695mr6356947wrq.55.1698054877529;
        Mon, 23 Oct 2023 02:54:37 -0700 (PDT)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id u14-20020a5d468e000000b00323330edbc7sm7428801wrq.20.2023.10.23.02.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 02:54:37 -0700 (PDT)
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
Subject: [RFT PATCH 02/17] ASoC: codecs: adau1373: Handle component name prefix
Date:   Mon, 23 Oct 2023 11:54:13 +0200
Message-Id: <20231023095428.166563-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023095428.166563-1-krzysztof.kozlowski@linaro.org>
References: <20231023095428.166563-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use snd_soc_dapm_widget_name_cmp() helper when comparing widget names,
to include also the component's name prefix.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/adau1373.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/adau1373.c b/sound/soc/codecs/adau1373.c
index b0ab0a69b207..3582c4b968a0 100644
--- a/sound/soc/codecs/adau1373.c
+++ b/sound/soc/codecs/adau1373.c
@@ -834,7 +834,7 @@ static int adau1373_check_aif_clk(struct snd_soc_dapm_widget *source,
 	else
 		clk = "SYSCLK2";
 
-	return strcmp(source->name, clk) == 0;
+	return snd_soc_dapm_widget_name_cmp(source, clk) == 0;
 }
 
 static int adau1373_check_src(struct snd_soc_dapm_widget *source,
-- 
2.34.1

