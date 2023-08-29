Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4165778CCD9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbjH2TSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239088AbjH2TSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:18:23 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDF3185
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 12:18:19 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7950fac19f2so34599039f.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 12:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693336699; x=1693941499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asdwWrQgSDUsQBbMFgdwSUCGxAMIv135nq9+k2HMaa0=;
        b=RDPVP53Na4RjKIWVH4dYAGzx+P4LsBWFkOALAa+gmqqY5yCjmdWpCUpTFmxELphu2N
         u4XclXHLKT62uF4s7WWpt2ZIHom/6aI9lesxGW2jk1l7yERIEsKbHwUglbAhdF7oCBzl
         F6/WkjbcJ2idMkWbb3YsaIKzXq8ompF2DDfgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693336699; x=1693941499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asdwWrQgSDUsQBbMFgdwSUCGxAMIv135nq9+k2HMaa0=;
        b=SPSCUpXapNjKAkq2AgQYMZjuhTG9zX2iSvrMvS9fwA/S0nLpLOKAM0w8FXHFhv7AhH
         vG0O4Cx2dNRnalR1jv27nrZDU0589A3A7k/VuS+T3RSkhhea/gRtx8xte15jSR4HrooR
         1L8ahVLr5A6g8xsloiekzg8zcFa9Unj34QMNp4FjXh/YxbNWljXVgVquBYKT02X09ciS
         uwo4IVyNmIa5F69IzGq/NuEwIL/HDQbAYKKVRc+C8mp4Wl9DZgPQSKaOF8hRMKHGxzne
         OmtZBOypuCt5T66cuolQ0OnWKGiU/KtkA6GyImy2EiE3RecAYsyR7F5bhrkEzO0nmZLN
         rKvg==
X-Gm-Message-State: AOJu0YwVWGHWjUu7yWFhcr8rzXrvwbpZeoo3HmuqiTEzo37MLRLz+bVj
        vwBNltLNXNA9QpamMhkyomy54Q==
X-Google-Smtp-Source: AGHT+IGAS+bTigCPmRP0jxu5uZgQG+yMGKUfr6n4pFO5Py5STv9I4dkw/kX8J7iBq5DSVfvEGDSG5w==
X-Received: by 2002:a5d:990f:0:b0:790:fc73:6e3c with SMTP id x15-20020a5d990f000000b00790fc736e3cmr332445iol.8.1693336699097;
        Tue, 29 Aug 2023 12:18:19 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:16d9:c947:1a18:4c10])
        by smtp.gmail.com with ESMTPSA id fq8-20020a056638650800b004332f6537e2sm3359798jab.83.2023.08.29.12.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 12:18:18 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     devicetree@vger.kernel.org
Cc:     Dhaval Sharma <dhaval@rivosinc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Gua Guo <gua.guo@intel.com>, Tom Rini <trini@konsulko.com>,
        Rob Herring <robh@kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        ron minnich <rminnich@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Lean Sheng Tan <sheng.tan@9elements.com>,
        Maximilian Brune <maximilian.brune@9elements.com>,
        Chiu Chasel <chasel.chiu@intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        linux-acpi@vger.kernel.org, Guo Dong <guo.dong@intel.com>,
        Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 3/4] schemas: Add a schema for memory map
Date:   Tue, 29 Aug 2023 13:18:08 -0600
Message-ID: <20230829191812.135759-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230829191812.135759-1-sjg@chromium.org>
References: <20230829191812.135759-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Devicetree specification skips over handling of a logical view of
the memory map, pointing users to the UEFI specification.

It is common to split firmware into 'Platform Init', which does the
initial hardware setup and a "Payload" which selects the OS to be booted.
Thus an handover interface is required between these two pieces.

Where UEFI boot-time services are not available, but UEFI firmware is
present on either side of this interface, information about memory usage
and attributes must be presented to the "Payload" in some form.

This aims to provide an initial schema for this mapping.

Note that this is separate from the existing /memory and /reserved-memory
nodes, since it is mostly concerned with what the memory is used for. It
may cover only a small fraction of available memory.

