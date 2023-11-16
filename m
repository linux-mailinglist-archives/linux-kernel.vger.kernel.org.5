Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B139A7EE129
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbjKPNNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbjKPNNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:13:36 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A85610D5;
        Thu, 16 Nov 2023 05:13:25 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9c603e2354fso152904866b.1;
        Thu, 16 Nov 2023 05:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700140404; x=1700745204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fnxhr1dk/vfohyQfMfgOpH3tTQBBu2nuppfYXXpJ6wA=;
        b=H1oUfAE+1QrnehJZkBuHjvmsPK0HCTA4vu6rQn5VTwUWdD1PpFiQ94xyv04e6glrG5
         YgV0QkyPvjI8fC45JIR959oN5lP3t49Jn450YXF67UOHpIHlYwK3zfN82UtsKHAA2zrG
         NEcKVmjpVG8yMqpOtSGV81qwcNvptg8p6Ym8pGTeTNESS8ih96vF4On/izYsmGQde4a+
         f8boRsbt3eASmZJQXUipad7jekHe7ZIgplQ3Z9h623JVwfNVAqw6Dv2DP9PNgVt8VGFL
         Ub9lCgqPrDCbzVC0/d0At8Jj8GBzsE2nPuhPQwrtHDuOPzudPE8gnZ1dijBn7pYpdrFw
         iTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700140404; x=1700745204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fnxhr1dk/vfohyQfMfgOpH3tTQBBu2nuppfYXXpJ6wA=;
        b=ZIbfSl+NEZiNWxeAXSKY+dO8FhzP4mjvtA52NKCrX2W+duKXeMasxxc+LsZKZtqA6G
         Z8BC9SRTEpDXMm+UNmYSAXzbNS84gd5OBl0sXdtWrcPFPOX9IX8wCGIW+tRDgk67hu/i
         Xr+B6gfK0DUI4cFmw9FTW24iHRGBtOdpjPjfXHJZnzPtDAHVYCFQs2Cn9bKv4YmDP8vS
         w7RHaqVf8D5YFRjqwpV3xPTtcqDXWkjpmDJf8+zT2/uj1kZfZ9Mogta6J5jcXdUL+atq
         ZDeYyS0mDCfeT3Y3KTJqp0yiuTktdV9EdIZWpG5khmiZzY8MnRT5YLdelfCKnol5TNzb
         YjYg==
X-Gm-Message-State: AOJu0Yx6Th+dAYXJVCpRTl0khh0HSNJrlaxrxMVd5lwInXNE2YUQf4B6
        ff0TNtvcK7/f5N6YKx/bmMs=
X-Google-Smtp-Source: AGHT+IEl2Xlwo1h4vrkBr9Yyi0WKoUvKYSm60dyFK8pkJfjBaHrRZa6CGJkO4HvqqcrARMGr96+9Yg==
X-Received: by 2002:a17:907:75d7:b0:9b2:be5e:3674 with SMTP id jl23-20020a17090775d700b009b2be5e3674mr1401307ejc.36.1700140403737;
        Thu, 16 Nov 2023 05:13:23 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id u10-20020a170906408a00b009e5d30422ebsm8412710ejj.101.2023.11.16.05.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 05:13:23 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2] dt-bindings: thermal: convert Mediatek Thermal to the json-schema
Date:   Thu, 16 Nov 2023 14:13:16 +0100
Message-Id: <20231116131316.5897-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This helps validating DTS files.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Add "maintainers"

 .../bindings/thermal/mediatek-thermal.txt     |  52 ---------
 .../bindings/thermal/mediatek-thermal.yaml    | 101 ++++++++++++++++++
 2 files changed, 101 insertions(+), 52 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/mediatek-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
