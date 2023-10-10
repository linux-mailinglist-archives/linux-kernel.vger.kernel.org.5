Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282337BF6A6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjJJI7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjJJI7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:59:43 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D169F;
        Tue, 10 Oct 2023 01:59:39 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c434c33ec0so32845185ad.3;
        Tue, 10 Oct 2023 01:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696928379; x=1697533179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEPQeXbDNX7cEZDTBC032FO6/JWl4BuZWQHhgOFQHzg=;
        b=nHRt1ZhNdX6HP9fo2kYQztn6J95V3ns0P/BXJyBjtghn3eqv7or4Jr9tyORnAQTy4b
         qf0zZYhvJXmeTqySTlNHv7oN7LRcK9MFMSN8kNazG8Be8vEc7sSAxPmZVmngm/75fx8W
         ub3mAKyTZJEnvhcG7dF1dYNu01DGEvwHnnoDvsmXmq2l06iGt/QQ6wWsABRbkLDk15E9
         zinDhU5cKuV4/se8VoN4bFuwdLWDool0a+9YtY0CbU3F6TiVotRiRyxsZBhyHvE3JoU1
         +LHPJOtjapNK7FEBsPIaTt3wZh+sv+LimqbCQzgMXGi0HhYKg81YmbQvnpw2ID0slriA
         ANpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696928379; x=1697533179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEPQeXbDNX7cEZDTBC032FO6/JWl4BuZWQHhgOFQHzg=;
        b=c+CoPSt6HleEvnNbb35mBSEuv68NqcVZTqvCZhqPAnqLUXYoyp4zQQyZaBfhx3V8T7
         slyEbfztCjpd0MDIm3M4tDe9lLxpYJX9oWZH9Eksxiu2AaSFzShorV8EwsOsbtxMvxEh
         c834vZfAsMy/2+SpQmQlReoodwbOV5+NLMyDmPOS6TFxqyAKpIGcypoGTnmXOsbMD928
         3Ir7xd92E4hQi5yRj70wSfNoFQ/XFPYYJMRoY6qwPDM9beE9dYR8Bkt4ZdNP0uWJnp1r
         /ZxfVO7ASXOfU85Eio8fNrSuO2j3VItjYTXTUOLAfuZ4hs4Gwi5WnvMx0ON4wDZO9zpj
         cw2Q==
X-Gm-Message-State: AOJu0Yyc6RJCVRcHM+bBBYs/PoFl+y9DQOKKZLrOkBpxbwm83biknjc1
        ULpxcMvO4d2gCJhsQPGvCkr26A5o15I=
X-Google-Smtp-Source: AGHT+IEOz9ULpLzOBD00C5r5LQifLM4XDVQ8pIo8eYhsY/NZcfShpGJrrYbH6uECa1qLPlNQXUibmA==
X-Received: by 2002:a17:90b:fc6:b0:27c:edd5:6137 with SMTP id gd6-20020a17090b0fc600b0027cedd56137mr703187pjb.25.1696928378744;
        Tue, 10 Oct 2023 01:59:38 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:f462:7ab2:1aaa:db73])
        by smtp.gmail.com with ESMTPSA id o12-20020a17090a3d4c00b0027782f611d1sm12542731pjf.36.2023.10.10.01.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 01:59:38 -0700 (PDT)
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
Subject: [PATCH v5 2/5] dt-bindings: serial: document esp32-uart
Date:   Tue, 10 Oct 2023 01:59:23 -0700
Message-Id: <20231010085926.1021667-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231010085926.1021667-1-jcmvbkbc@gmail.com>
References: <20231010085926.1021667-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the ESP32xx UART controllers.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

