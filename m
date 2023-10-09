Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CA07BE9B4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378224AbjJIShd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378209AbjJIShP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:37:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04151C6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696876582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QVKQrPdUbZGc1wU+oO+Twkh3N/BNeBlGHNRWMhTu31k=;
        b=ZGdS2dKM/FSbizUYKYF0FsM70M33pd1lao1z+X1Qo88xNlV2WQ8MVdDS3q7t6ad0eAxZAv
        OrzI+Beqm7fSgw0DXPWpxREAQdr/1haUzAuT8iLAv5MKAfy72ucC8HMDSTcvmt5u8cEqPA
        rQoMUburAmDrSu+fEU5fygojyiYhTXU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252--Jhv4srvMLWE1aNEW_63eA-1; Mon, 09 Oct 2023 14:36:11 -0400
X-MC-Unique: -Jhv4srvMLWE1aNEW_63eA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-327ab41de6cso3517806f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876569; x=1697481369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVKQrPdUbZGc1wU+oO+Twkh3N/BNeBlGHNRWMhTu31k=;
        b=YxR1QwYwzU+CexLQT0z0UGL+6Wahyyot1gJoZu/rRHbbuZvNYjvWefMnaTpIk3ktIz
         QWzFr1cS1REgwKjp1GLIdCE36y/s3yW62zcQZU085dVyPZHG+SNApGY65Tn5yzhwsE4B
         A0XsjcoWJVaUcb60/HKvJSd4LNqE0UqSNEM1eCVsiQMsVyAezIhJYbRNMxAvKGgpQd0E
         xyx4kpy6GfYo1voiItAofYOz/pIoyiCgzzX3IRKN+UcFpPF8NP5bpNt2W4shavePiq7Z
         tg1b1msvzew2atgMYGJalIvmCZxlJW2Nf4YNwVwEqaqFzWkpDGTeJJ9YTFEznBKOymzx
         OK2w==
X-Gm-Message-State: AOJu0Yz7cjS62vLbVlZ6cTGo6xjkwefLoCqGNe9Mvp20rUmw9JcTI4bQ
        Ya7hCDO92y/j29ES2akmECTGq39YDRBswpnuLn1U2+wcZkq9POBJEaSt2LBp+UI2HlhvgbeqYxc
        CxusL5FxsvTnbPcy35BQXWjgOqE4N/4P53UjnObciQfJ+qgGzrdyVLMc/IF/htvYIRkaEr/JJNR
        y62eVgIiY=
X-Received: by 2002:a05:6000:1008:b0:31a:ed75:75df with SMTP id a8-20020a056000100800b0031aed7575dfmr14391824wrx.15.1696876569561;
        Mon, 09 Oct 2023 11:36:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHU9ipeYY5/67yz9rQUzhHMG8K4QZBRRRVgXLPaNfAyAaJFKTL902MD4ZsjPgkqmWa4uorcA==
X-Received: by 2002:a05:6000:1008:b0:31a:ed75:75df with SMTP id a8-20020a056000100800b0031aed7575dfmr14391797wrx.15.1696876569304;
        Mon, 09 Oct 2023 11:36:09 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b16-20020adfe650000000b003266ece0fe2sm10221874wrn.98.2023.10.09.11.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:36:09 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 8/8] dt-bindings: display: Add SSD132x OLED controllers
Date:   Mon,  9 Oct 2023 20:34:22 +0200
Message-ID: <20231009183522.543918-9-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009183522.543918-1-javierm@redhat.com>
References: <20231009183522.543918-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a Device Tree binding schema for the OLED panels based on the Solomon
SSD132x family of controllers.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 .../bindings/display/solomon,ssd132x.yaml     | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd132x.yaml

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd132x.yaml b/Documentation/devicetree/bindings/display/solomon,ssd132x.yaml
new file mode 100644
index 000000000000..b64904703a3a
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/solomon,ssd132x.yaml
@@ -0,0 +1,116 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/solomon,ssd132x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Solomon SSD132x OLED Controllers
+
+maintainers:
+  - Javier Martinez Canillas <javierm@redhat.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - solomon,ssd1322
+          - solomon,ssd1325
+          - solomon,ssd1327
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  # Only required for SPI
+  dc-gpios:
+    description:
+      GPIO connected to the controller's D/C# (Data/Command) pin,
+      that is needed for 4-wire SPI to tell the controller if the
+      data sent is for a command register or the display data RAM
+    maxItems: 1
+
+  solomon,height:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Height in pixel of the screen driven by the controller.
+      The default value is controller-dependent.
+
+  solomon,width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Width in pixel of the screen driven by the controller.
+      The default value is controller-dependent.
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: solomon,ssd1322
+    then:
+      properties:
+        width:
+          default: 480
+        height:
+          default: 128
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: solomon,ssd1325
+    then:
+      properties:
+        width:
+          default: 128
+        height:
+          default: 80
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: solomon,ssd1327
+    then:
+      properties:
+        width:
+          default: 128
+        height:
+          default: 128
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ssd1327_i2c: oled@3c {
+                    compatible = "solomon,ssd1327";
+                    reg = <0x3c>;
+                    reset-gpios = <&gpio2 7>;
+            };
+
+    };
+  - |
+    spi {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ssd1327_spi: oled@0 {
+                    compatible = "solomon,ssd1327";
+                    reg = <0x0>;
+                    reset-gpios = <&gpio2 7>;
+                    dc-gpios = <&gpio2 8>;
+                    spi-max-frequency = <10000000>;
+            };
+    };
-- 
2.41.0

