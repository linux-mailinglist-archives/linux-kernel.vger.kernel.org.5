Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4113785940
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbjHWN2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbjHWN2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:28:31 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A4F1734
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:27:57 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52a1ce529fdso2214432a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692797276; x=1693402076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haatfWR2uR8UKXBeB48Hj2MdGE5hoyzIE8VGVa/sO+A=;
        b=tOFOkYrYhirr1WisUkU6WO+GRHNoY6CJ4p0m4YmOja0bY3LXMUE5VXnWZt2R6Pil+2
         oieTWXB0sPwJZhXIn8ky7oB3LXWMFZTnKy2KEzd/nfzYTd/WcRUUbLRwwZqknadE/UF6
         +Qg/KGHAgg+gmHaQnNzpvpkR18JWW88eHURZfg8Uj5ZpT7alhSrN1ehiFPGLAVt73IBI
         jxmUg9cLF7aA+9nBCaXRCfNH9il/4j6EUppBK3LULEeHYrVwZ64d88RaphFw1XBeLET2
         w+goC2LFfOH6SNIsYAdiz4g/omOrMh72hsMzImC3FHf1diKHW42PmygPSa+oUNLjpwLH
         jwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797276; x=1693402076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haatfWR2uR8UKXBeB48Hj2MdGE5hoyzIE8VGVa/sO+A=;
        b=e/cQkAoqkOCA9UjHRkaSTSiDMrRF9+x3qs2gft8X+eE6nbKm6aWr1AGZk1fISArfSh
         zAm43Eg1PMKTMNx1hrZVCGCiCt+qqyoyR+Xx3JXut+2NMZi2fXvVldaeCu0vQF8SSncC
         FO4Aawe41GJWxLJ1A32S/TajORoB2yoeQ8Qm+lEb+V5+JTFPLBSWLpHpSKDSHtntF2t3
         86e7wHDX3P537yrdpKsd4XRsVfuFH1mMbuY68ejpq11P09GWuXex+5FexCHh0JTV+9qB
         XBM2nThPT/dpt7+K9684NzQiXaS8yIJQvg4bwA329Cp8UoES0iLiVRXqGdvm5YorYyQR
         Q91A==
X-Gm-Message-State: AOJu0YzxJUWT5R7Kj8zbacfZE61wYqX+T5rpYbEK0YN/RfCCCOhYIpye
        sLF0d3oVBC6UEBSw8NJwtB4dbw==
X-Google-Smtp-Source: AGHT+IE46sXZropk6uA3nUYbgv61dCfO7AipKke6dtQnjDZaAfsH9+1z6IoANib3Y/Nszg/VfKZ7vQ==
X-Received: by 2002:a17:907:7603:b0:9a1:e395:2d10 with SMTP id jx3-20020a170907760300b009a1e3952d10mr1133468ejc.75.1692797275762;
        Wed, 23 Aug 2023 06:27:55 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709066b8900b009a168ab6ee2sm8918202ejr.164.2023.08.23.06.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:27:54 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 01/22] dt-bindings: nvmem: fixed-cell: add compatible for MAC cells
Date:   Wed, 23 Aug 2023 14:27:23 +0100
Message-Id: <20230823132744.350618-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
References: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4535; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=6qs4F6uFdu1duv8ahk7XqHZRwt7L1qU4fj3+gWue0lg=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBk5glCeDiXRIsyZCqShwuOJfq9/waNoYZ35vC02 9YuIcctVeCJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZOYJQgAKCRB6of1ZxzRV N0JVB/9Bi95KfkpvyEIjwXg7YNN/VePyeOv1z3aWBpTnd/JoJ13BjfjocKQbjKOxAPkFM+gdhor kj7fO8A1eU71ryaPorgV0eHW8ZzcBLlbvhumopKV3TKrx81kjpSu341Fhesr+nNhUfyyJ8/ZDDe WmAqZzhTUo6XNo+YssP07Vqh+c6m13pRuVdqeq9JsBOcTJutLXxO9wcQ/mGr9luYGR8j6Ii6BFT U3ihF04jL5qmCKDx6fINrRq79zGcVlvDBgluYmT1q8nvtPGOf9S+VbtrO4BQZkbbUvK2KV20mqs MG0bWLKFddeFr9ZF5PBZLUPkPozWNm7yIChm3Gn9pUcNThdA
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

