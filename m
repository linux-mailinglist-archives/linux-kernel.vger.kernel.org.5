Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F330079F393
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbjIMVPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbjIMVPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:15:22 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814AA1BCF;
        Wed, 13 Sep 2023 14:15:14 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c1f8aaab9aso1936265ad.1;
        Wed, 13 Sep 2023 14:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694639713; x=1695244513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzfhoXLsSjlLrRJfrDSVVG5FOU2Ipha50d0RVuqA3Xc=;
        b=R61KAzd83s/bd20DrI1mGlt+QhnQm9DgeG+vzc5lQypSlO8WXK36cKRzB5FLw7+8cK
         4veYfTXlVfDY4Reqb3xmbnkbNU/hEfIYgVnq3wDly9vmM+oLz/aIrBwVJbLjBKw9fDje
         5ET5+tNM3BJoCn7np1DlHc/eRD9LTkR+h32mdQQer4puih5ISEi64hhs5vkbIPpn6QTB
         /3GP7PT+D4gMv9nQ+iO9/JKNmXmU21PuPpaXvxA0OOdF+hcDdVzpnjVr2ct43OibxQbz
         fKH0DYNSwicBHFeyz5Z+q0b9HdE/2gcRpetDCtqoN5ML4N1dtODSNUL9IOrCHo/yyNDZ
         baBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694639713; x=1695244513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzfhoXLsSjlLrRJfrDSVVG5FOU2Ipha50d0RVuqA3Xc=;
        b=Gp6W6exO7qu0ADeNomO/oDGS19yCLy1Cp7GM+N6RJ3UbtYxBc63h6Zye2N9fP54Me4
         v9axQ/2p5Tc0i8hWMW6xLgMpZYLZgfQ9+DYTDMM7RlAVTWiaDPIKL4I/CrQ6SMAGzwQP
         tFOtsdKyMsdJdaScYJlJ8Z6Vx8bpEzvsQ2b0ygNz/0ycdlIvLWojWt7RSNyTjf5T93o2
         zxW3VLaD/9jFuE7sbKlyqdkGQhIeiBteETOqh7yzsGMgJYzZ1MCaDLyfA5n6PedYi3lc
         WlfcMVtCFXKN2vsXQSP/xHg4qH5Zeyvt+fkcxZIyoD9D+ywqcm5QYfjEIxvN0jzV/NcP
         GrOg==
X-Gm-Message-State: AOJu0YzGa+uk7jRDTS+hIOu32kx2cvJ9+V3+gCvUdApx8W5MLuHEY05z
        NB/mjKlxy9n9zn2ahsByrG49wBW8FC0=
X-Google-Smtp-Source: AGHT+IFvb0nI4rxjSSA6s4XBO614WrAZfL61hagQlHGLBtcxZSd18u+5J/EvBgriHLf9rgRJV2PLGA==
X-Received: by 2002:a17:903:22c5:b0:1c3:cee1:cc8e with SMTP id y5-20020a17090322c500b001c3cee1cc8emr4508196plg.68.1694639713666;
        Wed, 13 Sep 2023 14:15:13 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:82b1:d7c2:2eaf:61e7])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090301d200b001b8c689060dsm73707plh.28.2023.09.13.14.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 14:15:13 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 3/4] dt-bindings: serial: document esp32s3-acm bindings
Date:   Wed, 13 Sep 2023 14:14:48 -0700
Message-Id: <20230913211449.668796-4-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230913211449.668796-1-jcmvbkbc@gmail.com>
References: <20230913211449.668796-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the ESP32S3 ACM controller.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 .../bindings/serial/esp,esp32-acm.yaml        | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/esp,esp32-acm.yaml

diff --git a/Documentation/devicetree/bindings/serial/esp,esp32-acm.yaml b/Documentation/devicetree/bindings/serial/esp,esp32-acm.yaml
new file mode 100644
index 000000000000..dafbae38aa64
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/esp,esp32-acm.yaml
@@ -0,0 +1,40 @@
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
+description: |
+  ESP32S3 ACM controller is a communication device found in the ESP32S3
+  SoC that is connected to one of its USB controllers.
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
+    acm@60038000 {
+            compatible = "esp,esp32s3-acm";
+            reg = <0x60038000 0x1000>;
+            interrupts = <96 3 0>;
+    };
-- 
2.30.2

