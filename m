Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AB67D902D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345289AbjJ0HqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345496AbjJ0HqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:46:04 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C6B1AC
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:46:01 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6be840283ceso1754224b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1698392761; x=1698997561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZM7mEbym++2u+NU79QX4ZHMRGx0lVPkdpZQMaBrXSg=;
        b=Ft24V1OFnLpvslK6+YTzMQi/tdIlNytIjOEbhu8m4apjFGtJGd/ZnGAB8Ti4ztD1uf
         egm31OUUsLZ2rUyqVDPC4VSqZjyNfDP7F1/4b6aYhFlcIqs/IjnBpTgttmAfttyetH9f
         6VoRACoQDd6RZRaRtywcHfeS8obPbDtlBxT9NC+9Az2YgJySesM5+Ys9GFN83uEc/6d0
         YIoglZqf45+owgeJ+WyiZMSsXtJw3GWMfkVm4lv+tFjZK2JDer9UU/DKMIfmE4+wyv8n
         mSnxpILTyNNIexY0jDZtFB9/Yes1WHhOrrYVWWBLx4m40yiQYq2yRLBCT2QcRbl3IOAu
         RwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698392761; x=1698997561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZM7mEbym++2u+NU79QX4ZHMRGx0lVPkdpZQMaBrXSg=;
        b=eCpYNs3lIPbk47NkhzfpZ1VamEFw2C1LBDCNrpEQUUfuotl3gOL1MghrTk1G10tT30
         PQgwZRI6EFdrU96wM8Zu1FMuXTaHLtoqz3NAFjRaoqyxORucszBpwuvG/S+yxioxlneg
         eymLybpOPvl7tFL6KNkwIq8t+/9rh/d33CNrbn4Py7pjlRVKFYfGximNxZHbntt35TeT
         iK5QTxeblDD9JaH9+Sfa8Eizi7M9QHGzARxaztBpLixZvbW7IMLxxH74NVA68o37xYbj
         vmjMjIBf9PZViSLnFJldi0bScQAm9u/zfbRnuABuFcaYO4HxFZ6H/caa2v508EFHINsC
         xWwQ==
X-Gm-Message-State: AOJu0YzdYTW/fUKCCaqChEiWMdOYeR6RmUqWHpMnDN0fiQWQfFmRsIGl
        4gk25Hq51nTaUIjQZsXW2mwZjA==
X-Google-Smtp-Source: AGHT+IEIfDvnLnrrWUgUvOg/jUERDroViV38HLoZeYqt750GTS4ajzfl7eGgNONF2qRlvbQB6bBxjg==
X-Received: by 2002:a05:6a21:7906:b0:174:af85:91fc with SMTP id bg6-20020a056a21790600b00174af8591fcmr2034147pzc.48.1698392761014;
        Fri, 27 Oct 2023 00:46:01 -0700 (PDT)
Received: from localhost.localdomain (2403-580d-82f4-0-bfe6-93ca-47b7-e8ec.ip6.aussiebb.net. [2403:580d:82f4:0:bfe6:93ca:47b7:e8ec])
        by smtp.gmail.com with ESMTPSA id v12-20020a17090ac90c00b00277832fbf4esm684835pjt.16.2023.10.27.00.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 00:46:00 -0700 (PDT)
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
Subject: [PATCH v2 1/2] dt-bindings: iio: light: Avago APDS9306
Date:   Fri, 27 Oct 2023 18:15:44 +1030
Message-Id: <20231027074545.6055-2-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027074545.6055-1-subhajit.ghosh@tweaklogic.com>
References: <20231027074545.6055-1-subhajit.ghosh@tweaklogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2
- No change

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

