Return-Path: <linux-kernel+bounces-61381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3E885119D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85CF3B261D6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4EB3987C;
	Mon, 12 Feb 2024 10:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BTWytZL9"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569E53984B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707735293; cv=none; b=bbPkHFBI+S+neCfnnIjUbfF/27SUF5Zvx/onCkkM5u2dDHGO6ZlFnyXEnOje855G4swDaohPtkR3X6IWxDQ79AR9cFUfrSbjapFhzvV4Gueg63XtZosUH8kJ4DeMFNyVnKlovuJhyRC5kx0ORGxopYF3RNtPVUd6GKVS9PKytas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707735293; c=relaxed/simple;
	bh=JkGNB6EACZs7G0wca90SjCDRR1MMVvxtGzQZVSSTfnA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IGgszcXGxRC59ovSQqfnSlflXw7ZH0e3ANCl63K7ZCVH3ZpGF7fLFaAlgpq13fTnz5TA9Go1aE4zSOOBe8+QJD5nBpUJef8DHyRIfmB0oSFmGzui33S2P0zkUQHrLJ3HMZlfnasAftTObNVxwYO+s+J5qEnEIuUKoCW9sTllpTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BTWytZL9; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5116bf4dcf4so3606075e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707735289; x=1708340089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ku8IgqKXgZ1aGnd9uYNvU88mrbVJaBGhSivSTqvjkG4=;
        b=BTWytZL9jm6F2+TS5DPFO/AbXTPbtMr2r5f1PKSYwA8QBJR3gK9lezWit4QJ3ATDIe
         4Z+Rzur0CP4VghfftkIUN06Gxk1YMoyg9+kdvxA9/5C1EW6GuRma9FrJKAvFhmdN49pJ
         4WdsV6zfqZhyX2zQck9zAmCS/ZBfYHEfRSs4QEvBL++iYKWvHtGg8RR1efdArgLFQpYH
         wn017ZnPMqsnPD+zkGplR90ptl8WgdXZIc3p8j3wxof3EScNlLXmtkAhun607O8SEGCE
         0Lok48hZepxFl8PNW5RUp57E50ajH/ho95UwKsfT+XVKMfMexck7kvTF+dF98Hfnm+qJ
         /UYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707735289; x=1708340089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ku8IgqKXgZ1aGnd9uYNvU88mrbVJaBGhSivSTqvjkG4=;
        b=FiB1BYIJz2LPzBboHt8+Zb6lUgfRNRI3J8g9J/ZlmvLMCEgNULtEjtOTwWXgPF9GNn
         9g1wjFe1b/iLlr+RLRl8/y79Kma6/FNtlQ1h/BjfuNkBHgRNH1XUtanNqvG9x3weGp1E
         vKQ9dGvwTQjQTyfU6axUeuqW8hLN2Ic2KbxiMK3Jfdzbt9r2QFwm6u1BZjgEfgCSwj2w
         Nm6zGjFNO1BlLciahPbgPMS9m17s8UHCbVkdaOFkFz4ZkXJ8OAhP+3EIEb/DJG6KMdq7
         JNFTnT7Tqu9hGj9scwQi4UtOWcMeFy6fwBXCrKAiI0AIgYyZimSA0DnZaTV2bcH7+BD0
         4W5w==
X-Forwarded-Encrypted: i=1; AJvYcCUiULfOvG58lEzCv4uGKigqI1cHB+GMYyiWBwjcpUk4cj91srxY0QaTswAZYAPQSsOQwrivqJtXKQLxV3m/5BUaxO4xbnMXMqPO9v4U
X-Gm-Message-State: AOJu0Yzjz1y2qSDxVeQI9Y3v29Uc6Zr/Ug60bhJqMsLtfTGyUmMkVCBw
	0j1EQKTpOto9NngTxDjrhkWpMd31XG3gu/kMtPCb+ZpoxeeQ/UdSwHi+O0GHhgw=
