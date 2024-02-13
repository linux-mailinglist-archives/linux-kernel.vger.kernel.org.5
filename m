Return-Path: <linux-kernel+bounces-64581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35FD854086
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99A5285CE1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D3B63506;
	Tue, 13 Feb 2024 23:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Zi9hkaCg"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306E865BD5;
	Tue, 13 Feb 2024 23:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707868664; cv=none; b=A5sVvUCRTyio3MoWnoUxS6LuGb3TV4ek4pOFS+RgrZSIYZe6a5Cbbs3MNYQlqZnIWUkQlLzsTEwkRXubjOGsJn54Hr1wbfDuxmkwdplyqXHvLj8NAELP/V/ch0FVZLJyvmOsGCn1BPVWih/eT/849LMDdjwZE8RxJQU0irdvcqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707868664; c=relaxed/simple;
	bh=piAU5tC1h1y3vvrNsOA2aQ3BtK64uKqiYYvZ0WADs+Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i7Z3SJJUk3t0P5E1Pn7LYIXCFfqf74OiUZyFPjdaCBdEgyTutXZA/+N4i578sH8AasM2UsB0i5Us39H9v10d+DIGKbrtoKwxzt20IYF3kGWd6Vu3b3J1nsWKgrhnFwYqiv0HodkeESkS+/1chckLBfxWae1YwzTfeP1YRi27O0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Zi9hkaCg; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41DNv1X7010135;
	Tue, 13 Feb 2024 17:57:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707868621;
	bh=3S3Qh1mo0rfRIPDFHYJT0K7IV8QikFSO5XW0LQrfkrc=;
	h=From:To:CC:Subject:Date;
	b=Zi9hkaCg+wq7kfGHtJEQSHBkhTFsyZfpwlvkxXs7D9ybRicm3kq25S/HzUUgbugpw
	 CWZdUS25bsLcbc+diuJKKVFF1eMfngxpFwENdDTlpw8E1SrLVYM6W6EwcJyrSvvy8Y
	 WTXmUOh+tevj4uXv3sj4r/thVsaWC9zf/gnjO8jE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41DNv1Z2006441
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Feb 2024 17:57:01 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Feb 2024 17:57:01 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Feb 2024 17:57:01 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41DNv1R4091761;
	Tue, 13 Feb 2024 17:57:01 -0600
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
Subject: [PATCH v3 0/9] Fix MMC properties on Sitara K3 devices
Date: Tue, 13 Feb 2024 17:56:52 -0600
Message-ID: <20240213235701.2438513-1-jm@ti.com>
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

This patch series aims to fix and update MMC nodes for TI
Sitara K3 devices with the following changes.

The series introduces sdhci0 and sdhci2 nodes and enables
eMMC for AM62ax platform.

Also introduce fixes for MMC ITAP/OTAP values for AM64x
platform according to device datasheet [0], and add ITAP/
OTAP values for AM62p to enable the highest timing possible
for MMC0 and MMC1, according to device datasheet [1].

The DLL properties ti,trm-icp and ti,driver-strength-ohm
should be removed for soft PHYs since drive strength cannot
be changed, so remove these properties when not applicable.
Since this fix touches non-TI boards and therefore cannot be
tested, all tested-by's are welcome.

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

Fixes since V2:
- Remove ti,driver-strength-ohm property in sdhci1 node for
 k3-am642-tqma64xxl-mbax4xxl and k3-am642-phyboard-electra-rdk board files.
- Add Francesco's Acked-by

V2: https://lore.kernel.org/linux-devicetree/20240213002416.1560357-1-jm@ti.com/
V1: https://lore.kernel.org/linux-devicetree/22af7436-8833-4049-bdbb-f79bb3314ee8@ti.com/
RFC: https://lore.kernel.org/linux-devicetree/c94b7399-31c0-4e7d-a616-8f29c86a27ba@ti.com/

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
 .../dts/ti/k3-am642-phyboard-electra-rdk.dts  |  1 -
 arch/arm64/boot/dts/ti/k3-am642-sk.dts        |  2 -
 .../dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts    |  1 -
 18 files changed, 129 insertions(+), 38 deletions(-)


base-commit: 1e6bbc5185bcd113c8d2f7aa0a02f588a6bdbe5d
-- 
2.43.0


