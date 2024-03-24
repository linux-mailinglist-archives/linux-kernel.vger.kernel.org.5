Return-Path: <linux-kernel+bounces-115291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B369C88938C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6B701C2E7C1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DBC1607B3;
	Mon, 25 Mar 2024 02:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ed1Wls4e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619367F7CB;
	Sun, 24 Mar 2024 22:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320484; cv=none; b=lzG7LMEgCIdt4E44jUKB+eXG4i1xAIatCQy1DfJtaiXp7tbJijonlW/aY8ClrjRURCB2/Qeo8sZzl+GfjI5BtlZf13FWj92GOi+yNCOjDByL+IrK6yw/FN0OJWGFKpaK/C3k1K9gt1XshiEAKDeJb3klNOTpP8d8LhItoDBSD3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320484; c=relaxed/simple;
	bh=x7MLU62vI7O1d2eyk4IUEW2gd5l0YWD/HIw5tn3Wglg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=av5VFglDXGNxmQXGL45noEaASkXa7m92q23rzaaD7i3VAxjHqsQQS/GE9T4fvNjtiSNBcM25JBws/c5vwNCM/1mFpEFapNOtAYXHQDd7LvTCEzvc+7+Fcv2DVnp0tAmI8rBzkLEIIgkQgGqO+RG2E3dURbuLIrspT1s/V9J32WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ed1Wls4e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2DAC433F1;
	Sun, 24 Mar 2024 22:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320484;
	bh=x7MLU62vI7O1d2eyk4IUEW2gd5l0YWD/HIw5tn3Wglg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ed1Wls4e8IBrbuE7DZR+QhRO2W+OPb4Tbl2SWA+MWI6bwBnM7Oc+jim1DGED2POoS
	 NTOf2cS1wT4PyfNcL7ihrCnHmW/VaM7IYNQ16sdkjQScnAEcOY9q5a9Mj1XhzCyyYV
	 kQJXwAGDleeBcS2kIU8kaPBfkZocPaqFA3nM/HRjlN/idfffRakoqHy30nvbpO1b1t
	 MNW+dDqq9OKP68MAJHb3Hy1Ry2Y91ctUiiQs9Xh1DFcTPW/KrAqVujwng7ZzKUK0Ei
	 sBpZo8YVevCL/ad+VAyLURTApptn8jV4iqH/JEoJxTSB6FbL0ChOmx69/mpMvVvREH
	 Ji05qLd7jR0Jg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Chanho Min <chanho.min@lge.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 043/713] arm64: dts: Fix dtc interrupt_provider warnings
Date: Sun, 24 Mar 2024 18:36:09 -0400
Message-ID: <20240324224720.1345309-44-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Rob Herring <robh@kernel.org>

[ Upstream commit 91adecf911e5df78ea3e8f866e69db2c33416a5c ]

The dtc interrupt_provider warning is off by default. Fix all the warnings
so it can be enabled.

Signed-off-by: Rob Herring <robh@kernel.org>
Reviewed-By: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> #
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Florian Fainelli <florian.fainelli@broadcom.com> #Broadcom
Acked-by: Chanho Min <chanho.min@lge.com>
Link: https://lore.kernel.org/r/20240213-arm-dt-cleanups-v1-3-f2dee1292525@kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/amazon/alpine-v2.dtsi           | 1 -
 arch/arm64/boot/dts/amazon/alpine-v3.dtsi           | 1 -
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi    | 1 +
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi | 1 +
 arch/arm64/boot/dts/lg/lg1312.dtsi                  | 1 -
 arch/arm64/boot/dts/lg/lg1313.dtsi                  | 1 -
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi       | 1 -
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts        | 1 +
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi            | 4 ++++
 9 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/amazon/alpine-v2.dtsi b/arch/arm64/boot/dts/amazon/alpine-v2.dtsi
