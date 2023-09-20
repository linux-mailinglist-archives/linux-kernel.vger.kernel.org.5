Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D837A7059
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 04:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjITC1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 22:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjITC1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 22:27:13 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB40D3;
        Tue, 19 Sep 2023 19:27:06 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-690b7cb71aeso321888b3a.0;
        Tue, 19 Sep 2023 19:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695176825; x=1695781625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ctG9h68bN1LpqNi5sowsdHW8jUAN0KhQ159GSSbtDo=;
        b=RUnJ++75ICIE2dssgzv1QFEJIn6P1h94Z7b6l1vDZTcyOEBQBg2xYtzEM5ul9RntWS
         nEmtHWu/rs3i7Ve/Kjg/ANeZaj4haVCbAiTArwGLY4K6kG2k7SZvjshiEQLGHzCrkq9U
         bArjYAismmkHGUY9bcinJc5yRO2I+wyL5MYBdxkomDpXpGXWnTS6pqENJmU4nLOUKc6U
         U/qVDyUOwYJlOY7gi/PpBgFVu1iXvw+S1iqhLez+NvjbUHI3zwmKzWvGCtHWHmkHDneF
         WEdDlMos+cto7JOhDIUZGgHR2v54IDg06WR5DEKxLU4hvPREgOaLWlmJrGtm9GrZpCD3
         nbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695176825; x=1695781625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ctG9h68bN1LpqNi5sowsdHW8jUAN0KhQ159GSSbtDo=;
        b=Cn/nufUkElUQlDCELGUgpWV0t0Pc5J6Md3ghaOUcvv0K6mwzHN5HGmoDQmO3HRbmyj
         I033dhKz9JCCnMbbGRwWH3hK53btbJi0QJFyuOY+YYp86mmYm6tB5C5bXa7XayoH89AG
         bENLjOtAdJDi28qO5+AwGKsVuZsI5f/KCJu2S2WxcjdLsNFbCGkbvDfQKhjtQmzVCdfY
         02jz7vLLRP/GtLf/5iAvWsJ8X9+dnNSbOC6HH1BvE/aunq7rGbBvPw7PRyAo0tF6929a
         KuiI9cwNtbh9D9DzqiVp7zaBorhO3KkyRZYAUlOnyaIfPMi3K1qpElVOUGfQlkHBVCZm
         Ge/Q==
X-Gm-Message-State: AOJu0YzjT9ppv7ANpcYM43DY5r67o3SPm+wPIzYLiEjCec5o699cma9C
        IdQBrSOapzlUO8sX79ReiUwVQRwSIdc=
X-Google-Smtp-Source: AGHT+IH8lDYXXk+wnakZWmbQS7+dUVqPwbYitARw1OdarcbJDpJ7ns/R2XBL1mHfaFEUetxB3afvyQ==
X-Received: by 2002:a05:6a00:b44:b0:68a:6d34:474b with SMTP id p4-20020a056a000b4400b0068a6d34474bmr6440975pfo.15.1695176825287;
        Tue, 19 Sep 2023 19:27:05 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:9ca3:318f:421e:68cb])
        by smtp.gmail.com with ESMTPSA id p15-20020a62ab0f000000b0067aea93af40sm9224757pff.2.2023.09.19.19.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 19:27:04 -0700 (PDT)
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
Subject: [PATCH v2 4/5] dt-bindings: serial: document esp32s3-acm
Date:   Tue, 19 Sep 2023 19:26:43 -0700
Message-Id: <20230920022644.2712651-5-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230920022644.2712651-1-jcmvbkbc@gmail.com>
References: <20230920022644.2712651-1-jcmvbkbc@gmail.com>
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

---
Changes v1->v2:
- fix description
- rename node in the example
- fix example indentation

 .../bindings/serial/esp,esp32-acm.yaml        | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/esp,esp32-acm.yaml

diff --git a/Documentation/devicetree/bindings/serial/esp,esp32-acm.yaml b/Documentation/devicetree/bindings/serial/esp,esp32-acm.yaml
new file mode 100644
index 000000000000..6ec836db694a
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/esp,esp32-acm.yaml
@@ -0,0 +1,39 @@
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

