Return-Path: <linux-kernel+bounces-84497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C2886A781
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8827D1F2405F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2169620332;
	Wed, 28 Feb 2024 04:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lApzpA77"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3524C2032E
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 04:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709093542; cv=none; b=UHCX+TT5q4bwVWr8FASxvVm4Dm5ZN+XS48LHh4lBTuD0jPrKbevf0oVOyU61s5Ccs9xJcSTi4TVcmJ0xqC81+pIQ9Z1M3oIA+hTAV8ruHuBQNKXdZd7kzP60+ajXrBra3aX97Yqy0jXgeIGVP00E+RuPyVvsxO/qnaVf5+H3JKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709093542; c=relaxed/simple;
	bh=Lnr2cqFC5Ms3Ww1RRSxUe0Hh6shkqKumjhGCyK0C9Ps=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:Content-Type; b=oDXkbkDZ6+py7DMyhhcdT7vsFJbDxgC8JUpD4TvPSr5yxGPNLTY0PNoFMAjusDS1ezWVSoE6XepNK/dkhnK30Xp71A2iwqT4v2OvehQjI+mMzaGw9bdf8gZg7qAHMZDj8xV/obJ2UImp5+OMHayzbUOL1q8HR3I15T2+zHg6/g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lApzpA77; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41S4C0lA086154;
	Tue, 27 Feb 2024 22:12:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709093520;
	bh=wtH5nNLUGak97AzBUrzh+WNIhSeQeMJZCay59Y0ohao=;
	h=Date:From:Subject:To:CC;
	b=lApzpA77DJQej5S7NBsrjjPybFkq7B1wAYlyvACoQ5BYKpRHto/mmpxmCmYf8Zw2N
	 zueNsnKx1O3YAkEpxHoLsGxrtQRfQAcpqdY+Ru5ypvRHJa1vqfAkchTgBqFTM1eMEN
	 KWLfrc9jqcHJJdr6Wy6SlexZL2iAK41aKXaD+ZrY=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41S4C0jL086387
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Feb 2024 22:12:00 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 Feb 2024 22:12:00 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 Feb 2024 22:12:00 -0600
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41S4BuvM099972;
	Tue, 27 Feb 2024 22:11:57 -0600
Message-ID: <e7e984db-47b9-404a-9471-5d2ed0effe1d@ti.com>
Date: Wed, 28 Feb 2024 09:41:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vignesh Raghavendra <vigneshr@ti.com>
Subject: [GIT PULL 1/2] arm64: dts: ti: K3 devicetree updates for v6.9
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm-soc
	<arm@kernel.org>, SoC <soc@kernel.org>
CC: Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------5qbsYK036nqbgMv6V2c0vg1l"
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--------------5qbsYK036nqbgMv6V2c0vg1l
Content-Type: multipart/mixed; boundary="------------VOwKNiEfW0w7MFrBuRURn4Jz";
 protected-headers="v1"
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
 arm-soc <arm@kernel.org>, SoC <soc@kernel.org>
Cc: Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Nishanth Menon <nm@ti.com>
Message-ID: <e7e984db-47b9-404a-9471-5d2ed0effe1d@ti.com>
Subject: [GIT PULL 1/2] arm64: dts: ti: K3 devicetree updates for v6.9

--------------VOwKNiEfW0w7MFrBuRURn4Jz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd3=
3d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3=
-dt-for-v6.9

for you to fetch changes up to bbef42084cc170cbfc035bf784f2ff055c939d7e:

  arm64: dts: ti: hummingboard-t: add overlays for m.2 pci-e and usb-3 (2=
024-02-26 15:51:36 +0530)

----------------------------------------------------------------
TI K3 device tree updates for v6.9

New Features across family / New SoCs:
- J722s SoC and board support with OSPI NOR, CPSW ethernet
- Camera capture support on mulitple J7xx SoCs, AM68, AM69 and AM62P SoCs=

- Wave5 Encoder/Decoder support for J721s2, J784s4 and AM62P

Generic Cleanups/Fixes:
- Stop spliting single mbox items
- Adds MIT license along with GPL-2.0 for all TI DTS files
- Moves PCIe EP nodes in overlays
- VTM Power domain fixups for J7xx SoCs
- Conversion of mmio mux users to reg-mux where possible
- Drops unnecessary UART pinmuxes on J7xx SoCs
- MMC TAP value updates for AM64/AM62A/AM62P for improved stability
- DSS register space updates for AM65/AM62/AM62A

