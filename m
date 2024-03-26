Return-Path: <linux-kernel+bounces-118658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8FA88BDD6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C670B24F40
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA25A12BE9A;
	Tue, 26 Mar 2024 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJi8j1CC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EC26F079;
	Tue, 26 Mar 2024 09:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444842; cv=none; b=T5YoM8UVU8U0Ww5BxHugjggVIuojgGF6zvVZ/MQUcnPEHgR2NhzoOMG8JqCjKStQ78NH8eP51dbh9ppKB5EEoJm4+zhPwEVGKIR7eo2WVa9inkcnzjcwLZSkoLIWen3n4uEYfB6p2O9pCzb1KFIHuqYH8/kw0oDvP1xGVDgB6+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444842; c=relaxed/simple;
	bh=z8ZWhs/5zvx3G6R8b4jbvSH/4gHgw6KY8ml450z0UoI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CMlmAcMqnwPTkNVi6X0tdTFKhi3QGYi5b5AZCoCYYElOnv1lY7Zme1ewZDnvVDLetCJRpRSuXQU/P0YCDunVfWxMBv7xdEdCqi/ChFbUj3vELq6LVdFuHVGERD8G1X7KjcOaS2YmrkcMS6F8BFmKNhW4TjFUmpdeaBoqmUOYk+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJi8j1CC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 249F9C4AF73;
	Tue, 26 Mar 2024 09:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711444842;
	bh=z8ZWhs/5zvx3G6R8b4jbvSH/4gHgw6KY8ml450z0UoI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gJi8j1CCVHoSsuI2+FweiNX9ydr+T5E0NwFXCk4LsdTuwEyeDKlqW9y8HvSOxvEuk
	 nSt/v8oUw+un7CnXvf/trnLzit0y6wkPmMhk/pT1Ksg1FtJNO+98oJhRxEdAKfhWkV
	 927NGqxBP4XE1vH12Z0DL6nvB+zm0XfcE4nI4OlVVigccPnFp98biwo0iumA2x4hKl
	 CYuvGXTB+qFfiH5fNQ2Do5Y2L4RBz96pGXkDdsTq4GqGg79/y1dtWlPGFY0NQLB4Ia
	 8t6IONFPbjP0aDS7KKSjC5audAQvbzFMHDd9XT9wMuOX66C80zAGAixx0d7klJq9ma
	 OHWi4gBQpxPNQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCD3C54E58;
	Tue, 26 Mar 2024 09:20:42 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Tue, 26 Mar 2024 12:18:49 +0300
Subject: [PATCH v9 22/38] dt-bindings: input: Add Cirrus EP93xx keypad
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-ep93xx-v9-22-156e2ae5dfc8@maquefel.me>
References: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
In-Reply-To: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711444837; l=3131;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=BmV75DVRygMtC4JmBqsWTX4r3uOQf/4IH1RLZhibCAg=;
 b=aFVKrEHsPQPgsVdie9w6RPYDqHY6i2WrBOlhHxBad4yfDnOuZZ3uO+z6TEimokKaqs1HLUdow8Kw
 ixGMbC4bAuU1Rxu913yhr609WkmPG/B81AMz9AeuYR8iE2hBzYpR
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add YAML bindings for ep93xx SoC keypad.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 .../bindings/input/cirrus,ep9307-keypad.yaml       | 87 ++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/cirrus,ep9307-keypad.yaml b/Documentation/devicetree/bindings/input/cirrus,ep9307-keypad.yaml
new file mode 100644
index 000000000000..a0d2460c55ab
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/cirrus,ep9307-keypad.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/cirrus,ep9307-keypad.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus ep93xx keypad
+
+maintainers:
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+
+allOf:
+  - $ref: /schemas/input/matrix-keymap.yaml#
+
+description:
+  The KPP is designed to interface with a keypad matrix with 2-point contact
+  or 3-point contact keys. The KPP is designed to simplify the software task
+  of scanning a keypad matrix. The KPP is capable of detecting, debouncing,
+  and decoding one or multiple keys pressed simultaneously on a keypad.
+
+properties:
+  compatible:
+    oneOf:
+      - const: cirrus,ep9307-keypad
+      - items:
+          - enum:
+              - cirrus,ep9312-keypad
+              - cirrus,ep9315-keypad
+          - const: cirrus,ep9307-keypad
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
+  debounce-delay-ms:
+    description: |
+          Time in microseconds that key must be pressed or
+          released for state change interrupt to trigger.
+
+  cirrus,prescale:
+    description: row/column counter pre-scaler load value
+    $ref: /schemas/types.yaml#/definitions/uint16
+    maximum: 1023
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - linux,keymap
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/input/input.h>
+    #include <dt-bindings/clock/cirrus,ep9301-syscon.h>
+    keypad@800f0000 {
+        compatible = "cirrus,ep9307-keypad";
+        reg = <0x800f0000 0x0c>;
+        interrupt-parent = <&vic0>;
+        interrupts = <29>;
+        clocks = <&eclk EP93XX_CLK_KEYPAD>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&keypad_default_pins>;
+        linux,keymap = <KEY_UP>,
+                       <KEY_DOWN>,
+                       <KEY_VOLUMEDOWN>,
+                       <KEY_HOME>,
+                       <KEY_RIGHT>,
+                       <KEY_LEFT>,
+                       <KEY_ENTER>,
+                       <KEY_VOLUMEUP>,
+                       <KEY_F6>,
+                       <KEY_F8>,
+                       <KEY_F9>,
+                       <KEY_F10>,
+                       <KEY_F1>,
+                       <KEY_F2>,
+                       <KEY_F3>,
+                       <KEY_POWER>;
+    };

-- 
2.41.0



