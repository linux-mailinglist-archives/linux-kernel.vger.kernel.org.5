Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EB17931CE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 00:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244550AbjIEWIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 18:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjIEWIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 18:08:40 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B15E6;
        Tue,  5 Sep 2023 15:08:37 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6bca018afe8so895030a34.0;
        Tue, 05 Sep 2023 15:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693951717; x=1694556517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ce16MbM3TIjereNRMgMjUrtiSlhzKCA03BxWXdmdgQ=;
        b=aTtUrvcDN/fRQUYtfldxBs5oN77nWLl/VGcWZi6GUb0UTg7eBEuI3b6JoAJWO7uP2h
         jm9NZ6Dh2tQWIv/GLqnj1OJPHS19EIJqC53Oa1P7bRwWt7oosD9f7zxTNDSACWGlNFX5
         9dT9cKQ9S/mC1OqBaEwegZnOFRsOicDHC3cFdPk9zi1rMtkf8Ljw/KP6sYNLtdmBUefa
         vJloqXz5s/2DYyFtjtn/sB+tKAqQCRPNJPq4z0b8AsU0lcq/w09e0jUZjv+EZDJaaD0w
         BH34YqBcQv3/ERNivpRgKBynvxf305Z1ZAVZmh2Xu0roN4LQIaJ8QU1p2X9hMqTu5qj/
         yL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693951717; x=1694556517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Ce16MbM3TIjereNRMgMjUrtiSlhzKCA03BxWXdmdgQ=;
        b=DLa0QIEnQnwmSsALG+unBwW+v0cSCm6BVB5brutNNgh11MJSC0wRDgKPDR78Emgx8H
         oFdlhODPIAlLVJj7hNjvninogP8JUN2LYFAo+Yn935mWLDl6IHDbh48SNsoCyYt4Fbi3
         PH2VDjjHUJFpOZAgjB1otOKP0k5oU+LH/zRRXEzzoUnWSQ+KT4quF2NcGFVeSLEe4aqU
         ECouBY+b+WaJX3fmsAnIcswj8OXx50UwSATt98xQEd5IgendDk7O5ImQKsyO1wyPzBSa
         UfQ/Qha228/jaeLWIEhfYa51VpousN+SDThObX5i3+QD01SCHPTb8TO5XX4wmiWMDO2F
         1fWQ==
X-Gm-Message-State: AOJu0YwskcLtKiGN602MphNHjM5zO0Ni/ksBuBFRdRYJwgmXX4Xv5Py7
        q6icrR++BP7BfgVo9pjecPA=
X-Google-Smtp-Source: AGHT+IE9No+QwoJ279rZlSWHEdl6v0ks4fUomqCbO0ofRUUcJH3Fek5URlHzmlUZ9r/dcaYDCaxnDg==
X-Received: by 2002:a05:687c:86:b0:1d1:40a6:e832 with SMTP id yg6-20020a05687c008600b001d140a6e832mr9385921oab.4.1693951716591;
        Tue, 05 Sep 2023 15:08:36 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:2abb:b8c2:b1a6:d1ec])
        by smtp.gmail.com with ESMTPSA id j12-20020a056870168c00b001d4c5e4c2c5sm3430765oae.25.2023.09.05.15.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 15:08:36 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     alexandre.belloni@bootlin.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, sam@ravnborg.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier.carrasco@wolfvision.net, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v3] dt-bindings: rtc: pcf8523: Convert to YAML
Date:   Tue,  5 Sep 2023 19:08:26 -0300
Message-Id: <20230905220826.79901-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
Changes since v2:
- Fix the default quartz-load-femtofarads value. (Javier)

 .../devicetree/bindings/rtc/nxp,pcf8523.txt   | 18 --------
 .../devicetree/bindings/rtc/nxp,pcf8523.yaml  | 45 +++++++++++++++++++
 2 files changed, 45 insertions(+), 18 deletions(-)
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
index 000000000000..8d17b89fef5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.yaml
@@ -0,0 +1,45 @@
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
+    enum: [ 7000, 12500 ]
+    default: 12500
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
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