SoC specific Fixes/Features:
J7200:
- Adds CAN support
- New compatible for J7200 to support IO wakeup

AM62A
- HDMI Display (DSS) support
- Move to simple-bus for main_conf node
- eMMC, additional MMC/SD instance support

AM62
- move to simple-bus for main_conf node

AM654
- IOT2050-SM board support
- IOT2050 DT refractoring.

AM64
- SolidRun AM642 HummingBoard-T support and its DT overlays
- ICSSG Ethernet support and associated peripherals

Board specific fixes/Features:
- Beagle Play MDIO and USB node fixes
- TPM support on k3-am642-phyboard-electra and verdin-am62-mallow
- Phycore-am64 ADC
- PCIe + USB2.0 SERDES and PCIe + USB3.0 SERDES card support
- USB1 support on verdin-am62

----------------------------------------------------------------
Andrejs Cainikovs (2):
      arm64: dts: ti: verdin-am62: add support for Verdin USB1 interface
      arm64: dts: ti: k3-am62-main: disable usb lpm

Andrew Davis (26):
      arm64: dts: ti: k3-am642-evm: Do not split single items
      arm64: dts: ti: k3-am642-sk: Do not split single items
      arm64: dts: ti: iot2050: Do not split single items
      arm64: dts: ti: k3-am654-base-board: Do not split single items
      arm64: dts: ti: k3-am68-sk-som: Do not split single items
      arm64: dts: ti: k3-am69-sk: Do not split single items
      arm64: dts: ti: k3-j7200-som-p0: Do not split single items
      arm64: dts: ti: k3-j721e-beagleboneai64: Do not split single items
      arm64: dts: ti: k3-j721e-sk: Do not split single items
      arm64: dts: ti: k3-j721e-som-p0: Do not split single items
      arm64: dts: ti: k3-j721s2-som-p0: Do not split single items
      arm64: dts: ti: k3-j7200: Enable PCIe nodes at the board level
      arm64: dts: ti: k3-j7200: Remove PCIe endpoint node
      arm64: dts: ti: k3-am65: Remove PCIe endpoint nodes
      arm64: dts: ti: k3-am64: Remove PCIe endpoint node
      arm64: dts: ti: k3-am64: Convert serdes_ln_ctrl node into reg-mux
      arm64: dts: ti: k3-j7200: Convert serdes_ln_ctrl node into reg-mux
      arm64: dts: ti: k3-j7200: Convert usb_serdes_mux node into reg-mux
      arm64: dts: ti: k3-j721e: Convert serdes_ln_ctrl node into reg-mux
      arm64: dts: ti: k3-j721e: Convert usb_serdes_mux node into reg-mux
      arm64: dts: ti: k3-j721s2: Convert usb_serdes_mux node into reg-mux=

      arm64: dts: ti: k3-j721s2: Convert serdes_ln_ctrl node into reg-mux=

      arm64: dts: ti: k3-j7200: Make the FSS node a simple-bus
      arm64: dts: ti: k3-am62: Make the main_conf node a simple-bus
      arm64: dts: ti: k3-am62a: Make the main_conf node a simple-bus
      arm64: dts: ti: k3-j721e: Fix mux-reg-masks in hbmc_mux

Apurva Nandan (1):
      arm64: dts: ti: Add phase tags for memory node on J784S4 EVM and AM=
69 SK

Aradhya Bhatia (3):
      arm64: dts: ti: k3-am62a-main: Add node for Display SubSystem (DSS)=

      arm64: dts: ti: k3-am62a7-sk: Add HDMI support
      arm64: dts: ti: Makefile: Add HDMI audio check for AM62A7-SK

Baocheng Su (2):
      arm64: dts: ti: iot2050: Disable R5 lockstep for all PG2 boards
      arm64: dts: ti: iot2050: Support IOT2050-SM variant

Bhavya Kapoor (7):
      arm64: dts: ti: k3-j7200: Add support for CAN nodes
      arm64: dts: ti: k3-j7200-som-p0: Add support for CAN instance 0 in =
