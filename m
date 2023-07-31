Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BD17691FF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjGaJnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjGaJnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:43:25 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DBF1B6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:43:21 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so11511839a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690796599; x=1691401399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMkdpsehTQiUEk5WvbiE/NK1y+1H3B3yrpjwlG6gOYw=;
        b=tn4w2YQmJTk0uY8ChJCamrtd1NcK7DH3BQF48MS47k8eGNen03b0H8BrqpxyZcEvWK
         TPXsdcjEnmC3fTAo3UDqvw+henD34TO1onisgORuIUrwequZeMPv+n4uHfY13ORotoiv
         rLN4hAb0lP69zVN/jHC6pzdlKqoort8C/+dXokjQYsHxgXt3tOsQCl2anHisRU5ep80I
         RwGS8Pj1HR0lFBDLxSDNQeJZ/KbUg1sttYQb4MsMbazqmlM2tlYaauEfC/Z/7ycQHL+i
         b7Tpp2/WI5HuL5GbF+kt7pzxeXCyFL3aUWSs5UGq6gO8A6RiVb4h03SE/3b8kEceXusx
         XMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690796599; x=1691401399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMkdpsehTQiUEk5WvbiE/NK1y+1H3B3yrpjwlG6gOYw=;
        b=DBX257WYLu3XqWe2Oua8DL4OeIxsa+nEbFTjNyWR7SU3Xt3c9X3Beif8R0KO+YL7nS
         To1LZ9EuMV+++279QS/Td2VMGyKpfc2I0eTJjvmWfgT3ddRpSiFedsN2+SFZ/Z6gqaIK
         hYbH2jTZ2s59uWiYSrgd85LWHs9k1OzhEcVZWg9O0glDF/4yzyPovQhKpVSmkmXFiZKZ
         cbCT0unABorhsdBL98ZmHz03ZoMNsPVtb77jrd+BIpljVu6oeduT/WfJA7Q2OYzE4rhD
         wHB07p7qBUoWWBsxjyuqTwoOayKJTGuRtYrzoy9tgRCtHFjCKmzecNy2q4iQ5OL/aX4n
         gepw==
X-Gm-Message-State: ABy/qLbSPEOBY1BDKJzets+4iQDYOQ4PH43EFUbQrMKZ2uydBjxlis/q
        7j1mVY5NhDTYUGHTU5xQumRlMQ==
X-Google-Smtp-Source: APBJJlEHS8HRS+DJX1TaYBtav0YDH5TTIyB34YjlvE4tjVqyDckc7nADYmMtp8qDuz0QDDXeqOSJhQ==
X-Received: by 2002:a17:906:309b:b0:993:da87:1c81 with SMTP id 27-20020a170906309b00b00993da871c81mr6791657ejv.20.1690796599396;
        Mon, 31 Jul 2023 02:43:19 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id z17-20020a170906815100b0099bcdfff7cbsm5867547ejw.160.2023.07.31.02.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:43:19 -0700 (PDT)
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
Subject: [PATCH 03/12] ASoC: dt-bindings: mediatek,mt8188-mt6359: use common sound card
Date:   Mon, 31 Jul 2023 11:42:54 +0200
Message-Id: <20230731094303.185067-4-krzysztof.kozlowski@linaro.org>
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

The mediatek,mt8188-mt6359 Linux sound machine driver requires the
"model" property, so binding was incomplete.  Reference the common sound
card properties to fix that which also allows to remove duplicated
property definitions.  Leave the relevant parts of "audio-routing"
description.

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

