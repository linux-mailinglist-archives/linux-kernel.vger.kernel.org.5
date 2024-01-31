Return-Path: <linux-kernel+bounces-47161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D74844A02
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE681F21CEB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F173A1C4;
	Wed, 31 Jan 2024 21:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GZm9pt2z"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E931139AD5;
	Wed, 31 Jan 2024 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706736431; cv=none; b=IyLvipW1a6wbmxfZaUWhTwXscEasTIb4AEl5f/oTILJEU4J5CSULGK4FFlQVI/63yQ0FEP7rAgjoSC8GlK0VWo8zjDhwjNIcpoBeOdOoZ26GeOa/ewExVpwKDeWGKSHo33X52ZFxZFV3p0SsLyf0sYoB+4vnUVtEN5McYH67QOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706736431; c=relaxed/simple;
	bh=Zt1G8AZNItAAIfTTJxEAMYILTLrfahkLOO1UxAxM6hE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lIJaglX/xxV0stgAiPoxelodkyhHJJyF+55MKCIQex0WD6ZQ03sUJHrHX0IBnX/QgS7L9B+fJ4pUKu8hkaSkoAyI4O0oCALollmpoL7OKDQcR/0WWRuEb2kgyKvCSqM7QMQidcgPu38mpyePigWnXmWz//Iw9kLeSXfdDzRFxK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GZm9pt2z; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VLQfb2128548;
	Wed, 31 Jan 2024 15:26:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706736401;
	bh=emvhLlu/Lf9BG1U3YSbdeyD0o8sfDbBQciiGQFlSHoU=;
	h=From:To:CC:Subject:Date;
	b=GZm9pt2z+antuuEx734zaHeR7F7O+PBAaJg3+Qp1OC3VDBunxV6DMWcyWvsBffsz6
	 MOIjziywPQHBdbJvKzBMFunahSepyXCZHjtJnDN0NTwzTU/SNr7jLRG56/VrsdcOBE
	 8BLU7eC9Dq8Bg4CdF8WbihC8b3dmLlv46sRq2/gs=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VLQfZ7020257
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 15:26:41 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 15:26:41 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 15:26:41 -0600
Received: from udba0500997.dhcp.ti.com (udba0500997.dhcp.ti.com [128.247.81.249])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VLQfKP028966;
	Wed, 31 Jan 2024 15:26:41 -0600
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
Subject: [PATCH v3 0/6] Add Support for Wave5 on TI Devices
Date: Wed, 31 Jan 2024 15:26:19 -0600
Message-ID: <20240131212625.1862775-1-b-brnich@ti.com>
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

Brandon Brnich (5):
  arm64: dts: ti: k3-j784s4: Add Wave5 Video Encoder/Decoder Node
  arm64: dts: ti: k3-am69-sk: Enable Wave5 Video Encoder/Decoder
  arm64: dts: ti: k3-am68-sk: Enable Wave5 Video Encoder/Decoder
  arm64: dts: ti: k3-am62p: Add Wave5 Video Encoder/Decoder Node
  arm64: defconfig: Enable Wave5 Video Encoder/Decoder

Darren Etheridge (1):
  arm64: dts: ti: k3-j721s2-main: Add Wave5 Video Encoder/Decoder Node

 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi     | 10 ++++++++++
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts       |  4 ++++
 .../boot/dts/ti/k3-am68-sk-base-board.dts     |  4 ++++
 arch/arm64/boot/dts/ti/k3-am69-sk.dts         |  8 ++++++++
 .../dts/ti/k3-j721s2-common-proc-board.dts    |  4 ++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 10 ++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      |  8 ++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 20 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi         |  2 ++
 arch/arm64/configs/defconfig                  |  1 +
 10 files changed, 71 insertions(+)

-- 
2.34.1


