Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E6876920D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjGaJoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjGaJnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:43:49 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE33E78
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:43:33 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5221f3affe4so5795864a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690796611; x=1691401411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDlAiDCsa5OyQV1o1rM++WZe4Dne9dcJk7rWwMzlcwg=;
        b=uoOLAF+GuBMic8HTce18DnIFS64ebzdbM2EqcooL5fF8d9NfvcCA2EsZ9DH2ZW+2vq
         JAp06pifF/KwIrU7D2KX8hkW4YFSelrfKCthdZrMTpunL77cpbWyXm7pOLULH0GbcxsX
         xiGijdmOXAIqny29Ln1PeOYEQvyoBdFfNos/61um7aaWB8N4/9CaNnAQ+vDzK86Ca0+i
         8xVL7FLjTyEhrNWZ6/XSYwCLys8HXLJzXe9pUTeonmVyQjCleDAUC2I8tt4UfyKx/WJh
         RPgBvG90IsjMLgdDH68+yzCieqA443GpBQOUDy+dJbCx0b2NhnHhyMdTyccm7P4UxJRt
         7VFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690796611; x=1691401411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDlAiDCsa5OyQV1o1rM++WZe4Dne9dcJk7rWwMzlcwg=;
        b=Eo6U5lrYkUP25x9AQHfrTfbhqUlaqRpeVF+UMSZo1c4MEtBRdnJiLNOkifsRVxfikt
         R4xPkiG9mRSpnTCj95Bronn5ck0dDJY3/zxLo/TpvPLOZCbrgJ2KBWi7UWVpwM5bVMeJ
         utxfdaEqkUbmcC55M7bI5d2Ooa+tnM29vZRk0D7EKQF1sdPO172WSFFp7F/0K+AKn2JI
         4nNpMBM1nYsgPw7HfxGMwdtbzQd3Jzilg9+cTO4WM6NcUUdNPwpDN/eGWh6dVQg8Spsa
         URdh6xeJpXk/k07FXAhgdfXxonNHctJ9OwBU1L9/SrW6Wioo9TeZEmN6kfNgKZSRMhNJ
         FVwg==
X-Gm-Message-State: ABy/qLbWzipsajnK47omohivD1cTCAddAW82/Zi2YWjqNQKGLEjUp68Q
        eLQw0ATKIsETd/FH47SbDkcuFQ==
X-Google-Smtp-Source: APBJJlHPZE8l2UiavjYohAlal1BncG7+low027lOhN5gE0MMRSv0AOJLmfRkvZE/XcvYn+EHfGTb/A==
X-Received: by 2002:a17:907:2c77:b0:993:d75b:63ea with SMTP id ib23-20020a1709072c7700b00993d75b63eamr5408717ejc.16.1690796610988;
        Mon, 31 Jul 2023 02:43:30 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id z17-20020a170906815100b0099bcdfff7cbsm5867547ejw.160.2023.07.31.02.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:43:30 -0700 (PDT)
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
Subject: [PATCH 07/12] ASoC: dt-bindings: samsung,tm2: use common sound card
Date:   Mon, 31 Jul 2023 11:42:58 +0200
Message-Id: <20230731094303.185067-8-krzysztof.kozlowski@linaro.org>
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
 .../devicetree/bindings/sound/samsung,tm2.yaml   | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/samsung,tm2.yaml b/Documentation/devicetree/bindings/sound/samsung,tm2.yaml
index 491e08019c04..760592599143 100644
--- a/Documentation/devicetree/bindings/sound/samsung,tm2.yaml
+++ b/Documentation/devicetree/bindings/sound/samsung,tm2.yaml
@@ -10,6 +10,9 @@ maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
   - Sylwester Nawrocki <s.nawrocki@samsung.com>
 
+allOf:
+  - $ref: sound-card-common.yaml#
+
 properties:
   compatible:
     const: samsung,tm2-audio
@@ -32,6 +35,8 @@ properties:
       being the connection's source; valid names for sources and sinks are the
       WM5110's and MAX98504's pins and the jacks on the board: HP, SPK, Main
       Mic, Sub Mic, Third Mic, Headset Mic.
+      Deprecated, use audio-routing.
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/non-unique-string-array
 
   i2s-controller:
@@ -44,20 +49,15 @@ properties:
   mic-bias-gpios:
     description: GPIO pin that enables the Main Mic bias regulator.
 
-  model:
-    description: The user-visible name of this sound complex.
-    $ref: /schemas/types.yaml#/definitions/string
-
 required:
   - compatible
   - audio-amplifier
   - audio-codec
-  - samsung,audio-routing
+  - audio-routing
   - i2s-controller
   - mic-bias-gpios
-  - model
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
@@ -70,7 +70,7 @@ examples:
         audio-amplifier = <&max98504>;
         mic-bias-gpios = <&gpr3 2 GPIO_ACTIVE_HIGH>;
         model = "wm5110";
-        samsung,audio-routing = "HP", "HPOUT1L",
+        audio-routing = "HP", "HPOUT1L",
                                 "HP", "HPOUT1R",
                                 "SPK", "SPKOUT",
                                 "SPKOUT", "HPOUT2L",
-- 
2.34.1

