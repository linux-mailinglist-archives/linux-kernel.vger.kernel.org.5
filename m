Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C125476921C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjGaJpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjGaJop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:44:45 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB291986
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:44:19 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31792ac0fefso1517714f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690796640; x=1691401440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNOB2kSBm/ZCjLUQLsGBk0BsOPSn2yUKgs+5rBFTqgc=;
        b=p9WGqBEO1R9VytlRHDo/HZ1uwShHN2SLVI387g5girhq6M+o1kwBxUZv1AcVFHO8Zl
         hG1jYTwRo4HiCvEzYeT6Cu5viDEEP4GkBaQJOTulYCry4Wqh+vGZhAHrapnloCz9Lvvr
         1TXg8jwln8Vxcxz8abcB8L3W4+dAi2xKxTQ+rTLPhf+EDoAsnmfHs8aAPQCLVzp8+Lv6
         qwWuLxTlvkthajwdZQbw009GUatqRqs4SdJaANqsMg8CAYhbYVwcx6mkAOntqPz29yFT
         /6mu7gvqHCVmr33Yo9o3CHJP2Dc0dqyuEp7Qk9BsGQWw7lbgqiGZNd+zG1D/Af6LeUPc
         Iolg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690796640; x=1691401440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNOB2kSBm/ZCjLUQLsGBk0BsOPSn2yUKgs+5rBFTqgc=;
        b=Mbag8UaT1FIiWyIxP28gNChVCButKb8gTkLBAY19fcXSCnt+dVwJtVzodG/8qpW48Y
         oS1Ygw9klD41OBgfqm0uNQ3p3IgVPgaWOQnihudH72A28P40qXxThdmwkUzC/Qbf1QOb
         YiaAD5ygAciRrRMgQh65GcdUGV2pU1yyfr52dOiww6o7DnHIAbsd2yxRHwo9hKh897jn
         yfCxqNIg4CzHqk1vAtzyFh6dEQrKVvp1/sbdMyrhIpWzOoNsYEFk6fsU1GgWhgffPEMC
         Pk0sgMbmp8lfs+qR6MKfKjMmY7E460vT5Ia/jHQXABtW8bVooKMt2bfD4p6tQuauqI2f
         hy6Q==
X-Gm-Message-State: ABy/qLbYk7Bm03+DazoM5JLvTrVzj2GM1D8ysj6i4/MjnikkJRR2prAu
        kSHJ/awDybmtNf5nsfvnIPOtLzHaWu3J3cGxkMo=
X-Google-Smtp-Source: APBJJlHUrPvgQI+LUCrK+fMQO4ZN6R1lD9qdc/qBN0woqpQl49xLOblAvsdV3IiwHKgyrdrveuwFBA==
X-Received: by 2002:a2e:9557:0:b0:2b9:eeaa:1072 with SMTP id t23-20020a2e9557000000b002b9eeaa1072mr1013157ljh.18.1690796619353;
        Mon, 31 Jul 2023 02:43:39 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id z17-20020a170906815100b0099bcdfff7cbsm5867547ejw.160.2023.07.31.02.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:43:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Rohit kumar <quic_rohkumar@quicinc.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Rao Mandadapu <srivasam@codeaurora.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 10/12] ASoC: samsung: midas_wm1811: parse audio-routing
Date:   Mon, 31 Jul 2023 11:43:01 +0200
Message-Id: <20230731094303.185067-11-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731094303.185067-1-krzysztof.kozlowski@linaro.org>
References: <20230731094303.185067-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse generic sound card "audio-routing" property and fallback to
"samsung,audio-routing" if it is missing.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/samsung/midas_wm1811.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/samsung/midas_wm1811.c b/sound/soc/samsung/midas_wm1811.c
index 6931b9a45b3e..9e83ed071f39 100644
--- a/sound/soc/samsung/midas_wm1811.c
+++ b/sound/soc/samsung/midas_wm1811.c
@@ -462,10 +462,14 @@ static int midas_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = snd_soc_of_parse_audio_routing(card, "samsung,audio-routing");
+	ret = snd_soc_of_parse_audio_routing(card, "audio-routing");
 	if (ret < 0) {
-		dev_err(dev, "Audio routing invalid/unspecified\n");
-		return ret;
+		/* Backwards compatible way */
+		ret = snd_soc_of_parse_audio_routing(card, "samsung,audio-routing");
+		if (ret < 0) {
+			dev_err(dev, "Audio routing invalid/unspecified\n");
+			return ret;
+		}
 	}
 
 	cpu = of_get_child_by_name(dev->of_node, "cpu");
-- 
2.34.1

