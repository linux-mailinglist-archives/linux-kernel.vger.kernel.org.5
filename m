Return-Path: <linux-kernel+bounces-33219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4215836685
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74B222897DB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B105147A76;
	Mon, 22 Jan 2024 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HMTL1w52"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8215146535;
	Mon, 22 Jan 2024 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935380; cv=none; b=Sp3uO1DrHOIBY8FFOdLMz9NnkELi30maDqZv41nbojV7Q8odrVcHBOfYnZHnyer0telERzsgQ4yGpQXcXBaubfko878Mw0Q1lvb2ULe6MB6O0Nr3mTQPvDTIQx4gAj+H74F8GNQhYWJTjey9FlTrytgRbm0pvOb74+bIGVboJI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935380; c=relaxed/simple;
	bh=tseWQ+TXhuYGKRBWR8R0RrEZEs9EXXRyjbdZGTywX+Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oTy0oY5gE9aZU0JE4sZ+60wLRHLkTPcLUSZif2Ze+7ggfrc07Ua5dymtF6ulKWGbYgTSHfc8RIWUQe7ZYAB8+1O1zdyKz+I5S/milnwo0XwVftgVPCxLNGmcjvlTX75dFReMjuh3NbDQkxZ0/ZlwSU5xHXOikfydqL0NYreBQbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HMTL1w52; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40MEthx5045395;
	Mon, 22 Jan 2024 08:55:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705935343;
	bh=mCzh9yt7kMY1MpZtUBHO4MH/an5Hfn5JHx44oH9oldg=;
	h=From:To:CC:Subject:Date;
	b=HMTL1w52Z2LAmw21r8upUfo7oOAah+du0Z4Ht0uzVdIlgf/6xKEuwXalX2K24292j
	 /X7v6HbRh4OS5lkIxX0cpCg10MV5Do9UKhFzzclCcYM2HTrn9fag0OFenNqAa+S5g3
	 cPDVodW2zIokJLC7NXIONyodweYKv0+kllSlIAC8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40MEthX5126190
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Jan 2024 08:55:43 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Jan 2024 08:55:43 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Jan 2024 08:55:43 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40MEthel021988;
	Mon, 22 Jan 2024 08:55:43 -0600
From: Nishanth Menon <nm@ti.com>
To: Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Nishanth Menon <nm@ti.com>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Ayush Singh <ayushdevel1325@gmail.com>,
        Chao Zeng <chao.zeng@siemens.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Esteban Blanc
	<eblanc@baylibre.com>,
        Garrett Giordano <ggiordano@phytec.com>,
        Guillaume La
 Roque <glaroque@baylibre.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jason
 Kridner <jkridner@beagleboard.org>,
        Jerome Neanne <jneanne@baylibre.com>,
        Julien Panis <jpanis@baylibre.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Le Jin <le.jin@siemens.com>,
        Matthias
 Schiffer <matthias.schiffer@ew.tq-group.com>,
        Peng Fan <peng.fan@nxp.com>, Pierre Gondois <pierre.gondois@arm.com>,
        Robert Nelson
	<robertcnelson@gmail.com>,
        Rob Herring <robh@kernel.org>, Roger Quadros
	<rogerq@kernel.org>,
        Ronald Wahl <ronald.wahl@raritan.com>,
        Sarah Walker
	<sarah.walker@imgtec.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Tony Lindgren <tony@atomide.com>, Wadim Egorov <w.egorov@phytec.de>
Subject: [PATCH V2 00/16] arm64: dts: ti: Additional licensing and clarification
Date: Mon, 22 Jan 2024 08:55:23 -0600
Message-ID: <20240122145539.194512-1-nm@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Thank you all for the detailed acks on various patches on V1,
consolidated all of these with V2 and noted some missing acks below.
Since it has been 12 days since I posted v1 and v6.8-rc1 is now
tagged, looks like a good time to refresh the series.

As part of my 2023 LPC talk[1] about the difficulty in ensuring
device tree is same across multiple s/w ecosystems, I mentioned about
Licensing, and Rob had indicated that other SoC vendors have MIT
license option that allows co-existance with Apache.

So, bunch of internal paper work later (during which GPL-2.0-only
had to be retained due to certain user community), here is the
update to sync TI K3 device trees with addition of MIT license in
addition to existing GPL-2.0 license.

After querying BeagleBoard Foundation folks, they'd also like to
follow suit, so those platforms have been added to the list as well.

While at this, clarify existing licenses to be compatible with latest
SPDX specifications for iot2050 and phycore.

Verdin platforms look already sane, so no action required there.

The CC list is based on (Since I am representing @ti.com for this
series):
git log --no-merges --pretty="%ae" $files|grep -v "@ti.com"|sort -u

Requesting Acked by from the CC list at the earliest so that we can
merge this for next baseline. - patches 6, 8 and 10 need some
love.

