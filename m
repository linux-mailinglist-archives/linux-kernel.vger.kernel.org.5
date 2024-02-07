Return-Path: <linux-kernel+bounces-57278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FBA84D616
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA7E288F5D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356B3535C8;
	Wed,  7 Feb 2024 22:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DLyh20/s"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A1E1EB42;
	Wed,  7 Feb 2024 22:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707346538; cv=none; b=XN3BnkUJbjWOyt02HRb5KoIgVES4lMwiQyu0Pf+6KD1SVGb7hGgMw1plYabNWYbyMdwGhVmsVEh8ZouHRMHV71h+MRCBrGOgFnM32feqwqoE3vr+aJCotKhRNABJjTQeG6HWMiFR/agcrpd7jFZMyigAWE4FoakV/KmiBtFs7+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707346538; c=relaxed/simple;
	bh=xX7JSbunBOvPlkFRAzytZEE8CRX45lbTaFkR1OIGUQQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VvxrXdb9DPyMASH37MqIpcouL76uOj1+6a6fb8q3iRV92Chphf+KEzhSUFHSQ1pJeKSej9aL5uIb66IWdJ5k5ACTG5jISN4w3XumfBNHfMm1r/3snXOwOSeNr6+bkKFLorVEgu4U7jKQPKuVS0lmYsnA6KdBmXIAGIjLaqWf0+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DLyh20/s; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 417MtR9h014810;
	Wed, 7 Feb 2024 16:55:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707346527;
	bh=zOoJZOLG26Ul8soZA3DhrVj70l4+Sl0iEM4P7gItmx8=;
	h=From:To:CC:Subject:Date;
	b=DLyh20/sL1Oy7AzPwimy0MAAp4SL98c1hF8vLtGNYdUORwO91VlsTegIdr62ZDZkP
	 qUzOW9yGjRAJuf4Tsc30WFO8/qTQ4yuJoKbOEZxPb+5n02aLSC9mZhDy2JRmIuW3V4
	 ahXmUkZ4CNgmcLjM7G3XQuV9O8qqPWlfOu+Nv3Ss=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 417MtRuE082333
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Feb 2024 16:55:27 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 16:55:27 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Feb 2024 16:55:27 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 417MtQmT014027;
	Wed, 7 Feb 2024 16:55:26 -0600
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/9] Fix MMC properties on Sitara devices
Date: Wed, 7 Feb 2024 16:55:17 -0600
Message-ID: <20240207225526.3953230-1-jm@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This patch series aims to add or fix MMC properties:
OTAPDLY/ITAPDLY.

The DLL properties ti,trm-icp and ti,driver-strength-ohm
should also be updated since only AM64x and AM62p devices
have a DLL to enable, so remove these properties when not
applicable.

Also add support for eMMC on AM62ax platform.

This series was tested on:
- AM62a SK
- AM62x SK
- AM62p SK
- AM64x GP EVM
- AM64x SK EVM

Judith Mendez (7):
  arm64: dts: ti: k3-am62a-main: Add sdhci2 instance
  arm64: dts: ti: k3-am64-main: Fix ITAP/OTAP values for MMC
  arm64: dts: ti: k3-am62p: Add ITAP/OTAP values for MMC
  arm64: dts: ti: k3-am6*: Remove DLL properties for soft PHYs
  arm64: dts: ti: k3-am6*: Fix ti,clkbuf-sel property in MMC nodes
  arm64: dts: ti: k3-am6*: Fix bus-width property in MMC nodes
  arm64: dts: ti: k3-am6*: Fix bootph-all property in MMC node

Nitin Yadav (2):
  arm64: dts: ti: k3-am62a-main: Add sdhci0 instance
  arm64: dts: ti: k3-am62a7-sk: Enable eMMC support

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi      | 12 +++--
 .../arm64/boot/dts/ti/k3-am625-beagleplay.dts |  4 --
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi     | 45 ++++++++++++++++++-
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts       | 27 ++++++++++-
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi     | 44 ++++++++++++++++--
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts       |  5 +--
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi |  2 -
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      | 15 +++++--
 arch/arm64/boot/dts/ti/k3-am642-evm.dts       |  4 +-
 arch/arm64/boot/dts/ti/k3-am642-sk.dts        |  2 -
 10 files changed, 130 insertions(+), 30 deletions(-)


base-commit: 1e6bbc5185bcd113c8d2f7aa0a02f588a6bdbe5d
-- 
2.43.0


