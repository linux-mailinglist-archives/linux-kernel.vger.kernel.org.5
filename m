Return-Path: <linux-kernel+bounces-115064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BF6888CD6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4B528FB7D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F17C2F2D7B;
	Mon, 25 Mar 2024 01:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWcJsiUe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2C62892B5;
	Sun, 24 Mar 2024 23:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324039; cv=none; b=j6rqFm1/VNSEcuQznymoUary0AWr0RRrE20eozJFK7fmCy7vNvibMGPq6TnKlzCC75qzonX1GPO1ct4ehnPD/NllS2yAScsNcSYsuJ3M4YJYaK/eeACv7U+BU5y5jX/+vQTEP6rrfMkjpPCOfYoTreniKXxRIfdBpDrZX12FltQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324039; c=relaxed/simple;
	bh=McbMIX7Ej9DjfcJa/tptOsZymK3j6hDK6cy4Oi3Af4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/ZsX0KeSA1d8AUyWRV+dQTj6Jtwl8q8qz5jdjszY/1PwVnJBt8XCL9jO57e5RRdTdmmlnNFVs1N/6I//XsRdspiBJtmcCrZ0CuTkzMfxgTs3cRI0pE6jL29dr9v8PpzdL6az0eopMNOLpVrMoCzccHmRMzaF5b/2FSIummz96M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWcJsiUe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A827EC433F1;
	Sun, 24 Mar 2024 23:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324038;
	bh=McbMIX7Ej9DjfcJa/tptOsZymK3j6hDK6cy4Oi3Af4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DWcJsiUegsiav9ffKlKC4Vo2HbRllesIICnd4bTlAAxgOWmzP0Fqeh/C8gsMyDLgC
	 FmdHIkhQf6EwxXrvuxpNMeW8O5nmfsnuR9C2Q7I/9HYBAdzqoGb78ffRSVXsRWPxs1
	 00N71aUfzH36Y6B2Stlltw95gm1DzvLuNM5666xgdldDxpKxLbeC1IOq+bOV+Oqoi6
	 wMJayZ9uIuoM5qP8Lm1NL/5D5Jvj92/3YSTJy2zdleb0W5ol2BN8aDlUXazscAVnd2
	 KYZdJvBouPH9Z84iWi5pHxVSEvjYqIXWRl6bL+YjznJOfDF1iUkZXsDxCNpC+YOqY9
	 kErGM1esVgC9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 039/183] ARM: dts: renesas: r8a73a4: Fix external clocks and clock rate
Date: Sun, 24 Mar 2024 19:44:12 -0400
Message-ID: <20240324234638.1355609-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 090c4094574705b0afc7d37825cdc5d06f0e7e02 ]

External clocks should be defined as zero-Hz clocks in the SoC .dtsi,
and overridden in the board .dts when present.

Correct the clock rate of extal1 from 25 to 26 MHz, to match the crystal
oscillator present on the APE6-EVM board.

Fixes: a76809a329d6ebae ("ARM: shmobile: r8a73a4: Common clock framework DT description")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Link: https://lore.kernel.org/r/1692bc8cd465d62168cbf110522ad62a7af3f606.1705315614.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts | 12 ++++++++++++
 arch/arm/boot/dts/r8a73a4.dtsi        |  9 ++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index a5351ddbf5060..a396f403c9091 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -211,6 +211,18 @@ &cmt1 {
 	status = "okay";
 };
 
+&extal1_clk {
+	clock-frequency = <26000000>;
+};
+
+&extal2_clk {
+	clock-frequency = <48000000>;
+};
+
+&extalr_clk {
+	clock-frequency = <32768>;
+};
+
 &pfc {
 	scifa0_pins: scifa0 {
 		groups = "scifa0_data";
diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 4447f45f0cba9..48121ef690c9d 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -494,17 +494,20 @@ clocks {
 		extalr_clk: extalr {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			clock-frequency = <32768>;
+			/* This value must be overridden by the board. */
+			clock-frequency = <0>;
 		};
 		extal1_clk: extal1 {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			clock-frequency = <25000000>;
+			/* This value must be overridden by the board. */
+			clock-frequency = <0>;
 		};
 		extal2_clk: extal2 {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			clock-frequency = <48000000>;
+			/* This value must be overridden by the board. */
+			clock-frequency = <0>;
 		};
 		fsiack_clk: fsiack {
 			compatible = "fixed-clock";
-- 
2.43.0


