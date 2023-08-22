Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BA7784B78
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 22:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjHVUfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 16:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHVUe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 16:34:59 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7F1CEE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 13:34:56 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-792437be990so51586739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 13:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692736495; x=1693341295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EQi7QRj3DomGJNq77fSPrkeQ/5P45CBX8SOOZ9egyGY=;
        b=XBVW9o6x4KH2aCFdnr1+cajztmT4qOPkS38+3KWb80IYCTIE/cDT2m7Q1cGzg9b1Vf
         G6ylQeW1DnqKRObzW2ZE014/yIgDz0TNNYo2juLa948F8fSNiNUUILFzGCIm1/B2lVgJ
         7w1aZCUpmGCvqJPGioKkUOs4lrVT4dj2CIHCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692736495; x=1693341295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EQi7QRj3DomGJNq77fSPrkeQ/5P45CBX8SOOZ9egyGY=;
        b=Zm99Yu/OSpqVKy4Z6ow784qIGh3X4IsJCRPH+BXzDRPURiR5/8PSYh6pjNikwWZlTK
         ovsMTnidYPaWLq10wUg7kv4Y1n7iZ3hcTYzfQjloabGH21FwYVUX8OBpkpb4Bd/DLbFb
         beTZqoodPehU409Er1e6iMxEYhSEm8aYVQQmA8w83QjMaA4kX35x3aiK3511WpNoCMcg
         mbK1IR3DgNTx7ADifbY2PRzc8jbWcrqbxeQjam2xgPTuBl+hSUVDX35rjbSYG4QqVrR7
         PrdvOZlFM6ZBz01PQ2oTCBHsZoCsvMebyOkwf33LeEdS3pfymSUZtO3oKcQpml00b2+O
         hiJA==
X-Gm-Message-State: AOJu0Ywgp/V6eEEmoHsUHl2PG44znBem9kjbc3r7oINUbNW8lwN4IBDp
        uEquwxgIB0+rB0o+i/4ayS0A0Q==
X-Google-Smtp-Source: AGHT+IG7GwprJP1540358w3OKonK7RTDA7jAtXMa1F0tKSSk5KGEYAodBigGr7WB4czbJykGoyCX8Q==
X-Received: by 2002:a5d:930c:0:b0:790:fab3:2052 with SMTP id l12-20020a5d930c000000b00790fab32052mr815521ion.5.1692736495526;
        Tue, 22 Aug 2023 13:34:55 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b7f:10f7:eb5:da54])
        by smtp.gmail.com with ESMTPSA id s20-20020a5eaa14000000b0078754bed499sm3500745ioe.37.2023.08.22.13.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 13:34:54 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     devicetree@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Chiu Chasel <chasel.chiu@intel.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Gua Guo <gua.guo@intel.com>, linux-acpi@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        ron minnich <rminnich@gmail.com>,
        Tom Rini <trini@konsulko.com>,
        Lean Sheng Tan <sheng.tan@9elements.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 1/2] schemas: Add a schema for memory map
Date:   Tue, 22 Aug 2023 14:34:42 -0600
Message-ID: <20230822203446.4111742-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

This binding does not include a binding for the memory 'attribute'
property, defined by EFI_BOOT_SERVICES.GetMemoryMap(). It may be useful
to have that as well, but perhaps not as a bit mask.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Reword commit message again
- cc a lot more people, from the FFI patch
- Split out the attributes into the /memory nodes

Changes in v2:
- Reword commit message

 dtschema/schemas/memory-map.yaml | 61 ++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 dtschema/schemas/memory-map.yaml

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
-- 
2.42.0.rc1.204.g551eb34607-goog

