Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35127B60E7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 08:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjJCGki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 02:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239181AbjJCGkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 02:40:33 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106528E;
        Mon,  2 Oct 2023 23:40:29 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so8492251a12.1;
        Mon, 02 Oct 2023 23:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696315227; x=1696920027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uye/HSI1wQAdkgUnSG3A2VWR7SagBYCfdMDY+nvLJco=;
        b=Re0lYPomd2SowzDTCoOa79JngY6ii5uIR8QECWlOnl9m3uq0AuBx2xnIGvq3fSY+ZX
         CMEGejbw0j0IathH1UM4zQxtKZK5Hof9XX0l8QzQ5+0SAXwLbzgT0F+2RF1xJnYnoxVZ
         CoeTs3bwZ5NCp7fG8hCR2dv+biwtumTJW+7Alhy8uSqp4EGvKpWuHtbx6FbKNwx8F9cP
         XmgW+Xvro+Pv/SPp9H1BxY76dta4+KGdnMkiLDmxF0w8TSX+ND1kFIOlMucGmkEcoH/g
         wJMXDe9zE7bIpz9OWVMJpx9OteTbEN+TnztaF4Jq1kMgO3A6ZqHb5iA9cY8u8G8tIQXQ
         oU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696315227; x=1696920027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uye/HSI1wQAdkgUnSG3A2VWR7SagBYCfdMDY+nvLJco=;
        b=Jtq9UlQwxlPM0Cg1MtqgNmmWG099UA5ygbt4/BePZci6x+0EbdTRTleTRZW9G1O5bq
         zYwT7EfC6g2Pmoy9FGfU9JlpRei6vxAfOURo4xqpzlHvZS+HkCPMR06AeR4urItfnsXc
         r4/f02X8nAJn9187YSHQ4D3IQQ07GaPilTtZKuCawJo8l0GOgFXwnHj+nkID6h8Tw8ze
         WqgFy6zWVg6zLhbkrZ4tQ4GfghUymjH6pX2PiQnTQmiyPMj7MSzEqLeA7CLCLR0ryow0
         YKZQ8/DANFhf48Un+IhYIBrJ2xkQ2iorPM/hFrfOcN1epGCeYefAQPkY6nVcjtkg0ZU0
         vMxA==
X-Gm-Message-State: AOJu0YySCMn7BdcC47nwvNRe6ZSlPRMB90yfbfIB0knUuBeiasoYYECN
        OI8C9Xis1fhezp6O0bPPxvE=
X-Google-Smtp-Source: AGHT+IHweMDUKStFAHIR/AP7EtRQ6ait6aFeVzWpmfMtUeYCHmbVmgvoJIyZ/NHXrrxki+Xg0r1cUQ==
X-Received: by 2002:a17:907:7fa4:b0:9a9:405b:26d1 with SMTP id qk36-20020a1709077fa400b009a9405b26d1mr1758019ejc.5.1696315227064;
        Mon, 02 Oct 2023 23:40:27 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id h22-20020a17090634d600b009a1fef32ce6sm504324ejb.177.2023.10.02.23.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 23:40:26 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Lala Lin <lala.lin@mediatek.com>,
        Komal Bajaj <quic_kbajaj@quicinc.com>,
        Kumar Thella <sthella@codeaurora.org>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, asahi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2] dt-bindings: nvmem: move deprecated cells binding to its own file
Date:   Tue,  3 Oct 2023 08:40:18 +0200
Message-Id: <20231003064018.7502-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Support for old NVMEM fixed cells was deprecated in favour of
"fixed-layout". It's still part of the nvmem.yaml though and may be
unknowingly used by new bindings added without much of analyze.

