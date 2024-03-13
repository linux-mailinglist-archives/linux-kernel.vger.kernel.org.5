Return-Path: <linux-kernel+bounces-102353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457F787B1D7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86517B21F57
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C69D6F533;
	Wed, 13 Mar 2024 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aMZyKlNf"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D846FB80
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710354078; cv=none; b=aD4ohV4XOjJ9xEOk4KrsqxN8jA+56lE6bBsWxK8pKflHKZzL3Qcbzw51eMhnQuF30EFyzkY7j5qnvgAysLmyIdNxnC0d2AJhiHFoFGUdiFbsH6j1IKZEOtk4ZoWhQl6PuYkt69cDqkiyl6lpZwqfXrIpB2FoW5L9kv3bwoG0HXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710354078; c=relaxed/simple;
	bh=N0pWrZyQXrTMiGtBwdpPCskwTIccqQFj9gl2+9UdKi4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uJ9tNTZwsv6PUm5Mj7Rop5QjN7OFFpu4Hjh55e3GpBgOrPJ6BbmxAENnB7ktuA8/bV8Ne00nDhI2x5+Wdb8krryfeFxTlLgtkrOjCotMqeIipMBRw0fwzo+dhqzhc1xHB055HWbUc5DdW6SJknoVvOUJOijbsCngODD0QoxCUIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aMZyKlNf; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-413eee75912so1008505e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710354074; x=1710958874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6om7OCpDfnkdw/VSs/QMebeECIcaK8bcG7xAOFS/8ys=;
        b=aMZyKlNfVNglczypgL2a21gBKtzGAtV5DAB1aGG9qTp0klUlSKuHgZCnDJG7Sw3xyr
         9XmGaCJRnXP2iHbmzkwe0Nei5Usauytts6Bj5fDSCm/ueU2/poPw7Wn+SQnfjvwBkNr4
         mzmpViYnBxz6RptJI08yxwXI7pQf3wBNtNdFc1aGjOgz0zBD48A9bQOsqVll2/grQl8W
         9+ca4p5NDd73gjNU3Octg2idV/5dAFs1oMbLfVcjGEhoDjNx3rnTmufgHQ+qdA50Vxi6
         UHUGez9UlE0jS2PSwZMQcr4qpyKfg9mO6FNBAhI39yjb9iWZIoau1Gw5NeKOWplsoISn
         km1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710354074; x=1710958874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6om7OCpDfnkdw/VSs/QMebeECIcaK8bcG7xAOFS/8ys=;
        b=vyVbJAvGAxhGfEDp0qfkhfxBORQOUj6RoOyT5Q7L5vi7XeoZZeqlo6iSlq8HBA7zbC
         ssdsndX2xlalC4jKUpl+S4Fz2ZgBztRnCzSQgKudxgm4OQxvcWoe9T/96b8IBIEwNGH8
         d+SI1BTZAd7f4jk0YIm6NQ3miTj1aS4oOLYQ1I7PEKEiJXqQbo8gRsHOSJnSC+IHd0oL
         pEo+2u7tYrZpzWylKX7xy1uzKzFiDjhfiYh7DScKzeC0D+bemSlcEHhDCDq+annbNmdf
         qZXKxeUEeEHaWoZmvWvcryVrhP2ECBxy/jGBHtqxznzoPKpmWDFh7iicE9VEMC1oo9/6
         N4Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVcXAnXhLBKOO0f6whMhzWK6WSS8bg45F8T2QAilJjsh0NX7mrj7ov7KN5pncWz+aZCiFzcAkC63PHod0Mj5nrHwS2OFfty20YGLikf
X-Gm-Message-State: AOJu0YweaJmSlrLnaI+mZ26y4+ZPiU/BDgiTCWO+VYuX8fjW5UK6OnK7
	9tZ7RGPYBLevx2iwIYG2wNHEez0p2JD+xZcM0C9KZuenEQguTM7xlom3mmB7WBA=
X-Google-Smtp-Source: AGHT+IFMrRVOk317baIYag+ylVYYi/NIeJlRZwlC5NfJro2DkXXq8GsZwmxjKwOeCmQki0tbMmpxnQ==
X-Received: by 2002:a05:600c:450c:b0:413:1285:6e40 with SMTP id t12-20020a05600c450c00b0041312856e40mr576503wmo.20.1710354074410;
        Wed, 13 Mar 2024 11:21:14 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c444600b00412f83e0c11sm3024337wmn.22.2024.03.13.11.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 11:21:13 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: display: samsung,exynos5-dp: convert to DT Schema
