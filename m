Return-Path: <linux-kernel+bounces-114959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA3C888C32
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6CB1F28514
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B912DE231;
	Mon, 25 Mar 2024 00:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTo2cz4C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128932811D2;
	Sun, 24 Mar 2024 23:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323678; cv=none; b=PJV295vLiXNtkV2dXFiBvcFKdpq7+5kCLn31jKz9ZPUq6zRI7lNtfwmH7VgJIEbZV4eqOFH2lwCJNAP7uA+0El0XxoBR9AbrmvggCZa2gi0wkr8grR1csCisTQHK8PjbtHY6KFtIMvueJPFvR0IZJIxcB3qvRJxgH58XsRMIQng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323678; c=relaxed/simple;
	bh=ATb1YtUcp7NvYmx4HjbB58j2NBFLq651YIr/cfDjZ2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UHs2eox909DExnAPdNPAZAaTOIgSBOiq1QcudAZ5GuUW4nmCZhcjoaVn297ZbW2csBN58k1ZiWdtc3tkGKCVVk7iMn2q1X1FA2SqUGCY9jSNF1AMzhE+JpReLXqTnR96kxoKZjsWQjryGPfHOz5ZDa2iwzw9+QrsYxEohCYhCy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTo2cz4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528D1C43394;
	Sun, 24 Mar 2024 23:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323676;
	bh=ATb1YtUcp7NvYmx4HjbB58j2NBFLq651YIr/cfDjZ2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XTo2cz4CepZh4/QJ1jNhWq/HWW1rI9SIz3UeiyDQsuQpp6QvFgkpP6QDvUMHlsiJ9
	 11MEnR8YSkuP96dLAfVn/tfm4Z14tdBJUuXcRwmQJ/6jhKkEGpwprK/DsHNmyajWuc
	 MfhSuBYsa+11ecIMfPS5XwQdX7BX3gg7xKUM7pyvFhIn87wiPIqwvFfB8XOrh19c0e
	 gemDy3mtGoWscOWsbVZubBPaFKP8J+VHDritKniQo6j54D+RC/aKNUkdGt87nReo/5
	 lE30buOKfPJ/Z5AebVqzaLuG4Vb7YYCSK6nxPS3F06BImsLh8zQkt6p0srGRPm4bve
	 GBbCDqJ2b0sZg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 049/238] ARM: dts: renesas: r8a73a4: Fix external clocks and clock rate
Date: Sun, 24 Mar 2024 19:37:17 -0400
Message-ID: <20240324234027.1354210-50-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index b088e8e351d54..1028f721b38b0 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -208,6 +208,18 @@ &cmt1 {
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
index e5fb1ce261f72..bcde8d1005976 100644
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


