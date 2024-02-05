Return-Path: <linux-kernel+bounces-53864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 518DE84A768
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE71AB24908
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599A48002B;
	Mon,  5 Feb 2024 19:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NkTKs6Hu"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B9C7FBC5;
	Mon,  5 Feb 2024 19:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162454; cv=none; b=LcE4ZFRywpu5pAV4TAZtqcszXN3dYY+IkCaTZbxNRG4RseWwZhtIY3lcqH8tJ/h29HIjgM+K62TeJ9VD2U0KZrmSuO6hFGkmjbvmOSLOD4NGTrS/d0Ip67mlH54+AMOgwpJ1Ffs6wdlMX6nFl0rRonuY6VefkjYkNcUWqgix/P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162454; c=relaxed/simple;
	bh=NP+owyuLHzyC3xmqvEx7MB7++GTByIiCpxocTPBctd8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TRixVPI9xWehon6mCzp3eluUJvWx/i2fp8T7/jGR4HxTWgzr93RZEREgsOWBW1zktjQx4OmVCIG4o55ADP1jxYwnjVLQ6Vd2PwaKMkvv46LpV2iFsbULqZUIpxhGbjIJOZxKswidvv7Qb8YqbA5xqx4ogROpKHahisGJiZWHN5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NkTKs6Hu; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415Jl9Kv011562;
	Mon, 5 Feb 2024 13:47:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707162429;
	bh=HXYHUPZ6O3GFQ/Kio13SHUHCJDVXL/YXTT3/Zo8b22M=;
	h=From:To:CC:Subject:Date;
	b=NkTKs6Hup7dQ1ML+X4a6B5Aq/5bMCZg8BWJsZ/lfFsm3VhOCuBdHZOPT9NSx2ZM4W
	 ktsuEJXGstayS55B/0jyAcoAtvAVKFslvyG4ruP0vM4B14Vc0H/00qZyzoKGjMOT0T
	 O+iukyvu3P4nLt+So4HGv8Hu0K7U2k/wyl6T00OY=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415Jl9tb005942
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 13:47:09 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 13:47:09 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 13:47:08 -0600
Received: from udba0500997.dhcp.ti.com (udba0500997.dhcp.ti.com [128.247.81.249])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415Jl90X037073;
	Mon, 5 Feb 2024 13:47:09 -0600
From: Brandon Brnich <b-brnich@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon
	<will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Geert
 Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Konrad
 Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?=
	<nfraprado@collabora.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Darren Etheridge <detheridge@ti.com>
CC: Brandon Brnich <b-brnich@ti.com>
Subject: [PATCH v4 0/4] Add Support for Wave5 on TI Devices
Date: Mon, 5 Feb 2024 13:47:02 -0600
Message-ID: <20240205194706.3605309-1-b-brnich@ti.com>
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

This series is responsible for adding support for Wave5 driver[0]
across numerous TI K3 platforms.

[0]: https://lore.kernel.org/all/ae6d2ad3-0b2a-462a-a9eb-9ce01e7a7f5e@xs4all.nl/

Changes since v3:
=================

* Address Andrew's comments
  - remove disabled by default on all platforms
  - reorder addresses in 84s4 to be correctly sorted

Changes since v2:
=================

* Remove reference to k3 as requested
* Rebase on v6.8-rc2 where new bindings are present
* Remove am62a dts entry until hrtimer[1] patch gets merged

[1]: https://patchwork.kernel.org/project/linux-media/patch/20240125130833.1953617-1-devarsht@ti.com/

Changes since v1:
=================

* Remove sram parameters
  - sram-size property not included in bindings. Without this, size
  will default to 0 so no point in specifying until binding is added.
* Remove global CMA pools for each platform
  - This is something that has been added in TI backport of driver
  and does not yet have reliable support in upstream version.
  - Removing for now with intention to add back once 48-bit
  addressing is supported in upstream Wave5 driver.

Brandon Brnich (3):
  arm64: dts: ti: k3-j784s4: Add Wave5 Video Encoder/Decoder Node
  arm64: dts: ti: k3-am62p: Add Wave5 Video Encoder/Decoder Node
  arm64: defconfig: Enable Wave5 Video Encoder/Decoder

Darren Etheridge (1):
  arm64: dts: ti: k3-j721s2-main: Add Wave5 Video Encoder/Decoder Node

 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi  |  9 +++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi |  9 +++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 18 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi      |  2 ++
 arch/arm64/configs/defconfig               |  1 +
 5 files changed, 39 insertions(+)

-- 
2.34.1