deleted file mode 100644
index ac39c7156fde..000000000000
--- a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-* Mediatek Thermal
-
-This describes the device tree binding for the Mediatek thermal controller
-which measures the on-SoC temperatures. This device does not have its own ADC,
-instead it directly controls the AUXADC via AHB bus accesses. For this reason
-this device needs phandles to the AUXADC. Also it controls a mux in the
-apmixedsys register space via AHB bus accesses, so a phandle to the APMIXEDSYS
-is also needed.
-
-Required properties:
-- compatible:
-  - "mediatek,mt8173-thermal" : For MT8173 family of SoCs
-  - "mediatek,mt2701-thermal" : For MT2701 family of SoCs
-  - "mediatek,mt2712-thermal" : For MT2712 family of SoCs
-  - "mediatek,mt7622-thermal" : For MT7622 SoC
-  - "mediatek,mt7981-thermal", "mediatek,mt7986-thermal" : For MT7981 SoC
-  - "mediatek,mt7986-thermal" : For MT7986 SoC
-  - "mediatek,mt8183-thermal" : For MT8183 family of SoCs
-  - "mediatek,mt8365-thermal" : For MT8365 family of SoCs
-  - "mediatek,mt8516-thermal", "mediatek,mt2701-thermal : For MT8516 family of SoCs
-- reg: Address range of the thermal controller
-- interrupts: IRQ for the thermal controller
-- clocks, clock-names: Clocks needed for the thermal controller. required
-                       clocks are:
-		       "therm":	 Main clock needed for register access
-		       "auxadc": The AUXADC clock
-- mediatek,auxadc: A phandle to the AUXADC which the thermal controller uses
-- mediatek,apmixedsys: A phandle to the APMIXEDSYS controller.
-- #thermal-sensor-cells : Should be 0. See Documentation/devicetree/bindings/thermal/thermal-sensor.yaml for a description.
-
-Optional properties:
-- resets: Reference to the reset controller controlling the thermal controller.
-- nvmem-cells: A phandle to the calibration data provided by a nvmem device. If
-               unspecified default values shall be used.
-- nvmem-cell-names: Should be "calibration-data"
-
-Example:
-
-	thermal: thermal@1100b000 {
-		#thermal-sensor-cells = <1>;
-		compatible = "mediatek,mt8173-thermal";
-		reg = <0 0x1100b000 0 0x1000>;
-		interrupts = <0 70 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&pericfg CLK_PERI_THERM>, <&pericfg CLK_PERI_AUXADC>;
-		clock-names = "therm", "auxadc";
-		resets = <&pericfg MT8173_PERI_THERM_SW_RST>;
-		reset-names = "therm";
-		mediatek,auxadc = <&auxadc>;
-		mediatek,apmixedsys = <&apmixedsys>;
-		nvmem-cells = <&thermal_calibration_data>;
-		nvmem-cell-names = "calibration-data";
-	};
diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek-thermal.yaml
new file mode 100644
index 000000000000..faeb4d6c6dd4
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/mediatek-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek Thermal
+
+maintainers:
+  - Sascha Hauer <s.hauer@pengutronix.de>
+
+description: >
+  This describes the device tree binding for the Mediatek thermal controller
+  which measures the on-SoC temperatures. This device does not have its own ADC,
+  instead it directly controls the AUXADC via AHB bus accesses. For this reason
+  this device needs phandles to the AUXADC. Also it controls a mux in the
+  apmixedsys register space via AHB bus accesses, so a phandle to the APMIXEDSYS
+  is also needed.
+
+allOf:
+  - $ref: thermal-sensor.yaml#
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt2701-thermal
+      - mediatek,mt2712-thermal
+      - mediatek,mt7622-thermal
+      - mediatek,mt7981-thermal
+      - mediatek,mt7986-thermal
+      - mediatek,mt8173-thermal
+      - mediatek,mt8183-thermal
+      - mediatek,mt8365-thermal
+      - mediatek,mt8516-thermal
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Main clock needed for register access
+      - description: The AUXADC clock
+
+  clock-names:
+    items:
+      - const: therm
+      - const: auxadc
+
+  mediatek,auxadc:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: A phandle to the AUXADC which the thermal controller uses
+
+  mediatek,apmixedsys:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: A phandle to the APMIXEDSYS controller
+
+  resets: Reference to the reset controller controlling the thermal controller.
+
+  nvmem-cells:
+    items:
+      - description: >
+          NVMEM cell with EEPROMA phandle to the calibration data provided by an
+          NVMEM device. If unspecified default values shall be used.
+
+  nvmem-cell-names:
+    items:
+      - const: calibration-data
+
+unevaluatedProperties: false
+
+required:
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - mediatek,auxadc
+  - mediatek,apmixedsys
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/mt8173-clk.h>
+    #include <dt-bindings/reset/mt8173-resets.h>
+
+    thermal@1100b000 {
+        compatible = "mediatek,mt8173-thermal";
+        reg = <0x1100b000 0x1000>;
+        interrupts = <0 70 IRQ_TYPE_LEVEL_LOW>;
+        clocks = <&pericfg CLK_PERI_THERM>, <&pericfg CLK_PERI_AUXADC>;
+        clock-names = "therm", "auxadc";
+        resets = <&pericfg MT8173_PERI_THERM_SW_RST>;
+        reset-names = "therm";
+        mediatek,auxadc = <&auxadc>;
+        mediatek,apmixedsys = <&apmixedsys>;
+        nvmem-cells = <&thermal_calibration_data>;
+        nvmem-cell-names = "calibration-data";
+        #thermal-sensor-cells = <1>;
+    };
-- 
2.35.3

