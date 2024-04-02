Return-Path: <linux-kernel+bounces-128596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A9C895CE8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 836CD1C22ACD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FE715CD49;
	Tue,  2 Apr 2024 19:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mk0akoq/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F9E15B985;
	Tue,  2 Apr 2024 19:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086895; cv=none; b=AfHe7xQkGUavofm+coMrCsCxl3MNgGdDwuceNslWHIHeMhaSsZkGcFZKuCfUD/We3acwiuH2nQ04AVDrLF2dPp19OJ3jbkoScM/eTHYEvznfLCXFe6rsTSQRX+ivy9j/HR9b5kEZHw0++thaQIzmozBGuhixBx6gCAkB2BHLIVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086895; c=relaxed/simple;
	bh=s4lH2zrSCo7QItZFDrrw8fEP1GHeFjp6YZrwFfQRM28=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=soO3B/v4ksCjGtRbBeBZ6WbcY9QABAYQH8BelYHrCwrDU1HyAJcpeJwnLo/Gy5SBjPSvggFaSry7ECezgGNzCuGfZIop95KiWg48sZc7bS5r5nF79QJJO6xOoBlzEyckLNSBo7V/qzpkWrU0cXG6kRzw/wIR0eFCh7Yfw2zvS6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mk0akoq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E099C433F1;
	Tue,  2 Apr 2024 19:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712086894;
	bh=s4lH2zrSCo7QItZFDrrw8fEP1GHeFjp6YZrwFfQRM28=;
	h=From:To:Cc:Subject:Date:From;
	b=mk0akoq/nIeUdisxqbYpa887UmCZI5bIynutXFBZ1pHGMFqq7xcmuQQ6m5hv5xkvH
	 N3IRdp8t9JTFbiPgzQbUab+Wxg1enElDduk5Gin6/faHNbphO2VheFNrdcgZgROWW2
	 h/SqLLekJkKhPhLD8nDz3DwbyfI6sUTpuid3xvkXL1q7SOA4IcGO02ADYF4djxH7fY
	 tj3ueF5rlSpcjBIPnovr/U5eV94V95uMGCNEnBVdj282yj8FloDIbZ9G6WLyy1Qje1
	 mCL8BV+o2G3nPRUPx/WAzCrSw6wBel4tBVi9snyozxfpTADoZfd1SUTHb5GT8nqqxO
	 Uw/QtoVW2EuEA==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/2] arm64: dts: cavium: move non-MMIO node out of soc
Date: Tue,  2 Apr 2024 21:41:28 +0200
Message-Id: <20240402194129.69481-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Non-MMIO devices, which are BTW not really part of the SoC, should not
be within simple-bus, as reported by dtc W=1 warning:

  thunder-88xx.dtsi:374.28-379.5: Warning (simple_bus_reg): /soc/refclk50mhz: missing or empty reg/ranges property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/cavium/thunder-88xx.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi b/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
index 8ad31dee11a3..e29e878ee120 100644
--- a/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
+++ b/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
@@ -365,19 +365,19 @@ pmu {
 		interrupts = <1 7 4>;
 	};
 
+	refclk50mhz: refclk50mhz {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
+		clock-output-names = "refclk50mhz";
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
 
-		refclk50mhz: refclk50mhz {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <50000000>;
-			clock-output-names = "refclk50mhz";
-		};
-
 		gic0: interrupt-controller@8010,00000000 {
 			compatible = "arm,gic-v3";
 			#interrupt-cells = <3>;
-- 
2.34.1


