Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A507F6E59
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344818AbjKXIiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKXIiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:38:03 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88E7D6C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 00:38:08 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a06e59384b6so177185466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 00:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700815087; x=1701419887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CYqzi/+XlQ/s+DJqiECuwYHNpVRCGbZDGfLfIlCHIxk=;
        b=b6SvHPkMkQgell54qC4wOZhJcYM2VQ17kjDJhwTJT0v3CLuGY1+6P9pBlYJjuTARUK
         2nq5tNdbcFez11QXjUa9xbVQyglAiOGlMwIIsfesLy3GX6HoBu1+ECheIN6qRZpLnRyY
         bC+PHSwZRH3xwPF+OgGA5wegoRVf0aCd60fCBUZcdgvDEvfUWEKcdSbUOwvDLR09WgEN
         9kHAbsZdws4NpHRvOtzK0FwPCnh4GW+En4NFITa77WLhRKQP7Qt9CJqNbAORr+zXRJNf
         W1PnlnCRCG3y6WbGgUziDgmPB0h+JAAJK/kK/orsNA2nD4wHIrw+i7TZSxuVbmve5z9k
         A5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700815087; x=1701419887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CYqzi/+XlQ/s+DJqiECuwYHNpVRCGbZDGfLfIlCHIxk=;
        b=KBFtb9rMGbVDIdKZugJUw3uUYZ7OSVs12fp5tA4AhO4fot4/wzX3YpIyJiUrLg1eCf
         dKERP8F1YjL3HD1u3LrxoG5nnLF4AzSbN570+34VDytzcLS54rk3iLyM1wea6YwJTyyt
         rDogJ3u3Ealgpc84TIkiKF1iDm6fBvNmU1xps6v/j2sSwRPNkYTIXzensb5PQxdvgogy
         M2/hdnw6oZNm+vQjLI+a9VEfzb88fBnY8muKKNrlaX/7DkdlVu3VckaRhuxy9pNYDFGu
         zUhMMWW/E9rl17P36kWGQaxvlaGerbnMNQUiiYWXcCtjI22fQlRM+4e6c4s2DuuNdY2W
         yQTQ==
X-Gm-Message-State: AOJu0YzZtyubIr8RHd5m+XO7xDLLzwfFm00iGK5B0qCGb44CrO32L6Vg
        VyT+pFp0168xOX9DvHmutYq7gw==
X-Google-Smtp-Source: AGHT+IE/6AvzGFpXeoUuooNv8Hkv3iVH5oo4ItGvDeCTDaiH0at3wQHZPjucHgaXdu9YSCtq8CFIyQ==
X-Received: by 2002:a17:906:2756:b0:9bd:9bfe:e40b with SMTP id a22-20020a170906275600b009bd9bfee40bmr1324090ejd.75.1700815087137;
        Fri, 24 Nov 2023 00:38:07 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id ks20-20020a170906f85400b009db53aa4f7bsm1781574ejb.28.2023.11.24.00.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 00:38:06 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Shenghao Ding <shenghao-ding@ti.com>,
        Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Seven Lee <wtli@nuvoton.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH] ASoC: dt-bindings: correct white-spaces in examples
Date:   Fri, 24 Nov 2023 09:38:03 +0100
Message-Id: <20231124083803.12773-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use only one and exactly one space around '=' in DTS example.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/sound/nuvoton,nau8821.yaml        | 2 +-
 Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml | 4 ++--
 .../devicetree/bindings/sound/qcom,wcd938x-sdw.yaml       | 4 ++--
 Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml | 4 ++--
 Documentation/devicetree/bindings/sound/renesas,rsnd.yaml | 8 ++++----
 .../devicetree/bindings/sound/ti,tlv320aic32x4.yaml       | 2 +-
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
index 3380b6aa9542..054b53954ac3 100644
--- a/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
+++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
@@ -135,7 +135,7 @@ examples:
             nuvoton,jack-insert-debounce = <7>;
             nuvoton,jack-eject-debounce = <0>;
             nuvoton,dmic-clk-threshold = <3072000>;
