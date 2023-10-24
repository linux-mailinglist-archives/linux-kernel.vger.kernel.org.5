Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93687D5D5E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 23:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344470AbjJXVlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 17:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344460AbjJXVlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 17:41:20 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987ADD7F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:41:17 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ca6809fb8aso34942135ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698183677; x=1698788477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qlj3Zfises7r0D8qFU0FTbLuXsSPwTC7ghoEI6cXzzE=;
        b=lBeixISwFVwDkdi/qQ9H2Trq3Uj9yzWAPbG7fIN1b8/CFlNBQXI4tv8BGqu3GIxMd7
         acFTNdSuWPN/x/5hsiyTOvwrNXCYSIq+R0lxCN/HjyuDIhF7uMxh8PD8r9wsQ23EX7qu
         JCjg0odMGrwkrMHMVg9x4f5mFDRofZYS85cxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698183677; x=1698788477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qlj3Zfises7r0D8qFU0FTbLuXsSPwTC7ghoEI6cXzzE=;
        b=adOZjajCTf9MFYuMA1jgF772R1eeL8Afqz0V5G7cfQQdU5LbPqMfiFt5YyV2sYEtr8
         0+j8AGvUZWvm9HoJdYXHNCyrlvZcPMFRxJKqcbrTcNp999F37iMr5QNZf3elSopXmtNX
         FAEOdFCenT//pKXLU7QOiAL7wbmT6SpxrIBHCwzFAYAirtTYg56YhutQZ4ZUmK99gRBk
         RWvIEjAi+vRLIRY63xopsDht/nOdbLqh8hWpHu8/iYjBEhgdozy71bDRoM3JfOiYKTje
         Jlo5dfbz4/QeNqTzRgFUE5hf6KMmB1IONO1oY7wCcnFifjWQAuSSO7JedW4thWk8J6mO
         LbCw==
X-Gm-Message-State: AOJu0Yw1+Mgls7GNh23lb7SSpoTosEZp9SV82jR4NarC5FuTDF+7nHJl
        ioy7Wv/lslVNtPECZuegFrzfDQ==
X-Google-Smtp-Source: AGHT+IGxvWj9Xsu3pRzsZTnMyZCtBlY1xbUa07gBVG2GR0HjQ/NJi+InpJB7d3yeYs2gM51dcxBfDg==
X-Received: by 2002:a17:902:c215:b0:1c7:3558:721a with SMTP id 21-20020a170902c21500b001c73558721amr10294915pll.58.1698183677103;
        Tue, 24 Oct 2023 14:41:17 -0700 (PDT)
Received: from sjg1.roam.corp.google.com ([202.144.206.130])
        by smtp.gmail.com with ESMTPSA id 18-20020a170902c21200b001c5f7e06256sm7861055pll.152.2023.10.24.14.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:41:16 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     devicetree@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Michael Walle <mwalle@kernel.org>,
        Tom Rini <trini@konsulko.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>, Simon Glass <sjg@chromium.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] dt-bindings: mtd: binman-partition: Add binman compatibles
Date:   Wed, 25 Oct 2023 10:39:17 +1300
Message-ID: <20231024213940.3590507-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231024213940.3590507-1-sjg@chromium.org>
References: <20231024213940.3590507-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two compatible for binman entries, as a starting point for the
schema.

Note that, after discussion on v2, we decided to keep the existing
meaning of label so as not to require changes to existing userspace
software when moving to use binman nodes to specify the firmware
layout.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v5:
- Add mention of why 'binman' is the vendor
- Drop  'select: false'
- Tidy up the compatible setings
- Use 'tfa-bl31' instead of 'atf-bl31'

Changes in v4:
- Correct selection of multiple compatible strings

Changes in v3:
- Drop fixed-partitions from the example
- Use compatible instead of label

Changes in v2:
- Use plain partition@xxx for the node name

 .../mtd/partitions/binman-partition.yaml      | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
new file mode 100644
index 00000000000000..37a413464b0ce5
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Google LLC
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/binman-partition.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Binman partition
+
+maintainers:
+  - Simon Glass <sjg@chromium.org>
+
+description: |
+  This corresponds to a binman 'entry'. It is a single partition which holds
+  data of a defined type.
+
+  The vendor is specified as binman since there are quite a number
+  of binman-specific entry types, such as section, fill and files,
+  to be added later.
+
+allOf:
+  - $ref: /schemas/mtd/partitions/partition.yaml#
+
+properties:
+  compatible:
+    - enum:
+        - binman,entry # generic binman entry
+        - u-boot       # u-boot.bin from U-Boot project
+        - tfa-bl31     # bl31.bin or bl31.elf from TF-A project
+
+additionalProperties: false
+
+examples:
+  - |
+    partitions {
+        compatible = "binman";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@100000 {
+            compatible = "u-boot";
+            reg = <0x100000 0xf00000>;
+        };
+
+        partition@200000 {
+            compatible = "tfa-bl31";
+            reg = <0x200000 0x100000>;
+        };
+    };
-- 
2.42.0.758.gaed0368e0e-goog

