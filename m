Return-Path: <linux-kernel+bounces-136605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E17889D612
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34648283C46
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3A982865;
	Tue,  9 Apr 2024 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igzVb5+z"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25A78173C;
	Tue,  9 Apr 2024 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712656610; cv=none; b=osor4+isI24w7ONBjB2KNKqFMuCf8kvXYRGbWu+3a/SF8si/E1UPvRAHCIvGeZbZzDryg84HFhaNg/wn2Qc8uwtWrTsNR3bHAXZuic3Sq4dxV2HEr2dMKNBL1OIfb8oNDnOkblTvoRBfhef/8WRF+QricMZSKNKfYs/666xi6vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712656610; c=relaxed/simple;
	bh=wvsDcCz4V8ckm6Y5cmx24jz4vCItdVXP3OrMJQUAD+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WZ7g1d8YpGTtB6iVNdBVbRoesvrxNsNv65en06qZB4FjcirvrOu9r3UCOLCunLEhVdTZGbIg9qnCYyMSG49Yqht5l44fsDpf1JFt8rID7ishK74rjYakRvjazfUETOR212gNxy7dUaDw9HU61y0zgZY+N5KM1hcYyKwW8P4PFko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igzVb5+z; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ed2dc03df6so1723177b3a.1;
        Tue, 09 Apr 2024 02:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712656608; x=1713261408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBNT1NwAXcdBlViFBBFgJVd26xGIToLjTiUG+Kqd4r4=;
        b=igzVb5+zcXyrMqIYU+stAGFGdiJR1X5vaZFTzs4pOfSt4FBGueN7CGpJa98qPgA20m
         0yDvcXZkSTHsgCX95kE3gT/Up7JRhDfu6PPLXgCdZUw9VQxG7tGYmvgU01ND7OF2h7KF
         68ttIm12LZD7aU2eKYr/EtFiPRLT88250WbKUDytkjFlxoS1bBhEyUnfmuajLKoT6DlL
         TMmIEGhoAwpimbvMSmTtrQrY0EaroSc7tEFGQWFgZhkSzmoz/YBO4uVww+gYBR9sM1AI
         ZgSG5uYZ5dS9HPRa09Spa+R5c4l5sv16WgM2yyHg/fhNhSWIVmT1LwyGLwccYDnUGp4s
         zr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712656608; x=1713261408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBNT1NwAXcdBlViFBBFgJVd26xGIToLjTiUG+Kqd4r4=;
        b=htP72J0P0Wm7NkgDOCZMd56nh3nPE5p4nIR7xLBNl23A5mhm7ejw+2EfWPsc2phx3o
         ncZWk4Re07RBfzo4o1kaqydEH7Lj+qNlMHGk2eP/6DpnwR1njAEmPzdyl6c8999AohHe
         pVPtVfXcXSCDRunA6gp0eoLnVClhf5CrP5hnbLzzMPOT973CRDhot7ewiyrhwnuuI6Y6
         dPa8Lk+IGbNVEfue1T0NQYDQEAGzh/XFQG5J6t9I7duMwO8FIgsn2gTKCvi1vdtLUgo3
         /gzTGDLCu2vx3PpsHWlxvlZ0LVrM7+7we5bRLXyTUrb4KfrSmi17uYUHLsSAPzHxiD9n
         8whA==
X-Forwarded-Encrypted: i=1; AJvYcCUolBdsNbegD7Ho+Pnt2MM14wD9zoAfBrNY3KCnN52J0oseBgAdJbj+tEDq8zAR1SyyOTpqSA6UGlnwNaPLc9Hy16CGvtdpOcOI+gEk+1n72zj7sXWSq+WnDTEagWhX3a+10bER6P53ZIGuq90o6ntsQs4HSv6nDciEddILF0vM001+m18=
X-Gm-Message-State: AOJu0YydeowyHn57TMTBn6lTJ2GS2KsLAbD8NSAQLflaLihAdrrPwHto
	bsEg5R1o6pHGFrkSSWBBA9c0nwybV1nGjQIxWsD5NSAuKFB2oaBN
X-Google-Smtp-Source: AGHT+IH+0xUHB5fNKZSDnFf4TdSpCjNWFwoNEa+N7S7Yf2YQ9ZZ8dXvoiwYwJG1I3dhWKPBX9BpxLA==
X-Received: by 2002:a05:6a21:2d89:b0:1a7:3d2a:7383 with SMTP id ty9-20020a056a212d8900b001a73d2a7383mr14320944pzb.18.1712656608022;
        Tue, 09 Apr 2024 02:56:48 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902d4d100b001e3f1596baasm5100445plg.298.2024.04.09.02.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 02:56:47 -0700 (PDT)
