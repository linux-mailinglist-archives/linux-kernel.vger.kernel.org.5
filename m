Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579917B600E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 06:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239115AbjJCEpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 00:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239145AbjJCEpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 00:45:18 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AF2197
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 21:45:09 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-57babef76deso284979eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 21:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1696308309; x=1696913109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOjDepVi55uZJQ1rIBBnqb1diEnF/zfemFV4q9wl2F4=;
        b=nt9xj9o70XBHpO2kvvCxHUYO7CcMx8CO4BLj2svKRZA3ISvth5Ls30O8pE4J/a823q
         c3rgDiNCFl9Gtjx8KjohbnsrhdyrZLNpSjfgSaAC9SjNLhZkrUU15lbAvm6EK/mAPMAn
         lR4yhLZxbpLfXCnqAtvQtK/Nrm14oamd+f5cuoEP89P2QSNH5OoDpXusDp34XG2Hyu2C
         RskfJFOq8kzyGhUT6HiqWcdc7ZK4hten3/s5wAZ354izUeuELMaCTF5jZMNfRvNADmIi
         AMOesS6NnEu1gTLcEGFEi1ybKVFylQmBGMSycoYSvI4QW6Jwoua6qzOJj6Kb/AjA66qA
         GJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696308309; x=1696913109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOjDepVi55uZJQ1rIBBnqb1diEnF/zfemFV4q9wl2F4=;
        b=GQSzhWsqptKud+vkWEsuOXPWHsgf5J1KCecL2IvpS6TfhUO/CQ2Umk/UX30yZIDLKH
         eG7tdh1MvvlUjGeWFV0BN7YbLfXB8BJdW8i4eYYspZYr2TnDNORBw5c8vvr9IHkiiQop
         Rk2Nzf5R/6EKIn3c7Z2+fXv7k+Sf32xH+LyVj0mPNONGvqnd/1uQeuwTT8IqbP8yY5k0
         Hg3KLUhUWUDN1Gm04DQGzzIGVB/rqX3bk91jJ+ltTN6EyoyN8tDbPX10tQSc+2Ywoq7m
         cyZgPKTiwV/bB1B7E04AtmG3PzwYlHxR71REBtatqllrusdALYmh2ajMsVl40m9fWjRQ
         mCbQ==
X-Gm-Message-State: AOJu0YylfEN0963tYwh5tHU3LFtIkkB8kKjeLCQQJgl/2QSZhHG1w8J4
        Sj0lqPqGTig2F8jkcOlccedMEQ==
X-Google-Smtp-Source: AGHT+IE4BwBVle254BwguEmSkgLVB/yCz8tulqf9QAg6FvDZ2qa2iCjJujATnitp1TzXoZJZrmHneA==
X-Received: by 2002:a05:6358:7245:b0:13f:2833:bf41 with SMTP id i5-20020a056358724500b0013f2833bf41mr14823216rwa.23.1696308308798;
        Mon, 02 Oct 2023 21:45:08 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.84.132])
        by smtp.gmail.com with ESMTPSA id h9-20020aa786c9000000b0068e49cb1692sm346421pfo.1.2023.10.02.21.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 21:45:08 -0700 (PDT)
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
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v10 07/15] dt-bindings: interrupt-controller: Add RISC-V incoming MSI controller
Date:   Tue,  3 Oct 2023 10:13:55 +0530
Message-Id: <20231003044403.1974628-8-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003044403.1974628-1-apatel@ventanamicro.com>
References: <20231003044403.1974628-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add DT bindings document for the RISC-V incoming MSI controller
(IMSIC) defined by the RISC-V advanced interrupt architecture (AIA)
specification.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../interrupt-controller/riscv,imsics.yaml    | 172 ++++++++++++++++++
 1 file changed, 172 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
