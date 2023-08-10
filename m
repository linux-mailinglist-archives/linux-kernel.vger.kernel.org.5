Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBE9777073
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 08:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbjHJGd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 02:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbjHJGdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 02:33:41 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCAE2719
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 23:33:29 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe5eb84dceso4802805e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 23:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691649208; x=1692254008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WBYHWBePTU6C5eucIxmnpm6TRHg4GxWEuDC87hbIx8=;
        b=WsW7N5hH568pRQc1HRO3Dph5sZBjMP7VCQ9PCz17RKguEShZUyFktuqumSMowNXnNL
         eZS7dxaBqYwAANnxZaDYAmepUMVya8yW7kPjBBApwlk7OvvMjJEZO7H+FbP07j4yW/Q9
         v+OQWgdu1hwGASwjeScs1jrTLWsV+ZWk6T7EU3sxTyt8AmDwR3GSouEMghCxR7wTB4+l
         QyKQhIQUJpsbbZm1bTH7OH4EwIzoF2l1A+au4POCQyT1uXwMkgZcMkz5b1mxwoyN3S41
         HQkoW65jAh72hsl2jei/YeCfL+DOSWqvIbvOk1YayxqYBkf7jfR67GAuRMcFIDR1qauT
         ezqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691649208; x=1692254008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WBYHWBePTU6C5eucIxmnpm6TRHg4GxWEuDC87hbIx8=;
        b=BItk5jOUBoEFc4lakc7xF8a22Wj8MKdjCS38KjGhrIUUQEW0Z5/9BiaH/pca+Bl3Hq
         4kEt2NFfun9NV67jblXUgKqkUM1Hnj44PshvPQMVvefzDwGv+RHdAK7pLQJVQSFGj7rZ
         eAG4iBB/G+g+R2/KgPeqof2FxaRRYFapSu9RS5kJOd3scFDQWSN4YNJ7NlBtmAM/jDtN
         03MC8TGMFVz38EMj5hHRe55JiLzJlJ7zrIGV8jR8aGdmoUaH+/edLcKug0S/a0AzPILO
         OKEp/OMUCHrQBwz8VWiYdyTB20aeftCw7m8NpA0+qkkC/CUf77610WukkAtLxx/3WWqu
         Mdxw==
X-Gm-Message-State: AOJu0YyrJlltMcS241L+1zDZm5EPRvkhPCFsrT51cXXQtnF1wjNXQCMG
        yDLiYC+XVtu32CZpjmPpXacOCg==
X-Google-Smtp-Source: AGHT+IEXV/tZ+ldWvHaqx8+19PGg8/1xO8IsS1t83BnY9Nx8oyuLOskgHlviUqUGSPNbI+PEAFXAUg==
X-Received: by 2002:a7b:ce8e:0:b0:3fe:2109:b9ff with SMTP id q14-20020a7bce8e000000b003fe2109b9ffmr1127175wmj.0.1691649208491;
        Wed, 09 Aug 2023 23:33:28 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003fe2b6d64c8sm4020018wmc.21.2023.08.09.23.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 23:33:28 -0700 (PDT)
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
Subject: [PATCH v2 11/11] ASoC: samsung: tm2_wm5110: parse audio-routing
Date:   Thu, 10 Aug 2023 08:32:59 +0200
Message-Id: <20230810063300.20151-11-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810063300.20151-1-krzysztof.kozlowski@linaro.org>
References: <20230810063300.20151-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse generic sound card "audio-routing" property and fallback to
"samsung,audio-routing" if it is missing.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/samsung/tm2_wm5110.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/samsung/tm2_wm5110.c b/sound/soc/samsung/tm2_wm5110.c
index d611ec9e5325..5ebf17f3de1e 100644
--- a/sound/soc/samsung/tm2_wm5110.c
+++ b/sound/soc/samsung/tm2_wm5110.c
@@ -523,10 +523,14 @@ static int tm2_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = snd_soc_of_parse_audio_routing(card, "samsung,audio-routing");
+	ret = snd_soc_of_parse_audio_routing(card, "audio-routing");
 	if (ret < 0) {
-		dev_err(dev, "Audio routing is not specified or invalid\n");
-		return ret;
+		/* Backwards compatible way */
+		ret = snd_soc_of_parse_audio_routing(card, "samsung,audio-routing");
+		if (ret < 0) {
+			dev_err(dev, "Audio routing is not specified or invalid\n");
+			return ret;
+		}
 	}
 
 	card->aux_dev[0].dlc.of_node = of_parse_phandle(dev->of_node,
-- 
2.34.1

