Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19217BF6A5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjJJI7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjJJI7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:59:43 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC006A9;
        Tue, 10 Oct 2023 01:59:41 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c737d61a00so42542055ad.3;
        Tue, 10 Oct 2023 01:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696928381; x=1697533181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knsmk50m/uDLQeOJXx3jysW3i/KekJPrSPk+OKdi4js=;
        b=Wf9uedmJQ8X5lcIpjWkF1yx/CcGmGpK6FGNioDaroI33zTgeWvTrq2juq4IxAk+drN
         w4m1lNiunM/Z2W7AUpdeqBeXNarUx9/TEBhZD7XU6JUjMV6Wv/YQT/2QNXvNqe53jMVk
         omhgU+LS8hGv39ONLNcaAzWxj3b2ps1WTwtNOmTkWppIb31rBZ4teDp1aNenmnuYp1I/
         cAkHs0aZseVf9/JdxdheKbrEsVmJUp4MkE92UiK/2ngBOR86fCyZlRoXzKURyTCGt2i7
         SekVKZh15F7SU0VJiuKUTZaQK0T1ltg2Dzu4Ys6Gij5Do6cLEvSMLxS9ECJ62LX5POQ9
         OlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696928381; x=1697533181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knsmk50m/uDLQeOJXx3jysW3i/KekJPrSPk+OKdi4js=;
        b=gB1FmGtSaQ4xaiLzTyzbhzpSKYtZYXYMItOzgLQLdwveXy8amBfMGJ/knl9VmskFpX
         hUkc55R0qGA2R+3nUiRwHGCVVxmVzwAsNYvMlIL5uNZbB1RDnrvY8uJ1IAB8+45dJZiB
         eIGxdA9XpU0IB4UifqqobWKLPfH/lJQU0PBor8E3xKQnXgpp2+ssbxTxiFzV4lRR98Zp
         vHMDVkXsChky5N1ypmXp3SNjOAQNjqaUjLKtQ+VAiylvUY/Qjvtpg/92wAECyFpC2hej
         p/X7tsUBv21aewaXuCEtLODriS83KPQnKkdur2aNM48puq5svx8JVS/OcU026+Y+s+Yc
         /2Sw==
X-Gm-Message-State: AOJu0YxQriyd3B+a8n5gNNYxE8IQSYv5Ooc5Acrp7ewAkT3AKv24GE4y
        Cm+0O3DtvIo5mVMRmuFN65eQZX+3QAw=
X-Google-Smtp-Source: AGHT+IH7CDTPmtgQB47CFVi4QyIC+c3WqACiWl8KLuNrS7ujy+yMBD6FV3rrEO49k/hJhVPNRmB7xg==
X-Received: by 2002:a17:90a:b891:b0:273:441a:dae6 with SMTP id o17-20020a17090ab89100b00273441adae6mr16528278pjr.19.1696928381009;
        Tue, 10 Oct 2023 01:59:41 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:f462:7ab2:1aaa:db73])
        by smtp.gmail.com with ESMTPSA id o12-20020a17090a3d4c00b0027782f611d1sm12542731pjf.36.2023.10.10.01.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 01:59:40 -0700 (PDT)
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
Subject: [PATCH v5 4/5] dt-bindings: serial: document esp32s3-acm
Date:   Tue, 10 Oct 2023 01:59:25 -0700
Message-Id: <20231010085926.1021667-5-jcmvbkbc@gmail.com>
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

Add documentation for the ESP32S3 USB CDC-ACM gadget controller.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes v4->v5:
- add the word 'gadget' to the description to make it more consistent
  with linux terminology

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
index 000000000000..77fbb2c72171
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
+title: ESP32S3 ACM gadget controller
+
+maintainers:
+  - Max Filippov <jcmvbkbc@gmail.com>
+
+description:
+  Fixed function USB CDC-ACM gadget controller of the Espressif ESP32S3 SoC.
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

