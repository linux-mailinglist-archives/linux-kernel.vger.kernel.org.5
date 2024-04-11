Return-Path: <linux-kernel+bounces-141682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB188A21F6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B9B287D49
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84B946B80;
	Thu, 11 Apr 2024 22:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ra/PrU+U"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4B74D108;
	Thu, 11 Apr 2024 22:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712875999; cv=none; b=HQseqnDokeX8+7lSV07g1f/IQ3KmB7tTIKCaB7qPKMg9a9XbFu8tR8hgHJMdhBnZmLcru+ihKzLxWoAdw52UX+3urWmM23MzH84WdFW2rp/DMHrTBdaMKBh9kXrxpGMNwHDuP/NYxPln/dfHXhd5ZD7wqmVuKQONC4kcg32jDPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712875999; c=relaxed/simple;
	bh=UNHv6+Y7DsoY0XQE53JoSzkJ3ZOGe3lZ3+BPvFel6go=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gycNYJPZ5JZC1UIV5coJdioPjY17uKX1n7+NJiHn5PHuQI9cfT4dy6RT4M0hhMDZEKW2DgkUAQWTLUv0XZVRM2XSg4Rk/r9ad9YZJKsCSZVCVaDteBn/DVuzCPNgm7/roXpewyLSqQ/DcSzchZd+6bbN6jC5SQN7H2GyK6jz+QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ra/PrU+U; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43BMqvtR115878;
	Thu, 11 Apr 2024 17:52:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712875977;
	bh=k/6Ejm6t8n3tA2KqC9S8sogmmyxBPS/9Pwp4x5SZSZE=;
	h=From:To:CC:Subject:Date;
	b=Ra/PrU+UlM68uSfsGekt5dOg6ilRkOnFUslCQE81BUf5VmXYtXkmyWpDjwigmA9Rw
	 XHAgAdbkla5o3hF5vXyXb38k6lXio/h7ywegX2I7wZn7Zva6b355qoHqmU1y/8JzkL
	 NsCr9VdbZIh8u/1SUMpyF8aHwZEAcq3qLxmnUka8=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43BMqv0f015552
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Apr 2024 17:52:57 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 Apr 2024 17:52:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 11 Apr 2024 17:52:57 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43BMqv7W002381;
	Thu, 11 Apr 2024 17:52:57 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bhavya Kapoor <b-kapoor@ti.com>,
        Dasnavis
 Sabiya <sabiya.d@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH 0/7] MMC updates for TI K3 platforms
Date: Thu, 11 Apr 2024 17:52:50 -0500
Message-ID: <20240411225257.383889-1-jm@ti.com>
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

It includes support for enabling UHS/SDR104 bus modes or removing
HS400 support due to CQE errors seen during boot.

For AM62ax, add missing UHS support.

For AM65x, fix ITAP delay and OTAP delay and clkbuf-sel properties
in SDHCI nodes.

Bhavya Kapoor (1):
  arm64: dts: ti: k3-j721s2-main: Enable support for SDR104 speed mode

Dasnavis Sabiya (2):
  arm64: dts: ti: k3-j784s4-main: Enable support for UHS mode
  arm64: dts: ti: k3-am69-sk: Remove HS400 mode support for eMMC

Judith Mendez (2):
  arm64: dts: ti: k3-am65-main: Update sdhci properties
  arm64: dts: ti: k3-am65-main: Remove unused properties in sdhci nodes

Udit Kumar (1):
  arm64: dts: ti: k3-j784s4-evm: Remove HS400 mode support for eMMC

Vignesh Raghavendra (1):
  arm64: dts: ti: k3-am62a: Enable UHS mode support for SD cards

 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi  |  2 --
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts    | 21 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi   | 26 +++++++++-------------
 arch/arm64/boot/dts/ti/k3-am69-sk.dts      |  1 +
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi |  2 --
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts   |  1 +
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi |  2 --
 7 files changed, 34 insertions(+), 21 deletions(-)


base-commit: 534ad093bb80f19c20b251a89f09ce1a0e3d4f2d
-- 
2.43.2


