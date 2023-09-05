Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52613792A91
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243167AbjIEQjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353709AbjIEH2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:28:04 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549F112A;
        Tue,  5 Sep 2023 00:28:00 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-402c1407139so23182265e9.1;
        Tue, 05 Sep 2023 00:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693898879; x=1694503679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cZBR5s2TcOk6Ihcqiuwq7lQP4wWO0jnfk6ipoL5a/u8=;
        b=Bl4UiPQoZSKOk3altYflwtKGKipmatWcGFBTMQiy2M9MAf17isLUv35yLO5ilZ3bW4
         IFeFeiWjfM5tuvM49Ou5CtTYHUZfmaPtHFzlEEyNzSp0xF5WUU3im772/0uu8cQzTYiH
         Gmd+TfXjYm1tZ+VlF88RgyUDZ+RvvhLkF/CIX/luYlQRpRtIB+68pEgP+PX7B3JHG3DS
         TT+TRopS7PAafpl/bY3Zy15bdcG/TZJ0zR0oNkcQKZOu3RR0ifmDU5/HlVWcg4xQvNuo
         mcGo8+ZBbyoTZihkKgfE/ipXKLHhn3z3Y/rIDsG3g4xO/Rf+POIWJ4njQeoVOmwmh+BJ
         fiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693898879; x=1694503679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZBR5s2TcOk6Ihcqiuwq7lQP4wWO0jnfk6ipoL5a/u8=;
        b=UaFNoHsmtcw4+03wFEghAX/nACQADysyNkHlkrcZPDOpnBGXWYNuNkM769xK1ku6Ew
         XDZxESbcDnWUgHQpn4ml/QKmwHQL1ZRdJjx1rvHhv0AsOcCWxnOu3vBrIfWh2LmpvmPM
         +t2ZCgPbS0gRif79BcI92lP6OTCi+TcDzOnOhB9t7/fFwkKyx8O/mifS6pNrv7r+VGt2
         IrGdhyfO4oyKC7MezMFLQI5PADdZkox7GHD2SUkl2UYE6Hp4SX7bWBSKWWuiDPIWF8UD
         f38HS6nBlioeDjhpOD2T2kFTKJF6ZFgUZOll6kBfKJBWYdSnx65NE83+l8X+UnV5kyPV
         PpfQ==
X-Gm-Message-State: AOJu0YyDCGrUM7xF4klTMwy1GuI1aSN9Zax9hNBT5FZxqrMcKqM/0xvu
        tv/oRxVRPZoPyroZ2HYbajQ=
X-Google-Smtp-Source: AGHT+IF+72/5S5hbkeurgEqTmzG+tjG+g1oTHka6O9/k+8Qfm+UOMk7sVv4nGRX04aihjlgLpCC9FQ==
X-Received: by 2002:a05:6000:4e:b0:317:f714:3be6 with SMTP id k14-20020a056000004e00b00317f7143be6mr7886347wrx.61.1693898878520;
        Tue, 05 Sep 2023 00:27:58 -0700 (PDT)
Received: from localhost ([2a01:e0a:32f:1f0:c25b:89f6:3b46:6d1e])
        by smtp.gmail.com with ESMTPSA id b4-20020adfde04000000b0031aef72a021sm16440112wrm.86.2023.09.05.00.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 00:27:58 -0700 (PDT)
From:   Raphael Gallais-Pou <rgallaispou@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4] dt-bindings: irqchip: convert st,stih407-irq-syscfg to DT schema
Date:   Tue,  5 Sep 2023 09:27:40 +0200
Message-ID: <20230905072740.23859-1-rgallaispou@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert deprecated format to DT schema format.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v2:
	- Added Conor's r-by
	- Removed quotes surrounding $refs
	- Hardcoded 'st,invert-ext' possible values

Changes in v3:
	- Fixed enum syntax warnings
	- Removed reference to driver in favor of device

