Return-Path: <linux-kernel+bounces-147680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347058A77A5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 663DA1C2139D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7385613A3E2;
	Tue, 16 Apr 2024 22:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NlywMpkv"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616DA84E0B;
	Tue, 16 Apr 2024 22:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713305829; cv=none; b=KwVphEzBVnGCx5RdzhKRL8CpEa7Qq+0igVXJdECy3NzSlRJgveL1NdLhv6qC9RzLKdUb7sP9cyasHnghGb+95i52qcs56gJsiRLsblH+yAxS1rs7x8pqO+Zf1lHIXuQb2Wx5k+sCWBPEbvFs9WZOTMX33MfE73edZSVNEC1h7ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713305829; c=relaxed/simple;
	bh=XcK0kn5qTb5pQCNKexVlFOXMEVII95wpZPigI3nC2fo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L9wUGT5nk4XNs8C1eqls8aM6gYqtw3CZ9gtMPUHvEZM694fHKPHFEhzzXaRUnLDKxtwh6YYceCz5nVxMKWoLAD3TFq3urG/JrC0QHdnpb7qSg9FaQF6dahebDLnX+AKEgOF2uUx1i4Bj4wDp605/NpAHaoUYzeuN8rYEic3v/k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NlywMpkv; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43GMGnVJ065467;
	Tue, 16 Apr 2024 17:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713305809;
	bh=cmvcOdjVa3LxB8N0mIhJb5ibHBnSoyYJbNXgqK4oqWU=;
	h=From:To:CC:Subject:Date;
	b=NlywMpkvyoezYAYo2KUmB9dumhCmWhHegMKap93smB2Ku2x1vUQ9cKBVMxHe7eo+j
	 LNs/0LjPbMZOGhqURwvjNjla5nS78eZfRxT6bSh6O1+cWKkSrslFOvvmb654Tk1tKe
	 1H7h359FXZz5Wepgm+k3hJ81deAS1bWjQ1/QUpKg=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43GMGmrq051567
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 16 Apr 2024 17:16:48 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 Apr 2024 17:16:48 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 Apr 2024 17:16:48 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43GMGmSk102285;
	Tue, 16 Apr 2024 17:16:48 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bhavya Kapoor <b-kapoor@ti.com>,
        Dasnavis
 Sabiya <sabiya.d@ti.com>
Subject: [PATCH v2 0/6] MMC updates for TI K3 platforms
Date: Tue, 16 Apr 2024 17:16:42 -0500
Message-ID: <20240416221648.3522201-1-jm@ti.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This patch series includes MMC updates for various TI K3 platforms.

It includes support for enabling UHS/SDR104 bus modes.

For AM62ax, add missing UHS support.

For AM65x, fix ITAP delay and OTAP delay and clkbuf-sel properties
in SDHCI nodes.

Lastly, change TPS6593x PMIC driver to built-in since booting SD
with UHS modes have a dependency on the driver.

Changes since v1:
- Drop patches that remove HS400 mode support
- Add patch 6/6

Link to v1:
https://lore.kernel.org/linux-devicetree/20240411225257.383889-1-jm@ti.com/

Bhavya Kapoor (1):
  arm64: dts: ti: k3-j721s2-main: Enable support for SDR104 speed mode

Dasnavis Sabiya (1):
  arm64: dts: ti: k3-j784s4-main: Enable support for UHS mode

Judith Mendez (3):
  arm64: dts: ti: k3-am65-main: Update sdhci properties
  arm64: dts: ti: k3-am65-main: Remove unused properties in sdhci nodes
  arm64: defconfig: Set CONFIG_MFD_TPS6594_I2C=y

Vignesh Raghavendra (1):
  arm64: dts: ti: k3-am62a: Enable UHS mode support for SD cards

 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi  |  2 --
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts    | 21 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi   | 26 +++++++++-------------
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi |  2 --
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi |  2 --
 arch/arm64/configs/defconfig               |  2 +-
 6 files changed, 33 insertions(+), 22 deletions(-)


base-commit: 534ad093bb80f19c20b251a89f09ce1a0e3d4f2d
-- 
2.43.2


