Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2955769218
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjGaJpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjGaJog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:44:36 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA76AE5D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:44:07 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe3678010eso1165258e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690796622; x=1691401422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMM3/oOp03VQdiM5UtFP36bUtHvT73/cLwCpo+QdiIw=;
        b=p3V1KScmdLPmgJC69GcijUepICL5AVIM3EAETvRj+mTvl8smXeR7y+qE5llrGg1RBc
         mtCFxnbJt3diMjUWIgc/V85kdWzKsoCJU27yfBoQsImZvU0egnXL9lWKmOlI5YKzjUtW
         nfAwpgyk/SK6HEu+TBByd3i2lZDDBKYF1hDU/u/0nZYo5csjYCe+d9Wn3UvuunBi+GAQ
         aIRDBhMF6xnlo7gg5JTsuJtWglDKN/l9ppYfnwGgtyn5P0MR1WANzCPEbFSxY1bQjyVp
         KHd07Et7akegVLox7KMF1SsjBVlB78QSjiikAX4pc+rrOlH5LQdfQs5YXRumr1gfRBBz
         D92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690796622; x=1691401422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMM3/oOp03VQdiM5UtFP36bUtHvT73/cLwCpo+QdiIw=;
        b=hvu4mZnhXQ9rLdpqnGUZD03BA8UZkywoF3VwiA2eClHSy77g29ARt0Htu5R48J9vra
         SN1Bqr5sTlY9Mcc/KmS6Bv0z87315e4kNjKYkDxfmIy77NOBtSe8BstHYW7dE8PCLTue
         HbMdJWGUnh12r7s0+SYK7tHEIBaCEvwLK64lFQamiD7bstwtAB3Yk+f8YttKywx0qwsU
         PDryfplwi8IN8nfn2o5AsVaTPZikBnqn0+RHiUbgH6TffRRK10HglEdyj/5RzwUANcaj
         sdYZDCW+otxl3NjribGTvXZ1i1AXMpP/8L/jLRylZ7zr6f7QDKt81zBYc9BqGXZX3hII
         9bZw==
X-Gm-Message-State: ABy/qLa8JwXdw97KiJFD1gRuPdzaAeLF8aaphiX0EDHgLmB9tDiopI+S
        iAWFK63wgN7jS4OyOeDhIbO+eQ==
X-Google-Smtp-Source: APBJJlEp0ZNK+HWD6CIv96Mutem+tcF9lSytD8+rqw83Zg83lTGZaiCv/X0Q6YA+P3HWOwl2ZbY4yg==
X-Received: by 2002:a05:6512:459:b0:4f8:75cf:fdd7 with SMTP id y25-20020a056512045900b004f875cffdd7mr5655698lfk.22.1690796622165;
        Mon, 31 Jul 2023 02:43:42 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id z17-20020a170906815100b0099bcdfff7cbsm5867547ejw.160.2023.07.31.02.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:43:41 -0700 (PDT)
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
Subject: [PATCH 11/12] ASoC: samsung: odroid: parse audio-routing
Date:   Mon, 31 Jul 2023 11:43:02 +0200
Message-Id: <20230731094303.185067-12-krzysztof.kozlowski@linaro.org>
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
 sound/soc/samsung/odroid.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/soc/samsung/odroid.c b/sound/soc/samsung/odroid.c
index 1743bd55ba1a..c93cb5a86426 100644
--- a/sound/soc/samsung/odroid.c
+++ b/sound/soc/samsung/odroid.c
@@ -230,12 +230,13 @@ static int odroid_audio_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	if (of_property_present(dev->of_node, "samsung,audio-routing")) {
-		ret = snd_soc_of_parse_audio_routing(card,
-						"samsung,audio-routing");
-		if (ret < 0)
-			return ret;
-	}
+	ret = 0;
+	if (of_property_present(dev->of_node, "audio-routing"))
+		ret = snd_soc_of_parse_audio_routing(card, "audio-routing");
+	else if (of_property_present(dev->of_node, "samsung,audio-routing"))
+		ret = snd_soc_of_parse_audio_routing(card, "samsung,audio-routing");
+	if (ret < 0)
+		return ret;
 
 	card->dai_link = odroid_card_dais;
 	card->num_links = ARRAY_SIZE(odroid_card_dais);
-- 
2.34.1

