Return-Path: <linux-kernel+bounces-82976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 815B4868C7A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9237A1C23DBD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6BB1384BE;
	Tue, 27 Feb 2024 09:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l/BJeXbo"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A691369A0;
	Tue, 27 Feb 2024 09:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709026814; cv=none; b=gllcxbkZktgQ/wxF8vDbhcZ/TnoIvzlNk+pIVx7IiQDLlv2ho6fq6R+0MnmGATyAfkza4VAdj/xQNGvzr2Jcl+FUMmEVyAd7Pu+N4C9YPzkz0sJ+StBz4DSoTPCIb1ayFT1mQAU8zjlhPF/z92klqIcUtEtpuQQuAuyaDcacxuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709026814; c=relaxed/simple;
	bh=9JjvHERcZ8YVK7b/Q4VF9ZW0OhQYLZLE7HJA4c4oEVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwO2nhf6+57jlIi6SJpSEGxGLxVqWLHgd/5CUrm0slzSb3lJNjjOy5X2AF6AiTG/FZ3O2JQwL5JdM4tbXioTSEu1YwD0k2F8WCIZz/tl0YL+l6cThvfRmc/8lr9YTCfUgQc6B43Z2xPXYp4pCyjcMAodM1LyyZjiNYubVxCFfKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l/BJeXbo; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 5FCE91BF20C;
	Tue, 27 Feb 2024 09:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709026804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lvm6/L2WXUvtdtliXYOUV1u9RT8vkw9obusEbpY4LHk=;
	b=l/BJeXboAzq1t4BjFnD2es++LHkbZFXWmgrkX0aR4REVIzt4KMJ5FAFxCYspEGps/FbXDy
	Z3bMV2puAky55syDyN/tQZVqDlJpRTClyqH5iFYlBOJaCZBIX2PJPZmXtg61O8ySCmGKUw
	aBbY3IjojuuJORbqxR494qk/k86uhWSvZVcMHnTjmsU90YfnEomj6el5YsvqSQchk9Zj5b
	+jbQkP78Uc3nBa/LDHnV6mqGpCQ8EkU3negzntm/hxKfo1pCZF7KNimfktC50nDvopfo+9
	7ndMdXlLbiekglz8oPiJ5u98zOkFZptaU+VIJsYuTXCrhmH+FRzjWWy8RFdmYQ==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-leds@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com,
	maxime.chevallier@bootlin.com,
	christophercordahi@nanometrics.ca
Subject: [PATCH v2 1/6] dt-bindings: net: Add bindings for PHY DP83640
Date: Tue, 27 Feb 2024 10:39:40 +0100
Message-ID: <20240227093945.21525-2-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227093945.21525-1-bastien.curutchet@bootlin.com>
References: <20240227093945.21525-1-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

The DP83640 is a PTP PHY. Some of his features can be enabled by
hardware straps. There is not binding yet.

Add a device tree binding to be able to override the hardware strap
configuration when needed.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 .../devicetree/bindings/net/ti,dp83640.yaml   | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ti,dp83640.yaml

diff --git a/Documentation/devicetree/bindings/net/ti,dp83640.yaml b/Documentation/devicetree/bindings/net/ti,dp83640.yaml
new file mode 100644
index 000000000000..db1dc909d5cb
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ti,dp83640.yaml
@@ -0,0 +1,77 @@
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
+  The DP83640 Precision PHYTER device is an Ethernet PHY providing PTP
+  capabilities based on IEEE 1588 standard.
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
+  ti,fiber-mode:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [ disable, enable ]
+    description: |
+      If present, enables or disables the FX Fiber Mode.
+       - disable  = FX Fiber Mode disabled
+       - enable   = FX Fiber Mode enabled
+      Fiber mode enabling can also be strapped. If the strap pin is not set
+      correctly or not set at all then this can be used to configure it.
+
+  leds:
+    type: object
+    $ref: /schemas/leds/common.yaml#
+    description: |
+      Describes the three LEDs of the PHY.
+
+required:
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      ethphy0: ethernet-phy@0 {
+        reg = <0>;
+        ti,fiber-mode = "disable";
+        leds {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          led@0 {
+            reg = <0>;
+            label = "activity";
+          };
+          led@1 {
+            reg = <1>;
+            label = "link";
+          };
+          led@2 {
+            reg = <2>;
+            label = "speed";
+          };
+        };
+      };
+    };
-- 
2.43.0


