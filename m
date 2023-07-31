Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC60D769203
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjGaJn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjGaJno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:43:44 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285AFE68
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:43:26 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso566547266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690796605; x=1691401405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wru1VW4ElNQWwbcOi9qEWUoTt9rJrkxi91n6SS30Eys=;
        b=cQcWGSDwLdxq6R599X8W8DBqRHuUQ8TLEqRJdVpH+ad9PFCr2UnbMtcYleek6ZoOCI
         FVRgDKR2kHfjVYGCLkcl/rAZAB22kuyPcohETwQdscluc5L9m05Jff7UIqxl5a1qyQcb
         x7uikvpX2QobNa8Vem/M/kyHaCVV0ietA89zOVLby2150vsXNHLnCqtl3Nt4cQat43Oi
         8weD//QJ47qnCd2XAIV6nxsKkjeO4rynyJnz3TYOg1INHmHjLs1+rauPrfuvxY/rdY7x
         QMSjMpmzmchtdKaS/mVJwQNk/0wMuEP7pvgeaIII9ibFlpr3OhRiz4yW/S9tJuPIuvuQ
         WDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690796605; x=1691401405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wru1VW4ElNQWwbcOi9qEWUoTt9rJrkxi91n6SS30Eys=;
        b=VNLQCA8MiTdGVUygd+/Y1W2O01Or+uHNOpTCzNd+144dt+zlHqQkk7D4JPNdzi4NIo
         iyUcMZ7CePhlcyp2VNcqmpVeuUcYbkHHxxOZFXVxfies6HFwK+krC3VLa/CWmv3X1PQq
         38ZPe8UO+SxdYq5G9F6FxRuLtxarw2yWNr7wYu+dIW+cjhUnrENjPupWDTyR7K3hw8bE
         pkcfjxokjn2AymqI/vL7imddcjBaV+13ftEO3OCqBgDCLzBmTFftDcBbQwTJgCs9FsoB
         Vz71Jr2OxKcueqzI0lvhszg8TBFe2F8+UaU72RPKcJxwtWsnZdkBkVr667Rgb+4dt7iP
         ajKg==
X-Gm-Message-State: ABy/qLbnJYnb/05F3VtujrIOvRRF7bMMoWrOa4LlIM7Y6cw2639TJ/ZK
        GcEsYRBbHKgLHmiHG5yAs1PrKQ==
X-Google-Smtp-Source: APBJJlFAH+HzXe9+VU+AK4McGXrg3AZIuVNaeiawk99F4JSYDsrh1HQUKcYS9HIu77uxpXdoyHV5Sw==
X-Received: by 2002:a17:906:7397:b0:99b:6c47:1145 with SMTP id f23-20020a170906739700b0099b6c471145mr6069053ejl.32.1690796605096;
        Mon, 31 Jul 2023 02:43:25 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id z17-20020a170906815100b0099bcdfff7cbsm5867547ejw.160.2023.07.31.02.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:43:24 -0700 (PDT)
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
Subject: [PATCH 05/12] ASoC: dt-bindings: samsung,midas-audio: use common sound card
Date:   Mon, 31 Jul 2023 11:42:56 +0200
Message-Id: <20230731094303.185067-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731094303.185067-1-krzysztof.kozlowski@linaro.org>
References: <20230731094303.185067-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reference the common sound card properties and deprecate the
custom "samsung,audio-routing" in favor of generic one.  This allows to
remove "model" property and make the binding closer to other sounds
cards.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/sound/samsung,midas-audio.yaml      | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml b/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml
index 31095913e330..6ec80f529d84 100644
--- a/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml
+++ b/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml
@@ -9,14 +9,13 @@ title: Samsung Midas audio complex with WM1811 codec
 maintainers:
   - Sylwester Nawrocki <s.nawrocki@samsung.com>
 
+allOf:
+  - $ref: sound-card-common.yaml#
+
 properties:
   compatible:
     const: samsung,midas-audio
 
-  model:
-    $ref: /schemas/types.yaml#/definitions/string
-    description: The user-visible name of this sound complex.
-
   cpu:
     type: object
     additionalProperties: false
@@ -38,6 +37,7 @@ properties:
       - sound-dai
 
   samsung,audio-routing:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/non-unique-string-array
     description: |
       List of the connections between audio components; each entry is
@@ -45,6 +45,7 @@ properties:
       being the connection's source; valid names for sources and sinks are
       the WM1811's pins (as documented in its binding), and the jacks
       on the board: HP, SPK, Main Mic, Sub Mic, Headset Mic.
+      Deprecated, use audio-routing.
 
   mic-bias-supply:
     description: Supply for the micbias on the Main microphone
@@ -62,14 +63,13 @@ properties:
 
 required:
   - compatible
-  - model
   - cpu
   - codec
-  - samsung,audio-routing
+  - audio-routing
   - mic-bias-supply
   - submic-bias-supply
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
@@ -84,7 +84,7 @@ examples:
         mic-bias-supply = <&mic_bias_reg>;
         submic-bias-supply = <&submic_bias_reg>;
 
-        samsung,audio-routing =
+        audio-routing =
                 "HP", "HPOUT1L",
                 "HP", "HPOUT1R",
 
-- 
2.34.1

