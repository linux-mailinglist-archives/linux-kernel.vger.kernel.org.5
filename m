Return-Path: <linux-kernel+bounces-143409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6488A3892
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 00:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714F1284571
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A7E152507;
	Fri, 12 Apr 2024 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAE9upkI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EC6147C9A;
	Fri, 12 Apr 2024 22:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712960978; cv=none; b=SPSznsa9v3a5fQy38aHcqeODSLgHT3ikrUPX85SQikk1EBSVzXqrz+EhaZoH4nY148MV4APchoDomtTgbWvQhruDKOo1kKJTN/j1yNyekpoIYtV8XyZzuqREII2jZpB79QJSbz5ts7LFr1hhOOpc7seDGZnmkn41m1+9l8+Zlpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712960978; c=relaxed/simple;
	bh=HWlSNSzNydaMeQStEb5EXv5WktdHgAn9YeBEYdUC28c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cr2+witxHuhga98gj1aMHElLzY8WDUSJ/LWBSGrUvcoWmpz7Tj4fFiSzp2VerjzG4HVCO3Va4yEa6Kg+cyrh8B5XfMr5S3hJMPxo7b5lfCc2yRmht/Fle97KAfJJ7gRGIEh2gNJ/4u4aHGxVk2FYL9mWtx7wwmi9xWFeg9+Pvss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAE9upkI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36320C113CC;
	Fri, 12 Apr 2024 22:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712960978;
	bh=HWlSNSzNydaMeQStEb5EXv5WktdHgAn9YeBEYdUC28c=;
	h=From:To:Cc:Subject:Date:From;
	b=dAE9upkIAiJC1u+Yyml0Un2UD8dKUzvpPGNunaI8cO5+2Gaz492Rui8r0dDwODz1o
	 ca5BjCEvGyomDqjplJrqB6R7cZ/kIf3deFjriQ0vY+oP1WYQ+Ie0AiP2HavpYMDFOC
	 2E7sQBImDPsroAikLHszoAlPPMfliWa/HVV4mlMwcR9Yk5xLzRTV+d2if5DXCOfSXY
	 mm0Ie1zQBkmcQnwfCeEDJAyQxNWreYRJquHTcJTos/Z2o4PPYEtjVwKyxeWhO6MIrv
	 wQ1J+r6j+qOWfHPTS78zCW1wFLs3ct9TvYHlxALawhEWxxt2Q/+Lp19Jd4NDML6P/n
	 4/BDZAhkl3gaw==
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: sprd: Split PMU nodes for heterogeneous CPUs
Date: Fri, 12 Apr 2024 17:29:22 -0500
Message-ID: <20240412222923.3873814-1-robh@kernel.org>
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

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/sprd/ums512.dtsi  | 14 ++++++++++----
 arch/arm64/boot/dts/sprd/ums9620.dtsi | 14 ++++++++++----
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/sprd/ums512.dtsi b/arch/arm64/boot/dts/sprd/ums512.dtsi
index dbdb79f8e959..4c080df48724 100644
--- a/arch/arm64/boot/dts/sprd/ums512.dtsi
+++ b/arch/arm64/boot/dts/sprd/ums512.dtsi
@@ -136,16 +136,22 @@ timer {
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>; /* Hipervisor PPI */
 	};
 
-	pmu {
-		compatible = "arm,armv8-pmuv3";
+	pmu-a55 {
+		compatible = "arm,cortex-a55-pmu";
 		interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&CPU0>, <&CPU1>, <&CPU2>, <&CPU3>, <&CPU4>, <&CPU5>;
+	};
+
+	pmu-a75 {
+		compatible = "arm,cortex-a75-pmu";
+		interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&CPU6>, <&CPU7>;
 	};
 
 	soc: soc {
diff --git a/arch/arm64/boot/dts/sprd/ums9620.dtsi b/arch/arm64/boot/dts/sprd/ums9620.dtsi
index 2191f0a4811b..2458071320c9 100644
--- a/arch/arm64/boot/dts/sprd/ums9620.dtsi
+++ b/arch/arm64/boot/dts/sprd/ums9620.dtsi
@@ -144,16 +144,22 @@ timer {
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>; /* Hipervisor PPI */
 	};
 
-	pmu {
-		compatible = "arm,armv8-pmuv3";
+	pmu-a55 {
+		compatible = "arm,cortex-a55-pmu";
 		interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&CPU0>, <&CPU1>, <&CPU2>, <&CPU3>;
+	};
+
+	pmu-a76 {
+		compatible = "arm,cortex-a76-pmu";
+		interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&CPU4>, <&CPU5>, <&CPU6>, <&CPU7>;
 	};
 
 	soc: soc {
-- 
2.43.0


