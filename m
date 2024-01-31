Return-Path: <linux-kernel+bounces-47239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F996844ADB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBEF91F2BB2D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF66739FF7;
	Wed, 31 Jan 2024 22:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wDwTMp9z"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7586739AE6;
	Wed, 31 Jan 2024 22:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706739608; cv=none; b=krNXN1MZM0UCYEemz67/hqy4MV1I5bI2TZqFO2FdD9wuL7zjw4TEJlceJZmPDFpwXjjVHX8vMIuMTutRhn0fFXiKyY5RlUevVl1tNDnKvFbFa/K45iLQySy7pIkyxO/g9UeWX1Faq7aFIxfQf2q1LCk5VX2xKdXjps2DAcJ45nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706739608; c=relaxed/simple;
	bh=HEiByU47X4szvoKot6Qi4UvZvWQwUxoeP2aw/yIdkGo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fEp7JKHm0+zYocBQviDJ3VNj2gTiZVMjORI3uNu2Ca+F2kYRVmNEfHR8I/zUWe7X7RtdDBPSBTtpXAIbrv21mI8qkRJ+Bmv/eHPETcB40S9gv/JcnM7IyvwSC3HiIjNVeiJcnrCjQlUhW3Q45uJItDcUUKU6YiRkFLGC/pE/OW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wDwTMp9z; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VMJxeY004316;
	Wed, 31 Jan 2024 16:19:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706739599;
	bh=oxfY+NQUBrJCOZE6uSbWk7em4uytovOm7ANLLvlhJLU=;
	h=From:To:CC:Subject:Date;
	b=wDwTMp9z16PtwTgdyWMduRQ3Rr9ypGsPlc4vQW6rgC04yJqs0J6ofVm+qxH5rlw1k
	 6qP1onbHSC8bcOYQA71ChorAohuKFFXGb2I56CmgrZnNTG18ILuOQ9vGZrXG3YO2RK
	 kV4qMm5hHjiR0RvYLHVOYvJOgDRDsp/oH9eeCnA0=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VMJxtN100443
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 16:19:59 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 16:19:59 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 16:19:59 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VMJwx2102504;
	Wed, 31 Jan 2024 16:19:58 -0600
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Vignesh
 Raghavendra <vigneshr@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 00/12] Add TI-SCI reboot driver
Date: Wed, 31 Jan 2024 16:19:45 -0600
Message-ID: <20240131221957.213717-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello all,

While PCSI normally handles reboot for K3, this is an available
fallback in case PCSI reboot fails. This driver is registered 
with low priority as we want PSCI to remain the main way these
devices are rebooted.

The important part is the binding/DT changes. Currently in
U-Boot (which use the Linux device trees) we may not have
PSCI available yet (pre TF-A) and so we need this node
to correctly reboot. Adding this node in U-Boot is one of
the last remaining deltas between the two project DT files. 

Thanks,
Andrew

Andrew Davis (12):
  dt-bindings: power: reset: Document ti,sci-reboot compatible
  dt-bindings: arm: keystone: ti-sci: Add reboot-controller child node
  power: reset: Add TI-SCI reboot driver
  arm64: dts: ti: k3-am64: Add reboot-controller node
  arm64: dts: ti: k3-am62: Add reboot-controller node
  arm64: dts: ti: k3-am62a: Add reboot-controller node
  arm64: dts: ti: k3-am62p: Add reboot-controller node
  arm64: dts: ti: k3-am65: Add reboot-controller node
  arm64: dts: ti: k3-j7200: Add reboot-controller node
  arm64: dts: ti: k3-j721e: Add reboot-controller node
  arm64: dts: ti: k3-j721s2: Add reboot-controller node
  arm64: dts: ti: k3-j784s4: Add reboot-controller node

 .../bindings/arm/keystone/ti,sci.yaml         |  8 +++
 .../bindings/power/reset/ti,sci-reboot.yaml   | 33 ++++++++++
 MAINTAINERS                                   |  2 +
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi      |  5 ++
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi     |  4 ++
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi     |  5 ++
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      |  5 ++
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi    |  4 ++
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      |  4 ++
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  4 ++
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |  4 ++
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     |  5 ++
 drivers/power/reset/Kconfig                   |  7 +++
 drivers/power/reset/Makefile                  |  1 +
 drivers/power/reset/ti-sci-reboot.c           | 63 +++++++++++++++++++
 15 files changed, 154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/ti,sci-reboot.yaml
 create mode 100644 drivers/power/reset/ti-sci-reboot.c

-- 
2.39.2


