Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBED765842
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbjG0QGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbjG0QGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:06:30 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386ED2D45;
        Thu, 27 Jul 2023 09:06:29 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b6f97c7115so18204001fa.2;
        Thu, 27 Jul 2023 09:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690473987; x=1691078787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyKDf+CToOe8rKKKOXBY/UzZ8faPu6UhccJmfEJhILw=;
        b=jIyUhVoZRSdJJO/RKPbHwkRqRp4QkuP6L9jVwzEGc0cB09SWgMpcVxbkFdpdT7PcRW
         H6MI1od9iKQGz5ZqKK2W6t4fx6bTd/iy2u4v7JoxrfPm/hEpbFeeTUW6LKjdwmln4xFe
         i/zZ4lJSntCA/TrmAld3pui6ydKofYTPe30ttK+ganP0mfLtUl774clTvRiQ9htw1k7m
         vdL0KBvZDEZG6w1yYtnv39TG9ySbWme9LalA+v0nESfa81T3kfpxBFENLG0mNAfpqDjC
         JX1qal+A55JANOWitOZUgUH2/YzeV5+A27SgZUPU7e4/cEnTETiXxu69TQXqEU4Ex9y/
         ppPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690473987; x=1691078787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyKDf+CToOe8rKKKOXBY/UzZ8faPu6UhccJmfEJhILw=;
        b=U+hecDcCDdc4xj/lRlldRj+vyR2A5XI2sMtnVQpg/0QlBtJ6Xxx0YPhrWkEfaN/fi1
         G6VuN18ObMZB+B1APktmewp//bbTk3U8zV6xJoWZTsfDAnG11Oj+mUJXlBnwUfn90ium
         sPXsrbkR5WrgJ088HLEsXztHpCfa9ZecsHRhhUzrlkmGiuiKYhflyxCteKoYGfOjUN/W
         Qk0D+yR1PvthsBNvQv2ve4LGZgfWkgpFIEUsy805PIYCxCS7s4kmIkoOLs8FW1mrIMv2
         mR9CDGuAVuQNTU/emYeaTdBgoNydqzMAWGvvhFa1XgXgydQ0y6IeZqPeH6T8UIBqiO+J
         ZMXQ==
X-Gm-Message-State: ABy/qLbb/F+NInTVhcm/4yR68wQ0D0YfNiVRX7NXxqdjHlE81SUXB9VB
        KNSrw1NrK6mltS92lXwEP2keAH4lr00s2Q==
X-Google-Smtp-Source: APBJJlEQkdEBVvchG2qcztsQVkpCpSxQ4/441HR6s3d4gLwnmjmyRnb57s1Aq2wLH/YGWoOFxT8a7Q==
X-Received: by 2002:a2e:9550:0:b0:2b6:e2aa:8fc2 with SMTP id t16-20020a2e9550000000b002b6e2aa8fc2mr2014600ljh.46.1690473987112;
        Thu, 27 Jul 2023 09:06:27 -0700 (PDT)
Received: from localhost.localdomain ([2a01:c844:242b:b300:215:5dff:fe78:868])
        by smtp.gmail.com with ESMTPSA id ck8-20020a170906c44800b00982be08a9besm936540ejb.172.2023.07.27.09.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 09:06:26 -0700 (PDT)
From:   Matus Gajdos <matuszpd@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matus Gajdos <matuszpd@gmail.com>
Subject: [PATCH 2/3] dt-bindings: leds: Add binding for Broadchip BCT3024 LED driver
Date:   Thu, 27 Jul 2023 18:05:24 +0200
Message-Id: <20230727160525.23312-3-matuszpd@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230727160525.23312-1-matuszpd@gmail.com>
References: <20230727160525.23312-1-matuszpd@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCT3024 chip is an I2C LED driver with independent 24 output
channels. Each channel supports 256 levels.

Signed-off-by: Matus Gajdos <matuszpd@gmail.com>
---
 .../bindings/leds/broadchip,bct3024.yaml      | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/broadchip,bct3024.yaml

diff --git a/Documentation/devicetree/bindings/leds/broadchip,bct3024.yaml b/Documentation/devicetree/bindings/leds/broadchip,bct3024.yaml
new file mode 100644
index 000000000000..0d622894e79c
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/broadchip,bct3024.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/broadchip,bct3024.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadchip BCT3024 LED Driver
+
+maintainers:
+  - Matus Gajdos <matuszpd@gmail.com>
+
+description: |
+  The BCT3024 is an I2C LED driver with independent 24 output channels. Each
+  channel supports 256 levels and its output current can be scaled by a factor
+  of 1, 1/2, 1/3 and 1/4.
+
+properties:
+  compatible:
+    const: broadchip,bct3024
+
+  reg:
+    description: I2C slave address of the driver.
+    maxItems: 1
+
+  vdd-supply:
+    description: Regulator providing power to the VDD pin.
+
+  shutdown-gpios:
+    maxItems: 1
+    description: GPIO attached to the SDB pin.
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^led@[0-9a-f]+$":
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        description: Index of the LED channel.
+        minimum: 0
+        maximum: 23
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/leds/common.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        led-controller@3c {
+            compatible = "broadchip,bct3024";
+            reg = <0x3c>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            vdd-supply = <&reg_3v3d>;
+
+            led@0 {
+                reg = <0x00>;
+                function = LED_FUNCTION_INDICATOR;
+                color = <LED_COLOR_ID_RED>;
+            };
+
+            led@1 {
+                reg = <0x01>;
+                function = LED_FUNCTION_INDICATOR;
+                color = <LED_COLOR_ID_GREEN>;
+            };
+        };
+    };
+
+...
-- 
2.25.1