main domain
      arm64: dts: ti: k3-j7200: Add support for multiple CAN instances
      arm64: dts: ti: k3-j7200-common-proc-board: Modify Pinmux for wkup_=
uart0 and mcu_uart0
      arm64: dts: ti: k3-j7200-common-proc-board: Remove clock-frequency =
from mcu_uart0
      arm64: dts: ti: k3-j721s2-common-proc-board: Remove Pinmux for CTS =
and RTS in wkup_uart0
      arm64: dts: ti: k3-j784s4-evm: Remove Pinmux for CTS and RTS in wku=
p_uart0

Brandon Brnich (2):
      arm64: dts: ti: k3-j784s4: Add Wave5 Video Encoder/Decoder Node
      arm64: dts: ti: k3-am62p: Add Wave5 Video Encoder/Decoder Node

Chintan Vankar (1):
      arm64: dts: ti: k3-j784s4-main: Fix mux-reg-masks in serdes_ln_ctrl=


Darren Etheridge (1):
      arm64: dts: ti: k3-j721s2-main: Add Wave5 Video Encoder/Decoder Nod=
e

Dasnavis Sabiya (2):
      arm64: dts: ti: k3-am69-sk: Enable CAN interfaces for AM69 SK board=

      arm64: dts: ti: k3-am69-sk: Add support for OSPI flash

Devarsh Thakkar (3):
      arm64: dts: ti: Add common1 register space for AM65x SoC
      arm64: dts: ti: Add common1 register space for AM62x SoC
      arm64: dts: ti: Add common1 register space for AM62A SoC

Francesco Dolcini (2):
      arm64: dts: ti: verdin-am62: mallow: add TPM device
      arm64: dts: ti: verdin-am62: Set VDD CORE minimum voltage to 0.75V

Jai Luthra (4):
      arm64: dts: ti: k3-am62p: Fix memory ranges for DMSS
      arm64: dts: ti: k3-am62p: Add DMASS1 for CSI
      arm64: dts: ti: k3-am62p: Add nodes for CSI-RX
      arm64: dts: ti: Enable overlays for SK-AM62P

Jan Kiszka (4):
      arm64: dts: ti: iot2050: Factor out arduino connector bits
      arm64: dts: ti: iot2050: Factor out enabling of USB3 support
      arm64: dts: ti: iot2050: Factor out DP related bits
      arm64: dts: ti: iot2050: Annotate LED nodes

Jayesh Choudhary (1):
      arm64: dts: ti: k3-am69-sk: remove assigned-clock-parents for unuse=
d VP

Josua Mayer (3):
      dt-bindings: arm: ti: Add bindings for SolidRun AM642 HummingBoard-=
T
      arm64: dts: add description for solidrun am642 som and evaluation b=
oard
      arm64: dts: ti: hummingboard-t: add overlays for m.2 pci-e and usb-=
3

Judith Mendez (7):
      arm64: dts: ti: k3-am62a-main: Add sdhci2 instance
      arm64: dts: ti: k3-am64-main: Fix ITAP/OTAP values for MMC
      arm64: dts: ti: k3-am62p: Add ITAP/OTAP values for MMC
      arm64: dts: ti: k3-am6*: Remove DLL properties for soft PHYs
      arm64: dts: ti: k3-am6*: Fix ti,clkbuf-sel property in MMC nodes
      arm64: dts: ti: k3-am6*: Fix bus-width property in MMC nodes
      arm64: dts: ti: k3-am6*: Add bootph-all property in MMC node

Kishon Vijay Abraham I (1):
      arm64: dts: ti: Add DT overlay for PCIe + USB3.0 SERDES personality=
 card

Li Hua Qian (1):
      arm64: dts: ti: Add reserved memory for watchdog

MD Danish Anwar (2):
      arm64: dts: ti: k3-am642-evm: add ICSSG1 Ethernet support
      arm64: dts: ti: k3-am642-evm: add overlay for ICSSG1 2nd port

Manorit Chawdhry (2):
      arm64: dts: ti: k3-j721s2: Fix power domain for VTM node
      arm64: dts: ti: k3-j784s4: Fix power domain for VTM node

Nathan Morrisson (3):
      arm64: dts: ti: Disable clock output of the ethernet PHY
      arm64: dts: ti: phycore-am64: Add ADC
      arm64: dts: ti: am62-phyboard-lyra: Add overlay to enable a GPIO fa=
