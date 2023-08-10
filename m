Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6579877706B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 08:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjHJGdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 02:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbjHJGdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 02:33:22 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB275269A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 23:33:19 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so8550871fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 23:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691649198; x=1692253998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYK3gBdbZNa0sNOQK67Ss/5e2crqIr7FWYCpvQqQW+g=;
        b=zMl0Q6Wo4VQxBOxQpo1rTcZRIWwM309TN6yCpDr/EeJrTnVpUvCkfew3iUmCwJpBBI
         MChHsatOC+ZhTfU2GaboaU02NCWtGr0R7Gbm/BTk/oo1E7nczfHfoN85tuwbxL0uJTEo
         ZaGHg4nLZ4pbZ5BbBxSkikvWi9RcizQXngjyy4DdN1wBLiBT3TIoW3brijqlQs6hlXHE
         7tuvYU4gYApdVRXh2fRnXMsZxuZb7lmL0XjHsLL+pxGon2FmmwvaKEobyZ3mXvtUv8Wv
         jsl+QYF967v94rD1iOqlmd8WDBTfo7YsOmIQLBuxdeAsQz1qI0dhUFzOtv67ghiWnKzw
         2SaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691649198; x=1692253998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYK3gBdbZNa0sNOQK67Ss/5e2crqIr7FWYCpvQqQW+g=;
        b=j2eWjoUd0vKtAcEn0lUpWp6g+4hK81zo1Pk4V15aDXYPUgeKGFokCvlOguI7Rqr9Gk
         d5iaqf+T+SNFYCjcM7xKSzdQXRJl/D1RiI5s28eT0Evy1sdgz1VSilas562rv91cRFKV
         Ain60G9k5vvYaNz9FgIZahmsu/pgg4xTa8z2ztctmY+8QTmJ8jpXgiinz2VFXlkPQtKI
         ERWOkvVpgMg/2+IGuKbXD6ZNdNMcsaEd8NrmYbxEUJQePSn4t9POUUyj79IxebFQEI68
         LmhUBNBLPFfl9nRxKIYPFMqr42cR7YaryLX6HYhRot1xbKjVOBYi+BxXieeW7L+uycmG
         0bdw==
X-Gm-Message-State: AOJu0Yy2+8S9xtlLbQ0umJuAWeAtiAttOKAZVfq8winrDmgkQuOVN++T
        NNK57zHjT94DVK7ncVSliJJBsg==
X-Google-Smtp-Source: AGHT+IFqfz82dC6HvQTaxglBx3yT9S64xVlc1ywkXQiWNswPweX3dARtW7q3pPyLGsgAYz8OCa/Z+A==
X-Received: by 2002:a2e:9a84:0:b0:2b6:df71:cff1 with SMTP id p4-20020a2e9a84000000b002b6df71cff1mr1059849lji.52.1691649198267;
        Wed, 09 Aug 2023 23:33:18 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003fe2b6d64c8sm4020018wmc.21.2023.08.09.23.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 23:33:17 -0700 (PDT)
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
Subject: [PATCH v2 07/11] ASoC: samsung: odroid: use of_property_present to check for property
Date:   Thu, 10 Aug 2023 08:32:55 +0200
Message-Id: <20230810063300.20151-7-krzysztof.kozlowski@linaro.org>
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

"samsung,audio-widgets" and "samsung,audio-routing" are not boolean
properties, thus more appropriate is to use of_property_present() to
check if they are present.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/samsung/odroid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/odroid.c b/sound/soc/samsung/odroid.c
index a5442592bde4..1743bd55ba1a 100644
--- a/sound/soc/samsung/odroid.c
+++ b/sound/soc/samsung/odroid.c
@@ -223,14 +223,14 @@ static int odroid_audio_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	if (of_property_read_bool(dev->of_node, "samsung,audio-widgets")) {
+	if (of_property_present(dev->of_node, "samsung,audio-widgets")) {
 		ret = snd_soc_of_parse_audio_simple_widgets(card,
 						"samsung,audio-widgets");
 		if (ret < 0)
 			return ret;
 	}
 
-	if (of_property_read_bool(dev->of_node, "samsung,audio-routing")) {
+	if (of_property_present(dev->of_node, "samsung,audio-routing")) {
 		ret = snd_soc_of_parse_audio_routing(card,
 						"samsung,audio-routing");
 		if (ret < 0)
-- 
2.34.1

