Return-Path: <linux-kernel+bounces-87453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B540486D49A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D93DE1C21B3D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51191428FA;
	Thu, 29 Feb 2024 20:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZ/FQxA/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF654154E88;
	Thu, 29 Feb 2024 20:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239102; cv=none; b=i/51LsMD6WsgizP4FGfy/25gxlllZFomNv4jbsFrt5uQrZyA0FGYycMEcbZkDp9R5CIYXWxgjuSH/CluUsyTMNOATLmohf0zBaR2vyzI7tAQiOpC3wmT7QijWRsb4X+C5PXkU3yd5fRR2udti3mC4YzoRWosp//+nGf+FXHXLPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239102; c=relaxed/simple;
	bh=x7MLU62vI7O1d2eyk4IUEW2gd5l0YWD/HIw5tn3Wglg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQjBMep+2Lc22cTLSmnK59rZ6Jhk0u0/KBX6NEcV2dhpGpCz8N+rDdj8YQ/3xo3s3WeQzRRNNg2PxgHAot/HQglh3302NHD8f9o+ypylqVtqPjY2/ZUYQeK5020uHx58XT0JO0apy6fxwemW23m+LMdy2myVEJ1LD0lYmmge5ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZ/FQxA/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C848C43394;
	Thu, 29 Feb 2024 20:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239101;
	bh=x7MLU62vI7O1d2eyk4IUEW2gd5l0YWD/HIw5tn3Wglg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QZ/FQxA/y/l0f9AHvDyUg5rrYRe4wCIAfl/xkd6L1PhVfbXYSNhN00opRygNNzZFK
	 Rz+Tn6JcR4XmbFTaaJAOSen4wNw8GCVP31h3Oem1BQuyTVwUKKEUsZS1hSomdE3k0L
	 EVxkdDCZ+OZbf+doMl802Mm68dEsoLtJZ7nXMq8VBAUBQJCIILicv5Hon6948S/NOt
	 dRQ3PoSfmXjwbV1Fh04ofqwMT3pDovWM77mIoaLPESIKkKPwhzPSuSIR5RwOL1nU0D
	 bpD5BQp2PEOJmNmkh83J3qWqVhbHx/PTq+ZUviIu9AwL2yNPLK2wSjUpqedZpKS4gF
	 xwsQkotaHnBfQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Chanho Min <chanho.min@lge.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>,
	tsahee@annapurnalabs.com,
	atenart@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	rjui@broadcom.com,
	sbranden@broadcom.com,
	andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	matthias.bgg@gmail.com,
	magnus.damm@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 20/24] arm64: dts: Fix dtc interrupt_provider warnings
Date: Thu, 29 Feb 2024 15:37:00 -0500
Message-ID: <20240229203729.2860356-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229203729.2860356-1-sashal@kernel.org>
References: <20240229203729.2860356-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
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


