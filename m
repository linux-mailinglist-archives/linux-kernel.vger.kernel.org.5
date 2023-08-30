Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC2E78E320
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 01:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344403AbjH3XSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 19:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344402AbjH3XSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 19:18:21 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D79C2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 16:18:15 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7927f36120cso11966539f.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 16:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693437495; x=1694042295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHtRVfZdazalwXF7/K/X+IK1quBJnoh9ttNrkKe1UhE=;
        b=MyqsxcjLJHpDx+Zuo9Crtc2OR4po45WncypPEfOpEPkTUhzHbjl7K0V5dcg2fiEn23
         TqFBlVSVrj5/ClksIcvWTJIdRDCAdSkJehN2yIpkLZ/myDaJTD7eKP/NKl2hVZn91FMB
         9c2GjWRAMTmPvkd0/NMUhF3kwdEmY3TJiqtJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693437495; x=1694042295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHtRVfZdazalwXF7/K/X+IK1quBJnoh9ttNrkKe1UhE=;
        b=FpHo72rtVymqbjX9urVrl6YRRvlp8x/tK2ntKs4a/UZI/g/OCjM9FlgtJHLrDrVYbE
         jGjkYdnJKkg6AD0UyDzezPg4S8oKeAuyskfcNY2FpJ0NNqbvRTJ6ohNNDbJR4YNoPQlJ
         X3pO0ia4dEIZ3MCzHeIGGWxXB3t+EIVye1QopW9LF10nkvO5TXMGKLes2Mapmg3cYLDS
         ouikSkggL5uIgN/lCWtZzX2mzfwoPnSAhSWu+V+QmrWNbnDCE60bM6DN8dzDNs0J2Qbo
         NI7LwNUE4hLG6XtJq6ZpKO4kqy9dxiUyRQbjLwxBIl1K+UeMDxOKtpB9cmxKgOxyp2zN
         44Yw==
X-Gm-Message-State: AOJu0YwsO1jH9R/Q1inPq6op1RvH4+lPMNXF7E9hmmAtqujsXa0ciEKe
        le6RTu5xFwQFkFxkVFXvnT8lrQ==
X-Google-Smtp-Source: AGHT+IEakavImaUnpU6sdboDG8r+uspqLawPT8R+8zuQfCmFsnJ9iwEhtG5lpm0/Jpn3CMcMbrd35w==
X-Received: by 2002:a5e:d510:0:b0:783:6eef:1496 with SMTP id e16-20020a5ed510000000b007836eef1496mr3804390iom.19.1693437494858;
        Wed, 30 Aug 2023 16:18:14 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
        by smtp.gmail.com with ESMTPSA id z25-20020a5ec919000000b007951e14b951sm73360iol.25.2023.08.30.16.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 16:18:14 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     devicetree@vger.kernel.org
Cc:     Maximilian Brune <maximilian.brune@9elements.com>,
        ron minnich <rminnich@gmail.com>,
        Tom Rini <trini@konsulko.com>,
        Dhaval Sharma <dhaval@rivosinc.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        linux-acpi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Gua Guo <gua.guo@intel.com>,
        Lean Sheng Tan <sheng.tan@9elements.com>,
        Guo Dong <guo.dong@intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Chiu Chasel <chasel.chiu@intel.com>,
        Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 2/4] Bring in some other reserved-memory files
Date:   Wed, 30 Aug 2023 17:17:50 -0600
Message-ID: <20230830231758.2561402-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230830231758.2561402-1-sjg@chromium.org>
References: <20230830231758.2561402-1-sjg@chromium.org>
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

Add schema yaml files from v6.5 which are not vendor-specific, nor
Linux-specific.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v5:
- Trim back to just a subset of mostly generic schemas

Changes in v4:
- New patch

 .../schemas/reserved-memory/framebuffer.yaml  | 52 ++++++++++
 .../reserved-memory/memory-region.yaml        | 40 ++++++++
 .../reserved-memory/shared-dma-pool.yaml      | 97 +++++++++++++++++++
 3 files changed, 189 insertions(+)
 create mode 100644 dtschema/schemas/reserved-memory/framebuffer.yaml
 create mode 100644 dtschema/schemas/reserved-memory/memory-region.yaml
 create mode 100644 dtschema/schemas/reserved-memory/shared-dma-pool.yaml

