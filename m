Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BF47AD3B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbjIYItS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjIYIsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:48:55 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8692FDA;
        Mon, 25 Sep 2023 01:48:49 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3aca1543608so3972628b6e.0;
        Mon, 25 Sep 2023 01:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695631728; x=1696236528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPX1kwMKQM0/ph0MJT5sYDN8s7Zga8G5Q5u69VI1sEQ=;
        b=BCFUhPJ5ifVbJo1K6xUAvSBmq3cX+P9BUjnWdT1mXFWXnvkZbh5anAH2OQIa913cd3
         QGxD/3vEvE5Z1qVfWvL7Icl7qI92Zmbe+bGpi1uW2Sd+PSywXdv41fMKyG4Noo0cMhAm
         HvA0jdx5+1igSrJrRb64Ph67BW2yGW/gIJzehNrBCwoq+GU+IhsRbWUGvLsyM9Sw3u4w
         9kmZQfK42DtL58qMROek4l6BsLFyHNuUQ17Gmc14deVtpfCnu4y88CRDdTItm126/q+e
         fox69ifQ/ijYYXC2XkGqJla+gedzwP2pkQRdT6QbJ+49eUIKO/eP6F9W8QMAmT1PNKqL
         1B9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695631728; x=1696236528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPX1kwMKQM0/ph0MJT5sYDN8s7Zga8G5Q5u69VI1sEQ=;
        b=MTdTjeCxdtf4u/4hlobnylO4RJC8RTajENMuVQZX2IFocTgMF/aQ2mFvYJbJAyGr9a
         mT50O4D3JnpW54/filnrxnaDHa5hXyNiOD+xbBc+a6IGpWLZ/BqbmP0RBEXPsz51VykE
         nkfL27YG/a9QcpT15hYjJ2F2ku5AD8l3B5N2fTB3TYcgCJgcWLQW6FUMm2Np1ChYoc8t
         188x4H/+bMbBR/OdWdNDVVx4bcYA7wyRK9FNfd/Ca94xXHqcDSsNQDGvfE6yEWNjqEaL
         lt76QivqCEBm72+ylRetlxgPYOHQoThU6WbbvL92fKtU6Vy99+DLapgrjrsEwiMgVUmL
         3Tpg==
X-Gm-Message-State: AOJu0YzJH9ktLhn4l3JaOoOLAgiQjA+18CHeE0T7DiMDd+5KqL2R5j95
        Z3zJXxt6cHrTmYxnPjUxxiB10mVGvDI=
X-Google-Smtp-Source: AGHT+IGlft9dU+UnwN4t/gm5fKKCotl2l1Nj/mmc6913HXBLAeATV9RkTXyZD55hlc5woE8H5hcRZg==
X-Received: by 2002:a05:6358:998e:b0:143:321:f36b with SMTP id j14-20020a056358998e00b001430321f36bmr6646787rwb.18.1695631728396;
        Mon, 25 Sep 2023 01:48:48 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:bc97:e554:1bd8:be33])
        by smtp.gmail.com with ESMTPSA id t63-20020a638142000000b0055c178a8df1sm7406376pgd.94.2023.09.25.01.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 01:48:47 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v3 2/5] dt-bindings: serial: document esp32-uart
Date:   Mon, 25 Sep 2023 01:48:22 -0700
Message-Id: <20230925084825.4160708-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230925084825.4160708-1-jcmvbkbc@gmail.com>
References: <20230925084825.4160708-1-jcmvbkbc@gmail.com>
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

Add documentation for the ESP32xx UART controllers.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>

---
Changes v2->v3:
- add a reference to serial.yaml

Changes v1->v2:
- drop '|' from description
- change 'compatible' property type to enum
- drop label from the example node
- fix example indentation

 .../bindings/serial/esp,esp32-uart.yaml       | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/esp,esp32-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/esp,esp32-uart.yaml b/Documentation/devicetree/bindings/serial/esp,esp32-uart.yaml
new file mode 100644
index 000000000000..2a80ca997a0c
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/esp,esp32-uart.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/esp,esp32-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ESP32xx UART controllers
+
+maintainers:
+  - Max Filippov <jcmvbkbc@gmail.com>
+
+description:
+  ESP32 UART controller is a part of the ESP32 SoC.
+  ESP32S3 UART controller is a part of the ESP32S3 SoC.
+  Both SoCs are produced by Espressif Systems Co. Ltd.
+
+allOf:
+  - $ref: serial.yaml#
+
+properties:
+  compatible:
+    enum:
+      - esp,esp32-uart
+      - esp,esp32s3-uart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    serial@60000000 {
+      compatible = "esp,esp32s3-uart";
+      reg = <0x60000000 0x80>;
+      interrupts = <27 1 0>;
+      clocks = <&serial_clk>;
+    };
-- 
2.30.2

