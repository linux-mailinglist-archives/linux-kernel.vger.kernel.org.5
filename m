Return-Path: <linux-kernel+bounces-133504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0553D89A49E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7B21F24C4E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF772172BCC;
	Fri,  5 Apr 2024 19:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uH+Ii8iD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C18172BB1;
	Fri,  5 Apr 2024 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712343904; cv=none; b=ng/fmr37XpzhHSrcQom9oEz7tz0o7bmgxWz+WM3ANNM+k7VAVz7X1qVZxDYk5y+p36PLo5Aj3C9XV13nhVtUOoWAd2+3kFiGmyjUchiEG8G34NjvN33lL8EhU+gBcI3uz8pukxYDRiMscMoR6RnGeTuS+gXZKYgaxW1iJ7wpxgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712343904; c=relaxed/simple;
	bh=VTThJeokk6apiJI6RQPPJVUE80D6u6RQGQpiDwwZc+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I0JlRhRy7jkjNFQDh6RPZHl8jT4VPjI8sZk/cYsYDpnJ1J+dW1H3Anu62tSBRNYpXdzL0IhqovClTlEC9VIIAgJkGK23G58t6xujlXvsafVdunNArzl3uQlrjcjf34wjC58b7lM9e9FxK++owYDjS+KP2Bpz/w9YZz+PUvRjeus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uH+Ii8iD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A399C43601;
	Fri,  5 Apr 2024 19:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712343904;
	bh=VTThJeokk6apiJI6RQPPJVUE80D6u6RQGQpiDwwZc+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uH+Ii8iDXhxCDsSDhZKZ0/qpcn+Sv9HVMV4MoH9IRO0VDQBcxgoY3mjbXkOoUwqJl
	 rsF0aGFARSSN23bwpBiSDQgM2SLbnFZfq401zseGmlXMx/FP163PYtC1uYJR69zm5F
	 z3GPnLDyW/Q1/fSPs2XFhA3N6GTQS+e7f365jl5y84p8aJ7cYfuAu2LJijEKsr5bPJ
	 ehFtpT0hUXj3DLNhdjdczdhf++pcQBvKSNeSq5/etl1TOvMYN4Lj8MRtxm53thw2nm
	 vVR+7g7FukntvEzvaNqBd08nRZ99nyP77RCJCmSnAartXUciqIc1YL5uewQapQ18hJ
	 WvCK9v6GRpJWw==
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
Subject: [PATCH v2 07/10] arm64: dts: microchip: sparx5_pcb134: drop LED unit addresses
Date: Fri,  5 Apr 2024 21:04:16 +0200
Message-Id: <20240405190419.74162-7-krzk@kernel.org>
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

GPIO leds should not have unit addresses (no "reg" property), as
reported by dtc W=1 warnings:

  sparx5_pcb134_board.dtsi:18.9-21.5: Warning (unit_address_vs_reg): /leds/led@0: node has a unit name, but no reg or ranges property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes in v2:
1. None
---
 .../dts/microchip/sparx5_pcb134_board.dtsi    | 96 +++++++++----------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi b/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
