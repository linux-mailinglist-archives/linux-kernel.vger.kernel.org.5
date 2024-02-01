Return-Path: <linux-kernel+bounces-48380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF28845B3C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D4301C21E79
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F64A15F33C;
	Thu,  1 Feb 2024 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1n3TxF3"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFE615DBDD;
	Thu,  1 Feb 2024 15:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800709; cv=none; b=boRSDvd1OCU4EnOTzYAibrOSSWrW528Ld9BKB1DlJosGoyKeP66kGhfnFEbLIjCawU+r4phP9otGZKDWxTZIQF9lzLnHu8a8koe774LkXJ778gjyJCIN2mAo6UXDyfjdZbCtyirm9v3ygWx8pa1QztDN+q6NbJZJia3vuUP4WGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800709; c=relaxed/simple;
	bh=ryQW+grlt4EQVnHr4h5ru2inb8EsxZt0Umc7HsHCdjI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pV1+IMtQ1yAaE9KtXGYlX6Z2gvarH8ZPOZNtYWvMj9AWd0SepeEGNIMOTbCFzhVor7b7uYQNjAZNBAgId1clwFd94j7EiyVL4L2CH2UAHil335gcQu2PQLaPeGU6t70ylqsmQeMiF3fklq9RaXCRcAUV27Z9PZNudPAc3ViDLMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1n3TxF3; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cf338e1438so10553061fa.0;
        Thu, 01 Feb 2024 07:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706800704; x=1707405504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9z7Sog4aXnCpZ8GbfHY+8/HFbwv7GHMBypWwI4uSCTc=;
        b=l1n3TxF32X1x52NOaG2hr1uUOtzTTvtnohn6p3U0FXgpoKXYOMowlFJvjWbnF3ZLZM
         yKY9JeuJTC0mDkKWG5vt2rOFboEEtwoqWpNBlvfOuK1DcR8/BSztW2DQOR4byBOljzKy
         l/TZVDFelL8K/A0cTr42R4M2sJ97qt3joDfQOql7jcj6gRUAzK4MR14wcS0Sku2IvJLD
         JOf01Uv06yKXucfA6gtjQxcVJf/r0E72y2XNZ7LHgE68qxlGaN/gyc+d45IxgThQrAEY
         2F52gDOTgpQ26GHHIFutB38Tk9ZsQKubGGricrd/JRwjigOccbT8u3AB2YBBq5jbuhBB
         WHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706800704; x=1707405504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9z7Sog4aXnCpZ8GbfHY+8/HFbwv7GHMBypWwI4uSCTc=;
        b=Xjp7Hvmjns+Z5fUc+qkB/JyZg7l4tQgfl5iWe2v2J7sF8AwTALcCWIKVZmjkoZ0l3y
         CVeLXN2GVOwnMKQ6yBdJDmGoqlB1Umok3vCw8RGHy22VyW0Y69eFbblPaFrwE25ecRMS
         SFPnM9s+ZbvTnwh1GQGelyUYhXd3Hu13ik6NIYi2QI5W4UCeOM0TzZ8/rjYOTt5nAxJn
         9oBomEkwCLbwg+nbCjqgp4Xiji3txl1Mhop1Yecterbky6fbpGG+wWHKp19y3ozPROD/
         noikY4uz2gfHdbDEwb76b61XVv3u9clDzcW2tIH9A3mXhIDTb8am+BYd1YfKsQQjceBf
         TxIQ==
X-Gm-Message-State: AOJu0Yy5DhC4rFLZK6zuFmex8Sk1Z8ZjFkDrFlcE75LPNJlbyXPSSdBp
	vnibvg/hXHmaRNF1pI8ZQK9v+zSIlobC5FP6dRpTHQPiuRhaOoTI
X-Google-Smtp-Source: AGHT+IF7KWtjP+sk2yU0LCsksDtK8zUGOU0ootfQ8bPlW33/Gfy6JNQRTJ1PFm4wpqD8rH3+q7JCuA==
X-Received: by 2002:a2e:b546:0:b0:2cd:9e2f:c631 with SMTP id a6-20020a2eb546000000b002cd9e2fc631mr1525634ljn.10.1706800703617;
        Thu, 01 Feb 2024 07:18:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX1B7ObFodeCniL3CVLn/wKXpHrNKdTa5GghEQekzO26B4PqHOSC4WkeK13gsDS9u1siqR+8vPN0a3XqQqw9dFxVBwOjXfF3W40Z5uWekERTTJHtCDgzpKK6h5bumxYghknRDGJ78pSbQ/xOYiOogdOl0xJZAzn+Mob7QSZ8Oc4ZuPfH+KpLdavt3In396o+6rEglP0hhjYAOvZe/jkA9EQ7f4EChsGWqDIXmP1jssUa3gg3tOQrtP9kg1ECfVwDPEXNlynD0bel3J9Fv/vnQkOCYTMyHZ6LJ3181dcCB8AgIV400MnRX+QT4fNF+eCOA2YrzNqbYNcgJlnLyxb/vaUAQUJooKBzjMVKmhnTATsR44yTq0+r6bFvkkHpgAw2xQ+T/iQsIOc8Mcf6ZpItX/DJl3q3FiCVIZzq0svH3B2ntNNRHdYtx788Cilr9IG9gXPr6fQmHDjZQ16eBQ+PP5hIy9/h0wXGjmEvrAhGWrcUWLZnmiMzE2QPZsJXsBhc74KNn6Jm8dyiCx5lVovIdMWj2MzwKT2Hdv+mwFkq6WL9xJ2N/9Qm5jeGaXrVrpGcSrfbq6o5DASpjdQMJiKsSSNoIrDEFxWJJ3/y9vQtoqd1LBxGTkBBqth
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id z9-20020a2e3509000000b002cdf37ee19dsm2437978ljz.7.2024.02.01.07.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:18:23 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Rowand <frowand.list@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [net-next PATCH v5 6/9] dt-bindings: net: Document Qcom QCA807x PHY package
Date: Thu,  1 Feb 2024 16:17:32 +0100
Message-ID: <20240201151747.7524-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201151747.7524-1-ansuelsmth@gmail.com>
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Qcom QCA807x PHY package.

