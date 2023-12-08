Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD64080AD59
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 20:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbjLHTwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 14:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHTwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 14:52:53 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CF4137
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 11:52:59 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a1d450d5c11so318997266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 11:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702065177; x=1702669977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AQL2QzATtB7HD48YvHn7NcHvaYuNjHniWUH7CLZRyog=;
        b=q28ZqfaEwMhMnkIACRBvhMKYc7sq9t129BEObLiuPPtKE3Y6d1ulb+oBKs1EO1jEFL
         daKqChtF42XGLxSHB36hVQm8XCDDxFAPF8wHphZyF/RSMtBLGWUfgvXRcTdL3OP22rCl
         2EGoVSWYShNkjAvv2T84WgHp1aK4CHX2dUC+kgsszqUm0TbOlL+pmJfkKK00pdJEbhBX
         DB5Rjga7WjgB4pxYCVBwKA6UdXoPfj9SBIfqqvHzkPH3DggCIvoIH7SjhsY2cNqDvLOE
         u8vIVEJTFFaqidzBtvpNN3eQ3L2RdiHYLB9ZqPWgtL1YBweLf2ljw1qKXreebDW9/28e
         q8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702065177; x=1702669977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQL2QzATtB7HD48YvHn7NcHvaYuNjHniWUH7CLZRyog=;
        b=FSSCcrCejxGaRAYTQSHF6tqcXDyoibDMCVtYjEbxF3KqT7df8j/YVrGThC0zms/1Wt
         QRkelIdGPdXIYjt7pOV6ahRxSd3MreykLbD58TEA4LpOMq25h+FTQrco1/KpwLtP+1sc
         cbAdvO8n6BteuoJEjJSIWSEByMdYDoiJlDJ7k2fS3lElVp/204yUZ/kok+Oat/T8jam2
         8UIEXos5gdE5a28O6O97Y3Dzb7Ulph4RneCuNUW4w6xxglV4ru9gsNnqopEMM+yOIWGm
         OlS1KCAPHvFUGq1ST1moUjArpKta0qAM+ACJVSNzDe2vpriaok0rSpFYLep2YCD2LWxx
         hRqQ==
X-Gm-Message-State: AOJu0Yze+eXAtl8iZXrkOJpQvmNoVK+IrnGQ0HZHoaLjL4toWB8qrzrc
        RmxKOyofO+d1A2r5Dj9nn0wI1/ApC/IBlzWLfyc=
X-Google-Smtp-Source: AGHT+IF8UxKogiHQOCSLgyU2Q+4VTW/vNSAnLHzakwQyvd9TFf30yQ25fUjFYq7YQAinGnNjCOiKyQ==
X-Received: by 2002:a17:906:3289:b0:9c4:54c6:8030 with SMTP id 9-20020a170906328900b009c454c68030mr246504ejw.6.1702065177641;
        Fri, 08 Dec 2023 11:52:57 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id vu6-20020a170907a64600b00a1d61183006sm1339333ejc.83.2023.12.08.11.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 11:52:57 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3] media: dt-bindings: ov8856: decouple lanes and link frequency from driver
Date:   Fri,  8 Dec 2023 20:52:53 +0100
Message-Id: <20231208195253.130470-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The data lanes and link frequency were set to match existing Linux driver
limitations, however bindings should be independent of chosen Linux
driver support.

Decouple these properties from the driver to match what is actually
supported by the hardware.

This also fixes DTS example:

  ov8856.example.dtb: camera@10: port:endpoint:link-frequencies:0: [360000000] is too short

Fixes: 066a94e28a23 ("media: dt-bindings: media: Use graph and video-interfaces schemas")
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v3:
1. Drop link-frequencies entirely (Sakari)
2. Add Conor's ack

Changes in v2:
1. Rework approach: decouple bindings from driver instead of fixing
   DTS example (Sakari)
---
 .../devicetree/bindings/media/i2c/ov8856.yaml | 24 +++++++++----------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/ov8856.yaml b/Documentation/devicetree/bindings/media/i2c/ov8856.yaml
index 57f5e48fd8e0..816dac9c6f60 100644
--- a/Documentation/devicetree/bindings/media/i2c/ov8856.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/ov8856.yaml
@@ -67,19 +67,17 @@ properties:
 
         properties:
           data-lanes:
-            description: |-
-              The driver only supports four-lane operation.
-            items:
-              - const: 1
-              - const: 2
-              - const: 3
-              - const: 4
-
-          link-frequencies:
-            description: Frequencies listed are driver, not h/w limitations.
-            maxItems: 2
-            items:
-              enum: [ 360000000, 180000000 ]
+            oneOf:
+              - items:
+                  - const: 1
+              - items:
+                  - const: 1
+                  - const: 2
+              - items:
+                  - const: 1
+                  - const: 2
+                  - const: 3
+                  - const: 4
 
         required:
           - link-frequencies
-- 
2.34.1

