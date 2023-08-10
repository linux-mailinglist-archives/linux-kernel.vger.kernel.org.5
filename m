Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634AD777064
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 08:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjHJGdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 02:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbjHJGdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 02:33:10 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA582E5B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 23:33:07 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe4a89e7efso4357365e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 23:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691649186; x=1692253986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRK4u/u6GjShtJ9g8bcUM1XPaEOsUKZUUqbfqiifYIs=;
        b=EKOLsf+ykA5qIQjzzOus1wbbzFq81JXaJvdLkG0mm3Ei/C2xTDE/Wu8pEO3Adhv1sB
         a8fYpYw1hxGihI1MFUifamdPmJH45ZV8HDggIKT3v396ZMr2JyDRdg4/D9PmrKPpCvPL
         8EA8uAJyzKgvFa/yGogo535vvEIkekTvq5q7u0arTD8e0FY1RGFxH2bC/gCqRI9mbS9Z
         aXWnnIogjDkXyOz9T65Ds170m+XMLrSZ4mQOUEJGTsXUZGNMpMsdTEyBALGWponNQ0nj
         a+D3erhbaW+s3A1Ll/jbyvpMMzlDhOPzMTwzJf18WEgJkTn53cmJNV7nVbKISH4GEA3+
         zMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691649186; x=1692253986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRK4u/u6GjShtJ9g8bcUM1XPaEOsUKZUUqbfqiifYIs=;
        b=EcFuh/U6mwrhsaFJTmpFMHR5FsPlA+lGfaEcDaDstujgwxIi0WlrZEcLdfONc8Qu3/
         x+7lieKtkcnwsZ1SreJKx6m/cch8Ay/uBEiYYKxtmyjvX0YLPKd+w61KAK9gVgLGHYHy
         ysoEY6bIBzC2zBShaFlugc62c6Z4mEcpBoymtGQkYqzfZErTkf0w6MEyg8QELYScD7uR
         OZVZDzZz3D8poGbHlQGoSWfx1RGJjUAKJoFTjuQG/fnj1zYZJyst53BN0YRGzzSyjk+e
         AUF6JdvErdBSjO7mXAXGWbKKGW+WudKBfUpMr8ajAwuvx09H6KxBQnHHOqyz92dUXcy5
         GY9A==
X-Gm-Message-State: AOJu0Yyi9WucAptx3Od8uvFiOHzfPFYm2ePLEhYhItzb56Tdnsbvayik
        icK2AxrZDZfCC4uP5iDeQ9MWRw==
X-Google-Smtp-Source: AGHT+IF3jK0RC64l2dE7mBJal346hXqt7G4hF0HjJMrFLuF9HMUsWWO06rStb8U1TvYEIzfEW6pMQQ==
X-Received: by 2002:a1c:4b0a:0:b0:3fe:212c:f790 with SMTP id y10-20020a1c4b0a000000b003fe212cf790mr962281wma.36.1691649186466;
        Wed, 09 Aug 2023 23:33:06 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003fe2b6d64c8sm4020018wmc.21.2023.08.09.23.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 23:33:05 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 02/11] ASoC: dt-bindings: mediatek,mt8188-mt6359: use common sound card
Date:   Thu, 10 Aug 2023 08:32:50 +0200
Message-Id: <20230810063300.20151-2-krzysztof.kozlowski@linaro.org>
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

The mediatek,mt8188-mt6359 Linux sound machine driver requires the
"model" property, so binding was incomplete.  Reference the common sound
card properties to fix that which also allows to remove duplicated
property definitions.  Leave the relevant parts of "audio-routing"
description.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/sound/mediatek,mt8188-mt6359.yaml  | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
index 05e532b5d50a..43b3b67bdf3b 100644
--- a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
@@ -9,23 +9,19 @@ title: MediaTek MT8188 ASoC sound card
 maintainers:
   - Trevor Wu <trevor.wu@mediatek.com>
 
+allOf:
+  - $ref: sound-card-common.yaml#
+
 properties:
   compatible:
     enum:
       - mediatek,mt8188-mt6359-evb
       - mediatek,mt8188-nau8825
 
-  model:
-    $ref: /schemas/types.yaml#/definitions/string
-    description: User specified audio sound card name
-
   audio-routing:
-    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
     description:
-      A list of the connections between audio components. Each entry is a
-      sink/source pair of strings. Valid names could be the input or output
-      widgets of audio components, power supplies, MicBias of codec and the
-      software switch.
+      Valid names could be the input or output widgets of audio components,
+      power supplies, MicBias of codec and the software switch.
 
   mediatek,platform:
     $ref: /schemas/types.yaml#/definitions/phandle
@@ -86,7 +82,7 @@ patternProperties:
     required:
       - link-name
 
-additionalProperties: false
+unevaluatedProperties: false
 
 required:
   - compatible
@@ -96,6 +92,7 @@ examples:
   - |
     sound {
         compatible = "mediatek,mt8188-mt6359-evb";
+        model = "MT6359-EVB";
         mediatek,platform = <&afe>;
         pinctrl-names = "default";
         pinctrl-0 = <&aud_pins_default>;
-- 
2.34.1

