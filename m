Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0EB07A8D45
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjITT5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjITT5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:57:45 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FE3C9;
        Wed, 20 Sep 2023 12:57:38 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-502a4f33440so464368e87.1;
        Wed, 20 Sep 2023 12:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695239853; x=1695844653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5XzZksbV/3HO4SAr0Uk6zK330d1dH4mTSmHQR/Nt2A=;
        b=nTiEX4gR8eXqB3gbpx7MSZxzDw3cqbWollINOs0yTEy1DEmhJpmkZTPqXIVboNSH4n
         PTRwyx37jd6FcZHibHp/y78ZP9uNfualL3nxgTJ7Kyi/U75UzLwg/4E1qqgnWZT7BvvQ
         YtLTJ3unnQXgao9XcNBYyFijMChIXEvO1Ju0SoLo+pdu++QA1/FS6KHdCo0CFEfgVhkp
         9K9J1h2X+br9ITEo7z0T8L0DgPhKoOB0tvvuMA3bvUXSfWUTpLRx+MpwApYY371db5jO
         mtKBWWfkX4VRawAu6WS+K/SFMLpxvH57YrPIBtfld2htqDuaTxu3jOUT4x6wZMLLjnJF
         26dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695239853; x=1695844653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5XzZksbV/3HO4SAr0Uk6zK330d1dH4mTSmHQR/Nt2A=;
        b=Q5sOq6V613zhm5WKwD+hVkknodsVPnWmHIl6al2olGrfRgfJnjun0XsPq71zSR7H6j
         R/fw5V2FWCOTrGwR8SyMDcdm/pJam6Ye79sB0AZf2rrs4RFZGeS1jYp1FfC9qW5bvpCB
         kj4mLaSoOP1fHPMK2V6Z8m22mTTgGDpKDi7iUr6DGf8uJI+vUADL5cKFZngF3IqV+uSj
         OkEM0mQpHmokE67FoGmClLvcum3BLQlxXvfZDREyIWfkqtmDd4BO1qGOAq9VZr6xZJRh
         L3BcgrFodEhUGPXRMaemhPZj3oFW1qjNJDMJWZLM/wWuFQHTE//Yfk1WHbs2LrEGnFOg
         REUw==
X-Gm-Message-State: AOJu0YxmBcK5eL73n6j7Qwu4vbcNfTdMTEar8tZzhW46woyruKaI/7Rs
        F36KaFZH5cvGD8q9H+3IfJI=
X-Google-Smtp-Source: AGHT+IEKtEGnv7R0sVUV2eFH+krO2vA6UfHOGpzalmLbaNHZ4NrxuFUkleyT9ZwnX5jcxSg7ulq83Q==
X-Received: by 2002:a05:6512:3da7:b0:502:fd1a:9fa0 with SMTP id k39-20020a0565123da700b00502fd1a9fa0mr4077682lfv.53.1695239853367;
        Wed, 20 Sep 2023 12:57:33 -0700 (PDT)
Received: from localhost ([83.149.21.16])
        by smtp.gmail.com with ESMTPSA id p21-20020a19f015000000b004fe3bd81278sm765040lfc.70.2023.09.20.12.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:57:33 -0700 (PDT)
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
        Conor Dooley <conor+dt@kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/13] dt-bindings: memory: Add BT1 DDRC DT-schema
Date:   Wed, 20 Sep 2023 22:56:33 +0300
Message-ID: <20230920195720.32047-3-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920195720.32047-1-fancer.lancer@gmail.com>
References: <20230920195720.32047-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baikal-T1 DDR controller is based on the DW uMCTL2 DDRC IP-core v2.51a
with up to DDR3 protocol capability and 32-bit data bus + 8-bit ECC. There
are individual IRQs for each ECC and DFI events. The dedicated scrubber
clock source is absent since it's fully synchronous to the core clock.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changelog v2:
- Keep the alphabetically ordered compatible strings list. (@Krzysztof)
- Fix grammar nitpicks in the patch log. (@Krzysztof)
- Drop the PHY CSR region. (@Rob)
- Move the device bindings to the separate DT-schema.
---
 .../memory-controllers/baikal,bt1-ddrc.yaml   | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/baikal,bt1-ddrc.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/baikal,bt1-ddrc.yaml b/Documentation/devicetree/bindings/memory-controllers/baikal,bt1-ddrc.yaml
new file mode 100644
index 000000000000..80353a0a676f
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/baikal,bt1-ddrc.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/baikal,bt1-ddrc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Baikal-T1 DDR Controller
+
+maintainers:
+  - Serge Semin <fancer.lancer@gmail.com>
+
+description:
+  Baikal-T1 DDRC is based on the DW uMCTL2 DDRC IP-core v2.51a with DDR2
+  and DDR3 protocol capability, 32-bit data bus + 8-bit ECC + up to 2
+  SDRAM ranks. There are individual IRQs for each ECC and DFI events.
+  The dedicated scrubber clock source is absent since it's fully
+  synchronous to the core clock.
+
+allOf:
+  - $ref: /schemas/memory-controllers/snps,dw-umctl2-common.yaml#
+
+properties:
+  compatible:
+    const: baikal,bt1-ddrc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 4
+
+  interrupt-names:
+    items:
+      - const: dfi_e
+      - const: ecc_ce
+      - const: ecc_ue
+      - const: ecc_sbr
+
+  clocks:
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: aclk
+      - const: core
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: arst
+      - const: core
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/mips-gic.h>
+    #include <dt-bindings/clock/bt1-ccu.h>
+    #include <dt-bindings/reset/bt1-ccu.h>
+
+    memory-controller@1f042000 {
+      compatible = "baikal,bt1-ddrc";
+      reg = <0x1f042000 0x1000>;
+
+      interrupts = <GIC_SHARED 96 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SHARED 97 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SHARED 98 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SHARED 99 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "dfi_e", "ecc_ce", "ecc_ue", "ecc_sbr";
+
+      clocks = <&ccu_sys CCU_SYS_APB_CLK>,
+               <&ccu_axi CCU_AXI_DDR_CLK>,
+               <&ccu_pll CCU_DDR_PLL>;
+      clock-names = "pclk", "aclk", "core";
+
+      resets = <&ccu_axi CCU_AXI_DDR_RST>,
+               <&ccu_sys CCU_SYS_DDR_INIT_RST>;
+      reset-names = "arst", "core";
+    };
+...
-- 
2.41.0