new file mode 100644
index 000000000000..84976f17a4a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
@@ -0,0 +1,172 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/riscv,imsics.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V Incoming MSI Controller (IMSIC)
+
+maintainers:
+  - Anup Patel <anup@brainfault.org>
+
+description: |
+  The RISC-V advanced interrupt architecture (AIA) defines a per-CPU incoming
+  MSI controller (IMSIC) for handling MSIs in a RISC-V platform. The RISC-V
+  AIA specification can be found at https://github.com/riscv/riscv-aia.
+
+  The IMSIC is a per-CPU (or per-HART) device with separate interrupt file
+  for each privilege level (machine or supervisor). The configuration of
+  a IMSIC interrupt file is done using AIA CSRs and it also has a 4KB MMIO
+  space to receive MSIs from devices. Each IMSIC interrupt file supports a
+  fixed number of interrupt identities (to distinguish MSIs from devices)
+  which is same for given privilege level across CPUs (or HARTs).
+
+  The device tree of a RISC-V platform will have one IMSIC device tree node
+  for each privilege level (machine or supervisor) which collectively describe
+  IMSIC interrupt files at that privilege level across CPUs (or HARTs).
+
+  The arrangement of IMSIC interrupt files in MMIO space of a RISC-V platform
+  follows a particular scheme defined by the RISC-V AIA specification. A IMSIC
+  group is a set of IMSIC interrupt files co-located in MMIO space and we can
+  have multiple IMSIC groups (i.e. clusters, sockets, chiplets, etc) in a
+  RISC-V platform. The MSI target address of a IMSIC interrupt file at given
+  privilege level (machine or supervisor) encodes group index, HART index,
+  and guest index (shown below).
+
+  XLEN-1            > (HART Index MSB)                  12    0
+  |                  |                                  |     |
+  -------------------------------------------------------------
+  |xxxxxx|Group Index|xxxxxxxxxxx|HART Index|Guest Index|  0  |
+  -------------------------------------------------------------
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qemu,imsics
+      - const: riscv,imsics
+
+  reg:
+    minItems: 1
+    maxItems: 16384
+    description:
+      Base address of each IMSIC group.
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 0
+
+  msi-controller: true
+
+  "#msi-cells":
+    const: 0
+
+  interrupts-extended:
+    minItems: 1
+    maxItems: 16384
+    description:
+      This property represents the set of CPUs (or HARTs) for which given
+      device tree node describes the IMSIC interrupt files. Each node pointed
+      to should be a riscv,cpu-intc node, which has a CPU node (i.e. RISC-V
+      HART) as parent.
+
+  riscv,num-ids:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 63
+    maximum: 2047
+    description:
+      Number of interrupt identities supported by IMSIC interrupt file.
+
+  riscv,num-guest-ids:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 63
+    maximum: 2047
+    description:
+      Number of interrupt identities are supported by IMSIC guest interrupt
+      file. When not specified it is assumed to be same as specified by the
+      riscv,num-ids property.
+
+  riscv,guest-index-bits:
+    minimum: 0
+    maximum: 7
+    default: 0
+    description:
+      Number of guest index bits in the MSI target address.
+
+  riscv,hart-index-bits:
+    minimum: 0
+    maximum: 15
+    description:
+      Number of HART index bits in the MSI target address. When not
+      specified it is calculated based on the interrupts-extended property.
+
+  riscv,group-index-bits:
+    minimum: 0
+    maximum: 7
+    default: 0
+    description:
+      Number of group index bits in the MSI target address.
+
+  riscv,group-index-shift:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 55
+    default: 24
+    description:
+      The least significant bit position of the group index bits in the
+      MSI target address.
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - msi-controller
+  - "#msi-cells"
+  - interrupts-extended
+  - riscv,num-ids
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    // Example 1 (Machine-level IMSIC files with just one group):
+
+    interrupt-controller@24000000 {
+      compatible = "qemu,imsics", "riscv,imsics";
+      interrupts-extended = <&cpu1_intc 11>,
+                            <&cpu2_intc 11>,
+                            <&cpu3_intc 11>,
+                            <&cpu4_intc 11>;
+      reg = <0x28000000 0x4000>;
+      interrupt-controller;
+      #interrupt-cells = <0>;
+      msi-controller;
+      #msi-cells = <0>;
+      riscv,num-ids = <127>;
+    };
+
+  - |
+    // Example 2 (Supervisor-level IMSIC files with two groups):
+
+    interrupt-controller@28000000 {
+      compatible = "qemu,imsics", "riscv,imsics";
+      interrupts-extended = <&cpu1_intc 9>,
+                            <&cpu2_intc 9>,
+                            <&cpu3_intc 9>,
+                            <&cpu4_intc 9>;
+      reg = <0x28000000 0x2000>, /* Group0 IMSICs */
+            <0x29000000 0x2000>; /* Group1 IMSICs */
+      interrupt-controller;
+      #interrupt-cells = <0>;
+      msi-controller;
+      #msi-cells = <0>;
+      riscv,num-ids = <127>;
+      riscv,group-index-bits = <1>;
+      riscv,group-index-shift = <24>;
+    };
+...
-- 
2.34.1

