Return-Path: <linux-kernel+bounces-42631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33301840416
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0A91F21545
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162605D8FD;
	Mon, 29 Jan 2024 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MYKkUPFY"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A425EE60;
	Mon, 29 Jan 2024 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706528891; cv=none; b=eqQ0bLE8PyOy5CJr/LqhzEemOQgB3j0u5qubxgHB+4izW+m3bOcyC05xTq3kQCBGnXKcLhXIGzJm/G812/Y3OQeKZ85Ay1blGIay++XX7a8fc8M9mPSfhlHrKdRHGBUsW8c0UdqANeK87PbQ4SB4CzSXkqDSd4QEasDiLz50Jb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706528891; c=relaxed/simple;
	bh=O8AZC10zY7ggCIyUWjiwyicHtrvf5ln0+sqPnY3/pGc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z62l2BOijLi6JhMXxTpKsgyhZG6llL61vUHEjThlMe38JMRw6U4vnGhkMlQUeJi8LjxkSU9boJkF8qkTXoQNL4m2jNUb8ad8pcaZA7JlpB+yevJu+m7AklL3vNAS4oidurZYtbJ6gpeholmH3yWxBRNZr2cREpHzsfAXrPXf5vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MYKkUPFY; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40TBm1ll107261;
	Mon, 29 Jan 2024 05:48:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706528881;
	bh=MoCRQYVZEX+Mr8OkesIHLNljp9ihpwaEzEO3zAB3r08=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=MYKkUPFYdGGGVY+DOiIV10jYF1/i9KCFULKXZokh5EFGNf1UpUbXalk3jH4IMFkdP
	 5kI2IN9t/sj2jUvsGRlRFOdCRrdt57o+wDHhgC0R9QZtjyV0DBgLJ/yszRO0lOuiaF
	 NvoTTZJakw2n2I6q/lIYZDh3K87wVRiXVEWIj+s8=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40TBm1Ta023321
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jan 2024 05:48:01 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jan 2024 05:48:00 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jan 2024 05:48:00 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40TBloqR029678;
	Mon, 29 Jan 2024 05:47:57 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 2/3] arm64: dts: ti: k3-j784s4-evm: Enable PCIe0 and PCIe1 in RC Mode
Date: Mon, 29 Jan 2024 17:17:48 +0530
Message-ID: <20240129114749.1197579-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129114749.1197579-1-s-vadapalli@ti.com>
References: <20240129114749.1197579-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Enable PCIe0 and PCIe1 instances of PCIe in Root Complex mode of
operation on J784S4 EVM. The lanes of PCIe0 are connected to Serdes1
instance of Serdes while the lanes of PCIe1 are connected to Serdes0
instance of Serdes in J784S4 SoC. Despite both PCIe instances supporting
up to 4 Lanes, since the physical connections to the PCIe connector
corresponding to the PCIe1 instance of PCIe are limited to 2 Lanes on
the J784S4 EVM, update the "num-lanes" property of PCIe1 accordingly.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 46 ++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index f34b92acc56d..4b94fa348869 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -1081,3 +1081,49 @@ dp0_out: endpoint {
 		};
 	};
 };
+
+&serdes0 {
+	status = "okay";
+	serdes0_pcie1_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <4>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_PCIE>;
+		resets = <&serdes_wiz0 1>, <&serdes_wiz0 2>,
+			 <&serdes_wiz0 3>, <&serdes_wiz0 4>;
+	};
+};
+
+&serdes_wiz0 {
+	status = "okay";
+};
+
+&pcie1_rc {
+	status = "okay";
+	num-lanes = <2>;
+	reset-gpios = <&exp1 2 GPIO_ACTIVE_HIGH>;
+	phys = <&serdes0_pcie1_link>;
+	phy-names = "pcie-phy";
+};
+
+&serdes1 {
+	status = "okay";
+	serdes1_pcie0_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <2>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_PCIE>;
+		resets = <&serdes_wiz1 1>, <&serdes_wiz1 2>;
+	};
+};
+
+&serdes_wiz1 {
+	status = "okay";
+};
+
+&pcie0_rc {
+	status = "okay";
+	reset-gpios = <&exp1 6 GPIO_ACTIVE_HIGH>;
+	phys = <&serdes1_pcie0_link>;
+	phy-names = "pcie-phy";
+};
-- 
2.34.1


