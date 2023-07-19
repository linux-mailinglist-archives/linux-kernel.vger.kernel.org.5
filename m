Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB40D75945D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjGSLhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjGSLha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:37:30 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210841FD6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:37:04 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6687466137bso4496794b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1689766609; x=1690371409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYQsgV6mmNiNxm7fkk00HaM0IkP9BeYIjrigTOut9Eg=;
        b=kR3NvZQyH5fux8dphx2zj8yGyheFPoOAcTGkV7s1MA5f+/umQ9Dt+GY3ClJWiFuzwB
         j6NEEvwBtbi/IZZ0TYjpdKyzuel3JJNH5tULr32GTyxyBguAUBaR1wCcm1qlh0jYYwpH
         qnspGyoX0Y5+/rsQgyoPHjG+jrxlELRqCCAqD5Di54HVNYPa6X8kAXfgaIoFpejdV+zO
         9Yj243ZRUws0gjhGJXWSEi5k1KYPVT/Jurv99E8XQ9o/L3BVSVfoVVfzEDIcfM6KxqbE
         Xi3ohCPlxFNLbIssbYvszTkR7PvnTu9UYKCvn2dnabmeiMfIHNYRCDWolaElbE9jpw5z
         6iGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689766609; x=1690371409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYQsgV6mmNiNxm7fkk00HaM0IkP9BeYIjrigTOut9Eg=;
        b=VGLxIBmYqwQwpj81Ei9AIFr3D8OSyE3esskNsTfi73x8tpXiHL4lAsE099qYspNq09
         hmG1aDYbn+mEqQUwj25Z6yegmgx3l82/ka8f0rXWArjGalvWRwfWpwHncAvGrBKehus+
         MsckOFpAS4bl8xIa+PqLdklJ14IKm3cEe/1+r0MYFJj7GffF2+lG43TxKhN/Z5TrFHw3
         v/PdxsH1NUDoaeyu81pfBcjhlHlEkOpB2EiZwXS+83LuAHLpgYH7YtVi2rg9aq7pOiOv
         EKnk6fgKCPH6ycfhrJ7kNtSVamW32+WDcS242xuhnc6PuXKg3GKMA1YmzmV9sqrnu4RT
         uX/Q==
X-Gm-Message-State: ABy/qLYqX9dnArniyoe6j4yVaoOSQyQGQ7EUevcWf75GzOYZdVuaJXZu
        s0mZ8N02PbVwIM899dTE70vucw==
X-Google-Smtp-Source: APBJJlHg3dgiGng4zvc3NmEtDdfuHhZRz4OyGcxpttAoJJ4mBp3L5G5Cax4FNfnE3aZwb9iUBc3lWA==
X-Received: by 2002:a05:6a21:33a9:b0:12d:3d9e:2934 with SMTP id yy41-20020a056a2133a900b0012d3d9e2934mr2278727pzb.44.1689766608714;
        Wed, 19 Jul 2023 04:36:48 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.86.130])
        by smtp.gmail.com with ESMTPSA id j10-20020aa783ca000000b00669c99d05fasm3050408pfn.150.2023.07.19.04.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 04:36:48 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 10/14] dt-bindings: interrupt-controller: Add RISC-V advanced PLIC
Date:   Wed, 19 Jul 2023 17:05:38 +0530
Message-Id: <20230719113542.2293295-11-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230719113542.2293295-1-apatel@ventanamicro.com>
References: <20230719113542.2293295-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add DT bindings document for RISC-V advanced platform level interrupt
controller (APLIC) defined by the RISC-V advanced interrupt architecture
(AIA) specification.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../interrupt-controller/riscv,aplic.yaml     | 172 ++++++++++++++++++
 1 file changed, 172 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
