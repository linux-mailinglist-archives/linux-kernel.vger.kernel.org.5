Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5D17C78C0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 23:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442931AbjJLVkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 17:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442971AbjJLVkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 17:40:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189F1C0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697146761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zvrgj9LmWX09P0otLVv1M+TO46oxoY5RjfV1LrD5p/Y=;
        b=JskmBZxpe5UDvX660P6u7c4mGbaBsQO+pV4PcXZHZm2nWIwVamcGxsSusMG1QZqovpjWtq
        wpJt2zda80T8veH5brA55Q4Z+MYvSIASpVy/REwWtuoMkQBeLJbkdBZfoQ2ZFR96UqeNZC
        ILaUJuiGX80gtIaxyctuWdHyjhcOOVc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-M4cFfE54NzCkvjHZZ6RJEQ-1; Thu, 12 Oct 2023 17:39:15 -0400
X-MC-Unique: M4cFfE54NzCkvjHZZ6RJEQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4065ca278b3so9930685e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697146753; x=1697751553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zvrgj9LmWX09P0otLVv1M+TO46oxoY5RjfV1LrD5p/Y=;
        b=YsR9jpisKikY9EYUjWtciA3xkrSsWvMnsJhjj3PEs+EjUna4JEymiOGym5Z2/SqNVz
         d/GAmFnAOK4UAj8fcLh1vxx+51YSQoCJxgEZjW+l/L5jmKpcYDpsqzOI3OhJG0Ioe5ga
         cnNfrJ3AnlKjIrQ++c6Fux27g2SuLVlGCtLwXn+sE5QT3aqvwiLa/qfbhD2G3o7kXXOW
         W0YGDXb8AmIhRz3SoJ9FwMy9rm1ok1xBnfXr8Tx4APTrti6aVO2h84dfmQ4HZIOiXiwm
         e5sW/f0o5isKMB0LrdfIviGyCQr/tTF1RJdaBPEAp6/k840bCytk4N3xoQESWOAtk817
         DBKw==
X-Gm-Message-State: AOJu0Yyccr3mvAAdUVcl9uIJQdGAWeBEH+8RvfRskEYEiy1HftnNRzxL
        cFlrGHlPZHH6pkn6KsALVa+pvTBXWBGA0UORLbcQOVAw6uqTAAzWg7USwiKB41dh1k/0WgvI34l
        MUnXkprdyMvTJpAUKiOCDB5PaGxy4EwDuWz66eQDTo5RbfDmyztlI1tuv390zx4TM0LvI8NI0X3
        asXX42AO4=
X-Received: by 2002:a05:6000:c47:b0:32d:96e0:8048 with SMTP id do7-20020a0560000c4700b0032d96e08048mr1285809wrb.9.1697146753424;
        Thu, 12 Oct 2023 14:39:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa0OCXnp4TmZg8fDDOv2923o5ApTWRzYFiWzqeGRiluRFdYCqG4XtpAfQeNB8xNHJ97UalbQ==
X-Received: by 2002:a05:6000:c47:b0:32d:96e0:8048 with SMTP id do7-20020a0560000c4700b0032d96e08048mr1285788wrb.9.1697146753151;
        Thu, 12 Oct 2023 14:39:13 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l16-20020a056000023000b0032d893d8dc8sm4982734wrz.2.2023.10.12.14.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 14:39:12 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v3 5/6] dt-bindings: display: Split common Solomon properties in their own schema
Date:   Thu, 12 Oct 2023 23:38:35 +0200
Message-ID: <20231012213843.1151060-6-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012213843.1151060-1-javierm@redhat.com>
References: <20231012213843.1151060-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are DT properties that can be shared across different Solomon OLED
Display Controller families. Split them into a separate common schema to
avoid these properties to be duplicated in different DT bindings schemas.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v3:
- Fix "No newline at end of file" in solomon,ssd-common.yaml (Rob Herring).
- Add Rob Herring's Reviewed-by tag to patch #5.

 .../bindings/display/solomon,ssd-common.yaml  | 42 +++++++++++++++++++
 .../bindings/display/solomon,ssd1307fb.yaml   | 28 +------------
 MAINTAINERS                                   |  1 +
 3 files changed, 44 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd-common.yaml

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd-common.yaml b/Documentation/devicetree/bindings/display/solomon,ssd-common.yaml
new file mode 100644
index 000000000000..3e6998481a75
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/solomon,ssd-common.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/solomon,ssd-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common properties for Solomon OLED Display Controllers
+
+maintainers:
+  - Javier Martinez Canillas <javierm@redhat.com>
+
+properties:
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
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
index 20e2bd15d4d2..3afbb52d1b7f 100644
--- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
+++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
@@ -27,38 +27,12 @@ properties:
           - solomon,ssd1307
           - solomon,ssd1309
 
-  reg:
-    maxItems: 1
-
   pwms:
     maxItems: 1
 
-  reset-gpios:
-    maxItems: 1
-
-  # Only required for SPI
-  dc-gpios:
-    description:
-      GPIO connected to the controller's D/C# (Data/Command) pin,
-      that is needed for 4-wire SPI to tell the controller if the
-      data sent is for a command register or the display data RAM
-    maxItems: 1
-
   vbat-supply:
     description: The supply for VBAT
 
-  solomon,height:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description:
-      Height in pixel of the screen driven by the controller.
-      The default value is controller-dependent.
-
-  solomon,width:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description:
-      Width in pixel of the screen driven by the controller.
-      The default value is controller-dependent.
-
   solomon,page-offset:
     $ref: /schemas/types.yaml#/definitions/uint32
     default: 1
@@ -148,7 +122,7 @@ required:
   - reg
 
 allOf:
-  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - $ref: solomon,ssd-common.yaml#
 
   - if:
       properties:
diff --git a/MAINTAINERS b/MAINTAINERS
index 46ca5c4affdb..4a3baf970839 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6732,6 +6732,7 @@ DRM DRIVER FOR SOLOMON SSD130X OLED DISPLAYS
 M:	Javier Martinez Canillas <javierm@redhat.com>
 S:	Maintained
 T:	git git://anongit.freedesktop.org/drm/drm-misc
+F:	Documentation/devicetree/bindings/display/solomon,ssd-common.yaml
 F:	Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
 F:	drivers/gpu/drm/solomon/ssd130x*
 
-- 
2.41.0

