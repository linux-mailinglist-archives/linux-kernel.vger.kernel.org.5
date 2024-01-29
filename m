Return-Path: <linux-kernel+bounces-42633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 365E384041A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E726128131E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAA76026A;
	Mon, 29 Jan 2024 11:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FXXBzZr1"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65D85EE82;
	Mon, 29 Jan 2024 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706528894; cv=none; b=WABb8oasWxsvWD8dipQj9loSsQXyOGsZeNkrj7dxFRuwW4JzxoUH1MeaxfOl8Vc4/mYEJc+89s6FJ/8a+QWhQvfujHR8yRN7T0F5T0z/1o/sh6YMyi7sVhPUMsHz1g98sqtnpvqJ/0F0jVGccbRDZiFmyxGMuSxS/pL0spRx9Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706528894; c=relaxed/simple;
	bh=UZSjcZNEWZeuncgjlGL6XIiyi13elCANBwAmNd5nwd0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vm+S1kMMJwiGi48u0xaxfhk1VKS7ePR1olJbDN7HtykoZ7n0McyZZbd1DMdutTvwLSOYC9msPDIJy8MC3uNfIqGAPY3LXBGWMKnVHdTyix/YG1LV0K4/NSm7+ZRxRmUvWf9i3AKektZhm4+iE2pCDqbLqIA2+dSbo7JO+fYiJJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FXXBzZr1; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40TBlsGn102376;
	Mon, 29 Jan 2024 05:47:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706528874;
	bh=jIPZjzqodUCMiwZz2MUWXuRmtOiuFatsm+9MP4VW5pU=;
	h=From:To:CC:Subject:Date;
	b=FXXBzZr1FnVbiGvubjgqGllGD/VLUeBFyBll8COiORz51wNCXjrtNTFq2eI0ZjzGV
	 SdLAIJonKlkRIufU+kxcajri5rk9nkd+yMMU40DfD1OjHMTeFIAfPVtJp+hRPwoXKm
	 G9nS+QKprB9WREg9mRO4Y3cEl3dyn4rnm4fTWKVE=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40TBlsFY064207
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jan 2024 05:47:54 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jan 2024 05:47:53 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jan 2024 05:47:53 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40TBloqP029678;
	Mon, 29 Jan 2024 05:47:50 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 0/3] Add PCIe DT support for TI's J784S4 SoC
Date: Mon, 29 Jan 2024 17:17:46 +0530
Message-ID: <20240129114749.1197579-1-s-vadapalli@ti.com>
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

Hello,

TI's J784S4 SoC has two Gen3 x4 Lane PCIe Controllers. This series adds
the necessary device-tree support to enable both PCIe instances in Root
Complex mode of operation by default. The device-tree overlay to enable
both instances in Endpoint mode of operation is also present in this
series.

**NOTE**
This series depends on:
1. https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240124122936.816142-1-s-vadapalli@ti.com/
   for adding the Device ID in the bindings for J784S4 SoC.

2. https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240129104958.1139787-1-s-vadapalli@ti.com/
   for enabling support for configuring the PCIe mode of operation,
   number of lanes and link speed when the System Controller node
   in the device-tree is modelled as a "simple-bus" which happens to
   be the case for J784S4 SoC:
   https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi#L45

3. https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240125100501.4137977-2-c-vankar@ti.com/
   for fixing the "serdes_ln_ctrl" node in order to ensure that the PCIe
   lanes are mapped correctly to the corresponding Serdes Lanes.

This series has been tested on top of linux-next tagged next-20240129
after applying the above dependent patches and enabling the relevant
PCIe driver configs.

Test Logs:
1. PCIe0 and PCIe1 in Root Complex Modes of operation with an NVMe SSD
connected to PCIe0 instance and Read performance measured using hdparm:
https://gist.github.com/Siddharth-Vadapalli-at-TI/6592af75ee8ba3f3bdd372a882de8b43
2. PCIe0 in Endpoint Mode on one J784S4-EVM with PCIe0 in RC Mode on
other J784S4-EVM connected to each other. Enumeration of PCIe0 as an
Endpoint is verified on the J784S4-EVM where PCIe0 is in RC Mode:
https://gist.github.com/Siddharth-Vadapalli-at-TI/cef85519669c12894352ce081ea2a8ab
3. PCIe1 in Endpoint Mode on one J784S4-EVM with PCIe1 in RC Mode on
other J784S4-EVM connected to each other. Enumeration of PCIe1 as an
Endpoint is verified on the J784S4-EVM where PCIe1 is in RC Mode:
https://gist.github.com/Siddharth-Vadapalli-at-TI/646d51757cffd651b51bac33d138a8ac

Regards,
Siddharth.

Siddharth Vadapalli (3):
  arm64: dts: ti: k3-j784s4-main: Add PCIe nodes
  arm64: dts: ti: k3-j784s4-evm: Enable PCIe0 and PCIe1 in RC Mode
  arm64: dts: ti: k3-j784s4-evm: Add overlay for PCIE0 and PCIE1 EP Mode

 arch/arm64/boot/dts/ti/Makefile               |  7 +-
 .../dts/ti/k3-j784s4-evm-pcie0-pcie1-ep.dtso  | 79 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      | 46 ++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 84 +++++++++++++++++++
 4 files changed, 215 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm-pcie0-pcie1-ep.dtso

-- 
2.34.1


