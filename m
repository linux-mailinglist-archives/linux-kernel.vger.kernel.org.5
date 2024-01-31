Return-Path: <linux-kernel+bounces-47166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FED5844A0C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB431F26C40
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B0339AE0;
	Wed, 31 Jan 2024 21:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="okVkBh0N"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5297B39AE6;
	Wed, 31 Jan 2024 21:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706736469; cv=none; b=JKVSkiBYzV869BR7EYcdIpy5qjp5aHwTXGe5/PB6JxuV8SBfT2eKw15ajcZzvjNMiaPaix8wYfsLwgDgXV93x8UnuHf5F/sjyiSDUjL9OEEMoA5xvTycy6Hz7it715dMHlmlgfrts4UzgSbAJwkknbaNSyFnXSGTFKcmJLsuQqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706736469; c=relaxed/simple;
	bh=b34DzFJ4AZO2g8PMxqDg2FDrKqMy46Tr7YLgYwWX3+4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BUBij3/qSAoFYKV2IFb66UhTIm+pTJIYpuaXf+bTFZcHBMd1NHNd87lrqD6+auNJHjmPDPA7AtqB+sHIiaKy250zjj/TGRwChkdVwF/XB5/PaCqN49HukoLklk8QoXeacI+sHLDDgnFd9hftaQQMVn8vk/idedrp/SC2qcVFRA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=okVkBh0N; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VLR3bT119725;
	Wed, 31 Jan 2024 15:27:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706736423;
	bh=a+CrFxA52My7KPBlxg7kYJKUOgXW8bGCoxdEVMO/YQE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=okVkBh0N8h3myU7puqYNE9wLzvYaYkBq/OCni5HyQmEF2Hv39mqJUSmO9HdndDMIY
	 yYFOBUcbeECQYFg+I+0KCy03rKYFMLetZPn8ybt6EboeuVh+WBrYpqByOcWKbinQoE
	 c4tf9OThMVpUfyqaJqtC8CONcpNX3qgSiwprbTDY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VLR337041062
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 15:27:03 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 15:27:03 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 15:27:03 -0600
Received: from udba0500997.dhcp.ti.com (udba0500997.dhcp.ti.com [128.247.81.249])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VLQfKS028966;
	Wed, 31 Jan 2024 15:27:02 -0600
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
Subject: [PATCH v3 3/6] arm64: dts: ti: k3-j721s2-main: Add Wave5 Video Encoder/Decoder Node
Date: Wed, 31 Jan 2024 15:26:22 -0600
Message-ID: <20240131212625.1862775-4-b-brnich@ti.com>
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

From: Darren Etheridge <detheridge@ti.com>

Add the Chips and Media wave521cl video decoder/encoder node on J721S2.

Signed-off-by: Darren Etheridge <detheridge@ti.com>
Signed-off-by: Brandon Brnich <b-brnich@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts |  4 ++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi             | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index c6b85bbf9a17..0b1bcb4b5b57 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -502,3 +502,7 @@ &main_mcan5 {
 	pinctrl-0 = <&main_mcan5_pins_default>;
 	phys = <&transceiver4>;
 };
+
+&vpu {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index ea7f2b2ab165..5b4cd3dc3b60 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -716,6 +716,16 @@ main_i2c6: i2c@2060000 {
 		status = "disabled";
 	};
 
+	vpu: video-codec@4210000 {
+		compatible = "ti,j721s2-wave521c", "cnm,wave521c";
+		reg = <0x00 0x4210000 0x00 0x10000>;
+		interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 179 2>;
+		clock-names = "vcodec";
+		power-domains = <&k3_pds 179 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
 	main_sdhci0: mmc@4f80000 {
 		compatible = "ti,j721e-sdhci-8bit";
 		reg = <0x00 0x04f80000 0x00 0x1000>,
-- 
2.34.1


