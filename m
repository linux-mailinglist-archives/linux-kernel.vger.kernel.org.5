Return-Path: <linux-kernel+bounces-38360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CC583BE49
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5FA028BD95
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8901CD02;
	Thu, 25 Jan 2024 10:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CPeHRxBX"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DEE1C69A;
	Thu, 25 Jan 2024 10:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706177156; cv=none; b=Smxdz06hFSBofUcVF7W9y0XQ2UICNKQPvUqmQhqsWrlW4Sz+MShGKtsQP2ar1Xo2IZFsq0jclXSoVMAn/tB93mLA7YX9ilLPIWM3G9hEUTXzAdadMk4gNPbR/ZMLVuN6FwiOtsAyr/0NGYe/ryLBeY3i2aGtJ2u/rDqM06s3hmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706177156; c=relaxed/simple;
	bh=1NjOq8QpYCQXV9SHSo6d3He/arkTV8LcnlAVkkf9pBU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SaPXLuDhGXNl8U14Zh1ybDwVuO/eQjPcxsNT1/MMIhCzo65CLC6hOvgfF49WkyAa1MFDOSMDoSATlcOYCz0B0xqq7nzJ8gGubyhK0NzR4K+o3zh5e4c41RiUrtL3eu+WEVBNDoOOXTYLEdYoFmZ4kgt46VJ3rUDBGj4/twTHkFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CPeHRxBX; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40PA5Dv8069387;
	Thu, 25 Jan 2024 04:05:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706177114;
	bh=90Wx4wXz/bfBM2NhwoVGPDRkYZNOgi7Yeec6KpjN/Ls=;
	h=From:To:CC:Subject:Date;
	b=CPeHRxBXGTIzCLbb0ubbCteR0llpO8eSyEdrZpMhdZw2NYEhFwsCl+BSKqXe3wogU
	 ANxhP0kex5cDRqHkPBPrdpkO2HMRun8lkKC2niysoj620HIxyh/dwmYpXioHMvUclR
	 qj3NlhoJupU6h+34z7Q/IKCYIo+hSKwN7qZBf7uE=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40PA5D3I025973
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Jan 2024 04:05:13 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Jan 2024 04:05:13 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Jan 2024 04:05:13 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40PA5C6p005006;
	Thu, 25 Jan 2024 04:05:12 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Andrew Davis <afd@ti.com>, Peter Rosin <peda@axentia.se>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth
 Menon <nm@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>, <r-gunasekaran@ti.com>, <danishanwar@ti.com>,
        Chintan Vankar
	<c-vankar@ti.com>
Subject: [PATCH v3 0/5] Add CPSW2G and CPSW9G nodes for J784S4
Date: Thu, 25 Jan 2024 15:34:56 +0530
Message-ID: <20240125100501.4137977-1-c-vankar@ti.com>
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
  arm64: dts: ti: k3-j784s4-main: Fix mux-reg-masks in serdes_ln_ctrl

Siddharth Vadapalli (4):
  arm64: dts: ti: k3-j784s4-main: Add CPSW2G and CPSW9G nodes
  arm64: dts: ti: k3-j784s4: Add Main CPSW2G node
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


