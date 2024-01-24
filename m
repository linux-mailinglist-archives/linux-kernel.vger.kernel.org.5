Return-Path: <linux-kernel+bounces-37526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AA083B148
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06B71F224DC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96300131E31;
	Wed, 24 Jan 2024 18:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YOxXBdSJ"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B38131757;
	Wed, 24 Jan 2024 18:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706121434; cv=none; b=pt/beOm9mcoqpT2UfHF50rmjOvA0tqayzzUklrBnzcDO9yddCpQudM2pgPzp+Dg9lvHy7O3GY3YTEO07hXVgw97VtpDrNLQOGO+RiFn2GHPSzHgAw31m75DUXmkE4C3jbSef3L9KGWrurV51+ePyxBW8IxsrVXtu/QzEEWpA/9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706121434; c=relaxed/simple;
	bh=xC/30zjEDKsQj2Y+zZTcMWYVEh0CxLo58RcmlfY5mAw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g0vYzavmsHx0xmNNuisDAuLKyjHcTDSudn/JRF86V0U922kH0/9P0i8R6ICEULRTgikM7at6oQXzFWe6DnpiF/SC+aCuzrQcawOOiRkhYNZ1nQK8dRTBEPWJw+2hlY378yccBG7x2x0udBawHWvPpGvJSaDMyPOOlMEKZ/bsOMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YOxXBdSJ; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OIb2fX128728;
	Wed, 24 Jan 2024 12:37:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706121422;
	bh=GjbOImoox0tR8x+R9TADsdC+j+QS+DMQ1DAEW80lqOY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=YOxXBdSJoi3tcypi6Q6qk7mZg/KQj4Z2NstBZZLdYoUkBrxwfLJweXHBMjGTLu24d
	 4eDAa6jqFePWcWhKhfn3lc56iioL9KTXxZuHHK78R5yIfu0DqKnjrQTL0I4N+H0L5c
	 eTJFHkHs+9ZhbTVm6DTB9TqrrssEYKXE33gusYDA=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OIb2Gp015413
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jan 2024 12:37:02 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 12:37:01 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 12:37:01 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OIb0bB106485;
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
Subject: [PATCH 3/4] arm64: dts: ti: k3-am65: Remove PCIe endpoint nodes
Date: Wed, 24 Jan 2024 12:36:58 -0600
Message-ID: <20240124183659.149119-3-afd@ti.com>
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

These nodes are example nodes for the PCIe controller in "endpoint" mode.
By default the controller is in "root complex" mode and there is already a
DT node for the same.

Examples should go in the bindings or other documentation.

Remove this node.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 28 ------------------------
 1 file changed, 28 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index fcea544656360..b922b483ea0f7 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -886,20 +886,6 @@ pcie0_rc: pcie@5500000 {
 		status = "disabled";
 	};
 
-	pcie0_ep: pcie-ep@5500000 {
-		compatible = "ti,am654-pcie-ep";
-		reg = <0x0 0x5500000 0x0 0x1000>, <0x0 0x5501000 0x0 0x1000>, <0x0 0x10000000 0x0 0x8000000>, <0x0 0x5506000 0x0 0x1000>;
-		reg-names = "app", "dbics", "addr_space", "atu";
-		power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
-		ti,syscon-pcie-mode = <&scm_conf 0x4060>;
-		num-ib-windows = <16>;
-		num-ob-windows = <16>;
-		max-link-speed = <2>;
-		dma-coherent;
-		interrupts = <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
-		status = "disabled";
-	};
-
 	pcie1_rc: pcie@5600000 {
 		compatible = "ti,am654-pcie-rc";
 		reg = <0x0 0x5600000 0x0 0x1000>, <0x0 0x5601000 0x0 0x1000>, <0x0 0x18000000 0x0 0x2000>, <0x0 0x5606000 0x0 0x1000>;
@@ -921,20 +907,6 @@ pcie1_rc: pcie@5600000 {
 		status = "disabled";
 	};
 
-	pcie1_ep: pcie-ep@5600000 {
-		compatible = "ti,am654-pcie-ep";
-		reg = <0x0 0x5600000 0x0 0x1000>, <0x0 0x5601000 0x0 0x1000>, <0x0 0x18000000 0x0 0x4000000>, <0x0 0x5606000 0x0 0x1000>;
-		reg-names = "app", "dbics", "addr_space", "atu";
-		power-domains = <&k3_pds 121 TI_SCI_PD_EXCLUSIVE>;
-		ti,syscon-pcie-mode = <&scm_conf 0x4070>;
-		num-ib-windows = <16>;
-		num-ob-windows = <16>;
-		max-link-speed = <2>;
-		dma-coherent;
-		interrupts = <GIC_SPI 355 IRQ_TYPE_EDGE_RISING>;
-		status = "disabled";
-	};
-
 	mcasp0: mcasp@2b00000 {
 		compatible = "ti,am33xx-mcasp-audio";
 		reg = <0x0 0x02b00000 0x0 0x2000>,
-- 
2.39.2


