Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E6C7C9326
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 09:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjJNHQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 03:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNHQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 03:16:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B85C2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 00:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697267737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=raAB53+V1qu2bUUCCKF3EKq6VfIA1dHSrOv8hUuGyAo=;
        b=SMWst+cqgfvaMS3YaHUJtt8swayvs/d2YRnJd/QnTWsZt8Gdu5siCV4kFtYIqAog6gXM+O
        disPOkk+ujp08gg5DnLDM4eyeDwKxxsuN/zHrKvNM8Kpm57RSuobXmZhjCJLglcGdGlzfZ
        Q1mgymcxGzwzVrDjfZIwA/YC1BAP3wI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-R7SRvfMZNtShFDBr5Fc6Hg-1; Sat, 14 Oct 2023 03:15:36 -0400
X-MC-Unique: R7SRvfMZNtShFDBr5Fc6Hg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2c50d4a1a33so7254501fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 00:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697267734; x=1697872534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=raAB53+V1qu2bUUCCKF3EKq6VfIA1dHSrOv8hUuGyAo=;
        b=HOzxogwJjoiDam/Vueqdh51IWM1eX3/FHr6dPqo6cz2nDaNFUYTPIkKkBHVgu3Pbjr
         /1tvzMRjApjb6XpUAJf6JDiP6kYZWneraiK09ZKI3iS/EoFdfIyxHtQZcWhvYHpZlSnD
         7+Twti2Mk0PCmfFOYZL5tV6R0U0zq4+JyKFGpYXvWr8FGorjpb2Gt9pG9EIzbEPhKfng
         ba+1bVYiuzwLj+vhCtWsLoW5pHvffEAM0AXgzHUHv9P/SHgWk/F4dNPqro33xc/WhZ5C
         gzRFYp3+CmVnVkB2S2TxP/d7/GFLPYOvOyCsZuX2nMLuiZQ/G479jJvRKjVJyFCkkGt8
         IHJQ==
X-Gm-Message-State: AOJu0YzXLenCHfkLnYcsP6Qi/GSKBSGwqPU+uW6ALGmoVl7dPbI9TrYz
        hcxSoVUxt1EfCLJjcAkfRbxoLeM1zWlTZ89BUIO3x/BaYRLEqgOtPioq1o3XBLarM6EmU5fl8ZL
        6yGajha7P+db8xT5vCmZOKEfhWyzTbADOBUaCVsVRT6l7dMMJ43ocMLBtj34sCo1p9uFUY0Fgdw
        qLqECgQvs=
X-Received: by 2002:a2e:a99a:0:b0:2c5:521:cec3 with SMTP id x26-20020a2ea99a000000b002c50521cec3mr4148494ljq.23.1697267734512;
        Sat, 14 Oct 2023 00:15:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGwjo1TWnsUDMoqQYTjitJuF6l8VXN+YN8uVve4vYyQKLFuyh4vtPwp12m6D7ie0yr7j0T0Q==
X-Received: by 2002:a2e:a99a:0:b0:2c5:521:cec3 with SMTP id x26-20020a2ea99a000000b002c50521cec3mr4148465ljq.23.1697267734152;
        Sat, 14 Oct 2023 00:15:34 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c190b00b0040646a708dasm1144730wmq.15.2023.10.14.00.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 00:15:33 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v4 6/6] dt-bindings: display: Add SSD132x OLED controllers
Date:   Sat, 14 Oct 2023 09:15:08 +0200
Message-ID: <20231014071520.1342189-7-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231014071520.1342189-1-javierm@redhat.com>
References: <20231014071520.1342189-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a Device Tree binding schema for the OLED panels based on the Solomon
SSD132x family of controllers.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
---

(no changes since v3)

Changes in v3:
- Add Rob Herring's Reviewed-by tag to patch #6.

Changes in v2:
- Remove unnecessary 'oneOf' in the SSD132x DT binding schema (Conor Dooley).
- Remove unused DT nodes labels in the binding schema examples (Conor Dooley).
- Split out common Solomon properties into a separate schema (Rob Herring).

 .../bindings/display/solomon,ssd132x.yaml     | 89 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 2 files changed, 90 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd132x.yaml

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd132x.yaml b/Documentation/devicetree/bindings/display/solomon,ssd132x.yaml
new file mode 100644
index 000000000000..0aa41bd9ddca
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/solomon,ssd132x.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/solomon,ssd132x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Solomon SSD132x OLED Display Controllers
+
+maintainers:
+  - Javier Martinez Canillas <javierm@redhat.com>
+
+properties:
+  compatible:
+    - enum:
+        - solomon,ssd1322
+        - solomon,ssd1325
+        - solomon,ssd1327
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: solomon,ssd-common.yaml#
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
+            oled@3c {
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
+            oled@0 {
+                    compatible = "solomon,ssd1327";
+                    reg = <0x0>;
+                    reset-gpios = <&gpio2 7>;
+                    dc-gpios = <&gpio2 8>;
+                    spi-max-frequency = <10000000>;
+            };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index c63649e9ba58..4b518429458b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6766,7 +6766,7 @@ M:	Javier Martinez Canillas <javierm@redhat.com>
 S:	Maintained
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/solomon,ssd-common.yaml
-F:	Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
+F:	Documentation/devicetree/bindings/display/solomon,ssd13*.yaml
 F:	drivers/gpu/drm/solomon/ssd130x*
 
 DRM DRIVER FOR ST-ERICSSON MCDE
-- 
2.41.0

