Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF237C422A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343970AbjJJVPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343923AbjJJVPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:15:00 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A6B91;
        Tue, 10 Oct 2023 14:14:58 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9ba081173a3so669283266b.1;
        Tue, 10 Oct 2023 14:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696972497; x=1697577297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oujABCSZJNk2IyD5lN5ZvORKGcKBX/k42s5CPJt8qtE=;
        b=GNJW8o7rwFZJFgElDaZLwlpzr0BIBOsLawbmWKEvFIBk1zKoJawF0Lkl7GlMcJwqHB
         OGuVgW4w9n/VfAKIe3b0dIC2MCHXaAKzByykO1x124a8m+uldRlZ0praFC4hqgZ9wwQF
         7L97tpc1Z+ZJrCTni2eXv7v1Sa6Jh190bO7/vQDTD79sLyDQaWUvdmWfFIeNblVeiYMS
         rxtnG+BZcQqbQsR6h7mLEaJ+l9YOFuWRcu52iSuGHGaKW6Fs//H2n0prZAb9TuRMSexc
         LUuwv9voQFAbeGfI1ZNVPCmEogkfCxhVvbiyeDTdZsoBvRCmtsXXUX3Qba5rMWXaIIyU
         19vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696972497; x=1697577297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oujABCSZJNk2IyD5lN5ZvORKGcKBX/k42s5CPJt8qtE=;
        b=RidCRGSCuGZLGIdQqQfZ+voCdql5HVDnbLDxN2DXX11tlg17LfcQnAJUnhfWIkKULU
         +kFXPBByF32OFcNnJkRKWbRaiy3+2nLhYMb90Ovywl87u2Y4jLbgVpnEI40x7bWmQdON
         nPuJMsGHWfnzgjUuv2p4iUCCAfBGUHOngL+8rq1GngJdoIKC9XFNeUgTJuMYdsK0L4Kt
         D07OSMDXyQzY77YcBAF99KMccni411d2IOgRySFAaevmzTNRyf2UZ8et/Wx0XMQaOr8L
         JGUmgkSRcz7/tXhwYvxNB9PRHmZCstNI3ZEEajWicVgGJOOukPmFRkz1FCRjiSIByBZs
         RWug==
X-Gm-Message-State: AOJu0YwwNq9qRahX7NOo62qxOLMrziXNDBL0QXGr4hEEn0uz1wrtUm11
        laDKkz2WU5L+IzDuTkELKdk=
X-Google-Smtp-Source: AGHT+IFAQkkMmq60a6tXrYlsvOraSSOPfxHSylqM0IAALDYvo60rpktWiXaBYMY+u6BmJ9y3N7a9kg==
X-Received: by 2002:a17:906:844a:b0:9bd:7a9f:a02 with SMTP id e10-20020a170906844a00b009bd7a9f0a02mr317217ejy.4.1696972496481;
        Tue, 10 Oct 2023 14:14:56 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:8c00:3664:7a05:7dcc:abce:3c83])
        by smtp.gmail.com with ESMTPSA id o18-20020a1709061b1200b009b9977867fbsm8905883ejg.109.2023.10.10.14.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 14:14:55 -0700 (PDT)
From:   Nik Bune <n2h9z4@gmail.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        skhan@linuxfoundation.org, stwiss.opensource@diasemi.com
Cc:     Nik Bune <n2h9z4@gmail.com>, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH] dt-bindings: watchdog: da9062-wdt: convert txt to yaml
Date:   Tue, 10 Oct 2023 23:14:39 +0200
Message-Id: <20231010211439.98458-1-n2h9z4@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert txt file to yaml.
Add a mainterner block. Took a value from dlg,da9063 PMIC.

Signed-off-by: Nik Bune <n2h9z4@gmail.com>
---

Changes in v2:
- Updated filename to be equal to compatible value.
- Removed ">" in description fields. 
- Added optional properties to the example. 
- Removed reg property, as it is not present in the txt version. 


 .../bindings/watchdog/da9062-wdt.txt          | 34 -------------
 .../watchdog/dlg,da9062-watchdog.yaml         | 49 +++++++++++++++++++
 2 files changed, 49 insertions(+), 34 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/dlg,da9062-watchdog.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt b/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
deleted file mode 100644
index 354314d854ef..000000000000
--- a/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-* Dialog Semiconductor DA9062/61 Watchdog Timer
-
-Required properties:
-
-- compatible: should be one of the following valid compatible string lines:
-	"dlg,da9061-watchdog", "dlg,da9062-watchdog"
-	"dlg,da9062-watchdog"
-
-Optional properties:
-- dlg,use-sw-pm: Add this property to disable the watchdog during suspend.
-	Only use this option if you can't use the watchdog automatic suspend
-	function during a suspend (see register CONTROL_B).
-- dlg,wdt-sd: Set what happens on watchdog timeout. If this bit is set the
-	watchdog timeout triggers SHUTDOWN, if cleared the watchdog triggers
-	POWERDOWN. Can be 0 or 1. Only use this option if you want to change the
-	default chip's OTP setting for WATCHDOG_SD bit. If this property is NOT
-	set the WATCHDOG_SD bit and on timeout watchdog behavior will match the
-	chip's OTP settings.
-
-Example: DA9062
-
-	pmic0: da9062@58 {
-		watchdog {
-			compatible = "dlg,da9062-watchdog";
-		};
-	};
-
-Example: DA9061 using a fall-back compatible for the DA9062 watchdog driver
-
-	pmic0: da9061@58 {
-		watchdog {
-			compatible = "dlg,da9061-watchdog", "dlg,da9062-watchdog";
-		};
-	};
diff --git a/Documentation/devicetree/bindings/watchdog/dlg,da9062-watchdog.yaml b/Documentation/devicetree/bindings/watchdog/dlg,da9062-watchdog.yaml
new file mode 100644
index 000000000000..9b7ffdb01da0
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/dlg,da9062-watchdog.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/dlg,da9062-watchdog.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Dialog Semiconductor DA9062/61 Watchdog Timer
+
+maintainers:
+  - Steve Twiss <stwiss.opensource@diasemi.com>
+
+allOf:
+  - $ref: watchdog.yaml#
+
+properties:
+  compatible:
+    enum: 
+      - dlg,da9061-watchdog
+      - dlg,da9062-watchdog
+
+  dlg,use-sw-pm:
+    type: boolean
+    description:
+      Add this property to disable the watchdog during suspend.
+      Only use this option if you can't use the watchdog automatic suspend
+      function during a suspend (see register CONTROL_B).
+  
+  dlg,wdt-sd:
+    type: boolean
+    description:
+      Set what happens on watchdog timeout. If this bit is set the
+      watchdog timeout triggers SHUTDOWN, if cleared the watchdog triggers
+      POWERDOWN. Can be 0 or 1. Only use this option if you want to change the
+      default chip's OTP setting for WATCHDOG_SD bit. If this property is NOT
+      set the WATCHDOG_SD bit and on timeout watchdog behavior will match the
+      chip's OTP settings.
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    watchdog {
+      compatible = "dlg,da9062-watchdog";
+      dlg,use-sw-pm;
+      dlg,wdt-sd;
+    };
-- 
2.34.1

