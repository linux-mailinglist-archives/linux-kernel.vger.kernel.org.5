Return-Path: <linux-kernel+bounces-47162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C56D844A05
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730221F24E1E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102E23986C;
	Wed, 31 Jan 2024 21:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="B1tOnkNg"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB97239859;
	Wed, 31 Jan 2024 21:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706736442; cv=none; b=BK2T+drZ/YssrJGQP9KOxrCvnCQei5taA9qdsqG5jeKE6+xroMS0h8FYP0hIfOOXek48lRi9oC7hycGbunTqfXOtG7kw7fQBLyXasf+bteGAQpMvKPUycopVSbjFYi/GtLn9PSTcICNrwcqS4bhI0oLsMwfCz2w6rLHhoed69xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706736442; c=relaxed/simple;
	bh=4UZvqj+jhQZfdAZz5p5AwA7e6ez97Ilgo+T1DbybycE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3cXVPjhcNb53oa1Uv0G+mVl6w1OwTal9ECv/az+zIL9An4OQlmpGLFs/QCzlrXeZi1neiDCWEvBSPR+MxrY99oUqRa8/MH/L5FpbTSdQtoxWenSrv5NId5VfSYpRzU942X2uGi0myUiQbRC0btQVL3Mhguc/K+Fe+eoNsgely8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=B1tOnkNg; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VLQx8P119705;
	Wed, 31 Jan 2024 15:26:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706736419;
	bh=wdG//Xd6xd9OLxbOdH6iKiAlTR9/FDqTxdm2k9x4EvE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=B1tOnkNg0oZzW2nZkUUoXW8fn2uqwi2vum5KqGt7oRXCfG3mZCs6xKCCl+Pk78OtP
	 JFpXYTMiQJgbNhJkU1sm2tgI8AZfzAcv2QAsbkUVPEK2IXoFdIKveYiQH6rD/Xt7dj
	 7W8hy9uVAnZ/QMivd0XNo4/9P58zj7UoKY84kiIA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VLQxUV023324
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 15:26:59 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 15:26:58 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 15:26:58 -0600
Received: from udba0500997.dhcp.ti.com (udba0500997.dhcp.ti.com [128.247.81.249])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VLQfKQ028966;
	Wed, 31 Jan 2024 15:26:58 -0600
From: Brandon Brnich <b-brnich@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon
	<will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Geert
 Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Konrad
 Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?=
	<nfraprado@collabora.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Darren Etheridge <detheridge@ti.com>
CC: Brandon Brnich <b-brnich@ti.com>
Subject: [PATCH v3 1/6] arm64: dts: ti: k3-j784s4: Add Wave5 Video Encoder/Decoder Node
Date: Wed, 31 Jan 2024 15:26:20 -0600
Message-ID: <20240131212625.1862775-2-b-brnich@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131212625.1862775-1-b-brnich@ti.com>
References: <20240131212625.1862775-1-b-brnich@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This patch adds support for the Wave521cl on the J784S4-evm.

Signed-off-by: Brandon Brnich <b-brnich@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts   |  8 ++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 20 ++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi      |  2 ++
 3 files changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index f34b92acc56d..7d37c11b4df4 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -784,6 +784,14 @@ &main_gpio0 {
 	status = "okay";
 };
 
+&vpu0 {
+	status = "okay";
+};
+
+&vpu1 {
+	status = "okay";
+};
+
 &mcu_cpsw {
 	status = "okay";
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index f2b720ed1e4f..8b2623ac8160 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -662,6 +662,26 @@ main_i2c6: i2c@2060000 {
 		status = "disabled";
 	};
 
+	vpu0: video-codec@4210000 {
+		compatible = "ti,j721s2-wave521c", "cnm,wave521c";
+		reg = <0x00 0x4210000 0x00 0x10000>;
+		interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 241 2>;
+		clock-names = "vcodec";
+		power-domains = <&k3_pds 241 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	vpu1: video-codec@4220000 {
+		compatible = "ti,j721s2-wave521c", "cnm,wave521c";
+		reg = <0x00 0x4220000 0x00 0x10000>;
+		interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 242 2>;
+		clock-names = "vcodec";
+		power-domains = <&k3_pds 242 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
 	main_sdhci0: mmc@4f80000 {
 		compatible = "ti,j721e-sdhci-8bit";
 		reg = <0x00 0x04f80000 0x00 0x1000>,
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
index 4398c3a463e1..93bb0cba1b48 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
@@ -247,6 +247,8 @@ cbass_main: bus@100000 {
 			 <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>, /* MAIN NAVSS */
 			 <0x41 0x00000000 0x41 0x00000000 0x01 0x00000000>, /* PCIe1 DAT1 */
 			 <0x4e 0x20000000 0x4e 0x20000000 0x00 0x00080000>, /* GPU */
+			 <0x00 0x04210000 0x00 0x04210000 0x00 0x00010000>, /* VPU0 */
+			 <0x00 0x04220000 0x00 0x04220000 0x00 0x00010000>, /* VPU1 */
 
 			 /* MCUSS_WKUP Range */
 			 <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>,
-- 
2.34.1


