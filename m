Return-Path: <linux-kernel+bounces-133500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF1689A496
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9AF31C227F0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143DA173325;
	Fri,  5 Apr 2024 19:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cus0Ku8a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5652A171E47;
	Fri,  5 Apr 2024 19:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712343883; cv=none; b=gCs/AlfK8V+W9xyLti0ixXKCYGQDAfzpfTsW9xPmf5xtWuq0QgbUeOIXApXjof1WUhqvXLfe5sCYtjtNWIFZ5EM500NwTxZMfnmmhaitjN291+6tlT1ikcfaAG57BIhVwp0gL4ENpbxvBWYvGK1gAgU8OpTwSOpxllXWTjuBluQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712343883; c=relaxed/simple;
	bh=H9Wi3Y/rHK+r5zWsUtvjAuPhqT1r6YuxbE5O8catXRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ksqn4GoKh2MXcLsxiMqQeMf9m/ShCh5Q4lu+iqyGLAmaMefABPm9M3N7AHjvIIOYTlS7KI5LRHUO1KliveBOZIc6FMOoUR4m5w/+6JDpG5Y9mkrqiNQ9indBtJZADTqccJhli9SAxn3qaGtNe2WXKeVb97Qtmqim59WeI8DzDdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cus0Ku8a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0DBC433F1;
	Fri,  5 Apr 2024 19:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712343883;
	bh=H9Wi3Y/rHK+r5zWsUtvjAuPhqT1r6YuxbE5O8catXRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cus0Ku8aNK3ifuJq59N7aZlXIpDm5heOHh44f/N0frewhJWCW3oZhLuEcioVctd5D
	 bopqCxi+HFlbBfnuZLXBU/f7igVm7sVgZkd8NxikBc23uzDdVj5B9qCPDORurlqvKQ
	 io0dUTcSNjGSHBakLLHd5ZlMP+48KgMc3JZw9Wyj1AnKkRsX4rslWhltpB6uFyXFU5
	 gl9ZDRnDzYo6/HscRVeQxh/SpPNUwEGZdXjUKyIzOoILr0fHLEl3RJ8N/PjYRXazo2
	 ggnvNtDSGPaSp22ZNCtb76E6S6v329Vv7MFlWd2/tlohctt4+c2TY0YlB166NSE1MK
	 QnNyqLKDctRhw==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Conor Dooley <conor@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Bjarni Jonasson <bjarni.jonasson@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: horatiu.vultur@microchip.com,
	steen.hegelund@microchip.com,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 03/10] arm64: dts: microchip: sparx5_pcb134: add missing I2C mux unit addresses
Date: Fri,  5 Apr 2024 21:04:12 +0200
Message-Id: <20240405190419.74162-3-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405190419.74162-1-krzk@kernel.org>
References: <20240405190419.74162-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The children of I2C mux should be named "i2c", according to DT schema
and bindings, and they should have unit address.

This fixes dtbs_check warnings like:

  sparx5_pcb134_emmc.dtb: i2c0-imux@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'i2c_sfp1', ...

and dtc W=1 warnings:

  sparx5_pcb134_board.dtsi:548.23-555.4: Warning (simple_bus_reg): /axi@600000000/sfp-eth12: missing or empty reg/ranges property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes in v2:
1. None
---
 .../dts/microchip/sparx5_pcb134_board.dtsi    | 40 +++++++++----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi b/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
index f3e226de5e5e..e816e6e9d62d 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
@@ -427,62 +427,62 @@ &i2c0_imux {
 	pinctrl-10 = <&i2cmux_10>;
 	pinctrl-11 = <&i2cmux_11>;
 	pinctrl-12 = <&i2cmux_pins_i>;
-	i2c_sfp1: i2c_sfp1 {
+	i2c_sfp1: i2c@0 {
 		reg = <0x0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-	i2c_sfp2: i2c_sfp2 {
+	i2c_sfp2: i2c@1 {
 		reg = <0x1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-	i2c_sfp3: i2c_sfp3 {
+	i2c_sfp3: i2c@2 {
 		reg = <0x2>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-	i2c_sfp4: i2c_sfp4 {
+	i2c_sfp4: i2c@3 {
 		reg = <0x3>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-	i2c_sfp5: i2c_sfp5 {
+	i2c_sfp5: i2c@4 {
 		reg = <0x4>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-	i2c_sfp6: i2c_sfp6 {
+	i2c_sfp6: i2c@5 {
 		reg = <0x5>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-	i2c_sfp7: i2c_sfp7 {
+	i2c_sfp7: i2c@6 {
 		reg = <0x6>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-	i2c_sfp8: i2c_sfp8 {
+	i2c_sfp8: i2c@7 {
 		reg = <0x7>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-	i2c_sfp9: i2c_sfp9 {
+	i2c_sfp9: i2c@8 {
 		reg = <0x8>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-	i2c_sfp10: i2c_sfp10 {
+	i2c_sfp10: i2c@9 {
 		reg = <0x9>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-	i2c_sfp11: i2c_sfp11 {
+	i2c_sfp11: i2c@a {
 		reg = <0xa>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-	i2c_sfp12: i2c_sfp12 {
+	i2c_sfp12: i2c@b {
 		reg = <0xb>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -495,42 +495,42 @@ &gpio 60 GPIO_ACTIVE_HIGH
 		     &gpio 61 GPIO_ACTIVE_HIGH
 		     &gpio 54 GPIO_ACTIVE_HIGH>;
 	idle-state = <0x8>;
-	i2c_sfp13: i2c_sfp13 {
+	i2c_sfp13: i2c@0 {
 		reg = <0x0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-	i2c_sfp14: i2c_sfp14 {
+	i2c_sfp14: i2c@1 {
 		reg = <0x1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-	i2c_sfp15: i2c_sfp15 {
+	i2c_sfp15: i2c@2 {
 		reg = <0x2>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-	i2c_sfp16: i2c_sfp16 {
+	i2c_sfp16: i2c@3 {
 		reg = <0x3>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-	i2c_sfp17: i2c_sfp17 {
+	i2c_sfp17: i2c@4 {
 		reg = <0x4>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-	i2c_sfp18: i2c_sfp18 {
+	i2c_sfp18: i2c@5 {
 		reg = <0x5>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-	i2c_sfp19: i2c_sfp19 {
+	i2c_sfp19: i2c@6 {
 		reg = <0x6>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-	i2c_sfp20: i2c_sfp20 {
+	i2c_sfp20: i2c@7 {
 		reg = <0x7>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.34.1


