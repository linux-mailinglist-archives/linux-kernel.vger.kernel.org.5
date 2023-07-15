Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF42C7547B5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 11:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjGOJTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 05:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjGOJSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 05:18:55 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52F53A96;
        Sat, 15 Jul 2023 02:18:41 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b6f9edac8dso41142921fa.3;
        Sat, 15 Jul 2023 02:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689412720; x=1692004720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aL5sq5Lugahi7hv9X9W+s9NTZzWQgnxxieVUqmZWN4k=;
        b=hkC/l0PqNNlvf1QawpapipLhW0ec27tqSQNF+pbnWG2amkvKgTbUy2BZj1E60f0XPw
         ICzQv+APS8QZRPsaVgLEcXOt+rIVfVGvX0pi8EzBH6QkCPZrKM+s2c+xMVxAaY9ArgrR
         bpdD3YPHN23ka/++8CxR+4ai0xmURIv54D7PdOB+VKLwZg4iI8DRef/2AE8nuIi1HvIK
         apn4JdSnn3J6DUqfaNhES2hrFi76pZFVgkTjRJfafjIflfRxe0wex1XWTVvNn36FO6oa
         vpnyImsyV+M3EAcrPucso+1ehaU3IZuFbDMDnu0zNVBEnp2payDVLW+bnqTNV2hPW9nQ
         esag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689412720; x=1692004720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aL5sq5Lugahi7hv9X9W+s9NTZzWQgnxxieVUqmZWN4k=;
        b=ht/wthrFWs120ntXZmDB3Ei6CrXQv9crEDSfTaM9FiTqioT093LcO8yuXxb7xUChKB
         QnBwvZfkDaqj1YyG3jrrmsUSQmFNJs7Y1PBdvkyQR9RKbJxHFVL0sIa2GcpLWO8ZNUi0
         IC9AYGT97U3qQvlqpBtXlQuCPMfsSoC5mJTXwtSxK14k43awcORROVCZgPPHPPrVGSRf
         SnMKzguPIYFFZ4wL8XMwpwsrJIuEXeACesSYXLPh5cAlppFz+aVwi15DN+LNO3jfumXb
         2hT2xvcoxGdbn6SpUsuVaPrvkaX/JwJ74ySRS3RnfJEQuWVoAgjgKMYG4YfBtt+XukgP
         nMQQ==
X-Gm-Message-State: ABy/qLb5xusfL9j5LeF5HPXUOBfCf9zoQlAE73zP9PPw2TdJ4ZsN+iX3
        Z4r+19YVDQ79+gGVMVX1K9ttAbx1vJPsFQ==
X-Google-Smtp-Source: APBJJlFw6pqwd8SozYu/e4m47fwD0y7FnzFvfCySpTqQUjXAlW6XQ/C3li71WujguTyDYtPhFY1uqA==
X-Received: by 2002:a2e:94c7:0:b0:2b6:e2aa:8fc2 with SMTP id r7-20020a2e94c7000000b002b6e2aa8fc2mr4696400ljh.46.1689412719800;
        Sat, 15 Jul 2023 02:18:39 -0700 (PDT)
Received: from user-PC.. ([92.51.95.194])
        by smtp.gmail.com with ESMTPSA id b17-20020a2e9891000000b002b840f283a7sm561784ljj.36.2023.07.15.02.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 02:18:39 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Maksim Kiselev <bigunclemax@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v9 3/4] dt-bindings: iio: adc: Add Allwinner D1/T113s/R329/T507 SoCs GPADC
Date:   Sat, 15 Jul 2023 12:18:15 +0300
Message-Id: <20230715091816.3074375-4-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230715091816.3074375-1-bigunclemax@gmail.com>
References: <20230715091816.3074375-1-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner's D1/T113s/R329/T507 SoCs have a new general purpose ADC.
This ADC is the same for all of this SoCs. The only difference is
the number of available channels.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 .../iio/adc/allwinner,sun20i-d1-gpadc.yaml    | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml b/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
new file mode 100644
index 000000000000..7ef46c90ebc8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/allwinner,sun20i-d1-gpadc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner D1 General Purpose ADC
+
+maintainers:
+  - Maksim Kiselev <bigunclemax@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - allwinner,sun20i-d1-gpadc
+
+  "#io-channel-cells":
+    const: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+patternProperties:
+  "^channel@[0-9a-f]+$":
+    $ref: adc.yaml
+    type: object
+    description:
+      Represents the internal channels of the ADC.
+
+    properties:
+      reg:
+        items:
+          minimum: 0
+          maximum: 15
+
+    required:
+      - reg
+
+    unevaluatedProperties: false
+
+required:
+  - "#io-channel-cells"
+  - clocks
+  - compatible
+  - interrupts
+  - reg
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/sun20i-d1-ccu.h>
+    #include <dt-bindings/reset/sun20i-d1-ccu.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    gpadc: adc@2009000 {
+        compatible = "allwinner,sun20i-d1-gpadc";
+        reg = <0x2009000 0x400>;
+        clocks = <&ccu CLK_BUS_GPADC>;
+        resets = <&ccu RST_BUS_GPADC>;
+        interrupts = <73 IRQ_TYPE_LEVEL_HIGH>;
+        #io-channel-cells = <1>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        channel@0 {
+            reg = <0>;
+        };
+
+        channel@1 {
+            reg = <1>;
+        };
+    };
+...
-- 
2.39.2

