Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431CA785506
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbjHWKMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbjHWITq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:19:46 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AD63A99
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:15:16 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-997c4107d62so709460066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692778515; x=1693383315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqRFfyB6fBH2NjSEwbcQneI6aytxmQl02N3y/cGFN8Q=;
        b=iHZOl1PZKN62nlsynpyoDx9vyDVvVCO3NcP7oVnW1ecm5RD1cdHMaDNM7ltaET90RA
         Vi4eXQ3am5DKBisey3XxfvShn7luVkBBqhzdHaCwrUOJd3eVloo3kjHXyvoWcQl4wYcT
         lYgGSSBLqjKK+S3uBCa4qOTBmYzuhRtBiES0iwlTYNelE4vEPEYov512pXM+F8rPZcDd
         J0Glv/qMM16RjQPcEaO3HApk4tr+2NdUqV31dQOjAiyZ5FEG05la6qSdjAVYrpjEa3Oe
         YQjxNTHUUr43V6ZHFxEVjAsNgK8UqS5TqhY0Ey/T+Y8Ca152aX2QnXOR0J9E7lo8Qh/V
         VB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778515; x=1693383315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PqRFfyB6fBH2NjSEwbcQneI6aytxmQl02N3y/cGFN8Q=;
        b=RtjKBlIEmsujF99qaCkwftFM8Ou2JEtqvCjOP6fAL+VqJYbXQ51rimZHjbynsj8yBl
         jILsE6RaBMb7y0Qjdfi6fZEY2HSQHILrPPM5BF51kOoxPmXJiD8d4v2uMEyMjeAHJnOH
         Aj97bTJSTtG/w8AXRM9HVdpCpeYy3GNwAqmehm20qL9MdZ4yVj1vU/XSXMMKgUNxXNob
         FbEVmLWpF0IRrWfbIsPM30RpDzjWjGVE2y8d/jUSzKaRI0QxBpdQ7jcBuHisUwiIDfOa
         Qdu5rYzZgO+2ImOwHdX2MkUbkkaWoU3cS1Xpk4DRzJHhR4Gpvi8ROYoq62p8QPFuwqAe
         Xk7A==
X-Gm-Message-State: AOJu0Yw0cSL0ap6q1mm6Qy7TW0sbzo10aUEQ71xFoIO6pT9Z2X0DehpE
        A7R4UYbeQ9iiT2E/BCKHAtLPJw==
X-Google-Smtp-Source: AGHT+IGoWKgMFpxZ9BF5pSIbrht5kIRNqx7e0/bgz0+0hiqpzXF3RpNK5nrnWgjZRC4fE/5RdArPcQ==
X-Received: by 2002:a17:907:2cf7:b0:99c:d05d:7b50 with SMTP id hz23-20020a1709072cf700b0099cd05d7b50mr8958826ejc.2.1692778515235;
        Wed, 23 Aug 2023 01:15:15 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id v18-20020a170906b01200b0098e78ff1a87sm9539730ejy.120.2023.08.23.01.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 01:15:14 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 3/3] dt-bindings: display: novatek,nt36523: define ports
Date:   Wed, 23 Aug 2023 10:15:00 +0200
Message-Id: <20230823081500.84005-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823081500.84005-1-krzysztof.kozlowski@linaro.org>
References: <20230823081500.84005-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

---

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

