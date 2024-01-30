Return-Path: <linux-kernel+bounces-44206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 871FB841EC6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9BEF1C234E5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233D066B50;
	Tue, 30 Jan 2024 09:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="d/oxvNJu"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15D260894;
	Tue, 30 Jan 2024 09:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605481; cv=none; b=KTKiP7HgDaHl9ZErNnbrqoTRB2HfxvHBWytjNQVzMgRjGBxQyDyOGK2t6sd7r+NSYYZM/NXDwgZqwCuZ5QeRT4uIl/5f01QDX9XngsI2GEjKpzh7k9yhgW8u+RFc97uJvTx0vcdW5dQeRTIGshTmwQ8Qnd9CWS/qqDa89HHOXtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605481; c=relaxed/simple;
	bh=zMZUnh+ptFzCUiMHGRQMzrBIbMYD6NQ3+yiLZXs+Acg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYo+Omzjy/gD0hvCrJxQW0OXl+zcgqXSMZ+MEF0FUYXsYZR3bEy++8SIyrGs2n2G9N3VhRwuPZcBUfF9lpaOTsy+gZAyMdEc7lV+5GVQZWg1HrW5F3BFNqLUcYmgoxNuQpwdnFA4ipLbxgV93j6LtlsSzSvslzB5h4VUrZLTc4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=d/oxvNJu; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 1E91D240006;
	Tue, 30 Jan 2024 09:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706605476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZLD7+4VmFr+Iy4x1r22wPwY17kqHNg9zXXFrmCLK6s=;
	b=d/oxvNJuzEefAEUXVPikn+2ik3mPEtm6jVEttEQg97iVUiRaLfJPQqa0j7F+DzNo19dsv7
	87mjCRV0bns6Y57PcTc/JFJAIFeZi9WnTGidaEmz6ErfSPm9ybWQvyFAmg9bLIvKP2Kqje
	gsgtSDkfqJ06w/YCLiOIbBYMMPUrj7WZ2s2um1eehUQNoz0oItK3NXLLdByqFMqEvvUVaw
	fEJ+MDjxnYU+XaPJ0jXa6Iwcd9gb00UGu0xng8F0X/7TUnUOvQxiQutFPBGfKFHd1DJvS8
	K8e8XZ1meX+9sPPjywKK+3GZFqLYV9vkzFKd7uinAP3q2YrU315B/SOFTtWHgA==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 1/2] dt-bindings: net: Add TI DP83640
Date: Tue, 30 Jan 2024 09:59:34 +0100
Message-ID: <20240130085935.33722-2-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130085935.33722-1-bastien.curutchet@bootlin.com>
References: <20240130085935.33722-1-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

The TI DP83640 is a PTP PHY. Some of his features can be enabled by
hardware straps or by registers configuration. Add a device tree
binding for configuration through registers

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 .../devicetree/bindings/net/ti,dp83640.yaml   | 113 ++++++++++++++++++
 include/dt-bindings/net/ti-dp83640.h          |  18 +++
 2 files changed, 131 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ti,dp83640.yaml
 create mode 100644 include/dt-bindings/net/ti-dp83640.h

