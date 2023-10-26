Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D897D808A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 12:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbjJZKTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 06:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjJZKTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 06:19:38 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2493FDC;
        Thu, 26 Oct 2023 03:19:36 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9a6190af24aso119051766b.0;
        Thu, 26 Oct 2023 03:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698315574; x=1698920374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R6xRovC9oM8uLuvwYTTHSjPfu/zUQK1EzagTxS/ZS6I=;
        b=jqdC2gdQJ1hQzKmF7j1iUolY8F7BIEbVqFSo/M8VO//FAk15m0e9yKcer7rMKIpA4J
         aox8XnW25dzP0h7jvRpbIwSbLGRHB93iY5lJHuuKZu0qLDOmFHgcOYevsfrIY5BLADmN
         APJyAdTN6EYKvDwFLO0YciDnn/FcBLJN8c7jWDQjHsGu4F2YKl+jpF8WsbwTgGt7m0+I
         BIPwGd/boaU4TVAWSStJdAsUX4ZLfsa1AuzHpNvKulBRwr/iqKdFCg4EMRck8358A22f
         Ju/Df4pqvm1hOrQuUAEtqIUqX60OXZJvCCGpCxLv4QPei6vCWLrr9SNZIjhNJJfGtvxp
         9B5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698315574; x=1698920374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R6xRovC9oM8uLuvwYTTHSjPfu/zUQK1EzagTxS/ZS6I=;
        b=jZBTuG2jdMP5yXGNSJkzdJf1iZvX7oCMPQkEI3qGRx/zChuiFXriy1kD7mnhiggUP4
         rK3TJetAmxyLyQxV6w1pf8/MZf6IG9tEvfeLnHPow2is8t93sijS8Rn0/P5WqZFPoJB9
         Um5+kl/ZE/OVRqZkfZQPAAu08ZpGxT328hA6GxG9GlcvxgYsePtXj4/ZmKV7hjI5xPUu
         2v99ujkDNOys2p3pkQXtOV+keuIohwO5ThDd9O9B5gEkGaJ75IVyjungIoGzz/YPlqiE
         TskSAbV10q5lA42g3A6PaLyWLLu30a7sHCM0gNuaCESMviOR8Suti4tQFcEC92KdE6Ck
         vdIA==
X-Gm-Message-State: AOJu0YxHV1BTGfdgPzkQBbTvwvt1p0UAxgahma2a8A24j7fUKI+ykpy7
        I6Cp8OZmdyCM2oM9fXDS0EY=
X-Google-Smtp-Source: AGHT+IFONz4Km/NGUBE/juLsEkByLkDuNJBDP7znncsLKTroN2coU2vhl00r8C/0cgDi630dR+GuEg==
X-Received: by 2002:a17:907:608b:b0:9b2:9e44:222e with SMTP id ht11-20020a170907608b00b009b29e44222emr17653637ejc.19.1698315574319;
        Thu, 26 Oct 2023 03:19:34 -0700 (PDT)
Received: from fedora.. (cpezg-94-253-130-190-cbl.xnet.hr. [94.253.130.190])
        by smtp.googlemail.com with ESMTPSA id jy20-20020a170907763400b009b97d9ae329sm11457552ejc.198.2023.10.26.03.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 03:19:33 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_tdas@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH] dt-bindings: clock: qcom,gcc-ipq6018: split to separate schema
Date:   Thu, 26 Oct 2023 12:18:37 +0200
Message-ID: <20231026101931.695497-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm IPQ6018 GCC clock controller has clock inputs, thus existing
gcc-other.yaml was not describing it fully so move it to a separate schema.

Fully document the allowed and required XO and sleep clock inputs, as well
as update the provided example.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 .../bindings/clock/qcom,gcc-ipq6018.yaml      | 57 +++++++++++++++++++
 .../bindings/clock/qcom,gcc-other.yaml        |  3 -
 2 files changed, 57 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-ipq6018.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq6018.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq6018.yaml
new file mode 100644
index 0000000000000..af5d883cfdc86
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq6018.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,gcc-ipq6018.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Global Clock & Reset Controller on IPQ6018
+
+maintainers:
+  - Stephen Boyd <sboyd@kernel.org>
+  - Taniya Das <quic_tdas@quicinc.com>
+  - Robert Marko <robimarko@gmail.com>
+
+description: |
+  Qualcomm global clock control module provides the clocks, resets and power
+  domains on IPQ6018.
+
+  See also::
+    include/dt-bindings/clock/qcom,gcc-ipq6018.h
+    include/dt-bindings/reset/qcom,gcc-ipq6018.h
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+properties:
+  compatible:
+    const: qcom,gcc-ipq6018
+
+  clocks:
+    items:
+      - description: board XO clock
+      - description: sleep clock
+
+  clock-names:
+    items:
+      - const: xo
+      - const: sleep_clk
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    clock-controller@1800000 {
+      compatible = "qcom,gcc-ipq6018";
+      reg = <0x01800000 0x80000>;
+      clocks = <&xo>, <&sleep_clk>;
+      clock-names = "xo", "sleep_clk";
+      #clock-cells = <1>;
+      #power-domain-cells = <1>;
+      #reset-cells = <1>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
index 559fc21435c8d..7d05f0f63cef2 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
@@ -15,8 +15,6 @@ description: |
   domains.
 
   See also::
-    include/dt-bindings/clock/qcom,gcc-ipq6018.h
-    include/dt-bindings/reset/qcom,gcc-ipq6018.h
     include/dt-bindings/clock/qcom,gcc-msm8953.h
     include/dt-bindings/clock/qcom,gcc-mdm9607.h
 
@@ -26,7 +24,6 @@ allOf:
 properties:
   compatible:
     enum:
-      - qcom,gcc-ipq6018
       - qcom,gcc-mdm9607
 
 required:
-- 
2.41.0

