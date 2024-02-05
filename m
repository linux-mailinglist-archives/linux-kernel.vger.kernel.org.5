Return-Path: <linux-kernel+bounces-52264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA2F84960E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BED31B21697
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A15718030;
	Mon,  5 Feb 2024 09:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YaF51rik"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB8D125B8;
	Mon,  5 Feb 2024 09:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707124067; cv=none; b=qmI6cqzqmzYJKvPZwa4TgLqCLrRCa6FOx77LJPaZT+sQdxM53ecvcjP2+vIHDsXQ7zGmtkfnJYk5oThR6DdU3SQm3o33Se41kczJDX7Id1TYxw42Endqlh/j20a7bPlYa5AD3wx20DZ99MW+mzf/s7NDKX/FtqiKNbb+uOCwS3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707124067; c=relaxed/simple;
	bh=OYWfKIZZbNVvNdUGeXPzqCrger3e70yeWu9jt5ZwRbY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eVDKAiUqe9e4+v7fWPwjdBgdmbHwOqxdRHXtzSSiKpQ6MAvQ1TkSR5zPO0wv2XB2vHxrrlif05PkAtEVo8SPUFBCwaSswWuLEbFFADYYW97ZfadHm3arKTPGB/gGCz87fmx4zUUGhS+/375g4padh7bWKnkqKagGCgM1+Cg14zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YaF51rik; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41595nLk075683;
	Mon, 5 Feb 2024 03:05:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707123949;
	bh=jEerUnjT73P4OnEdJfNUUf24fkGk3mF2BgO5V6SKjwE=;
	h=From:To:CC:Subject:Date;
	b=YaF51rik1O/Zu93T4Jft/HFeMLWUbnKT5SxFy7LrYzy0rVNdtjKDZDT+v57B9qxVx
	 ILktmALQP0dIOnvJhkPOBGKldGeWp/dF3IuvmYuorzezbRPKYrbmVO1FNcInnUc7IN
	 s5AxT38TqOsxB8mPE6TXIGaGskbJzFQjsFQTjgE4=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41595nNU029214
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 03:05:49 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 03:05:49 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 03:05:49 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41595nVN010124;
	Mon, 5 Feb 2024 03:05:49 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 41595mCt032276;
	Mon, 5 Feb 2024 03:05:49 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero
 Kristo <kristo@kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>,
        Roger
 Quadros <rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>
Subject: [PATCH v4 0/3] Add AM64x ICSSG Ethernet support
Date: Mon, 5 Feb 2024 14:35:43 +0530
Message-ID: <20240205090546.4000446-1-danishanwar@ti.com>
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

Hi All,

This series adds support for ICSSG ethernet on AM64x. 
This series is based on the latest next-20240205 linux-next.

AM64x EVM has three ethernet ports. One is dedicated to CPSW and one is
dedicated to ICSSG1. The remaining port is muxed between CPSW and ICSSG1
ICSSG1 ports. The ICSSG1 node is added in the k3-am642-evm.dts. By default
the muxed port is used by CPSW so 2nd ICSSG1 port is disabled in the
k3-am642-evm.dts. But overlay k3-am642-evm-icssg1-dualemac.dtso can be
applied to use muxed port as ICSSG1.

This is the v4 of the series [v1].

Changes from v3 to v4:
*) Dropped ethernet3 alias from k3-am642-evm.dts as suggested by Roger.
*) Dropped extra blank lines from k3-am642-evm.dts.
*) Updated commit message of patch 3/3
*) Updated licensing header in k3-am642-evm-icssg1-dualemac.dtso.
*) Fixed up alias for ethernet1 to icssg1_emac1 in
   k3-am642-evm-icssg1-dualemac.dtso as suggested by Roger.
*) Renamed 'mdio-mux-1' and 'mdio-mux-2' to 'mdio-mux@1' and 'mdio-mux@0'
   respectively as suggested by Roger.

Changes from v2 to v3:
*) No functional changes.
*) Rebased on latest linux-next (next-20240122) after 6.8-rc1.

Changes from v1 to v2:
*) Fixed aliases section in k3-am642-evm.dts
*) Fixed firmware-names in k3-am642-evm.dts
*) Changed icssg1_phy1 to ethernet-phy@f from ethernet-phy@0 as suggested
   by Andrew L.
*) Changed makefile to handle overlays using CONFIG_OF_ALL_DTBS as
   suggested by Nishant and Andrew Davis.
*) Fixed aliases section in k3-am642-evm-icssg1-dualemac.dtso
*) Fixed pinctrl in k3-am642-evm-icssg1-dualemac.dtso
*) Updated commit message of patch 3/3 of the series to warn about adding
   label name to 'mdio-mux-1' node.

[v1] https://lore.kernel.org/all/20231207081917.340167-1-danishanwar@ti.com/
[v2] https://lore.kernel.org/all/20231212165832.3933335-1-danishanwar@ti.com/
[v3] https://lore.kernel.org/all/20240122113045.1711818-1-danishanwar@ti.com/

Thanks and Regards,
MD Danish Anwar

MD Danish Anwar (2):
  arm64: dts: ti: k3-am642-evm: add ICSSG1 Ethernet support
  arm64: dts: ti: k3-am642-evm: add overlay for icssg1 2nd port

Suman Anna (1):
  arm64: dts: ti: k3-am64-main: Add ICSSG IEP nodes

 arch/arm64/boot/dts/ti/Makefile               |  5 +
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      | 24 +++++
 .../dts/ti/k3-am642-evm-icssg1-dualemac.dtso  | 79 +++++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts       | 99 ++++++++++++++++++-
 4 files changed, 206 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-dualemac.dtso

base-commit: 23e11d0318521e8693459b0e4d23aec614b3b68b
-- 
2.34.1