diff --git a/Documentation/devicetree/bindings/net/ti,dp83640.yaml b/Documentation/devicetree/bindings/net/ti,dp83640.yaml
new file mode 100644
index 000000000000..b0f389122934
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ti,dp83640.yaml
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2024 Nanometrics Inc
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/ti,dp83640.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI DP83640 ethernet PHY
+
+allOf:
+  - $ref: ethernet-controller.yaml#
+
+maintainers:
+  - Bastien Curutchet <bastien.curutchet@bootlin.com>
+
+description: |
+  The DP83640 Precision PHYTER device delivers the highest level of precision
+  clock synchronization for real time industrial connectivity based on the
+  IEEE 1588 standard. The DP83640 has deterministic, low latency and allows
+  choice of microcontroller with no hardware customization required
+
+  This device interfaces directly to the MAC layer through the
+  IEEE 802.3 Standard Media Independent Interface (MII), or Reduced MII (RMII).
+
+  Specifications about the Ethernet PHY can be found at:
+    https://www.ti.com/lit/gpn/dp83640
+
+properties:
+  reg:
+    maxItems: 1
+
+  ti,clk-output:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    description: |
+      If present, enables or disables the CLK_OUT pin.
+      CLK_OUT pin disabling can also be strapped. If the strap pin is not set
+      correctly or not set at all then this can be used to configure it.
+       - 0     = CLK_OUT pin disabled
+       - 1     = CLK_OUT pin enabled
+       - unset = Configured by straps
+
+  ti,led-config:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 3]
+    description: |
+      If present, configures the LED Mode (values defined in
+      dt-bindings/net/ti-dp83640.h).
+      LED configuration can also be strapped. If the strap pin is not set
+      correctly or not set at all then this can be used to configure it.
+       - 1     = Mode 1
+        LED_LINK = ON for Good Link, OFF for No Link
+        LED_SPEED = ON in 100 Mb/s, OFF in 10 Mb/s
+        LED_ACT = ON for Activity, OFF for No Activity
+       - 2     = Mode 2
+        LED_LINK = ON for Good Link, BLINK for Activity
+        LED_SPEED = ON in 100 Mb/s, OFF in 10 Mb/s
+        LED_ACT = ON for Collision, OFF for No Collision
+       - 3     = Mode 3
+        LED_LINK = ON for Good Link, BLINK for Activity
+        LED_SPEED = ON in 100 Mb/s, OFF in 10 Mb/s
+        LED_ACT = ON for Full Duplex, OFF for Half Duplex
+       - unset = Configured by straps
+
+  ti,phy-control-frames:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    description: |
+      If present, enables or disables the PHY control frames.
+      PHY Control Frames support can also be strapped. If the strap pin is not
+      set correctly or not set at all then this can be used to configure it.
+       - 0     = PHY Control Frames disabled
+       - 1     = PHY Control Frames enabled
+       - unset = Configured by straps
+
+  ti,fiber-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    description: |
+      If present, enables or disables the FX Fiber Mode.
+      Fiber mode support can also be strapped. If the strap pin is not set
+      correctly or not set at all then this can be used to configure it.
+       - 0     = FX Fiber Mode disabled
+       - 1     = FX Fiber Mode enabled
+       - unset = Configured by straps
+
+  ti,energy-detect-en:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      If present, Energy Detect Mode is enabled. If not present, Energy Detect
+      Mode is disabled. This feature can not be strapped.
+
+required:
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/net/ti-dp83640.h>
+
+    mdio0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      ethphy0: ethernet-phy@0 {
+        reg = <0>;
+        ti,clk-output = <0>;
+        ti,energy-detect-en;
+        ti,led-config = <DP83640_PHYCR_LED_CNFG_MODE_3>;
+        ti,phy-control-frames = <1>;
+        ti,fiber-mode = <1>;
+      };
+    };
diff --git a/include/dt-bindings/net/ti-dp83640.h b/include/dt-bindings/net/ti-dp83640.h
new file mode 100644
index 000000000000..5f44f8eeb666
--- /dev/null
+++ b/include/dt-bindings/net/ti-dp83640.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Device Tree constants for the Texas Instruments DP83640 PHY
+ *
+ * Author: Bastien Curutchet bastien.curutchet@bootlin.com>
+ *
+ * Copyright: 2024 Nanometrics Inc.
+ */
+
+#ifndef _DT_BINDINGS_TI_DP83640_H
+#define _DT_BINDINGS_TI_DP83640_H
+
+/* PHY CTRL bits */
+#define DP83640_PHYCR_LED_CNFG_MODE_1 1
+#define DP83640_PHYCR_LED_CNFG_MODE_2 2
+#define DP83640_PHYCR_LED_CNFG_MODE_3 3
+
+#endif
-- 
2.43.0


