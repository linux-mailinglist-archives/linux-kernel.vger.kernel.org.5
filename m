Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FC27B2158
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjI1Pao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbjI1PaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:30:22 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A58B7;
        Thu, 28 Sep 2023 08:30:21 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-692a9bc32bcso9654042b3a.2;
        Thu, 28 Sep 2023 08:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695915020; x=1696519820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQh+M7SmDprRboBhgDHXIpxmaPaNtvjtjiuRyojb0gU=;
        b=hXZ971nvBO97AGIbCuoam/MZgQZhnHGCOeHWVwiiQcQD4H/uD+bqxlipCLdc7V+3Li
         Cw8HOw93LTLe0bVPKCl9XqNKPWgjLMhicWD/Grn0jNfSs3oSygKyFqmpgrv+94uCdpW3
         T34KPTN7+YuHXQ+9kWAFskY1Myek7vWkV77WJk8/37WKcwnWwhGW+RhjhBRTeFZCS6+e
         vCBhcm7Sux4yee58lTqOZl3jB00lBx+Sx0RKYFfLJFQy/yYRxduuvMThXe41EHzPaX3Q
         LIv26NxkrGOw+Q/drJrz0YtBY8mCM+KHLJ7lnvafpeP8aNRaOBO8bYzwftBD9ZE6KOUf
         EfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695915020; x=1696519820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQh+M7SmDprRboBhgDHXIpxmaPaNtvjtjiuRyojb0gU=;
        b=qpBk/u/MUlpjPFIKaL4++DnpbX+VuJQCDSqxDdefH51/IJt3NO0ey1vi3ZrUjtynmM
         qx0GHSO5SAB5e+BFNTorXX0jh5WtdM9VFvAH2ujkpiFZALYvP6RkF2G/Yla9WVbn41Dd
         JPD/aVO9SUrgoxOgVBoT+XVEvB1kMOf5RcOSDW7We2c+VHrmQif6Zc/k1/IhdtXvNz8E
         2ZT6M/Imo5mS+gf8RfgQGuX7NyydJoWAYrXKa9y7RYo91VRRMuIYnV1q1lAwGLcUWtqW
         9zvBjZCLViIoeFmuL+pgZSG6wwvHETxY5WGsvVa/SWEVsEmupCYD2TsR9VL381h2966i
         nAPw==
X-Gm-Message-State: AOJu0YxPWftNkk4pxjfL3JmOmHlZ6GUTgMCnMnfH8xNWPG5oRacgRAOz
        kdCM/lKgFFqfKD7rBkC0zlVgCFx7EDQ=
X-Google-Smtp-Source: AGHT+IG0oReNFmM2y81AJEWoWgx6RFlCDkJXE6VJKy53E5zBOnBmW/6qwwJEp2TK0DkidCScizB/zQ==
X-Received: by 2002:a05:6a21:32a6:b0:159:f39a:54e1 with SMTP id yt38-20020a056a2132a600b00159f39a54e1mr1788324pzb.51.1695915020353;
        Thu, 28 Sep 2023 08:30:20 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:a19c:f3d0:698d:f7a])
        by smtp.gmail.com with ESMTPSA id m6-20020a17090a414600b00274a9f8e82asm3892318pjg.51.2023.09.28.08.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 08:30:19 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 4/5] dt-bindings: serial: document esp32s3-acm
Date:   Thu, 28 Sep 2023 08:16:30 -0700
Message-Id: <20230928151631.149333-5-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230928151631.149333-1-jcmvbkbc@gmail.com>
References: <20230928151631.149333-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the ESP32S3 USB CDC-ACM controller.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes v2->v3:
- add a reference to serial.yaml

Changes v1->v2:
- fix description
- rename node in the example
- fix example indentation

 .../bindings/serial/esp,esp32-acm.yaml        | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/esp,esp32-acm.yaml

diff --git a/Documentation/devicetree/bindings/serial/esp,esp32-acm.yaml b/Documentation/devicetree/bindings/serial/esp,esp32-acm.yaml
new file mode 100644
index 000000000000..e385ca9d9e2b
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/esp,esp32-acm.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/esp,esp32-acm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ESP32S3 ACM controller
+
+maintainers:
+  - Max Filippov <jcmvbkbc@gmail.com>
+
+description:
+  Fixed function USB CDC-ACM device controller of the Espressif ESP32S3 SoC.
+
+allOf:
+  - $ref: serial.yaml#
+
+properties:
+  compatible:
+    const: esp,esp32s3-acm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    serial@60038000 {
+      compatible = "esp,esp32s3-acm";
+      reg = <0x60038000 0x1000>;
+      interrupts = <96 3 0>;
+    };
-- 
2.30.2

