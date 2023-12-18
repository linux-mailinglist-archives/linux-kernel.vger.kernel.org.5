Return-Path: <linux-kernel+bounces-4074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E838177A0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F7A284DEB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8FD5BF83;
	Mon, 18 Dec 2023 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="V0eHPv02"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251B449894
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202312181636036a20d83194650ce91c
        for <linux-kernel@vger.kernel.org>;
        Mon, 18 Dec 2023 17:36:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=18MeOL0se+BZuGL7wj8aaSkn/7W0ooLxqBhqEfaWOXE=;
 b=V0eHPv02O3XqiLhuzOMi0SkKXj6rCDoZAUg9B7F17jFxVowqFPZbdcdjhtXegsRYMzlUpY
 P/XZeZ5HZLsuX7tCRbA2ofyzjnjtmkKSOnLvSiGCjPFek7DfO02Lfz0j6xdMh4azbdTTa+C1
 6oScTKXHEUPNbK0LLppo2wC34dhpI=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bao Cheng Su <baocheng.su@siemens.com>
Subject: [PATCH 3/4] arm64: dts: ti: iot2050: Factor out arduino connector bits
Date: Mon, 18 Dec 2023 17:35:59 +0100
Message-Id: <202d324ab0aa3728c8f846d31bedcbaba14aebdd.1702917360.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1702917360.git.jan.kiszka@siemens.com>
References: <cover.1702917360.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

A new variant is to be added which will not have a arduino connector
like the existing ones. Factor out all bits that are specific to this
connector.

The split is not perfect because wkup_gpio0 is defined based on what is
common to all variants having the connector, thus containing also
connector-unrelated information. But this is still cleaner than
replicating this node into all 4 variants.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../ti/k3-am65-iot2050-arduino-connector.dtsi | 768 ++++++++++++++++++
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 753 -----------------
 .../ti/k3-am6528-iot2050-basic-common.dtsi    |   1 +
 .../dts/ti/k3-am6548-iot2050-advanced-m2.dts  |   1 +
 .../dts/ti/k3-am6548-iot2050-advanced-pg2.dts |   1 +
 .../dts/ti/k3-am6548-iot2050-advanced.dts     |   1 +
 6 files changed, 772 insertions(+), 753 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-arduino-connector.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-arduino-connector.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-arduino-connector.dtsi
