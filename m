Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E388064B4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbjLFBqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbjLFBqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:46:31 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EEA10EA;
        Tue,  5 Dec 2023 17:46:17 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6d9a3c035b3so1687457a34.2;
        Tue, 05 Dec 2023 17:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701827176; x=1702431976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csVIocKJcCA0/pKL9VAYyHAhw6hsvYWEU7r5aRbgOmA=;
        b=k7ZYZ6fXc2kx0u0FG8a/3Ng1nNeGr3DiZp3+rUGvX8dpgBvYMGAWAcjRW6CZNaTG5b
         cNwD/9FuVwqZlZrIZwyTrrJsyHQ5JDT9LvFs9cHk9hGruEt7f9FxEUBJb2OjULNOIiOk
         kUzhsz8pzJIYZxtsiKcsB0ihWDjdgSD/D8D0g5BMZDmOdWHDbTfH4LGHt+NLchB82gBc
         c1XvPjVjc+0HofcwjC281M6P74TmNmLQ0nitFM9yljaCzPiHGdko73y6w1wvTjEvKD4i
         jStVuwa9RqIzZRtXAyUXHW9YDheg+lizDec1cbVXgfSzjBVdcw0qREYqZVQ9I0xr/qyF
         hvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701827176; x=1702431976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csVIocKJcCA0/pKL9VAYyHAhw6hsvYWEU7r5aRbgOmA=;
        b=HoyE4GfDaMD+MezOAlcwmQ3Zb8T+BtW7QsBpzX0Uj6EQ5RPaOjp20R/shRZVGOBFGw
         JkU/OlBq2TOFoC5ds0nvd662iAp5HiKM1jU+mHtGnrSAheeHZSmKviJJD5AfPuUxrAac
         2CzMFExDMUhM1LAR1Gl5auiThHCFbae0YiqYlDfBE8WqZiyP/m8d7zN9MLiiNgJ1x3Zg
         BDkbeJdmm2z8jfBWpMx8r4ENT8f3vt+VY+cbLtQ2Omrfe88MKPzPuko8uDraOgU4qjof
         rW9F8PbEebdNIWFz14ufE80ML9l9uF6YHinGFrn85zH4W9zddNPzbCp8z0WgKsYa7JZ1
         Gtcw==
X-Gm-Message-State: AOJu0Ywp5QFjhep9aLqjo97GZ3adIW2pdrb46L2CvXjBjN+Z/9CWedV8
        aukkvXWEt2CVM9ILCjWdb4F3gfNn4Z2Z8g==
X-Google-Smtp-Source: AGHT+IETsWTi6W69r2n7qUYLLjgu++skFmcC8RUdUKEwRQgcp554G/iyPKJUsFkziyon99BD0VyYwA==
X-Received: by 2002:a05:6830:1681:b0:6d8:e05b:115b with SMTP id k1-20020a056830168100b006d8e05b115bmr266085otr.7.1701827176057;
        Tue, 05 Dec 2023 17:46:16 -0800 (PST)
Received: from localhost.localdomain ([112.78.94.69])
        by smtp.gmail.com with ESMTPSA id g24-20020aa78758000000b006ce781f6f85sm1250956pfo.43.2023.12.05.17.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 17:46:15 -0800 (PST)
From:   Jim Liu <jim.t90615@gmail.com>
To:     JJLIU0@nuvoton.com, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, andy@kernel.org, robh+dt@kernel.org,
        conor+dt@kernel.org, KWLIU@nuvoton.com, jim.t90615@gmail.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v8 1/3] dt-bindings: gpio: add NPCM sgpio driver bindings
Date:   Wed,  6 Dec 2023 09:45:28 +0800
Message-Id: <20231206014530.1600151-2-jim.t90615@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231206014530.1600151-1-jim.t90615@gmail.com>
References: <20231206014530.1600151-1-jim.t90615@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings document for the Nuvoton NPCM7xx sgpio driver

Signed-off-by: Jim Liu <jim.t90615@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v8:
   - no changed
Changes for v7:
   - no changed
Changes for v6:
   - Drop quotes for $ref
   - Add and drop '|' for description
   - Add space after 'exposed.'
   - remove status
---
 .../bindings/gpio/nuvoton,sgpio.yaml          | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml b/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
new file mode 100644
index 000000000000..84e0dbcb066c
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/nuvoton,sgpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton SGPIO controller
+
+maintainers:
+  - Jim LIU <JJLIU0@nuvoton.com>
+
+description: |
+  This SGPIO controller is for NUVOTON NPCM7xx and NPCM8xx SoC.
+  Nuvoton NPCM7xx SGPIO module is combine serial to parallel IC (HC595)
+  and parallel to serial IC (HC165), and use APB3 clock to control it.
+  This interface has 4 pins  (D_out , D_in, S_CLK, LDSH).
+  NPCM7xx/NPCM8xx have two sgpio module each module can support up
+  to 64 output pins,and up to 64 input pin, the pin is only for gpi or gpo.
+  GPIO pins have sequential, First half is gpo and second half is gpi.
+  GPIO pins can be programmed to support the following options
+  - Support interrupt option for each input port and various interrupt
+    sensitivity option (level-high, level-low, edge-high, edge-low)
+  - ngpios is number of nuvoton,input-ngpios GPIO lines and nuvoton,output-ngpios GPIO lines.
+    nuvoton,input-ngpios GPIO lines is only for gpi.
+    nuvoton,output-ngpios GPIO lines is only for gpo.
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,npcm750-sgpio
+      - nuvoton,npcm845-sgpio
+
+  reg:
+    maxItems: 1
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  nuvoton,input-ngpios:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The numbers of GPIO's exposed. GPIO lines is only for gpi.
+    minimum: 0
+    maximum: 64
+
+  nuvoton,output-ngpios:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The numbers of GPIO's exposed. GPIO lines is only for gpo.
+    minimum: 0
+    maximum: 64
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - '#gpio-cells'
+  - interrupts
+  - nuvoton,input-ngpios
+  - nuvoton,output-ngpios
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/nuvoton,npcm7xx-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    gpio8: gpio@101000 {
+        compatible = "nuvoton,npcm750-sgpio";
+        reg = <0x101000 0x200>;
+        clocks = <&clk NPCM7XX_CLK_APB3>;
+        interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        nuvoton,input-ngpios = <64>;
+        nuvoton,output-ngpios = <64>;
+    };
-- 
2.25.1

