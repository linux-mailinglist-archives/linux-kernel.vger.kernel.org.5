Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C0F7F43E2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjKVKaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjKVKaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:30:04 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816CD91
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:30:00 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 5b1f17b1804b1-4083f613275so32891355e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1700648999; x=1701253799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9feGrtgxkTxJbOa4Vk9//3jntNv3ytgoDCgss4YnGjI=;
        b=VKlD7j4Re7x3tqxi5gIkYaSAWb5ySw/SImzpHTNtNgiY5sPl1GZFWDyx8Rs7at642w
         XAQ/wVby+EjOnEcn2q8wQdMvipBqUUhG+qNFLGsu91rOn+Xw+fr4Z+5p+Z/T8KelNAqW
         /d2qXZrRymqFp1S7T4xSLQiVB4PZdx6hgUkMHCUyxmk+Lz03hOP97GFPnLg3C66uEpSt
         vILpg7TkUHZzUdS4cuEET8Iq2nLXOMVRH29j0bg9PS79yEkFhGpG4+OemKEixpxIK+c2
         lGnNNVvk969jhy3wDTTB1ifllCvlsUfm4JagdZeNqitU4zFQ6LTQmy/PZySYs0BbmJwa
         e3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700648999; x=1701253799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9feGrtgxkTxJbOa4Vk9//3jntNv3ytgoDCgss4YnGjI=;
        b=qyn+jZabBqu+kr/LNKC9vz1NRHvzjBPKWGTIAdmy6DM0mS+DwQK/o1VVtPeo0BDIsx
         +q4/rBmA4eGRK075db+6GjMYF0ztwEfN1DQHrXvS1iBogDhb+EQIzAGvhpQ5S++QKU+D
         fiK/YlkgUbetiXEqWkP5Tklc6VwDeohh+jqMdzMS618ZsoML0lNoXgj8u2jR5UcMLqpX
         HdynOjcqKjyUSV4kuRPiP/F4E2RZ+vCjp7kp63dBMic73Ij2TCmhtII8BHk4FtLzjZ/S
         cCZVtiEHT0MI72EA2soHDAEX3ff8RRXSt3fR72Q55DjvaC2gwZFJYL0/M3vsV7Iqpdo4
         XLQg==
X-Gm-Message-State: AOJu0YzC11CGtQAFXX9+ENbfFXiT3flkUKUKDIXYNwwA77UdMFSVJ4/u
        nnMCZwP6lOM2Ndqu81mrhOp9IQ==
X-Google-Smtp-Source: AGHT+IFwH8apropXiRO6oy9qjpxN3mgJ1v/LqypvU7Rn8//ZDXTpyGL41zCRhAadaKue8OYvwfJUYg==
X-Received: by 2002:a5d:6d8f:0:b0:32f:92f3:dbbb with SMTP id l15-20020a5d6d8f000000b0032f92f3dbbbmr951901wrs.70.1700648998902;
        Wed, 22 Nov 2023 02:29:58 -0800 (PST)
Received: from localhost.localdomain (d54C3956F.access.telenet.be. [84.195.149.111])
        by smtp.gmail.com with ESMTPSA id f12-20020adff44c000000b003313e4dddecsm16652786wrp.108.2023.11.22.02.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 02:29:58 -0800 (PST)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Crt Mori <cmo@melexis.com>
Subject: [PATCH 2/2] dt-bindings: iio: temperature: add MLX90635 device bindings
Date:   Wed, 22 Nov 2023 11:27:21 +0100
Message-Id: <2e8b4a7d3ef4bc1c53bd0a849e4c31eaf2477f6b.1700648165.git.cmo@melexis.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1700648164.git.cmo@melexis.com>
References: <cover.1700648164.git.cmo@melexis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for MLX90635 Infra Red contactless temperature
sensor.

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 .../iio/temperature/melexis,mlx90635.yaml     | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/melexis,mlx90635.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90635.yaml b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90635.yaml
new file mode 100644
index 000000000000..96463121a806
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90635.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/temperature/melexis,mlx90635.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Melexis MLX90635 contactless Infra Red temperature sensor
+
+maintainers:
+  - Crt Mori <cmo@melexis.com>
+
+description: |
+  https://www.melexis.com/en/documents/documentation/datasheets/datasheet-mlx90635
+
+  There are various applications for the Infra Red contactless temperature
+  sensor and MLX90635 is most suitable for consumer applications where
+  measured object temperature is in range between -20 to 100 degrees
+  Celsius with relative error of measurement 2 degree Celsius in
+  object temperature range for industrial applications, while just 0.2
+  degree Celsius for human body measurement applications. Since it can
+  operate and measure ambient temperature in range of -20 to 85 degrees
+  Celsius it is suitable also for outdoor use.
+
+  Be aware that electronics surrounding the sensor can increase ambient
+  temperature. MLX90635 can be calibrated to reduce the housing effect via
+  already existing EEPROM parameters.
+
+  Since measured object emissivity effects Infra Red energy emitted,
+  emissivity should be set before requesting the object temperature.
+
+properties:
+  compatible:
+    const: melexis,mlx90635
+
+  reg:
+    maxItems: 1
+    description: Default is 0x3a, but can be reprogrammed.
+
+  vdd-supply:
+    description: provide VDD power to the sensor (check datasheet for voltage).
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        temp-sensor@3a {
+            compatible = "melexis,mlx90635";
+            reg = <0x3a>;
+            vdd-supply = <&ldo4_reg>;
+        };
+    };
+...
-- 
2.40.1