To make it more difficult to accidentally support old syntax move its
binding to separated file with "deprecated" in its name.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Fix path to nvmem-deprecated-cells.yaml in amlogic,meson6-rtc.yaml

 .../devicetree/bindings/mtd/mtd.yaml          |  7 ++++-
 .../bindings/mtd/partitions/nvmem-cells.yaml  |  1 +
 .../nvmem/amlogic,meson-gxbb-efuse.yaml       |  1 +
 .../bindings/nvmem/amlogic,meson6-efuse.yaml  |  1 +
 .../bindings/nvmem/apple,efuses.yaml          |  1 +
 .../devicetree/bindings/nvmem/imx-ocotp.yaml  |  1 +
 .../bindings/nvmem/mediatek,efuse.yaml        |  1 +
 .../nvmem/microchip,sama7g5-otpc.yaml         |  1 +
 .../devicetree/bindings/nvmem/mxs-ocotp.yaml  |  1 +
 .../nvmem/nvmem-deprecated-cells.yaml         | 28 +++++++++++++++++++
 .../devicetree/bindings/nvmem/nvmem.yaml      |  9 ------
 .../bindings/nvmem/qcom,qfprom.yaml           |  1 +
 .../bindings/nvmem/qcom,sec-qfprom.yaml       |  1 +
 .../bindings/nvmem/qcom,spmi-sdam.yaml        |  1 +
 .../bindings/nvmem/rockchip,otp.yaml          |  1 +
 .../bindings/nvmem/rockchip-efuse.yaml        |  1 +
 .../nvmem/socionext,uniphier-efuse.yaml       |  1 +
 .../bindings/nvmem/sunplus,sp7021-ocotp.yaml  |  1 +
 .../bindings/rtc/amlogic,meson6-rtc.yaml      |  1 +
 19 files changed, 50 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/nvmem-deprecated-cells.yaml

diff --git a/Documentation/devicetree/bindings/mtd/mtd.yaml b/Documentation/devicetree/bindings/mtd/mtd.yaml
index b82ca03e969c..f322290ee516 100644
--- a/Documentation/devicetree/bindings/mtd/mtd.yaml
+++ b/Documentation/devicetree/bindings/mtd/mtd.yaml
@@ -43,7 +43,12 @@ patternProperties:
     deprecated: true
 
   "^otp(-[0-9]+)?$":
-    $ref: ../nvmem/nvmem.yaml#
+    type: object
+
+    allOf:
+      - $ref: ../nvmem/nvmem.yaml#
+      - $ref: ../nvmem/nvmem-deprecated-cells.yaml#
+
     unevaluatedProperties: false
 
     description: |
diff --git a/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
index 5474d63268dc..9518281007af 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
@@ -19,6 +19,7 @@ maintainers:
 allOf:
   - $ref: /schemas/mtd/partitions/partition.yaml#
   - $ref: /schemas/nvmem/nvmem.yaml#
+  - $ref: /schemas/nvmem/nvmem-deprecated-cells.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/amlogic,meson-gxbb-efuse.yaml b/Documentation/devicetree/bindings/nvmem/amlogic,meson-gxbb-efuse.yaml
index e49c2754ff55..9801fe6f91b5 100644
--- a/Documentation/devicetree/bindings/nvmem/amlogic,meson-gxbb-efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/amlogic,meson-gxbb-efuse.yaml
@@ -11,6 +11,7 @@ maintainers:
 
 allOf:
   - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/amlogic,meson6-efuse.yaml b/Documentation/devicetree/bindings/nvmem/amlogic,meson6-efuse.yaml
index 84b3dfd21e09..b5cf740f96fa 100644
--- a/Documentation/devicetree/bindings/nvmem/amlogic,meson6-efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/amlogic,meson6-efuse.yaml
@@ -12,6 +12,7 @@ maintainers:
 
 allOf:
   - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml b/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
index e0860b6b85f3..d3abdafdbca0 100644
--- a/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
+++ b/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
@@ -16,6 +16,7 @@ maintainers:
 
 allOf:
   - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
index 99e60d713dac..be1314454bec 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
@@ -16,6 +16,7 @@ description: |
 
 allOf:
   - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