n

Nishanth Menon (16):
      arm64: dts: ti: Use https for urls
      arm64: dts: ti: k3-am62a7: Add MIT license along with GPL-2.0
      arm64: dts: ti: k3-am625: Add MIT license along with GPL-2.0
      arm64: dts: ti: k3-am62p: Add MIT license along with GPL-2.0
      arm64: dts: ti: k3-am64: Add MIT license along with GPL-2.0
      arm64: dts: ti: k3-am65: Add MIT license along with GPL-2.0
      arm64: dts: ti: k3-j7200: Add MIT license along with GPL-2.0
      arm64: dts: ti: k3-j721e: Add MIT license along with GPL-2.0
      arm64: dts: ti: k3-j721s2: Add MIT license along with GPL-2.0
      arm64: dts: ti: k3-j784s4: Add MIT license along with GPL-2.0
      arm64: dts: ti: k3-pinctrl: Add MIT license along with GPL-2.0
      arm64: dts: ti: k3-serdes: Add MIT license along with GPL-2.0
      arm64: dts: ti: beagle*: Add MIT license along with GPL-2.0
      arm64: dts: ti: phycore*: Add MIT license along with GPL-2.0
      arm64: dts: ti: iot2050*: Clarify GPL-2.0 as GPL-2.0-only
      arm64: dts: ti: Makefile: Clarify GPL-2.0 as GPL-2.0-only

Nitin Yadav (2):
      arm64: dts: ti: k3-am62a-main: Add sdhci0 instance
      arm64: dts: ti: k3-am62a7-sk: Enable eMMC support

Ravi Gunasekaran (1):
      arm64: dts: ti: k3-am62p5-sk: Enable CPSW MDIO node

Roger Quadros (2):
      arm64: dts: ti: am65x: Fix dtbs_install for Rocktech OLDI overlay
      arm64: dts: ti: Add DT overlay for PCIe + USB2.0 SERDES personality=
 card

Romain Naour (2):
      arm64: dts: ti: k3-am69-sk: fix PMIC interrupt number
      arm64: dts: ti: k3-j721e-sk: fix PMIC interrupt number

Siddharth Vadapalli (1):
      arm64: dts: ti: k3-j722s-evm: Enable CPSW3G RGMII1

Sjoerd Simons (3):
      arm64: dts: ti: k3-am625-sk: Add boot phase tags for USB0
      arm64: dts: ti: k3-am625-beagleplay: Add boot phase tags for USB0
      arm64: dts: ti: k3-am625-beagleplay: Use the builtin mdio bus

Su Bao Cheng (1):
      dt-bindings: arm: ti: Add binding for Siemens IOT2050 SM variant

Suman Anna (1):
      arm64: dts: ti: k3-am64-main: Add ICSSG IEP nodes

Thomas Richard (1):
      arm64: dts: ti: k3-j7200: use ti,j7200-padconf compatible

Tony Lindgren (1):
      arm64: dts: ti: k3-am62-wakeup: Configure ti-sysc for wkup_uart0

Vaishnav Achath (14):
      arm64: dts: ti: k3-am62p-mcu/wakeup: Disable MCU and wakeup R5FSS n=
odes
      dt-bindings: arm: ti: Add bindings for J722S SoCs
      arm64: dts: ti: Introduce J722S family of SoCs
      arm64: dts: ti: Add support for TI J722S Evaluation Module
      arm64: dts: ti: k3-j721s2-common-proc-board: Enable camera peripher=
als
      arm64: dts: ti: k3-j784s4-evm: Enable camera peripherals
      arm64: dts: ti: k3-am68-sk-base-board: Enable camera peripherals
      arm64: dts: ti: k3-am69-sk: Enable camera peripherals
      arm64: dts: ti: k3-j721e-sk: Model CSI2RX connector mux
      arm64: dts: ti: k3-j721e-main: Add CSI2RX capture nodes
      arm64: dts: ti: k3-j721s2-main: Add CSI2RX capture nodes
      arm64: dts: ti: k3-j784s4-main: Add CSI2RX capture nodes
      arm64: dts: ti: k3-j721e-sk: Add overlay for IMX219
      arm64: dts: ti: k3-j722s-evm: Enable OSPI NOR support

