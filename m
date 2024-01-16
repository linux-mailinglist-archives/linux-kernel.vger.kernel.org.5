Return-Path: <linux-kernel+bounces-27974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A53882F88D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958B828C348
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058BA25562;
	Tue, 16 Jan 2024 19:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPIjnQIM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE591F5F3;
	Tue, 16 Jan 2024 19:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434730; cv=none; b=Z/Zj2vyyitw8pg95pDn3V6e8cc4MRQJUw9pt2ObaeGnw6oyqH7bQgb/6RPEri4SVdgzoJRvG29e38UPyAAa34uyrUTAet9Kllh7K4RQt7AtCgTT9VBCLpsy8kYRmB1Zj6FUlUBtfIqK5TVTIdwHL1ANU0Bj9pGFL9HvvKSsuVEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434730; c=relaxed/simple;
	bh=HlzBsDp6k6DRdPQsKDOA1wu2AKK9wqQg1A7h1nmaL/A=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=KnGIIM/dAidzc24i2AligTSZxHCJMxwqA2uqOtlrM6oHHW0JpTdnLfbKfUlVH20taJcKKPjjqisACmDFQ+FZH+8YJeJb2nDYdXdbMIK94FokoHMOq58hvDp1R8ke6rFB4EDqYeqQAKFQJSE97NZdiqjSF5d7e/t7If/oluxUIvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPIjnQIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D23C433F1;
	Tue, 16 Jan 2024 19:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434730;
	bh=HlzBsDp6k6DRdPQsKDOA1wu2AKK9wqQg1A7h1nmaL/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hPIjnQIMHxkULEcKObHEKQxX0QpaeB5SqwllCu/Pcw8/Pn/sVa7WqCHiJkz2fNp4A
	 2A4l8Jtp2Pwlg+aDj0m9BWUXzCZ6tXVZa5T0C8AQbSWVT08MmQgqWeAsbd4VQM3tDz
	 O6qhEfAAx0w1EqHXFdHLP5aTBnJw0ooiibL/JlgclKU3N6BEtFyf3Bj+xsam4uaBcO
	 0tgMKsNVduVQwqC0mp7pLsd7t0Hdt5gMkHQNkVXE3NsCTDRKEwsABPDSNsLOCLYTSb
	 I4c1qZ6de9pGJriI441vPw+3v/Z8mXldqyuJ290/VB0+peEsT+hINnyJjQVo7prdN4
	 Y6Xww9ka46H7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	harini.katakam@amd.com,
	manikanta.guntupalli@amd.com,
	ashok.reddy.soma@xilinx.com,
	laurent.pinchart@ideasonboard.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 063/104] arm64: zynqmp: Move fixed clock to / for kv260
Date: Tue, 16 Jan 2024 14:46:29 -0500
Message-ID: <20240116194908.253437-63-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Michal Simek <michal.simek@amd.com>

[ Upstream commit 6a10a19a6bd2fd8d27a510678bf87bd9408f51d8 ]

fixed clock nodes can't be on the bus because they are missing reg
property. That's why move them to root.
And because it is root it is good to have it as the first node in a file.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 28 ++++++++---------
 .../boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso | 30 +++++++++----------
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
index ae1b9b2bdbee..dee238739290 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
@@ -21,20 +21,7 @@
 /dts-v1/;
 /plugin/;
 
-&i2c1 { /* I2C_SCK C23/C24 - MIO from SOM */
-	#address-cells = <1>;
-	#size-cells = <0>;
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_i2c1_default>;
-	pinctrl-1 = <&pinctrl_i2c1_gpio>;
-	scl-gpios = <&gpio 24 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio 25 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-
-	/* u14 - 0x40 - ina260 */
-	/* u27 - 0xe0 - STDP4320 DP/HDMI splitter */
-};
-
-&amba {
+&{/} {
 	si5332_0: si5332_0 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -72,6 +59,19 @@ si5332_5: si5332_5 { /* u17 */
 	};
 };
 
+&i2c1 { /* I2C_SCK C23/C24 - MIO from SOM */
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1_default>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio 24 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio 25 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+
+	/* u14 - 0x40 - ina260 */
+	/* u27 - 0xe0 - STDP4320 DP/HDMI splitter */
+};
+
 /* DP/USB 3.0 and SATA */
 &psgtr {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
index b59e48be6465..73c5cb156caf 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
@@ -16,21 +16,7 @@
 /dts-v1/;
 /plugin/;
 
-&i2c1 { /* I2C_SCK C23/C24 - MIO from SOM */
-	#address-cells = <1>;
-	#size-cells = <0>;
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_i2c1_default>;
-	pinctrl-1 = <&pinctrl_i2c1_gpio>;
-	scl-gpios = <&gpio 24 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio 25 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-
-	/* u14 - 0x40 - ina260 */
-	/* u43 - 0x2d - usb5744 */
-	/* u27 - 0xe0 - STDP4320 DP/HDMI splitter */
-};
-
-&amba {
+&{/} {
 	si5332_0: si5332_0 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -68,6 +54,20 @@ si5332_5: si5332_5 { /* u17 */
 	};
 };
 
+&i2c1 { /* I2C_SCK C23/C24 - MIO from SOM */
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1_default>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio 24 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio 25 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+
+	/* u14 - 0x40 - ina260 */
+	/* u43 - 0x2d - usb5744 */
+	/* u27 - 0xe0 - STDP4320 DP/HDMI splitter */
+};
+
 /* DP/USB 3.0 */
 &psgtr {
 	status = "okay";
-- 
2.43.0