-            nuvoton,dmic-slew-rate= <0>;
+            nuvoton,dmic-slew-rate = <0>;
             #sound-dai-cells = <0>;
         };
     };
diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
index 4df59f3b7b01..beb0ff0245b0 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
@@ -201,9 +201,9 @@ examples:
   - |
     codec@1,0{
         compatible = "slim217,250";
-        reg  = <1 0>;
+        reg = <1 0>;
         reset-gpios = <&tlmm 64 0>;
-        slim-ifc-dev  = <&wcd9340_ifd>;
+        slim-ifc-dev = <&wcd9340_ifd>;
         #sound-dai-cells = <1>;
         interrupt-parent = <&tlmm>;
         interrupts = <54 4>;
diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml
index b430dd3e1841..7b31bf93f1a1 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml
@@ -51,7 +51,7 @@ examples:
         reg = <0x03210000 0x2000>;
         wcd938x_rx: codec@0,4 {
             compatible = "sdw20217010d00";
-            reg  = <0 4>;
+            reg = <0 4>;
             qcom,rx-port-mapping = <1 2 3 4 5>;
         };
     };
@@ -62,7 +62,7 @@ examples:
         reg = <0x03230000 0x2000>;
         wcd938x_tx: codec@0,3 {
             compatible = "sdw20217010d00";
-            reg  = <0 3>;
+            reg = <0 3>;
             qcom,tx-port-mapping = <2 3 4 5>;
         };
     };
diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
index 018565793a3e..adbfa67f88ed 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
@@ -137,7 +137,7 @@ examples:
         reg = <0x03210000 0x2000>;
         wcd938x_rx: codec@0,4 {
             compatible = "sdw20217010d00";
-            reg  = <0 4>;
+            reg = <0 4>;
             qcom,rx-port-mapping = <1 2 3 4 5>;
         };
     };
@@ -148,7 +148,7 @@ examples:
         reg = <0x03230000 0x2000>;
         wcd938x_tx: codec@0,3 {
             compatible = "sdw20217010d00";
-            reg  = <0 3>;
+            reg = <0 3>;
             qcom,tx-port-mapping = <2 3 4 5>;
         };
     };
diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
index 1174205286d4..0d7a6b576d88 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
@@ -497,19 +497,19 @@ examples:
         rcar_sound,dai {
             dai0 {
                 playback = <&ssi5>, <&src5>;
-                capture  = <&ssi6>;
+                capture = <&ssi6>;
             };
             dai1 {
                 playback = <&ssi3>;
             };
             dai2 {
-                capture  = <&ssi4>;
+                capture = <&ssi4>;
             };
             dai3 {
                 playback = <&ssi7>;
             };
             dai4 {
-                capture  = <&ssi8>;
+                capture = <&ssi8>;
             };
         };
 
@@ -523,7 +523,7 @@ examples:
                 frame-master = <&rsnd_endpoint0>;
 
                 playback = <&ssi0>, <&src0>, <&dvc0>;
-                capture  = <&ssi1>, <&src1>, <&dvc1>;
+                capture = <&ssi1>, <&src1>, <&dvc1>;
             };
         };
     };
diff --git a/Documentation/devicetree/bindings/sound/ti,tlv320aic32x4.yaml b/Documentation/devicetree/bindings/sound/ti,tlv320aic32x4.yaml
index a7cc9aa34468..4783e6dbb5c4 100644
--- a/Documentation/devicetree/bindings/sound/ti,tlv320aic32x4.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,tlv320aic32x4.yaml
@@ -90,7 +90,7 @@ examples:
         ldoin-supply = <&reg_3v3>;
         clocks = <&clks 201>;
         clock-names = "mclk";
-        aic32x4-gpio-func= <
+        aic32x4-gpio-func = <
           0xff /* AIC32X4_MFPX_DEFAULT_VALUE */
           0xff /* AIC32X4_MFPX_DEFAULT_VALUE */
           0x04 /* MFP3 AIC32X4_MFP3_GPIO_ENABLED */
-- 
2.34.1

