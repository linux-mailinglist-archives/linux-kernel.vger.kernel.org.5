Return-Path: <linux-kernel+bounces-98310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B3F87783F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 20:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9830FB20E28
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 19:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48CC3A8DA;
	Sun, 10 Mar 2024 19:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b="el0RgnmE"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7098539FFB;
	Sun, 10 Mar 2024 19:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710098535; cv=none; b=Dydgeb9VImAcfzgypIUx4LlkPC4N6SS4NX0LyQuU0SICzYMbYdFSlU8Q3enqmer3elYW+X8QX3Fh3wUb7ysmbZq5GtlVa1lKPby1sgaMzai0ulz4s97QCXqAdKcfmFy2xKTkKZFUeLWTv1j73FqYvofaam5DDJUENxjvVbrmQoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710098535; c=relaxed/simple;
	bh=6NrF/w77Op3jkfAxtCcQ+TosCvo0V+DYPJY4uCHzAtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WtB2EC/sEmaMeg2plsIThgGb0+uc6o8VWl51PdUHtrhO2rtmosONBKSPaaDMM/Z+ZM9DU46iRM3i/j8O3LEcvI7r6EShYn+sfvnPIgIEoQJQGQBfz1y6GLhfC6TXLNswF+nWLf5TrRRwZnvutZMSd6Fm0Xwfcs+4YXoV5cSCBlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b=el0RgnmE; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1710098501; x=1710703301; i=j.neuschaefer@gmx.net;
	bh=6NrF/w77Op3jkfAxtCcQ+TosCvo0V+DYPJY4uCHzAtI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=el0RgnmEBLGVTPuV8h4c+rawNSxGTjZE3tV1RWq7zFI+zuuUxz5bPM9Resb3E7G2
	 1dkMmEGgXiB1r/lFASvolu0s8tKOx6uoFa8Po8NEXHNivz5vc8C1T9KdFOU+jBn6P
	 sYEuxLJDFt8qN0XizCgtu3TNpN7lfe0PGdElxmf5zzcUhuWFAcbC+NptEAOfcm34O
	 MucarEKG0eFmKqoEUtg3+YH069EeBAc8c0diljMMdpxREKORCCU9UZiH6C4UF2LJy
	 f8/cNq+6iWQznCDrgeIxZtfcuBHkLgOVen4g48R5CoRsC4XDskq2fCwiQrgOo60TI
	 e9HCtsLQQRaGO8G/Gw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([78.35.216.168]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUXpQ-1rJ6Qf1PKi-00QPqP; Sun, 10
 Mar 2024 20:21:41 +0100
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linux-clk@vger.kernel.org,
	openbmc@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v10 1/4] dt-bindings: clock: Add Nuvoton WPCM450 clock/reset controller