index 7ec2988b597e..cf5f9e22bb7e 100644
--- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
@@ -16,6 +16,7 @@ maintainers:
 
 allOf:
   - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
 
 properties:
   $nodename:
diff --git a/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml b/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
index a296d348adb4..cc25f2927682 100644
--- a/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
+++ b/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
@@ -16,6 +16,7 @@ description: |
 
 allOf:
   - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml
index a9b822aeaa7e..f43186f98607 100644
--- a/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml
@@ -11,6 +11,7 @@ maintainers:
 
 allOf:
   - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/nvmem-deprecated-cells.yaml b/Documentation/devicetree/bindings/nvmem/nvmem-deprecated-cells.yaml
new file mode 100644
index 000000000000..951af28bbfb3
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/nvmem-deprecated-cells.yaml
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/nvmem-deprecated-cells.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVMEM old syntax for fixed cells
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  Before introducing NVMEM layouts all NVMEM (fixed) cells were defined
+  as direct device subnodes. That syntax was replaced by "fixed-layout"
+  and is deprecated now. No new bindings should use it.
+
+patternProperties:
+  "@[0-9a-f]+(,[0-7])?$":
+    type: object
+    allOf:
+      - $ref: layouts/fixed-cell.yaml
+      - properties:
+          compatible: false
+    deprecated: true
+
+additionalProperties: true
+
+...
diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
index 9f921d940142..4fd015d402ce 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -46,15 +46,6 @@ properties:
       container may reference more advanced (dynamic) layout
       parsers.
 
-patternProperties:
-  "@[0-9a-f]+(,[0-7])?$":
-    type: object
-    allOf:
-      - $ref: layouts/fixed-cell.yaml
-      - properties:
-          compatible: false
-    deprecated: true
-
 additionalProperties: true
 
 examples:
diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 8740938c32eb..8c8f05d9eaf1 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -11,6 +11,7 @@ maintainers:
 
 allOf:
   - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml
index 9b133f783d29..2ada2099946d 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml
@@ -16,6 +16,7 @@ description:
 
 allOf:
   - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
index cd980def97b8..068bedf5dbc9 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
@@ -16,6 +16,7 @@ description: |
 
 allOf:
   - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml b/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
index 9c6eff788928..a44d44b32809 100644
--- a/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
@@ -49,6 +49,7 @@ required:
 
 allOf:
   - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
 
   - if:
       properties:
diff --git a/Documentation/devicetree/bindings/nvmem/rockchip-efuse.yaml b/Documentation/devicetree/bindings/nvmem/rockchip-efuse.yaml
index c5403e149080..b80fd8d1ae5b 100644
--- a/Documentation/devicetree/bindings/nvmem/rockchip-efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/rockchip-efuse.yaml
@@ -11,6 +11,7 @@ maintainers:
 
 allOf:
   - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml b/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
index efccc5aacbe0..e27cbae2d63a 100644
--- a/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
@@ -12,6 +12,7 @@ maintainers:
 
 allOf:
   - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
index da3f1de7d281..af97eeb8316c 100644
--- a/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
@@ -12,6 +12,7 @@ maintainers:
 
 allOf:
   - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/rtc/amlogic,meson6-rtc.yaml b/Documentation/devicetree/bindings/rtc/amlogic,meson6-rtc.yaml
index 8bf7d3a9be98..3a4551253e3e 100644
--- a/Documentation/devicetree/bindings/rtc/amlogic,meson6-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/amlogic,meson6-rtc.yaml
@@ -13,6 +13,7 @@ maintainers:
 allOf:
   - $ref: rtc.yaml#
   - $ref: /schemas/nvmem/nvmem.yaml#
+  - $ref: /schemas/nvmem/nvmem-deprecated-cells.yaml#
 
 properties:
   compatible:
-- 
2.35.3