A lot of home routers have NVMEM fixed cells containing MAC address that
need some further processing. In ~99% cases MAC needs to be:
1. Optionally parsed from ASCII format
2. Increased by a vendor-picked value

There was already an attempt to design a binding for that at NVMEM
device level in the past. It wasn't accepted though as it didn't really
fit NVMEM device layer.

The introduction of NVMEM fixed-cells layout seems to be an opportunity
to provide a relevant binding in a clean way.

This commit adds a *generic* compatible string: "mac-base". As always it
needs to be carefully reviewed.

OpenWrt project currently supports ~300 home routers that have NVMEM
cell with binary-stored base MAC.T hose devices are manufactured by
multiple vendors. There are TP-Link devices (76 of them), Netgear (19),
D-Link (11), OpenMesh (9), EnGenius (8), GL.iNet (8), ZTE (7),
Xiaomi (5), Ubiquiti (6) and more. Those devices don't share an
architecture or SoC.

Another 200 devices have base MAC stored in an ASCII format (not all
those devices have been converted to DT though).

It would be impractical to provide unique "compatible" strings for NVMEM
layouts of all those devices. It seems like a valid case for allowing a
generic binding instead. Even if this binding will not be sufficient for
some further devices it seems to be useful enough as it is.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/nvmem/layouts/fixed-cell.yaml    | 26 +++++++++++++++++++
 .../bindings/nvmem/layouts/fixed-layout.yaml  | 12 +++++++++
 .../devicetree/bindings/nvmem/nvmem.yaml      |  5 +++-
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml b/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
index e698098450e1..ac2381e66027 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
@@ -11,6 +11,15 @@ maintainers:
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 
 properties:
+  compatible:
+    oneOf:
+      - const: mac-base
+        description: >
+          Cell with base MAC address to be used for calculating extra relative
+          addresses.
+          It can be stored in a plain binary format (cell length 6) or as an
+          ASCII text like "00:11:22:33:44:55" (cell length 17).
+
   reg:
     maxItems: 1
 
@@ -25,6 +34,23 @@ properties:
         description:
           Size in bit within the address range specified by reg.
 
+allOf:
+  - if:
+      required: [ compatible ]
+    then:
+      if:
+        properties:
+          compatible:
+            contains:
+              const: mac-base
+      then:
+        properties:
+          "#nvmem-cell-cells":
+            description: The first argument is a MAC address offset.
+            const: 1
+        required:
+          - "#nvmem-cell-cells"
+
 required:
   - reg
 
diff --git a/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
index c271537d0714..9bd34bd5af30 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
@@ -44,6 +44,18 @@ examples:
         #address-cells = <1>;
         #size-cells = <1>;
 
+        mac@100 {
+            compatible = "mac-base";
+            reg = <0x100 0x6>;
+            #nvmem-cell-cells = <1>;
+        };
+
+        mac@110 {
+            compatible = "mac-base";
+            reg = <0x110 0x11>;
+            #nvmem-cell-cells = <1>;
+        };
+
         calibration@4000 {
             reg = <0x4000 0x100>;
         };
diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
index 980244100690..9f921d940142 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -49,7 +49,10 @@ properties:
 patternProperties:
   "@[0-9a-f]+(,[0-7])?$":
     type: object
-    $ref: layouts/fixed-cell.yaml
+    allOf:
+      - $ref: layouts/fixed-cell.yaml
+      - properties:
+          compatible: false
     deprecated: true
 
 additionalProperties: true
-- 
2.25.1