For now, no attempt is made to create an exhaustive binding, so there are
some example types listed. This can be completed once this has passed
initial review.

The compatible string is not included, since the node name is enough to
indicate the purpose of a node, as per the existing reserved-memory
schema.

This binding does not include a binding for the memory 'attribute'
property, defined by EFI_BOOT_SERVICES.GetMemoryMap(). It may be useful
to have that as well, but perhaps not as a bit mask.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Make use of the reserved-memory node instead of creating a new one

Changes in v3:
- Reword commit message again
- cc a lot more people, from the FFI patch
- Split out the attributes into the /memory nodes

Changes in v2:
- Reword commit message

 dtschema/schemas/memory-map.yaml              | 61 +++++++++++++++++++
 .../reserved-memory/common-reserved.yaml      | 53 ++++++++++++++++
 2 files changed, 114 insertions(+)
 create mode 100644 dtschema/schemas/memory-map.yaml
 create mode 100644 dtschema/schemas/reserved-memory/common-reserved.yaml

diff --git a/dtschema/schemas/memory-map.yaml b/dtschema/schemas/memory-map.yaml
new file mode 100644
index 0000000..4b06583
--- /dev/null
+++ b/dtschema/schemas/memory-map.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: BSD-2-Clause
+# Copyright 2023 Google LLC
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-map.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: /memory-map nodes
+description: |
+  Common properties always required in /memory-map nodes. These nodes are
+  intended to resolve the nonchalant clause 3.4.1 ("/memory node and UEFI")
+  in the Devicetree Specification.
+
+maintainers:
+  - Simon Glass <sjg@chromium.org>
+
+properties:
+  $nodename:
+    const: 'memory-map'
+
+patternProperties:
+  "^([a-z][a-z0-9\\-]+@[0-9a-f]+)?$":
+    type: object
+    additionalProperties: false
+
+    properties:
+      reg:
+        minItems: 1
+        maxItems: 1024
+
+      usage:
+        $ref: /schemas/types.yaml#/definitions/string
+        description: |
+          Describes the usage of the memory region, e.g.:
+
+            "acpi-reclaim", "acpi-nvs", "bootcode", "bootdata", "bootdata",
+            "runtime-code", "runtime-data".
+
+            See enum EFI_MEMORY_TYPE in "Unified Extensible Firmware Interface
+            (UEFI) Specification" for all the types. For now there are not
+            listed here.
+
+    required:
+      - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    memory-map {
+        acpi@f0000 {
+            reg = <0xf0000 0x4000>;
+            usage = "acpi-reclaim";
+        };
+
+        runtime@12300000 {
+            reg = <0x12300000 0x28000>;
+            usage = "runtime-code";
+        };
+    };
+...
diff --git a/dtschema/schemas/reserved-memory/common-reserved.yaml b/dtschema/schemas/reserved-memory/common-reserved.yaml
new file mode 100644
index 0000000..70cdead
--- /dev/null
+++ b/dtschema/schemas/reserved-memory/common-reserved.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/common-reserved.yaml#
+$schema: http://devicetree.org/meta-schemas/base.yaml#
+
+title: Common memory reservations
+
+description: |
+  Specifies that the reserved memory region can be used for the purpose
+  indicated by its node name.
+
+  Clients may reuse this reserved memory if they understand what it is for.
+
+maintainers:
+  - Simon Glass <sjg@chromium.org>
+
+# always select the core schema
+select: true
+
+properties:
+    $nodename:
+    oneOf:
+      - acpi-reclaim
+      - acpi-nvs
+      - boot-code
+      - boot-data
+      - runtime-code
+      - runtime-data
+
+  reg:
+    description: region of memory that is reserved for the purpose indicated
+      by the node name.
+
+required:
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    reserved-memory {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        boot-code@12340000 {
+            reg = <0x12340000 0x00800000>;
+        };
+
+        boot-data@43210000 {
+            reg = <0x43210000 0x00800000>;
+        };
+    };
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