Wadim Egorov (1):
      arm64: dts: ti: k3-am642-phyboard-electra: Add TPM support

 Documentation/devicetree/bindings/arm/ti/k3.yaml              |  14 +
 arch/arm64/boot/dts/ti/Makefile                               |  55 +-
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts                      |   4 +-
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi                      |  30 +-
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi                       |   4 +-
 arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi               |   5 +-
 arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi                   |   5 +-
 arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi             |   1 -
 arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi                |   1 -
 arch/arm64/boot/dts/ti/k3-am62-verdin-mallow.dtsi             |  10 +
 arch/arm64/boot/dts/ti/k3-am62-verdin-wifi.dtsi               |   1 -
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi                    |  59 +-
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi                    |  38 +-
 arch/arm64/boot/dts/ti/k3-am62.dtsi                           |   4 +-
 arch/arm64/boot/dts/ti/k3-am625-beagleplay-csi2-ov5640.dtso   |   4 +-
 .../boot/dts/ti/k3-am625-beagleplay-csi2-tevi-ov5640.dtso     |   4 +-
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts                |  54 +-
 arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts         |   6 +-
 arch/arm64/boot/dts/ti/k3-am625-sk.dts                        |   4 +-
 arch/arm64/boot/dts/ti/k3-am625.dtsi                          |   4 +-
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi                     |  80 +-
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi                      |   4 +-
 arch/arm64/boot/dts/ti/k3-am62a-thermal.dtsi                  |   5 +-
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi                   |   4 +-
 arch/arm64/boot/dts/ti/k3-am62a.dtsi                          |   4 +-
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts                       | 123 +-
 arch/arm64/boot/dts/ti/k3-am62a7.dtsi                         |   4 +-
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi                     | 154 +-
 arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi                      |   6 +-
 arch/arm64/boot/dts/ti/k3-am62p-thermal.dtsi                  |   5 +-
 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi                   |   5 +-
 arch/arm64/boot/dts/ti/k3-am62p.dtsi                          |   6 +-
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts                       |  11 +-
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi                         |   4 +-
 arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra-gpio-fan.dtso   |  50 +
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi                |   8 +-
 arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso           |   4 +-
 arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso           |   4 +-
 arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso      |   4 +-
 arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso            |   4 +-
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi                      |  69 +-
 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi                       |   4 +-
 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi               |  13 +-
 arch/arm64/boot/dts/ti/k3-am64-thermal.dtsi                   |   5 +-
 arch/arm64/boot/dts/ti/k3-am64.dtsi                           |   4 +-
 arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-dualemac.dtso      |  79 +
 arch/arm64/boot/dts/ti/k3-am642-evm.dts                       | 119 +-
 arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dtso      |  45 +
 arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso      |  44 +
 arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts            | 292 +++
 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts      |  30 +-
 arch/arm64/boot/dts/ti/k3-am642-sk.dts                        |  14 +-
 arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi                   | 594 ++++=
+++
 arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts        |   1 -
 arch/arm64/boot/dts/ti/k3-am642.dtsi                          |   4 +-
 arch/arm64/boot/dts/ti/k3-am65-iot2050-arduino-connector.dtsi | 768 ++++=
