Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E18771039
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 16:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjHEOrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 10:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjHEOri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 10:47:38 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D3D1FE6;
        Sat,  5 Aug 2023 07:47:36 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31771a876b5so2425228f8f.3;
        Sat, 05 Aug 2023 07:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691246855; x=1691851655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9ciEu/fwMFN0/e4mswcIYC65MPebziJgFPOMt4uYNoo=;
        b=ecGVW+nZgLc/8ucvEHqZoijA3oFZ4t131sfcqVJPBAe+YKPAkT4B73ReyQbV+8Jasd
         0KaQOoboKtShMxflU3ov6myUpKH923ZLTEZMsv4xb/BRep6oFnURhKwY5QevuYIefbuu
         C2S8mgRUnKZcNiue8FShlga7adUIfoEWFKahist8ihDDM8bggnpozu7OB8Q/3YEhM65r
         OP8FbjR0Sq3G/kj9AAOl3RSQ116myswoM0gsVmB1de8okwAENDIhGXCwCow6TnQRyn84
         I1S/9FrodoquOo4JHGgpmM9JdTV2Y0iCqDhB3TvDCjVH4zAlanbYypJTKN6GAO2OqSUp
         VpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691246855; x=1691851655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ciEu/fwMFN0/e4mswcIYC65MPebziJgFPOMt4uYNoo=;
        b=CG9QgKC3TDtL5ce/0aRXFdozj+XhcEKU7o6kxTBX/4vfx0+uBQI37OaGvRtXzdd/Za
         WsAV/Pj4516dPcXSnNh+HToeKJYHse3VtxBHVAzHiBllJDzo7o73IjizVRsW9N/I2swB
         AclGRy/BpEnInlhnK22sKfRUMONGq007rfLSlf+0djV1EwPTPaPLbuBv3r4FhYTZtnqo
         f5Wn4GDnTAsUsKBJb+W3itLVOH7xi5sRbDgjn8kDc6LZQrVIVvyhm6ifsOxs73x6Be/K
         755E6IsD9D/H3NvmRRFZUVaWBof/f7O9X+y44IPUrmQeJWVAFXnPDLODw0e7qRtM5PON
         qJfw==
X-Gm-Message-State: AOJu0YxFV/7DvWET/yWDwcVOxux7oPy6hQ4zUmT9VX+vItC0OkcS2zpO
        k9UEHGUinFbr1MAHRZrUzXs=
X-Google-Smtp-Source: AGHT+IFJEGsZaRS6edrWhE40ETxJQqpnKbCz1VltiCnaEXYetDvMKyTsiAnipO2blTQ0zOVk4ZpggA==
X-Received: by 2002:a5d:6688:0:b0:315:a91c:1a8c with SMTP id l8-20020a5d6688000000b00315a91c1a8cmr3413991wru.22.1691246854962;
        Sat, 05 Aug 2023 07:47:34 -0700 (PDT)
Received: from localhost ([2a01:e0a:32f:1f0:c25b:89f6:3b46:6d1e])
        by smtp.gmail.com with ESMTPSA id r15-20020adff70f000000b0031763fd36c4sm5320985wrp.104.2023.08.05.07.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 07:47:34 -0700 (PDT)
From:   Raphael Gallais-Pou <rgallaispou@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2] dt-bindings: irqchip: convert st,stih407-irq-syscfg to DT schema
Date:   Sat,  5 Aug 2023 16:46:46 +0200
Message-ID: <20230805144646.33819-1-rgallaispou@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
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

 .../st,sti-irq-syscfg.txt                     | 30 ---------
 .../st,stih407-irq-syscfg.yaml                | 67 +++++++++++++++++++
 2 files changed, 67 insertions(+), 30 deletions(-)
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
index 000000000000..b6f2ef70c0ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/st,stih407-irq-syscfg.yaml
@@ -0,0 +1,67 @@
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
+  Configuration registers.  This driver is used to unmask them prior to use.
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
+      these IRQs using bitwise logic.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - const: 1
+      - const: 2
+      - const: 4
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
2.41.0

