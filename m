Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E0B77706A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 08:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjHJGd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 02:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbjHJGdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 02:33:21 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A652106
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 23:33:17 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe1489ced6so791406e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 23:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691649196; x=1692253996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swPZatRmU5IAV5ZeCQ4kXkKbN4f+jKft+68xvypLEqM=;
        b=LsM/h3KPobzkTcoOxI5RPb0T84ud0ZGa4N6jmsjPveiCQzV7GU6U3za5q2AyO4B+5n
         wo+am54GWZdmEQr7eZszZcWrHM3Xd2eu3AQfdqqekomh4lTA7GwaFrZBJw9iaTmYenmS
         N9vy8Kgq357VzueL7xAclqjL1GRsGamNq57RexwJV8w8/d6hWz9J9vcqxzQ9nkGbuR4M
         MNxVek3Fl72nyvkPUlRrBizy1HpDb9unAgTEwUnaWQ4MYuoI9oA1svnj3wqg/G7/3iJA
         IBhXL09whKGx2e5We4vwU1V1BFTHYcs0bXXhIPRz/tROEOoMjMtQtvpZ27Wa/0hxEud1
         8kSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691649196; x=1692253996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swPZatRmU5IAV5ZeCQ4kXkKbN4f+jKft+68xvypLEqM=;
        b=Sm23cJpKnFw8Iej8HvHfHMvfZYaix2xAfD+3iDFzpeFHIhb8G+ZDkD4NEgqmpwuya2
         Ea1vccI33XojgEXyEhgqhnUgx9tNETA8iDnC0jUsbAQ1JSo/BVCsNCMGNfDEqhm3aUi0
         jTYa38jUa/vjIK8ET1uTh0wgJKNFmDnrBYcHebZa9WiDY7aWeZT2gPzyVG9gW5sIGizh
         Vi6pjjFS3axTGcvHbTPhBEyn9vYrMlef8pzij9EZMxHWLxVn1oyzXae3ovrrVzdRGouf
         04+e9KPII4Bq1qloYojbo8jVZ+PjAyfI0QVfdalY2OfJJ7xGJ5TF5uF0l2qbQuJs9840
         TyRQ==
X-Gm-Message-State: AOJu0YzNjJrhkLB/ABRTba/94rW9QOIT/dgl4e4DkJuc1hLUGmMyOQu/
        PQ09LREpOWOVNdOu8wKU183q+g==
X-Google-Smtp-Source: AGHT+IFSMwcqRWrUYV9irC56xpJoWb74ftanQaLP6RyThzYdg+w2lYlHHTaLxfomYlbHvWOWiHg8fw==
X-Received: by 2002:a05:6512:3e1f:b0:4fe:5795:35ed with SMTP id i31-20020a0565123e1f00b004fe579535edmr1082315lfv.6.1691649195909;
        Wed, 09 Aug 2023 23:33:15 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003fe2b6d64c8sm4020018wmc.21.2023.08.09.23.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 23:33:15 -0700 (PDT)
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
Subject: [PATCH v2 06/11] ASoC: dt-bindings: samsung,tm2: use common sound card
Date:   Thu, 10 Aug 2023 08:32:54 +0200
Message-Id: <20230810063300.20151-6-krzysztof.kozlowski@linaro.org>
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

Reference the common sound card properties and deprecate the
custom "samsung,audio-routing" in favor of generic one.  This allows to
remove "model" property and make the binding closer to other sounds
cards.

Reviewed-by: Rob Herring <robh@kernel.org>
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

