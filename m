Return-Path: <linux-kernel+bounces-36500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3930683A1CA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E043728934D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD65C13AD4;
	Wed, 24 Jan 2024 06:07:27 +0000 (UTC)
Received: from TWMBX02.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD7AF9C2;
	Wed, 24 Jan 2024 06:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706076447; cv=none; b=iN4pC8TV10LHgHp7zWmf4m4nPzQ/ej0Jb3iZ8AoRexY/dm78LWj5wU8HD6FkvZWuf5OvsEhBa1IrXj8A/yUaMBqv2i31SSmIuzNoCJF9NEDwzavPyY+Q7/mqENhM6zUQrN4S1zT87Sai+cO6zlO0PEwoCucntRENvWvF1C8Ajvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706076447; c=relaxed/simple;
	bh=0yhz4sgrkGLrZFFp1Dc8nacN1MARb64w5yjArFzHj3Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rb4YgXPNxgcerLXOiWHJcu3hHAeLvt0GjiJ96QI7xk61OyDIvPDBhaXEtDIvkEZCYczcDdBMdbHS+sb1wjibdwbnXq+TJotA3DrjuPR7Bz8Nzr/qGfZfrx10N97j0eqEBbOYoOEsmUCUsP4nW01EFUShL2pZCgUpKVMyZUVGENE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX02.aspeed.com (192.168.0.25) by TWMBX02.aspeed.com
 (192.168.0.25) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 24 Jan
 2024 14:07:07 +0800
Received: from twmbx02.aspeed.com (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 24 Jan 2024 14:07:07 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <corbet@lwn.net>,
	<u.kleine-koenig@pengutronix.de>, <p.zabel@pengutronix.de>,
	<billy_tsai@aspeedtech.com>, <naresh.solanki@9elements.com>,
	<linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>, <BMC-SW@aspeedtech.com>, <patrick@stwcx.xyz>
Subject: [PATCH v13 2/3] dt-bindings: hwmon: Support Aspeed g6 PWM TACH Control
Date: Wed, 24 Jan 2024 14:07:04 +0800
Message-ID: <20240124060705.1342461-3-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240124060705.1342461-1-billy_tsai@aspeedtech.com>
References: <20240124060705.1342461-1-billy_tsai@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: Fail (TWMBX02.aspeed.com: domain of billy_tsai@aspeedtech.com
 does not designate 192.168.10.10 as permitted sender)
 receiver=TWMBX02.aspeed.com; client-ip=192.168.10.10;
 helo=twmbx02.aspeed.com;

Document the compatible for aspeed,ast2600-pwm-tach device, which can
support up to 16 PWM outputs and 16 fan tach input.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 .../bindings/hwmon/aspeed,g6-pwm-tach.yaml    | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
new file mode 100644
index 000000000000..7d2b020ec693
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2023 Aspeed, Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/aspeed,g6-pwm-tach.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED G6 PWM and Fan Tach controller
+
+maintainers:
+  - Billy Tsai <billy_tsai@aspeedtech.com>
+
+description: |
+  The ASPEED PWM controller can support up to 16 PWM outputs.
+  The ASPEED Fan Tacho controller can support up to 16 fan tach input.
+  They are independent hardware blocks, which are different from the
+  previous version of the ASPEED chip.
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2600-pwm-tach
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+patternProperties:
+  "^fan-[0-9]+$":
+    $ref: fan-common.yaml#
+    unevaluatedProperties: false
+    required:
+      - tach-ch
+
+required:
+  - reg
+  - clocks
+  - resets
+  - "#pwm-cells"
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/aspeed-clock.h>
+    pwm_tach: pwm-tach-controller@1e610000 {
+      compatible = "aspeed,ast2600-pwm-tach";
+      reg = <0x1e610000 0x100>;
+      clocks = <&syscon ASPEED_CLK_AHB>;
+      resets = <&syscon ASPEED_RESET_PWM>;
+      #pwm-cells = <3>;
+
+      fan-0 {
+        tach-ch = /bits/ 8 <0x0>;
+        compatible = "pwm-fan";
+        pwms = <&pwm_tach 0 40000 0>;
+      };
+
+      fan-1 {
+        tach-ch = /bits/ 8 <0x1 0x2>;
+        compatible = "pwm-fan";
+        pwms = <&pwm_tach 1 40000 0>;
+      };
+    };
-- 
2.25.1


