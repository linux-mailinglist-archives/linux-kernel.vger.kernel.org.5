Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BBA7D230C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 14:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjJVMDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 08:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVMDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 08:03:46 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BBBA3;
        Sun, 22 Oct 2023 05:03:44 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9be02fcf268so343704166b.3;
        Sun, 22 Oct 2023 05:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697976223; x=1698581023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LV4D2DnniG5y0BqTHFZQB1MGn4Ao69hJ2NYsUwg1XoA=;
        b=Pz1x6n/2KrcylN5fR5PbATiRbk0lvQCMaulynwhdsc7IPJvjpPPn6Ec0aE+qEwaVl8
         cT9Q9q1hLsBD/ZaT7flsRJvELU6Q1OA9hXLnm1ccVAYiMCLQX0Mc2htXGJvtGhwPr6gA
         8FChjyZXoeKvR7tnmYJcYir2rrq6DVpMRJvOf0ggMMzurUPOboijdVxctor2jEnBJOkk
         Vsb2GmAzII/fKTyX41prqbWcoY18ExrBxSbSFDiQHMh/c6HQhzZ7mSW2m44W9NqJCqua
         oM/pEkj6ulyeybq9wq+8fZfBHtDL+LK/ME/8OhDa0mbk+nPXLcqxqgRhHgKr+DCMv9w2
         8paQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697976223; x=1698581023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LV4D2DnniG5y0BqTHFZQB1MGn4Ao69hJ2NYsUwg1XoA=;
        b=d0hAOc5LJsxsU+t05Y8vRzTagoawuRWX8WpOuNBr0ZJjvVdGP5BVmDdhd/9VSGGWZZ
         Mv5BLaa4KenMblnSMAEkn1ejydkOfYGJsIW3t6rNk02jwVbmpK6XfOv4/ySoZLzRW+xj
         ZLs90lQ0pGXnhlzG13QFgBb51YF98CDOHybhLbm1tJXi0rQqBEf6AlBMCO/5CK7YdtVf
         KEHkNa4IW/dCO8dRVPSZtOxjupyi4XdljErrJP5GRZl3z8FbCNecJ6YFR8amVeL/Jh/1
         eQ84b6g+xOHloO20ouyQBOUUl0jSkB+VlQJ/K3J+52akT8fv9FyIZdcoa/d4yVVkGlUN
         JJPg==
X-Gm-Message-State: AOJu0YyBjHXnUf+mRaqs0i0IAoJNximVfjYXPwpaVR//0W79NymU9z+J
        phSTMe6xYwhA7ntc1XExsnY=
X-Google-Smtp-Source: AGHT+IH1iiAQaekK8D5v5zJkhVAmQ58w+d+CKS4qxxgJ8PwvgrnrO1pQzOeT/Qw0m+iwgCLYdQWeOw==
X-Received: by 2002:a17:907:1b0a:b0:99d:e8da:c20b with SMTP id mp10-20020a1709071b0a00b0099de8dac20bmr5049091ejc.24.1697976222823;
        Sun, 22 Oct 2023 05:03:42 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:8c00:3664:5c63:7da:9756:9320])
        by smtp.gmail.com with ESMTPSA id q24-20020a170906361800b009b2ba067b37sm4870012ejb.202.2023.10.22.05.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 05:03:42 -0700 (PDT)
From:   Nik Bune <n2h9z4@gmail.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        skhan@linuxfoundation.org, baruch@tkos.co.il
Cc:     Nik Bune <n2h9z4@gmail.com>, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: watchdog: cnxt,cx92755-wdt: convert txt to yaml
Date:   Sun, 22 Oct 2023 14:03:28 +0200
Message-Id: <20231022120328.137788-1-n2h9z4@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert txt file to yaml.
Add maintainers list. Took from Documentation/devicetree/bindings/arm/digicolor.yaml file. 

Signed-off-by: Nik Bune <n2h9z4@gmail.com>
---
 .../bindings/watchdog/cnxt,cx92755-wdt.yaml   | 49 +++++++++++++++++++
 .../bindings/watchdog/digicolor-wdt.txt       | 25 ----------
 2 files changed, 49 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/cnxt,cx92755-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/digicolor-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/cnxt,cx92755-wdt.yaml b/Documentation/devicetree/bindings/watchdog/cnxt,cx92755-wdt.yaml
new file mode 100644
index 000000000000..acd2d30b20f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/cnxt,cx92755-wdt.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/cnxt,cx92755-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Conexant Digicolor SoCs Watchdog timer
+
+description: |
+  The watchdog functionality in Conexant Digicolor SoCs relies on the so called
+  "Agent Communication" block. This block includes the eight programmable system
+  timer counters. The first timer (called "Timer A") is the only one that can be
+  used as watchdog.
+
+allOf:
+  - $ref: watchdog.yaml#
+
+maintainers:
+  - Baruch Siach <baruch@tkos.co.il>
+
+properties:
+  compatible:
+    const: cnxt,cx92755-wdt
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      specifies the clock that drives the timer
+
+  timeout-sec: true
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    watchdog@f0000fc0 {
+        compatible = "cnxt,cx92755-wdt";
+        reg = <0xf0000fc0 0x8>;
+        clocks = <&main_clk>;
+        timeout-sec = <15>;
+    };
diff --git a/Documentation/devicetree/bindings/watchdog/digicolor-wdt.txt b/Documentation/devicetree/bindings/watchdog/digicolor-wdt.txt
deleted file mode 100644
index a882967e17d4..000000000000
--- a/Documentation/devicetree/bindings/watchdog/digicolor-wdt.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Conexant Digicolor SoCs Watchdog timer
-
-The watchdog functionality in Conexant Digicolor SoCs relies on the so called
-"Agent Communication" block. This block includes the eight programmable system
-timer counters. The first timer (called "Timer A") is the only one that can be
-used as watchdog.
-
-Required properties:
-
-- compatible : Should be "cnxt,cx92755-wdt"
-- reg : Specifies base physical address and size of the registers
-- clocks : phandle; specifies the clock that drives the timer
-
-Optional properties:
-
-- timeout-sec : Contains the watchdog timeout in seconds
-
-Example:
-
-	watchdog@f0000fc0 {
-		compatible = "cnxt,cx92755-wdt";
-		reg = <0xf0000fc0 0x8>;
-		clocks = <&main_clk>;
-		timeout-sec = <15>;
-	};
-- 
2.34.1