Date: Sun, 10 Mar 2024 20:20:59 +0100
Message-ID: <20240310192108.2747084-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240310192108.2747084-1-j.neuschaefer@gmx.net>
References: <20240310192108.2747084-1-j.neuschaefer@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fw14egUNoBom9w1dGp3wFN0nblRuKgnnItHG+gE0CBjhqzOwVYL
 8rhmhsjwuFftEDklSccS7sU+B5EPg87KzmsE1L+JDFywVJ1hVra4oASOfnOwWFkAl7MXGX6
 5NKVWFOKC2HI89sdOtSAX8HAh6RhYmzu+/okscjCJPy1kJjX+InDYIkVQDq1q7g0B1lNLai
 J/AC8ocnd7G/q31bJjHkA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:opuMrp+Apzg=;3lP/qhKFERKfRPkGJXwMP4HvzyC
 3sZYaii7KWf+WcXuG+AYNpOAI6cdP0mz3UhHBIGdLAKph1CHAFpslAASAYXAw1D5nr0BYz5bx
 xHO+INPllMpKePoBd9461vMRHBcQCiRrX1mrgSN67i6mw5EuMnGnLl5dtN5bknj0Xb1o0D1hA
 zOhbGB3aCoDqlLQjoCBQF+KHrAqIdL+YSpfB7hxsH3b1MNRkgmxF0ElaCeefqzNMt4NFkMV2s
 kGO9J9VrgczZIovcMssp+QIS5GulA7ywXgO+35xDRb6+QLL22WgXP87VNQ10AzUSOlHJXO/uu
 VTeDFACW67xL+rpYzJw7zlLPaFCiH3xO9kITPz17Z6bkjwwFAHf2b4PpQBpS0fAIoDT615XzA
 mXuFH9hnvIQOA5lY2gXhY9f2kf3vUE+jsLCakFmQXKUakOfH+OgQP58H1oDEWe63cfaI0+bqJ
 CoVg6rCyPzZmc7GKpecn+gvJIkiZ/6AmUmgSeai+p24vf9Ffcno9kCe1n2sSPo64OciwQfYtJ
 RbAN4JlyAZCp9ZaYMfIUJ0XT2q/uMq9BbxgwP8EDtjr269doStCEYqdpYJFWt2khwy/cdY3cf
 zWYHrGcTx4WnnB5c/s1BP+b9U0iPdUBBA+kf1BID+cP/syQDyuFUEiW5afykVQ1Kq8/2nkvES
 vrWoNxq4c6n8PKcn/yXkHZptcHnS8kDJx8mGNpF1r7C6piK/nqN0r/at0l9MT5tYYvkw46nPJ
 uWzZF+D+t8+jBV+LfRLR1kTtc9pGhRLNqWxMCpzOpTXCwW9A4Aj/+vB4Zcp8KEaFcnfuUk6UT
 huirk3v4y98zwTUL0alwHxgymiPLOb11GpCmIn9De25HU=

The Nuvoton WPCM450 SoC has a combined clock and reset controller.
Add a devicetree binding for it, as well as definitions for the bit
numbers used by it.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
=2D--
v10:
- no changes

v9:
- Remove clock-output-names in example, because it's now unnecessary due
  to driver improvements

v5-v8:
- no changes

v4:
- https://lore.kernel.org/lkml/20220610072141.347795-4-j.neuschaefer@gmx.n=
et/
- Add R-b tag

v3:
- Change clock-output-names and clock-names from "refclk" to "ref", sugges=
ted
  by Krzysztof Kozlowski

v2:
- https://lore.kernel.org/lkml/20220429172030.398011-5-j.neuschaefer@gmx.n=
et/
- Various improvements, suggested by Krzysztof Kozlowski

v1:
- https://lore.kernel.org/lkml/20220422183012.444674-5-j.neuschaefer@gmx.n=
et/
=2D--
 .../bindings/clock/nuvoton,wpcm450-clk.yaml   | 65 ++++++++++++++++++
 .../dt-bindings/clock/nuvoton,wpcm450-clk.h   | 67 +++++++++++++++++++
 2 files changed, 132 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,wpcm45=
0-clk.yaml
 create mode 100644 include/dt-bindings/clock/nuvoton,wpcm450-clk.h