++++
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi        |   7 +-
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi        |  27 +-
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi            | 887 +---=
------
 arch/arm64/boot/dts/ti/k3-am65-iot2050-dp.dtsi                |  98 +
 arch/arm64/boot/dts/ti/k3-am65-iot2050-usb3.dtsi              |  27 +
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi                      |  37 +-
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi                       |   4 +-
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi                    |   4 +-
 arch/arm64/boot/dts/ti/k3-am65.dtsi                           |   4 +-
 arch/arm64/boot/dts/ti/k3-am652.dtsi                          |   4 +-
 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi    |   8 +-
 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts        |   4 +-
 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts            |   7 +-
 .../boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso |   4 +-
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts                |   8 +-
 arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso                   |   4 +-
 arch/arm64/boot/dts/ti/k3-am654-idk.dtso                      |   4 +-
 arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi       |   5 +-
 arch/arm64/boot/dts/ti/k3-am654-pcie-usb2.dtso                |  59 +
 arch/arm64/boot/dts/ti/k3-am654-pcie-usb3.dtso                |  61 +
 arch/arm64/boot/dts/ti/k3-am654.dtsi                          |   4 +-
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi |   2 +-
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts      |  22 +-
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts     |  12 +-
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts      | 189 ++
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts         |   3 +-
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts              |  54 +-
 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi                    |  20 +-
 arch/arm64/boot/dts/ti/k3-am69-sk.dts                         | 253 ++-
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts         | 109 +-
 arch/arm64/boot/dts/ti/k3-j7200-evm-quad-port-eth-exp.dtso    |   4 +-
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi                     | 315 +++-=

 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi               |  57 +-
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi                   |  47 +-
 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi                  |   5 +-
 arch/arm64/boot/dts/ti/k3-j7200.dtsi                          |   4 +-
 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts            |  26 +-
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts         |   4 +-
 arch/arm64/boot/dts/ti/k3-j721e-evm-gesi-exp-board.dtso       |   4 +-
 arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso             |   4 +-
 arch/arm64/boot/dts/ti/k3-j721e-evm-quad-port-eth-exp.dtso    |   4 +-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi                     | 149 +-
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi               |   8 +-
 arch/arm64/boot/dts/ti/k3-j721e-sk-csi2-dual-imx219.dtso      | 165 ++
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts                        |  45 +-
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi                   |  22 +-
 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi                  |   5 +-
 arch/arm64/boot/dts/ti/k3-j721e.dtsi                          |   4 +-
 arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts        |  31 +-
 arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso      |   4 +-
 arch/arm64/boot/dts/ti/k3-j721s2-evm-pcie1-ep.dtso            |   4 +-
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi                    | 143 +-
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi              |   6 +-
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi                  |  20 +-
 arch/arm64/boot/dts/ti/k3-j721s2-thermal.dtsi                 |   5 +-
 arch/arm64/boot/dts/ti/k3-j721s2.dtsi                         |   4 +-
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts                       | 383 ++++=

 arch/arm64/boot/dts/ti/k3-j722s.dtsi                          |  89 +
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts                      |  32 +-
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi                    | 215 ++-
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi              |   6 +-
 arch/arm64/boot/dts/ti/k3-j784s4-thermal.dtsi                 |   5 +-
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi                         |   6 +-
 arch/arm64/boot/dts/ti/k3-pinctrl.h                           |   7 +-
 arch/arm64/boot/dts/ti/k3-serdes.h                            |   4 +-
 121 files changed, 5249 insertions(+), 1399 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra-gpio-fa=
n.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-dualemac.d=
tso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.d=
tso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.d=
tso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-arduino-connec=
tor.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-dp.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-usb3.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am654-pcie-usb2.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am654-pcie-usb3.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.=
dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-sk-csi2-dual-imx219.d=
tso
 create mode 100644 arch/arm64/boot/dts/ti/k3-j722s-evm.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-j722s.dtsi
--=20
Regards
Vignesh

--------------VOwKNiEfW0w7MFrBuRURn4Jz--

--------------5qbsYK036nqbgMv6V2c0vg1l
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEyRC2zAhGcGjrhiNExEYeRXyRFuMFAmXesosFAwAAAAAACgkQxEYeRXyRFuP1
WQgAkC2ZfKcPjegnW83TitfHaqjlh5EKUHbbq3Mm5+On8vs48mUngTkfBTO6IWwIF1BTS8FL5PZ/
uMN9WqPp++UPdlVjKyRue/aRLA3ZYmJUWnEtcXRU238q+dee9OFyzIAV7CI17wfszYdUEJS4BBFn
oPyYgqVuMiUAlLS9zqsLUB7ObeuenrbPmjisaNAemzkJtpuNonKIW1S0CDd9NckbNvHIuoRtC6jm
k1sv0cJOV2kiHgX4vhUR9ay9U2RLRHZbjBFPm42OdmBzAC8P2bpRTpVBViHUDNF20pVBR0535OPs
IcjwIah1auMxjUVALYANsqxbY36c2o4NS3sQbReLmQ==
=Hv9n
-----END PGP SIGNATURE-----

--------------5qbsYK036nqbgMv6V2c0vg1l--

