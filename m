Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA62E7E8B39
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 15:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjKKOcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 09:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjKKOca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 09:32:30 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3D9469E
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 06:32:26 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9e623356e59so238181666b.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 06:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699713145; x=1700317945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ub4VI3MZ7DSmkukUX/fiEV7NAmUSVlsfQVOOR3bbu7U=;
        b=EVG4BSnGOavD/Qw7HgnrENa9WDABPIT0igsYMOaFDsiOQ2KkdzAbftWN2W80kfvoIn
         cpp6NNGDGUFGa7rmD/gtCeWppb9VnVFLRkAeCBu9Qgg2RW03Ks/CdrWyJzxHIPuez7/D
         zUDHpYFttixi68nyCoBcWHPfjTn8b24fht/ehLZZFME36m73Zk3RZo4fm3XyLpanjbP6
         BjlKWlLQXQ3cEz6wu1yiuhzlQjoaltZnizmFoexnfTen3goES3Qdfq7a5IZYF/1V0bQR
         81AuGvKnpeZGPi5eiQ3u3Knw7hNFHKjY3dDtkOku7QihtFa6STkIJtW94q5nZp05viHC
         O2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699713145; x=1700317945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ub4VI3MZ7DSmkukUX/fiEV7NAmUSVlsfQVOOR3bbu7U=;
        b=GbOmymXYyaQNY6eeubLLQnY3/ABrMTR9EN7eLzS1tT4599ep2dVf6XfS5d0TP5Cff5
         QcyNX3nYdwP0i1kLLQ6fq++jsy8sFWoFAqaxW6pLijUqWP7pgZywdiw3Z5KBo5Dyzvnn
         moJ2cNFXYYklN+HH5FLGEhXqpGZGDsIFMrjFkN667if5I3l6jnSwJSmtKGsmW3dU14q+
         LrdAWE18+sJiobXXTTBSnqre3UKyYhB3xkGEnlzp3HC1Jg0z8R0r2QFNbibCus/lk5bN
         H5EPTPw2Ig/i+Ike/PfGjuas9llz6xw/W9mGIabgqAryWl/9i2DOtv3so8+aJypEtSM5
         Zt7Q==
X-Gm-Message-State: AOJu0YwxraVlpEdgzHP6U2ypfSPYTlbJc/uZTcBeGB2hwZYzVEX7Nr7z
        cZnyC1kpQe+Dl9uyMj+Hp+PWc3bnUzR7Qw89CgA=
X-Google-Smtp-Source: AGHT+IFhbal/t9dQICzWzQexo59iM2onji5W66rDi2OmOwwG1cMKENrsger0nKbYz10Q5RUipiWJfQ==
X-Received: by 2002:a17:906:6c92:b0:9e8:2c4d:40d4 with SMTP id s18-20020a1709066c9200b009e82c4d40d4mr180958ejr.30.1699713144759;
        Sat, 11 Nov 2023 06:32:24 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id b13-20020a170906038d00b009bd9ac83a9fsm1136889eja.152.2023.11.11.06.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 06:32:24 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: input: samsung,s6sy761: convert to DT schema
Date:   Sat, 11 Nov 2023 15:32:21 +0100
Message-Id: <20231111143221.55452-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Samsung  S6SY761 touchscreen controller bindings to DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

I put original autho, Andi, as bindings maintainer, but I don't think he
has access to the device anymore. Anyone else has datasheet or hardware?
---
 .../input/touchscreen/samsung,s6sy761.txt     | 32 -----------
 .../input/touchscreen/samsung,s6sy761.yaml    | 54 +++++++++++++++++++
 2 files changed, 54 insertions(+), 32 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.txt b/Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.txt
deleted file mode 100644
index 6805d10d226d..000000000000
--- a/Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-* Samsung S6SY761 touchscreen controller
-
-Required properties:
-- compatible		: must be "samsung,s6sy761"
-- reg			: I2C slave address, (e.g. 0x48)
-- interrupts		: interrupt specification
-- avdd-supply		: analogic power supply
-- vdd-supply		: power supply
-
-Optional properties:
-- touchscreen-size-x	: see touchscreen.txt. This property is embedded in the
-			  device. If defined it forces a different x resolution.
-- touchscreen-size-y	: see touchscreen.txt. This property is embedded in the
-			  device. If defined it forces a different y resolution.
-
-Example:
-
-i2c@00000000 {
-
-	/* ... */
-
-	touchscreen@48 {
-		compatible = "samsung,s6sy761";
-		reg = <0x48>;
-		interrupt-parent = <&gpa1>;
-		interrupts = <1 IRQ_TYPE_NONE>;
-		avdd-supply = <&ldo30_reg>;
-		vdd-supply = <&ldo31_reg>;
-		touchscreen-size-x = <4096>;
-		touchscreen-size-y = <4096>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.yaml b/Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.yaml
new file mode 100644
index 000000000000..1ffd17af3c53
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/samsung,s6sy761.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S6SY761 touchscreen controller
+
+maintainers:
+  - Andi Shyti <andi.shyti@kernel.org>
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    const: samsung,s6sy761
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  avdd-supply: true
+  vdd-supply: true
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - avdd-supply
+  - vdd-supply
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        touchscreen@48 {
+            compatible = "samsung,s6sy761";
+            reg = <0x48>;
+            interrupt-parent = <&gpa1>;
+            interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
+            avdd-supply = <&ldo30_reg>;
+            vdd-supply = <&ldo31_reg>;
+            touchscreen-size-x = <4096>;
+            touchscreen-size-y = <4096>;
+        };
+    };
-- 
2.34.1