new file mode 100644
index 000000000000..cd86f412b837
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-arduino-connector.dtsi
@@ -0,0 +1,768 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Siemens AG, 2018-2023
+ *
+ * Authors:
+ *   Le Jin <le.jin@siemens.com>
+ *   Jan Kiszka <jan.kiszka@siemens.com>
+ *
+ * Common bits for IOT2050 variants with Arduino connector
+ */
+
+&wkup_pmx0 {
+	pinctrl-names =
+		"default",
+		"d0-uart0-rxd",  "d0-gpio",  "d0-gpio-pullup",  "d0-gpio-pulldown",
+		"d1-uart0-txd",  "d1-gpio",  "d1-gpio-pullup",  "d1-gpio-pulldown",
+		"d2-uart0-ctsn", "d2-gpio",  "d2-gpio-pullup",  "d2-gpio-pulldown",
+		"d3-uart0-rtsn", "d3-gpio",  "d3-gpio-pullup",  "d3-gpio-pulldown",
+		"d10-spi0-cs0",  "d10-gpio", "d10-gpio-pullup", "d10-gpio-pulldown",
+		"d11-spi0-d0",   "d11-gpio", "d11-gpio-pullup", "d11-gpio-pulldown",
+		"d12-spi0-d1",   "d12-gpio", "d12-gpio-pullup", "d12-gpio-pulldown",
+		"d13-spi0-clk",  "d13-gpio", "d13-gpio-pullup", "d13-gpio-pulldown",
+		"a0-gpio", "a0-gpio-pullup", "a0-gpio-pulldown",
+		"a1-gpio", "a1-gpio-pullup", "a1-gpio-pulldown",
+		"a2-gpio", "a2-gpio-pullup", "a2-gpio-pulldown",
+		"a3-gpio", "a3-gpio-pullup", "a3-gpio-pulldown",
+		"a4-gpio", "a4-gpio-pullup", "a4-gpio-pulldown",
+		"a5-gpio", "a5-gpio-pullup", "a5-gpio-pulldown";
+
+	pinctrl-0 = <&d0_uart0_rxd>;
+	pinctrl-1 = <&d0_uart0_rxd>;
+	pinctrl-2 = <&d0_gpio>;
+	pinctrl-3 = <&d0_gpio_pullup>;
+	pinctrl-4 = <&d0_gpio_pulldown>;
+	pinctrl-5 = <&d1_uart0_txd>;
+	pinctrl-6 = <&d1_gpio>;
+	pinctrl-7 = <&d1_gpio_pullup>;
+	pinctrl-8 = <&d1_gpio_pulldown>;
+	pinctrl-9 = <&d2_uart0_ctsn>;
+	pinctrl-10 = <&d2_gpio>;
+	pinctrl-11 = <&d2_gpio_pullup>;
+	pinctrl-12 = <&d2_gpio_pulldown>;
+	pinctrl-13 = <&d3_uart0_rtsn>;
+	pinctrl-14 = <&d3_gpio>;
+	pinctrl-15 = <&d3_gpio_pullup>;
+	pinctrl-16 = <&d3_gpio_pulldown>;
+	pinctrl-17 = <&d10_spi0_cs0>;
+	pinctrl-18 = <&d10_gpio>;
+	pinctrl-19 = <&d10_gpio_pullup>;
+	pinctrl-20 = <&d10_gpio_pulldown>;
+	pinctrl-21 = <&d11_spi0_d0>;
+	pinctrl-22 = <&d11_gpio>;
+	pinctrl-23 = <&d11_gpio_pullup>;
+	pinctrl-24 = <&d11_gpio_pulldown>;
+	pinctrl-25 = <&d12_spi0_d1>;
+	pinctrl-26 = <&d12_gpio>;
+	pinctrl-27 = <&d12_gpio_pullup>;
+	pinctrl-28 = <&d12_gpio_pulldown>;
+	pinctrl-29 = <&d13_spi0_clk>;
+	pinctrl-30 = <&d13_gpio>;
+	pinctrl-31 = <&d13_gpio_pullup>;
+	pinctrl-32 = <&d13_gpio_pulldown>;
+	pinctrl-33 = <&a0_gpio>;
+	pinctrl-34 = <&a0_gpio_pullup>;
+	pinctrl-35 = <&a0_gpio_pulldown>;
+	pinctrl-36 = <&a1_gpio>;
+	pinctrl-37 = <&a1_gpio_pullup>;
+	pinctrl-38 = <&a1_gpio_pulldown>;
+	pinctrl-39 = <&a2_gpio>;
+	pinctrl-40 = <&a2_gpio_pullup>;
+	pinctrl-41 = <&a2_gpio_pulldown>;
+	pinctrl-42 = <&a3_gpio>;
+	pinctrl-43 = <&a3_gpio_pullup>;
+	pinctrl-44 = <&a3_gpio_pulldown>;
+	pinctrl-45 = <&a4_gpio>;
+	pinctrl-46 = <&a4_gpio_pullup>;
+	pinctrl-47 = <&a4_gpio_pulldown>;
+	pinctrl-48 = <&a5_gpio>;
+	pinctrl-49 = <&a5_gpio_pullup>;
+	pinctrl-50 = <&a5_gpio_pulldown>;
+
+	d0_uart0_rxd: d0-uart0-rxd-pins {
+		pinctrl-single,pins = <
+			/* (P4) MCU_UART0_RXD */
+			AM65X_WKUP_IOPAD(0x0044, PIN_INPUT, 4)
+		>;
+	};
+
+	d0_gpio: d0-gpio-pins {
+		pinctrl-single,pins = <
+			/* (P4) WKUP_GPIO0_29 */
+			AM65X_WKUP_IOPAD(0x0044, PIN_INPUT, 7)
+		>;
+	};
+
+	d0_gpio_pullup: d0-gpio-pullup-pins {
+		pinctrl-single,pins = <
+			/* (P4) WKUP_GPIO0_29 */
+			AM65X_WKUP_IOPAD(0x0044, PIN_INPUT_PULLUP, 7)
+		>;
+	};
+
+	d0_gpio_pulldown: d0-gpio-pulldown-pins {
+		pinctrl-single,pins = <
+			/* (P4) WKUP_GPIO0_29 */
+			AM65X_WKUP_IOPAD(0x0044, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	d1_uart0_txd: d1-uart0-txd-pins {
+		pinctrl-single,pins = <
+			/* (P5) MCU_UART0_TXD */
+			AM65X_WKUP_IOPAD(0x0048, PIN_OUTPUT, 4)
+		>;
+	};
+
+	d1_gpio: d1-gpio-pins {
+		pinctrl-single,pins = <
+			/* (P5) WKUP_GPIO0_30 */
+			AM65X_WKUP_IOPAD(0x0048, PIN_INPUT, 7)
+		>;
+	};
+
+	d1_gpio_pullup: d1-gpio-pullup-pins {
+		pinctrl-single,pins = <
+			/* (P5) WKUP_GPIO0_30 */
+			AM65X_WKUP_IOPAD(0x0048, PIN_INPUT, 7)
+		>;
+	};
+
+	d1_gpio_pulldown: d1-gpio-pulldown-pins {
+		pinctrl-single,pins = <
+			/* (P5) WKUP_GPIO0_30 */
+			AM65X_WKUP_IOPAD(0x0048, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	d2_uart0_ctsn: d2-uart0-ctsn-pins {
+		pinctrl-single,pins = <
+			/* (P1) MCU_UART0_CTSn */
+			AM65X_WKUP_IOPAD(0x004C, PIN_INPUT, 4)
+		>;
+	};
+
+	d2_gpio: d2-gpio-pins {
+		pinctrl-single,pins = <
+			/* (P5) WKUP_GPIO0_31 */
+			AM65X_WKUP_IOPAD(0x004C, PIN_INPUT, 7)
+		>;
+	};
+
+	d2_gpio_pullup: d2-gpio-pullup-pins {
+		pinctrl-single,pins = <
+			/* (P5) WKUP_GPIO0_31 */
+			AM65X_WKUP_IOPAD(0x004C, PIN_INPUT, 7)
+		>;
+	};
+
+	d2_gpio_pulldown: d2-gpio-pulldown-pins {
+		pinctrl-single,pins = <
+			/* (P5) WKUP_GPIO0_31 */
+			AM65X_WKUP_IOPAD(0x004C, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	d3_uart0_rtsn: d3-uart0-rtsn-pins {
+		pinctrl-single,pins = <
+			/* (N3) MCU_UART0_RTSn */
+			AM65X_WKUP_IOPAD(0x0054, PIN_OUTPUT, 4)
+		>;
+	};
+
+	d3_gpio: d3-gpio-pins {
+		pinctrl-single,pins = <
+			/* (N3) WKUP_GPIO0_33 */
+			AM65X_WKUP_IOPAD(0x0054, PIN_INPUT, 7)
+		>;
+	};
+
+	d3_gpio_pullup: d3-gpio-pullup-pins {
+		pinctrl-single,pins = <
+			/* (N3) WKUP_GPIO0_33 */
+			AM65X_WKUP_IOPAD(0x0054, PIN_INPUT, 7)
+		>;
+	};
+
+	d3_gpio_pulldown: d3-gpio-pulldown-pins {
+		pinctrl-single,pins = <
+			/* (N3) WKUP_GPIO0_33 */
+			AM65X_WKUP_IOPAD(0x0054, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	d10_spi0_cs0: d10-spi0-cs0-pins {
+		pinctrl-single,pins = <
+			/* (Y4) MCU_SPI0_CS0 */
+			AM65X_WKUP_IOPAD(0x009c, PIN_OUTPUT, 0)
+		>;
+	};
+
+	d10_gpio: d10-gpio-pins {
+		pinctrl-single,pins = <
+			/* (Y4) WKUP_GPIO0_51 */
+			AM65X_WKUP_IOPAD(0x009c, PIN_INPUT, 7)
+		>;
+	};
+
+	d10_gpio_pullup: d10-gpio-pullup-pins {
+		pinctrl-single,pins = <
+			/* (Y4) WKUP_GPIO0_51 */
+			AM65X_WKUP_IOPAD(0x009c, PIN_INPUT, 7)
+		>;
+	};
+
+	d10_gpio_pulldown: d10-gpio-pulldown-pins {
+		pinctrl-single,pins = <
+			/* (Y4) WKUP_GPIO0_51 */
+			AM65X_WKUP_IOPAD(0x009c, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	d11_spi0_d0: d11-spi0-d0-pins {
+		pinctrl-single,pins = <
+			/* (Y3) MCU_SPI0_D0 */
+			AM65X_WKUP_IOPAD(0x0094, PIN_INPUT, 0)
+		>;
+	};
+
+	d11_gpio: d11-gpio-pins {
+		pinctrl-single,pins = <
+			/* (Y3) WKUP_GPIO0_49 */
+			AM65X_WKUP_IOPAD(0x0094, PIN_INPUT, 7)
+		>;
+	};
+
+	d11_gpio_pullup: d11-gpio-pullup-pins {
+		pinctrl-single,pins = <
+			/* (Y3) WKUP_GPIO0_49 */
+			AM65X_WKUP_IOPAD(0x0094, PIN_INPUT, 7)
+		>;
+	};
+
+	d11_gpio_pulldown: d11-gpio-pulldown-pins {
+		pinctrl-single,pins = <
+			/* (Y3) WKUP_GPIO0_49 */
+			AM65X_WKUP_IOPAD(0x0094, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	d12_spi0_d1: d12-spi0-d1-pins {
+		pinctrl-single,pins = <
+			/* (Y2) MCU_SPI0_D1 */
+			AM65X_WKUP_IOPAD(0x0098, PIN_INPUT, 0)
+		>;
+	};
+
+	d12_gpio: d12-gpio-pins {
+		pinctrl-single,pins = <
+			/* (Y2) WKUP_GPIO0_50 */
+			AM65X_WKUP_IOPAD(0x0098, PIN_INPUT, 7)
+		>;
+	};
+
+	d12_gpio_pullup: d12-gpio-pullup-pins {
+		pinctrl-single,pins = <
+			/* (Y2) WKUP_GPIO0_50 */
+			AM65X_WKUP_IOPAD(0x0098, PIN_INPUT, 7)
+		>;
+	};
+
+	d12_gpio_pulldown: d12-gpio-pulldown-pins {
+		pinctrl-single,pins = <
+			/* (Y2) WKUP_GPIO0_50 */
+			AM65X_WKUP_IOPAD(0x0098, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	d13_spi0_clk: d13-spi0-clk-pins {
+		pinctrl-single,pins = <
+			/* (Y1) MCU_SPI0_CLK */
+			AM65X_WKUP_IOPAD(0x0090, PIN_INPUT, 0)
+		>;
+	};
+
+	d13_gpio: d13-gpio-pins {
+		pinctrl-single,pins = <
+			/* (Y1) WKUP_GPIO0_48 */
+			AM65X_WKUP_IOPAD(0x0090, PIN_INPUT, 7)
+		>;
+	};
+
+	d13_gpio_pullup: d13-gpio-pullup-pins {
+		pinctrl-single,pins = <
+			/* (Y1) WKUP_GPIO0_48 */
+			AM65X_WKUP_IOPAD(0x0090, PIN_INPUT, 7)
+		>;
+	};
+
+	d13_gpio_pulldown: d13-gpio-pulldown-pins {
+		pinctrl-single,pins = <
+			/* (Y1) WKUP_GPIO0_48 */
+			AM65X_WKUP_IOPAD(0x0090, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	a0_gpio: a0-gpio-pins {
+		pinctrl-single,pins = <
+			/* (L6) WKUP_GPIO0_45 */
+			AM65X_WKUP_IOPAD(0x0084, PIN_INPUT, 7)
+		>;
+	};
+
+	a0_gpio_pullup: a0-gpio-pullup-pins {
+		pinctrl-single,pins = <
+			/* (L6) WKUP_GPIO0_45 */
+			AM65X_WKUP_IOPAD(0x0084, PIN_INPUT, 7)
+		>;
+	};
+
+	a0_gpio_pulldown: a0-gpio-pulldown-pins {
+		pinctrl-single,pins = <
+			/* (L6) WKUP_GPIO0_45 */
+			AM65X_WKUP_IOPAD(0x0084, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	a1_gpio: a1-gpio-pins {
+		pinctrl-single,pins = <
+			/* (M6) WKUP_GPIO0_44 */
+			AM65X_WKUP_IOPAD(0x0080, PIN_INPUT, 7)
+		>;
+	};
+
+	a1_gpio_pullup: a1-gpio-pullup-pins {
+		pinctrl-single,pins = <
+			/* (M6) WKUP_GPIO0_44 */
+			AM65X_WKUP_IOPAD(0x0080, PIN_INPUT, 7)
+		>;
+	};
+
+	a1_gpio_pulldown: a1-gpio-pulldown-pins {
+		pinctrl-single,pins = <
+			/* (M6) WKUP_GPIO0_44 */
+			AM65X_WKUP_IOPAD(0x0080, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	a2_gpio: a2-gpio-pins {
+		pinctrl-single,pins = <
+			/* (L5) WKUP_GPIO0_43 */
+			AM65X_WKUP_IOPAD(0x007C, PIN_INPUT, 7)
+		>;
+	};
+
+	a2_gpio_pullup: a2-gpio-pullup-pins {
+		pinctrl-single,pins = <
+			/* (L5) WKUP_GPIO0_43 */
+			AM65X_WKUP_IOPAD(0x007C, PIN_INPUT, 7)
+		>;
+	};
+
+	a2_gpio_pulldown: a2-gpio-pulldown-pins {
+		pinctrl-single,pins = <
+			/* (L5) WKUP_GPIO0_43 */
+			AM65X_WKUP_IOPAD(0x007C, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	a3_gpio: a3-gpio-pins {
+		pinctrl-single,pins = <
+			/* (M5) WKUP_GPIO0_39 */
+			AM65X_WKUP_IOPAD(0x006C, PIN_INPUT, 7)
+		>;
+	};
+
+	a3_gpio_pullup: a3-gpio-pullup-pins {
+		pinctrl-single,pins = <
+			/* (M5) WKUP_GPIO0_39 */
+			AM65X_WKUP_IOPAD(0x006C, PIN_INPUT, 7)
+		>;
+	};
+
+	a3_gpio_pulldown: a3-gpio-pulldown-pins {
+		pinctrl-single,pins = <
+			/* (M5) WKUP_GPIO0_39 */
+			AM65X_WKUP_IOPAD(0x006C, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	a4_gpio: a4-gpio-pins {
+		pinctrl-single,pins = <
+			/* (L2) WKUP_GPIO0_42 */
+			AM65X_WKUP_IOPAD(0x0078, PIN_INPUT, 7)
+		>;
+	};
+
+	a4_gpio_pullup: a4-gpio-pullup-pins {
+		pinctrl-single,pins = <
+			/* (L2) WKUP_GPIO0_42 */
+			AM65X_WKUP_IOPAD(0x0078, PIN_INPUT, 7)
+		>;
+	};
+
+	a4_gpio_pulldown: a4-gpio-pulldown-pins {
+		pinctrl-single,pins = <
+			/* (L2) WKUP_GPIO0_42 */
+			AM65X_WKUP_IOPAD(0x0078, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	a5_gpio: a5-gpio-pins {
+		pinctrl-single,pins = <
+			/* (N5) WKUP_GPIO0_35 */
+			AM65X_WKUP_IOPAD(0x005C, PIN_INPUT, 7)
+		>;
+	};
+
+	a5_gpio_pullup: a5-gpio-pullup-pins {
+		pinctrl-single,pins = <
+			/* (N5) WKUP_GPIO0_35 */
+			AM65X_WKUP_IOPAD(0x005C, PIN_INPUT_PULLUP, 7)
+		>;
+	};
+
+	a5_gpio_pulldown: a5-gpio-pulldown-pins {
+		pinctrl-single,pins = <
+			/* (N5) WKUP_GPIO0_35 */
+			AM65X_WKUP_IOPAD(0x005C, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
+		pinctrl-single,pins = <
+			/* (AC7) WKUP_I2C0_SCL */
+			AM65X_WKUP_IOPAD(0x00e0, PIN_INPUT,  0)
+			/* (AD6) WKUP_I2C0_SDA */
+			AM65X_WKUP_IOPAD(0x00e4, PIN_INPUT,  0)
+		>;
+	};
+
+	arduino_i2c_aio_switch_pins_default: arduino-i2c-aio-switch-default-pins {
+		pinctrl-single,pins = <
+			/* (R2) WKUP_GPIO0_21 */
+			AM65X_WKUP_IOPAD(0x0024, PIN_OUTPUT, 7)
+		>;
+	};
+
+	arduino_io_oe_pins_default: arduino-io-oe-default-pins {
+		pinctrl-single,pins = <
+			/* (N4) WKUP_GPIO0_34 */
+			AM65X_WKUP_IOPAD(0x0058, PIN_OUTPUT, 7)
+			/* (M2) WKUP_GPIO0_36 */
+			AM65X_WKUP_IOPAD(0x0060, PIN_OUTPUT, 7)
+			/* (M3) WKUP_GPIO0_37 */
+			AM65X_WKUP_IOPAD(0x0064, PIN_OUTPUT, 7)
+			/* (M4) WKUP_GPIO0_38 */
+			AM65X_WKUP_IOPAD(0x0068, PIN_OUTPUT, 7)
+			/* (M1) WKUP_GPIO0_41 */
+			AM65X_WKUP_IOPAD(0x0074, PIN_OUTPUT, 7)
+		>;
+	};
+};
+
+&main_pmx0 {
+	pinctrl-names =
+		"default",
+		"d4-ehrpwm0-a", "d4-gpio", "d4-gpio-pullup", "d4-gpio-pulldown",
+		"d5-ehrpwm1-a", "d5-gpio", "d5-gpio-pullup", "d5-gpio-pulldown",
+		"d6-ehrpwm2-a", "d6-gpio", "d6-gpio-pullup", "d6-gpio-pulldown",
+		"d7-ehrpwm3-a", "d7-gpio", "d7-gpio-pullup", "d7-gpio-pulldown",
+		"d8-ehrpwm4-a", "d8-gpio", "d8-gpio-pullup", "d8-gpio-pulldown",
+		"d9-ehrpwm5-a", "d9-gpio", "d9-gpio-pullup", "d9-gpio-pulldown";
+
+	pinctrl-0 = <&d4_ehrpwm0_a>;
+	pinctrl-1 = <&d4_ehrpwm0_a>;
+	pinctrl-2 = <&d4_gpio>;
+	pinctrl-3 = <&d4_gpio_pullup>;
+	pinctrl-4 = <&d4_gpio_pulldown>;
+
+	pinctrl-5 = <&d5_ehrpwm1_a>;
+	pinctrl-6 = <&d5_gpio>;
+	pinctrl-7 = <&d5_gpio_pullup>;
+	pinctrl-8 = <&d5_gpio_pulldown>;
+
+	pinctrl-9 = <&d6_ehrpwm2_a>;
+	pinctrl-10 = <&d6_gpio>;
+	pinctrl-11 = <&d6_gpio_pullup>;
+	pinctrl-12 = <&d6_gpio_pulldown>;
+
+	pinctrl-13 = <&d7_ehrpwm3_a>;
+	pinctrl-14 = <&d7_gpio>;
+	pinctrl-15 = <&d7_gpio_pullup>;
+	pinctrl-16 = <&d7_gpio_pulldown>;
+
+	pinctrl-17 = <&d8_ehrpwm4_a>;
+	pinctrl-18 = <&d8_gpio>;
+	pinctrl-19 = <&d8_gpio_pullup>;
+	pinctrl-20 = <&d8_gpio_pulldown>;
+
+	pinctrl-21 = <&d9_ehrpwm5_a>;
+	pinctrl-22 = <&d9_gpio>;
+	pinctrl-23 = <&d9_gpio_pullup>;
+	pinctrl-24 = <&d9_gpio_pulldown>;
+
+	d4_ehrpwm0_a: d4-ehrpwm0-a-pins {
+		pinctrl-single,pins = <
+			/* (AG18) EHRPWM0_A */
+			AM65X_IOPAD(0x0084, PIN_OUTPUT, 5)
+		>;
+	};
+
+	d4_gpio: d4-gpio-pins {
+		pinctrl-single,pins = <
+			/* (AG18) GPIO0_33 */
+			AM65X_IOPAD(0x0084, PIN_INPUT, 7)
+		>;
+	};
+
+	d4_gpio_pullup: d4-gpio-pullup-pins {
+		pinctrl-single,pins = <
+			/* (AG18) GPIO0_33 */
+			AM65X_IOPAD(0x0084, PIN_INPUT_PULLUP, 7)
+		>;
+	};
+
+	d4_gpio_pulldown: d4-gpio-pulldown-pins {
+		pinctrl-single,pins = <
+			/* (AG18) GPIO0_33 */
+			AM65X_IOPAD(0x0084, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	d5_ehrpwm1_a: d5-ehrpwm1-a-pins {
+		pinctrl-single,pins = <
+			/* (AF17) EHRPWM1_A */
+			AM65X_IOPAD(0x008C, PIN_OUTPUT, 5)
+		>;
+	};
+
+	d5_gpio: d5-gpio-pins {
+		pinctrl-single,pins = <
+			/* (AF17) GPIO0_35 */
+			AM65X_IOPAD(0x008C, PIN_INPUT, 7)
+		>;
+	};
+
+	d5_gpio_pullup: d5-gpio-pullup-pins {
+		pinctrl-single,pins = <
+			/* (AF17) GPIO0_35 */
+			AM65X_IOPAD(0x008C, PIN_INPUT_PULLUP, 7)
+		>;
+	};
+
+	d5_gpio_pulldown: d5-gpio-pulldown-pins {
+		pinctrl-single,pins = <
+			/* (AF17) GPIO0_35 */
+			AM65X_IOPAD(0x008C, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	d6_ehrpwm2_a: d6-ehrpwm2-a-pins {
+		pinctrl-single,pins = <
+			/* (AH16) EHRPWM2_A */
+			AM65X_IOPAD(0x0098, PIN_OUTPUT, 5)
+		>;
+	};
+
+	d6_gpio: d6-gpio-pins {
+		pinctrl-single,pins = <
+			/* (AH16) GPIO0_38 */
+			AM65X_IOPAD(0x0098, PIN_INPUT, 7)
+		>;
+	};
+
+	d6_gpio_pullup: d6-gpio-pullup-pins {
+		pinctrl-single,pins = <
+			/* (AH16) GPIO0_38 */
+			AM65X_IOPAD(0x0098, PIN_INPUT_PULLUP, 7)
+		>;
+	};
+
+	d6_gpio_pulldown: d6-gpio-pulldown-pins {
+		pinctrl-single,pins = <
+			/* (AH16) GPIO0_38 */
+			AM65X_IOPAD(0x0098, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	d7_ehrpwm3_a: d7-ehrpwm3-a-pins {
+		pinctrl-single,pins = <
+			/* (AH15) EHRPWM3_A */
+			AM65X_IOPAD(0x00AC, PIN_OUTPUT, 5)
+		>;
+	};
+
+	d7_gpio: d7-gpio-pins {
+		pinctrl-single,pins = <
+			/* (AH15) GPIO0_43 */
+			AM65X_IOPAD(0x00AC, PIN_INPUT, 7)
+		>;
+	};
+
+	d7_gpio_pullup: d7-gpio-pullup-pins {
+		pinctrl-single,pins = <
+			/* (AH15) GPIO0_43 */
+			AM65X_IOPAD(0x00AC, PIN_INPUT_PULLUP, 7)
+		>;
+	};
+
+	d7_gpio_pulldown: d7-gpio-pulldown-pins {
+		pinctrl-single,pins = <
+			/* (AH15) GPIO0_43 */
+			AM65X_IOPAD(0x00AC, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	d8_ehrpwm4_a: d8-ehrpwm4-a-pins {
+		pinctrl-single,pins = <
+			/* (AG15) EHRPWM4_A */
+			AM65X_IOPAD(0x00C0, PIN_OUTPUT, 5)
+		>;
+	};
+
+	d8_gpio: d8-gpio-pins {
+		pinctrl-single,pins = <
+			/* (AG15) GPIO0_48 */
+			AM65X_IOPAD(0x00C0, PIN_INPUT, 7)
+		>;
+	};
+
+	d8_gpio_pullup: d8-gpio-pullup-pins {
+		pinctrl-single,pins = <
+			/* (AG15) GPIO0_48 */
+			AM65X_IOPAD(0x00C0, PIN_INPUT_PULLUP, 7)
+		>;
+	};
+
+	d8_gpio_pulldown: d8-gpio-pulldown-pins {
+		pinctrl-single,pins = <
+			/* (AG15) GPIO0_48 */
+			AM65X_IOPAD(0x00C0, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	d9_ehrpwm5_a: d9-ehrpwm5-a-pins {
+		pinctrl-single,pins = <
+			/* (AD15) EHRPWM5_A */
+			AM65X_IOPAD(0x00CC, PIN_OUTPUT, 5)
+		>;
+	};
+
+	d9_gpio: d9-gpio-pins {
+		pinctrl-single,pins = <
+			/* (AD15) GPIO0_51 */
+			AM65X_IOPAD(0x00CC, PIN_INPUT, 7)
+		>;
+	};
+
+	d9_gpio_pullup: d9-gpio-pullup-pins {
+		pinctrl-single,pins = <
+			/* (AD15) GPIO0_51 */
+			AM65X_IOPAD(0x00CC, PIN_INPUT_PULLUP, 7)
+		>;
+	};
+
+	d9_gpio_pulldown: d9-gpio-pulldown-pins {
+		pinctrl-single,pins = <
+			/* (AD15) GPIO0_51 */
+			AM65X_IOPAD(0x00CC, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+};
+
+&main_gpio0 {
+	gpio-line-names =
+		"main_gpio0-base", "", "", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "", "", "",
+		"", "", "", "IO4", "", "IO5", "", "", "IO6", "",
+		"", "", "", "IO7", "", "", "", "", "IO8", "",
+		"", "IO9";
+};
+
+&wkup_gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 =
+		<&arduino_i2c_aio_switch_pins_default>,
+		<&arduino_io_oe_pins_default>,
+		<&push_button_pins_default>,
+		<&db9_com_mode_pins_default>;
+	gpio-line-names =
+		/* 0..9 */
+		"wkup_gpio0-base", "", "", "", "UART0-mode1", "UART0-mode0",
+		"UART0-enable", "UART0-terminate", "", "WIFI-disable",
+		/* 10..19 */
+		"", "", "", "", "", "", "", "", "", "",
+		/* 20..29 */
+		"", "A4A5-I2C-mux", "", "", "", "USER-button", "", "", "","IO0",
+		/* 30..39 */
+		"IO1", "IO2", "", "IO3", "IO17-direction", "A5",
+		"IO16-direction", "IO15-direction", "IO14-direction", "A3",
+		/* 40..49 */
+		"", "IO18-direction", "A4", "A2", "A1", "A0", "", "", "IO13",
+		"IO11",
+		/* 50..51 */
+		"IO12", "IO10";
+};
+
+&wkup_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_i2c0_pins_default>;
+	clock-frequency = <400000>;
+};
+
+&mcu_i2c0 {
+	/* D4200 */
+	pcal9535_1: gpio@20 {
+		compatible = "nxp,pcal9535";
+		reg = <0x20>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-line-names =
+			"A0-pull", "A1-pull", "A2-pull", "A3-pull", "A4-pull",
+			"A5-pull", "", "",
+			"IO14-enable", "IO15-enable", "IO16-enable",
+			"IO17-enable", "IO18-enable", "IO19-enable";
+	};
+
+	/* D4201 */
+	pcal9535_2: gpio@21 {
+		compatible = "nxp,pcal9535";
+		reg = <0x21>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-line-names =
+			"IO0-direction", "IO1-direction", "IO2-direction",
+			"IO3-direction", "IO4-direction", "IO5-direction",
+			"IO6-direction", "IO7-direction",
+			"IO8-direction", "IO9-direction", "IO10-direction",
+			"IO11-direction", "IO12-direction", "IO13-direction",
+			"IO19-direction";
+	};
+
+	/* D4202 */
+	pcal9535_3: gpio@25 {
+		compatible = "nxp,pcal9535";
+		reg = <0x25>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-line-names =
+			"IO0-pull", "IO1-pull", "IO2-pull", "IO3-pull",
+			"IO4-pull", "IO5-pull", "IO6-pull", "IO7-pull",
+			"IO8-pull", "IO9-pull", "IO10-pull", "IO11-pull",
+			"IO12-pull", "IO13-pull";
+	};
+};
+
+&mcu_uart0 {
+	status = "okay";
+};
+
+&tscadc1 {
+	status = "okay";
+	adc {
+		ti,adc-channels = <0 1 2 3 4 5>;
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index ab1dffa5c1c6..402afa4bc1b6 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -187,434 +187,6 @@ icssg0_emac1: port@1 {
 };
 
 &wkup_pmx0 {
-	pinctrl-names =
-		"default",
-		"d0-uart0-rxd",  "d0-gpio",  "d0-gpio-pullup",  "d0-gpio-pulldown",
-		"d1-uart0-txd",  "d1-gpio",  "d1-gpio-pullup",  "d1-gpio-pulldown",
-		"d2-uart0-ctsn", "d2-gpio",  "d2-gpio-pullup",  "d2-gpio-pulldown",
-		"d3-uart0-rtsn", "d3-gpio",  "d3-gpio-pullup",  "d3-gpio-pulldown",
-		"d10-spi0-cs0",  "d10-gpio", "d10-gpio-pullup", "d10-gpio-pulldown",
-		"d11-spi0-d0",   "d11-gpio", "d11-gpio-pullup", "d11-gpio-pulldown",
-		"d12-spi0-d1",   "d12-gpio", "d12-gpio-pullup", "d12-gpio-pulldown",
-		"d13-spi0-clk",  "d13-gpio", "d13-gpio-pullup", "d13-gpio-pulldown",
-		"a0-gpio", "a0-gpio-pullup", "a0-gpio-pulldown",
-		"a1-gpio", "a1-gpio-pullup", "a1-gpio-pulldown",
-		"a2-gpio", "a2-gpio-pullup", "a2-gpio-pulldown",
-		"a3-gpio", "a3-gpio-pullup", "a3-gpio-pulldown",
-		"a4-gpio", "a4-gpio-pullup", "a4-gpio-pulldown",
-		"a5-gpio", "a5-gpio-pullup", "a5-gpio-pulldown";
-
-	pinctrl-0 = <&d0_uart0_rxd>;
-	pinctrl-1 = <&d0_uart0_rxd>;
-	pinctrl-2 = <&d0_gpio>;
-	pinctrl-3 = <&d0_gpio_pullup>;
-	pinctrl-4 = <&d0_gpio_pulldown>;
-	pinctrl-5 = <&d1_uart0_txd>;
-	pinctrl-6 = <&d1_gpio>;
-	pinctrl-7 = <&d1_gpio_pullup>;
-	pinctrl-8 = <&d1_gpio_pulldown>;
-	pinctrl-9 = <&d2_uart0_ctsn>;
-	pinctrl-10 = <&d2_gpio>;
-	pinctrl-11 = <&d2_gpio_pullup>;
-	pinctrl-12 = <&d2_gpio_pulldown>;
-	pinctrl-13 = <&d3_uart0_rtsn>;
-	pinctrl-14 = <&d3_gpio>;
-	pinctrl-15 = <&d3_gpio_pullup>;
-	pinctrl-16 = <&d3_gpio_pulldown>;
-	pinctrl-17 = <&d10_spi0_cs0>;
-	pinctrl-18 = <&d10_gpio>;
-	pinctrl-19 = <&d10_gpio_pullup>;
-	pinctrl-20 = <&d10_gpio_pulldown>;
-	pinctrl-21 = <&d11_spi0_d0>;
-	pinctrl-22 = <&d11_gpio>;
-	pinctrl-23 = <&d11_gpio_pullup>;
-	pinctrl-24 = <&d11_gpio_pulldown>;
-	pinctrl-25 = <&d12_spi0_d1>;
-	pinctrl-26 = <&d12_gpio>;
-	pinctrl-27 = <&d12_gpio_pullup>;
-	pinctrl-28 = <&d12_gpio_pulldown>;
-	pinctrl-29 = <&d13_spi0_clk>;
-	pinctrl-30 = <&d13_gpio>;
-	pinctrl-31 = <&d13_gpio_pullup>;
-	pinctrl-32 = <&d13_gpio_pulldown>;
-	pinctrl-33 = <&a0_gpio>;
-	pinctrl-34 = <&a0_gpio_pullup>;
-	pinctrl-35 = <&a0_gpio_pulldown>;
-	pinctrl-36 = <&a1_gpio>;
-	pinctrl-37 = <&a1_gpio_pullup>;
-	pinctrl-38 = <&a1_gpio_pulldown>;
-	pinctrl-39 = <&a2_gpio>;
-	pinctrl-40 = <&a2_gpio_pullup>;
-	pinctrl-41 = <&a2_gpio_pulldown>;
-	pinctrl-42 = <&a3_gpio>;
-	pinctrl-43 = <&a3_gpio_pullup>;
-	pinctrl-44 = <&a3_gpio_pulldown>;
-	pinctrl-45 = <&a4_gpio>;
-	pinctrl-46 = <&a4_gpio_pullup>;
-	pinctrl-47 = <&a4_gpio_pulldown>;
-	pinctrl-48 = <&a5_gpio>;
-	pinctrl-49 = <&a5_gpio_pullup>;
-	pinctrl-50 = <&a5_gpio_pulldown>;
-
-	d0_uart0_rxd: d0-uart0-rxd-pins {
-		pinctrl-single,pins = <
-			/* (P4) MCU_UART0_RXD */
-			AM65X_WKUP_IOPAD(0x0044, PIN_INPUT, 4)
-		>;
-	};
-
-	d0_gpio: d0-gpio-pins {
-		pinctrl-single,pins = <
-			/* (P4) WKUP_GPIO0_29 */
-			AM65X_WKUP_IOPAD(0x0044, PIN_INPUT, 7)
-		>;
-	};
-
-	d0_gpio_pullup: d0-gpio-pullup-pins {
-		pinctrl-single,pins = <
-			/* (P4) WKUP_GPIO0_29 */
-			AM65X_WKUP_IOPAD(0x0044, PIN_INPUT_PULLUP, 7)
-		>;
-	};
-
-	d0_gpio_pulldown: d0-gpio-pulldown-pins {
-		pinctrl-single,pins = <
-			/* (P4) WKUP_GPIO0_29 */
-			AM65X_WKUP_IOPAD(0x0044, PIN_INPUT_PULLDOWN, 7)
-		>;
-	};
-
-	d1_uart0_txd: d1-uart0-txd-pins {
-		pinctrl-single,pins = <
-			/* (P5) MCU_UART0_TXD */
-			AM65X_WKUP_IOPAD(0x0048, PIN_OUTPUT, 4)
-		>;
-	};
-
-	d1_gpio: d1-gpio-pins {
-		pinctrl-single,pins = <
-			/* (P5) WKUP_GPIO0_30 */
-			AM65X_WKUP_IOPAD(0x0048, PIN_INPUT, 7)
-		>;
-	};
-
-	d1_gpio_pullup: d1-gpio-pullup-pins {
-		pinctrl-single,pins = <
-			/* (P5) WKUP_GPIO0_30 */
-			AM65X_WKUP_IOPAD(0x0048, PIN_INPUT, 7)
-		>;
-	};
-
-	d1_gpio_pulldown: d1-gpio-pulldown-pins {
-		pinctrl-single,pins = <
-			/* (P5) WKUP_GPIO0_30 */
-			AM65X_WKUP_IOPAD(0x0048, PIN_INPUT_PULLDOWN, 7)
-		>;
-	};
-
-	d2_uart0_ctsn: d2-uart0-ctsn-pins {
-		pinctrl-single,pins = <
-			/* (P1) MCU_UART0_CTSn */
-			AM65X_WKUP_IOPAD(0x004C, PIN_INPUT, 4)
-		>;
-	};
-
-	d2_gpio: d2-gpio-pins {
-		pinctrl-single,pins = <
-			/* (P5) WKUP_GPIO0_31 */
-			AM65X_WKUP_IOPAD(0x004C, PIN_INPUT, 7)
-		>;
-	};
-
-	d2_gpio_pullup: d2-gpio-pullup-pins {
-		pinctrl-single,pins = <
-			/* (P5) WKUP_GPIO0_31 */
-			AM65X_WKUP_IOPAD(0x004C, PIN_INPUT, 7)
-		>;
-	};
-
-	d2_gpio_pulldown: d2-gpio-pulldown-pins {
-		pinctrl-single,pins = <
-			/* (P5) WKUP_GPIO0_31 */
-			AM65X_WKUP_IOPAD(0x004C, PIN_INPUT_PULLDOWN, 7)
-		>;
-	};
-
-	d3_uart0_rtsn: d3-uart0-rtsn-pins {
-		pinctrl-single,pins = <
-			/* (N3) MCU_UART0_RTSn */
-			AM65X_WKUP_IOPAD(0x0054, PIN_OUTPUT, 4)
-		>;
-	};
-
-	d3_gpio: d3-gpio-pins {
-		pinctrl-single,pins = <
-			/* (N3) WKUP_GPIO0_33 */
-			AM65X_WKUP_IOPAD(0x0054, PIN_INPUT, 7)
-		>;
-	};
-
-	d3_gpio_pullup: d3-gpio-pullup-pins {
-		pinctrl-single,pins = <
-			/* (N3) WKUP_GPIO0_33 */
-			AM65X_WKUP_IOPAD(0x0054, PIN_INPUT, 7)
-		>;
-	};
-
-	d3_gpio_pulldown: d3-gpio-pulldown-pins {
-		pinctrl-single,pins = <
-			/* (N3) WKUP_GPIO0_33 */
-			AM65X_WKUP_IOPAD(0x0054, PIN_INPUT_PULLDOWN, 7)
-		>;
-	};
-
-	d10_spi0_cs0: d10-spi0-cs0-pins {
-		pinctrl-single,pins = <
-			/* (Y4) MCU_SPI0_CS0 */
-			AM65X_WKUP_IOPAD(0x009c, PIN_OUTPUT, 0)
-		>;
-	};
-
-	d10_gpio: d10-gpio-pins {
-		pinctrl-single,pins = <
-			/* (Y4) WKUP_GPIO0_51 */
-			AM65X_WKUP_IOPAD(0x009c, PIN_INPUT, 7)
-		>;
-	};
-
-	d10_gpio_pullup: d10-gpio-pullup-pins {
-		pinctrl-single,pins = <
-			/* (Y4) WKUP_GPIO0_51 */
-			AM65X_WKUP_IOPAD(0x009c, PIN_INPUT, 7)
-		>;
-	};
-
-	d10_gpio_pulldown: d10-gpio-pulldown-pins {
-		pinctrl-single,pins = <
-			/* (Y4) WKUP_GPIO0_51 */
-			AM65X_WKUP_IOPAD(0x009c, PIN_INPUT_PULLDOWN, 7)
-		>;
-	};
-
-	d11_spi0_d0: d11-spi0-d0-pins {
-		pinctrl-single,pins = <
-			/* (Y3) MCU_SPI0_D0 */
-			AM65X_WKUP_IOPAD(0x0094, PIN_INPUT, 0)
-		>;
-	};
-
-	d11_gpio: d11-gpio-pins {
-		pinctrl-single,pins = <
-			/* (Y3) WKUP_GPIO0_49 */
-			AM65X_WKUP_IOPAD(0x0094, PIN_INPUT, 7)
-		>;
-	};
-
-	d11_gpio_pullup: d11-gpio-pullup-pins {
-		pinctrl-single,pins = <
-			/* (Y3) WKUP_GPIO0_49 */
-			AM65X_WKUP_IOPAD(0x0094, PIN_INPUT, 7)
-		>;
-	};
-
-	d11_gpio_pulldown: d11-gpio-pulldown-pins {
-		pinctrl-single,pins = <
-			/* (Y3) WKUP_GPIO0_49 */
-			AM65X_WKUP_IOPAD(0x0094, PIN_INPUT_PULLDOWN, 7)
-		>;
-	};
-
-	d12_spi0_d1: d12-spi0-d1-pins {
-		pinctrl-single,pins = <
-			/* (Y2) MCU_SPI0_D1 */
-			AM65X_WKUP_IOPAD(0x0098, PIN_INPUT, 0)
-		>;
-	};
-
-	d12_gpio: d12-gpio-pins {
-		pinctrl-single,pins = <
-			/* (Y2) WKUP_GPIO0_50 */
-			AM65X_WKUP_IOPAD(0x0098, PIN_INPUT, 7)
-		>;
-	};
-
-	d12_gpio_pullup: d12-gpio-pullup-pins {
-		pinctrl-single,pins = <
-			/* (Y2) WKUP_GPIO0_50 */
-			AM65X_WKUP_IOPAD(0x0098, PIN_INPUT, 7)
-		>;
-	};
-
-	d12_gpio_pulldown: d12-gpio-pulldown-pins {
-		pinctrl-single,pins = <
-			/* (Y2) WKUP_GPIO0_50 */
-			AM65X_WKUP_IOPAD(0x0098, PIN_INPUT_PULLDOWN, 7)
-		>;
-	};
-
-	d13_spi0_clk: d13-spi0-clk-pins {
-		pinctrl-single,pins = <
-			/* (Y1) MCU_SPI0_CLK */
-			AM65X_WKUP_IOPAD(0x0090, PIN_INPUT, 0)
-		>;
-	};
-
-	d13_gpio: d13-gpio-pins {
-		pinctrl-single,pins = <
-			/* (Y1) WKUP_GPIO0_48 */
-			AM65X_WKUP_IOPAD(0x0090, PIN_INPUT, 7)
-		>;
-	};
-
-	d13_gpio_pullup: d13-gpio-pullup-pins {
-		pinctrl-single,pins = <
-			/* (Y1) WKUP_GPIO0_48 */
-			AM65X_WKUP_IOPAD(0x0090, PIN_INPUT, 7)
-		>;
-	};
-
-	d13_gpio_pulldown: d13-gpio-pulldown-pins {
-		pinctrl-single,pins = <
-			/* (Y1) WKUP_GPIO0_48 */
-			AM65X_WKUP_IOPAD(0x0090, PIN_INPUT_PULLDOWN, 7)
-		>;
-	};
-
-	a0_gpio: a0-gpio-pins {
-		pinctrl-single,pins = <
-			/* (L6) WKUP_GPIO0_45 */
-			AM65X_WKUP_IOPAD(0x0084, PIN_INPUT, 7)
-		>;
-	};
-
-	a0_gpio_pullup: a0-gpio-pullup-pins {
-		pinctrl-single,pins = <
-			/* (L6) WKUP_GPIO0_45 */
-			AM65X_WKUP_IOPAD(0x0084, PIN_INPUT, 7)
-		>;
-	};
-
-	a0_gpio_pulldown: a0-gpio-pulldown-pins {
-		pinctrl-single,pins = <
-			/* (L6) WKUP_GPIO0_45 */
-			AM65X_WKUP_IOPAD(0x0084, PIN_INPUT_PULLDOWN, 7)
-		>;
-	};
-
-	a1_gpio: a1-gpio-pins {
-		pinctrl-single,pins = <
-			/* (M6) WKUP_GPIO0_44 */
-			AM65X_WKUP_IOPAD(0x0080, PIN_INPUT, 7)
-		>;
-	};
-
-	a1_gpio_pullup: a1-gpio-pullup-pins {
-		pinctrl-single,pins = <
-			/* (M6) WKUP_GPIO0_44 */
-			AM65X_WKUP_IOPAD(0x0080, PIN_INPUT, 7)
-		>;
-	};
-
-	a1_gpio_pulldown: a1-gpio-pulldown-pins {
-		pinctrl-single,pins = <
-			/* (M6) WKUP_GPIO0_44 */
-			AM65X_WKUP_IOPAD(0x0080, PIN_INPUT_PULLDOWN, 7)
-		>;
-	};
-
-	a2_gpio: a2-gpio-pins {
-		pinctrl-single,pins = <
-			/* (L5) WKUP_GPIO0_43 */
-			AM65X_WKUP_IOPAD(0x007C, PIN_INPUT, 7)
-		>;
-	};
-
-	a2_gpio_pullup: a2-gpio-pullup-pins {
-		pinctrl-single,pins = <
-			/* (L5) WKUP_GPIO0_43 */
-			AM65X_WKUP_IOPAD(0x007C, PIN_INPUT, 7)
-		>;
-	};
-
-	a2_gpio_pulldown: a2-gpio-pulldown-pins {
-		pinctrl-single,pins = <
-			/* (L5) WKUP_GPIO0_43 */
-			AM65X_WKUP_IOPAD(0x007C, PIN_INPUT_PULLDOWN, 7)
-		>;
-	};
-
-	a3_gpio: a3-gpio-pins {
-		pinctrl-single,pins = <
-			/* (M5) WKUP_GPIO0_39 */
-			AM65X_WKUP_IOPAD(0x006C, PIN_INPUT, 7)
-		>;
-	};
-
-	a3_gpio_pullup: a3-gpio-pullup-pins {
-		pinctrl-single,pins = <
-			/* (M5) WKUP_GPIO0_39 */
-			AM65X_WKUP_IOPAD(0x006C, PIN_INPUT, 7)
-		>;
-	};
-
-	a3_gpio_pulldown: a3-gpio-pulldown-pins {
-		pinctrl-single,pins = <
-			/* (M5) WKUP_GPIO0_39 */
-			AM65X_WKUP_IOPAD(0x006C, PIN_INPUT_PULLDOWN, 7)
-		>;
-	};
-
-	a4_gpio: a4-gpio-pins {
-		pinctrl-single,pins = <
-			/* (L2) WKUP_GPIO0_42 */
-			AM65X_WKUP_IOPAD(0x0078, PIN_INPUT, 7)
-		>;
-	};
-
-	a4_gpio_pullup: a4-gpio-pullup-pins {
-		pinctrl-single,pins = <
-			/* (L2) WKUP_GPIO0_42 */
-			AM65X_WKUP_IOPAD(0x0078, PIN_INPUT, 7)
-		>;
-	};
-
-	a4_gpio_pulldown: a4-gpio-pulldown-pins {
-		pinctrl-single,pins = <
-			/* (L2) WKUP_GPIO0_42 */
-			AM65X_WKUP_IOPAD(0x0078, PIN_INPUT_PULLDOWN, 7)
-		>;
-	};
-
-	a5_gpio: a5-gpio-pins {
-		pinctrl-single,pins = <
-			/* (N5) WKUP_GPIO0_35 */
-			AM65X_WKUP_IOPAD(0x005C, PIN_INPUT, 7)
-		>;
-	};
-
-	a5_gpio_pullup: a5-gpio-pullup-pins {
-		pinctrl-single,pins = <
-			/* (N5) WKUP_GPIO0_35 */
-			AM65X_WKUP_IOPAD(0x005C, PIN_INPUT_PULLUP, 7)
-		>;
-	};
-
-	a5_gpio_pulldown: a5-gpio-pulldown-pins {
-		pinctrl-single,pins = <
-			/* (N5) WKUP_GPIO0_35 */
-			AM65X_WKUP_IOPAD(0x005C, PIN_INPUT_PULLDOWN, 7)
-		>;
-	};
-
-	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
-		pinctrl-single,pins = <
-			/* (AC7) WKUP_I2C0_SCL */
-			AM65X_WKUP_IOPAD(0x00e0, PIN_INPUT,  0)
-			/* (AD6) WKUP_I2C0_SDA */
-			AM65X_WKUP_IOPAD(0x00e4, PIN_INPUT,  0)
-		>;
-	};
-
 	mcu_i2c0_pins_default: mcu-i2c0-default-pins {
 		pinctrl-single,pins = <
 			/* (AD8) MCU_I2C0_SCL */
@@ -624,13 +196,6 @@ AM65X_WKUP_IOPAD(0x00ec, PIN_INPUT,  0)
 		>;
 	};
 
-	arduino_i2c_aio_switch_pins_default: arduino-i2c-aio-switch-default-pins {
-		pinctrl-single,pins = <
-			/* (R2) WKUP_GPIO0_21 */
-			AM65X_WKUP_IOPAD(0x0024, PIN_OUTPUT, 7)
-		>;
-	};
-
 	push_button_pins_default: push-button-default-pins {
 		pinctrl-single,pins = <
 			/* (T1) MCU_OSPI1_CLK.WKUP_GPIO0_25 */
@@ -638,22 +203,6 @@ AM65X_WKUP_IOPAD(0x0034, PIN_INPUT,  7)
 		>;
 	};
 
-
-	arduino_io_oe_pins_default: arduino-io-oe-default-pins {
-		pinctrl-single,pins = <
-			/* (N4) WKUP_GPIO0_34 */
-			AM65X_WKUP_IOPAD(0x0058, PIN_OUTPUT, 7)
-			/* (M2) WKUP_GPIO0_36 */
-			AM65X_WKUP_IOPAD(0x0060, PIN_OUTPUT, 7)
-			/* (M3) WKUP_GPIO0_37 */
-			AM65X_WKUP_IOPAD(0x0064, PIN_OUTPUT, 7)
-			/* (M4) WKUP_GPIO0_38 */
-			AM65X_WKUP_IOPAD(0x0068, PIN_OUTPUT, 7)
-			/* (M1) WKUP_GPIO0_41 */
-			AM65X_WKUP_IOPAD(0x0074, PIN_OUTPUT, 7)
-		>;
-	};
-
 	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
 		pinctrl-single,pins = <
 			/* (V1) MCU_OSPI0_CLK */
@@ -717,214 +266,6 @@ AM65X_WKUP_IOPAD(0x003C, PIN_OUTPUT, 7)
 };
 
 &main_pmx0 {
-	pinctrl-names =
-		"default",
-		"d4-ehrpwm0-a", "d4-gpio", "d4-gpio-pullup", "d4-gpio-pulldown",
-		"d5-ehrpwm1-a", "d5-gpio", "d5-gpio-pullup", "d5-gpio-pulldown",
-		"d6-ehrpwm2-a", "d6-gpio", "d6-gpio-pullup", "d6-gpio-pulldown",
-		"d7-ehrpwm3-a", "d7-gpio", "d7-gpio-pullup", "d7-gpio-pulldown",
-		"d8-ehrpwm4-a", "d8-gpio", "d8-gpio-pullup", "d8-gpio-pulldown",
-		"d9-ehrpwm5-a", "d9-gpio", "d9-gpio-pullup", "d9-gpio-pulldown";
-
-	pinctrl-0 = <&d4_ehrpwm0_a>;
-	pinctrl-1 = <&d4_ehrpwm0_a>;
-	pinctrl-2 = <&d4_gpio>;
-	pinctrl-3 = <&d4_gpio_pullup>;
-	pinctrl-4 = <&d4_gpio_pulldown>;
-
-	pinctrl-5 = <&d5_ehrpwm1_a>;
-	pinctrl-6 = <&d5_gpio>;
-	pinctrl-7 = <&d5_gpio_pullup>;
-	pinctrl-8 = <&d5_gpio_pulldown>;
-
-	pinctrl-9 = <&d6_ehrpwm2_a>;
-	pinctrl-10 = <&d6_gpio>;
-	pinctrl-11 = <&d6_gpio_pullup>;
-	pinctrl-12 = <&d6_gpio_pulldown>;
-
-	pinctrl-13 = <&d7_ehrpwm3_a>;
-	pinctrl-14 = <&d7_gpio>;
-	pinctrl-15 = <&d7_gpio_pullup>;
-	pinctrl-16 = <&d7_gpio_pulldown>;
-
-	pinctrl-17 = <&d8_ehrpwm4_a>;
-	pinctrl-18 = <&d8_gpio>;
-	pinctrl-19 = <&d8_gpio_pullup>;
-	pinctrl-20 = <&d8_gpio_pulldown>;
-
-	pinctrl-21 = <&d9_ehrpwm5_a>;
-	pinctrl-22 = <&d9_gpio>;
-	pinctrl-23 = <&d9_gpio_pullup>;
-	pinctrl-24 = <&d9_gpio_pulldown>;
-
-	d4_ehrpwm0_a: d4-ehrpwm0-a-pins {
-		pinctrl-single,pins = <
-			/* (AG18) EHRPWM0_A */
-			AM65X_IOPAD(0x0084, PIN_OUTPUT, 5)
-		>;
-	};
-
-	d4_gpio: d4-gpio-pins {
-		pinctrl-single,pins = <
-			/* (AG18) GPIO0_33 */
-			AM65X_IOPAD(0x0084, PIN_INPUT, 7)
-		>;
-	};
-
-	d4_gpio_pullup: d4-gpio-pullup-pins {
-		pinctrl-single,pins = <
-			/* (AG18) GPIO0_33 */
-			AM65X_IOPAD(0x0084, PIN_INPUT_PULLUP, 7)
-		>;
-	};
-
-	d4_gpio_pulldown: d4-gpio-pulldown-pins {
-		pinctrl-single,pins = <
-			/* (AG18) GPIO0_33 */
-			AM65X_IOPAD(0x0084, PIN_INPUT_PULLDOWN, 7)
-		>;
-	};
-
-	d5_ehrpwm1_a: d5-ehrpwm1-a-pins {
-		pinctrl-single,pins = <
-			/* (AF17) EHRPWM1_A */
-			AM65X_IOPAD(0x008C, PIN_OUTPUT, 5)
-		>;
-	};
-
-	d5_gpio: d5-gpio-pins {
-		pinctrl-single,pins = <
-			/* (AF17) GPIO0_35 */
-			AM65X_IOPAD(0x008C, PIN_INPUT, 7)
-		>;
-	};
-
-	d5_gpio_pullup: d5-gpio-pullup-pins {
-		pinctrl-single,pins = <
-			/* (AF17) GPIO0_35 */
-			AM65X_IOPAD(0x008C, PIN_INPUT_PULLUP, 7)
-		>;
-	};
-
-	d5_gpio_pulldown: d5-gpio-pulldown-pins {
-		pinctrl-single,pins = <
-			/* (AF17) GPIO0_35 */
-			AM65X_IOPAD(0x008C, PIN_INPUT_PULLDOWN, 7)
-		>;
-	};
-
-	d6_ehrpwm2_a: d6-ehrpwm2-a-pins {
-		pinctrl-single,pins = <
-			/* (AH16) EHRPWM2_A */
-			AM65X_IOPAD(0x0098, PIN_OUTPUT, 5)
-		>;
-	};
-
-	d6_gpio: d6-gpio-pins {
-		pinctrl-single,pins = <
-			/* (AH16) GPIO0_38 */
-			AM65X_IOPAD(0x0098, PIN_INPUT, 7)
-		>;
-	};
-
-	d6_gpio_pullup: d6-gpio-pullup-pins {
-		pinctrl-single,pins = <
-			/* (AH16) GPIO0_38 */
-			AM65X_IOPAD(0x0098, PIN_INPUT_PULLUP, 7)
-		>;
-	};
-
-	d6_gpio_pulldown: d6-gpio-pulldown-pins {
-		pinctrl-single,pins = <
-			/* (AH16) GPIO0_38 */
-			AM65X_IOPAD(0x0098, PIN_INPUT_PULLDOWN, 7)
-		>;
-	};
-
-	d7_ehrpwm3_a: d7-ehrpwm3-a-pins {
-		pinctrl-single,pins = <
-			/* (AH15) EHRPWM3_A */
-			AM65X_IOPAD(0x00AC, PIN_OUTPUT, 5)
-		>;
-	};
-
-	d7_gpio: d7-gpio-pins {
-		pinctrl-single,pins = <
-			/* (AH15) GPIO0_43 */
-			AM65X_IOPAD(0x00AC, PIN_INPUT, 7)
-		>;
-	};
-
-	d7_gpio_pullup: d7-gpio-pullup-pins {
-		pinctrl-single,pins = <
-			/* (AH15) GPIO0_43 */
-			AM65X_IOPAD(0x00AC, PIN_INPUT_PULLUP, 7)
-		>;
-	};
-
-	d7_gpio_pulldown: d7-gpio-pulldown-pins {
-		pinctrl-single,pins = <
-			/* (AH15) GPIO0_43 */
-			AM65X_IOPAD(0x00AC, PIN_INPUT_PULLDOWN, 7)
-		>;
-	};
-
-	d8_ehrpwm4_a: d8-ehrpwm4-a-pins {
-		pinctrl-single,pins = <
-			/* (AG15) EHRPWM4_A */
-			AM65X_IOPAD(0x00C0, PIN_OUTPUT, 5)
-		>;
-	};
-
-	d8_gpio: d8-gpio-pins {
-		pinctrl-single,pins = <
-			/* (AG15) GPIO0_48 */
-			AM65X_IOPAD(0x00C0, PIN_INPUT, 7)
-		>;
-	};
-
-	d8_gpio_pullup: d8-gpio-pullup-pins {
-		pinctrl-single,pins = <
-			/* (AG15) GPIO0_48 */
-			AM65X_IOPAD(0x00C0, PIN_INPUT_PULLUP, 7)
-		>;
-	};
-
-	d8_gpio_pulldown: d8-gpio-pulldown-pins {
-		pinctrl-single,pins = <
-			/* (AG15) GPIO0_48 */
-			AM65X_IOPAD(0x00C0, PIN_INPUT_PULLDOWN, 7)
-		>;
-	};
-
-	d9_ehrpwm5_a: d9-ehrpwm5-a-pins {
-		pinctrl-single,pins = <
-			/* (AD15) EHRPWM5_A */
-			AM65X_IOPAD(0x00CC, PIN_OUTPUT, 5)
-		>;
-	};
-
-	d9_gpio: d9-gpio-pins {
-		pinctrl-single,pins = <
-			/* (AD15) GPIO0_51 */
-			AM65X_IOPAD(0x00CC, PIN_INPUT, 7)
-		>;
-	};
-
-	d9_gpio_pullup: d9-gpio-pullup-pins {
-		pinctrl-single,pins = <
-			/* (AD15) GPIO0_51 */
-			AM65X_IOPAD(0x00CC, PIN_INPUT_PULLUP, 7)
-		>;
-	};
-
-	d9_gpio_pulldown: d9-gpio-pulldown-pins {
-		pinctrl-single,pins = <
-			/* (AD15) GPIO0_51 */
-			AM65X_IOPAD(0x00CC, PIN_INPUT_PULLDOWN, 7)
-		>;
-	};
-
 	main_pcie_enable_pins_default: main-pcie-enable-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x01c4, PIN_INPUT_PULLUP, 7)  /* (AH13) GPIO1_17 */
@@ -1083,57 +424,11 @@ &main_uart1 {
 	pinctrl-0 = <&main_uart1_pins_default>;
 };
 
-&mcu_uart0 {
-	status = "okay";
-};
-
-&main_gpio0 {
-	gpio-line-names =
-		"main_gpio0-base", "", "", "", "", "", "", "", "", "",
-		"", "", "", "", "", "", "", "", "", "",
-		"", "", "", "", "", "", "", "", "", "",
-		"", "", "", "IO4", "", "IO5", "", "", "IO6", "",
-		"", "", "", "IO7", "", "", "", "", "IO8", "",
-		"", "IO9";
-};
-
 &main_gpio1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_pcie_enable_pins_default>;
 };
 
-&wkup_gpio0 {
-	pinctrl-names = "default";
-	pinctrl-0 =
-		<&arduino_i2c_aio_switch_pins_default>,
-		<&arduino_io_oe_pins_default>,
-		<&push_button_pins_default>,
-		<&db9_com_mode_pins_default>;
-	gpio-line-names =
-		/* 0..9 */
-		"wkup_gpio0-base", "", "", "", "UART0-mode1", "UART0-mode0",
-		"UART0-enable", "UART0-terminate", "", "WIFI-disable",
-		/* 10..19 */
-		"", "", "", "", "", "", "", "", "", "",
-		/* 20..29 */
-		"", "A4A5-I2C-mux", "", "", "", "USER-button", "", "", "","IO0",
-		/* 30..39 */
-		"IO1", "IO2", "", "IO3", "IO17-direction", "A5",
-		"IO16-direction", "IO15-direction", "IO14-direction", "A3",
-		/* 40..49 */
-		"", "IO18-direction", "A4", "A2", "A1", "A0", "", "", "IO13",
-		"IO11",
-		/* 50..51 */
-		"IO12", "IO10";
-};
-
-&wkup_i2c0 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&wkup_i2c0_pins_default>;
-	clock-frequency = <400000>;
-};
-
 &mcu_i2c0 {
 	status = "okay";
 	pinctrl-names = "default";
@@ -1151,47 +446,6 @@ psu: regulator@60 {
 		ti,vsel1-state-high;
 		ti,enable-vout-discharge;
 	};
-
-	/* D4200 */
-	pcal9535_1: gpio@20 {
-		compatible = "nxp,pcal9535";
-		reg = <0x20>;
-		#gpio-cells = <2>;
-		gpio-controller;
-		gpio-line-names =
-			"A0-pull", "A1-pull", "A2-pull", "A3-pull", "A4-pull",
-			"A5-pull", "", "",
-			"IO14-enable", "IO15-enable", "IO16-enable",
-			"IO17-enable", "IO18-enable", "IO19-enable";
-	};
-
-	/* D4201 */
-	pcal9535_2: gpio@21 {
-		compatible = "nxp,pcal9535";
-		reg = <0x21>;
-		#gpio-cells = <2>;
-		gpio-controller;
-		gpio-line-names =
-			"IO0-direction", "IO1-direction", "IO2-direction",
-			"IO3-direction", "IO4-direction", "IO5-direction",
-			"IO6-direction", "IO7-direction",
-			"IO8-direction", "IO9-direction", "IO10-direction",
-			"IO11-direction", "IO12-direction", "IO13-direction",
-			"IO19-direction";
-	};
-
-	/* D4202 */
-	pcal9535_3: gpio@25 {
-		compatible = "nxp,pcal9535";
-		reg = <0x25>;
-		#gpio-cells = <2>;
-		gpio-controller;
-		gpio-line-names =
-			"IO0-pull", "IO1-pull", "IO2-pull", "IO3-pull",
-			"IO4-pull", "IO5-pull", "IO6-pull", "IO7-pull",
-			"IO8-pull", "IO9-pull", "IO10-pull", "IO11-pull",
-			"IO12-pull", "IO13-pull";
-	};
 };
 
 &main_i2c0 {
@@ -1292,13 +546,6 @@ &mcu_spi0 {
 	ti,pindir-d0-out-d1-in;
 };
 
-&tscadc1 {
-	status = "okay";
-	adc {
-		ti,adc-channels = <0 1 2 3 4 5>;
-	};
-};
-
 &ospi0 {
 	status = "okay";
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi
index 2300abe69e94..8c438f101c99 100644
--- a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi
@@ -10,6 +10,7 @@
  */
 
 #include "k3-am65-iot2050-common.dtsi"
+#include "k3-am65-iot2050-arduino-connector.dtsi"
 
 / {
 	memory@80000000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
index 1e5d4d98b69b..2401cbe2b66c 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
@@ -15,6 +15,7 @@
 
 #include "k3-am6548-iot2050-advanced-common.dtsi"
 #include "k3-am65-iot2050-common-pg2.dtsi"
+#include "k3-am65-iot2050-arduino-connector.dtsi"
 
 / {
 	compatible = "siemens,iot2050-advanced-m2", "ti,am654";
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts
index a8ce8c891894..c1205feef54e 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts
@@ -17,6 +17,7 @@
 
 #include "k3-am6548-iot2050-advanced-common.dtsi"
 #include "k3-am65-iot2050-common-pg2.dtsi"
+#include "k3-am65-iot2050-arduino-connector.dtsi"
 
 / {
 	compatible = "siemens,iot2050-advanced-pg2", "ti,am654";
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
index 077f165bdc68..b66965f992b9 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
@@ -17,6 +17,7 @@
 
 #include "k3-am6548-iot2050-advanced-common.dtsi"
 #include "k3-am65-iot2050-common-pg1.dtsi"
+#include "k3-am65-iot2050-arduino-connector.dtsi"
 
 / {
 	compatible = "siemens,iot2050-advanced", "ti,am654";
-- 
2.35.3


