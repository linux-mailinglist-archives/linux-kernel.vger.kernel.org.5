Return-Path: <linux-kernel+bounces-128633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0F4895D45
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0FE1C220EE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9114615D5CD;
	Tue,  2 Apr 2024 20:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3X34J4w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10B515D5BE;
	Tue,  2 Apr 2024 20:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712088475; cv=none; b=deU7LW0W+OPUfBbs4r2crMZYx2OHugJ2gqwd4dFIwrY21qn8w1BDZjnYjdFBhWvpb/m6BicIE5lyaENpKLR5Rpkzn3gRWtxKCXva9d8LO6QguJTUNeFtbkQq4gqYMrlofNt1EV/PsO00Qqzg08v3JIAemZJfMC1M8+45wmnqDwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712088475; c=relaxed/simple;
	bh=fQtdRGcuT1arJCs0mUc7nrp+KeOPsHpW6nViZkBBPEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e9RDfWeSuUmM8ZOUUEgmrQ8N81gkUqAmW9b9DTIsAfN9PRkXvV+J6R9r8BMkuTAIr2rI726BVVutFdEUj/viJyMrvjW5phL3CDFgiNAk9zUVlm2SgvcrbmqqpBCDHoYmvxgOM5UytGL/52OP5sjE5DiVpuxh0bsgTTX53FqrK38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3X34J4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DE4C433B1;
	Tue,  2 Apr 2024 20:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712088475;
	bh=fQtdRGcuT1arJCs0mUc7nrp+KeOPsHpW6nViZkBBPEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l3X34J4wQnMsrtnO6oaY+c471ieTWJoMAZJRrJxe+NhiIMsY9IO6QIyyFaGIHZoKr
	 sVKd72D6Y2s16WQgKpiHCznqh8zEZDq0pXxx8dhVlTpmIlNvY00hbLbVIEbsrqeQpu
	 6G2jAi/gNfaE6aOg4n9dJMYEsdTDYhCAkhcaJgLO2+ufYIVz2T9dXLQcuQWKP0J25N
	 a9VqUooGF5XempjITfU+EsKtgrY5dVGGalMkAfqsfjzcJs3ShYUv3ZXTujGjYJqLll
	 zYILn7oC3BTwbXlqt7UJ+RU4vOQGVQdFoSn3ANDJCH1AOPWnvRUBWN1XfBkAAZvkir
	 3hT0beXFdWNIg==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tsahee Zidenberg <tsahee@annapurnalabs.com>,
	Antoine Tenart <atenart@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/5] arm64: dts: amazon: alpine-v2: move non-MMIO node out of soc
Date: Tue,  2 Apr 2024 22:07:41 +0200
Message-Id: <20240402200744.79349-2-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402200744.79349-1-krzk@kernel.org>
References: <20240402200744.79349-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Non-MMIO devices should not be within simple-bus, as reported by dtc W=1
warning:

  alpine-v2.dtsi:100.9-106.5: Warning (simple_bus_reg): /soc/timer: missing or empty reg/ranges property
  alpine-v2.dtsi:108.7-114.5: Warning (simple_bus_reg): /soc/pmu: missing or empty reg/ranges property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/amazon/alpine-v2.dtsi | 33 ++++++++++++-----------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/amazon/alpine-v2.dtsi b/arch/arm64/boot/dts/amazon/alpine-v2.dtsi
index 32b6ac8a5352..5b6b58dd44cb 100644
--- a/arch/arm64/boot/dts/amazon/alpine-v2.dtsi
+++ b/arch/arm64/boot/dts/amazon/alpine-v2.dtsi
@@ -39,6 +39,7 @@
 / {
 	model = "Annapurna Labs Alpine v2";
 	compatible = "al,alpine-v2";
+	interrupt-parent = <&gic>;
 	#address-cells = <2>;
 	#size-cells = <2>;
 
@@ -89,6 +90,22 @@ sbclk: sbclk {
 		clock-frequency = <1000000>;
 	};
 
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
@@ -97,22 +114,6 @@ soc {
 		interrupt-parent = <&gic>;
 		ranges;
 
-		timer {
-			compatible = "arm,armv8-timer";
-			interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
-				     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
-				     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
-				     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
-		};
-
-		pmu {
-			compatible = "arm,armv8-pmuv3";
-			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
 		gic: interrupt-controller@f0200000 {
 			compatible = "arm,gic-v3";
 			reg = <0x0 0xf0200000 0x0 0x10000>,	/* GIC Dist */
-- 
2.34.1


