Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EF478E326
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 01:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344462AbjH3XSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 19:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240280AbjH3XSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 19:18:35 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C021E43
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 16:18:17 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-77ac14ff51bso11460739f.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 16:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693437496; x=1694042296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY2cU6JGuZrguIyfLb09NlceqC/Y62AT/KhqZYbIbwU=;
        b=M942CseN4xXa7ivkN3BQ9ivaUDeaX11zck40TQgJZ7eE9yfunHmrPWwL7oyxKDAHF7
         0zvPrCY65S9NnUXzqwpP8gTCEo4NfmUuA6CkeJOSEttfV5HAiQlD4cW/tMxVKR5vWtaf
         u8QANLGfifUWO9TKEFik3R95p/ZOjrZqmdL+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693437496; x=1694042296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HY2cU6JGuZrguIyfLb09NlceqC/Y62AT/KhqZYbIbwU=;
        b=I7iwZ86s/SapKJAlIZnllRrf8//z72Vh7kbrTxl0Yf1qhdxdW92pqGYnmc5zSfXBMU
         /WAxtAGBYwRtssttc5n2tcncZAUNLjBBH0fOP4Y/K93vSGGQ41utK/2K7H6oO2/CyzV4
         9ch3zRNWixap1rpHnKt3OvB132saZlYHOisoCd6YRSa7QmFTeY3el1m5Drp5s5LvsHif
         XcS0C7NRpSVfk46jYRtMO4XRtcK4z4XpMhni43qXpF02ElDvbDjXMmMVfWo4BKV1lj8x
         TM5abgWBW1AtOeuISn6raPet0z0kij1eNEi8KDN7qM+hmxr74axevNkUL7okqtv4ek0X
         sgwA==
X-Gm-Message-State: AOJu0YxzKhQs1raSPvZWFmi6Bn86rQLWlzAyi4ZlUA6L+m0vCLllJHIn
        BdaAhrIkjkxXnCT263KIprqi5g==
X-Google-Smtp-Source: AGHT+IEDA6Kz+88UsYqnGtgINRuvJ4OfWV7BCV1mSX3IDTB900P56/Cp3vrRoaq3PqkXR21lxfX66Q==
X-Received: by 2002:a6b:6112:0:b0:790:f733:2f9e with SMTP id v18-20020a6b6112000000b00790f7332f9emr3861880iob.13.1693437496510;
        Wed, 30 Aug 2023 16:18:16 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
        by smtp.gmail.com with ESMTPSA id z25-20020a5ec919000000b007951e14b951sm73360iol.25.2023.08.30.16.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 16:18:16 -0700 (PDT)
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
Subject: [PATCH v5 4/4] memory: Add ECC properties
Date:   Wed, 30 Aug 2023 17:17:52 -0600
Message-ID: <20230830231758.2561402-4-sjg@chromium.org>
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

Some memories provide ECC detection and/or correction. For software which
wants to check memory, it is helpful to see which regions provide this
feature.

Add this as a property of the /memory nodes, since it presumably follows
the hardware-level memory system.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v5:
- Redo to make this property specific to ECC
- Provide properties both for detection and correction

Changes in v3:
- Add new patch to update the /memory nodes

 dtschema/schemas/memory.yaml | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/dtschema/schemas/memory.yaml b/dtschema/schemas/memory.yaml
index 1d74410..944aa9f 100644
--- a/dtschema/schemas/memory.yaml
+++ b/dtschema/schemas/memory.yaml
@@ -34,7 +34,37 @@ patternProperties:
         description:
           For the purpose of identification, each NUMA node is associated with
           a unique token known as a node id.
+      ecc-detection:
+        $ref: /schemas/types.yaml#/definitions/string
+        enum:
+          - none
+          - single-bit
+          - multi-bit
+        description: |
+          If present, this inidcates the type of memory errors which can be
+          detected and reported by the Error-Correction Code (ECC) memory
+          subsystem:
 
+            none       - No error detection is possible
+            single-bit - Detects and reports single-bit ECC errors
+            multi-bit  - Detects and reports multiple-bit ECC errors
+
+          If not present, this is equivalent to 'none'.
+      ecc-correction:
+        $ref: /schemas/types.yaml#/definitions/string
+        enum:
+          - none
+          - single-bit
+          - multi-bit
+        description: |
+          If present, this inidcates the type of memory errors which can be
+          corrected by the Error-Correction Code (ECC) memory subsystem:
+
+            none       - No error correction is possible
+            single-bit - Corrects single-bit ECC errors
+            multi-bit  - Corrects multiple-bit ECC errors
+
+          If not present, this is equivalent to 'none'.
 
     required:
       - device_type
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

