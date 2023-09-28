Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC2B7B214E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjI1Paa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjI1PaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:30:19 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53407DD;
        Thu, 28 Sep 2023 08:30:18 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c735473d1aso9010695ad.1;
        Thu, 28 Sep 2023 08:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695915017; x=1696519817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEPQeXbDNX7cEZDTBC032FO6/JWl4BuZWQHhgOFQHzg=;
        b=ktNBy0jPnShWfOSdU+VZPgM5cRu3lrvVUWuttuZcWPScOAP+KT/VyGSoQWoVfm1ZPe
         fQzGs4pMYWSCqqxlGTIZNI4kJKdgrqtQ5RnW6SC71Peaznxy/iXS/iNxnN8XKb/ToS7M
         MV21/NGtbYF9KB+xVEgHzxHV9dRvBUnaxPVJdIVrE6ucYpDDQ1fyvGPGps2GHHufHzaZ
         O4vpZAAHm/T6+8BZsls53/Lh6CaiULtqo+Vlqzpg+1VF5bTv+IWResTLxHJ1dKtBWeLC
         hvHv6rgF52J1qPiCpRwF7v/omVQnzNDj3f5fveDQxhR1pk/HqRYSW+IQG/a2Lf/qNtk3
         bVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695915017; x=1696519817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEPQeXbDNX7cEZDTBC032FO6/JWl4BuZWQHhgOFQHzg=;
        b=G5cVeNtETtpjP+q9GJ4yUuR/iVkjdZUO3ZUWj/pfhNgFy64piKDED0YDO/V38uaDYN
         RBb2icwP6qUHXHcv2L5lshaMlBFNSr0fJ4+PfPVC88MoAprkyBoczRiDNMp7gowY6WV5
         qhw5WIzIyPSmq+2MjFfBqkvEE7etKZbys6w3vY1SuaRB8wGqh4mtLPsMDU2qyTdSuf4u
         j/n78fF3H2gF5iX9x9KwacHUhg3dFiOeo9EF95sgIOqy6oMOfIg0tWoG9nfS6tWejSqJ
         w1B2A0/LgGq+nv/O9ZzeYZXhwIjHrvpaTDfDvE7/IDUnpGM+zT1sl3wZu4LiK9QsDOcc
         NXtA==
X-Gm-Message-State: AOJu0YxDSXZ9GaE2D+qB23bJtWS/pteTnVFZ8tGavD3i0P4IiuKJ4DRI
        A2QSpXf3oJsqFyGwANVzU/KICDE0b3U=
X-Google-Smtp-Source: AGHT+IGlcnvY0xKXicStD87CG+2N+YNkt8blHGZGAEpTTNtJbxMKa1vSBLeFz/fz/y9BI0FljkML+g==
X-Received: by 2002:a17:90a:6046:b0:274:b12a:37ad with SMTP id h6-20020a17090a604600b00274b12a37admr1408433pjm.37.1695915017515;
        Thu, 28 Sep 2023 08:30:17 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:a19c:f3d0:698d:f7a])
        by smtp.gmail.com with ESMTPSA id m6-20020a17090a414600b00274a9f8e82asm3892318pjg.51.2023.09.28.08.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 08:30:17 -0700 (PDT)
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
Subject: [PATCH v4 2/5] dt-bindings: serial: document esp32-uart
Date:   Thu, 28 Sep 2023 08:16:28 -0700
Message-Id: <20230928151631.149333-3-jcmvbkbc@gmail.com>
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

