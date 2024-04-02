Return-Path: <linux-kernel+bounces-128638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE22895D4F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB3D1C22B25
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F127115E5A2;
	Tue,  2 Apr 2024 20:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOder+cG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395B815D5CD;
	Tue,  2 Apr 2024 20:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712088506; cv=none; b=AMDRyYf45M6x85nb6mfbDqQ9Bc3dQsqKTZnSGPiLbyJOpyoX/I7CVnxy5ufchX3vR+6niG/az1pXI1/qEKdwBDaxEPRn7WiQ5ktIbwVPXdJQnh3eGrZ7A5EN2QtnPuJTOn0GNfMAcyhu2cXazARB7uF5fEPF3OQTAdt0mF4zz/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712088506; c=relaxed/simple;
	bh=xJrjfeejgwexYe9JI005KYx6J/N/bRUh8/FNLcIbp14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l5dxPMzCiRtZsQFRp8xkFkS/fXcB8qdHEy93frvn//IuKI1LSsCR1f+wJ6dyIMrr5PuuScvnJvOn+YTZ46XZ/iN2BOYVADTLuoFuSJoyODisI2psCdfzL1m4jzii6sZpSywN9PcELXMU51YDk0Xt+J3Q+iFcfgqALr5vREBczZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOder+cG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF31EC43141;
	Tue,  2 Apr 2024 20:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712088506;
	bh=xJrjfeejgwexYe9JI005KYx6J/N/bRUh8/FNLcIbp14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bOder+cGRQRDIPbbx1FfcO9v8uAQrkKK0LrsVtXY79H97uKsCCLRkqoq4g2+QYVJ8
	 mPWexbVvgkJ3PdeV0QnYtpa9ID6+nC+sZd4U00lTJABO1nC5Wf51ISb5yPmuPybRXw
	 CHce4fmqZLcfz2AvjI2cN3CfCbjq5oalRg3Zo0zb0fogpIO82ygf2Q9znr6e0VAdmS
	 IPrYwUsqTIxQ7LSjMYoLGjXVpS3TgRaZ7gSRJNMO0KtKgWGi5OTp8FE30D0199Bi5A
	 sv+IHm1rv+JN9xFYGcwqW1xQ1oY5Uxi+OzMTZAi+KGpf8OQ3xRAGvLl5b81QSeff41
	 Vvr6A3lzdAysQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Khuong Dinh <khuong@os.amperecomputing.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/2] arm64: dts: apm: shadowcat: move non-MMIO node out of soc
Date: Tue,  2 Apr 2024 22:08:18 +0200
Message-Id: <20240402200818.79446-2-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402200818.79446-1-krzk@kernel.org>
References: <20240402200818.79446-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Non-MMIO devices, like fixed-clocks, should not be within simple-bus.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
index 65ebac3082e2..ea5721ea02f0 100644
--- a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
@@ -211,6 +211,13 @@ v2m15: v2m@f0000 {
 		};
 	};
 
+	refclk: refclk {
+		compatible = "fixed-clock";
+		#clock-cells = <1>;
+		clock-frequency = <100000000>;
+		clock-output-names = "refclk";
+	};
+
 	pmu {
 		compatible = "arm,armv8-pmuv3";
 		interrupts = <1 12 0xff04>;
@@ -236,13 +243,6 @@ clocks {
 			#size-cells = <2>;
 			ranges;
 
-			refclk: refclk {
-				compatible = "fixed-clock";
-				#clock-cells = <1>;
-				clock-frequency = <100000000>;
-				clock-output-names = "refclk";
-			};
-
 			pmdpll: pmdpll@170000f0 {
 				compatible = "apm,xgene-pcppll-v2-clock";
 				#clock-cells = <1>;
-- 
2.34.1


