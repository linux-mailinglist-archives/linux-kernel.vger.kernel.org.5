Return-Path: <linux-kernel+bounces-54646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E9184B1EB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000A5286C26
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010CD12DD8C;
	Tue,  6 Feb 2024 10:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sPhJpJCh"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10D712D145;
	Tue,  6 Feb 2024 10:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213983; cv=none; b=umszr9qzV3rBV3ECF7r7ajPfAOIiwFhGgkUNnRhXJFNZ4iTi+rlo1kmboOoZqjosR0P7wqCZ92fdfPEQXB/TyxL24aQVwlAM+TEd2zkaZdFd4/DZ4aslx5qpMvm9Td/6efafUe43YLkeW3HZZ6Bbht8n5dBAQmg0WsyBNhgmSfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213983; c=relaxed/simple;
	bh=R/VXMJ4UGVEmzXscYw1FRdvzkcgzuWvny87easFjD00=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hhMOfkyFwN8r2RrKDRUwtt5RarQoBvLrpRuG4/wT5KYSr8elW9A6QgrW/gGv3RjBhEnfqThKDHKxwMEeB5xT1UYPKPWhCN2GtKMB3zXtHRtxSMRTpkGw6nVR+v21WAh+czBZGgAc+A/h3DZYvDzg/8bFt1UBw4X05PsLGPcRDX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sPhJpJCh; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 416A6DDs106834;
	Tue, 6 Feb 2024 04:06:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707213973;
	bh=3z/xz3eWl30A4xyT/WrxKYaFQKmxTgbKssfNK4YQz5A=;
	h=From:To:CC:Subject:Date;
	b=sPhJpJChou64LmVuyUTPUD/OPneyp6D0QxTeS6wQObohNBXSNEFAj9SsbOrCibQT3
	 ImDwD7gdgFQGo/9AVFm3vSJOcwA4mKd+UNIJNd9DVGOwwxkQh4jV5sDZRy4fYMm4B7
	 8zT7NDjbqLYY8BcdCCA3eCfz2ABijlC9kPpNwMxM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 416A6Dud014037
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 04:06:13 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 04:06:13 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 04:06:12 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 416A68qs054893;
	Tue, 6 Feb 2024 04:06:09 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kristo@kernel.org>,
        <robh+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <vaishnav.a@ti.com>,
        <j-choudhary@ti.com>
Subject: [PATCH v2 0/3] arm64: dts: ti: Introduce J722S SoC and EVM
Date: Tue, 6 Feb 2024 15:36:05 +0530
Message-ID: <20240206100608.127702-1-vaishnav.a@ti.com>
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

This series adds basic support for J722S family of SoCs. Also add
J722S EVM support with basic peripheral like MMC and UART.

TRM: https://www.ti.com/lit/zip/sprujb3
EVM Schematics: https://www.ti.com/lit/zip/sprr495

Bootlog (6.8.0-rc3-next-20240206):
https://gist.github.com/vaishnavachath/23d859925277df9ccd628190e7c23371

Changelog:
V1->V2:
  * Address feedback from Nishanth to reuse from AM62P5 dtsi.
  * Remove bootph-all from root nodes.
  * Change License to GPL-2.0-only OR MIT as followed for other
    K3 files.

Vaishnav Achath (3):
  dt-bindings: arm: ti: Add bindings for J722S SoCs
  arm64: dts: ti: Introduce J722S family of SoCs
  arm64: dts: ti: Add support for TI J722S Evaluation Module

 .../devicetree/bindings/arm/ti/k3.yaml        |   6 +
 arch/arm64/boot/dts/ti/Makefile               |   3 +
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts       | 251 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j722s.dtsi          |  89 +++++++
 arch/arm64/boot/dts/ti/k3-pinctrl.h           |   3 +
 5 files changed, 352 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j722s-evm.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-j722s.dtsi

-- 
2.34.1


