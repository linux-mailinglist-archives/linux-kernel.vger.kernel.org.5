Return-Path: <linux-kernel+bounces-114099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D18E888F41
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E6C71C2B429
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE44423A770;
	Sun, 24 Mar 2024 23:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8fUsV88"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC71201258;
	Sun, 24 Mar 2024 23:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321401; cv=none; b=akHM+8bZwN/r56i37Y7xsBJIvHqjR+OEK2tAUYfrdYPXt8Sd7E5fbQEQO5ZHl1L/wgz1iZ/xsIsdpcCPv1KaEUYFS9etfdXYpDogQKZjYTXgUmtMoXAo2VOBGKFRMSilsnI5cLNxdRc5WVSfxCvntGNzz/o/E2eHdvLdfatDwTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321401; c=relaxed/simple;
	bh=TX73+o5Zksy/nU+bttvWqBAKEynL0P+CANS8XUJ5u7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BFPJiDbtx+80nfDiNQ6HNSB4U/2ihtt/MmTJ+Apwy6SQeTl3F+bMhnmdK0PgfQjkKFtwJLwobZvd7XCC8pqUaQnTljo4Y4vG2hz1MYEI38AlWO1lGj6l3M2wApabJy/TCy3uSXgBpz48HCns+z5CxzCfvGjxykw9q5nrsJcRXXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8fUsV88; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B802DC433C7;
	Sun, 24 Mar 2024 23:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321400;
	bh=TX73+o5Zksy/nU+bttvWqBAKEynL0P+CANS8XUJ5u7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K8fUsV881lt4fcNfKvaQomFLYGM/GetpCFoFbo33Yt5H/l+91AaYQh1Fn5pzUbQTz
	 4UzRx4IZHbcfXU25g05W7vEABiK/E/qg+ffxiaVcdukqMQYebYeSDxufEHm/WlKVil
	 GjLKdSTqoddrOuLc6VAjKaCL/lflKxCjQW4hCw0s5oyulln8syr6LFpHhyfOz5oMSc
	 nGruWJ6l8bhoS+YS2qFW2NyG61nPE5CAxbXDY3aKk/eYAVtp58vvvxwRqRA5q1sfNT
	 +3nfwvvuNGM95LF7w7mp1VqqYy+eSU9tDhk2zk8rnD9NZKiq8tN6SbyHJuH3AL1Ahs
	 iOo8UdRyVLXSw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 124/638] ARM: dts: renesas: r8a73a4: Fix external clocks and clock rate
Date: Sun, 24 Mar 2024 18:52:41 -0400
Message-ID: <20240324230116.1348576-125-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index e81a7213d3047..4282bafbb5043 100644
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


