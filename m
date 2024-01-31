Return-Path: <linux-kernel+bounces-45535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FA7843223
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972FA1F267A3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E902134F;
	Wed, 31 Jan 2024 00:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hzWh4m4l"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED001C27;
	Wed, 31 Jan 2024 00:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706661447; cv=none; b=C0mRNSxNrm1BU6N/35cBW83DPGteMvH78YbCUarCJtiTNm51ucxqpD97bFDSKBsqOSz+GBYNW8dv2iFULCsbkC8ilbMd6m3PF9djHNmBFIPM1PEWmMeR/WTfrE50wqZRytqJkHAsuEqonV22z/3A4njI2Zm15rHqOlpxR8+zvOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706661447; c=relaxed/simple;
	bh=R1xFZYlZq5iDmiqO1hgP/SCPOxGVh8mZ3jaCmVuJr1M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VVmJ1YugZYnhzE5VnZCjQ2+mP+q2KTq4nXulM5baQxVM+/Fw5REGZXI7V8bEAQBeA++hLYTdtTuBZGitNX9hmKBnBYGakMrNNglosj6qP0t06OykQti/qIf6jenvhc4L6fbleGPVGELxISFj6nL6uMxu26fH9soDFejMFZlxD8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hzWh4m4l; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40V0bF3o121322;
	Tue, 30 Jan 2024 18:37:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706661435;
	bh=xtnSmZCipnrpT8/DHBFeXQG5H33NY0uj3pHdnmk5/gk=;
	h=From:To:CC:Subject:Date;
	b=hzWh4m4lLeIjrj7ap7nsEu1Rw7cKCFvmpXuypgLFIJXdz61NYwgPPYqm8ZWWSnkX0
	 3/FPHknYdmIcdwpcIk2/IOu7Ri5vB+svgdP4kaDXfkUSthSk3bZU/NHIUFQAZiAG/1
	 yq/UFuU4YcREEIJfDFLX1Gyn1qJh/DWamCXz5k7w=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40V0bFTd045565
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jan 2024 18:37:15 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 18:37:15 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 18:37:14 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40V0bEw7026520;
	Tue, 30 Jan 2024 18:37:14 -0600
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
        Udit Kumar
	<u-kumar1@ti.com>, Roger Quadros <rogerq@kernel.org>,
        <devicetree@vger.kernel.org>, Randolph Sapp <rs@ti.com>
Subject: [RFC PATCH 00/13] Add tuning algorithm for delay chain
Date: Tue, 30 Jan 2024 18:37:01 -0600
Message-ID: <20240131003714.2779593-1-jm@ti.com>
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

This patch series introduces a new tuning algorithm for
mmc. The new algorithm should be used when delay chain is
enabled. The ITAPDLY is selected from the largest passing
window and the buffer is not viewed as a circular buffer.
The new tuning algorithm is implemented as per the paper
published here [0] and has been tested on the following
platforms: AM62x SK, AM62A SK, AM62p SK, AM64x SK, and AM64x
EVM.

The series also includes a few fixes in the sdhci_am654
driver on OTAPDLYEN/ITAPDLYEN and ITAPDELSEL. There are
also device tree node fixes for missing mmc nodes,
modifying DLL properties, and fixes for OTAP/ITAP delay
values. 

MMC0/MMC2 nodes are introduced for AM62ax in this series.

This series is sent as a RFC mostly to get some feedback
and/or comments on the new tuning algorithm implementation.

[0] https://www.ti.com/lit/an/spract9/spract9.pdf

Judith Mendez (11):
  drivers: mmc: host: sdhci_am654: Add tuning algorithm for delay chain
  drivers: mmc: host: sdhci_am654: Write ITAPDLY for DDR52 timing
  drivers: mmc: host: sdhci_am654: Add missing OTAP/ITAP enable
  drivers: mmc: host: sdhci_am654: Add ITAPDLYSEL in
    sdhci_j721e_4bit_set_clock
  drivers: mmc: host: sdhci_am654: Fix ITAPDLY for HS400 timing
  arm64: dts: ti: k3-am62a-main: Add sdhci2 instance
  arm64: dts: ti: k3-am64-main: Update ITAP/OTAP values for MMC
  arm64: dts: ti: k3-am62-main: Update ITAP/OTAP values for MMC
  arm64: dts: ti: k3-am62p: Add missing properties for MMC
  arm64: dts: ti: k3-am6*: Remove DLL properties for soft phys
  arm64: dts: ti: k3-am6*: Reorganize MMC properties

Nitin Yadav (2):
  arm64: dts: ti: k3-am62a-main: Add sdhci0 instance
  arm64: dts: ti: k3-am62a7-sk: Enable eMMC support

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi      |  57 +++--
 .../arm64/boot/dts/ti/k3-am625-beagleplay.dts |   5 -
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi     |  45 +++-
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts       |  27 ++-
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi     |  44 +++-
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts       |   7 +-
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi |   4 +-
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      |  17 +-
 arch/arm64/boot/dts/ti/k3-am642-evm.dts       |   4 +-
 arch/arm64/boot/dts/ti/k3-am642-sk.dts        |   2 -
 drivers/mmc/host/sdhci_am654.c                | 215 ++++++++++++++----
 11 files changed, 321 insertions(+), 106 deletions(-)

-- 
2.34.1


