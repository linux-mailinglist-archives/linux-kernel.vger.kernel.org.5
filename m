Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975737E45E2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbjKGQV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235623AbjKGQUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:20:53 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E964781
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 07:55:48 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c6b30aca06so76972841fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 07:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699372547; x=1699977347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyIzL/Q3yxnzrvtrJL0lEmia/DHhD7H2KwmfawN1GcI=;
        b=CRB/Gxgi1jx3QeFec+QGCJrKJ5W3VVRHESBEH1/TsMgYQCereLPXxO2OEV/r/M5RbJ
         1UncuQ1GqZNfQTwsv5FGJicmlE2mZbIHoi2IxcQ54qjy4Offlo5G4ZlQYGkIQ1KFjTxg
         CBmMmLjDWWRU/y81zESdgwQagAwz5l3il7Zi+pFGelOZORELAggaXpEqw3v+ucl3wsHB
         t29NH1ClckQRbkvZur5zKrjFvwwBsnLTrKS9aAROreIUuKhDxJqDTAGviazIRbIVkLWh
         o0+0uz0cnC//51sN4GcaRKrIACs9D2zJGMPcLkBDB+8guHcMhw7yqDOTzL0yu16yD3My
         M/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699372547; x=1699977347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hyIzL/Q3yxnzrvtrJL0lEmia/DHhD7H2KwmfawN1GcI=;
        b=vQDUIXmpkpOCIFp7qUuOoncPTR16MJIliaktFLzt/O1DaboxAi7dXmdfSOs7I0NUZ/
         ZRyEkj9SeJAS3Fc5lT2WXAWrCx9y+3CJuZKZgo5/lQXU3Pa6rDb5m4O0zUfycxiPlPHo
         RuH3FhubC02UeDCI5rNSvUNejh8TujuLBFIXzKdN2Uu7KaMyyF/ZqKaxJPmvMlE2aoec
         qC8+BFiGB4Fvc8PkaHUy33bPp606w6g0Vh2uk8O6f/qbVVAULX8yaYQVn9a0Y5ROHSwo
         uIRbWeSp57STz+b6hDCbwu3qh20DpSnH0UVBLbaXI2PilPiGGmSVx17IO/5u74dTt+uF
         FLrg==
X-Gm-Message-State: AOJu0Ywf4mtSzVU7QZj7PXDEy3i4ncjy+9hYK/DjvKe1XsuVTh/RNhK1
        kvM75nCs07IM9aaXveKp/5r/1g==
X-Google-Smtp-Source: AGHT+IF2CtEdSKnhv/tXugEB9xIrKqP4UzseDtGMiIJn+4Yx97r9/P6lMwv01Zt98YVJ/AbBVnN2kQ==
X-Received: by 2002:a05:651c:333:b0:2c5:1542:57e4 with SMTP id b19-20020a05651c033300b002c5154257e4mr24082642ljp.31.1699372546743;
        Tue, 07 Nov 2023 07:55:46 -0800 (PST)
Received: from arnold.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id f6-20020a05600c4e8600b003fefb94ccc9sm16579085wmq.11.2023.11.07.07.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 07:55:45 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org
Cc:     ricardo@pardini.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 1/6] dt-bindings: crypto: add support for rockchip,crypto-rk3588
Date:   Tue,  7 Nov 2023 15:55:27 +0000
Message-Id: <20231107155532.3747113-2-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231107155532.3747113-1-clabbe@baylibre.com>
References: <20231107155532.3747113-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding documentation for the Rockchip cryptographic
offloader V2.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../crypto/rockchip,rk3588-crypto.yaml        | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/rockchip,rk3588-crypto.yaml

diff --git a/Documentation/devicetree/bindings/crypto/rockchip,rk3588-crypto.yaml b/Documentation/devicetree/bindings/crypto/rockchip,rk3588-crypto.yaml
new file mode 100644
index 000000000000..07024cf4fb0e
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/rockchip,rk3588-crypto.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/rockchip,rk3588-crypto.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip cryptographic offloader V2
+
+maintainers:
+  - Corentin Labbe <clabbe@baylibre.com>
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3568-crypto
+      - rockchip,rk3588-crypto
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 3
+
+  clock-names:
+    items:
+      - const: core
+      - const: a
+      - const: h
+
+  resets:
+    minItems: 1
+
+  reset-names:
+    items:
+      - const: core
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/rockchip,rk3588-cru.h>
+    #include <dt-bindings/reset/rockchip,rk3588-cru.h>
+    crypto@fe370000 {
+      compatible = "rockchip,rk3588-crypto";
+      reg = <0xfe370000 0x4000>;
+      interrupts = <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH 0>;
+      clocks = <&scmi_clk SCMI_CRYPTO_CORE>, <&scmi_clk SCMI_ACLK_SECURE_NS>,
+               <&scmi_clk SCMI_HCLK_SECURE_NS>;
+      clock-names = "core", "a", "h";
+      resets = <&scmi_reset SRST_CRYPTO_CORE>;
+      reset-names = "core";
+    };
-- 
2.41.0

