Return-Path: <linux-kernel+bounces-73577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD2C85C46F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8FBA281C66
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB94134CEF;
	Tue, 20 Feb 2024 19:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zGgQflBk"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B8A76C9C;
	Tue, 20 Feb 2024 19:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456490; cv=none; b=JM14Xa2rqVESkYOCVJnAUGDOmtClV8fnVewZHElG+F5NPjBH+QkHDiCluM8oOE1eH+SVoOU0y5YkHwuJHkP0ygsvORMdX3MVCQSusGeqyP9SLSUUFsy8IrxqTYkqsT7fv4aSjhWHwdmc3Zkvd7HKFey18hJVT34SLVEQVudkYy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456490; c=relaxed/simple;
	bh=+4Wi//AXlr7TWKT21ayN/iDlBqiMB79qVAUTF+4TgX0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZWFdyD5ap5lKyZgj9TZH/1MlaQkkDUiYwuUT3A/Pyn6zvp6aS3k0gYQpjmCxsBLB5AwKOv3OJSGhIc1bRSEeXuyzLydaDusFiTcuqMHk+1cLoWWAxR6R0JlocIeFZbHUuodm0Fz3YnzZcPN6perJ+9nRdK9lNlGFOxo5hegQ/fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=zGgQflBk; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41KJEKWm059295;
	Tue, 20 Feb 2024 13:14:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708456460;
	bh=Ju6D8qwe0btWZ8SqLU34cJuOdj9z/fwKarHqN2ID9Iw=;
	h=From:To:CC:Subject:Date;
	b=zGgQflBkHo9JqNDaJe6c65j6qonOFk+5yMJp4fI6slSUh0mhpivJuxYk8lg4LM1a7
	 FMZj6OJ51GIA6GFFiWCcec05btRt4pW+DuAdUBEleRbOo8Fk6z9gpbxoj2e6v6ny2a
	 GUduNpftU2R6U8Ml3URLCvR2DETjytI0McWEh2og=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41KJEKOs038953
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Feb 2024 13:14:20 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Feb 2024 13:14:20 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Feb 2024 13:14:20 -0600
Received: from udba0500997.dhcp.ti.com (udba0500997.dhcp.ti.com [128.247.81.249])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41KJEKoN051513;
	Tue, 20 Feb 2024 13:14:20 -0600
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
CC: Andrew Davis <afd@ti.com>, Brandon Brnich <b-brnich@ti.com>
Subject: [PATCH v5 0/4] Add Support for Wave5 on TI Devices
Date: Tue, 20 Feb 2024 13:14:09 -0600
Message-ID: <20240220191413.3355007-1-b-brnich@ti.com>
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

Changes since v4:
=================
* Remove clock-names from device tree nodes per Vignesh's request
  - "vcodec" clock-name is defined as macro in driver, but unused
  - no purpose to have it in dt node

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

 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi  |  8 ++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi |  8 ++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 16 ++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi      |  2 ++
 arch/arm64/configs/defconfig               |  1 +
 5 files changed, 35 insertions(+)

-- 
2.34.1


