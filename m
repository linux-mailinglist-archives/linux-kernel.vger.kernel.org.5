Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3480F7E1E6D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjKFKdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjKFKd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:33:27 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2F6134
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 02:33:22 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32f7c80ab33so2591924f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 02:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699266801; x=1699871601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBQ+A9rHpTWs3KpXp33WW8nDFpcoA+H+EybbPKfpqLY=;
        b=mwewnK/A2XA9c0ngLeYhwiW8sP/L5Jn6gGMZu9z4WhW5l4JvgmqLJmUJa4jE+UDncx
         aPEvvC0X/nvEulsZNlRRQBhiHdSRVOXzeSOpukfKJq6bMBNHJDpXfjGa0rBglhznMGX8
         GDdggr9FcyWuDbQm5q6bAVWPuG5xQxGcDCNaHBcE4Ft7M5y+t4M1+HB46/m0+vlNViDp
         KcyDorut+PRC91zhqaOyrzw0ld2tFMShvNG3Qt/SOWIoYUS9n6gZQG2sw9xcU76ttefQ
         uC7oF4F9MovIltpNMAaY4foIP0msnbifeA1EM3enirNJsMkH2DRvRj/0sgQS2KQKtoys
         1/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699266801; x=1699871601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBQ+A9rHpTWs3KpXp33WW8nDFpcoA+H+EybbPKfpqLY=;
        b=A79FMieCv9U0iwyVG/woDHn5kUxjSvR/bp9Oi/GxJuQGwm/6HjuTRT7WyO8Y4KheQC
         eLMMLHhAsX4J4PCx9RqBVDVGQQc3N8OztECIMjiC+j4GvPogTZCUyIET94Fbty8t/ttV
         v8eVj82h14TtpPhf4qmGX1cz1OSp8L6/C1BLDPLJALu3kYjpua4LmiwQR0LN247lv/tn
         rUzR08oH0tIhoGSOTxvuJ7N4RKHoior7IZA52W6DTrot14zXvlyGETC7qQf37g26G/fo
         LJ+4nJHYlgUBiTM1T3wrkhIkYMpAuxERZfJI5FBGY923BzZf7nm+ddwwJuRxztHTQNtQ
         BObQ==
X-Gm-Message-State: AOJu0YxVVdiALgck1GtaNfCThNTGsNs5u62ZWzYAIZVJPnYuWDB9BpW8
        HouPl/QMSsjfxu7dhJPDyP1QUg==
X-Google-Smtp-Source: AGHT+IHcMPiY4o25MgzGfKk9Wcu81DblqKFjLfX/laBmvungFxUJ0K81n8g5LnJVDzF1XKHmm4zZPA==
X-Received: by 2002:adf:ecd0:0:b0:32d:a717:717a with SMTP id s16-20020adfecd0000000b0032da717717amr18098713wro.40.1699266801294;
        Mon, 06 Nov 2023 02:33:21 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:fabf:ec8c:b644:5d3])
        by smtp.googlemail.com with ESMTPSA id d1-20020a056000114100b0032415213a6fsm9033602wrx.87.2023.11.06.02.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 02:33:21 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        JunYi Zhao <junyi.zhao@amlogic.com>
Subject: [PATCH 2/6] dt-bindings: pwm: amlogic: add new compatible for meson8 pwm type
Date:   Mon,  6 Nov 2023 11:32:49 +0100
Message-ID: <20231106103259.703417-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106103259.703417-1-jbrunet@baylibre.com>
References: <20231106103259.703417-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new compatible for the pwm found in the meson8 to sm1 Amlogic SoCs.

The previous clock bindings for these SoCs described the driver and not the
HW itself. The clock provided was used to set the parent of the input clock
mux among the possible parents hard-coded in the driver.

The new bindings allows to describe the actual clock inputs of the PWM in
DT, like most bindings do, instead of relying of hard-coded data.

The new bindings make the old one deprecated.

There is enough experience on this HW to know that the PWM is exactly the
same all the supported SoCs. There is no need for a per-SoC compatible.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 35 +++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
index 754b70fc2db0..3aa522c4cae4 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
@@ -22,6 +22,7 @@ properties:
           - amlogic,meson-g12a-ao-pwm-ab
           - amlogic,meson-g12a-ao-pwm-cd
           - amlogic,meson-s4-pwm
+          - amlogic,meson8-pwm-v2
       - items:
           - const: amlogic,meson-gx-pwm
           - const: amlogic,meson-gxbb-pwm
@@ -37,7 +38,7 @@ properties:
 
   clocks:
     minItems: 1
-    maxItems: 2
+    maxItems: 4
 
   clock-names:
     minItems: 1
@@ -70,11 +71,14 @@ allOf:
               - amlogic,meson-gx-pwm
               - amlogic,meson-gx-ao-pwm
     then:
-      # Historic bindings tied to the driver implementation
+      # Obsolete historic bindings tied to the driver implementation
       # The clocks provided here are meant to be matched with the input
       # known (hard-coded) in the driver and used to select pwm clock
       # source. Currently, the linux driver ignores this.
+      deprecated: true
       properties:
+        clocks:
+          maxItems: 2
         clock-names:
           oneOf:
             - items:
@@ -83,6 +87,26 @@ allOf:
                 - const: clkin0
                 - const: clkin1
 
+  # Newer binding where clock describe the actual clock inputs of the pwm
+  # block. These are necessary but some inputs may be grounded.
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,meson8b-pwm-v2
+    then:
+      properties:
+        clocks:
+          minItems: 1
+          items:
+            - description: input clock 0 of the pwm block
+            - description: input clock 1 of the pwm block
+            - description: input clock 2 of the pwm block
+            - description: input clock 3 of the pwm block
+      required:
+        - clocks
+
   # Newer IP block take a single input per channel, instead of 4 inputs
   # for both channels
   - if:
@@ -111,6 +135,13 @@ examples:
       clock-names = "clkin0", "clkin1";
       #pwm-cells = <3>;
     };
+  - |
+    pwm@2000 {
+      compatible = "amlogic,meson8-pwm-v2";
+      reg = <0x1000 0x10>;
+      clocks = <&xtal>, <0>, <&fdiv4>, <&fdiv5>;
+      #pwm-cells = <3>;
+    };
   - |
     pwm@1000 {
       compatible = "amlogic,meson-s4-pwm";
-- 
2.42.0

