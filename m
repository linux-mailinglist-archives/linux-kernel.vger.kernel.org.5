Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA8077706D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 08:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbjHJGdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 02:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbjHJGdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 02:33:23 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DB326B1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 23:33:21 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe501e0b4cso4783285e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 23:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691649200; x=1692254000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vbXpmjMjw+lKtOoDoBL66la8kJXNdX97D3faoVkRss=;
        b=qRwFGkjs7FH05bLZCJETWbxdoViNxeC39FXgvqqlKU61gi57Ql7yy45M1F9AB8/Vnf
         m4mxqNHy7YspE8rZapqbpkWRGZNRknmR0Yw7mWVyCBYFhav+VPIm769MnpWWKLDWK6vD
         vC9kR5dcS6XYThPTkqfm7G3IaFxYAITemSv9pNs25yTxEymWJ1iCR4S+CpNCl/bM8AyP
         mrkj897BIXv6i7FCzrK0Wv2NRScb1bjBumNlC2vJIZeqIGZU5Uqzi7GP1fP1aQdTNOBW
         HBwf/zF4nwCb5TmpvViNmeug8wNpHdz1zKVQBEZuO6N2j7ktVNinkhjQ1eADaGOvVh0w
         T7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691649200; x=1692254000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2vbXpmjMjw+lKtOoDoBL66la8kJXNdX97D3faoVkRss=;
        b=gRWYRA8I0L1EA4Fu4Yc5EThL9aXNOgHDmjO+CSUqkh5FycBT9aaNwEXmuM3uwNF0Dq
         6N5t+TOgX38AjDjdDPdFPa6KWSxbe9ALwtJ+8mAEv1U5Kw+clfY2KHJ1O5uIeRrH0Vx1
         N0v59GmYuPMXtfU5/KRc+672tqhEY2mND9VCURpVoJRyaEbhCfObW5YAaobmZxRreUsO
         Wu0IRr5K3Fm2HDxoc0fp6Vgy7S9sKcLPlKbVqhglRIYFFkh7ybXq7mOhFwSwKdLmkMjZ
         ALV3xBOUguA1XYOh0n36aJP5jlvKF4Uj+jucLhydCaSidngqRR5deJuqLA6yjggWhGfs
         CG2Q==
X-Gm-Message-State: AOJu0YwS76eIAwq8TR/z7Tt1MveP+DNtGpXQC9ZvRoRhh3+3ls0RTOWk
        DvcB2pq8dosMjyosf1rkyTPUhw==
X-Google-Smtp-Source: AGHT+IFDBMmqGDMuwzh1dxYq3965kvpNZ6gEY/ZZqIfT2y0gnQEekNtyV10m0SOedP3uEd/zcYBgQw==
X-Received: by 2002:a7b:c398:0:b0:3fe:1820:2434 with SMTP id s24-20020a7bc398000000b003fe18202434mr1112564wmj.1.1691649200441;
        Wed, 09 Aug 2023 23:33:20 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003fe2b6d64c8sm4020018wmc.21.2023.08.09.23.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 23:33:20 -0700 (PDT)
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
Subject: [PATCH v2 08/11] ASoC: samsung: aries_wm8994: parse audio-routing
Date:   Thu, 10 Aug 2023 08:32:56 +0200
Message-Id: <20230810063300.20151-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810063300.20151-1-krzysztof.kozlowski@linaro.org>
References: <20230810063300.20151-1-krzysztof.kozlowski@linaro.org>
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

Parse generic sound card "audio-routing" property and fallback to
"samsung,audio-routing" if it is missing.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/samsung/aries_wm8994.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/samsung/aries_wm8994.c b/sound/soc/samsung/aries_wm8994.c
index 7492bb41456c..dd3cd2c9644a 100644
--- a/sound/soc/samsung/aries_wm8994.c
+++ b/sound/soc/samsung/aries_wm8994.c
@@ -620,10 +620,14 @@ static int aries_audio_probe(struct platform_device *pdev)
 	/* Update card-name if provided through DT, else use default name */
 	snd_soc_of_parse_card_name(card, "model");
 
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
 
 	aries_dai[1].dai_fmt = priv->variant->modem_dai_fmt;
-- 
2.34.1

