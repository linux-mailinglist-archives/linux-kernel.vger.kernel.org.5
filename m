Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE447C958E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 19:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjJNRFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 13:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjJNRFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 13:05:37 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01498B7;
        Sat, 14 Oct 2023 10:05:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9b95622c620so544084566b.0;
        Sat, 14 Oct 2023 10:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697303133; x=1697907933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rGc3NTLuP4Z3KWGBtP+k7zoFEne6z7qUyDpyDz/ywFk=;
        b=Bhyy6Uma4YPafy3epp5sEJBVbfdk7sh9iyGZoMRMJV5BFGkYIzptoRy8vQglC8ps4w
         DrS0ooMM3G0SvBGKmrXlt5VrLVaU2aeMDjPEeXB0D/15QVsKZRAUMrlA9z71s4MdTbxR
         4MXqXhgQILi8znUlqAHZk39rTcYNH7oC6y5pxUnf/fM6n5Ty6tGzMVRK2LYAnODXXmqm
         tud3He6a36CzzlO2T/Wzd8jbNpkiqviv/VU8iMQlaspkd0f/RDVJ5RM2WBsZNH1LECF7
         e/c0pygL56hdr7gwlZxBWxmXEUboyZEFTvNGmRXoPHdGRgbDefHP2+ei7aD1yH8BG1/2
         eNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697303133; x=1697907933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rGc3NTLuP4Z3KWGBtP+k7zoFEne6z7qUyDpyDz/ywFk=;
        b=vW/PRD0I1VGWezwJWNyvks/HnjJ7a1bBpeBA3WfTRQrSiR6g9Ua8F1Bx229ZZ2Csok
         Y8qANl51J8s5ovX7a2N+iFOGuPrOKzKq/tDspe/l+FRxz8aSKf2WS4M2auUbB2T202TQ
         Xfxov3/L3BYAWiyDto8B9nuI6I94vicpBOAJQbC2x27KNUSoFFaVnnChN6WddtfAlkx8
         8WprFQODZ8VQxQwkrH78ueSr8yYINMNEdQLqKtlAHcqTqH3ijQeFz+SlrofkIVdm9J1L
         K/COhMwc0ngb+ntxq4vuyxlGLnWeQuAh3aDL+SDG/Wr+1wbY2DPWI9UDvAYz8vqjxk21
         230A==
X-Gm-Message-State: AOJu0YzCpjB3nWCeDQmneWyGf72vGtLIhfsOQ0LFzNxU9z7f7LRHfm4K
        b3877iWHDnQ0TK95V8xpSaw=
X-Google-Smtp-Source: AGHT+IHUUQvr2WawwT2qGNYqERwTQXSYM7Bh4pAiMzJ4JP7Q+3Zv6PYSQ47az3rCECsbJdmmCGV9OQ==
X-Received: by 2002:a17:906:32d5:b0:9ae:6388:e09b with SMTP id k21-20020a17090632d500b009ae6388e09bmr27470044ejk.40.1697303133086;
        Sat, 14 Oct 2023 10:05:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:8c00:3664:9329:4692:d4de:7b69])
        by smtp.gmail.com with ESMTPSA id bm24-20020a170906c05800b0099bc2d1429csm1154380ejb.72.2023.10.14.10.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 10:05:32 -0700 (PDT)
From:   Nik Bune <n2h9z4@gmail.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        skhan@linuxfoundation.org, stwiss.opensource@diasemi.com
Cc:     Nik Bune <n2h9z4@gmail.com>, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: watchdog: da9062-wdt: convert txt to yaml
Date:   Sat, 14 Oct 2023 19:04:34 +0200
Message-Id: <20231014170434.159310-1-n2h9z4@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert txt file to yaml.
Add a mainterner block. Took a value from dlg,da9063 PMIC.


Signed-off-by: Nik Bune <n2h9z4@gmail.com>
---

Changes in v3
- Changed type of dlg,wdt-sd property from boolean to uint32. Following the discussed in v2 patch thread. 

v2 patch: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231010211439.98458-1-n2h9z4@gmail.com/


 .../bindings/watchdog/da9062-wdt.txt          | 34 -------------
 .../watchdog/dlg,da9062-watchdog.yaml         | 50 +++++++++++++++++++
 2 files changed, 50 insertions(+), 34 deletions(-)
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
index 000000000000..f058628bb632
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/dlg,da9062-watchdog.yaml
@@ -0,0 +1,50 @@
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
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
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
+      dlg,wdt-sd = <1>;
+    };
-- 
2.34.1

