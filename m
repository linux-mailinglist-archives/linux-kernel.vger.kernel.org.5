Return-Path: <linux-kernel+bounces-62753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BFB852548
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717C21C23AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDB912FB00;
	Tue, 13 Feb 2024 00:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pmkqNOwY"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B95B130ACD;
	Tue, 13 Feb 2024 00:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783876; cv=none; b=HLBCGj/vHIs+9ghGmVPCCQMtKZWKZpubUIub0b5X+PVfM0DEUCoVYBgmves14KUM2+R/RkcqnBgOapmq/VT+Fb9WAaq9YaKnng+CLs++ozBC4xcuTlkbJDijru9vaeL7egvQlY3ekwZZJx01qZkBsoSu2WKIIQgm3dho+S8+45w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783876; c=relaxed/simple;
	bh=FXhH1wQzbIwGCvQrq8FSKOMRbxbkr/ACCqi97KWWZDE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IbTC3I7bCYFvfnVjK6VVcXkbr4gNfBs+NMUTYZbgX8sMyjPWo+YcsumQiSrP+AXYo9HwSTcYzxHnJA3OM1BE6Gw1UFwzXNJ3LxlgCBIQmvDEnWDF9r1tpF7NW8HR2f156yR1I1ckndYq5SBewT8w2LNuWMXDNDJO7+gMrrt7UpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pmkqNOwY; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41D0OHXV061424;
	Mon, 12 Feb 2024 18:24:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707783857;
	bh=KRdHsmmSf+DstTGqo1ZdeTIDrC/r9iMRVkf72BFbhHw=;
	h=From:To:CC:Subject:Date;
	b=pmkqNOwYTyofL1GUOwxJhCqYLKrdLszZK2e5mWmLXapselbh6LxxRcFiJhpTD7dEU
	 W+qC3W7O/dzO1aMumGqN4Mw8bq22x3LGTeNbOtajDImyhjLMY1rHLgCr0SG7aQhreQ
	 7BuIctNvoBHth/il1wTtMNMtb5vIkmViyFXXM7WI=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41D0OHLH031528
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 18:24:17 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 18:24:16 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 18:24:16 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41D0OGXe119810;
	Mon, 12 Feb 2024 18:24:16 -0600
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Wadim Egorov
	<w.egorov@phytec.de>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2 0/9] Fix MMC properties on Sitara devices
Date: Mon, 12 Feb 2024 18:24:07 -0600
Message-ID: <20240213002416.1560357-1-jm@ti.com>
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

This patch series aims to update MMC nodes for TI 
K3 Sitara devices.

The series introduces MMC0 and MMC2 nodes and enables
eMMC for AM62ax platform.

Also introduce fixes for MMC ITAP/OTAP values for AM64x
platform according to device datasheet [0], and add ITAP/
OTAP values for AM62p to enable the highest timing possible
for MMC0 and MMC1, according to device datasheet [1].

The DLL properties ti,trm-icp and ti,driver-strength-ohm
should be removed for devices with soft PHYs since drive
strength cannot be changed, so remove these properties when
not applicable. Since this fix touches non-TI boards and
therefore cannot be tested, all tested-by's are welcome.

Also include a few fixes for ti,clkbuf-sel, bus-width,
and bootph-all device tree properties in MMC nodes.

This series was tested on:
- AM62a SK
- AM62x SK
- AM62p SK
- AM64x GP EVM
- AM64x SK EVM
- Beagleplay

[0] https://www.ti.com/lit/ds/symlink/am6442.pdf
[1] https://www.ti.com/lit/ds/symlink/am62p.pdf

Judith Mendez (7):
  arm64: dts: ti: k3-am62a-main: Add sdhci2 instance
  arm64: dts: ti: k3-am64-main: Fix ITAP/OTAP values for MMC
  arm64: dts: ti: k3-am62p: Add ITAP/OTAP values for MMC
  arm64: dts: ti: k3-am6*: Remove DLL properties for soft PHYs
  arm64: dts: ti: k3-am6*: Fix ti,clkbuf-sel property in MMC nodes
  arm64: dts: ti: k3-am6*: Fix bus-width property in MMC nodes
  arm64: dts: ti: k3-am6*: Add bootph-all property in MMC node

Nitin Yadav (2):
  arm64: dts: ti: k3-am62a-main: Add sdhci0 instance
  arm64: dts: ti: k3-am62a7-sk: Enable eMMC support

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi      | 12 +++--
 .../boot/dts/ti/k3-am62-phycore-som.dtsi      |  1 -
 .../boot/dts/ti/k3-am62-verdin-dahlia.dtsi    |  1 -
 .../arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi |  1 -
 .../boot/dts/ti/k3-am62-verdin-wifi.dtsi      |  1 -
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi    |  2 -
 .../arm64/boot/dts/ti/k3-am625-beagleplay.dts |  4 --
 .../dts/ti/k3-am625-phyboard-lyra-rdk.dts     |  1 -
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi     | 45 ++++++++++++++++++-
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts       | 27 ++++++++++-
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi     | 44 ++++++++++++++++--
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts       |  3 +-
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi |  2 -
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      | 15 +++++--
 arch/arm64/boot/dts/ti/k3-am642-evm.dts       |  4 +-
 arch/arm64/boot/dts/ti/k3-am642-sk.dts        |  2 -
 16 files changed, 129 insertions(+), 36 deletions(-)


base-commit: 1e6bbc5185bcd113c8d2f7aa0a02f588a6bdbe5d
-- 
2.43.0