Date: Wed, 13 Mar 2024 19:21:08 +0100
Message-Id: <20240313182108.12458-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert Samsung Exynos5250/5420 SoC Display Port Controller bindings to
DT schema with changes:
1. Drop samsung,hpd-gpio, because it is not used by Linux driver.
   Existing usage in DTS is going to be fixed.
2. Add power-domains, already used in DTS.

This Display Port controller is actually variant of Analogix Display
Port bridge, however new DT Schema does not reference analogix,dp.yaml,
because of incompatibilities in the driver.  The analogix,dp.yaml
expects two ports, input and output, but Linux Exynos DP DRM driver and
DTS use only one port: output.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/display/exynos/exynos_dp.txt     | 112 ------------
 .../display/samsung/samsung,exynos5-dp.yaml   | 159 ++++++++++++++++++
 2 files changed, 159 insertions(+), 112 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/exynos/exynos_dp.txt
 create mode 100644 Documentation/devicetree/bindings/display/samsung/samsung,exynos5-dp.yaml

diff --git a/Documentation/devicetree/bindings/display/exynos/exynos_dp.txt b/Documentation/devicetree/bindings/display/exynos/exynos_dp.txt
deleted file mode 100644
index 3a401590320f..000000000000
--- a/Documentation/devicetree/bindings/display/exynos/exynos_dp.txt
+++ /dev/null
@@ -1,112 +0,0 @@
-The Exynos display port interface should be configured based on
-the type of panel connected to it.
-
-We use two nodes:
-	-dp-controller node
-	-dptx-phy node(defined inside dp-controller node)
-
-For the DP-PHY initialization, we use the dptx-phy node.
-Required properties for dptx-phy: deprecated, use phys and phy-names
-	-reg: deprecated
-		Base address of DP PHY register.
-	-samsung,enable-mask: deprecated
-		The bit-mask used to enable/disable DP PHY.
-
-For the Panel initialization, we read data from dp-controller node.
-Required properties for dp-controller:
-	-compatible:
-		should be "samsung,exynos5-dp".
-	-reg:
-		physical base address of the controller and length
-		of memory mapped region.
-	-interrupts:
-		interrupt combiner values.
-	-clocks:
-		from common clock binding: handle to dp clock.
-	-clock-names:
-		from common clock binding: Shall be "dp".
-	-phys:
-		from general PHY binding: the phandle for the PHY device.
-	-phy-names:
-		from general PHY binding: Should be "dp".
-
-Optional properties for dp-controller:
-	-interlaced:
-		interlace scan mode.
-			Progressive if defined, Interlaced if not defined
-	-vsync-active-high:
-		VSYNC polarity configuration.
-			High if defined, Low if not defined
-	-hsync-active-high:
-		HSYNC polarity configuration.
-			High if defined, Low if not defined
-	-samsung,hpd-gpio:
-		Hotplug detect GPIO.
-			Indicates which GPIO should be used for hotplug
-			detection
-	-video interfaces: Device node can contain video interface port
-			nodes according to [1].
-	- display-timings: timings for the connected panel as described by
-		Documentation/devicetree/bindings/display/panel/display-timing.txt
-
-For the below properties, please refer to Analogix DP binding document:
- * Documentation/devicetree/bindings/display/bridge/analogix,dp.yaml
-	-phys (required)
-	-phy-names (required)
-	-hpd-gpios (optional)
-	 force-hpd (optional)
-
-Deprecated properties for DisplayPort:
--interlaced:            deprecated prop that can parsed from drm_display_mode.
--vsync-active-high:     deprecated prop that can parsed from drm_display_mode.
--hsync-active-high:     deprecated prop that can parsed from drm_display_mode.
--samsung,ycbcr-coeff:   deprecated prop that can parsed from drm_display_mode.
--samsung,dynamic-range: deprecated prop that can parsed from drm_display_mode.
--samsung,color-space:   deprecated prop that can parsed from drm_display_info.
--samsung,color-depth:   deprecated prop that can parsed from drm_display_info.
--samsung,link-rate:     deprecated prop that can reading from monitor by dpcd method.
--samsung,lane-count:    deprecated prop that can reading from monitor by dpcd method.
--samsung,hpd-gpio:      deprecated name for hpd-gpios.
-
--------------------------------------------------------------------------------
-
-Example:
-
-SOC specific portion:
-	dp-controller {
-		compatible = "samsung,exynos5-dp";
-		reg = <0x145b0000 0x10000>;
-		interrupts = <10 3>;
-		interrupt-parent = <&combiner>;
-		clocks = <&clock 342>;
-		clock-names = "dp";
-
-		phys = <&dp_phy>;
-		phy-names = "dp";
-	};
-
-Board Specific portion:
-	dp-controller {
-		display-timings {
-			native-mode = <&lcd_timing>;
-			lcd_timing: 1366x768 {
-				clock-frequency = <70589280>;
-				hactive = <1366>;
-				vactive = <768>;
-				hfront-porch = <40>;
-				hback-porch = <40>;
-				hsync-len = <32>;
-				vback-porch = <10>;
-				vfront-porch = <12>;
-				vsync-len = <6>;
-			};
-		};
-
-		ports {
-			port@0 {
-				dp_out: endpoint {
-					remote-endpoint = <&bridge_in>;
-				};
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/display/samsung/samsung,exynos5-dp.yaml b/Documentation/devicetree/bindings/display/samsung/samsung,exynos5-dp.yaml
new file mode 100644
index 000000000000..daf90cda453e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/samsung/samsung,exynos5-dp.yaml
@@ -0,0 +1,159 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/samsung/samsung,exynos5-dp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos5250/Exynos5420 SoC Display Port
+
+maintainers:
+  - Inki Dae <inki.dae@samsung.com>
+  - Seung-Woo Kim <sw0312.kim@samsung.com>
+  - Kyungmin Park <kyungmin.park@samsung.com>
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+properties:
+  compatible:
+    const: samsung,exynos5-dp
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: dp
+
+  display-timings:
+    $ref: /schemas/display/panel/display-timings.yaml#
+
+  interrupts:
+    maxItems: 1
+
+  hpd-gpios:
+    description:
+      Hotplug detect GPIO.
+      Indicates which GPIO should be used for hotplug detection
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    items:
+      - const: dp
+
+  power-domains:
+    maxItems: 1
+
+  interlaced:
+    type: boolean
+    deprecated: true
+    description:
+      Interlace scan mode. Progressive if defined, interlaced if not defined.
+
+  vsync-active-high:
+    type: boolean
+    deprecated: true
+    description:
+      VSYNC polarity configuration. High if defined, low if not defined
+
+  hsync-active-high:
+    type: boolean
+    deprecated: true
+    description:
+      HSYNC polarity configuration. High if defined, low if not defined
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Port node with one endpoint connected to a dp-connector node.
+
+    required:
+      - port
+
+  samsung,ycbcr-coeff:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
+    description:
+      Deprecated prop that can parsed from drm_display_mode.
+
+  samsung,dynamic-range:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
+    description:
+      Deprecated prop that can parsed from drm_display_mode.
+
+  samsung,color-space:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
+    description:
+      Deprecated prop that can parsed from drm_display_info.
+
+  samsung,color-depth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
+    description:
+      Deprecated prop that can parsed from drm_display_info.
+
+  samsung,link-rate:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
+    description:
+      Deprecated prop that can reading from monitor by dpcd method.
+
+  samsung,lane-count:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
+    description:
+      Deprecated prop that can reading from monitor by dpcd method.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - phys
+  - phy-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos5250.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    dp-controller@145b0000 {
+        compatible = "samsung,exynos5-dp";
+        reg = <0x145b0000 0x1000>;
+        clocks = <&clock CLK_DP>;
+        clock-names = "dp";
+        interrupts = <10 3>;
+        interrupt-parent = <&combiner>;
+        phys = <&dp_phy>;
+        phy-names = "dp";
+        pinctrl-0 = <&dp_hpd>;
+        pinctrl-names = "default";
+        power-domains = <&pd_disp1>;
+
+        samsung,color-space = <0>;
+        samsung,color-depth = <1>;
+        samsung,link-rate = <0x0a>;
+        samsung,lane-count = <2>;
+        hpd-gpios = <&gpx0 7 GPIO_ACTIVE_HIGH>;
+
+        ports {
+            port {
+                dp_out: endpoint {
+                    remote-endpoint = <&bridge_in>;
+                };
+            };
+        };
+    };
-- 
2.34.1