index dccbba6e7f98e..dbf2dce8d1d68 100644
--- a/arch/arm64/boot/dts/amazon/alpine-v2.dtsi
+++ b/arch/arm64/boot/dts/amazon/alpine-v2.dtsi
@@ -145,7 +145,6 @@ pci@fbc00000 {
 		msix: msix@fbe00000 {
 			compatible = "al,alpine-msix";
 			reg = <0x0 0xfbe00000 0x0 0x100000>;
-			interrupt-controller;
 			msi-controller;
 			al,msi-base-spi = <160>;
 			al,msi-num-spis = <160>;
diff --git a/arch/arm64/boot/dts/amazon/alpine-v3.dtsi b/arch/arm64/boot/dts/amazon/alpine-v3.dtsi
index 39481d7fd7d4d..3ea178acdddfe 100644
--- a/arch/arm64/boot/dts/amazon/alpine-v3.dtsi
+++ b/arch/arm64/boot/dts/amazon/alpine-v3.dtsi
@@ -355,7 +355,6 @@ pcie@fbd00000 {
 		msix: msix@fbe00000 {
 			compatible = "al,alpine-msix";
 			reg = <0x0 0xfbe00000 0x0 0x100000>;
-			interrupt-controller;
 			msi-controller;
 			al,msi-base-spi = <336>;
 			al,msi-num-spis = <959>;
diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
index 9dcd25ec2c041..896d1f33b5b61 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
@@ -586,6 +586,7 @@ gpio_g: gpio@660a0000 {
 			#gpio-cells = <2>;
 			gpio-controller;
 			interrupt-controller;
+			#interrupt-cells = <2>;
 			interrupts = <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index f049687d6b96d..d8516ec0dae74 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -450,6 +450,7 @@ gpio_hsls: gpio@d0000 {
 			#gpio-cells = <2>;
 			gpio-controller;
 			interrupt-controller;
+			#interrupt-cells = <2>;
 			interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-ranges = <&pinmux 0 0 16>,
 					<&pinmux 16 71 2>,
diff --git a/arch/arm64/boot/dts/lg/lg1312.dtsi b/arch/arm64/boot/dts/lg/lg1312.dtsi
index 48ec4ebec0a83..b864ffa74ea8b 100644
--- a/arch/arm64/boot/dts/lg/lg1312.dtsi
+++ b/arch/arm64/boot/dts/lg/lg1312.dtsi
@@ -126,7 +126,6 @@ eth0: ethernet@c1b00000 {
 	amba {
 		#address-cells = <2>;
 		#size-cells = <1>;
-		#interrupt-cells = <3>;
 
 		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
diff --git a/arch/arm64/boot/dts/lg/lg1313.dtsi b/arch/arm64/boot/dts/lg/lg1313.dtsi
index 3869460aa5dcb..996fb39bb50c1 100644
--- a/arch/arm64/boot/dts/lg/lg1313.dtsi
+++ b/arch/arm64/boot/dts/lg/lg1313.dtsi
@@ -126,7 +126,6 @@ eth0: ethernet@c3700000 {
 	amba {
 		#address-cells = <2>;
 		#size-cells = <1>;
-		#interrupt-cells = <3>;
 
 		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
diff --git a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
index 2c920e22cec2b..7ec7c789d87ef 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
@@ -138,7 +138,6 @@ pmu {
 
 			odmi: odmi@300000 {
 				compatible = "marvell,odmi-controller";
-				interrupt-controller;
 				msi-controller;
 				marvell,odmi-frames = <4>;
 				reg = <0x300000 0x4000>,
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
index 69c7f3954ae59..4127cb84eba41 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
@@ -128,6 +128,7 @@ mt6360: pmic@34 {
 		compatible = "mediatek,mt6360";
 		reg = <0x34>;
 		interrupt-controller;
+		#interrupt-cells = <1>;
 		interrupts-extended = <&pio 101 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-names = "IRQB";
 
diff --git a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
index 3885ef3454ff6..50de17e4fb3f2 100644
--- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
@@ -234,6 +234,7 @@ gpio_exp_74: gpio@74 {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
+		#interrupt-cells = <2>;
 		interrupt-parent = <&gpio6>;
 		interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
 
@@ -294,6 +295,7 @@ gpio_exp_75: gpio@75 {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
+		#interrupt-cells = <2>;
 		interrupt-parent = <&gpio6>;
 		interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
 	};
@@ -314,6 +316,7 @@ gpio_exp_76: gpio@76 {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
+		#interrupt-cells = <2>;
 		interrupt-parent = <&gpio7>;
 		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
 	};
@@ -324,6 +327,7 @@ gpio_exp_77: gpio@77 {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
+		#interrupt-cells = <2>;
 		interrupt-parent = <&gpio5>;
 		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
 	};
-- 
2.43.0


