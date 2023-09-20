Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECAF7A8D42
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjITT5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjITT5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:57:42 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E55AB;
        Wed, 20 Sep 2023 12:57:32 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bcb50e194dso2754671fa.3;
        Wed, 20 Sep 2023 12:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695239850; x=1695844650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jH5/i0fBYTGbVf7HMN5Ff/WeloccWe2hg/tj/I2fUhw=;
        b=Uq22OAGhqRcEycrmEt6+enuC4rjzyCVkxF8yKcKqJagzzH7RWdywYjpMRxEYro8oRd
         lFV/vKoZneuwJWzJdeOCp0Blj2KK9EkCSW4h0mzQMpBCDpWcay+vx3laMAhm6YrhU1lE
         j9b/EgCfn8GUJ/5l0KaqXdnXN2+1W/sBO4amYnDaMZ1FakNf4++cgNRfCVB5CVJOb7Dx
         rHaWU1AYgiTbNLlT6gOZ3j8+2Q/BoeMpMrVaqRZ6FOXBh2DApqpew4qYXxtRtwrumqA+
         ++BRH+qWHjrK5Edr+hQKcliB3+lrHvBYZJ6R4hkitkIw/5OCagHxVs08H55l9ob9QWiH
         dmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695239850; x=1695844650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jH5/i0fBYTGbVf7HMN5Ff/WeloccWe2hg/tj/I2fUhw=;
        b=JOyp44j5PmnX5YGH/CitSOvzjntewZrWXineZq1bMriFvPGOoUu1ZZe8po6WniA8ts
         kQYl+NV8V+zNuSiL2wORF39tyK75SwXBg3KjML0s8+MX2WzDQ9YgJTqv5xHZteMVnJmV
         zEHHxEu17JH3TddhUKf7ytlNPDQWlx7XOpVDHKgF3ien5yT4vfosR53sXt9sEUQI+5nX
         KBNgHH9bl2ca7s6af89G4TzsTdNGLHL8pKCfsbuqijZpGCGOdPPOk0S1yFI/WHOdlrpz
         qIAtVIXuB57XbjpzmZ3/Hjm3mxVU3vUyYUS1UnQX6Gb1eSJ44PdVtMMLZUMnbE090p6a
         7/lw==
X-Gm-Message-State: AOJu0YwtES5NeJrPXGLbEyPZ7hUaCvLsm4q45gvl3NDNROtpLPmAfOCJ
        oop0MBP8yaDREwFHk3yK4Ww=
X-Google-Smtp-Source: AGHT+IFzH++l2jpm7pegKlKpDJsv+54jftKDNT9JdrwOv9zHkESy0z9L5WvYlTizinZRa16Imnfx2g==
X-Received: by 2002:a19:8c4f:0:b0:503:19d8:8dc3 with SMTP id i15-20020a198c4f000000b0050319d88dc3mr2753220lfj.31.1695239850052;
        Wed, 20 Sep 2023 12:57:30 -0700 (PDT)
Received: from localhost ([178.176.85.138])
        by smtp.gmail.com with ESMTPSA id a14-20020a19f80e000000b00504296f067esm11659lff.233.2023.09.20.12.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:57:29 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Michal Simek <michal.simek@amd.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v4 01/13] dt-bindings: memory: snps: Convert the schema to being generic
Date:   Wed, 20 Sep 2023 22:56:32 +0300
Message-ID: <20230920195720.32047-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920195720.32047-1-fancer.lancer@gmail.com>
References: <20230920195720.32047-1-fancer.lancer@gmail.com>
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

At the current state the DW uMCTL2 DDRC DT-schema can't be used as the
common one for all the IP-core-based devices due to the compatible string
property constraining the list of the supported device names. In order to
fix that detach the common properties definition to the separate schema.
The later will be used by the vendor-specific controller versions to
preserve the DT-bindings convention defined for the DW uMCTL2 DDR
controller. Thus the generic DW uMCTL2 DDRC DT-bindings will be left with
the compatible property definition only and will just refer to the
detached common DT-schema.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changelog v2:
- This is a new patch created on v2 cycle of the patchset. (@Krzysztof)

Changelog v3:
- Create common DT-schema instead of using the generic device DT-bindings.
  (@Rob)
---
 .../snps,dw-umctl2-common.yaml                | 75 +++++++++++++++++++
 .../snps,dw-umctl2-ddrc.yaml                  | 57 ++------------
 2 files changed, 81 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-common.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-common.yaml b/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-common.yaml
