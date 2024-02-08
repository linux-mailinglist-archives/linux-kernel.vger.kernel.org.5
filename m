Return-Path: <linux-kernel+bounces-58054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 757C484E0AD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A52F1C23A40
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1401D7602B;
	Thu,  8 Feb 2024 12:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qLZEF3v7"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D45149E05;
	Thu,  8 Feb 2024 12:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707395571; cv=none; b=tRblceXpdiM+7+IRP7sagUdyupiHT978QaqviWk/ltZS7GwKhquHti/o5+QmX+6710qoY/7PyidlZMwY9Ib1wz7Z0jhDLMrhzAY6xsYVS51E493XTJnPg44l9GdmxitKC6pYoO8v798siCmuCOw3KUBXSuZ6I2vjFiiRGpp0lK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707395571; c=relaxed/simple;
	bh=aWVpefee/1r20J7/8H0Fz/fGvX0vdb7r9OXomDahz+w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lYG/AciGukg65Y0jkp+myojVhGitN+LEVCYvBUac833xJVbqoqtrwLszbXDXqwZR0etQAFLvz8HH7DFGZsjbq+YyYGHLEPxaVYyHoHXFjK7MrZZ6KEweGIMfbs+N+FHV9fyROGquTKbUA1fUQk+KqwgYCRvAUZfDHKQo0pv/YcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qLZEF3v7; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418CWdQK070425;
	Thu, 8 Feb 2024 06:32:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707395559;
	bh=e2FdLdDm/0fXJ+iu8rC2fY0deofpvai+SrPKPtsmH+g=;
	h=From:To:CC:Subject:Date;
	b=qLZEF3v77cI0f4MI+h4aF3Bs2ZYQK5GL7llQx5ahp6GlCjqLnIKibhMrJgL+kyS5E
	 Euig9vPrrYVm1M1Xy9aZkNbFJLiKEE0jOf8JFE/O2nzAev2Q5l68to8KM+hY8QcaOM
	 PmMzLjPMzOdqNYv0l6JvLryhXupgYnOTn6Zl6oBY=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418CWdcw005900
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 06:32:39 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 06:32:38 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 06:32:39 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418CWY1H074789;
	Thu, 8 Feb 2024 06:32:34 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vaishnav.a@ti.com>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
        <j-luthra@ti.com>, <afd@ti.com>
Subject: [PATCH v3 0/9] Add CSI2RX capture support on TI J7 platforms
Date: Thu, 8 Feb 2024 18:02:24 +0530
Message-ID: <20240208123233.391115-1-vaishnav.a@ti.com>
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

Hi,

This series adds support for CSI2RX capture support on J7 platforms,
series was tested for CSI2RX capture on OV5640 sensor and RPI camera
v2 IMX219 sensor on J721e Common Processor Board, J721E Starter kit,
J721S2 Common Processor Board, AM68 Starter Kit, J784s4 EVM and AM69
Starter kit.

V1: https://lore.kernel.org/all/20240129132742.1189783-1-vaishnav.a@ti.com/
V2: https://lore.kernel.org/all/20240208084254.295289-1-vaishnav.a@ti.com/

Changelog:
V2->V3:
  * Fix order of properties in patch 6/7/8 as per dts coding style.
V1->V2:
  * Address feedback from Jai and Andrew
    * Rename overlays to indicate first platform supported/dual camera.
    * Add missed build test.
    * Add board schematics for all commit messages.

Test logs:
J721E EVM OV5640 - https://gist.github.com/vaishnavachath/b08521386cfbe1939facf39b8b2d796b
J721S2 EVM OV5640 - https://gist.github.com/vaishnavachath/1b0d60da6b6464cf12334cd5e161a79b
J784s4 EVM OV5640 - https://gist.github.com/vaishnavachath/02b70df94d2d41662eff99f4ce966d67
TDA4VM SK IMX219 - https://gist.github.com/vaishnavachath/64fc6edd6cc060027812bebd6573df07
AM68 SK IMX219 - https://gist.github.com/vaishnavachath/d522254ff5e797bc853e0706fbea932a
AM69 SK IMX219 - https://gist.github.com/vaishnavachath/8dbd960cc89d691886df371c53aac399

Only a single set of overlays for dual RPI IMX219 is included in the series
for reference and other overlays to test OV5640 can be found here:
https://gist.github.com/vaishnavachath/d0a052106892fe9f3096733931e9ad5f

Vaishnav Achath (9):
  arm64: dts: ti: k3-j721s2-common-proc-board: Enable camera peripherals
  arm64: dts: ti: k3-j784s4-evm: Enable camera peripherals
  arm64: dts: ti: k3-am68-sk-base-board: Enable camera peripherals
  arm64: dts: ti: k3-am69-sk: Enable camera peripherals
  arm64: dts: ti: k3-j721e-sk: Model CSI2RX connector mux
  arm64: dts: ti: k3-j721e-main: Add CSI2RX capture nodes
  arm64: dts: ti: k3-j721s2-main: Add CSI2RX capture nodes
  arm64: dts: ti: k3-j784s4-main: Add CSI2RX capture nodes
  arm64: dts: ti: k3-j721e-sk: Add overlay for IMX219

 arch/arm64/boot/dts/ti/Makefile               |  13 ++
 .../boot/dts/ti/k3-am68-sk-base-board.dts     |  50 +++++
 arch/arm64/boot/dts/ti/k3-am69-sk.dts         |  51 +++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 122 ++++++++++++
 .../dts/ti/k3-j721e-sk-csi2-dual-imx219.dtso  | 125 ++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts        |  19 +-
 .../dts/ti/k3-j721s2-common-proc-board.dts    |  25 +++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 123 +++++++++++-
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      |  25 +++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 183 +++++++++++++++++-
 10 files changed, 732 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-sk-csi2-dual-imx219.dtso

-- 
2.34.1