new file mode 100644
index 000000000000..190a6499c932
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
@@ -0,0 +1,172 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/riscv,aplic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V Advanced Platform Level Interrupt Controller (APLIC)
+
+maintainers:
+  - Anup Patel <anup@brainfault.org>
+
+description:
+  The RISC-V advanced interrupt architecture (AIA) defines an advanced
+  platform level interrupt controller (APLIC) for handling wired interrupts
+  in a RISC-V platform. The RISC-V AIA specification can be found at
+  https://github.com/riscv/riscv-aia.
+
+  The RISC-V APLIC is implemented as hierarchical APLIC domains where all
+  interrupt sources connect to the root APLIC domain and a parent APLIC
+  domain can delegate interrupt sources to it's child APLIC domains. There
+  is one device tree node for each APLIC domain.
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qemu,aplic
+      - const: riscv,aplic
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  interrupts-extended:
+    minItems: 1
+    maxItems: 16384
+    description:
+      Given APLIC domain directly injects external interrupts to a set of
+      RISC-V HARTS (or CPUs). Each node pointed to should be a riscv,cpu-intc
+      node, which has a CPU node (i.e. RISC-V HART) as parent.
+
+  msi-parent:
+    description:
+      Given APLIC domain forwards wired interrupts as MSIs to a AIA incoming
+      message signaled interrupt controller (IMSIC). If both "msi-parent" and
+      "interrupts-extended" properties are present then it means the APLIC
+      domain supports both MSI mode and Direct mode in HW. In this case, the
+      APLIC driver has to choose between MSI mode or Direct mode.
+
+  riscv,num-sources:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 1023
+    description:
+      Specifies the number of wired interrupt sources supported by this
+      APLIC domain.
+
+  riscv,children:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    minItems: 1
+    maxItems: 1024
+    items:
+      maxItems: 1
+    description:
+      A list of child APLIC domains for the given APLIC domain. Each child
+      APLIC domain is assigned a child index in increasing order, with the
+      first child APLIC domain assigned child index 0. The APLIC domain child
+      index is used by firmware to delegate interrupts from the given APLIC
+      domain to a particular child APLIC domain.
+
+  riscv,delegation:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    minItems: 1
+    maxItems: 1024
+    items:
+      items:
+        - description: child APLIC domain phandle
+        - description: first interrupt number of the parent APLIC domain (inclusive)
+        - description: last interrupt number of the parent APLIC domain (inclusive)
+    description:
+      A interrupt delegation list where each entry is a triple consisting
+      of child APLIC domain phandle, first interrupt number of the parent
+      APLIC domain, and last interrupt number of the parent APLIC domain.
+      Firmware must configure interrupt delegation registers based on
+      interrupt delegation list.
+
+dependencies:
+  riscv,delegation: [ "riscv,children" ]
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - "#interrupt-cells"
+  - riscv,num-sources
+
+anyOf:
+  - required:
+      - interrupts-extended
+  - required:
+      - msi-parent
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    // Example 1 (APLIC domains directly injecting interrupt to HARTs):
+
+    interrupt-controller@c000000 {
+      compatible = "qemu,aplic", "riscv,aplic";
+      interrupts-extended = <&cpu1_intc 11>,
+                            <&cpu2_intc 11>,
+                            <&cpu3_intc 11>,
+                            <&cpu4_intc 11>;
+      reg = <0xc000000 0x4080>;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+      riscv,num-sources = <63>;
+      riscv,children = <&aplic1>, <&aplic2>;
+      riscv,delegation = <&aplic1 1 63>;
+    };
+
+    aplic1: interrupt-controller@d000000 {
+      compatible = "qemu,aplic", "riscv,aplic";
+      interrupts-extended = <&cpu1_intc 9>,
+                            <&cpu2_intc 9>;
+      reg = <0xd000000 0x4080>;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+      riscv,num-sources = <63>;
+    };
+
+    aplic2: interrupt-controller@e000000 {
+      compatible = "qemu,aplic", "riscv,aplic";
+      interrupts-extended = <&cpu3_intc 9>,
+                            <&cpu4_intc 9>;
+      reg = <0xe000000 0x4080>;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+      riscv,num-sources = <63>;
+    };
+
+  - |
+    // Example 2 (APLIC domains forwarding interrupts as MSIs):
+
+    interrupt-controller@c000000 {
+      compatible = "qemu,aplic", "riscv,aplic";
+      msi-parent = <&imsic_mlevel>;
+      reg = <0xc000000 0x4000>;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+      riscv,num-sources = <63>;
+      riscv,children = <&aplic3>;
+      riscv,delegation = <&aplic3 1 63>;
+    };
+
+    aplic3: interrupt-controller@d000000 {
+      compatible = "qemu,aplic", "riscv,aplic";
+      msi-parent = <&imsic_slevel>;
+      reg = <0xd000000 0x4000>;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+      riscv,num-sources = <63>;
+    };
+...
-- 
2.34.1

