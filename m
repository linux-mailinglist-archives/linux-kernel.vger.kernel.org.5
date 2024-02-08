Return-Path: <linux-kernel+bounces-57638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5421F84DBB1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F16A282C00
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551FA6D1DB;
	Thu,  8 Feb 2024 08:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PWy9Sskn"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F966D1D5;
	Thu,  8 Feb 2024 08:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381823; cv=none; b=KzkGZFZOv1UovYXWV9MzmPTDcg/BrI60cAjsW2ez/nDGVZFjVgdCPSgOQ3jYZ1Uff9u/DYJ7wd/mEeqR3itiKZgq2/u9uzAIFlX9sGnX9vDgw2SnwiLpVY3kWGhFOlIaRv7iFy+r4Rp0lFGF84U73ldmi/1JjbLGSphanWOL5IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381823; c=relaxed/simple;
	bh=8s7ZxTSAZfFlUjVevVr5GlBMhhbf9FWGLCY6IhPmMRk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MUkFVIN1J9ezhhPtCiSIO5/yDm/5syrlbfZf9OdX4xNtXngV+J7CeGd8FLw47M3pfAaVZEUy+RUJBaZuz7M20NinKv3iknGrWBevGBE2dfjo/upNHFeNSgeadyROJctmj74yb5sk8H7rqwx2euIKXRqIdv50tMSaZ6r3cN8RKXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PWy9Sskn; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4188gxLR020533;
	Thu, 8 Feb 2024 02:42:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707381779;
	bh=bt9J9P45uqT1NCvMcT/q9UULJ79smq3qVFxypoKNWYQ=;
	h=From:To:CC:Subject:Date;
	b=PWy9SsknXd/HRusueX4+53L0/zSwDzxT0z0kuO9uwS1vm6I/GhADKh3dAkVMkI7VL
	 QjsoUL64HSvzeJc4wp7VBAAsk7Q2D6ThjUq/wC4M7Ma4PZ2nXruBOgkwBafkkMCrez
	 yn8Te9ZHDE5WZxBMiXIKyNgifwQwiKFnuoIY802c=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4188gxtH018007
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 02:42:59 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 02:42:59 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 02:42:59 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4188gshK097884;
	Thu, 8 Feb 2024 02:42:55 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <vigneshr@ti.com>, <nm@ti.com>, <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>
CC: <j-luthra@ti.com>, <devicetree@vger.kernel.org>, <j-choudhary@ti.com>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <vaishnav.a@ti.com>,
        <afd@ti.com>
Subject: [PATCH v2 0/9] Add CSI2RX capture support on TI J7 platforms
Date: Thu, 8 Feb 2024 14:12:45 +0530
Message-ID: <20240208084254.295289-1-vaishnav.a@ti.com>
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

Changelog:

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