Qualcomm QCA807X Ethernet PHY is PHY package of 2 or 5
IEEE 802.3 clause 22 compliant 10BASE-Te, 100BASE-TX and
1000BASE-T PHY-s.

Document the required property to make the PHY package correctly
configure and work.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/net/qcom,qca807x.yaml | 142 ++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/qcom,qca807x.yaml

diff --git a/Documentation/devicetree/bindings/net/qcom,qca807x.yaml b/Documentation/devicetree/bindings/net/qcom,qca807x.yaml
new file mode 100644
index 000000000000..1c3692897b02
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/qcom,qca807x.yaml
@@ -0,0 +1,142 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/qcom,qca807x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QCA807X Ethernet PHY
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+  - Robert Marko <robert.marko@sartura.hr>
+
+description: |
+  Qualcomm QCA807X Ethernet PHY is PHY package of 2 or 5
+  IEEE 802.3 clause 22 compliant 10BASE-Te, 100BASE-TX and
+  1000BASE-T PHY-s.
+
+  They feature 2 SerDes, one for PSGMII or QSGMII connection with
+  MAC, while second one is SGMII for connection to MAC or fiber.
+
+  Both models have a combo port that supports 1000BASE-X and
+  100BASE-FX fiber.
+
+  Each PHY inside of QCA807x series has 4 digitally controlled
+  output only pins that natively drive LED-s for up to 2 attached
+  LEDs. Some vendor also use these 4 output for GPIO usage without
+  attaching LEDs.
+
+  Note that output pins can be set to drive LEDs OR GPIO, mixed
+  definition are not accepted.
+
+  PHY package can be configured in 3 mode following this table:
+
+                First Serdes mode       Second Serdes mode
+  Option 1      PSGMII for copper       Disabled
+                ports 0-4
+  Option 2      PSGMII for copper       1000BASE-X / 100BASE-FX
+                ports 0-4
+  Option 3      QSGMII for copper       SGMII for
+                ports 0-3               copper port 4
+
+$ref: ethernet-phy-package.yaml#
+
+properties:
+  compatible:
+    const: qcom,qca807x-package
+
+  qcom,package-mode:
+    enum:
+      - qsgmii
+      - psgmii
+
+  qcom,tx-driver-strength:
+    description: set the TX Amplifier value in mv.
+      If not defined, 600mw is set by default.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [140, 160, 180, 200, 220,
+           240, 260, 280, 300, 320,
+           400, 500, 600]
+
+patternProperties:
+  ^ethernet-phy(@[a-f0-9]+)?$:
+    $ref: ethernet-phy.yaml#
+
+    properties:
+      gpio-controller:
+        description: set the output lines as GPIO instead of LEDs
+        type: boolean
+
+      '#gpio-cells':
+        description: number of GPIO cells for the PHY
+        const: 2
+
+    dependencies:
+      gpio-controller: ['#gpio-cells']
+
+    if:
+      required:
+        - gpio-controller
+    then:
+      properties:
+        leds: false
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy-package@0 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            compatible = "qcom,qca807x-package";
+            reg = <0>;
+
+            qcom,package-mode = "qsgmii";
+
+            ethernet-phy@0 {
+                reg = <0>;
+
+                leds {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    led@0 {
+                        reg = <0>;
+                        color = <LED_COLOR_ID_GREEN>;
+                        function = LED_FUNCTION_LAN;
+                        default-state = "keep";
+                    };
+                };
+            };
+
+            ethernet-phy@1 {
+                reg = <1>;
+            };
+
+            ethernet-phy@2 {
+                reg = <2>;
+
+                gpio-controller;
+                #gpio-cells = <2>;
+            };
+
+            ethernet-phy@3 {
+                reg = <3>;
+            };
+
+            ethernet-phy@4 {
+                reg = <4>;
+            };
+        };
+    };
-- 
2.43.0


