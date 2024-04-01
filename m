Return-Path: <linux-kernel+bounces-126731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F92893C0B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B7B61F23B71
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37CE524BE;
	Mon,  1 Apr 2024 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKqntH8U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F65B40C15;
	Mon,  1 Apr 2024 14:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980702; cv=none; b=H7gh5C+aJl+Q8vLG21Xdr2cqH6PHlJJLRNApMnDjYMy/Unyz2u9tFQV5RmQ4yal+pTsQ7UYtJ9xEPauUeJmvRXkJxMWFE5nKSLx5WlIFDiN+zNbm8/+ZRDWRcW7QHxNuymTo3SogK4hSxTrPdx2o3BZ+DXf7G2ysRDZ2MuOJL5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980702; c=relaxed/simple;
	bh=SJ3FuiPHm5ehl3YVj0XJofbWh8NGcWd66diQG3ld5a8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PEZDOay3G4MauI1ByA6rkxkmc3es0z48M2Wurxu1SLXDMPyIuW0nnRCMPwPAVgVo7zIPr7l6t/akv6UoLeO5UMGfZYbmp5gjaAonQUA7qyTA1b4VA5S2efnDzmZab1hCGrEAVnb5J12tmSY9HFVmDenW8y6O55u6sZ+X2VggXR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKqntH8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1451FC433F1;
	Mon,  1 Apr 2024 14:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711980700;
	bh=SJ3FuiPHm5ehl3YVj0XJofbWh8NGcWd66diQG3ld5a8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WKqntH8UFOKswPhdxB4/TXmxxXHJjzq5pvgugdTeV/NKzneIrLfflSz7Fh/Emy0er
	 NfxRY5C+rJ23qpAFrrwBbVQk5l+FFgTN0h8EuB8qfPkSxJRiCW8s69TjfiuAf0acLj
	 pUGfjg7pQpTAtO2KSqPmoYt+9MGOJ/UXDgev9EIM3pNRENGEaEfcDHEC8vslFRR7tz
	 L/N0Y5kcrEunQ77ErNR5KbYDDutXyhztfme0UIs7IjtEfxHBixdO32Ty7KZMWeJ5/3
	 EdZzXX/WvyrEP3tfXXpRk8p2qNw1qwy1RvWbESBhlhWZrDzoQTGImdQuE1B5tC3TIG
	 CoHpSGMu4yD0w==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/5] arm64: dts: sc9860: move GIC to soc node
Date: Mon,  1 Apr 2024 16:11:26 +0200
Message-Id: <20240401141128.98317-3-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401141128.98317-1-krzk@kernel.org>
References: <20240401141128.98317-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All devices on MMIO bus should be within the "soc" node.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested on hardware.
---
 arch/arm64/boot/dts/sprd/sc9860.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/sprd/sc9860.dtsi b/arch/arm64/boot/dts/sprd/sc9860.dtsi
index e875dc8e3d98..16be9a405267 100644
--- a/arch/arm64/boot/dts/sprd/sc9860.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9860.dtsi
@@ -135,18 +135,6 @@ CLUSTER_PD: cluster_pd {
 		};
 	};
 
-	gic: interrupt-controller@12001000 {
-		compatible = "arm,gic-400";
-		reg = <0 0x12001000 0 0x1000>,
-		      <0 0x12002000 0 0x2000>,
-		      <0 0x12004000 0 0x2000>,
-		      <0 0x12006000 0 0x2000>;
-		#interrupt-cells = <3>;
-		interrupt-controller;
-		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8)
-					| IRQ_TYPE_LEVEL_HIGH)>;
-	};
-
 	psci {
 		compatible = "arm,psci-0.2";
 		method = "smc";
@@ -185,6 +173,18 @@ pmu {
 	};
 
 	soc {
+		gic: interrupt-controller@12001000 {
+			compatible = "arm,gic-400";
+			reg = <0 0x12001000 0 0x1000>,
+			      <0 0x12002000 0 0x2000>,
+			      <0 0x12004000 0 0x2000>,
+			      <0 0x12006000 0 0x2000>;
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8)
+						| IRQ_TYPE_LEVEL_HIGH)>;
+		};
+
 		pmu_gate: pmu-gate {
 			compatible = "sprd,sc9860-pmu-gate";
 			sprd,syscon = <&pmu_regs>; /* 0x402b0000 */
-- 
2.34.1