X-Google-Smtp-Source: AGHT+IHsBDotn/x5BD/p+sM1GZBMREIr2F7mHACW9xeTtzvtTArG/x3WnIz7chqZs8i/kxyttofBBQ==
X-Received: by 2002:ac2:48ae:0:b0:511:4e6a:12e7 with SMTP id u14-20020ac248ae000000b005114e6a12e7mr4069980lfg.58.1707735289337;
        Mon, 12 Feb 2024 02:54:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXUuuWtapF0T9cozNGQIW32rnMy0ZE0ChapQXoo6k9hEeUmQFrGZtzDoVmADFxRBSSv7TKPzCfJ+KWfhX3gUX/B1U59ToS1llc6o6EfieZ+6YU1SspBUAhquTrJARdDo0qlcbKX8dJdRAF6565A1DbA6QB8vjdQ0z+kbXgdpbgOlVoyDpcdzHcq3bsnCwIP9zf0JbCorKy+3QM5Bvur0hegGkHnZI5UYhD6BNrrSjvprPvI9Yz5XaETCR2+oCrs518A3ROWDqehNSZuNa9Kvodvut9mmnsG8RX6o7nkaLINYEMBfie2PIqWsBS1nBhvyFHb8OJh2u32cOYUuB9gk+rhopDWrPNPxmNgLLRA+VxCDaJ6D9tMYFvmgmSSSZdCS5r+a3giOYgrPCtcFfa0nV14VJMObggr
Received: from krzk-bin.. ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b00410794ddfc6sm8349380wms.35.2024.02.12.02.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 02:54:48 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next] dt-bindings: net: qca,ar9331: convert to DT schema
Date: Mon, 12 Feb 2024 11:54:45 +0100
Message-Id: <20240212105445.45341-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Qualcomm Atheros AR9331 built-in switch bindings to DT
schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

DSA switch bindings still bring me headache...
---
 .../devicetree/bindings/net/dsa/ar9331.txt    | 147 ----------------
 .../bindings/net/dsa/qca,ar9331.yaml          | 161 ++++++++++++++++++
 2 files changed, 161 insertions(+), 147 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/dsa/ar9331.txt
 create mode 100644 Documentation/devicetree/bindings/net/dsa/qca,ar9331.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/ar9331.txt b/Documentation/devicetree/bindings/net/dsa/ar9331.txt
