Return-Path: <linux-kernel+bounces-47165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA8D844A0A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570C02886E6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA513985A;
	Wed, 31 Jan 2024 21:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eKVaiNeb"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B6F3A1DF;
	Wed, 31 Jan 2024 21:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706736448; cv=none; b=s3KN8lscuDWPVBfNqU8KLxGmYcQU+3pCQBHSInpU8tsUNovJb2J6cdOedSDnX7nPNdKsg/VtZa/Dh4oP7ipnJHjaJLC39WpH4n/UtDIoBihRQSx8PeJ4DrAIgKgG3eBQrt/nkg1ybKR6cm/lt8B/H3I2t4a9i5r91P4KutKWCsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706736448; c=relaxed/simple;
	bh=1vTVEVZoaQBK25pdfO0Khb/E6FqUG8EDDoEedtc+qdk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjBlPAcWhqx6U0ZoTwaRPA07trcZ80Fl0vhh0+9FJKT3w8oDF3DHR80YTaGk8jM3pOMx8NcaDVGkFd9CoKUEUs6OSNzsOnxjCgh9z1PfxLQPsOWC5Qy7tJlBPe5cmtUU3zy/duBtQXBxv3Uo8HOyxkZfuw0kaLLh10EJwuzfCtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eKVaiNeb; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VLR5nw051155;
	Wed, 31 Jan 2024 15:27:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706736425;
	bh=RqeGdNNen1smgLVsTQRKswkyX+0wYpPdxWfj+SK3AhY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=eKVaiNebyEXlwdxIcVCfo7SaXIaX1kcfbNQEpoy4Td1baCMwG69Q1kOZp1h2RwylD
	 wYMO5JY7tAbiZuk4tuE6gSQ/7IXt7wY10hN+S3H28cqB+Zfqf0cRizkS5eiNUhcf1+
	 nGyzuQPk0SFRY1w75vxOmfGQ/0NZbf8wozE7OnLA=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VLR5QE041269
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 15:27:05 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 15:27:05 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 15:27:05 -0600
Received: from udba0500997.dhcp.ti.com (udba0500997.dhcp.ti.com [128.247.81.249])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VLQfKU028966;
	Wed, 31 Jan 2024 15:27:04 -0600
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
Subject: [PATCH v3 5/6] arm64: dts: ti: k3-am62p: Add Wave5 Video Encoder/Decoder Node
Date: Wed, 31 Jan 2024 15:26:24 -0600
Message-ID: <20240131212625.1862775-6-b-brnich@ti.com>
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

This patch adds support for the Wave521cl on the AM62P.

Signed-off-by: Brandon Brnich <b-brnich@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 10 ++++++++++
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts   |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index 4c51bae06b57..94c89699b35f 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -891,4 +891,14 @@ mcasp2: audio-controller@2b20000 {
 		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
 		status = "disabled";
 	};
+
+	vpu: video-codec@30210000 {
+		compatible = "ti,j721s2-wave521c", "cnm,wave521c";
+		reg = <0x00 0x30210000 0x00 0x10000>;
+		interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 204 2>;
+		clock-names = "vcodec";
+		power-domains = <&k3_pds 204 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index 1773c05f752c..0aec79ed5578 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -569,6 +569,10 @@ &main_uart0 {
 	bootph-all;
 };
 
+&vpu {
+	status = "okay";
+};
+
 &main_uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart1_pins_default>;
-- 
2.34.1