new file mode 100644
index 000000000000..115fe5e8339a
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-common.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/snps,dw-umctl2-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DesignWare Universal Multi-Protocol Memory Controller
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+  - Manish Narani <manish.narani@xilinx.com>
+  - Michal Simek <michal.simek@xilinx.com>
+
+description:
+  Synopsys DesignWare Enhanced uMCTL2 DDR Memory Controller is capable of
+  working with the memory devices supporting up to (LP)DDR4 protocol. It can
+  be equipped with SEC/DEC ECC feature if DRAM data bus width is either
+  16-bits or 32-bits or 64-bits wide.
+
+select: false
+
+properties:
+  interrupts:
+    description:
+      DW uMCTL2 DDRC IP-core provides individual IRQ signal for each event":"
+      ECC Corrected Error, ECC Uncorrected Error, ECC Address Protection,
+      Scrubber-Done signal, DFI Parity/CRC Error. Some platforms may have the
+      signals merged before they reach the IRQ controller or have some of them
+      absent in case if the corresponding feature is unavailable/disabled.
+    minItems: 1
+    maxItems: 5
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 5
+    oneOf:
+      - description: Common ECC CE/UE/Scrubber/DFI Errors IRQ
+        items:
+          - const: ecc
+      - description: Individual ECC CE/UE/Scrubber/DFI Errors IRQs
+        items:
+          enum: [ ecc_ce, ecc_ue, ecc_ap, ecc_sbr, dfi_e ]
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description:
+      A standard set of the clock sources contains CSRs bus clock, AXI-ports
+      reference clock, DDRC core clock, Scrubber standalone clock
+      (synchronous to the DDRC clock).
+    minItems: 1
+    maxItems: 4
+
+  clock-names:
+    minItems: 1
+    maxItems: 4
+    items:
+      enum: [ pclk, aclk, core, sbr ]
+
+  resets:
+    description:
+      Each clock domain can have separate reset signal.
+    minItems: 1
+    maxItems: 4
+
+  reset-names:
+    minItems: 1
+    maxItems: 4
+    items:
+      enum: [ prst, arst, core, sbr ]
+
+additionalProperties: true
+
+...
diff --git a/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml b/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
index 87ff9ee098f5..80b25d2fa974 100644
--- a/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
@@ -20,6 +20,11 @@ description: |
   controller. It has an optional SEC/DEC ECC support in 64- and 32-bits
   bus width configurations.
 
+allOf:
+  - $ref: /schemas/memory-controllers/snps,dw-umctl2-common.yaml#
+
+# Please create a separate DT-schema for your DW uMCTL2 DDR controller
+# with more detailed properties definition.
 properties:
   compatible:
     oneOf:
@@ -31,62 +36,12 @@ properties:
       - description: Xilinx ZynqMP DDR controller v2.40a
         const: xlnx,zynqmp-ddrc-2.40a
 
-  interrupts:
-    description:
-      DW uMCTL2 DDRC IP-core provides individual IRQ signal for each event":"
-      ECC Corrected Error, ECC Uncorrected Error, ECC Address Protection,
-      Scrubber-Done signal, DFI Parity/CRC Error. Some platforms may have the
-      signals merged before they reach the IRQ controller or have some of them
-      absent in case if the corresponding feature is unavailable/disabled.
-    minItems: 1
-    maxItems: 5
-
-  interrupt-names:
-    minItems: 1
-    maxItems: 5
-    oneOf:
-      - description: Common ECC CE/UE/Scrubber/DFI Errors IRQ
-        items:
-          - const: ecc
-      - description: Individual ECC CE/UE/Scrubber/DFI Errors IRQs
-        items:
-          enum: [ ecc_ce, ecc_ue, ecc_ap, ecc_sbr, dfi_e ]
-
-  reg:
-    maxItems: 1
-
-  clocks:
-    description:
-      A standard set of the clock sources contains CSRs bus clock, AXI-ports
-      reference clock, DDRC core clock, Scrubber standalone clock
-      (synchronous to the DDRC clock).
-    minItems: 1
-    maxItems: 4
-
-  clock-names:
-    minItems: 1
-    maxItems: 4
-    items:
-      enum: [ pclk, aclk, core, sbr ]
-
-  resets:
-    description:
-      Each clock domain can have separate reset signal.
-    minItems: 1
-    maxItems: 4
-
-  reset-names:
-    minItems: 1
-    maxItems: 4
-    items:
-      enum: [ prst, arst, core, sbr ]
-
 required:
   - compatible
   - reg
   - interrupts
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.41.0

