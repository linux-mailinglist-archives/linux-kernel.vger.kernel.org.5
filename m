Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF54F769210
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjGaJo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbjGaJn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:43:58 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D4C19B0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:43:36 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso2663597e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690796614; x=1691401414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYK3gBdbZNa0sNOQK67Ss/5e2crqIr7FWYCpvQqQW+g=;
        b=vGH2+BfyMZGVx2Mz2PghzNpH2Lq5fZhfgnQWWX6qIyUW7F+xe7yVIUgCvVGyO2jckw
         IhVxKo6jzyu9LgUCN+ZkGVOY3UHU4c4kbWcOCmwgeznYnO1nOX9iM1Y3SavG9vo56r1f
         nn7SRqa4w7Ohzz1EhhcN7Yn4waZCQTbIO24AlLB/qebcEymJ5BDEAUtGPxbKWlpvi1WV
         PPsNZXmmo8fZyOp4mM3g+ki5WCAgos85P6XQHdI3mYj/xUUWdl8B4HGsKc4k8TrR3JXv
         cgvoMuxzaih01U5doR1E2cYbIexG8RsB0ECGoC4deTSNRX89YVXAOyf5eX+pNR9Kz+7X
         dYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690796614; x=1691401414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYK3gBdbZNa0sNOQK67Ss/5e2crqIr7FWYCpvQqQW+g=;
        b=iSFPIgqh67+nu0fuioCTV5RsQC63aURjuKe7DR1AFSaxvKXDQ5BmCmSI5rfMQ5FPP0
         YObcWjEvROGS6M4DUweM/LXZfn4c7K6fRVs7oTKkSep3FCLzHkRbsOPZWg1uTLOgA3ng
         3jRWTH08ZtzeLABBpcxVPGsLpmaCB9lb679oEoglXGONsFTv6aVUhRgASVzfQ9HbAIdw
         1hWLyDHFqJWF0hiEw+/wnrwOCQncYVaaVmwH+Bqnh9JqFyMzKCmz23FONzWHsBBHz9gO
         7pM7LdDAwTtZdU4AlfGmN6IAKYXR62LyxIYQPBIEhOHlc2dbklwyXviSWNLuLr9FMj8W
         Zekg==
X-Gm-Message-State: ABy/qLao6MRdPTgkCsYbYA9WfzpbhWRoqs39Jn+ecYFz1SNeN3L+vFUm
        BQnQj4SoRfmnkF2D/OwNC/H7zg==
X-Google-Smtp-Source: APBJJlFi4tF2DDSDAGSo3/0U9Umv+lZh1Ow6pAepScqbXZ2BXO/rwOwioy/FJVCRSkz8wfIlGQX0uQ==
X-Received: by 2002:a05:6512:2399:b0:4f8:77f1:299a with SMTP id c25-20020a056512239900b004f877f1299amr6925105lfv.42.1690796613836;
        Mon, 31 Jul 2023 02:43:33 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id z17-20020a170906815100b0099bcdfff7cbsm5867547ejw.160.2023.07.31.02.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:43:33 -0700 (PDT)
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
Subject: [PATCH 08/12] ASoC: samsung: odroid: use of_property_present to check for property
Date:   Mon, 31 Jul 2023 11:42:59 +0200
Message-Id: <20230731094303.185067-9-krzysztof.kozlowski@linaro.org>
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

