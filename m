Return-Path: <linux-kernel+bounces-69919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B1185903D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6161F21916
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5594E7C0BB;
	Sat, 17 Feb 2024 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtrUsh6b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744257B3D0;
	Sat, 17 Feb 2024 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708182084; cv=none; b=hX2EO9niyacKZhh6gwaZ6pGAYdt0ESrwSxWAkfvnQtF0kSeDIl7Q/g28VyKQhRQ8FATaVRdIFOhnMshjqShb3LnHy8851dr2dYFS0tjUXNnmx1goAhwq91umhXyOJqADk4FxoqTtWNb1ecOA+8uY2rLTYl7EYgxxPQukry8xmGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708182084; c=relaxed/simple;
	bh=IojVOTkkmUgO8R4R5BC+JvxU3MusAnoRWz5cmE/Gqjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ROUHKwGG1uS7o5CcSzRkLZJni/Ly4zwLMsv7lflI9CxMqQZ3sYR9gBye91pM3SE3A2QwVlai3F2nNnQgBRllIilkPVBUttQyxGOsRw/XlfsYNO+EyrRLwMuLA6MLRTrWT0j9MmzSyavFXQI/PAJaqKKCGF21+kJ2EI8IRfpDgv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtrUsh6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD4EC433F1;
	Sat, 17 Feb 2024 15:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708182083;
	bh=IojVOTkkmUgO8R4R5BC+JvxU3MusAnoRWz5cmE/Gqjc=;
	h=From:To:Cc:Subject:Date:From;
	b=CtrUsh6bwVqhdBGdyOuDk0xtJef3k8N8vCn7a3CH5JXonVHQxfPDLMFYZdVsQDVWk
	 +bjGkaUhzstRRxhqn8KOlfclvoHzFFGzo67TuaoxpU8lmWHjta9QxHjyN8o/C3jf0y
	 PjMVYo4N6IeVR9dOnA/e47OtlC4ClvurnxM7fFTS6D0nfUzgLPukjzTlGm1O7ag76A
	 lhj0tWdeUNi2x9yXHIeHYzB/mKh4DraVWbyGjO4sUL83gBliNF7T4BXhGmXzHVrEli
	 ZU4VJRgjOqQiF9rXK/MXwDUC8+TcX1EnGeGiIYuYkoK0ndebkMu2qVS/x4TZ/z42ey
	 OkyO12z0GoLKQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH RFC] riscv: dts: sophgo: add sdcard support for milkv duo
Date: Sat, 17 Feb 2024 22:48:26 +0800
Message-ID: <20240217144826.3944-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add sdhci dt node in SoC dtsi and enable it in milkv duo dts.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
Since cv1800b's clk support isn't in, this patch uses fixed dummy clk
and just RFC, I will send formal patch after clk support is ready.

 .../riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts |  8 ++++++++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi          | 17 +++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
index 3af9e34b3bc7..94e64ddce8fa 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
+++ b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
@@ -33,6 +33,14 @@ &osc {
 	clock-frequency = <25000000>;
 };
 
+&sdhci0 {
+	status = "okay";
+	bus-width = <4>;
+	no-1-8-v;
+	no-mmc;
+	no-sdio;
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
index 2d6f4a4b1e58..405f4ba18392 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -4,6 +4,7 @@
  * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
  */
 
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
@@ -45,6 +46,13 @@ osc: oscillator {
 		#clock-cells = <0>;
 	};
 
+	sdhci_clk: sdhci-clock {
+		compatible = "fixed-clock";
+		clock-frequency = <375000000>;
+		clock-output-names = "sdhci_clk";
+		#clock-cells = <0>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
@@ -175,6 +183,15 @@ uart4: serial@41c0000 {
 			status = "disabled";
 		};
 
+		sdhci0: mmc@4310000 {
+			compatible = "sophgo,cv1800b-dwcmshc";
+			reg = <0x4310000 0x1000>;
+			interrupts = <36 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sdhci_clk>;
+			clock-names = "core";
+			status = "disabled";
+		};
+
 		plic: interrupt-controller@70000000 {
 			reg = <0x70000000 0x4000000>;
 			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
-- 
2.43.0


