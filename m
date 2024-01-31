Return-Path: <linux-kernel+bounces-46186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 541A2843BF4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790AF1C26979
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9802669D0D;
	Wed, 31 Jan 2024 10:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HFqf9+F9"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3247657DD;
	Wed, 31 Jan 2024 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696098; cv=none; b=aBhgl2amiUFEWaHQehYUHVNWvXyteC5CrUkzP9iJbmpcoUT9kmU9E254WAXy2bxXoF3hjEVu/OER6rZvIf6DIKVfcJDe8Kpd+nPFCFQ5a2ol6JPHh6Y8U66pbeB45oJ4iA7b9ATJm68LKTHUtWEg7cvgy/pU3r+3Qs+etqD/+6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696098; c=relaxed/simple;
	bh=b/GOL9zNV3mBZgbVA/hrJx5X+eL8qO8R3xgQko1NDuM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zg0Vm7UfdXnAT1lwNpKaQesGlDSBRSQpw50vv7wRfZmLuRK6m2GkfCEXmaiotp7Af3eaLaJcExICchvKf2HHz1EvGlIUK6mhm7WvORLR5vuWbhGzoudqQE+3dGPwiUH5PDMlFeYHWqYT8HH/4swqe4WSHiOfEAGXTLf+OG5BKqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HFqf9+F9; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VAEj7c055743;
	Wed, 31 Jan 2024 04:14:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706696085;
	bh=WbfLvT3kFZSrbmnYEVEAt8P7Y9YgAdQ7hhEX+xYFdMs=;
	h=From:To:CC:Subject:Date;
	b=HFqf9+F9GVkERESXJKXO2Er9NfzDFxq81359lHFqEIjN+Tm/h8nEOP9lJ5055np3p
	 X+taUoUiLfxvqju+oEu+MdbqstQygDCVnLRhU8VzA4yuOSrga8K+/xeaFVJ+HUWRwN
	 rtuLZtluTyHLfhC3JfmLlO0sdoZT3a+suPK5xo/c=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VAEjii075176
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 04:14:45 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 04:14:44 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 04:14:44 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VAEiBr110197;
	Wed, 31 Jan 2024 04:14:44 -0600
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
Subject: [PATCH v4 0/6] Add CPSW2G and CPSW9G nodes for J784S4
Date: Wed, 31 Jan 2024 15:44:35 +0530
Message-ID: <20240131101441.1362409-1-c-vankar@ti.com>
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

Link to v3: https://lore.kernel.org/r/20240125100501.4137977-1-c-vankar@ti.com/

Changes from v3 to v4:
1. Add alias for MCU CPSW2G node.
2. Add alias for Main CPSW2G node.
3. Add "ti,mac-only" property for CPSW9G node.

Chintan Vankar (2):
  arm64: dts: ti: k3-j784s4-main: Fix mux-reg-masks in serdes_ln_ctrl
  arm64: dts: ti: k3-j784s4: Add alias to MCU CPSW2G

Siddharth Vadapalli (4):
  arm64: dts: ti: k3-j784s4-main: Add CPSW2G and CPSW9G nodes
  arm64: dts: ti: k3-j784s4: Add Main CPSW2G node
  arm64: dts: ti: k3-j784s4: Add overlay to enable QSGMII mode with
    CPSW9G
  arm64: dts: ti: k3-j784s4: Add overlay for dual port USXGMII mode

 arch/arm64/boot/dts/ti/Makefile               |  11 +-
 .../ti/k3-j784s4-evm-quad-port-eth-exp1.dtso  | 147 +++++++++++++
 .../ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso   |  81 +++++++
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      |  50 +++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 198 +++++++++++++++++-
 5 files changed, 480 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm-quad-port-eth-exp1.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso

-- 
2.34.1


