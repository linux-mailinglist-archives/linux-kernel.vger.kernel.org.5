Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F307691FE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjGaJnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjGaJnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:43:22 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FDFE5F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:43:18 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bcc0adab4so686054466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690796597; x=1691401397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEyaJ9DgVVV+c0AfkmYQXBEqJGJ4zcTJQzB2dw0oboM=;
        b=fa448jy2NEUSDchmC0NYC0WDxE7amKdAbkuR5jMOBA7yla1ux1uwVBrMdSf8p/vREI
         JGf8aI5ZKzEnMUBVnSDeY5h2pzFzV2z5IXU7wZViic7SnYEXOswDmrh4oRO/VqH9zwHX
         jEalJU0lK+OnevuFMp7hgme8i3MmVw5smAsSxG5hzM2ddNj6AXrd6AFALNnNqdMkANGh
         nvMZ2CtB/Mz3ScvUWLTxMwHd0O+DOGgz7Wbjk54ucaXh1nQAtT3z4dhRz95TVGoc9vg9
         pzwdlcOAwz1Bk/qjcUgqL/gcGvYEVZdF9OhytMjuepTo1JK4rgtUaKnYznZz66jfOE3G
         CNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690796597; x=1691401397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEyaJ9DgVVV+c0AfkmYQXBEqJGJ4zcTJQzB2dw0oboM=;
        b=Iu5GQQLk4hVcw+1eHSsXEwLHDAQoR8BfK9yGKrxm+tDHNt5aT/vyyxU/ziyvDZ0bnv
         3HD0N959mUC7USmhPjno4u4gn19SXqGJMmp8zWv8/uuLPC5z1dkhYgc9pLGXaPD/0OmB
         s15ZzeiNyJzg6fqlI3usFWtWUrp9wXeBqYtb1gppxfODIrtwzu/ziMbnWVLd4gDaYM6D
         npF4FUzbiaPsp0DjIGeXbBrmn+T9gD1xxUemjRqPTJ3GNn83USyEu19BRLQNriMikexw
         poqOp8tq0HUjqnneYO8XwR4pZ60BxqHePorf++8U/LZiepuXMbRh8+y51/1jq0d+d9GS
         UWUQ==
X-Gm-Message-State: ABy/qLY9yJ1FbsZmPmajNSOftn87gz3qW7FZtCYjvaeRdoeWHQ/HX2lZ
        A+Lc6C+ZuGhSAz3DUMdC7Xqg5w==
X-Google-Smtp-Source: APBJJlExPjonnH5U7Bei0/nN+O3jQbS4RoPQEJuS00211nRnG7KjBF6o4HXYh3QZ/49/ezQIOr3+Aw==
X-Received: by 2002:a17:906:2216:b0:99b:57f0:68b5 with SMTP id s22-20020a170906221600b0099b57f068b5mr6986441ejs.75.1690796596803;
        Mon, 31 Jul 2023 02:43:16 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id z17-20020a170906815100b0099bcdfff7cbsm5867547ejw.160.2023.07.31.02.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:43:16 -0700 (PDT)
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
Subject: [PATCH 02/12] ASoC: dt-bindings: Add common sound card properties
Date:   Mon, 31 Jul 2023 11:42:53 +0200
Message-Id: <20230731094303.185067-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731094303.185067-1-krzysztof.kozlowski@linaro.org>
References: <20230731094303.185067-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Almost every board machine / sound cards has "audio-routing" and "model"
properties, so move them to common schema to have only one definition of
these properties.

For amlogic,gx-sound-card, leave the "audio-routing" constraints in the
original binding.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../sound/amlogic,axg-sound-card.yaml         | 15 +++--------
 .../bindings/sound/amlogic,gx-sound-card.yaml | 14 +++-------
 .../devicetree/bindings/sound/fsl,rpmsg.yaml  | 17 +++---------
 .../bindings/sound/google,sc7180-trogdor.yaml | 17 +++---------
 .../sound/google,sc7280-herobrine.yaml        | 17 +++---------
 .../bindings/sound/imx-audio-card.yaml        | 18 +++----------
 .../bindings/sound/sound-card-common.yaml     | 27 +++++++++++++++++++
 7 files changed, 50 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/sound-card-common.yaml

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.yaml
index bf1234550343..5db718e4d0e7 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.yaml
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.yaml
@@ -9,6 +9,9 @@ title: Amlogic AXG sound card
 maintainers:
   - Jerome Brunet <jbrunet@baylibre.com>
 
+allOf:
+  - $ref: sound-card-common.yaml#
+
 properties:
   compatible:
     const: amlogic,axg-sound-card
@@ -17,23 +20,12 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     description: list of auxiliary devices
 
-  audio-routing:
-    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
-    description:
-      A list of the connections between audio components. Each entry is a
-      pair of strings, the first being the connection's sink, the second
-      being the connection's source.
-
   audio-widgets:
     $ref: /schemas/types.yaml#/definitions/non-unique-string-array
     description:
       A list off component DAPM widget. Each entry is a pair of strings,
       the first being the widget type, the second being the widget name
 
-  model:
-    $ref: /schemas/types.yaml#/definitions/string
-    description: User specified audio sound card name
-
 patternProperties:
   "^dai-link-[0-9]+$":
     type: object
@@ -108,7 +100,6 @@ patternProperties:
       - sound-dai
 
 required:
-  - model
   - dai-link-0
 
 unevaluatedProperties: false
diff --git a/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml b/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml
index 45d6202d9730..9c6c4c0fab88 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml
+++ b/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml
@@ -9,6 +9,9 @@ title: Amlogic GX sound card
 maintainers:
   - Jerome Brunet <jbrunet@baylibre.com>
 