diff --git a/Documentation/devicetree/bindings/clock/nuvoton,wpcm450-clk.y=
aml b/Documentation/devicetree/bindings/clock/nuvoton,wpcm450-clk.yaml
new file mode 100644
index 00000000000000..93521cf68a040f
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/clock/nuvoton,wpcm450-clk.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/nuvoton,wpcm450-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton WPCM450 clock controller
+
+maintainers:
+  - Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
+
+description:
+  The clock controller of the Nuvoton WPCM450 SoC supplies clocks and res=
ets to
+  the rest of the chip.
+
+properties:
+  compatible:
+    const: nuvoton,wpcm450-clk
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Reference clock oscillator (should be 48 MHz)
+
+  clock-names:
+    items:
+      - const: ref
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+examples:
+  - |
+    #include <dt-bindings/clock/nuvoton,wpcm450-clk.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    refclk: clock-48mhz {
+      /* 48 MHz reference oscillator */
+      compatible =3D "fixed-clock";
+      clock-frequency =3D <48000000>;
+      #clock-cells =3D <0>;
+    };
+
+    clk: clock-controller@b0000200 {
+      reg =3D <0xb0000200 0x100>;
+      compatible =3D "nuvoton,wpcm450-clk";
+      clocks =3D <&refclk>;
+      clock-names =3D "ref";
+      #clock-cells =3D <1>;
+      #reset-cells =3D <1>;
+    };
diff --git a/include/dt-bindings/clock/nuvoton,wpcm450-clk.h b/include/dt-=
bindings/clock/nuvoton,wpcm450-clk.h
new file mode 100644
index 00000000000000..86e1c895921b71
=2D-- /dev/null
+++ b/include/dt-bindings/clock/nuvoton,wpcm450-clk.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_CLOCK_NUVOTON_WPCM450_CLK_H
+#define _DT_BINDINGS_CLOCK_NUVOTON_WPCM450_CLK_H
+
+/* Clocks based on CLKEN bits */
+#define WPCM450_CLK_FIU            0
+#define WPCM450_CLK_XBUS           1
+#define WPCM450_CLK_KCS            2
+#define WPCM450_CLK_SHM            4
+#define WPCM450_CLK_USB1           5
+#define WPCM450_CLK_EMC0           6
+#define WPCM450_CLK_EMC1           7
+#define WPCM450_CLK_USB0           8
+#define WPCM450_CLK_PECI           9
+#define WPCM450_CLK_AES           10
+#define WPCM450_CLK_UART0         11
+#define WPCM450_CLK_UART1         12
+#define WPCM450_CLK_SMB2          13
+#define WPCM450_CLK_SMB3          14
+#define WPCM450_CLK_SMB4          15
+#define WPCM450_CLK_SMB5          16
+#define WPCM450_CLK_HUART         17
+#define WPCM450_CLK_PWM           18
+#define WPCM450_CLK_TIMER0        19
+#define WPCM450_CLK_TIMER1        20
+#define WPCM450_CLK_TIMER2        21
+#define WPCM450_CLK_TIMER3        22
+#define WPCM450_CLK_TIMER4        23
+#define WPCM450_CLK_MFT0          24
+#define WPCM450_CLK_MFT1          25
+#define WPCM450_CLK_WDT           26
+#define WPCM450_CLK_ADC           27
+#define WPCM450_CLK_SDIO          28
+#define WPCM450_CLK_SSPI          29
+#define WPCM450_CLK_SMB0          30
+#define WPCM450_CLK_SMB1          31
+
+/* Other clocks */
+#define WPCM450_CLK_USBPHY        32
+
+#define WPCM450_NUM_CLKS          33
+
+/* Resets based on IPSRST bits */
+#define WPCM450_RESET_FIU          0
+#define WPCM450_RESET_EMC0         6
+#define WPCM450_RESET_EMC1         7
+#define WPCM450_RESET_USB0         8
+#define WPCM450_RESET_USB1         9
+#define WPCM450_RESET_AES_PECI    10
+#define WPCM450_RESET_UART        11
+#define WPCM450_RESET_MC          12
+#define WPCM450_RESET_SMB2        13
+#define WPCM450_RESET_SMB3        14
+#define WPCM450_RESET_SMB4        15
+#define WPCM450_RESET_SMB5        16
+#define WPCM450_RESET_PWM         18
+#define WPCM450_RESET_TIMER       19
+#define WPCM450_RESET_ADC         27
+#define WPCM450_RESET_SDIO        28
+#define WPCM450_RESET_SSPI        29
+#define WPCM450_RESET_SMB0        30
+#define WPCM450_RESET_SMB1        31
+
+#define WPCM450_NUM_RESETS        32
+
+#endif /* _DT_BINDINGS_CLOCK_NUVOTON_WPCM450_CLK_H */
=2D-
2.43.0


