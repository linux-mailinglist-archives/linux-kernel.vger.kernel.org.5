Return-Path: <linux-kernel+bounces-112956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E05088800A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F58281504
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9704E86AC6;
	Sun, 24 Mar 2024 22:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnT9ln0s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16E586639;
	Sun, 24 Mar 2024 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319768; cv=none; b=gIY/7iKQ0oriJmL8cBWjiM44zcW8LMrxXU+A/P8RT2P/L2OouTFovMUP3NPOjhz879kyWvCzRHUHnFDwcBMOJm6W8HvsPj3x4PNKtvKFl3aL9sxdInRntXN450ilypYHLTMNwsCWr01ShtJn70qDTUBqk5TRFNZwyrY/ghmJQ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319768; c=relaxed/simple;
	bh=YEPz7/LV8rFX1YoEpidCsvFq2drnraVPp+Gh9O1b24A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mpQqSspokHmZAVfPFjU+XYXlJ92YueeD31jRFiV0SeHik2lVFjWu50H6fhU54WYUDzrQ066MnffuArsOPYH9Ldx3KPf2cTY9FZ1AHL3thKOv65PIPq0NecIDL6hoyufKt4EZlfByssOVFrJpJHRCL7RIOPpYkJ0hk/8JCM6V7Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnT9ln0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04887C433C7;
	Sun, 24 Mar 2024 22:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319768;
	bh=YEPz7/LV8rFX1YoEpidCsvFq2drnraVPp+Gh9O1b24A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CnT9ln0si4zb+R+cnsdINgv4DGk32lP37EY6RiQmP7iYWS7afhAPy0RTNRoix9ZZu
	 Gkmnb7RH80tykym0fnOoGT/jxiQmD9pmwIaJI38s21M/h0QAR4/SeZY6OlJKH/qJGN
	 QEtMGxaty32H+d4l8TnPrxf3XC01tdm93gJ9Zi6atHg+ze9U2yWm8dGjmkDAtn+YeG
	 tyV+nm4BCUkYlnx7l6EFFC/ZeSw3W8QVj07GwCIkbVSgL3hlmBCi9ckXgaJ/TUTH3N
	 mdAHjXrPtc5KyLde8u2QAf/7QyY2C2DYC579vdQiKCmwL0dUSKQz7+KOyRzOAhXtra
	 5LDFYhzlHToJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 069/715] ARM: dts: renesas: r8a73a4: Fix external clocks and clock rate
Date: Sun, 24 Mar 2024 18:24:08 -0400
Message-ID: <20240324223455.1342824-70-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
 arch/arm/boot/dts/renesas/r8a73a4-ape6evm.dts | 12 ++++++++++++
 arch/arm/boot/dts/renesas/r8a73a4.dtsi        |  9 ++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/renesas/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/renesas/r8a73a4-ape6evm.dts
index ed75c01dbee10..3d02f065f71c2 100644
--- a/arch/arm/boot/dts/renesas/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/renesas/r8a73a4-ape6evm.dts
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
diff --git a/arch/arm/boot/dts/renesas/r8a73a4.dtsi b/arch/arm/boot/dts/renesas/r8a73a4.dtsi
index c39066967053f..d1f4cbd099efb 100644
--- a/arch/arm/boot/dts/renesas/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/renesas/r8a73a4.dtsi
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


