Return-Path: <linux-kernel+bounces-48178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A378845845
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05FD828B002
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF0B5B668;
	Thu,  1 Feb 2024 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NUclF66r"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ABF4D9E9;
	Thu,  1 Feb 2024 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706792111; cv=none; b=aIqfAQZIJjFo53PaNQpxwW2oLOwE5WQwpMBry4X1jnz4g+AuEIGaOEvseZSaqVOHBC/75l6GolmCMHTJ3TNk4VxBRqz/iXZ6kCM+iYvm8zbO9rq+O5JTpEFC2TlouJs3uSHa9v6jNVCdHkHXjb/oKeqOtDZfqc4RRdMVGzJB8J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706792111; c=relaxed/simple;
	bh=U0Zh0cmLjjKhko/TxWTtbUip1z23mZYUCdZulLbPFak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gaWS9evFscqou7VD4vZO4cSnIZqKK4afVt/FTy/dTp4letw5AAbSSvkDjTbc+yUDoVBgcPECEuRb+uDuyglGTkIU6tMLslDQKYtHMiUE1kIuNX/5IyuSnPlfF5gFf0qt2dx/Iw+1PIuY/qYQ/WUvE17ZC7s5sQFRkmqF5xMk5go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NUclF66r; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411CstNK101302;
	Thu, 1 Feb 2024 06:54:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706792095;
	bh=mmJpW7ZwzATTLnP59VBBwIaLJKwncunf09Qcm4loyTU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=NUclF66rzyh119mcWk128PojxKIUKGIgqOu16aM/e/sV4WVDEZLposIvXZeNgD+vB
	 4s8BQ0jLa956IJZXCCA9z/koj7gBOuoBjNVlTfIoQAQgjyqFVTJo+4SubQdFBu+GXe
	 nr+cI8Mte+vglHbSM4QUhpUA+r42jVamEO3ONj14=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411CstVX094821
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 06:54:55 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 06:54:55 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 06:54:54 -0600
Received: from localhost (uda0496377.dhcp.ti.com [10.24.69.150])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411Cssoa064890;
	Thu, 1 Feb 2024 06:54:54 -0600
From: Aradhya Bhatia <a-bhatia1@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List
	<linux-kernel@vger.kernel.org>,
        Linux ARM Kernel List
	<linux-arm-kernel@lists.infradead.org>,
        Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>,
        Devarsh Thakkar <devarsht@ti.com>, Jai
 Luthra <j-luthra@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH 1/3] arm64: dts: ti: k3-am62a-main: Add node for Display SubSystem (DSS)
Date: Thu, 1 Feb 2024 18:24:50 +0530
Message-ID: <20240201125452.1920623-2-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201125452.1920623-1-a-bhatia1@ti.com>
References: <20240201125452.1920623-1-a-bhatia1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add Display SubSystem (DSS) DT node for the AM62A7 SoC.

The DSS supports one each of video pipeline (vid) and video-lite
pipeline (vidl1). The video port 1 (vp1) is tied-off in AM62A SoC, but
the pipeline remains active. The video port 2 (vp2) outputs the DPI
signals. Both the video ports are connected to the pipelines via 2
identical overlay managers (ovr1 and ovr2).

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index f0b8c9ab1459..d3de5ad3eeb2 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -985,4 +985,29 @@ dphy0: phy@30110000 {
 		power-domains = <&k3_pds 185 TI_SCI_PD_EXCLUSIVE>;
 		status = "disabled";
 	};
+
+	dss: dss@30200000 {
+		compatible = "ti,am62a7-dss";
+		reg = <0x00 0x30200000 0x00 0x1000>, /* common */
+		      <0x00 0x30202000 0x00 0x1000>, /* vidl1 */
+		      <0x00 0x30206000 0x00 0x1000>, /* vid */
+		      <0x00 0x30207000 0x00 0x1000>, /* ovr1 */
+		      <0x00 0x30208000 0x00 0x1000>, /* ovr2 */
+		      <0x00 0x3020a000 0x00 0x1000>, /* vp1: Tied OFF in the SoC */
+		      <0x00 0x3020b000 0x00 0x1000>; /* vp2: Used as DPI Out */
+		reg-names = "common", "vidl1", "vid",
+			    "ovr1", "ovr2", "vp1", "vp2";
+		power-domains = <&k3_pds 186 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 186 6>,
+			 <&k3_clks 186 0>,
+			 <&k3_clks 186 2>;
+		clock-names = "fck", "vp1", "vp2";
+		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+
+		dss_ports: ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
 };
-- 
2.34.1


