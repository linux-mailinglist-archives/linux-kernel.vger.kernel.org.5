Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4457A792A98
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243799AbjIEQj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354666AbjIENXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:23:36 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBF319B;
        Tue,  5 Sep 2023 06:23:32 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6bb1133b063so298386a34.1;
        Tue, 05 Sep 2023 06:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693920212; x=1694525012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tAnyjNoEHzOtoWr8RZt8Z0B0PvJcndgHMjpREL+JJTc=;
        b=BKfp3hMsq6pBIVCozL+NV4m3WSnJh85eG61DsCI6irpq9MxhaiLrh7NWjsPqfVB9Fn
         9ZhRghXNv71ttQjrvWhuu4WHaaKy0KAKhrbHGUZ1TA9xUsHf4b3+xhx+ZHopZBPSzjdo
         L0jLVwl/XRbcQFR1Pfm5zd0op5Sj5J0hUq6+m43hCFScVpzIAbJhqTMngtAwRMuMFnVm
         hXuU7MDv9TVfAtuaDjuWZEV7m5a+7AewoxLdWlFvvJBMRRdDNvmA3XPyKrt0hu8hwdJ+
         t7B4TCcZMLbe12jUPYsXCesrT0yIKrgpWYj9Q14L+vbMfzOPLvIsgZtCso7tRTZMf0Wk
         AEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693920212; x=1694525012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tAnyjNoEHzOtoWr8RZt8Z0B0PvJcndgHMjpREL+JJTc=;
        b=gqFq6K4hwr9N4kPTMtcSdtk6jy3U0VIpYZHgYqag0LqXsqEmjXF6z9IBJ2jAhkjfBS
         H6rd9+hvbviHs/oyHF82x1cFz9scx6FMuYVJa8UMSjWrHnqLeQFSu7Kv8YkcTfJ1Slzs
         Tnlfzqm/ipyqlz47dZBGVzrpXOzEFy3eAXhyfmdzQ34aVfsccR08pgNrUdXiHzPLAX5L
         As8ZgpHq48SUzFY1aZRdY6tgfgGJ0jyi0vT2tdNZeWA6RX48CxsXP9bAli9TkWj88lTr
         IwhSszyWFtJryr5jRJvLcNLjY1BP6LkgI804YppuF7b9M6IyThtSZKSxXohhB2atpxDe
         pQrA==
X-Gm-Message-State: AOJu0YytNPWH+H5hNNX/sbryXTzT/dl7C7njtX5Gz2IJqBWJdVif1bFN
        OA4kjrdRbHCRPjOz1pLLbO0=
X-Google-Smtp-Source: AGHT+IGzXHFvxkJru02iZ4T7UiUFfUmCbJBdZ7YcOEEj2J6kpE0YGf1LLj2iwpaTeIynToQfSlvAFQ==
X-Received: by 2002:a05:6830:6a9b:b0:6bc:a6d0:ab7 with SMTP id da27-20020a0568306a9b00b006bca6d00ab7mr11675305otb.3.1693920212064;
        Tue, 05 Sep 2023 06:23:32 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:ed1a:13f:d0c6:913b])
        by smtp.gmail.com with ESMTPSA id e26-20020a9d63da000000b006b9d8c31e94sm5443062otl.39.2023.09.05.06.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 06:23:31 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     alexandre.belloni@bootlin.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, sam@ravnborg.or, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>
Subject: [PATCH] dt-bindings: rtc: pcf8523: Convert to YAML
Date:   Tue,  5 Sep 2023 10:23:24 -0300
Message-Id: <20230905132324.3146722-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

Convert the PCF8523 bindings from text format to YAML.

The YAML format is preferred as it allows validation.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 .../devicetree/bindings/rtc/nxp,pcf8523.txt   | 18 -------
 .../devicetree/bindings/rtc/nxp,pcf8523.yaml  | 48 +++++++++++++++++++
 2 files changed, 48 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf8523.yaml

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
deleted file mode 100644
index 0b1080c60f63..000000000000
--- a/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-* NXP PCF8523 Real Time Clock
-
-Required properties:
-- compatible: Should contain "nxp,pcf8523".
-- reg: I2C address for chip.
-
-Optional property:
-- quartz-load-femtofarads: The capacitive load of the quartz(x-tal),
-  expressed in femto Farad (fF). Valid values are 7000 and 12500.
-  Default value (if no value is specified) is 12500fF.
-
-Example:
-
-pcf8523: rtc@68 {
-	compatible = "nxp,pcf8523";
-	reg = <0x68>;
-	quartz-load-femtofarads = <7000>;
-};
diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf8523.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.yaml
new file mode 100644
index 000000000000..111cb9938f8f
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/nxp,pcf8523.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP PCF8523 Real Time Clock
+
+maintainers:
+  - Sam Ravnborg <sam@ravnborg.org>
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    const: nxp,pcf8523
+
+  reg:
+    maxItems: 1
+
+  quartz-load-femtofarads:
+    description:
+      The capacitive load of the crystal, expressed in femto Farad (fF).
+      Valid values are 7000 and 12500. The default value when this property
+      is absent is 12500fF.
+    enum: [ 7000, 12500 ]
+
+  wakeup-source: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc@68 {
+            compatible = "nxp,pcf8523";
+            reg = <0x68>;
+            quartz-load-femtofarads = <7000>;
+        };
+    };
-- 
2.34.1

