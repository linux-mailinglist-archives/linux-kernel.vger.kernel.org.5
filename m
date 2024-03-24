Return-Path: <linux-kernel+bounces-114764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967E4889115
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5215029354D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7A21B7F50;
	Mon, 25 Mar 2024 00:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSNZJWaz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACD2275506;
	Sun, 24 Mar 2024 23:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323361; cv=none; b=hoQf2Gk4ZqhUSkjCwp+uM6JY10ZqPQOt6ITz3kNt9pdKcMl4emONJ1MfJ7TaNSu4wNh1TRnu10XSu+y5sr4akFI7Yau23bU0LdsRzVx51DZm1IlZPs/7XAP+CRFYcA1a4CaLa/G8vzNXTucakj1h44kuIqYFwQzsajzioQkzm8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323361; c=relaxed/simple;
	bh=BqRZ8WtyK5fDkufOYUbNRatwBSbGsOt68dnAvr75fBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fGlwRI0MjKnB2sUGD+uWLdntnOmfSKi7aSCFOsPwnCgJ+bp4lVMjvws8e3Ti0t57+m0y5j4kO9FYhE7whB8lRDAbU5ooXFEDmhILjsbHrNiHSg65aGIMj397javQyB98XJ0wQrSX7J2W+0ppfrpllrLniWV8qqEYiSDr24ok7s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSNZJWaz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9620BC433F1;
	Sun, 24 Mar 2024 23:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323360;
	bh=BqRZ8WtyK5fDkufOYUbNRatwBSbGsOt68dnAvr75fBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oSNZJWazxD9oBwHFaCk8VCGTiRjl5I/GKUdmx13y/59zXgoaYR3gklP6/wJShSTUh
	 x8kB++Qpjh7eeUiFegOENrh1TsFo8rm0IJP7Y5Iu+72VdB4SXr7hdpBiMzLq5XKNS4
	 JyW6D7iTSAPs7QUcmD5+WBalFwSehTAnHAjW+LESHGs+FDLTE3ZSZImCGJ9h6q50aS
	 EXSjFdfhG28Siw3Nf6BUj7KHFKQCtS2EfR5wBs0PrZuF+93KpySXG2h4+UMzAiimT7
	 6P50KKAx0k/PgVQGLIMaideyea7gWk8UNSM/qwoMT9stYN/LoPKdyLLZi6uHBE7DaB
	 AwalicZTzDXyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 060/317] ARM: dts: renesas: r8a73a4: Fix external clocks and clock rate
Date: Sun, 24 Mar 2024 19:30:40 -0400
Message-ID: <20240324233458.1352854-61-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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