Changes in v4:
	- Make clearer description for "st,invert-ext" property
	- Handle better bitwise logic
---
 .../st,sti-irq-syscfg.txt                     | 30 ---------
 .../st,stih407-irq-syscfg.yaml                | 65 +++++++++++++++++++
 2 files changed, 65 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/st,stih407-irq-syscfg.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt b/Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt
deleted file mode 100644
index 977d7ed3670e..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-STMicroelectronics STi System Configuration Controlled IRQs
------------------------------------------------------------
-
-On STi based systems; External, CTI (Core Sight), PMU (Performance Management),
-and PL310 L2 Cache IRQs are controlled using System Configuration registers.
-This driver is used to unmask them prior to use.
-
-Required properties:
-- compatible	: Should be "st,stih407-irq-syscfg"
-- st,syscfg	: Phandle to Cortex-A9 IRQ system config registers
-- st,irq-device	: Array of IRQs to enable - should be 2 in length
-- st,fiq-device	: Array of FIQs to enable - should be 2 in length
-
-Optional properties:
-- st,invert-ext	: External IRQs can be inverted at will.  This property inverts
-		  these IRQs using bitwise logic.  A number of defines have been
-		  provided for convenience:
-			ST_IRQ_SYSCFG_EXT_1_INV
-			ST_IRQ_SYSCFG_EXT_2_INV
-			ST_IRQ_SYSCFG_EXT_3_INV
-Example:
-
-irq-syscfg {
-	compatible    = "st,stih407-irq-syscfg";
-	st,syscfg     = <&syscfg_cpu>;
-	st,irq-device = <ST_IRQ_SYSCFG_PMU_0>,
-			<ST_IRQ_SYSCFG_PMU_1>;
-	st,fiq-device = <ST_IRQ_SYSCFG_DISABLED>,
-			<ST_IRQ_SYSCFG_DISABLED>;
-};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stih407-irq-syscfg.yaml b/Documentation/devicetree/bindings/interrupt-controller/st,stih407-irq-syscfg.yaml
new file mode 100644
index 000000000000..2b153d7c5421
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/st,stih407-irq-syscfg.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/st,stih407-irq-syscfg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STi System Configuration Controlled IRQs
+
+maintainers:
+  - Patrice Chotard <patrice.chotard@foss.st.com>
+
+description:
+  On STi based systems; External, CTI (Core Sight), PMU (Performance
+  Management), and PL310 L2 Cache IRQs are controlled using System
+  Configuration registers.  This device is used to unmask them prior to use.
+
+properties:
+  compatible:
+    const: st,stih407-irq-syscfg
+
+  st,syscfg:
+    description: Phandle to Cortex-A9 IRQ system config registers
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  st,irq-device:
+    description: Array of IRQs to enable.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      - description: Enable the IRQ of the channel one.
+      - description: Enable the IRQ of the channel two.
+
+  st,fiq-device:
+    description: Array of FIQs to enable.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      - description: Enable the IRQ of the channel one.
+      - description: Enable the IRQ of the channel two.
+
+  st,invert-ext:
+    description: External IRQs can be inverted at will. This property inverts
+      these three IRQs using bitwise logic, each one being encoded respectively
+      on the first, second and fourth bit.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 1, 2, 3, 4, 5, 6 ]
+
+required:
+  - compatible
+  - st,syscfg
+  - st,irq-device
+  - st,fiq-device
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq-st.h>
+    irq-syscfg {
+        compatible    = "st,stih407-irq-syscfg";
+        st,syscfg     = <&syscfg_cpu>;
+        st,irq-device = <ST_IRQ_SYSCFG_PMU_0>,
+                        <ST_IRQ_SYSCFG_PMU_1>;
+        st,fiq-device = <ST_IRQ_SYSCFG_DISABLED>,
+                        <ST_IRQ_SYSCFG_DISABLED>;
+    };
+...
-- 
2.42.0