diff --git a/dtschema/schemas/reserved-memory/framebuffer.yaml b/dtschema/schemas/reserved-memory/framebuffer.yaml
new file mode 100644
index 0000000..851ec24
--- /dev/null
+++ b/dtschema/schemas/reserved-memory/framebuffer.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/framebuffer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: /reserved-memory framebuffer node
+
+maintainers:
+  - devicetree-spec@vger.kernel.org
+
+allOf:
+  - $ref: reserved-memory.yaml
+
+properties:
+  compatible:
+    const: framebuffer
+    description: >
+      This indicates a region of memory meant to be used as a framebuffer for
+      a set of display devices. It can be used by an operating system to keep
+      the framebuffer from being overwritten and use it as the backing memory
+      for a display device (such as simple-framebuffer).
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    / {
+        compatible = "foo";
+        model = "foo";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        chosen {
+            framebuffer {
+                compatible = "simple-framebuffer";
+                memory-region = <&fb>;
+            };
+        };
+
+        reserved-memory {
+            #address-cells = <1>;
+            #size-cells = <1>;
+            ranges;
+
+            fb: framebuffer@80000000 {
+                compatible = "framebuffer";
+                reg = <0x80000000 0x007e9000>;
+            };
+        };
+    };
+...
diff --git a/dtschema/schemas/reserved-memory/memory-region.yaml b/dtschema/schemas/reserved-memory/memory-region.yaml
new file mode 100644
index 0000000..592f180
--- /dev/null
+++ b/dtschema/schemas/reserved-memory/memory-region.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/memory-region.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Reserved Memory Region
+
+maintainers:
+  - devicetree-spec@vger.kernel.org
+
+description: |
+  Regions in the /reserved-memory node may be referenced by other device
+  nodes by adding a memory-region property to the device node.
+
+select: true
+
+properties:
+  memory-region:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: >
+      Phandle to a /reserved-memory child node assigned to the device.
+
+  memory-region-names:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: >
+      A list of names, one for each corresponding entry in the
+      memory-region property
+
+additionalProperties: true
+
+examples:
+  - |
+    fb0: video@12300000 {
+        /* ... */
+        reg = <0x12300000 0x1000>;
+        memory-region = <&display_reserved>;
+    };
+
+...
diff --git a/dtschema/schemas/reserved-memory/shared-dma-pool.yaml b/dtschema/schemas/reserved-memory/shared-dma-pool.yaml
new file mode 100644
index 0000000..457de09
--- /dev/null
+++ b/dtschema/schemas/reserved-memory/shared-dma-pool.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/shared-dma-pool.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: /reserved-memory DMA pool
+
+maintainers:
+  - devicetree-spec@vger.kernel.org
+
+allOf:
+  - $ref: reserved-memory.yaml
+
+properties:
+  compatible:
+    oneOf:
+      - const: shared-dma-pool
+        description: >
+          This indicates a region of memory meant to be used as a shared
+          pool of DMA buffers for a set of devices. It can be used by an
+          operating system to instantiate the necessary pool management
+          subsystem if necessary.
+
+      - const: restricted-dma-pool
+        description: >
+          This indicates a region of memory meant to be used as a pool
+          of restricted DMA buffers for a set of devices. The memory
+          region would be the only region accessible to those devices.
+          When using this, the no-map and reusable properties must not
+          be set, so the operating system can create a virtual mapping
+          that will be used for synchronization. The main purpose for
+          restricted DMA is to mitigate the lack of DMA access control
+          on systems without an IOMMU, which could result in the DMA
+          accessing the system memory at unexpected times and/or
+          unexpected addresses, possibly leading to data leakage or
+          corruption. The feature on its own provides a basic level of
+          protection against the DMA overwriting buffer contents at
+          unexpected times. However, to protect against general data
+          leakage and system memory corruption, the system needs to
+          provide way to lock down the memory access, e.g., MPU. Note
+          that since coherent allocation needs remapping, one must set
+          up another device coherent pool by shared-dma-pool and use
+          dma_alloc_from_dev_coherent instead for atomic coherent
+          allocation.
+
+  linux,cma-default:
+    type: boolean
+    description: >
+      If this property is present, then Linux will use the region for
+      the default pool of the contiguous memory allocator.
+
+  linux,dma-default:
+    type: boolean
+    description: >
+      If this property is present, then Linux will use the region for
+      the default pool of the consistent DMA allocator.
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: restricted-dma-pool
+then:
+  properties:
+    no-map: false
+    reusable: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+      reserved-memory {
+          #address-cells = <1>;
+          #size-cells = <1>;
+          ranges;
+
+          /* global autoconfigured region for contiguous allocations */
+          linux,cma {
+              compatible = "shared-dma-pool";
+              reusable;
+              size = <0x4000000>;
+              alignment = <0x2000>;
+              linux,cma-default;
+          };
+
+          display_reserved: framebuffer@78000000 {
+              reg = <0x78000000 0x800000>;
+          };
+
+          restricted_dma_reserved: restricted-dma-pool@50000000 {
+              compatible = "restricted-dma-pool";
+              reg = <0x50000000 0x4000000>;
+          };
+      };
+
+...
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

