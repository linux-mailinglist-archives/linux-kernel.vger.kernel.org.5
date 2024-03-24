Return-Path: <linux-kernel+bounces-115765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0002889775
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E3E1C30C9A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B0036ACEA;
	Mon, 25 Mar 2024 03:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUTtHwhv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F0A14291E;
	Sun, 24 Mar 2024 23:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321968; cv=none; b=IOXKba29fF/bNMYnxXWe7uK4pRLwHoruo/YvxEPbWJh4VaBepbLvFr4VWJF1B18DWhbiNBwJuQYjBMFRFhdXeD2SryVB+9U05hp3R2kVX2snskMDY4EBbx34E5E8xIkZk/7yvTXQFXesEznWH8AqHVHsnHj2m+xzrqQCiq6+uow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321968; c=relaxed/simple;
	bh=9VfXSt1NiGcVAed46Ql4jw8lhSZWuC2t0JpuV/8gLi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r1QHnoZy/mIx/VH+Eki+bYCm/WX7ocDcEFoRJ3/GbFkwMfguCIZRkrdluXnTiFh11FBfegM6RNZ0U91zaTPTAXoBvTdH96qFN7yx41VY0L/5Ty31J1zUOctj41U5prk8qaceMNZTaBJzL65RFUIYG8i46rOOZKpYbgrSWrL+/70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUTtHwhv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E75C43394;
	Sun, 24 Mar 2024 23:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321967;
	bh=9VfXSt1NiGcVAed46Ql4jw8lhSZWuC2t0JpuV/8gLi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AUTtHwhviq+I1zNT+ZOL0sLwIy/35gB2xiJ1Qf3gCXnDbfSkoO4dw7tuAaSa2k03Z
	 gFqLcU/N53g3W9tyIwo32+mEyRznYR8eMC5RtgjcNffIKu8+R+EDkbMPA8yEDuWXg+
	 RyLWawwXccYp2B7U+tgC1jle6DSWNBO++HQlIm6cpE0dUq6zRZHI1CI/IXy094DBJp
	 I3NX34sPGTT4PpY8f6G4aZWtlVui0QWqKnY0YdPXZl++2TkHsprc75B0fQqaeYnst9
	 QkjjNs+pJP8ixHOBlTFea+w/kZym5TTSF5Tl+7TBu26unAQ4l/rLCEFY0FVgJqXQSv
	 1NLCfwYxiSLeQ==
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
Subject: [PATCH 6.1 039/451] arm64: dts: Fix dtc interrupt_provider warnings
Date: Sun, 24 Mar 2024 19:05:15 -0400
Message-ID: <20240324231207.1351418-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 4eb2cd14e00b0..9b6da84deae7a 100644
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
index 73a352ea8fd5c..b30014d4dc29c 100644
--- a/arch/arm64/boot/dts/amazon/alpine-v3.dtsi
+++ b/arch/arm64/boot/dts/amazon/alpine-v3.dtsi
@@ -351,7 +351,6 @@ pcie@fbd00000 {
 		msix: msix@fbe00000 {
 			compatible = "al,alpine-msix";
 			reg = <0x0 0xfbe00000 0x0 0x100000>;
-			interrupt-controller;
 			msi-controller;
 			al,msi-base-spi = <336>;
 			al,msi-num-spis = <959>;
diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
index fda97c47f4e97..d5778417455c0 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
@@ -584,6 +584,7 @@ gpio_g: gpio@660a0000 {
 			#gpio-cells = <2>;
 			gpio-controller;
 			interrupt-controller;
+			#interrupt-cells = <2>;
 			interrupts = <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index 8f8c25e51194d..473d7d0ddf369 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -442,6 +442,7 @@ gpio_hsls: gpio@d0000 {
 			#gpio-cells = <2>;
 			gpio-controller;
 			interrupt-controller;
+			#interrupt-cells = <2>;
 			interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-ranges = <&pinmux 0 0 16>,
 					<&pinmux 16 71 2>,
diff --git a/arch/arm64/boot/dts/lg/lg1312.dtsi b/arch/arm64/boot/dts/lg/lg1312.dtsi
index 78ae73d0cf365..98ff17b14b2a5 100644
--- a/arch/arm64/boot/dts/lg/lg1312.dtsi
+++ b/arch/arm64/boot/dts/lg/lg1312.dtsi
@@ -124,7 +124,6 @@ eth0: ethernet@c1b00000 {
 	amba {
 		#address-cells = <2>;
 		#size-cells = <1>;
-		#interrupt-cells = <3>;
 
 		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
diff --git a/arch/arm64/boot/dts/lg/lg1313.dtsi b/arch/arm64/boot/dts/lg/lg1313.dtsi
index 2173316573bee..8e9410d8f46c0 100644
--- a/arch/arm64/boot/dts/lg/lg1313.dtsi
+++ b/arch/arm64/boot/dts/lg/lg1313.dtsi
@@ -124,7 +124,6 @@ eth0: ethernet@c3700000 {
 	amba {
 		#address-cells = <2>;
 		#size-cells = <1>;
-		#interrupt-cells = <3>;
 
 		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
diff --git a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
index a06a0a889c43f..73d8803b54d8b 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
@@ -133,7 +133,6 @@ pmu {
 
 			odmi: odmi@300000 {
 				compatible = "marvell,odmi-controller";
-				interrupt-controller;
 				msi-controller;
 				marvell,odmi-frames = <4>;
 				reg = <0x300000 0x4000>,
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
index 5117b2e7985af..998c2e78168a6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
@@ -111,6 +111,7 @@ mt6360: pmic@34 {
 		compatible = "mediatek,mt6360";
 		reg = <0x34>;
 		interrupt-controller;
+		#interrupt-cells = <1>;
 		interrupts-extended = <&pio 101 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-names = "IRQB";
 
diff --git a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
index 588b14b66b6fb..f37abfc13fe59 100644
--- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
@@ -251,6 +251,7 @@ gpio_exp_74: gpio@74 {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
+		#interrupt-cells = <2>;
 		interrupt-parent = <&gpio6>;
 		interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
 
@@ -311,6 +312,7 @@ gpio_exp_75: gpio@75 {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
+		#interrupt-cells = <2>;
 		interrupt-parent = <&gpio6>;
 		interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
 	};
@@ -331,6 +333,7 @@ gpio_exp_76: gpio@76 {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
+		#interrupt-cells = <2>;
 		interrupt-parent = <&gpio7>;
 		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
 	};
@@ -341,6 +344,7 @@ gpio_exp_77: gpio@77 {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
+		#interrupt-cells = <2>;
 		interrupt-parent = <&gpio5>;
 		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
 	};
-- 
2.43.0


