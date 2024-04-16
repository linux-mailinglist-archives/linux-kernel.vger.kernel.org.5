Return-Path: <linux-kernel+bounces-147205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19D68A70FC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87075285714
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C754413280C;
	Tue, 16 Apr 2024 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIE0hw6Z"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE549131758;
	Tue, 16 Apr 2024 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713283977; cv=none; b=Nd2l1EZKKiqUkOwXUFkxkQVaclfw0LVYKmI1VpljQGrQx26xKbb8nGGA2qfk25lRWTl+EbBW/QMRjIjiicr5RohzF7VEgT9PGNG0Q1DciNUHY0HbJxRtOLGnN9vkpwhT5d7pllSgMsf6aUBmgpV/9Xii0avwIOR2vSOZ2lkZnIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713283977; c=relaxed/simple;
	bh=HPEvp6Xnx0a24UTyj1XASHwdvMSE0QzhnlW66pb0fjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mH+zDuv+SEWuLNI8mpTGTECDAUjf4E04vacnaW38gqZOrTZ6cnKsyJhpZTs5G9gLVSdoRD/CW8AUILKH+Ee017rghD4xt6GMLA23YNxikzP8rTQOsN39I5+P3a4vRKyoKhCvrVVo4nyse014dKkDuJYUyOFq9fhsiDvglpcZEtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIE0hw6Z; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-518d98b9620so3214106e87.3;
        Tue, 16 Apr 2024 09:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713283974; x=1713888774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZ5AXaaZvF3udQdn/XiOr1JWab5XW1E44Fc/EcaEkYk=;
        b=EIE0hw6ZpZz3aOg5jnZzu2N3779kemRUXFWld0JDf41UeHPaneEDD76HnsQoE+wM0y
         Jy0Ct9QkTXGDtBCO91Hrb5MdnHw4gWQqqbqsuxiZq4hzWw+VvRuZFiF6eSG7XMJjXqeB
         IfeAYswTgd+rqAy7bpDUCkoA15uJ99lZZSbgM0Zo5VcJN/7TDaOEIWGy2eZd/r6/49JK
         hbCF86Cy4xg6QYla5s1p4i8MVOJ+VpuzSgQsnLw1zgaX2qgVXU5FhlvdLUlsQfVRb1tw
         c91gxjIVb7pUoFldWhdIqts/iDC214IL5ybQg9RT+lDkrYMH1w4UtSlV3eFaozA9uFVR
         gDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713283974; x=1713888774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZ5AXaaZvF3udQdn/XiOr1JWab5XW1E44Fc/EcaEkYk=;
        b=bYUPPKrZ76W8bsJthmpkiLIzjLjtXhh3O75NAgayV/s/58E+kJj85oaNoYv4V6KWPZ
         +ongJm0An1jJTytX3s/xgF1W7aSimRONvl1SXkmYuUiycdMRbjwqseGh1wjP7+tSEd9y
         IGP8ZDidOTYM+YG62MCiKrVqWvof0BqEcwPmMeiV1XuJRsFseVgqTa7X3grLvLHcZtcD
         dHjCWqPaZA6Pv143Ipy5afDUgi7ZFP13vJ9j+fb7q3C15wcFjLLbIbE5tC+KIfVHlV74
         MDUK0AolhlW6BST0JSsKe4gmjsHDOanrRMDMlhhm6lBa7ovH2w9K6fhRehHmtR2QiS5U
         r4xA==
X-Forwarded-Encrypted: i=1; AJvYcCU976XXs8kaybNJJen3UH1BzEULuLdzNymlrlGEhx6QNipJaX218rINa5yGunTJ7SQEFm/cB0vkRH3oq+l2gvJApHqIMfUFv1aYM0tQpE3BsR3UDb3omVCvijdG9tVtSOe87suZILciX06RhHbMN6N0q8mRa2BTFcKT2cMjf2ZFN/ahHMc=
X-Gm-Message-State: AOJu0Yw8VmQ+MdHoW3BdhiGoUc/h4KVBGkovBZQgKRH1Env6hsJV9hko
	12wf4r7I06KsbpDBaorjXzm/NTH9xebGzacC3woLbkDaj4Fd4Uc=