- "Alexander A. Klimov" <grandmaster@al2klimov.de> (patch #6, #8)
- Rob Herring <robh@kernel.org> (patch #6)
- Peng Fan <peng.fan@nxp.com> (patch #8)
- Jerome Neanne <jneanne@baylibre.com> (patch #8, #10)

Changes since V1:
* Just picked up acks, most patches are clean now except for 6, 8 and
  10.
* As requested, Switched Phytec license from GPL2.0-only to Adding MIT
  along with it.

V1: https://lore.kernel.org/all/20240110140903.4090946-1-nm@ti.com/


Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: Ayush Singh <ayushdevel1325@gmail.com>
Cc: Chao Zeng <chao.zeng@siemens.com>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Esteban Blanc <eblanc@baylibre.com>
Cc: Garrett Giordano <ggiordano@phytec.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jason Kridner <jkridner@beagleboard.org>
Cc: Jerome Neanne <jneanne@baylibre.com>
Cc: Julien Panis <jpanis@baylibre.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Le Jin <le.jin@siemens.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>
Cc: Robert Nelson <robertcnelson@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Ronald Wahl <ronald.wahl@raritan.com>
Cc: Sarah Walker <sarah.walker@imgtec.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Wadim Egorov <w.egorov@phytec.de>

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

 arch/arm64/boot/dts/ti/Makefile                           | 2 +-
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts                  | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi                  | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi                   | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi           | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi               | 5 ++++-
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi                | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62.dtsi                       | 4 ++--
 .../boot/dts/ti/k3-am625-beagleplay-csi2-ov5640.dtso      | 4 ++--
 .../boot/dts/ti/k3-am625-beagleplay-csi2-tevi-ov5640.dtso | 4 ++--
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts            | 6 +++---
 arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts     | 4 ++--
 arch/arm64/boot/dts/ti/k3-am625-sk.dts                    | 4 ++--
 arch/arm64/boot/dts/ti/k3-am625.dtsi                      | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi                 | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi                  | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62a-thermal.dtsi              | 5 ++++-
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi               | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62a.dtsi                      | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts                   | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62a7.dtsi                     | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi                 | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi                  | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62p-thermal.dtsi              | 5 ++++-
 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi               | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62p.dtsi                      | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts                   | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi                     | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi            | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso       | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso       | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso  | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso        | 4 ++--
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi                  | 4 ++--
 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi                   | 4 ++--
 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi           | 6 +++---
 arch/arm64/boot/dts/ti/k3-am64-thermal.dtsi               | 5 ++++-
 arch/arm64/boot/dts/ti/k3-am64.dtsi                       | 4 ++--
 arch/arm64/boot/dts/ti/k3-am642-evm.dts                   | 4 ++--
 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts  | 6 +++---
 arch/arm64/boot/dts/ti/k3-am642-sk.dts                    | 4 ++--
 arch/arm64/boot/dts/ti/k3-am642.dtsi                      | 4 ++--
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi    | 2 +-
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi    | 2 +-
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi        | 2 +-
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi                  | 4 ++--
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi                   | 4 ++--
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi                | 4 ++--
 arch/arm64/boot/dts/ti/k3-am65.dtsi                       | 4 ++--
 arch/arm64/boot/dts/ti/k3-am652.dtsi                      | 4 ++--
 .../arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi | 2 +-
 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts    | 2 +-
 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts        | 2 +-
 .../dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso  | 4 ++--
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts            | 4 ++--
 arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso               | 4 ++--
 arch/arm64/boot/dts/ti/k3-am654-idk.dtso                  | 4 ++--
 arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi   | 5 ++++-
 arch/arm64/boot/dts/ti/k3-am654.dtsi                      | 4 ++--
 .../boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi    | 2 +-
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts  | 2 +-
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts | 2 +-
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts     | 2 +-
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts          | 4 ++--
 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi                | 4 ++--
 arch/arm64/boot/dts/ti/k3-am69-sk.dts                     | 4 ++--
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts     | 4 ++--
 .../arm64/boot/dts/ti/k3-j7200-evm-quad-port-eth-exp.dtso | 4 ++--
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi                 | 4 ++--
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi           | 4 ++--
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi               | 4 ++--
 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi              | 5 ++++-
 arch/arm64/boot/dts/ti/k3-j7200.dtsi                      | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts        | 8 ++++----
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts     | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-evm-gesi-exp-board.dtso   | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso         | 4 ++--
 .../arm64/boot/dts/ti/k3-j721e-evm-quad-port-eth-exp.dtso | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi                 | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi           | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts                    | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi               | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi              | 5 ++++-
 arch/arm64/boot/dts/ti/k3-j721e.dtsi                      | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts    | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso  | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721s2-evm-pcie1-ep.dtso        | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi                | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi          | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi              | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721s2-thermal.dtsi             | 5 ++++-
 arch/arm64/boot/dts/ti/k3-j721s2.dtsi                     | 4 ++--
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts                  | 4 ++--
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi                | 4 ++--
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi          | 4 ++--
 arch/arm64/boot/dts/ti/k3-j784s4-thermal.dtsi             | 5 ++++-
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi                     | 4 ++--
 arch/arm64/boot/dts/ti/k3-pinctrl.h                       | 4 ++--
 arch/arm64/boot/dts/ti/k3-serdes.h                        | 4 ++--
 99 files changed, 210 insertions(+), 183 deletions(-)


base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d


[1] https://www.youtube.com/watch?v=kr-Yd56so9M
    https://lpc.events/event/17/contributions/1547/
-- 
2.43.0


