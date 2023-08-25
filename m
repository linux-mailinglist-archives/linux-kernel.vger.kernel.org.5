Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1914F7886B8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244542AbjHYMME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244624AbjHYML6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:11:58 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FDA1BC7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 05:11:56 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52a06f5f556so1290861a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 05:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692965515; x=1693570315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzqGDlYO53VtpNTfk9/2jQSIhaYzka5q6tmocMJNTUk=;
        b=Iw+vGU0WxM/n2TkZrEPhVytepIiLpJLCrgunLLHrb1dt2WzeE0v+25Q8ohu/3VhBMH
         isuG+szZerc1JZs/j5z/zpz+/JuDv2mK1hTQcwhIBY047MnqxhMvqLYS1CUKsgDj0IqY
         UNZ5uBoljRyzVqd5PdSzUUGcSsX/Jdjgjtet/lbCenTGyZx2MDuZNxDhie99jtRGN83O
         IJkHCO/f4Vhovn92yzawIxGFJMtCwqlNTrof8HpLKXBVnEHaEWdl8LV1zbNuwj1oP/Ti
         wwzriRyZzkG/dwaxaChFSoSfeO5MBw8L6/zxOUossa73ZoYg47OM2P3D9xNreGEo6cFx
         RHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692965515; x=1693570315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzqGDlYO53VtpNTfk9/2jQSIhaYzka5q6tmocMJNTUk=;
        b=d/jvVBr5XxM63kwwY++7Mrbuov3KFqsQBYFIonsIt1WB0UrpAP9qgxSvHggSXoEcnz
         2kSXQ9HDviiZhi41hj7sOkAqOXmmng1ZQyyIOSWhmH/6GOUg2PBU1sX13tMKUhAe6LqC
         zbyNvFQKY+tWj8TrWa6KC7j7gnb8brgYiEU4e5QSwPJtY8Or/JxDT8djJE4nJjMiGxf3
         kW4XYYORd0fGqTHjq8LMMrP+fRl+XyK9vmp9qusrgR3TXAP1LMUi+Dp1fPj8UKG0vGft
         D3leg5w1w3wDMyuaWyM4pR+Is33ODSg+web0Kv3R+DEewUXe0GMta2aZ9BdLmZKCNtkU
         ygMA==
X-Gm-Message-State: AOJu0YyFjw9x6+AduXVUtGsVPv/3jhq2OHuQUP6C1uKNbsMsWDJYJb44
        lezNjyNi9BhQ/GNtJQ8sHwhKKg==
X-Google-Smtp-Source: AGHT+IGUKhjqKcVWlKdpqBhagGpbCfzvbRoRShHrZQRitS1v8wNgCijkMtLxjEvIGq8epHehT9iSbA==
X-Received: by 2002:aa7:d952:0:b0:523:ae0a:a447 with SMTP id l18-20020aa7d952000000b00523ae0aa447mr15166905eds.13.1692965515299;
        Fri, 25 Aug 2023 05:11:55 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id l5-20020a056402124500b005222c6fb512sm952311edw.1.2023.08.25.05.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 05:11:54 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jianhua Lu <lujianhua000@gmail.com>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 3/3] dt-bindings: display: novatek,nt36523: define ports
Date:   Fri, 25 Aug 2023 14:11:42 +0200
Message-Id: <20230825121142.101759-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825121142.101759-1-krzysztof.kozlowski@linaro.org>
References: <20230825121142.101759-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panel-common schema does not define what "ports" property is, so
bring the definition by referencing the panel-common-dual.yaml. Panels
can be single- or dual-link, depending on the compatible, thus add
if:then:else: block narrowing ports per variant.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v3:
1. Rb tag

Changes since v2:
1. Use panel-common-dual.
2. Add if:then:else:

Changes since v1:
1. Rework to add ports to device schema, not to panel-common.
---
 .../display/panel/novatek,nt36523.yaml        | 25 +++++++++++++++----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
index 5f7e4c486094..bbeea8cfa5fb 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
@@ -14,9 +14,6 @@ description: |
   panels. Support video mode panels from China Star Optoelectronics
   Technology (CSOT) and BOE Technology.
 
-allOf:
-  - $ref: panel-common.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -38,7 +35,6 @@ properties:
     description: regulator that supplies the I/O voltage
 
   reg: true
-  ports: true
   rotation: true
   backlight: true
 
@@ -47,7 +43,26 @@ required:
   - reg
   - vddio-supply
   - reset-gpios
-  - ports
+
+allOf:
+  - $ref: panel-common-dual.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - novatek,nt36523w
+    then:
+      properties:
+        ports:
+          properties:
+            port@1: false
+    else:
+      properties:
+        port: false
+        ports:
+          required:
+            - port@1
 
 unevaluatedProperties: false
 
-- 
2.34.1

