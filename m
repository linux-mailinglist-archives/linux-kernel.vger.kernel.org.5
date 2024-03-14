Return-Path: <linux-kernel+bounces-102924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0227F87B87C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A718285B31
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9335C61F;
	Thu, 14 Mar 2024 07:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hoFwd0qR"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88506FB5;
	Thu, 14 Mar 2024 07:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710400912; cv=none; b=WxQoc84DDsJjT/NF/awd/yWyK6XAzPIRb79F3n7PM7V/54EpIFN2XpXsxuq/XYg4rwMPHGlAvt1lww+DGUi38IhKV74Mvr2isMNiH+hl1sgOYGRZBNABX0o8121YKsAF1CgVO/i4ydQAwAPTDZTu1rx8htbQgiUBxVUZnNcrJbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710400912; c=relaxed/simple;
	bh=ccHcqSZqrWHjYm6IvFnlj2uvZd1bVYq//MUBZilUvvE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XXpRIXBRBqHCH6QrglYDi0zHfbUjQ99+ilEOvS63pllQJz7dZuuTeD3ASnMXy3tPNVrARptQb4M1HYOI94zoHIcQONL/I0wL8BipbfDrZ/JG8YN++TezeqaL2q01qJWdLEJpBmOMV35l5YX3Uc6QX4NI1qkfDLLlPoqDl6VfFLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hoFwd0qR; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42E7LWhp021096;
	Thu, 14 Mar 2024 02:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710400892;
	bh=FcoX7xACm0C1orkfdYLpksQ6GDrWcw1v4XBWKblj6aE=;
	h=From:To:CC:Subject:Date;
	b=hoFwd0qRrkujocVtDEidzEbAzz2Ly1IGAPu61kJNMe5pQNyj4eKt8ls4Yd4QWuHEi
	 Svzmc7WEcYeHgcoFVOI8mTLxY4Wbu2ZaLvXzf0wEzK0qjlaT3uZ6TBuJVgTqtouB8p
	 IbhJmqHW9ZxTRayloC3TzQi0NfGeT6hHMdGFZOYY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42E7LWSl021663
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 14 Mar 2024 02:21:32 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 14
 Mar 2024 02:21:32 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 14 Mar 2024 02:21:32 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42E7LVQW120513;
	Thu, 14 Mar 2024 02:21:32 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth
 Menon <nm@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <s-vadapalli@ti.com>,
        <srk@ti.com>, <r-gunasekaran@ti.com>, <danishanwar@ti.com>,
        Chintan Vankar
	<c-vankar@ti.com>
Subject: [PATCH v5 0/5] Add CPSW2G and CPSW9G nodes for J784S4
Date: Thu, 14 Mar 2024 12:51:24 +0530
Message-ID: <20240314072129.1520475-1-c-vankar@ti.com>
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

Link to v4:
https://lore.kernel.org/r/20240131101441.1362409-1-c-vankar@ti.com/

Changes from v4 to v5:
1. Removed Patch at:
   https://lore.kernel.org/r/20240131101441.1362409-2-c-vankar@ti.com/
   from this version as it is posted as a separate patch at:
   https://lore.kernel.org/r/20240213080348.248916-1-s-vadapalli@ti.com/
2. Disabled node "main_cpsw1_mdio" in k3-j784s4-main.dtsi and enabled it
   in k3-j784s4-evm.dts.

Chintan Vankar (1):
  arm64: dts: ti: k3-j784s4-evm: Add alias for MCU CPSW2G

Siddharth Vadapalli (4):
  arm64: dts: ti: k3-j784s4-main: Add CPSW2G and CPSW9G nodes
  arm64: dts: ti: k3-j784s4-evm: Enable Main CPSW2G node and add aliases
    for it
  arm64: dts: ti: k3-j784s4: Add overlay to enable QSGMII mode with
    CPSW9G
  arm64: dts: ti: k3-j784s4: Add overlay for dual port USXGMII mode

 arch/arm64/boot/dts/ti/Makefile               |  11 +-
 .../ti/k3-j784s4-evm-quad-port-eth-exp1.dtso  | 147 ++++++++++++++
 .../ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso   |  81 ++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      |  51 +++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 187 ++++++++++++++++++
 5 files changed, 476 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm-quad-port-eth-exp1.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso

-- 
2.34.1


