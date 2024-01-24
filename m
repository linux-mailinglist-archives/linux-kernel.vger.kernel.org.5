Return-Path: <linux-kernel+bounces-37528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2868D83B14B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 842E4B22951
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A90A131E49;
	Wed, 24 Jan 2024 18:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jAW0g5Ts"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA0113175C;
	Wed, 24 Jan 2024 18:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706121435; cv=none; b=cZqMGpYUbsSyAmi2Nw0p4sQ5vgm2DLwfSSZTY1wMkIgAh1p+uQWcy3mHkAObQQoGjJoNHr9cKt4OGMbBRHNsd4Haas4sfLPjFQjPRU4Bu5Cse8ymLfdo5OqqONqbHZkPb87Qf9EVyVKFXI8RFQNYOn3b5bpDJVfVueXdvoAdpPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706121435; c=relaxed/simple;
	bh=3uzocwDw11owXvLEpuEy44ILwY1jHzvcDQ7mLByg2pg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XYxtVdu6RLqDGqZpncmVBHw1Oy6qyLSOUjPsWq37uw8ZujdW4KQX3ZuJFWMbX4acd9pLc77nkn0d03afd/i9gPJXJdwHeahpmorKEM/8/Xfz8bvgcfn1xr1jmODC8U/gGFpyyI3Mr68nGrbYa/kn2o0yLw/rVTncOFuNCrlVnrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jAW0g5Ts; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OIb1Jw106183;
	Wed, 24 Jan 2024 12:37:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706121421;
	bh=gED2gWvfzs427INIi0H3xv3sSVDvHPQjQ9BAVAAoC9A=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=jAW0g5Ts8b2iGphyZhrwTelP68MNKuhP0TdPvuo+5v0Q2iImd62ORsChTTJGv8w0w
	 0rhKGgYcM9nR/dzwcrKQr1QwhLBC6XQOeF5hrJlC5cDQpbvtuJLFZMAetwbQ1JjZMM
	 Q1RphEBczfScTkrPEPnGegd9P40TVp+atdmDMr+Q=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OIb1Mb015383
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jan 2024 12:37:01 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 12:37:01 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 12:37:01 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OIb0bA106485;
	Wed, 24 Jan 2024 12:37:01 -0600
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 2/4] arm64: dts: ti: k3-j7200: Remove PCIe endpoint node
Date: Wed, 24 Jan 2024 12:36:57 -0600
Message-ID: <20240124183659.149119-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124183659.149119-1-afd@ti.com>
References: <20240124183659.149119-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This node is an example node for the PCIe controller in "endpoint" mode.
By default the controller is in "root complex" mode and there is already a
DT node for the same.

Examples should go in the bindings or other documentation.

Remove this node.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 .../dts/ti/k3-j7200-common-proc-board.dts     |  7 -------
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 20 -------------------
 2 files changed, 27 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 7e4fd7ab9750c..ce2a5c9699de8 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -388,10 +388,3 @@ &pcie1_rc {
 	phy-names = "pcie-phy";
 	num-lanes = <2>;
 };
-
-&pcie1_ep {
-	phys = <&serdes0_pcie_link>;
-	phy-names = "pcie-phy";
-	num-lanes = <2>;
-	status = "disabled";
-};
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 1e2434caa7ffa..57608a6a64e6c 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -773,26 +773,6 @@ pcie1_rc: pcie@2910000 {
 		status = "disabled";
 	};
 
-	pcie1_ep: pcie-ep@2910000 {
-		compatible = "ti,j7200-pcie-ep", "ti,j721e-pcie-ep";
-		reg = <0x00 0x02910000 0x00 0x1000>,
-		      <0x00 0x02917000 0x00 0x400>,
-		      <0x00 0x0d800000 0x00 0x00800000>,
-		      <0x00 0x18000000 0x00 0x08000000>;
-		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
-		interrupt-names = "link_state";
-		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
-		ti,syscon-pcie-ctrl = <&scm_conf 0x4074>;
-		max-link-speed = <3>;
-		num-lanes = <4>;
-		power-domains = <&k3_pds 240 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 240 6>;
-		clock-names = "fck";
-		max-functions = /bits/ 8 <6>;
-		max-virtual-functions = /bits/ 8 <4 4 4 4 0 0>;
-		dma-coherent;
-	};
-
 	usbss0: cdns-usb@4104000 {
 		compatible = "ti,j721e-usb";
 		reg = <0x00 0x4104000 0x00 0x100>;
-- 
2.39.2


