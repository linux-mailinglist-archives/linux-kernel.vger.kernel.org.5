Return-Path: <linux-kernel+bounces-37529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE30D83B14C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87075283BC3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6A1131E4F;
	Wed, 24 Jan 2024 18:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WkGWKe/i"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C6377F3E;
	Wed, 24 Jan 2024 18:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706121435; cv=none; b=tTgfAfAjBLrft+9MAa47cy7sAY8amSgcQccPm9TpH7a7odYpyBHNnOpH418IfLYWOkqz/TikmWodxmt/xy7t8GLUSJ7NSkjtdEgMdOSHiHSPacucdeHls9j5+tC03jUGeX+6Cy4CW+0SG8+H2U/KlEPEmBO0+7S2lXJ4/WQW1nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706121435; c=relaxed/simple;
	bh=EX6PSsFWL+yVpTH9N+1rGkFZBXeONRvhWO9gy64TLHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFrVQybHMYRe+g7Q7GQPGHikCsMVq20LAijMmDGVlmlrQ0iI1E5lWHisYhbP0FKldUNOuqlB6ugtr4j9OzhWwizlXoHP0hCgU2yNkEgyDM7G0HsnLJwXgMa6HuC731qmxZBIHeJST7wY34uQUpDyR1e2p8E8HNDxo4SASRkhBJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WkGWKe/i; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OIb3nB091374;
	Wed, 24 Jan 2024 12:37:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706121423;
	bh=05zB4D5fH6Svarpqnx2uwXC2aEC5mSfYSDje+qKJcAI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=WkGWKe/iNhdDXw/oUrhjVyzzm+HYXJgM3UQC/jcpc+KqLuZ9md4gzdPnLfV8lZbCz
	 EfMN0ucEBeIaE7q4w3AwM4jcQY4G0nNx1Xiy0ZHh21p3nrjPzIyesXFGepV1reVROr
	 PK83AQEoCSc5rjes4xZcg0edM/HhUpHoT6sjarJQ=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OIb3e7015467
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jan 2024 12:37:03 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 12:37:02 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 12:37:02 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OIb0bC106485;
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
Subject: [PATCH 4/4] arm64: dts: ti: k3-am64: Remove PCIe endpoint node
Date: Wed, 24 Jan 2024 12:36:59 -0600
Message-ID: <20240124183659.149119-4-afd@ti.com>
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
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 19 -------------------
 arch/arm64/boot/dts/ti/k3-am642-evm.dts  |  6 ------
 2 files changed, 25 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index e348114f42e01..d5938f966a2dd 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1041,25 +1041,6 @@ pcie0_rc: pcie@f102000 {
 		status = "disabled";
 	};
 
-	pcie0_ep: pcie-ep@f102000 {
-		compatible = "ti,am64-pcie-ep", "ti,j721e-pcie-ep";
-		reg = <0x00 0x0f102000 0x00 0x1000>,
-		      <0x00 0x0f100000 0x00 0x400>,
-		      <0x00 0x0d000000 0x00 0x00800000>,
-		      <0x00 0x68000000 0x00 0x08000000>;
-		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
-		interrupt-names = "link_state";
-		interrupts = <GIC_SPI 203 IRQ_TYPE_EDGE_RISING>;
-		ti,syscon-pcie-ctrl = <&main_conf 0x4070>;
-		max-link-speed = <2>;
-		num-lanes = <1>;
-		power-domains = <&k3_pds 114 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 114 0>;
-		clock-names = "fck";
-		max-functions = /bits/ 8 <1>;
-		status = "disabled";
-	};
-
 	epwm0: pwm@23000000 {
 		compatible = "ti,am64-epwm", "ti,am3352-ehrpwm";
 		#pwm-cells = <3>;
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 8c5651d2cf5dd..6412c52c8001a 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -705,12 +705,6 @@ &pcie0_rc {
 	num-lanes = <1>;
 };
 
-&pcie0_ep {
-	phys = <&serdes0_pcie_link>;
-	phy-names = "pcie-phy";
-	num-lanes = <1>;
-};
-
 &ecap0 {
 	status = "okay";
 	/* PWM is available on Pin 1 of header J12 */
-- 
2.39.2


