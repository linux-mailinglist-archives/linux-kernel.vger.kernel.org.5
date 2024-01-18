Return-Path: <linux-kernel+bounces-29975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EBB831619
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACF131C2177C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970F0200AA;
	Thu, 18 Jan 2024 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Qt/oc+Os"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8305C1D533;
	Thu, 18 Jan 2024 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705571131; cv=none; b=AuQ2dQ7pc8/uh5RRT/A+SkUxp+wtiwo06E52HvB3oOgmkWJpbC3loLDeQl/V+Qcv35+ZB7ocSJwgZIC+fd2B2YQPvBaU0WAxxeholhQz/rwZ49oQkFffv0dOYfDQgGl2cYE3BF40woMPckVBdQK4qtw22jB0vsvamVW+SXgU+AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705571131; c=relaxed/simple;
	bh=FpAQoYQ0nA0k17n6ZCNuiZym9xUzsD8Lt6yFUgKPU+k=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EXCLAIMER-MD-CONFIG; b=iZHwZtZ3DpXHspwMra2o9Zo+Go7PsXFtvgAsROAKW7yv67NPPBQIBYkUnNn5L7bDr/LZwMCQOX8/XeheJjWy9oiiQByAODr3QPk8GNEb23ztxtoAN35Cijm0ObPTyu3+YvScVssWGJ+JJxJjmpdMuENCGaE7ZI3cu78MIYYCv/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Qt/oc+Os; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40I9jB2w083037;
	Thu, 18 Jan 2024 03:45:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705571111;
	bh=sv7BoNmCqEVqsIvmYySIhKlzmBYY2Dtc6a1WMjCpO3U=;
	h=From:To:CC:Subject:Date;
	b=Qt/oc+Os6va7BRTrEbcEqBL4BNG2uqfI3SyJS0/kX609dIsZwaFv42S2ll4qOtCEF
	 f4Ak6KiEz+Qiho14yCWZdHv08GTOvmk3k2G8KFBRMVJr2mjpmvK0HpEl5mFs7AinNn
	 JvVMMbLAqnVIIuTWT0z/C7pOUsobmTpD0QSM7qog=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40I9jBN5037115
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Jan 2024 03:45:11 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 18
 Jan 2024 03:45:10 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 18 Jan 2024 03:45:11 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40I9j9Ye113454;
	Thu, 18 Jan 2024 03:45:10 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth
 Menon <nm@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <afd@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>, <r-gunasekaran@ti.com>, <c-vankar@ti.com>,
        <danishanwar@ti.com>, <tony@atomide.com>
Subject: [PATCH v2 0/5] Add CPSW2G and CPSW9G nodes for J784S4
Date: Thu, 18 Jan 2024 15:14:49 +0530
Message-ID: <20240118094454.2656734-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This series adds device-tree nodes for CPSW2G and CPSW9G instance
of the CPSW Ethernet Switch on TI's J784S4 SoC. Additionally,
two device-tree overlays are also added:
1. QSGMII mode with the CPSW9G instance via the ENET EXPANSION 1
   connector.
2. USXGMII mode with MAC Ports 1 and 2 of the CPSW9G instance via
   ENET EXPANSION 1 and 2 connectors, configured in fixed-link
   mode of operation at 5Gbps link speed.

Similar to Andrew Davis patch at:
https://lore.kernel.org/r/20231117222930.228688-5-afd@ti.com/ for J721E,
similar changes are also required for J784S4 to remove dependency on the
parent node being a syscon node.

This series combines the v1 series at:
https://lore.kernel.org/r/20230522092201.127598-1-s-vadapalli@ti.com/
and the patch for Main CPSW2G node that is present in [PATCH v6 2/5] at:
https://lore.kernel.org/r/20230721132029.123881-1-j-choudhary@ti.com/
but dropped in it's next version at:
https://lore.kernel.org/r/20231019054022.175163-1-j-choudhary@ti.com/

Changes from v1 for J784S4 CPSW9G DT Support:
1. Update serdes_ln_ctrl node in k3-j784s4-main.dtsi
   to remove dependency on the parent node being a syscon node.
2. The patch for Main CPSW2G node is combined.
3. Update description in k3-j784s4-evm-quad-port-eth-exp1.dtso
   QSGMII overlay file and add product link for QSGMII
   daughtercard.
4. Add a comment in k3-j784s4-evm-usxgmii-exp1-exp2.dtso
   USXGMII overlay file for the serdes_wiz2 node since it uses
   156.25 MHz clock for USXGMII.

Changes from v6 for J784S4 Main CPSW2G node: 
1. Rename node name in k3-j784s4-main.dtsi from
   main_cpsw2g_pins_default to main_cpsw2g_default_pins,
   main_cpsw2g_mdio_pins_default to main_cpsw2g_mdio_default_pins
   and main_phy0 to main_cpsw1_phy0 based on Tony's suggestion at:
   https://lore.kernel.org/all/20230724045032.GU5194@atomide.com/

Chintan Vankar (1):
  arm64: dts: ti: k3-j784s4-main: Convert serdes_ln_ctrl node into
    reg-mux

Siddharth Vadapalli (4):
  arm64: dts: ti: k3-j784s4: Add Main CPSW2G node
  arm64: dts: ti: k3-j784s4-main: Add CPSW9G nodes
  arm64: dts: ti: k3-j784s4: Add overlay to enable QSGMII mode with
    CPSW9G
  arm64: dts: ti: k3-j784s4: Add overlay for dual port USXGMII mode

 arch/arm64/boot/dts/ti/Makefile               |  11 +-
 .../ti/k3-j784s4-evm-quad-port-eth-exp1.dtso  | 146 +++++++++++++
 .../ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso   |  73 +++++++
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      |  47 +++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 194 +++++++++++++++++-
 5 files changed, 464 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm-quad-port-eth-exp1.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso

-- 
2.34.1


