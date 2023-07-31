Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED03D769201
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjGaJnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbjGaJn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:43:28 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC78F10D5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:43:23 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bcf2de59cso687499966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690796602; x=1691401402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Vd2V8E3DB7z7kEvHV823551js9h9Apx/nKUpTAbbk0=;
        b=cVfLolvoYQFivQtun6RFjLWCxlxVEXn4VFabZs/4FJ357EbhrsHgVX9Sxi6T9gMYYS
         eyn/2o6gLXNpLk7pu0Hyc+kiXAA/1WqneNKhJo3fTb2QJ48tykBm3CEJygbTAAtyOJpO
         LKaNyPtg/44/gJJ/pgQVxajd4jDKTqOUeOtV/oR13z2aQ6jQl/VFTR+o99HNg/7nqZqI
         ASN5wVEIJGYtbU8l799jjI/+q1y7WcxjAi1iKiCB/oRHa75zbfwpS+W3iWxZ2qv7/1yx
         iuEiJsyHYWnf43/269BrkcDjxyReyKVi+YpxnCvwQqlwDwwuzO/WhTATgrXB4UmN81BK
         eOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690796602; x=1691401402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Vd2V8E3DB7z7kEvHV823551js9h9Apx/nKUpTAbbk0=;
        b=i8tLcVdsAsH2Ef1U4Cw7sAkjedTbgJN9gL33iWi2Myokhm+ML61qK5UK14FOvgDpcz
         0H61y/oUHQQwUL5g7wInpySooA4HPbb4zyHc3K2VeRQx/OA8Ywzui52PTvWQRn2O2Wwh
         thB9M6hqfJqA8dT+547+zRtLUb09tnRZLuL7LGl5sLst+dMZC2rLia/j3qnRovi2kNjE
         r6Z4ev6QccxR0Gcc1boJlRFEbjrqwkmuR2Kp7miE53VdRB6hOGHcqU7L7fzMqQyrj/i7
         /B6WJzWduApxh2+/2ZvC5zIIG8CiTVj5CrFeptj5gw2GU07Qb8IcRADgw07Rfeg2/14P
         DsmA==
X-Gm-Message-State: ABy/qLZX0SAuUaWvc5hUJ0XKQF5D1YaFqeQzJx7T0nkPoHZ6OyNQG7Qd
        P7+JAgRue7DY342gXVzXZSDnHA==
X-Google-Smtp-Source: APBJJlHDwXOgJtQLI73QXcvqo/WffZBIS9gmKGKdfzbOS8PNioPjtmvyx8qIi4hFsHUaY2kjvho8ig==
X-Received: by 2002:a17:906:8a63:b0:993:da87:1c7b with SMTP id hy3-20020a1709068a6300b00993da871c7bmr6154064ejc.10.1690796602231;
        Mon, 31 Jul 2023 02:43:22 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id z17-20020a170906815100b0099bcdfff7cbsm5867547ejw.160.2023.07.31.02.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:43:21 -0700 (PDT)
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
Subject: [PATCH 04/12] ASoC: dt-bindings: samsung,aries-wm8994: use common sound card
Date:   Mon, 31 Jul 2023 11:42:55 +0200
Message-Id: <20230731094303.185067-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731094303.185067-1-krzysztof.kozlowski@linaro.org>
References: <20230731094303.185067-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 .../bindings/sound/samsung,aries-wm8994.yaml     | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/samsung,aries-wm8994.yaml b/Documentation/devicetree/bindings/sound/samsung,aries-wm8994.yaml
index 447e013f6e17..5ea0819a261a 100644
--- a/Documentation/devicetree/bindings/sound/samsung,aries-wm8994.yaml
+++ b/Documentation/devicetree/bindings/sound/samsung,aries-wm8994.yaml
@@ -9,6 +9,9 @@ title: Samsung Aries audio complex with WM8994 codec
 maintainers:
   - Jonathan Bakker <xc-racer2@live.ca>
 
+allOf:
+  - $ref: sound-card-common.yaml#
+
 properties:
   compatible:
     enum:
@@ -17,10 +20,6 @@ properties:
       # Without FM radio and modem slave
       - samsung,fascinate4g-wm8994
 
-  model:
-    $ref: /schemas/types.yaml#/definitions/string
-    description: The user-visible name of this sound complex.
-
   cpu:
     type: object
     additionalProperties: false
@@ -46,6 +45,7 @@ properties:
 
   samsung,audio-routing:
     $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    deprecated: true
     description: |
       List of the connections between audio
       components;  each entry is a pair of strings, the first being the
@@ -56,6 +56,7 @@ properties:
       or FM In
       For samsung,fascinate4g-wm8994: HP, SPK, RCV, LINE, Main Mic,
       or HeadsetMic
+      Deprecated, use audio-routing.
 
   extcon:
     description: Extcon phandle for dock detection
@@ -87,10 +88,9 @@ properties:
 
 required:
   - compatible
-  - model
   - cpu
   - codec
-  - samsung,audio-routing
+  - audio-routing
   - extcon
   - main-micbias-supply
   - headset-micbias-supply
@@ -98,7 +98,7 @@ required:
   - headset-detect-gpios
   - headset-key-gpios
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
@@ -121,7 +121,7 @@ examples:
         headset-detect-gpios = <&gph0 6 GPIO_ACTIVE_HIGH>;
         headset-key-gpios = <&gph3 6 GPIO_ACTIVE_HIGH>;
 
-        samsung,audio-routing =
+        audio-routing =
             "HP", "HPOUT1L",
             "HP", "HPOUT1R",
 
-- 
2.34.1

