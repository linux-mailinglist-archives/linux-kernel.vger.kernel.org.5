Return-Path: <linux-kernel+bounces-149207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D288A8D2E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 535511C217F7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE4F4AEDE;
	Wed, 17 Apr 2024 20:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbETSj3/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C34D482DB;
	Wed, 17 Apr 2024 20:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713386644; cv=none; b=BO6+eiSczAy1tk0y5mDfAjcjgCobVHJ5RyPAd9xBk0AXQ36ILpfJyFldPv4liQwvIWADLL+LOKdZpnzmtMbPrHYX9HtjAf2VTsaWUgKx3G6OFdEHRGoJ8JmcnqbmpsqLzERLdsS+hXXLz8mi0qAy0LfyRbmRMP3ROpGxBjo4qdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713386644; c=relaxed/simple;
	bh=kwQCOEyx8WgKKzp5TIPczdJokZvo1f/Y6NjVRYtqmoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A2b5CNq5mjK7BBn4AKSMOQJ6bZGSmVg9Lqbcf3wJTxsBaIcph+0AXivchLUhmWP8nB0UIsc3CceZ0vl3WVdXnFcuq2EgaGDP4J/QFcrVDEe2bUexsqTBW85cAQ4yrKWSfwngYc5yC62azN2V3skHdxXPYDsyl2Kf/9ra7bNWl5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbETSj3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32EDC072AA;
	Wed, 17 Apr 2024 20:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713386644;
	bh=kwQCOEyx8WgKKzp5TIPczdJokZvo1f/Y6NjVRYtqmoE=;
	h=From:To:Cc:Subject:Date:From;
	b=JbETSj3/hwG3TIlJnRp4y25EpNmD0EVtcr5WHW/9OfkUihih4dpt/n22fw3ZLEUEx
	 tRc85ZU4RVMpiVxoNYg6FM7hgRPD2JtnLtXejkZCZ2o3rbbD6IHYdylUGPwBZJpWD0
	 57yCHZmqUCfiWsOcoSGIfZdFubtuqKMnTUVztBNrbXHGt04sHKiR0WpUK5Kr1hpjG1
	 9vCZmNodoUHdTwRzdijEa0oG0VvSP0hVFJ2XQ4oUf910D0kU367dfqCnBXO5U2EvvG
	 wNhNM5xu3mglemDS/j2PDJors0u2tFouQatzbbRJq7P00zxbrd9MWZYQ1oKjQgmIZD
	 OVbxivAJHDcvw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Xilin Wu <wuxilin123@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: qcom: Split PMU nodes for heterogeneous CPUs
Date: Wed, 17 Apr 2024 15:42:46 -0500
Message-ID: <20240417204247.3216703-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arm heterogeneous configurations should have separate PMU nodes for each
CPU uarch as the uarch specific events can be different. The
"arm,armv8-pmuv3" compatible is also intended for s/w models rather than
specific uarch implementations.

All the kryo CPUs are missing PMU compatibles, so they can't be fixed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
 - Drop old 'pmu' node in msm8976
 - sm8550 should be A715, not A720
---
 arch/arm64/boot/dts/qcom/msm8956.dtsi |  4 ++--
 arch/arm64/boot/dts/qcom/msm8976.dtsi | 12 +++++++++---
 arch/arm64/boot/dts/qcom/sm4450.dtsi  | 11 ++++++++---
 arch/arm64/boot/dts/qcom/sm8350.dtsi  | 14 ++++++++++++--
 arch/arm64/boot/dts/qcom/sm8550.dtsi  | 19 +++++++++++++++++--
 arch/arm64/boot/dts/qcom/sm8650.dtsi  | 14 ++++++++++++--
 6 files changed, 60 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8956.dtsi b/arch/arm64/boot/dts/qcom/msm8956.dtsi
index 668e05185c21..fa36b62156bb 100644
--- a/arch/arm64/boot/dts/qcom/msm8956.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8956.dtsi
@@ -8,8 +8,8 @@
 
 #include "msm8976.dtsi"
 
-&pmu {
-	interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
+&pmu_a72 {
+	interrupts = <GIC_PPI 7 (GIC_CPU_MASK_RAW(0x30) | IRQ_TYPE_LEVEL_HIGH)>;
 };
 
 &tsens {
diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index d2bb1ada361a..3b2962aad20d 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -222,11 +222,17 @@ memory@80000000 {
 		reg = <0x0 0x80000000 0x0 0x0>;
 	};
 
-	pmu: pmu {
-		compatible = "arm,armv8-pmuv3";
-		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
+	pmu-a53 {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	pmu_a72: pmu-a72 {
+		compatible = "arm,cortex-a72-pmu";
+		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_RAW(0xf0) | IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
diff --git a/arch/arm64/boot/dts/qcom/sm4450.dtsi b/arch/arm64/boot/dts/qcom/sm4450.dtsi
index 603c962661cc..411eb7577407 100644
--- a/arch/arm64/boot/dts/qcom/sm4450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm4450.dtsi
@@ -268,9 +268,14 @@ memory@a0000000 {
 		reg = <0x0 0xa0000000 0x0 0x0>;
 	};
 
-	pmu {
-		compatible = "arm,armv8-pmuv3";
-		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	pmu-a55 {
+		compatible = "arm,cortex-a55-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	pmu-a78 {
+		compatible = "arm,cortex-a78-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
 	};
 
 	psci {
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index a5e7dbbd8c6c..127fa9a935da 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -300,8 +300,18 @@ memory@80000000 {
 		reg = <0x0 0x80000000 0x0 0x0>;
 	};
 
-	pmu {
-		compatible = "arm,armv8-pmuv3";
+	pmu-a55 {
+		compatible = "arm,cortex-a55-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	pmu-a78 {
+		compatible = "arm,cortex-a78-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	pmu-x1 {
+		compatible = "arm,cortex-x1-pmu";
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 3904348075f6..d1c0b2d2123b 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -357,8 +357,23 @@ memory@a0000000 {
 		reg = <0 0xa0000000 0 0>;
 	};
 
-	pmu {
-		compatible = "arm,armv8-pmuv3";
+	pmu-a510 {
+		compatible = "arm,cortex-a510-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	pmu-a710 {
+		compatible = "arm,cortex-a710-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	pmu-a715 {
+		compatible = "arm,cortex-a715-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	pmu-x3 {
+		compatible = "arm,cortex-x3-pmu";
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index ba72d8f38420..90102a41489d 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -394,8 +394,18 @@ memory@a0000000 {
 		reg = <0 0xa0000000 0 0>;
 	};
 
-	pmu {
-		compatible = "arm,armv8-pmuv3";
+	pmu-a520 {
+		compatible = "arm,cortex-a520-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	pmu-a720 {
+		compatible = "arm,cortex-a720-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	pmu-x4 {
+		compatible = "arm,cortex-x4-pmu";
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
 	};
 
-- 
2.43.0