X-Google-Smtp-Source: AGHT+IHIKxf50ytdcwXdlZtYo1Szbwh4f+kLLgZNYs3gmQjei7+UEemHruTuLGWMf9W3fuWbS3xbjQ==
X-Received: by 2002:ac2:555a:0:b0:515:cb19:41f4 with SMTP id l26-20020ac2555a000000b00515cb1941f4mr7692676lfk.59.1713283973710;
        Tue, 16 Apr 2024 09:12:53 -0700 (PDT)
Received: from U4.lan ([91.66.160.190])
        by smtp.gmail.com with ESMTPSA id t7-20020adfe447000000b00343eac2acc4sm15350743wrm.111.2024.04.16.09.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 09:12:53 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Chris Zhong <zyw@rock-chips.com>,
	Zhang Qing <zhangqing@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/5] dt-bindings: mfd: Add rk816 binding
Date: Tue, 16 Apr 2024 18:12:33 +0200
Message-ID: <20240416161237.2500037-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240416161237.2500037-1-knaerzche@gmail.com>
References: <20240416161237.2500037-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DT binding document for Rockchip's RK816 PMIC

Signed-off-by: Alex Bee <knaerzche@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
changes since v1:
  - lowercase/hyphens for regulator node names
  - rename "-reg" to "-regulator" to make node names generic
  - dropped superfluous description for clock-output-names and
    wakeup-source
  - dropped "|" for text blocks that don't require to preserve formatting
  - use full path for `$ref`s
  - added pins description to the binding
  - added charger function to description

changes since v2:
  - dropped "-regulator"-suffix from regulator device names
  - use "'"-quotes consistently in the binding
  - dropped "pin_fun"-prefix from pin-function names
  - added pin to example

changes since v3:
  - made "unevaluatedProperties: false" to "additionalProperties: false" for
    regulators node
  - added RB-tag

 .../bindings/mfd/rockchip,rk816.yaml          | 274 ++++++++++++++++++
 1 file changed, 274 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml

diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml
new file mode 100644
index 000000000000..0676890f101e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml
@@ -0,0 +1,274 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/rockchip,rk816.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RK816 Power Management Integrated Circuit
+
+maintainers:
+  - Chris Zhong <zyw@rock-chips.com>
+  - Zhang Qing <zhangqing@rock-chips.com>
+
+description:
+  Rockchip RK816 series PMIC. This device consists of an i2c controlled MFD
+  that includes regulators, a RTC, a GPIO controller, a power button, and a
+  battery charger manager with fuel gauge.
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk816
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  '#clock-cells':
+    description:
+      See <dt-bindings/clock/rockchip,rk808.h> for clock IDs.
+    const: 1
+
+  clock-output-names:
+    maxItems: 2
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+  system-power-controller:
+    type: boolean
+    description:
+      Telling whether or not this PMIC is controlling the system power.
+
+  wakeup-source:
+    type: boolean
+
+  vcc1-supply:
+    description:
+      The input supply for dcdc1.
+
+  vcc2-supply:
+    description:
+      The input supply for dcdc2.
+
+  vcc3-supply:
+    description:
+      The input supply for dcdc3.
+
+  vcc4-supply:
+    description:
+      The input supply for dcdc4.
+
+  vcc5-supply:
+    description:
+      The input supply for ldo1, ldo2, and ldo3.
+
+  vcc6-supply:
+    description:
+      The input supply for ldo4, ldo5, and ldo6.
+
+  vcc7-supply:
+    description:
+      The input supply for boost.
+
+  vcc8-supply:
+    description:
+      The input supply for otg-switch.
+
+  regulators:
+    type: object
+    patternProperties:
+      '^(boost|dcdc[1-4]|ldo[1-6]|otg-switch)$':
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+    additionalProperties: false
+
+patternProperties:
+  '-pins$':
+    type: object
+    additionalProperties: false
+    $ref: /schemas/pinctrl/pinmux-node.yaml
+
+    properties:
+      function:
+        enum: [gpio, thermistor]
+
+      pins:
+        $ref: /schemas/types.yaml#/definitions/string
+        const: gpio0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/pinctrl/rockchip.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rk816: pmic@1a {
+            compatible = "rockchip,rk816";
+            reg = <0x1a>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <RK_PA2 IRQ_TYPE_LEVEL_LOW>;
+            clock-output-names = "xin32k", "rk816-clkout2";
+            pinctrl-names = "default";
+            pinctrl-0 = <&pmic_int_l>;
+            gpio-controller;
+            system-power-controller;
+            wakeup-source;
+            #clock-cells = <1>;
+            #gpio-cells = <2>;
+
+            vcc1-supply = <&vcc_sys>;
+            vcc2-supply = <&vcc_sys>;
+            vcc3-supply = <&vcc_sys>;
+            vcc4-supply = <&vcc_sys>;
+            vcc5-supply = <&vcc33_io>;
+            vcc6-supply = <&vcc_sys>;
+
+            regulators {
+                vdd_cpu: dcdc1 {
+                    regulator-name = "vdd_cpu";
+                    regulator-min-microvolt = <750000>;
+                    regulator-max-microvolt = <1450000>;
+                    regulator-ramp-delay = <6001>;
+                    regulator-initial-mode = <1>;
+                    regulator-always-on;
+                    regulator-boot-on;
+
+                    regulator-state-mem {
+                        regulator-off-in-suspend;
+                    };
+                };
+
+                vdd_logic: dcdc2 {
+                    regulator-name = "vdd_logic";
+                    regulator-min-microvolt = <800000>;
+                    regulator-max-microvolt = <1250000>;
+                    regulator-ramp-delay = <6001>;
+                    regulator-initial-mode = <1>;
+                    regulator-always-on;
+                    regulator-boot-on;
+
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                        regulator-suspend-microvolt = <1000000>;
+                    };
+                };
+
+                vcc_ddr: dcdc3 {
+                    regulator-name = "vcc_ddr";
+                    regulator-initial-mode = <1>;
+                    regulator-always-on;
+                    regulator-boot-on;
+
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                    };
+                };
+
+                vcc33_io: dcdc4 {
+                    regulator-min-microvolt = <3300000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-name = "vcc33_io";
+                    regulator-initial-mode = <1>;
+                    regulator-always-on;
+                    regulator-boot-on;
+
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                        regulator-suspend-microvolt = <3300000>;
+                    };
+                };
+
+                vccio_pmu: ldo1 {
+                    regulator-min-microvolt = <3300000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-name = "vccio_pmu";
+                    regulator-always-on;
+                    regulator-boot-on;
+
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                        regulator-suspend-microvolt = <3300000>;
+                    };
+                };
+
+                vcc_tp: ldo2 {
+                    regulator-min-microvolt = <3300000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-name = "vcc_tp";
+
+                    regulator-state-mem {
+                        regulator-off-in-suspend;
+                    };
+                };
+
+                vdd_10: ldo3 {
+                    regulator-min-microvolt = <1000000>;
+                    regulator-max-microvolt = <1000000>;
+                    regulator-name = "vdd_10";
+                    regulator-always-on;
+                    regulator-boot-on;
+
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                        regulator-suspend-microvolt = <1000000>;
+                    };
+                };
+
+                vcc18_lcd: ldo4 {
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <1800000>;
+                    regulator-name = "vcc18_lcd";
+
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                        regulator-suspend-microvolt = <1800000>;
+                    };
+                };
+
+                vccio_sd: ldo5 {
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-name = "vccio_sd";
+
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                        regulator-suspend-microvolt = <3300000>;
+                    };
+                };
+
+                vdd10_lcd: ldo6 {
+                    regulator-min-microvolt = <1000000>;
+                    regulator-max-microvolt = <1000000>;
+                    regulator-name = "vdd10_lcd";
+
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                        regulator-suspend-microvolt = <1000000>;
+                    };
+                };
+            };
+
+            rk816_gpio_pins: gpio-pins {
+                function = "gpio";
+                pins = "gpio0";
+            };
+        };
+    };
-- 
2.43.2


