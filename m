Return-Path: <linux-kernel+bounces-143411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD128A3896
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 00:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC4F1C21C26
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3A0152DE4;
	Fri, 12 Apr 2024 22:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pg3NKjON"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB4015219A;
	Fri, 12 Apr 2024 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712960990; cv=none; b=EoF8IlxjWuqU21MyDvCDSxc727Ut13vtImW78GimOLTjWikTXYDz9kHvu3wcuJoGeewZtyAjS6XNYOMK03kj9Q7TtWA8Zocu7jVcMm7dxm7C87kzx9BFHCloFxbSYeilrklxmMsrg9zGv9NnMNaBH8u9VrPnmzckrHq8fPDzC2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712960990; c=relaxed/simple;
	bh=840tAhIUgUsbJb+DciOBuX15dBYjk7QleC0dzcnetYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GMYf8SiSunlZQ3cZdtWu0OBCuSmbmEH+AmpCMQtEjTLYEgRCGL4gMhVd+NJ+ZuSKkt9bNMyFOXP/++c8RztY1qNvY+H+/NSD5XXq0Hv2v/7veIKMj8ZdxOQskJCX/7Ejw0ukR6Kbj5q+jhSmWcHZhnEnLVfh2WZ6E38cEZQaibI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pg3NKjON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B42C113CC;
	Fri, 12 Apr 2024 22:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712960990;
	bh=840tAhIUgUsbJb+DciOBuX15dBYjk7QleC0dzcnetYo=;
	h=From:To:Cc:Subject:Date:From;
	b=Pg3NKjONkSz08Cb2vwHZkhDz2hIZ/wqIBbXmGyDEsND0LIs61WjuYAiupQWXbOs4n
	 Lk6P84jrTM8pwPNdPRWogl4UxsGubl+9uCF82X4/mSO168jdXpMcBOLWlhojVqJN6t
	 oPg15EuiStPfTPlQDtlH918ttCbXdB8jzcJQkDO5ymUfFKXm2cQWESY2RxZBm5A6AM
	 8XrXj5stRnF4cbhzNKSK7F02upNsFpYTrA+wDy6cDYNcqDnKe1W7aPo4WiUfGrOvyh
	 +90lgG7vP5IYujAFv+VKFyxswcymC3Pis7/gw8vNQWoa+PU0Xv/YrS8/p4T9+4y9vt
	 G8z5YN5y+ZYQg==
From: Rob Herring <robh@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: Split PMU nodes for heterogeneous CPUs
Date: Fri, 12 Apr 2024 17:29:41 -0500
Message-ID: <20240412222942.3874269-1-robh@kernel.org>
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

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8956.dtsi |  4 ++--
 arch/arm64/boot/dts/qcom/msm8976.dtsi | 10 ++++++++++
 arch/arm64/boot/dts/qcom/sm4450.dtsi  | 11 ++++++++---
 arch/arm64/boot/dts/qcom/sm8350.dtsi  | 14 ++++++++++++--
 arch/arm64/boot/dts/qcom/sm8550.dtsi  | 19 +++++++++++++++++--
 arch/arm64/boot/dts/qcom/sm8650.dtsi  | 14 ++++++++++++--
 6 files changed, 61 insertions(+), 11 deletions(-)

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
index d2bb1ada361a..1ad102b1633c 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -226,6 +226,16 @@ pmu: pmu {
 		compatible = "arm,armv8-pmuv3";
 		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
+	pmu-a53 {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	pmu_a72: pmu-a72 {
+		compatible = "arm,cortex-a72-pmu";
+		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_RAW(0xf0) | IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
 
 	psci {
 		compatible = "arm,psci-1.0";
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
index 3904348075f6..8e7d0ac17a12 100644
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
+	pmu-a720 {
+		compatible = "arm,cortex-a720-pmu";
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


