Return-Path: <linux-kernel+bounces-66479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E323C855D48
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E40061C21AA4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5DF171B0;
	Thu, 15 Feb 2024 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="o87EUIFF"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F330D1C6A0;
	Thu, 15 Feb 2024 08:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707987574; cv=none; b=eqYdNj09PFAd+7zFevtNJJaA7n2vOsTC9QAkkC1j3jDuTaTtqKY1sYUTWL3xcA1PTdN7Id7hwnOZiFvLiLpvPFZ9VjpyaDcQkU835NW/vlqZq7/qmZ2icVualeWa/hHcypv9Qz3bdT3yAHQu33eGqQMBKhCwNiS8AmQ4+tc/9AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707987574; c=relaxed/simple;
	bh=OecqNcscZJ13PH840r95jogObDqAALk8/vWY1iDigqo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jWz8aGy31xhMKZ5iMfUPfb6PwWClvsfQ/Sk5kbPZmlnE9cFWMEpYGmbCgOYKoOtXzQGyjbidwUAUQmetsmeaSz/QH/zk96eJFsUWJV3hsLmeBxOmpaReSkCU4XQAvnsCMCcJWbjeNBa3R/0JkC4STNJ63XsdOb80rxFv2ulbf68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=o87EUIFF; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41F8tOla046504;
	Thu, 15 Feb 2024 02:55:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707987324;
	bh=GzoAjTL40y+5uHYK1NwcGcZJ3oE8njc2MXrOuA9vRSU=;
	h=From:To:CC:Subject:Date;
	b=o87EUIFFcS530DcQHNxRLaKSNOpc77gesm8dhxwRe7jfIZ9g8x6nm+pXym5XS+S88
	 NFV68VNySHNUzFWc+Qo1W8lPLGEt3oJifER2PlKB2x9MASfobPGABWa0fZQuNKDSdL
	 i1A18q/82/9MK45EvhQ+wXM6hQxR2UeCzUuXptbM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41F8tOAc069295
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 02:55:24 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 02:55:23 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 02:55:23 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41F8tJ7j008333;
	Thu, 15 Feb 2024 02:55:19 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <vigneshr@ti.com>, <nm@ti.com>, <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>
CC: <j-luthra@ti.com>, <devicetree@vger.kernel.org>, <j-choudhary@ti.com>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <vaishnav.a@ti.com>,
        <afd@ti.com>
Subject: [PATCH v4 0/9] Add CSI2RX capture support on TI J7 platforms
Date: Thu, 15 Feb 2024 14:25:09 +0530
Message-ID: <20240215085518.552692-1-vaishnav.a@ti.com>
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
V3: https://lore.kernel.org/all/20240208123233.391115-1-vaishnav.a@ti.com/

Changelog:
V3->V4:
  * Add additional port information in overlays to fix DTC warning:
	Warning (graph_child_address): graph node has single child node,
	#address-cells/#size-cells are not necessary  
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
 .../dts/ti/k3-j721e-sk-csi2-dual-imx219.dtso  | 165 ++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts        |  19 +-
 .../dts/ti/k3-j721s2-common-proc-board.dts    |  25 +++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 123 +++++++++++-
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      |  25 +++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 183 +++++++++++++++++-
 10 files changed, 772 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-sk-csi2-dual-imx219.dtso

-- 
2.34.1