+allOf:
+  - $ref: sound-card-common.yaml#
+
 properties:
   compatible:
     items:
@@ -19,13 +22,8 @@ properties:
     description: list of auxiliary devices
 
   audio-routing:
-    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
     minItems: 2
     maxItems: 32
-    description: |-
-      A list of the connections between audio components. Each entry is a
-      pair of strings, the first being the connection's sink, the second
-      being the connection's source.
 
   audio-widgets:
     $ref: /schemas/types.yaml#/definitions/non-unique-string-array
@@ -35,10 +33,6 @@ properties:
       A list off component DAPM widget. Each entry is a pair of strings,
       the first being the widget type, the second being the widget name
 
-  model:
-    $ref: /schemas/types.yaml#/definitions/string
-    description: User specified audio sound card name
-
 patternProperties:
   "^dai-link-[0-9]+$":
     type: object
@@ -88,7 +82,7 @@ required:
   - model
   - dai-link-0
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml b/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
index 6df0e03a1d4b..188f38baddec 100644
--- a/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
@@ -17,6 +17,9 @@ description: |
   such as SAI, MICFIL, .etc through building rpmsg channels between
   Cortex-A and Cortex-M.
 
+allOf:
+  - $ref: sound-card-common.yaml#
+
 properties:
   compatible:
     enum:
@@ -27,10 +30,6 @@ properties:
       - fsl,imx8ulp-rpmsg-audio
       - fsl,imx93-rpmsg-audio
 
-  model:
-    $ref: /schemas/types.yaml#/definitions/string
-    description: User specified audio sound card name
-
   clocks:
     items:
       - description: Peripheral clock for register access
@@ -66,13 +65,6 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: The phandle to a node of audio codec
 
-  audio-routing:
-    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
-    description: |
-      A list of the connections between audio components. Each entry is a
-      pair of strings, the first being the connection's sink, the second
-      being the connection's source.
-
   fsl,enable-lpa:
     $ref: /schemas/types.yaml#/definitions/flag
     description: enable low power audio path.
@@ -101,9 +93,8 @@ properties:
 
 required:
   - compatible
-  - model
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml b/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml
index ba5b7728cf33..bac940553965 100644
--- a/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml
+++ b/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml
@@ -13,23 +13,15 @@ maintainers:
 description:
   This binding describes the SC7180 sound card which uses LPASS for audio.
 
+allOf:
+  - $ref: sound-card-common.yaml#
+
 properties:
   compatible:
     enum:
       - google,sc7180-trogdor
       - google,sc7180-coachz
 
-  audio-routing:
-    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
-    description:
-      A list of the connections between audio components. Each entry is a
-      pair of strings, the first being the connection's sink, the second
-      being the connection's source.
-
-  model:
-    $ref: /schemas/types.yaml#/definitions/string
-    description: User specified audio sound card name
-
   "#address-cells":
     const: 1
 
@@ -86,11 +78,10 @@ patternProperties:
 
 required:
   - compatible
-  - model
   - "#address-cells"
   - "#size-cells"
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
 
diff --git a/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml b/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
index 0b1a01a4c14e..ec4b6e547ca6 100644
--- a/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
+++ b/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
@@ -13,22 +13,14 @@ maintainers:
 description:
   This binding describes the SC7280 sound card which uses LPASS for audio.
 
+allOf:
+  - $ref: sound-card-common.yaml#
+
 properties:
   compatible:
     enum:
       - google,sc7280-herobrine
 
-  audio-routing:
-    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
-    description:
-      A list of the connections between audio components. Each entry is a
-      pair of strings, the first being the connection's sink, the second
-      being the connection's source.
-
-  model:
-    $ref: /schemas/types.yaml#/definitions/string
-    description: User specified audio sound card name
-
   "#address-cells":
     const: 1
 
@@ -97,11 +89,10 @@ patternProperties:
 
 required:
   - compatible
-  - model
   - "#address-cells"
   - "#size-cells"
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
 
diff --git a/Documentation/devicetree/bindings/sound/imx-audio-card.yaml b/Documentation/devicetree/bindings/sound/imx-audio-card.yaml
index b6f5d486600e..f7ad5ea2491e 100644
--- a/Documentation/devicetree/bindings/sound/imx-audio-card.yaml
+++ b/Documentation/devicetree/bindings/sound/imx-audio-card.yaml
@@ -9,23 +9,14 @@ title: NXP i.MX audio sound card.
 maintainers:
   - Shengjiu Wang <shengjiu.wang@nxp.com>
 
+allOf:
+  - $ref: sound-card-common.yaml#
+
 properties:
   compatible:
     enum:
       - fsl,imx-audio-card
 
-  model:
-    $ref: /schemas/types.yaml#/definitions/string
-    description: User specified audio sound card name
-
-  audio-routing:
-    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
-    description:
-      A list of the connections between audio components. Each entry is a
-      pair of strings, the first being the connection's sink, the second
-      being the connection's source. Valid names could be power supplies,
-      MicBias of codec and the jacks on the board.
-
 patternProperties:
   ".*-dai-link$":
     description:
@@ -84,9 +75,8 @@ patternProperties:
 
 required:
   - compatible
-  - model
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/sound/sound-card-common.yaml b/Documentation/devicetree/bindings/sound/sound-card-common.yaml
new file mode 100644
index 000000000000..3a941177f684
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sound-card-common.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/sound-card-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Board Sound Card Common Properties
+
+maintainers:
+  - Mark Brown <broonie@kernel.org>
+
+properties:
+  audio-routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description: |
+      A list of the connections between audio components. Each entry is a
+      pair of strings, the first being the connection's sink, the second
+      being the connection's source.
+
+  model:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: User specified audio sound card name
+
+required:
+  - model
+
+additionalProperties: true
-- 
2.34.1