index cafec6ef0d0f..f165a409bc1d 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
@@ -15,234 +15,234 @@ gpio-restart {
 
 	leds {
 		compatible = "gpio-leds";
-		led@0 {
+		led-0 {
 			label = "twr0:green";
 			gpios = <&sgpio_out0 8 0 GPIO_ACTIVE_LOW>;
 		};
-		led@1 {
+		led-1 {
 			label = "twr0:yellow";
 			gpios = <&sgpio_out0 8 1 GPIO_ACTIVE_LOW>;
 		};
-		led@2 {
+		led-2 {
 			label = "twr1:green";
 			gpios = <&sgpio_out0 9 0 GPIO_ACTIVE_LOW>;
 		};
-		led@3 {
+		led-3 {
 			label = "twr1:yellow";
 			gpios = <&sgpio_out0 9 1 GPIO_ACTIVE_LOW>;
 		};
-		led@4 {
+		led-4 {
 			label = "twr2:green";
 			gpios = <&sgpio_out0 10 0 GPIO_ACTIVE_LOW>;
 		};
-		led@5 {
+		led-5 {
 			label = "twr2:yellow";
 			gpios = <&sgpio_out0 10 1 GPIO_ACTIVE_LOW>;
 		};
-		led@6 {
+		led-6 {
 			label = "twr3:green";
 			gpios = <&sgpio_out0 11 0 GPIO_ACTIVE_LOW>;
 		};
-		led@7 {
+		led-7 {
 			label = "twr3:yellow";
 			gpios = <&sgpio_out0 11 1 GPIO_ACTIVE_LOW>;
 		};
-		led@8 {
+		led-8 {
 			label = "eth12:green";
 			gpios = <&sgpio_out0 12 0 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@9 {
+		led-9 {
 			label = "eth12:yellow";
 			gpios = <&sgpio_out0 12 1 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@10 {
+		led-10 {
 			label = "eth13:green";
 			gpios = <&sgpio_out0 13 0 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@11 {
+		led-11 {
 			label = "eth13:yellow";
 			gpios = <&sgpio_out0 13 1 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@12 {
+		led-12 {
 			label = "eth14:green";
 			gpios = <&sgpio_out0 14 0 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@13 {
+		led-13 {
 			label = "eth14:yellow";
 			gpios = <&sgpio_out0 14 1 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@14 {
+		led-14 {
 			label = "eth15:green";
 			gpios = <&sgpio_out0 15 0 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@15 {
+		led-15 {
 			label = "eth15:yellow";
 			gpios = <&sgpio_out0 15 1 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@16 {
+		led-16 {
 			label = "eth48:green";
 			gpios = <&sgpio_out1 16 0 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@17 {
+		led-17 {
 			label = "eth48:yellow";
 			gpios = <&sgpio_out1 16 1 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@18 {
+		led-18 {
 			label = "eth49:green";
 			gpios = <&sgpio_out1 17 0 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@19 {
+		led-19 {
 			label = "eth49:yellow";
 			gpios = <&sgpio_out1 17 1 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@20 {
+		led-20 {
 			label = "eth50:green";
 			gpios = <&sgpio_out1 18 0 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@21 {
+		led-21 {
 			label = "eth50:yellow";
 			gpios = <&sgpio_out1 18 1 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@22 {
+		led-22 {
 			label = "eth51:green";
 			gpios = <&sgpio_out1 19 0 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@23 {
+		led-23 {
 			label = "eth51:yellow";
 			gpios = <&sgpio_out1 19 1 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@24 {
+		led-24 {
 			label = "eth52:green";
 			gpios = <&sgpio_out1 20 0 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@25 {
+		led-25 {
 			label = "eth52:yellow";
 			gpios = <&sgpio_out1 20 1 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@26 {
+		led-26 {
 			label = "eth53:green";
 			gpios = <&sgpio_out1 21 0 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@27 {
+		led-27 {
 			label = "eth53:yellow";
 			gpios = <&sgpio_out1 21 1 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@28 {
+		led-28 {
 			label = "eth54:green";
 			gpios = <&sgpio_out1 22 0 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@29 {
+		led-29 {
 			label = "eth54:yellow";
 			gpios = <&sgpio_out1 22 1 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@30 {
+		led-30 {
 			label = "eth55:green";
 			gpios = <&sgpio_out1 23 0 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@31 {
+		led-31 {
 			label = "eth55:yellow";
 			gpios = <&sgpio_out1 23 1 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@32 {
+		led-32 {
 			label = "eth56:green";
 			gpios = <&sgpio_out1 24 0 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@33 {
+		led-33 {
 			label = "eth56:yellow";
 			gpios = <&sgpio_out1 24 1 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@34 {
+		led-34 {
 			label = "eth57:green";
 			gpios = <&sgpio_out1 25 0 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@35 {
+		led-35 {
 			label = "eth57:yellow";
 			gpios = <&sgpio_out1 25 1 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@36 {
+		led-36 {
 			label = "eth58:green";
 			gpios = <&sgpio_out1 26 0 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@37 {
+		led-37 {
 			label = "eth58:yellow";
 			gpios = <&sgpio_out1 26 1 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@38 {
+		led-38 {
 			label = "eth59:green";
 			gpios = <&sgpio_out1 27 0 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@39 {
+		led-39 {
 			label = "eth59:yellow";
 			gpios = <&sgpio_out1 27 1 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@40 {
+		led-40 {
 			label = "eth60:green";
 			gpios = <&sgpio_out1 28 0 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@41 {
+		led-41 {
 			label = "eth60:yellow";
 			gpios = <&sgpio_out1 28 1 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@42 {
+		led-42 {
 			label = "eth61:green";
 			gpios = <&sgpio_out1 29 0 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@43 {
+		led-43 {
 			label = "eth61:yellow";
 			gpios = <&sgpio_out1 29 1 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@44 {
+		led-44 {
 			label = "eth62:green";
 			gpios = <&sgpio_out1 30 0 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@45 {
+		led-45 {
 			label = "eth62:yellow";
 			gpios = <&sgpio_out1 30 1 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@46 {
+		led-46 {
 			label = "eth63:green";
 			gpios = <&sgpio_out1 31 0 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		led@47 {
+		led-47 {
 			label = "eth63:yellow";
 			gpios = <&sgpio_out1 31 1 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
-- 
2.34.1


