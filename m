Return-Path: <linux-kernel+bounces-129521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 239D1896BDF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6DC1F2271A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1902136650;
	Wed,  3 Apr 2024 10:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozoCUCog"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1997317F;
	Wed,  3 Apr 2024 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139411; cv=none; b=iUrQ+sKFsG0dUVS9uFUr9zhDVvm8jrfTAU8e+JGpDRxMQqAR/c0j+dlCEItyIf2DaiG4Q+M3PexX37Y/vXN5TTAMFjNz39vyIqgZnxJNQ1jkz4Zuvbl9EYztD8KCMH/r/obbp6hXoMJPqPmGcf0HFGf3SikxULRJuuGDgzR++gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139411; c=relaxed/simple;
	bh=KhTM+tpnXqd9uFhBod6K1zqVBw8JCQg4SrMRO7iHxPU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bgmIBSfNPrnGgeUQ0dXcmaOMRx7yY+DwlSFuwKxneVRTwLT0KcytqkDLd00/mPW19XHlUYEWJOaV/pO10BbiEhFsx7pmTm9F/OQMmkbUA5vLDSxgHlYmPrHB51YXD0sSmS3CPNCNcHJwrvZz32FXlMq1begd1fICwEP2qObIXlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozoCUCog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839CDC433C7;
	Wed,  3 Apr 2024 10:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712139410;
	bh=KhTM+tpnXqd9uFhBod6K1zqVBw8JCQg4SrMRO7iHxPU=;
	h=From:To:Cc:Subject:Date:From;
	b=ozoCUCogL5YJSFcowlUZGMSY7SxjGo+lz7MHs4ClSy4L5csiVsqOQgAWCcy07AoBF
	 lrcIelHfI5DK1mhOTp4nJXzEY7Qq5tCKvix7Ed8CTFgUEZLKMPdaKIfEJI4brPyGs7
	 mwQzEKar4rZVs5VvKsazVWANIX+cbHWsAuhxC4aUhlIPa10/ltgrHPHCSfv2kArjxQ
	 m2525pZwCd6a+OvMztGNa1YzVZL8kra6hwLhsUOzf3gfsiUlww8a1yND50YJ1eMs6A
	 YvaqPz5GdpGWqV+/eXHokxUUc/v6vgcUTiQNCDkKaqS6RfSODtXfqnHYgxh6u//+5L
	 uZU3qxj986fWw==
From: Michael Walle <mwalle@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v2] arm64: dts: ti: k3-{am62p,j722s}: Disable ethernet by default
Date: Wed,  3 Apr 2024 12:15:45 +0200
Message-Id: <20240403101545.3932437-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device tree best practice is to disable any external interface in the
dtsi and just enable them if needed in the device tree. Thus, disable
the ethernet switch and its ports by default and just enable the ones
used by the EVMs in their device trees.

There is no functional change.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
v2:
 - move the status propert into k3-am62p5-main.dtsi, thus also update
   the k3-am62p5-sk.dts
 - put "status" last
---
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 3 +++
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts   | 3 +++
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts   | 5 +----
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index 7337a9e13535..88bc64111234 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -673,6 +673,7 @@ cpsw3g: ethernet@8000000 {
 		assigned-clock-parents = <&k3_clks 13 11>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 13 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 
 		dmas = <&main_pktdma 0xc600 15>,
 		       <&main_pktdma 0xc601 15>,
@@ -696,6 +697,7 @@ cpsw_port1: port@1 {
 				label = "port1";
 				phys = <&phy_gmii_sel 1>;
 				mac-address = [00 00 00 00 00 00];
+				status = "disabled";
 			};
 
 			cpsw_port2: port@2 {
@@ -704,6 +706,7 @@ cpsw_port2: port@2 {
 				label = "port2";
 				phys = <&phy_gmii_sel 2>;
 				mac-address = [00 00 00 00 00 00];
+				status = "disabled";
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index 6694087b3665..6a9c99c5fb2a 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -431,16 +431,19 @@ &cpsw3g {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_rgmii1_pins_default>,
 		    <&main_rgmii2_pins_default>;
+	status = "okay";
 };
 
 &cpsw_port1 {
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&cpsw3g_phy0>;
+	status = "okay";
 };
 
 &cpsw_port2 {
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&cpsw3g_phy1>;
+	status = "okay";
 };
 
 &cpsw3g_mdio {
diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index 6b148da2bcdc..8a38e5ae7d4f 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -226,10 +226,7 @@ cpsw3g_phy0: ethernet-phy@0 {
 &cpsw_port1 {
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&cpsw3g_phy0>;
-};
-
-&cpsw_port2 {
-	status = "disabled";
+	status = "okay";
 };
 
 &main_gpio1 {
-- 
2.39.2


