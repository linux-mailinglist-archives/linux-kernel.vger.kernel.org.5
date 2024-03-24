Return-Path: <linux-kernel+bounces-115866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86668889853
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B82321C31A7E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B21B1591E1;
	Mon, 25 Mar 2024 03:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxXINo7W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC01145B22;
	Sun, 24 Mar 2024 23:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322022; cv=none; b=Ve10FtAIWDqKUWygdE1eJ7HbVYiz/gMQyi93VC/LqZIO2Lb31VYrCKX4K2hbSPnfbYI4UiUTqCDV9jZ9iL6J2P5p2VeHAP43ceLdXy8GrA+1BodjFkri1aZIuxwH+vxJb/25T1tIMAgyClFmCPlGlKiQDJHp8v5Wo5cVgVCY9IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322022; c=relaxed/simple;
	bh=wCMk0SO3nkSkbyoXdW6YkCpT+RrxE0R8Tjp6ZBwW/uI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sZ45geqnxuMeo0YK929FJ0707/Hhi94xHsNOUQiYMF6LV9NKYTs5ujyaOsvZ1iyAigdRMVA4+KsWp1Se+0YjRumrJbihgoA7TDnLj3hY+AOFoo+vQWONj2sPmKlzyBolXNIDVGE7BRmbq8bAlusNRrma1/j68G0p+1Yevnfif9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxXINo7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60596C43394;
	Sun, 24 Mar 2024 23:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322022;
	bh=wCMk0SO3nkSkbyoXdW6YkCpT+RrxE0R8Tjp6ZBwW/uI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uxXINo7WM9xRTYWmH5pL5RylwfwyHenNsXi6vGV8gPl9/p8OYts+6qLrgP9iaK6go
	 yWJ3eQwXG7r4X+e7fLx/nB9WcPpPpzpJt+wH+hbYP0dF+nAs9tc0pha/w4d1A+/oca
	 oK8kHdGcxo2C6ET6RjRQIQ07Y+d15+9VlOWIoUSESk2LAJRzOmN+iDPmqFs7pGDFWM
	 doQZL6vvdzTB9kbM/Q7PuqXEs9lQw1m/VzH0kYosCuzLtqBKr4gSNgHhrT0XhTbuvX
	 C2csvslGlc+G9rgQQxhHsKBrteBO+33H619NJN9kzNaE3PyyObZrYBlo6Q6f593zk8
	 wglHcGXtpPX8A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 094/451] ARM: dts: renesas: r8a73a4: Fix external clocks and clock rate
Date: Sun, 24 Mar 2024 19:06:10 -0400
Message-ID: <20240324231207.1351418-95-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index e81a7213d3047..4282bafbb5043 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -209,6 +209,18 @@ &cmt1 {
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
index c39066967053f..d1f4cbd099efb 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -450,17 +450,20 @@ clocks {
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


