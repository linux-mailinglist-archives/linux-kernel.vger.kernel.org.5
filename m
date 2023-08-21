Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F00C783134
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjHUTsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHUTse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:48:34 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AB6E8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:48:32 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-79194701ce9so126926539f.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692647312; x=1693252112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3N7X/HZKiODl+6+MNX6JndqNW1xPMfJ5KlQEIhhEp20=;
        b=donK6i774XrVXYP+eFrBY/Un4gIoAVwXckSA4zoLb4QBZYzF5hY1hU1F0BosScRQZ7
         l8eJtPP5cxDUF78dsofEIp4j0EcKrNglBt9oSms17GThKXCDrYdb5byaw/WwyU/nlFex
         UW6rQKBjf9lgmZW8uJ/Z05szJXngqVckaTEWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692647312; x=1693252112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3N7X/HZKiODl+6+MNX6JndqNW1xPMfJ5KlQEIhhEp20=;
        b=G0qa9f9Q+8gIO3Lta4xT1mgsafSVIumLF1I9P5qPeqNngPOF/YxyyJ4hiRpeiwwyE/
         eGgmRg6NbF2i9M/JeJb/RMcA5KWU6JnSN6VB6HQn22rc6xFOOF1kRa3jYgFiTfuA56Si
         T9WUuDxIB/VCM9XzKNMw8iyZcrow/hdNdBg5Ij5fpjM8K5mgg+cMe2vhmISRo1qFy4vf
         bpA/zDGmGJM7xUQqBXfj25Ff7I6FWWjviY2VAP6UG0Xaesfto6ka5E+e2oW+i/bexOmE
         amEJzwNyDD9TEXQZYud8gMq8ov60pv6zIf1++D5MnXFYi2YkhDKc447J6RN+tFRO6x03
         0M9g==
X-Gm-Message-State: AOJu0Yxs3Wsl+Lvttu3TqlJgjKosgwos9Z1AVaUnVYCL7OawbcljNM5x
        o+94xnYGjunlxflaHpUp8WFzGQ==
X-Google-Smtp-Source: AGHT+IFcu3IPYhGGuLvsyVJO8RzW3hUh7Hrcr3zrfVG6DkyEQPecWurr30tfPYr4FOJh+8GUA9xkMA==
X-Received: by 2002:a05:6602:690:b0:785:5917:a35f with SMTP id dp16-20020a056602069000b007855917a35fmr10766390iob.8.1692647312413;
        Mon, 21 Aug 2023 12:48:32 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:9102:8976:7620:5093])
        by smtp.gmail.com with ESMTPSA id o21-20020a02c6b5000000b0042b0ce92dddsm2552076jan.161.2023.08.21.12.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 12:48:32 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     devicetree@vger.kernel.org
Cc:     Lean Sheng Tan <sheng.tan@9elements.com>,
        Tom Rini <trini@konsulko.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Chiu Chasel <chasel.chiu@intel.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Gua Guo <gua.guo@intel.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2] schemas: Add a schema for memory map
Date:   Mon, 21 Aug 2023 13:48:19 -0600
Message-ID: <20230821194821.2961213-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
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

The Devicespec specification skips over handling of a logical view of
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
may cover only a small fraction of available memory, although it could be
used to signal which area of memory has ECC.

For now, no attempt is made to create an exhaustive binding, so there are
some example types lists. This can be completed once this has passed
initial review.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Reword commit message

 dtschema/schemas/memory-map.yaml | 51 ++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 dtschema/schemas/memory-map.yaml

diff --git a/dtschema/schemas/memory-map.yaml b/dtschema/schemas/memory-map.yaml
new file mode 100644
index 0000000..97e531e
--- /dev/null
+++ b/dtschema/schemas/memory-map.yaml
@@ -0,0 +1,51 @@
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
+    const: '/'
+  usage:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      Describes the usage of the memory region, e.g.:
+
+        "acpi-reclaim", "acpi-nvs", "bootcode", "bootdata", "bootdata",
+        "runtime-code", "runtime-data"
+  attr:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: |
+      Attributes possessed by this memory region:
+
+        "single-bit-ecc" - supports single-bit ECC
+        "multi-bit-ecc" - supports multiple-bit ECC
+        "no-ecc" - non-ECC memory
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
+    required:
+      - reg
+
+additionalProperties: true
+
+...
-- 
2.42.0.rc1.204.g551eb34607-goog

