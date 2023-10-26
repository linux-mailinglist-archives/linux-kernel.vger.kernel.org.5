Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DE97D84DD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345289AbjJZOf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345287AbjJZOfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:35:53 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077A81B1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:35:50 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5ab2cb900fcso780156a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1698330949; x=1698935749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GADNeU8VMeN+ZUsjhqFuupJrDh+gDckp8FVMntouBr8=;
        b=W9Y5WaIcN4awD9r+6ORw9C5n5X3EVu+JK9PDLClR41b1f4msKxyTpfFe5/NNqamxO2
         ndfDbIAOk3WUOzR4nX9d+iiMsEVd7Lp98i0zMptSjMeXs/ZHA74gNfRjadan0Kg753zI
         Bf4k/MX8EL6blJE93xlhlwKt6svpIQwVHznuCOQS5Fbj/UVF8dZ2rBsCW6uX92Yi1W9V
         hTCYBDoXkssRTiRp/iU3CgF1UEIiDK8iQOYpbQ8E5XR/CogHGMAPfwTM2/AxptVQrCER
         6mHlFDQaWxLAsc8jExi78KKtm6LwRglwFenokUZ0KFP6vE2e7319X6aDIwng/7XeWzvg
         0DrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698330949; x=1698935749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GADNeU8VMeN+ZUsjhqFuupJrDh+gDckp8FVMntouBr8=;
        b=dMijivVJmPMA4lkslfnJo5HYmFxoS6euo6OGcQ6HnBOPSBf2mQgr1hopHOeXrKRpIy
         2nsmwJIjM6/tt7HcMXZiTdlkFXq0zrHv055uAOIoZYcxGB9pxLr01e/B9fmQ0ZOrPldJ
         3uP2fi6olccgMHDQ0awSz+EZzedP5IHSfAmzAnYilO8yCW9KYg9NKyOG52upEmpchsy4
         XPoKOXfeU7izxczZj4+ZNUCVj0nS49+n7P3+99398rPL+FrJaV4xy0TaaC5KYe5r3OfG
         9w+U1lj2y19cqqzguBo3Vz/UuM0I/mQoMdSI1aZ+9MyaUnv0ce7MPKQuQFFyZsdq0p51
         H8uw==
X-Gm-Message-State: AOJu0YxlSMs/H2/HBiGunoFF34Os1WZQLn6cEEaWyEN5UpCGRMOxbrKL
        eI4pT/H/itKSsME8nWC44qf5DQ==
X-Google-Smtp-Source: AGHT+IHP5gsv0gW18Tmg8C3ceRMS/SpMC1HPwLXEy6DtWHIfi4mrXfn77tau1E4st7x7akwUSL2umA==
X-Received: by 2002:a17:90a:35c:b0:27f:fa4c:ebaf with SMTP id 28-20020a17090a035c00b0027ffa4cebafmr1423484pjf.14.1698330949399;
        Thu, 26 Oct 2023 07:35:49 -0700 (PDT)
Received: from localhost.localdomain (2403-580d-82f4-0-16bf-4026-a446-e128.ip6.aussiebb.net. [2403:580d:82f4:0:16bf:4026:a446:e128])
        by smtp.gmail.com with ESMTPSA id iq11-20020a17090afb4b00b00256b67208b1sm1727519pjb.56.2023.10.26.07.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 07:35:49 -0700 (PDT)
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>
Cc:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        Matt Ranostay <matt@ranostay.sg>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: iio: light: Avago APDS9306
Date:   Fri, 27 Oct 2023 01:05:31 +1030
Message-Id: <20231026143532.39660-2-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026143532.39660-1-subhajit.ghosh@tweaklogic.com>
References: <20231026143532.39660-1-subhajit.ghosh@tweaklogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v0 -> v1
- Squashing Avago (Broadcom) APDS9300 and APDS9960 schemas into one as
  they look similar
- Adding support for APDS9306 in the same schema file
- Adding mandatory interrupt property requirement for APDS9960 as per the
  driver's probe method which fails if interrupt bindings are not defined.
  Both APDS9300 and APDS9306 (this patch set) supports sensors with and
  without hardware interrupt bindings
- In the device tree example, replacing interrupt type number with macro
  from irq.h
- Updated the vin to vdd which is the same for all the three sensors
- Used proper "Datasheet:" tags

Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
---
 .../bindings/iio/light/avago,apds9300.yaml    | 35 ++++++++++++---
 .../bindings/iio/light/avago,apds9960.yaml    | 44 -------------------
 2 files changed, 30 insertions(+), 49 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
index 206af44f2c43..7a24a97d0594 100644
--- a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
+++ b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
@@ -4,17 +4,26 @@
 $id: http://devicetree.org/schemas/iio/light/avago,apds9300.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Avago APDS9300 ambient light sensor
+title: Avago Gesture, RGB, ALS and Proximity sensors
 
 maintainers:
   - Jonathan Cameron <jic23@kernel.org>
+  - Matt Ranostay <matt@ranostay.sg>
+  - Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
 
 description: |
-  Datasheet at https://www.avagotech.com/docs/AV02-1077EN
+  Avago (Broadcom) optical and proximity sensors with I2C interfaces.
+  Datasheet: https://docs.broadcom.com/doc/AV02-1077EN
+  Datasheet: https://docs.broadcom.com/doc/AV02-4191EN
+  Datasheet: https://docs.broadcom.com/doc/AV02-4755EN
 
 properties:
   compatible:
-    const: avago,apds9300
+    oneOf:
+      - enum:
+          - avago,apds9300
+          - avago,apds9306
+          - avago,apds9960
 
   reg:
     maxItems: 1
@@ -22,14 +31,30 @@ properties:
   interrupts:
     maxItems: 1
 
-additionalProperties: false
+  vdd-supply: true
 
 required:
   - compatible
   - reg
 
+allOf:
+  - $ref: ../common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - avago,apds9960
+    then:
+      required:
+        - interrupts
+
+additionalProperties: false
+
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -38,7 +63,7 @@ examples:
             compatible = "avago,apds9300";
             reg = <0x39>;
             interrupt-parent = <&gpio2>;
-            interrupts = <29 8>;
+            interrupts = <29 IRQ_TYPE_EDGE_FALLING>;
         };
     };
 ...
diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml
deleted file mode 100644
index f06e0fda5629..000000000000
--- a/Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml
+++ /dev/null
@@ -1,44 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/iio/light/avago,apds9960.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Avago APDS9960 gesture/RGB/ALS/proximity sensor
-
-maintainers:
-  - Matt Ranostay <matt.ranostay@konsulko.com>
-
-description: |
-  Datasheet at https://www.avagotech.com/docs/AV02-4191EN
-
-properties:
-  compatible:
-    const: avago,apds9960
-
-  reg:
-    maxItems: 1
-
-  interrupts:
-    maxItems: 1
-
-additionalProperties: false
-
-required:
-  - compatible
-  - reg
-
-examples:
-  - |
-    i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-
-        light-sensor@39 {
-            compatible = "avago,apds9960";
-            reg = <0x39>;
-            interrupt-parent = <&gpio1>;
-            interrupts = <16 1>;
-        };
-    };
-...
-- 
2.34.1

