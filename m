Return-Path: <linux-kernel+bounces-42796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C508406E1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D8A289636
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3E564AB3;
	Mon, 29 Jan 2024 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kfGoxO9n"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC351634F1;
	Mon, 29 Jan 2024 13:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534882; cv=none; b=qgF+1hYekuCNPnXBR0GNGDlh000BdILD3WRgnbCS6IYJDtZMMZnpVLijWo6mWE9fJr9F+AuDQ8KqEUasT4kty0sRYyfccocQjggBvY9kMA23aS6+NPPt27Q9usj4jFGCfbh6RRLSDDanKeWyUsJ7SG82kF4Nahn8Qqyde/SBao8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534882; c=relaxed/simple;
	bh=rH3jXrntgM4YgWwATO4Gfv0xLewU3oOUC/m/QCARXuY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tZsaQvsf5+xkP5QbzLIIbQbKi15Gascqop7MD1QmkKnfxonjaagyv8UHlud2PHhtvdmL93DFagu43u9GgxF0vEkxBehz6qE+Gjrd3yheYSopxzSdj/TT63Vj1iM+L8j05Cn+byWc0asyxvm1+bjsAAA3zOCSGublT1SyM4iq9sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kfGoxO9n; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40TDRlCZ128826;
	Mon, 29 Jan 2024 07:27:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706534867;
	bh=HHazHNXhAm369Ngz+UjtwH3k5gdSdpNy3fLyx9BR4iQ=;
	h=From:To:CC:Subject:Date;
	b=kfGoxO9nZL75Kc6EIUsmrU+peluWj5MJrHKoqZ8DZd9gEXE6sKM/TCzbl9hLyVAdQ
	 NxWYBRWVUaZ2T2moIJhGmJJsz2S9G0zUnyz/GXKrXuHg5ScIQkIG+biAD7Q1El+dJ8
	 K/VWl5OsvTaDctQ6R5p31SAWYTdl0D9EbHlqILd4=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40TDRlTO026784
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jan 2024 07:27:47 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jan 2024 07:27:47 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jan 2024 07:27:47 -0600
Received: from uda0490681.dhcp.ti.com ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40TDRg9A036720;
	Mon, 29 Jan 2024 07:27:43 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vaishnav.a@ti.com>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
        <j-luthra@ti.com>
Subject: [PATCH 0/9] Add CSI2RX capture support on TI J7 platforms
Date: Mon, 29 Jan 2024 18:57:33 +0530
Message-ID: <20240129132742.1189783-1-vaishnav.a@ti.com>
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

Test logs:
J721E EVM OV5640 - https://gist.github.com/vaishnavachath/b08521386cfbe1939facf39b8b2d796b
J721S2 EVM OV5640 - https://gist.github.com/vaishnavachath/1b0d60da6b6464cf12334cd5e161a79b
J784s4 EVM OV5640 - https://gist.github.com/vaishnavachath/02b70df94d2d41662eff99f4ce966d67
TDA4VM SK IMX219 - https://gist.github.com/vaishnavachath/64fc6edd6cc060027812bebd6573df07
AM68 SK IMX219 - https://gist.github.com/vaishnavachath/d522254ff5e797bc853e0706fbea932a
AM69 SK IMX219 - https://gist.github.com/vaishnavachath/8dbd960cc89d691886df371c53aac399

Only a single set of overlays for RPI IMX219 is included in the series
for reference and other overlays to test OV5640 can be found here:
https://gist.github.com/vaishnavachath/d0a052106892fe9f3096733931e9ad5f

Patch 7/9 depends on : 
https://lore.kernel.org/all/20240125111449.855876-1-vaishnav.a@ti.com/

Thanks and Regards,
Vaishnav

Vaishnav Achath (9):
  arm64: dts: ti: k3-j721s2-common-proc-board: Enable camera peripherals
  arm64: dts: ti: k3-j784s4-evm: Enable camera peripherals
  arm64: dts: ti: k3-am68-sk-base-board: Enable camera peripherals
  arm64: dts: ti: k3-am69-sk: Enable camera peripherals
  arm64: dts: ti: k3-j721e-sk: Model CSI2RX connector mux
  arm64: dts: ti: k3-j721e-main: Add CSI2RX capture nodes
  arm64: dts: ti: k3-j721s2-main: Add CSI2RX capture nodes
  arm64: dts: ti: k3-j784s4-main: Add CSI2RX capture nodes
  arm64: dts: ti: k3-am69-sk: Add overlay for IMX219

 arch/arm64/boot/dts/ti/Makefile               |   6 +
 .../boot/dts/ti/k3-am68-sk-base-board.dts     |  50 +++++
 .../boot/dts/ti/k3-am69-sk-csi2-imx219.dtso   | 124 ++++++++++++
 arch/arm64/boot/dts/ti/k3-am69-sk.dts         |  51 +++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 122 ++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts        |  19 +-
 .../dts/ti/k3-j721s2-common-proc-board.dts    |  25 +++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 123 +++++++++++-
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      |  25 +++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 183 +++++++++++++++++-
 10 files changed, 724 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am69-sk-csi2-imx219.dtso

-- 
2.34.1