From: Jacky Huang <ychuang570808@gmail.com>
To: linus.walleij@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	j.neuschaefer@gmx.net
Cc: linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 2/3] dt-bindings: pinctrl: Document nuvoton ma35d1 pin control
Date: Tue,  9 Apr 2024 09:56:36 +0000
Message-Id: <20240409095637.2135-3-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240409095637.2135-1-ychuang570808@gmail.com>
References: <20240409095637.2135-1-ychuang570808@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacky Huang <ychuang3@nuvoton.com>

Add documentation to describe nuvoton ma35d1 pin control and GPIO.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../pinctrl/nuvoton,ma35d1-pinctrl.yaml       | 163 ++++++++++++++++++
 1 file changed, 163 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
new file mode 100644
index 000000000000..8b9ec263213f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
@@ -0,0 +1,163 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/nuvoton,ma35d1-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 pin control and GPIO
+
+maintainers:
+  - Shan-Chun Hung <schung@nuvoton.com>
+  - Jacky Huang <ychuang3@nuvoton.com>
+
+allOf:
+  - $ref: pinctrl.yaml#
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,ma35d1-pinctrl
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  nuvoton,sys:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle of the system-management node.
+
+  ranges: true
+
+patternProperties:
+  "^gpio@[0-9a-f]+$":
+    type: object
+    additionalProperties: false
+    properties:
+      gpio-controller: true
+
+      '#gpio-cells':
+        const: 2
+
+      reg:
+        maxItems: 1
+
+      clocks:
+        maxItems: 1
+
+      interrupt-controller: true
+
+      '#interrupt-cells':
+        const: 2
+
+      interrupts:
+        description:
+          The interrupt outputs to sysirq.
+        maxItems: 1
+
+    required:
+      - gpio-controller
+      - '#gpio-cells'
+      - reg
+      - clocks
+      - interrupt-controller
+      - '#interrupt-cells'
+      - interrupts
+
+  "^pin-[a-z0-9]+$":
+    type: object
+    description:
+      A pinctrl node should contain at least one subnodes representing the
+      pinctrl groups available on the machine. Each subnode will list the
+      pins it needs, and how they should be configured, with regard to muxer
+      configuration, pullups, drive strength, input enable/disable and input
+      schmitt.
+
+    $ref: pincfg-node.yaml#
+
+    properties:
+      power-source:
+        description: |
+          Valid arguments are described as below:
+          0: power supply of 1.8V
+          1: power supply of 3.3V
+        enum: [0, 1]
+
+      drive-strength-microamp:
+        oneOf:
+          - enum: [ 2900, 4400, 5800, 7300, 8600, 10100, 11500, 13000 ]
+            description: 1.8V I/O driving strength
+          - enum: [ 17100, 25600, 34100, 42800, 48000, 56000, 77000, 82000 ]
+            description: 3.3V I/O driving strength
+
+    unevaluatedProperties: false
+
+  "-grp$":
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+    properties:
+      nuvoton,pins:
+        description:
+          Each entry consists of 4 parameters and represents the mux and config
+          setting for one pin.
+        $ref: /schemas/types.yaml#/definitions/uint32-matrix
+        minItems: 1
+        items:
+          items:
+            - minimum: 0
+              maximum: 13
+              description:
+                Pin bank.
+            - minimum: 0
+              maximum: 15
+              description:
+                Pin bank index.
+            - minimum: 0
+              maximum: 15
+              description:
+                Mux 0 means GPIO and mux 1 to 15 means the specific device function.
+
+required:
+  - compatible
+  - nuvoton,sys
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+
+    pinctrl@40040000 {
+        compatible = "nuvoton,ma35d1-pinctrl";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        nuvoton,sys = <&sys>;
+        ranges = <0 0x40040000 0xc00>;
+
+        gpio@0 {
+            reg = <0x0 0x40>;
+            interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&clk GPA_GATE>;
+            gpio-controller;
+            #gpio-cells = <2>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+        };
+
+        uart-grp {
+            uart11-pins {
+                nuvoton,pins = <11 0 2>,
+                               <11 1 2>,
+                               <11 2 2>,
+                               <11 3 2>;
+                bias-disable;
+                power-source = <1>;
+            };
+        };
+    };
-- 
2.34.1


