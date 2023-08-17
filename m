Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAD977F0FB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 09:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348382AbjHQHL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 03:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348368AbjHQHLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 03:11:07 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EB32D54
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 00:11:03 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9923833737eso974847166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 00:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1692256262; x=1692861062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b90IMLBWM6zQGsk777iCjnjr53BKkJdrEo5WNQ1ldaY=;
        b=H2c7NBiQQhO7/E+JhYmltH5Qey+YF7rioiXGPAct8f1Q++JttPziqyPgN9AzV7QaeC
         wbvn0skUZbWJx3/XZ8hT5/KK2lY+EoBYEsTKBGFocAUZyM2BqhyFrNd/fMB1Jt4bxcfP
         vt5Sp3TwVEGX2NMLnd3+P4pVzHO3g98ugqPOPMomOVeuLRGo7ljqecvx/0HL90dJY5MY
         BTyNeomIxik49AbiSKIH5sYTeHhEkCbXYPS9OO6LqQwlx6nRijQaQZU8J26pIAfRMm42
         F62n2sZeF8VDqtjLbFTM7Gd0ii2k7oQXvuNl+Q/85HIColE/a4BXG26jmUckMCnjEPZb
         4y/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692256262; x=1692861062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b90IMLBWM6zQGsk777iCjnjr53BKkJdrEo5WNQ1ldaY=;
        b=Sn5MDH96aF1VDHiHncmjLfwRf2wHNb6B/NjQ/mmLzVs9iT0QRwQ3RnTTyjXtwiV6KJ
         ZZz0+vcpJDUlVuDKx58JFbUo22SkpQwV7ljPqCRe8IKbPCS5Ar22S7weltgwuRmF5KqE
         Zu5pvJwCTkEGBdCsb5GXz9MgqNfFD2sC6eYEcA5uWzpNlNuHd+kuewGzpW67BRhUZj30
         RWl+9XuEjnQJpf3vFRkg6PTTA6dXEmnsLZmleeBNoQqJ6WShQ0KOug8sQMy/hArTlur+
         ulOkRZQe6jajkV8wD52HyQf0iQqr3W73GEQkL9qHa55RUd+18SWJFYcxkPU2GrAvGu3+
         w9Dg==
X-Gm-Message-State: AOJu0YwKG29HxGchdvPZ0f4pz/rRUL690aDOhFGwpJtbNdwSJZ2+QGi+
        dAie+0WCQSZZetu4NnbjDTmomg==
X-Google-Smtp-Source: AGHT+IEgdlNDyUuQTO740sHhf8djCEa8VT8SCiFbw6TV/IOas227T3QbIjZIW2aIg8rgvvW1eRh80Q==
X-Received: by 2002:a17:906:311b:b0:99b:507d:dc05 with SMTP id 27-20020a170906311b00b0099b507ddc05mr3493724ejx.16.1692256261878;
        Thu, 17 Aug 2023 00:11:01 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-095-222-150-251.um34.pools.vodafone-ip.de. [95.222.150.251])
        by smtp.gmail.com with ESMTPSA id qn17-20020a170907211100b00992b510089asm9674361ejb.84.2023.08.17.00.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 00:11:01 -0700 (PDT)
From:   Patrick Rudolph <patrick.rudolph@9elements.com>
To:     Peter Rosin <peda@axentia.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     naresh.solanki@9elements.com,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v15 2/4] dt-bindings: i2c: Add Maxim MAX735x/MAX736x variants
Date:   Thu, 17 Aug 2023 09:10:51 +0200
Message-ID: <20230817071056.2125679-3-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817071056.2125679-1-patrick.rudolph@9elements.com>
References: <20230817071056.2125679-1-patrick.rudolph@9elements.com>
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

Update the pca954x bindings to add support for the Maxim MAX735x/MAX736x
chips. The functionality will be provided by the existing pca954x driver.

For chips that are powered off by default add a regulator called vdd-supply.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/i2c/i2c-mux-pca954x.yaml         | 23 +++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
index e5c1070903ef..2d7bb998b0e9 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
@@ -4,18 +4,29 @@
 $id: http://devicetree.org/schemas/i2c/i2c-mux-pca954x.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: NXP PCA954x I2C bus switch
+title: NXP PCA954x I2C and compatible bus switches
 
 maintainers:
   - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 
 description:
-  The binding supports NXP PCA954x and PCA984x I2C mux/switch devices.
+  The NXP PCA954x and compatible devices are I2C bus
+  multiplexer/switches that share the same functionality
+  and register layout.
+  The devices usually have 4 or 8 child buses, which are
+  attached to the parent bus by using the SMBus "Send Byte"
+  command.
 
 properties:
   compatible:
     oneOf:
       - enum:
+          - maxim,max7356
+          - maxim,max7357
+          - maxim,max7358
+          - maxim,max7367
+          - maxim,max7368
+          - maxim,max7369
           - nxp,pca9540
           - nxp,pca9542
           - nxp,pca9543
@@ -56,6 +67,10 @@ properties:
     description: if present, overrides i2c-mux-idle-disconnect
     $ref: /schemas/mux/mux-controller.yaml#/properties/idle-state
 
+  vdd-supply:
+    description: A voltage regulator supplying power to the chip. On PCA9846
+      the regulator supplies power to VDD2 (core logic) and optionally to VDD1.
+
 required:
   - compatible
   - reg
@@ -68,6 +83,8 @@ allOf:
           compatible:
             contains:
               enum:
+                - maxim,max7367
+                - maxim,max7369
                 - nxp,pca9542
                 - nxp,pca9543
                 - nxp,pca9544
@@ -94,6 +111,8 @@ examples:
             #size-cells = <0>;
             reg = <0x74>;
 
+            vdd-supply = <&p3v3>;
+
             interrupt-parent = <&ipic>;
             interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
             interrupt-controller;
-- 
2.41.0

