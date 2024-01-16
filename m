Return-Path: <linux-kernel+bounces-27835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2675782F68D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1671C210D1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AABD208BB;
	Tue, 16 Jan 2024 19:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlJn4aJb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0B540BE4;
	Tue, 16 Jan 2024 19:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434331; cv=none; b=qhwoobT5zIVnrSht3ApcUY+2c9FWtM1caAPxITpo8/QCee//PGSIfwAlajTO62CXCwtYFI7W2/iTeKKy1grUwrZXa53Cf5XazwqEAl/r01fiUaVP+eVdV75C454m68LTYURUCyH210k3Jl85E7zUddjg4+cNBNWqLxiL8f/YX8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434331; c=relaxed/simple;
	bh=HlzBsDp6k6DRdPQsKDOA1wu2AKK9wqQg1A7h1nmaL/A=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=a0F5QQBvhKiso+Er7sNgJnawVgG3T7G+r6irCotgpPPl2hzMgJiE0dg3yJNAAIw1BjBtpfRjhOQsv1cOXFcd8gHRBX8wxT65DcZCVdNxM1qIkc+4k8ceBxx8UyiTXDaav/czps+8ACnkQMfqCD9FVK3qAYGObhw78ah0hW6T67o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlJn4aJb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1FAC433F1;
	Tue, 16 Jan 2024 19:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434330;
	bh=HlzBsDp6k6DRdPQsKDOA1wu2AKK9wqQg1A7h1nmaL/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tlJn4aJbF6NDA3pUsEu0OD199J2lVg/CYIKV6XfBitV2f6CK2y8EVkRttaKMUJDh7
	 cjsp2PnrM4habWZb3HIk29gWNcrHtpuN+6mSoOGatmdkw4L5y6dn0cpHM/dKbtyeRE
	 m8BiIm2IVI9suR0JJ0eTbGgYs6b3xfgnG/5gPpQi/M6omAp1iUDZ89vMXRWNIvKt5a
	 UWuVy4kypB+VA9URmSQHdTqbSu3u6F4jzrdDbIGHfd/l9X10FrcEyOJrE69BWbTrYw
	 EY/OMwCYFXxFBxnniuv9R8mpaqKLcAKoJoOzAIs0/9aLQ9EXL1uOooHawExBDaO7MF
	 hmG87DWm4fAgQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	ashok.reddy.soma@xilinx.com,
	manikanta.guntupalli@amd.com,
	laurent.pinchart@ideasonboard.com,
	harini.katakam@amd.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.7 064/108] arm64: zynqmp: Move fixed clock to / for kv260
Date: Tue, 16 Jan 2024 14:39:30 -0500
Message-ID: <20240116194225.250921-64-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
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