deleted file mode 100644
index f824fdae0da2..000000000000
--- a/Documentation/devicetree/bindings/net/dsa/ar9331.txt
+++ /dev/null
@@ -1,147 +0,0 @@
-Atheros AR9331 built-in switch
-=============================
-
-It is a switch built-in to Atheros AR9331 WiSoC and addressable over internal
-MDIO bus. All PHYs are built-in as well.
-
-Required properties:
-
- - compatible: should be: "qca,ar9331-switch"
- - reg: Address on the MII bus for the switch.
- - resets : Must contain an entry for each entry in reset-names.
- - reset-names : Must include the following entries: "switch"
- - interrupt-parent: Phandle to the parent interrupt controller
- - interrupts: IRQ line for the switch
- - interrupt-controller: Indicates the switch is itself an interrupt
-   controller. This is used for the PHY interrupts.
- - #interrupt-cells: must be 1
- - mdio: Container of PHY and devices on the switches MDIO bus.
-
-See Documentation/devicetree/bindings/net/dsa/dsa.txt for a list of additional
-required and optional properties.
-Examples:
-
-eth0: ethernet@19000000 {
-	compatible = "qca,ar9330-eth";
-	reg = <0x19000000 0x200>;
-	interrupts = <4>;
-
-	resets = <&rst 9>, <&rst 22>;
-	reset-names = "mac", "mdio";
-	clocks = <&pll ATH79_CLK_AHB>, <&pll ATH79_CLK_AHB>;
-	clock-names = "eth", "mdio";
-
-	phy-mode = "mii";
-	phy-handle = <&phy_port4>;
-};
-
-eth1: ethernet@1a000000 {
-	compatible = "qca,ar9330-eth";
-	reg = <0x1a000000 0x200>;
-	interrupts = <5>;
-	resets = <&rst 13>, <&rst 23>;
-	reset-names = "mac", "mdio";
-	clocks = <&pll ATH79_CLK_AHB>, <&pll ATH79_CLK_AHB>;
-	clock-names = "eth", "mdio";
-
-	phy-mode = "gmii";
-
-	fixed-link {
-		speed = <1000>;
-		full-duplex;
-	};
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		switch10: switch@10 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			compatible = "qca,ar9331-switch";
-			reg = <0x10>;
-			resets = <&rst 8>;
-			reset-names = "switch";
-
-			interrupt-parent = <&miscintc>;
-			interrupts = <12>;
-
-			interrupt-controller;
-			#interrupt-cells = <1>;
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				switch_port0: port@0 {
-					reg = <0x0>;
-					ethernet = <&eth1>;
-
-					phy-mode = "gmii";
-
-					fixed-link {
-						speed = <1000>;
-						full-duplex;
-					};
-				};
-
-				switch_port1: port@1 {
-					reg = <0x1>;
-					phy-handle = <&phy_port0>;
-					phy-mode = "internal";
-				};
-
-				switch_port2: port@2 {
-					reg = <0x2>;
-					phy-handle = <&phy_port1>;
-					phy-mode = "internal";
-				};
-
-				switch_port3: port@3 {
-					reg = <0x3>;
-					phy-handle = <&phy_port2>;
-					phy-mode = "internal";
-				};
-
-				switch_port4: port@4 {
-					reg = <0x4>;
-					phy-handle = <&phy_port3>;
-					phy-mode = "internal";
-				};
-			};
-
-			mdio {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				interrupt-parent = <&switch10>;
-
-				phy_port0: phy@0 {
-					reg = <0x0>;
-					interrupts = <0>;
-				};
-
-				phy_port1: phy@1 {
-					reg = <0x1>;
-					interrupts = <0>;
-				};
-
-				phy_port2: phy@2 {
-					reg = <0x2>;
-					interrupts = <0>;
-				};
-
-				phy_port3: phy@3 {
-					reg = <0x3>;
-					interrupts = <0>;
-				};
-
-				phy_port4: phy@4 {
-					reg = <0x4>;
-					interrupts = <0>;
-				};
-			};
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/net/dsa/qca,ar9331.yaml b/Documentation/devicetree/bindings/net/dsa/qca,ar9331.yaml
new file mode 100644
index 000000000000..5c4f789a75fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/qca,ar9331.yaml
@@ -0,0 +1,161 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/qca,ar9331.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Atheros AR9331 built-in switch
+
+maintainers:
+  - Oleksij Rempel <o.rempel@pengutronix.de>
+
+description:
+  Qualcomm Atheros AR9331 is a switch built-in to Atheros AR9331 WiSoC and
+  addressable over internal MDIO bus. All PHYs are built-in as well.
+
+properties:
+  compatible:
+    const: qca,ar9331-switch
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 1
+
+  mdio:
+    $ref: /schemas/net/mdio.yaml#
+    unevaluatedProperties: false
+    properties:
+      interrupt-parent: true
+
+    patternProperties:
+      '@[0-9a-f]+$':
+        type: object
+        unevaluatedProperties: false
+
+        properties:
+          reg: true
+          interrupts:
+            maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: switch
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - '#interrupt-cells'
+  - mdio
+  - ports
+  - resets
+  - reset-names
+
+allOf:
+  - $ref: dsa.yaml#/$defs/ethernet-ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        switch10: switch@10 {
+            compatible = "qca,ar9331-switch";
+            reg = <0x10>;
+
+            interrupt-parent = <&miscintc>;
+            interrupts = <12>;
+            interrupt-controller;
+            #interrupt-cells = <1>;
+
+            resets = <&rst 8>;
+            reset-names = "switch";
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0x0>;
+                    ethernet = <&eth1>;
+
+                    phy-mode = "gmii";
+
+                    fixed-link {
+                        speed = <1000>;
+                        full-duplex;
+                    };
+                };
+
+                port@1 {
+                    reg = <0x1>;
+                    phy-handle = <&phy_port0>;
+                    phy-mode = "internal";
+                };
+
+                port@2 {
+                    reg = <0x2>;
+                    phy-handle = <&phy_port1>;
+                    phy-mode = "internal";
+                };
+
+                port@3 {
+                    reg = <0x3>;
+                    phy-handle = <&phy_port2>;
+                    phy-mode = "internal";
+                };
+
+                port@4 {
+                    reg = <0x4>;
+                    phy-handle = <&phy_port3>;
+                    phy-mode = "internal";
+                };
+            };
+
+            mdio {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                interrupt-parent = <&switch10>;
+
+                phy_port0: ethernet-phy@0 {
+                    reg = <0x0>;
+                    interrupts = <0>;
+                };
+
+                phy_port1: ethernet-phy@1 {
+                    reg = <0x1>;
+                    interrupts = <0>;
+                };
+
+                phy_port2: ethernet-phy@2 {
+                    reg = <0x2>;
+                    interrupts = <0>;
+                };
+
+                phy_port3: ethernet-phy@3 {
+                    reg = <0x3>;
+                    interrupts = <0>;
+                };
+
+                phy_port4: ethernet-phy@4 {
+                    reg = <0x4>;
+                    interrupts = <0>;
+                };
+            };
+        };
+    };
-- 
2.34.1


